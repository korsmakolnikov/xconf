.PHONY: help bootstrap packages apps link check reload docker asdf git-identity ssh-key browser

# package lists installed by `make packages`; apps.txt is opt-in through `make apps`
PACKAGE_LISTS := base dev fonts desktop
pacman_install = grep -hv '^\#' $(1) | sudo pacman -S --needed --noconfirm -

help: ## list the targets
	@grep -E '^[a-z-]+:.*## ' $(MAKEFILE_LIST) | awk -F':.*## ' '{printf "  %-13s %s\n", $$1, $$2}'

bootstrap: packages link docker asdf git-identity ssh-key browser ## set up a fresh machine (interactive)
	@echo "bootstrap done: log out and back in for the docker group to apply"

packages: ## install the base, dev, fonts and desktop package lists
	@$(call pacman_install,$(PACKAGE_LISTS:%=packages/%.txt))

apps: ## install the optional desktop applications
	@$(call pacman_install,packages/apps.txt)

link: ## symlink every file under home/ into $HOME
	@bin/dotlink link

check: ## verify the links and that every i3 exec resolves (exit 1 on any problem)
	@bin/dotlink check
	@bin/i3check

# i3 runs exec_always on start and restart, not on reload: restart eww explicitly
reload: check ## reload i3, restart eww, reload dunst; fail if picom or eww are down or eww logged errors
	@i3-msg -q reload
	@$(HOME)/.config/eww/launch.sh >/dev/null 2>&1
	@dunstctl reload
	@sleep 3
	@pgrep -x picom >/dev/null || { echo "picom is not running (eww loses transparency without it)"; exit 1; }
	@pgrep -x eww >/dev/null || { echo "eww is not running"; exit 1; }
	@! grep -i error $(HOME)/.cache/eww/*.log

docker: ## install docker, add $USER to the docker group, enable the service
	@$(call pacman_install,packages/docker.txt)
	@sudo groupadd -f docker
	@id -nG | grep -qw docker || sudo usermod -aG docker $(USER)
	@sudo systemctl enable --now docker.service

asdf: link ## install the asdf plugins and runtimes pinned in home/.tool-versions
	@cut -d' ' -f1 home/.tool-versions | while read -r plugin; do \
		asdf plugin list | grep -qx "$$plugin" || asdf plugin add "$$plugin"; \
	done
	@cd $(HOME) && asdf install

git-identity: ## set git name, email and editor if they are not set yet
	@git config --global user.name >/dev/null || git config --global user.name "Federico Caprari"
	@git config --global user.email >/dev/null || git config --global user.email "korsmakolnikov@gmail.com"
	@git config --global core.editor >/dev/null || git config --global core.editor nvim

ssh-key: ## create an ed25519 key if missing and print it for GitHub
	@test -f $(HOME)/.ssh/id_ed25519 || ssh-keygen -t ed25519 -C "korsmakolnikov@gmail.com"
	@echo "add this key to GitHub (https://github.com/settings/keys):"
	@cat $(HOME)/.ssh/id_ed25519.pub

browser: ## make firefox the default browser
	@xdg-mime default firefox.desktop x-scheme-handler/https x-scheme-handler/http
