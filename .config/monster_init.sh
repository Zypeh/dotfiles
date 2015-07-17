#!/usr/bin/env bash

fn="SourceCodePro 9:Bold"

nor_fg="#FFFFFF"
nor_bg="#000000"
sel_fg="#FFFFFF"
sel_bg="#612737"
urg_fg="#FFFFFF"
urg_bg="#BE0E50"
mod_fg="#EEEEEE"
mod_bg="#7182A8"

# Create a fifo to send output
: "${wm:="monsterwm"}"
: "${ff:="/tmp/monsterwm.fifo"}"
[[ -p $ff ]] || mkfifo -m 600 "$ff"

while read -t 2 -r wmout || true; do
	# Filter output to only what we want to match and parse
	if [[ $wmout =~ ^(([[:digit:]]+:)+[[:digit:]]+ ?)+.*$ ]]; then 
		read -ra desktops <<< "$wmout" && unset r
			for desktop in "${desktops[@]}"; do

			# d - the desktop number/id
			# w - the desktop's client count
			# m - the desktop's tiling layout mode/id
			# c - the desktop is the current focused (1) or not (0)
			# u - whether any client in that desktop has recieved an urgent hint

			IFS=':' read -r d w m c u <<< "$desktop"

			ic=" "
			((w)) && ic=" *"
			# Name each desktop
			case $d in
				0) d="work " ;;
				1) d="web" ;;
				2) d="tile " ;;
				3) d="hack" ;;
			esac

			# Display the current layout
			((c)) && fg="$sel_fg" bg="$sel_bg" && case $m in
				0) i="  Classic Tiling Mode" ;;
				1) i="  Monocle Mode" ;;
				2) i="  Bloat Mode" ;;
				3) i="  Grid Mode" ;;
			esac || fg="$nor_fg" bg="$nor_bg"

			# If desktop has an urgent hint
			((u)) && fg="$urg_fg" bg="$urg_bg"
		
			# Print desktop name
			r+="^bg($nor_bg)^bg($bg)^fg($fg)$ic$d^fg($nor_fg)^bg($nor_bg)"
		done
	fi
	printf "%s%s\n" "$r" "$i"
done < "$ff" | dzen2 -bg "$nor_bg" -h 18 -w 400 -ta l -e "button2=stick" -fn "$fn" &

while :; do "$wm" || break; done | tee -a "$ff"

