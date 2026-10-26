# xconf

Dotfiles and machine setup for my Arch (Garuda i3) machines: a laptop
(`blacksheep-tmp20`, Lenovo ThinkBook 16p Gen 2) and a desktop
(`blacksheep-i3`, RTX 3060, one 27" 2560x1440 monitor, HHKB Professional).
The repo is how the two stay in sync: change on one, push, pull on the other.

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
│   ├── c-cpp.txt     #   gcc, cmake, ninja, clang…   │
│   ├── fonts.txt     #                                │
│   ├── desktop.txt   #   what home/ configs run       ┘
│   ├── docker.txt    #   make docker (part of bootstrap)
│   └── apps.txt      #   optional apps: make apps
├── home/             # mirror of $HOME: home/X is linked to ~/X
│   ├── .bash_*  .bashlib  .tool-versions  .wezterm.lua
│   ├── .local/bin/   # rgs, i3lock-screen, swapcaps (link into the submodule)
│   └── .config/
│       ├── i3/config, i3/scripts/fnkey.sh
│       ├── eww/      # the bar
│       ├── rofi/     # launcher, Antracite theme
│       ├── dunst/    # notifications
│       └── picom.conf
├── hosts/            # per machine, linked only on the machine with that hostname
│   ├── blacksheep-tmp20/.config/i3/local.conf   # laptop: swapcaps at startup
│   └── blacksheep-i3/.config/i3/local.conf      # desktop: font 10
├── swapcaps/             (submodule)
└── my_keyboard_layout/   (submodule)
```

Adding a dotfile: move it to the same path under `home/`, run `make link`.
No list to maintain: the tree is the list.

Per-machine files go under `hosts/<hostname>/` with the same layout as `home/`;
`make link` links `home/` and then the folder matching `hostname`. The same
path cannot be in both (`make check` fails). The shared i3 config ends with
`include ~/.config/i3/local.conf`, so a host's `local.conf` overrides it; a
machine without one just uses the shared settings.

## Make targets

| Target | What it does |
|---|---|
| `make bootstrap` | fresh machine: `packages`, `link`, `docker`, `asdf`, `git-identity`, `ssh-key`, `browser` (interactive) |
| `make packages` | `pacman -Syu --needed` (full upgrade: no partial upgrades on Arch) the base, dev, c-cpp, fonts and desktop lists |
| `make apps` | the optional apps list |
| `make link` | symlink `home/` into `$HOME`; a real file that differs is moved to `<file>.bak-<date>`, one identical to the repo copy is just replaced; dangling links into the repo are removed. Safe to rerun |
| `make check` | exit 1 on a file not linked, a dangling link into the repo, a path in both `home/` and `hosts/`, an i3 config syntax error (`i3 -C`), or an i3 `exec` whose command is missing |
| `make reload` | `check`, reload i3, restart eww (`exec_always` does not run on an i3 reload), reload dunst; fail if picom or eww are down or eww logged errors |
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
- **eww** is the bar (`home/.config/eww/`): i3 workspaces, binding mode,
  clock, IPv4, wifi, ethernet (only when up), battery (only when there is
  one), disk, load, memory, system tray. `scripts/i3-listen.py` streams i3 events, `scripts/status.py`
  probes the system and prints JSON. The tray only shows StatusNotifierItem
  apps (start nm-applet with `--indicator`).
- **eww sits at the bottom** (`:anchor "bottom center"`, struts on the
  bottom side).
- **rofi** (`home/.config/rofi/`): Antracite theme, anchored top left 10px
  from the edges like the gaps, instead of centered.
- **dunst** (`home/.config/dunst/dunstrc`): notifications top right, 10px
  from the edges (`offset = (10, 10)`), same palette and radius; critical ones have a
  red frame and stay until closed. Left click closes, middle runs the action,
  right closes all. Reload with `dunstctl reload`.
- **i3bar and i3status are gone**: eww is the only bar. If it moves back to
  the top, rofi and dunst need `64px` offsets (bar height) to sit under it.
- **picom** rounds window corners with the same 14px radius as the eww pills.
  eww needs picom for transparency: if picom dies, restart picom *and then*
  eww, or the bar stays opaque black.
  picom reloads its config on every change and **exits if the file is
  invalid even for a moment**: a `git mv` of the linked file or a merge that
  writes conflict markers into it both killed picom. `make reload` reports it.
- **gaps**: 10px everywhere (`gaps inner 10`, `gaps outer 0`, `smart_gaps off`).

## TODO

### Desktop and laptop

The desktop is on the `home/` layout and has its `hosts/blacksheep-i3/`.
Its old settings (commits `7e3652f`, `3889088`) were reviewed: the font is in
`local.conf`, the picom fix is in the shared config, everything else
(xwallpaper, betterlockscreen, i3status, the launchpad rofi theme, conky,
the HDMI xrandr line, Garuda tray tools) was dropped for the shared setup.

- **On the laptop, after pulling**: `make link` (it links
  `hosts/blacksheep-tmp20/`, which now starts swapcaps), `make check`,
  `make reload`. swapcaps is linked from the submodule into `~/.local/bin`:
  the old `/usr/local/bin/swapcaps` from `swapcaps/install.sh` can go.
- **eww, still to do**:
  - wifi: hide the pill when there is no wireless device (today it shows a
    red "down" on a wired machine);
  - monitors: the window is pinned to `:monitor 0`; open one bar per monitor.
- `make check` should also fail on eww errors on the current machine, so one
  command proves the setup works there.

### Rice, after that

- i3 window border: the focused border is still Garuda's salmon `#bf616a`,
  clipped by the rounded corners; options: 2px fuchsia or no border plus
  picom shadow.
- wezterm tab bar font size (`window_frame.font_size`) to match the eww bar;
  size only, colors stay out of the theme.
- picom animations (`animations` block, picom ≥ 12) and blur behind
  translucent windows; `inactive-opacity = 0.3` is very aggressive.
- dunst keyboard shortcuts: the old `[shortcuts]` section is gone from
  dunst; if wanted, bind `dunstctl close`, `close-all` and `history-pop` in i3.

### Housekeeping

- `my_keyboard_layout` submodule has an uncommitted `dosbox/` directory:
  commit it in the submodule's own repo.
- `bin/i3check` checks the command of each `exec`, not its arguments: an exec
  of an existing binary on a missing file (as the old `java -jar xdman.jar`)
  passes.
