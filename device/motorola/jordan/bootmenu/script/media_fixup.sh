#!/system/bin/sh

PATH='/system/xbin:/system/bin'

restart_required() {
  logwrapper echo "check media server status"
  req=`logcat -d | tail -n 50 | grep "Waiting for service media"`
  [ -n "$req" ] && return 1
  req=`logcat -d | tail -n 50 | grep "AudioPolicyService not published"`
  [ -n "$req" ] && return 1
  req=`logcat -d | tail -n 50 | grep "Media player service not published"`
  [ -n "$req" ] && return 1
  return 0
}

restart_service() {
  logwrapper echo "RESTARTING MEDIA SERVICE TO FIX BOOTLOCK"
  stop media
  sleep 3
  start media
  logwrapper echo "restart done..."
}

# well, i could make a loop, but will be temporary :p

logwrapper echo "sleep 65s "
sleep 65

if [ -f /data/mediaDead ]; then
logwrapper echo "check waitingcount "
restart_service
rm -f /data/mediaDead 
fi

logwrapper echo "check exit "

exit 0
