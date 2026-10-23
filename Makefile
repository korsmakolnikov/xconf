.PHONY: help link check reload

help: ## list the targets
	@grep -E '^[a-z-]+:.*## ' $(MAKEFILE_LIST) | awk -F':.*## ' '{printf "  %-8s %s\n", $$1, $$2}'

link: ## symlink every file under home/ into $HOME
	@bin/dotlink link

check: ## verify the links (exit 1 on anything missing or dangling)
	@bin/dotlink check

reload: check ## reload i3 (which restarts eww) and report eww errors
	@i3-msg -q reload
	@sleep 3
	@pgrep -x picom >/dev/null || { echo "picom is not running (eww loses transparency without it)"; exit 1; }
	@pgrep -x eww >/dev/null || { echo "eww is not running"; exit 1; }
	@! grep -i error $(HOME)/.cache/eww/*.log
