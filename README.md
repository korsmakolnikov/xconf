# xconf

Dotfiles and machine setup for my Arch (Garuda i3) machines: a laptop
(`blacksheep-tmp20`, Lenovo ThinkBook 16p Gen 2) and a desktop. The repo is
how the two stay in sync: change on one, push, pull on the other.

## Layout

```
xconf/
├── Makefile          # the only entry point: make help
├── bin/
│   ├── dotlink       # link / check the symlinks from home/ into $HOME
│   └── i3check       # every exec in the i3 config must resolve to a command
├── packages/         # pacman lists, one package per line, # comments
│   ├── base.txt      #   command line tools          ┐
│   ├── dev.txt       #   language servers, dev tools  │ make packages
│   ├── fonts.txt     #                                │
│   ├── desktop.txt   #   what home/ configs run       ┘
│   ├── docker.txt    #   make docker (part of bootstrap)
│   └── apps.txt      #   optional apps: make apps
├── home/             # mirror of $HOME: home/X is linked to ~/X
│   ├── .bash_*  .bashlib  .tool-versions  .wezterm.lua
│   ├── .local/bin/   # rgs, i3lock-screen
│   └── .config/
│       ├── i3/config, i3/scripts/fnkey.sh
│       ├── eww/      # the top bar
│       └── picom.conf
├── swapcaps/             (submodule)
└── my_keyboard_layout/   (submodule)
```

Adding a dotfile: move it to the same path under `home/`, run `make link`.
No list to maintain: the tree is the list.

## Make targets

| Target | What it does |
|---|---|
| `make bootstrap` | fresh machine: `packages`, `link`, `docker`, `asdf`, `git-identity`, `ssh-key`, `browser` (interactive) |
| `make packages` | `pacman -S --needed` the base, dev, fonts and desktop lists |
| `make apps` | the optional apps list |
| `make link` | symlink `home/` into `$HOME`; a real file that differs is moved to `<file>.bak-<date>`, one identical to the repo copy is just replaced. Safe to rerun |
| `make check` | exit 1 on a file not linked, a dangling link into the repo, or an i3 `exec` whose command is missing |
| `make reload` | `check`, reload i3 (which restarts eww), fail if picom or eww are down or eww logged errors |
| `make docker` | docker + docker-compose, `$USER` in the docker group, service enabled (log out to apply the group) |
| `make asdf` | asdf plugins and runtimes pinned in `home/.tool-versions` (golang, nodejs LTS); Python is not on asdf, use `uv` |

`sudo` needs a real terminal: run `make packages`, `make apps`, `make docker`
and `make bootstrap` from a terminal, not from an agent's shell.

Fresh machine (the repo cannot clone itself):

```
git clone --recurse-submodules git@github.com:korsmakolnikov/xconf.git ~/xconf
cd ~/xconf && make bootstrap
```

Not in the lists on purpose, install by hand when needed: discord,
slack-desktop, steam, gimp, soundconverter.

## Desktop look: the Antracite theme

- **Palette** (RAL 7016 anthracite greys, vaporwave fuchsia accent), defined
  at the top of `home/.config/eww/eww.scss`:
  `#1b1f21 #23292b #293133 #383e42` greys, `#d6dadb` / `#8a9498` text,
  `#e05bbf` fuchsia, `#8ea5b2` steel, `#9bb07f` green, `#d8b568` yellow,
  `#e0566e` red.
- **wezterm stays out of the theme**: it keeps its own colors on purpose.
- **eww** is the top bar (`home/.config/eww/`): i3 workspaces, binding mode,
  clock, IPv4, wifi, ethernet (only when up), battery, disk, load, memory,
  system tray. `scripts/i3-listen.py` streams i3 events, `scripts/status.py`
  probes the system and prints JSON. The tray only shows StatusNotifierItem
  apps (start nm-applet with `--indicator`).
- **i3bar** is still at the bottom with i3status, as a fallback until eww is
  proven on both machines.
- **picom** rounds window corners with the same 14px radius as the eww pills.
  eww needs picom for transparency: if picom dies, restart picom *and then*
  eww, or the bar stays opaque black.
- **gaps**: 10px everywhere (`gaps inner 10`, `gaps outer 0`, `smart_gaps off`).

## TODO

### Next session on the desktop (read this first)

The restructuring into `home/` was done on the laptop. The desktop has never
pulled it, and its own last changes were never merged into the shared
config.

1. **Before pulling**: `git status`; commit or stash anything local.
2. **Right after `git pull --recurse-submodules`, run `make link` before any
   i3 reload or logout.** On the desktop `~/.config/i3/config` and
   `~/.config/picom.conf` are probably symlinks to `xconf/i3.conf` and
   `xconf/picom.conf`, which no longer exist: i3 would start without a config.
   `make link` backs up real files that differ as `.bak-<date>`.
3. Then `make check`, `make packages` (eww comes from chaotic-aur: check it is
   enabled), `make reload`.
4. **Recover the desktop-only settings** from commits `7e3652f` and `3889088`
   (`git show 3889088 -- i3.conf`). They were left out of the shared i3 config
   because they conflict with the laptop:
   - `font pango: source code pro 10` (laptop: 14)
   - wallpaper with `xwallpaper --zoom` on a random file of `~/wallpapers`
     (laptop: `feh --bg-fill --randomize`)
   - lock with `betterlockscreen -l dimblur` via xss-lock and `$super+l`
     (laptop: `i3lock-color` through `~/.local/bin/i3lock-screen`)
   - rofi with `-theme ~/.local/share/rofi/themes/launchpad.rasi`
   - i3status reads `~/.config/i3status/config`
   - picom started from `~/.config/picom/picom.conf` (repo links `~/.config/picom.conf`)
   - the `xrandr --output HDMI-1-0 … --left-of eDP-1` line, commented
5. **Per-machine config**: end the shared i3 config with
   `include ~/.config/i3/local.conf`, keep one file per machine in the repo
   (e.g. `hosts/<hostname>/`) and have `make link` link the one matching
   `hostname`. Laptop-only today: `fnkey.sh` and the ThinkBook function keys,
   brightness, touchpad toggle. Desktop-only: the list in step 4, monitors.
6. **Make eww portable**:
   - battery: on a machine without one `status.py battery` returns no
     `capacity` and eww logs `Failed to turn null into f64`; hide the pill
     when `present` is false and return safe defaults;
   - wifi: hide the pill when there is no wireless device (today it shows a
     red "down" on a wired machine);
   - monitors: the window is pinned to `:monitor 0`; open one bar per monitor.
7. `make check` should also fail on eww errors on the current machine, so one
   command proves the setup works there.

### Rice, after that

- rofi: themed in Antracite, anchored under the bar (top left) instead of centered.
- dunst: rounded corners, Antracite palette, placed under the bar.
- i3 window border: the focused border is still Garuda's salmon `#bf616a`,
  clipped by the rounded corners; options: 2px fuchsia or no border plus
  picom shadow.
- wezterm tab bar font size (`window_frame.font_size`) to match the eww bar;
  size only, colors stay out of the theme.
- picom animations (`animations` block, picom ≥ 12) and blur behind
  translucent windows; `inactive-opacity = 0.3` is very aggressive.
- remove i3bar and `i3status.conf` once eww is stable on both machines.

### Housekeeping

- `my_keyboard_layout` submodule has an uncommitted `dosbox/` directory:
  commit it in the submodule's own repo.
- `bin/i3check` checks the command of each `exec`, not its arguments: an exec
  of an existing binary on a missing file (as the old `java -jar xdman.jar`)
  passes.
