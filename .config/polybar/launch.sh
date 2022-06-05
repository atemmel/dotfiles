#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID polybar >/dev/null; do sleep 1; done

#polybar example -r &
if type "xrandr"; then
	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		MONITOR=$m polybar main &
		MONITOR=$m polybar lower &
		break
	done
else
	polybar main &
	polybar lower &
fi

# Old
#polybar main &
#polybar lower &
