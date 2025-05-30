readarray -t output <<<$(acpi battery)
battery_count=${#output[@]}

for line in "${output[@]}"; do
	percentages+=($(echo "$line" | grep -o -m1 '[0-9]\{1,3\}%' | tr -d '%'))
	statuses+=($(echo "$line" | egrep -o -m1 'Discharging|Charging|AC|Full|Unknown'))
	remaining=$(echo "$line" | egrep -o -m1 '[0-9][0-9]:[0-9][0-9]')
	if [[ -n $remaining ]]; then
		remainings+=(" ($remaining)")
	else
		remainings+=("")
	fi
done

squares="■"

#There are 8 colors that reflect the current battery percentage when
#discharging
dis_colors=("${C1:-#FF0027}" "${C2:-#FF3B05}" "${C3:-#FFB923}"
	"${C4:-#FFD000}" "${C5:-#E4FF00}" "${C6:-#ADFF00}"
	"${C7:-#6DFF00}" "${C8:-#10BA00}")
charging_color="${CHARGING_COLOR:-#00AFE3}"
full_color="${FULL_COLOR:-#FFFFFF}"
ac_color="${AC_COLOR:-#535353}"

while getopts 1:2:3:4:5:6:7:8:c:f:a:h opt; do
	case "$opt" in
	1) dis_colors[0]="$OPTARG" ;;
	2) dis_colors[1]="$OPTARG" ;;
	3) dis_colors[2]="$OPTARG" ;;
	4) dis_colors[3]="$OPTARG" ;;
	5) dis_colors[4]="$OPTARG" ;;
	6) dis_colors[5]="$OPTARG" ;;
	7) dis_colors[6]="$OPTARG" ;;
	8) dis_colors[7]="$OPTARG" ;;
	c) charging_color="$OPTARG" ;;
	f) full_color="$OPTARG" ;;
	a) ac_color="$OPTARG" ;;
	h)
		printf "Usage: batterybar [OPTION] color
        When discharging, there are 8 [1-8] levels colors.
        You can specify custom colors, for example:
        
        batterybar -1 red -2 \"#F6F6F6\" -8 green
        
        You can also specify the colors for the charging, AC and
        charged states:
        
        batterybar -c green -f white -a \"#EEEEEE\"\n"
		exit 0
		;;
	esac
done

end=$(($battery_count - 1))
for i in $(seq 0 $end); do
	if ((percentages[$i] > 0 && percentages[$i] < 20)); then
		squares="■"
	elif ((percentages[$i] >= 20 && percentages[$i] < 40)); then
		squares="■■"
	elif ((percentages[$i] >= 40 && percentages[$i] < 60)); then
		squares="■■■"
	elif ((percentages[$i] >= 60 && percentages[$i] < 80)); then
		squares="■■■■"
	elif ((percentages[$i] >= 80)); then
		squares="■■■■■"
	fi

	if [[ "${statuses[$i]}" = "Unknown" ]]; then
		squares="<sup>?</sup>$squares"
	fi

	case "${statuses[$i]}" in
	"Charging")
		color="$charging_color"
		;;
	"Full")
		color="$full_color"
		;;
	"AC")
		color="$ac_color"
		;;
	"Discharging" | "Unknown")
		if ((percentages[$i] >= 0 && percentages[$i] < 10)); then
			color="${dis_colors[0]}"
		elif ((percentages[$i] >= 10 && percentages[$i] < 20)); then
			color="${dis_colors[1]}"
		elif ((percentages[$i] >= 20 && percentages[$i] < 30)); then
			color="${dis_colors[2]}"
		elif ((percentages[$i] >= 30 && percentages[$i] < 40)); then
			color="${dis_colors[3]}"
		elif ((percentages[$i] >= 40 && percentages[$i] < 60)); then
			color="${dis_colors[4]}"
		elif ((percentages[$i] >= 60 && percentages[$i] < 70)); then
			color="${dis_colors[5]}"
		elif ((percentages[$i] >= 70 && percentages[$i] < 80)); then
			color="${dis_colors[6]}"
		elif ((percentages[$i] >= 80)); then
			color="${dis_colors[7]}"
		fi
		;;
	esac

	# Print Battery number if there is more than one
	if (($end > 0)); then
		message="$message $(($i + 1)):"
	fi

	if [[ "$BLOCK_BUTTON" -eq 1 ]]; then
		message="$message ${statuses[$i]} <span foreground=\"$color\">${percentages[$i]}%${remainings[i]}</span>"
	fi
	message="$message <span foreground=\"$color\">$squares</span>"
done

echo $message
