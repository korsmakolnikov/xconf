#!/usr/bin/env python3
"""Stream i3 state to eww: one JSON line per change.

Usage: i3-listen.py workspaces | mode
"""
import json
import subprocess
import sys


def workspaces():
    raw = subprocess.run(["i3-msg", "-t", "get_workspaces"],
                         capture_output=True, text=True).stdout
    keys = ("name", "num", "focused", "visible", "urgent")
    return [{k: ws[k] for k in keys} for ws in json.loads(raw)]


def emit(value):
    # eww parses JSON for structured values; a bare string goes out as plain text
    print(value if isinstance(value, str) else json.dumps(value), flush=True)


def main(kind):
    if kind == "workspaces":
        emit(workspaces())
        event, render = "workspace", lambda _: workspaces()
    elif kind == "mode":
        emit("")
        event = "mode"
        render = lambda ev: "" if ev["change"] == "default" else ev["change"]
    else:
        sys.exit(f"unknown kind: {kind}")

    sub = subprocess.Popen(["i3-msg", "-t", "subscribe", "-m", json.dumps([event])],
                           stdout=subprocess.PIPE, text=True)
    for line in sub.stdout:
        emit(render(json.loads(line)))


if __name__ == "__main__":
    main(sys.argv[1])
