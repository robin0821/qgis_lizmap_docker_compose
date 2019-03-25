#!/bin/sh
set -e

# Apache gets grumpy about PID files pre-existing
rm -f /var/run/apache2/apache2.pid
rm -f /usr/local/apache2/logs/httpd.pid
#remove pre-existing xvfb setting file
rm -f /tmp/.X99-lock
rm -rf /tmp/.X11-unix
#start xvfb process
/usr/bin/Xvfb  :99 -screen 0 1024x768x24 -ac +extension GLX +render -noreset &

service apache2 restart


# avoid containers closing and keep it open
tail -f /dev/null
