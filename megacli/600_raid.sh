#!/bin/sh

if [ ! -f /usr/bin/MegaCli64 ]; then ln -s /opt/MegaRAID/MegaCli/MegaCli64 /usr/bin/MegaCli64; fi

d=""

function sysoOne(){
	echo -e "${d}{\"metric\": \"${1}\", \"endpoint\": \"$(hostname)\", \"timestamp\": `date +"%s"`, \"step\": 600, \"value\": ${2}, \"counterType\": \"GAUGE\",\"tags\": \"${3}\"}\c"
}

MegaCli -PDGetNum -aALL -Silent -NoLog > /dev/null
pdiskcount=$?
pdiskok=$(MegaCli -PDList -aALL -NoLog | grep "Firmware state" | grep Online | wc -l)
echo -e "[\c"
sysoOne "megacli.pdisk" $(expr $pdiskcount - $pdiskok)
echo "]"
