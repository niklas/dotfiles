source ~/.bash/.bash_preexec.sh
# called before each command and starts stopwatch
function preexec () {
	export PREEXEC_CMD="$BASH_COMMAND"
	export PREEXEC_TIME=$(date +'%s')
}

# called after each command, stops stopwatch
# and notifies if time elpsed exceeds threshold
function precmd () {
	stop=$(date +'%s')
	start=${PREEXEC_TIME:-$stop}
	let elapsed=$stop-$start
	max=${PREEXEC_MAX:-10}

	if [ $elapsed -gt $max ]; then
		notify-send -c "Terminal" "${PREEXEC_CMD:-Terminal Command}" "took $elapsed secs"
#		growlnotify -n "Terminal" -m "took $elapsed secs" "${PREEXEC_CMD:-Terminal Command}"
	fi
}

preexec_install

