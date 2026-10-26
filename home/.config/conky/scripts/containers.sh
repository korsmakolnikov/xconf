#!/usr/bin/env bash
# Running docker containers as conky markup: green up, yellow restarting or paused, red otherwise.

out=$(docker ps --format '{{.Names}}\t{{.State}}\t{{.Status}}' 2>/dev/null) || { echo '${color1}docker not running'; exit 0; }
[[ -z $out ]] && { echo '${color1}no container running'; exit 0; }
while IFS=$'\t' read -r name state status; do
	case $state in
		running) c=color4 ;;
		restarting|paused) c=color5 ;;
		*) c=color6 ;;
	esac
	printf '${%s}● ${color}%s${alignr}${color1}%s\n' "$c" "$name" "$status"
done <<<"$out" | head -8
