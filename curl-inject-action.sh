 
#!/bin/bash
machineID=$(hostname)
action=$(/writable/var/mountScripts/curl-bin/curl --noproxy "*" -d "serial=${SERIAL_USB}&hostid=$machineID&event=inject" "${SERVER_URL}")
exit 0
