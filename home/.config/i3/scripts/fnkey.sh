#!/usr/bin/env bash
# Tasti funzione (ThinkBook 16p Gen 2, HHKB del desktop): esegue l'azione e mostra una notifica dunst.
# Uso: fnkey.sh vol-up|vol-down|mute|mic-mute|bright-up|bright-down|touchpad-dwt|eject

STEP=5
BL_DEV=amdgpu_bl2

notify() { # $1=tag  $2=testo  $3=valore barra (opzionale)
    notify-send -t 1200 -h "string:x-dunst-stack-tag:$1" ${3:+-h "int:value:$3"} "$2"
}

vol_notify() {
    local out pct
    out=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
    pct=$(awk '{printf "%d", $2*100}' <<<"$out")
    if [[ $out == *MUTED* ]]; then notify volume "Volume: muto" "$pct"; else notify volume "Volume: ${pct}%" "$pct"; fi
}

# touchpad: disabilita-durante-la-scrittura (libinput DWT), da spegnere per giocare
touchpad_dwt_toggle() {
    local id prop="libinput Disable While Typing Enabled" cur
    id=$(xinput list --id-only "$(xinput list --name-only | grep -i touchpad | head -1)") || return
    cur=$(xinput list-props "$id" | awk -F: -v p="$prop (" 'index($0, p) {gsub(/[[:space:]]/, "", $2); print $2}')
    if [[ $cur == 1 ]]; then
        xinput set-prop "$id" "$prop" 0; notify touchpad "Touchpad: sempre attivo (gioco)"
    else
        xinput set-prop "$id" "$prop" 1; notify touchpad "Touchpad: disattivo mentre scrivi"
    fi
}

bright_notify() {
    local pct
    pct=$(brightnessctl -d "$BL_DEV" -m | cut -d, -f4 | tr -d %)
    notify brightness "Luminosità: ${pct}%" "$pct"
}

# eject: smonta e spegne ogni disco USB o hotplug (le chiavette), mai i dischi interni
eject_usb() {
    local disk part ok=() busy=()
    while read -r disk; do
        for part in $(/usr/bin/lsblk -lnpo NAME "$disk"); do
            findmnt -n -S "$part" >/dev/null || continue
            udisksctl unmount -b "$part" >/dev/null 2>&1 || { busy+=("$part"); continue 2; }
        done
        udisksctl power-off -b "$disk" >/dev/null 2>&1 && ok+=("${disk#/dev/}") || busy+=("$disk")
    done < <(/usr/bin/lsblk -dnpo NAME,TRAN,HOTPLUG,TYPE | awk '$NF == "disk" && ($2 == "usb" || $3 == 1) {print $1}')
    if ((${#busy[@]})); then notify eject "Occupato, non espulso: ${busy[*]}"
    elif ((${#ok[@]})); then notify eject "Espulso: ${ok[*]}"
    else notify eject "Nessuna chiavetta da espellere"
    fi
}

case "$1" in
    vol-up)      wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ "${STEP}%+"; vol_notify ;;
    vol-down)    wpctl set-volume @DEFAULT_AUDIO_SINK@ "${STEP}%-"; vol_notify ;;
    mute)        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle; vol_notify ;;
    mic-mute)    wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
                 if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q MUTED; then notify mic "Microfono: muto"; else notify mic "Microfono: attivo"; fi ;;
    bright-up)   brightnessctl -q -d "$BL_DEV" set "${STEP}%+"; bright_notify ;;
    bright-down) brightnessctl -q -d "$BL_DEV" -n1 set "${STEP}%-"; bright_notify ;;
    touchpad-dwt) touchpad_dwt_toggle ;;
    eject)       eject_usb ;;
    *) echo "uso: $0 vol-up|vol-down|mute|mic-mute|bright-up|bright-down|touchpad-dwt|eject" >&2; exit 1 ;;
esac
