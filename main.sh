# Filename: file
# Author: CorQB
# Date: January 4, 2019
# Modified: January 4, 2019
#
# This script is used to start two functions, 1) a command which listens to
# an active log file and reports to 2) a bot which posts given strings from
# the logfile to a webhook. This script is meant to be used with the repository
# https://github.com/destruc7i0n/shulker to make bot startup easier to automate.

#Edit these values with your environment variables
MCSERVER="/opt/msm/servers/webbcraft/"
RCONIP="localhost"
RCONPORT="8000"

exec &> logfile.log
echo date "Beginning Log"

# Start listener

if pidof "listener" >/dev/null then;
    echo "Listener is already running. Everything is OK."
else
    echo "Starting listener..."
    screen -dm -S "listener" {tail -F /$MCSERVER/logs/latest.log | \
    grep --line-buffered ": <" | while read x ; do echo -ne $x | \
    curl -X POST -d @- http://$RCONIP:$RCONPORT/minecraft/hook ; done}
    echo "Listener Started."
    
###
