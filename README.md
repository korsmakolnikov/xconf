# xconf

Dotfiles and setup for my Arch (Garuda i3) machines.

Everything under `home/` sits at the path it has in `$HOME`; `make link`
symlinks it there, `make check` verifies the links and that every program
the i3 config starts is installed.

```
make help        # list the targets
make bootstrap   # fresh machine: packages, links, docker, asdf runtimes, git identity, ssh key
make packages    # package lists in packages/ (apps.txt is opt-in: make apps)
make link        # symlink home/ into $HOME (real files that differ are backed up)
make check       # exit 1 on a missing or dangling link, or an i3 exec that does not resolve
make reload      # check, reload i3 and eww, report eww errors
```

On a fresh machine, clone first (the repo cannot clone itself):

```
git clone --recurse-submodules git@github.com:korsmakolnikov/xconf.git && cd xconf && make bootstrap
```
