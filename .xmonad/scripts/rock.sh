fn="SourceCodePro 1m-9:Bold"
obg="#333333"
ofg="#EEEEEE"

conky -c /home/hans/.xmonad/scripts/okabe.conkyrc | dzen2 -p -ta r -x 400 -h 22 -w 966 -fn "$fn" -bg "$obg" -fg "$ofg"
