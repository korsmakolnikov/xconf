#!/usr/bin/env bash
# NVIDIA data conky has no variable for, printed as conky markup (execpi).
# Usage: gpu.sh power | procs | ollama

export LC_NUMERIC=C

case "$1" in
	power)
		IFS=', ' read -r draw limit < <(nvidia-smi --query-gpu=power.draw,power.limit --format=csv,noheader,nounits)
		printf '${color1}power ${color}%.0f / %.0f W\n' "$draw" "$limit"
		;;
	procs) # compute processes and the VRAM they hold: local models, training, CUDA jobs
		out=$(nvidia-smi --query-compute-apps=pid,process_name,used_memory --format=csv,noheader,nounits)
		if [[ -z $out ]]; then
			echo '${color1}no compute process on the GPU'
		else
			while IFS=', ' read -r pid name mem; do
				printf '${color}%s ${color1}%s${alignr}${color}%s MiB\n' "${name##*/}" "$pid" "$mem"
			done <<<"$out" | head -5
		fi
		;;
	ollama) # models loaded in ollama, with the CPU/GPU split and when they unload
		command -v ollama >/dev/null || exit 0
		out=$(ollama ps 2>/dev/null) || { echo '${color1}ollama not running'; exit 0; }
		models=$(tail -n +2 <<<"$out")
		if [[ -z $models ]]; then
			echo '${color1}ollama: no model loaded'
		else
			# NAME ID SIZE PROCESSOR CONTEXT RUNNER UNTIL, columns separated by 2+ spaces
			sed -E 's/ {2,}/\t/g' <<<"$models" | while IFS=$'\t' read -r name _ size proc _ _ until; do
				printf '${color2}󰧑 ${color}%s${alignr}%s ${color1}%s\n' "$name" "$size" "$proc"
				printf '${color1}  unloads %s\n' "$until"
			done
		fi
		;;
esac
