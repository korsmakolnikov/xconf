#!/usr/bin/env python3
"""Status probes for the eww bar, the same data i3status showed.

Usage: status.py wifi | ethernet | battery | ipv4   (prints one JSON object)
"""
import json
import os
import subprocess
import sys
from pathlib import Path

NET = Path("/sys/class/net")


def run(*cmd):
    return subprocess.run(cmd, capture_output=True, text=True).stdout.strip()


def ipv4(iface):
    out = run("ip", "-4", "-o", "addr", "show", iface).split()
    return out[3].split("/")[0] if len(out) > 3 else ""


def wifi():
    lines = Path("/proc/net/wireless").read_text().splitlines()[2:]
    if not lines:
        return {"up": False}
    iface, _, link, *_ = lines[0].split()
    iface = iface.rstrip(":")
    ssid = run("nmcli", "-t", "-f", "GENERAL.CONNECTION", "dev", "show", iface)
    return {
        "up": True,
        "ssid": ssid.split(":", 1)[-1],
        "quality": min(100, int(float(link) * 100 / 70)),
        "ip": ipv4(iface),
    }


def ethernet():
    for dev in sorted(NET.iterdir()):
        is_physical = (dev / "device").exists() and not (dev / "wireless").exists()
        if is_physical and (dev / "operstate").read_text().strip() == "up":
            speed = (dev / "speed").read_text().strip()
            return {"up": True, "ip": ipv4(dev.name), "speed": f"{speed} Mb/s"}
    return {"up": False}


def battery():
    bats = sorted(Path("/sys/class/power_supply").glob("BAT*"))
    if not bats:
        return {"present": False}
    bat = bats[0]
    read = lambda f: (bat / f).read_text().strip() if (bat / f).exists() else ""
    status = read("status")
    now = int(read("energy_now") or read("charge_now") or 0)
    full = int(read("energy_full") or read("charge_full") or 1)
    rate = int(read("power_now") or read("current_now") or 0)
    remaining = ""
    if rate > 0 and status in ("Discharging", "Charging"):
        hours = (now if status == "Discharging" else full - now) / rate
        remaining = f"{int(hours)}:{int(hours * 60) % 60:02d}"
    return {
        "present": True,
        "status": status,
        "capacity": int(read("capacity") or now * 100 // full),
        "remaining": remaining,
    }


def primary_ipv4():
    # source address of the default route: the one the machine is reachable at
    out = run("ip", "-4", "route", "get", "1.1.1.1").split()
    return {"addr": out[out.index("src") + 1] if "src" in out else ""}


if __name__ == "__main__":
    probes = {"wifi": wifi, "ethernet": ethernet, "battery": battery, "ipv4": primary_ipv4}
    print(json.dumps(probes[sys.argv[1]]()))
