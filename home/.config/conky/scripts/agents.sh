#!/usr/bin/env bash
# Coding agent sessions as conky markup: the project each one runs in, its CPU, memory and age.

agents='claude|codex|aider|gemini|opencode|goose|copilot'
pids=$(pgrep -x "$agents")
[[ -z $pids ]] && { echo '${color1}no agent running'; exit 0; }
for pid in $pids; do
	read -r comm etime pcpu rss < <(ps -o comm=,etime=,pcpu=,rss= -p "$pid") || continue
	project=$(basename "$(readlink "/proc/$pid/cwd")")
	printf '${color2}󰚩 ${color}%s ${color1}%s${goto 270}${color}%s%%  %dM${alignr}${color1}%s\n' \
		"$comm" "$project" "$pcpu" $((rss / 1024)) "$etime"
done | head -8
