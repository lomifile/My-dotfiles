#!/bin/bash
# Ubuntu-compatible i3blocks volume script using PulseAudio

set -a

# Symbols
AUDIO_HIGH_SYMBOL=${AUDIO_HIGH_SYMBOL:-' '}
AUDIO_MED_SYMBOL=${AUDIO_MED_SYMBOL:-' '}
AUDIO_LOW_SYMBOL=${AUDIO_LOW_SYMBOL:-''}
AUDIO_MUTED_SYMBOL=${AUDIO_MUTED_SYMBOL:-''}

# Thresholds and delta
AUDIO_MED_THRESH=${AUDIO_MED_THRESH:-50}
AUDIO_LOW_THRESH=${AUDIO_LOW_THRESH:-0}
AUDIO_DELTA=${AUDIO_DELTA:-5}

# Colors
DEFAULT_COLOR=${DEFAULT_COLOR:-"#cdd6f4"}
MUTED_COLOR=${MUTED_COLOR:-"#a0a0a0"}

# Format
LONG_FORMAT=${LONG_FORMAT:-'${SYMB} ${VOL}%'}
SHORT_FORMAT=${SHORT_FORMAT:-'${SYMB} ${VOL}% [${INDEX}]'}

# Flags
USE_ALSA_NAME=${USE_ALSA_NAME:-0}
USE_DESCRIPTION=${USE_DESCRIPTION:-0}
SUBSCRIBE=${SUBSCRIBE:-0}

# Mixer
MIXER=${MIXER:-""}
SCONTROL=${SCONTROL:-""}

# Parse options
while getopts F:Sf:adH:M:L:X:T:t:C:c:i:m:s:h opt; do
	case "$opt" in
	S) SUBSCRIBE=1 ;;
	F) LONG_FORMAT="$OPTARG" ;;
	f) SHORT_FORMAT="$OPTARG" ;;
	a) USE_ALSA_NAME=1 ;;
	d) USE_DESCRIPTION=1 ;;
	H) AUDIO_HIGH_SYMBOL="$OPTARG" ;;
	M) AUDIO_MED_SYMBOL="$OPTARG" ;;
	L) AUDIO_LOW_SYMBOL="$OPTARG" ;;
	X) AUDIO_MUTED_SYMBOL="$OPTARG" ;;
	T) AUDIO_MED_THRESH="$OPTARG" ;;
	t) AUDIO_LOW_THRESH="$OPTARG" ;;
	C) DEFAULT_COLOR="$OPTARG" ;;
	c) MUTED_COLOR="$OPTARG" ;;
	i) AUDIO_INTERVAL="$OPTARG" ;;
	m) MIXER="$OPTARG" ;;
	s) SCONTROL="$OPTARG" ;;
	h) grep -E "^# " "$0" | sed 's/^# //' && exit 0 ;;
	esac
done

# Determine mixer
if [[ -z "$MIXER" ]]; then
	if amixer -D pulse info >/dev/null 2>&1; then
		MIXER="pulse"
	else
		MIXER="default"
	fi
fi

# Determine scontrol
if [[ -z "$SCONTROL" ]]; then
	SCONTROL=$(amixer -D "$MIXER" scontrols | sed -n "s/Simple mixer control '\([^']*\)',0/\1/p" | head -n1)
fi

# Determine toggle capability (optional)
CAPABILITY=$(amixer -D "$MIXER" get "$SCONTROL" 2>/dev/null | grep -q 'Capture' && echo "cap" || echo "")

# Switch sinks (cycle default)
move_sinks_to_new_default() {
	local new_default=$1
	pactl list short sink-inputs | cut -f1 | while read -r input; do
		pactl move-sink-input "$input" "$new_default"
	done
}

set_default_playback_device_next() {
	local inc=${1:-1}
	local sinks=($(pactl list short sinks | cut -f2))
	local current=$(pactl get-default-sink)
	for i in "${!sinks[@]}"; do
		if [[ "${sinks[$i]}" == "$current" ]]; then
			new_index=$(((i + inc + ${#sinks[@]}) % ${#sinks[@]}))
			new_sink=${sinks[$new_index]}
			pactl set-default-sink "$new_sink"
			move_sinks_to_new_default "$new_sink"
			break
		fi
	done
}

# Mouse click handlers
case "$BLOCK_BUTTON" in
1) set_default_playback_device_next 1 ;;                      # Left click
2) amixer -q -D "$MIXER" sset "$SCONTROL" toggle ;;           # Middle click
3) set_default_playback_device_next -1 ;;                     # Right click
4) amixer -q -D "$MIXER" sset "$SCONTROL" "$AUDIO_DELTA"%+ ;; # Scroll up
5) amixer -q -D "$MIXER" sset "$SCONTROL" "$AUDIO_DELTA"%- ;; # Scroll down
esac

# Print helper
print_format() {
	echo "$1" | envsubst '${SYMB}${VOL}${INDEX}${NAME}'
}

print_block() {
	local default_sink=$(pactl get-default-sink)
	local sink_info=$(pactl list sinks | awk -v sink="$default_sink" '
        $0 ~ "Name: "sink {found=1}
        found && /^$/ {exit}
        found {print}
    ')
	local vol=$(echo "$sink_info" | grep -E 'Volume:.*front-left|mono' | head -n1 | grep -o '[0-9]\+%' | tr -d '%')
	local muted=$(echo "$sink_info" | grep -Po 'Mute: \K\w+')
	local name=$(echo "$sink_info" | grep -Po 'Description: \K.*')
	local index=$(echo "$sink_info" | grep -Po 'index: \K\d+')

	if [[ $USE_ALSA_NAME == 1 ]]; then
		name=$(pactl list sinks | awk -v sink="$default_sink" '
            $0 ~ "Name: "sink {found=1}
            found && /alsa.name|alsa.mixer_name/ {print $NF; exit}
        ')
	elif [[ $USE_DESCRIPTION == 1 ]]; then
		name=$(echo "$sink_info" | grep -Po 'Description: \K.*')
	fi

	local symb=$AUDIO_HIGH_SYMBOL
	if [[ "$muted" == "yes" ]]; then
		symb=$AUDIO_MUTED_SYMBOL
		COLOR=$MUTED_COLOR
	else
		if [[ $vol -le $AUDIO_LOW_THRESH ]]; then
			symb=$AUDIO_LOW_SYMBOL
		elif [[ $vol -le $AUDIO_MED_THRESH ]]; then
			symb=$AUDIO_MED_SYMBOL
		fi
		COLOR=$DEFAULT_COLOR
	fi

	export SYMB="$symb" VOL="$vol" NAME="$name" INDEX="$index"

	if [[ $SUBSCRIBE == 1 ]]; then
		print_format "$LONG_FORMAT"
	else
		print_format "$LONG_FORMAT"
		print_format "$SHORT_FORMAT"
		echo "$COLOR"
	fi
}

print_block

if [[ $SUBSCRIBE == 1 ]]; then
	pactl subscribe | grep --line-buffered 'sink' | while read -r _; do
		print_block
	done
fi
