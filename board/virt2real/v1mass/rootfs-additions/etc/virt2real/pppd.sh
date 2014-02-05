#!/bin/sh

case "$1" in
connect)
    echo "" >  /tmp/pppstate
    pppd call megafon
    ;;
disconnect)
    killall pppd 
    echo "" >  /tmp/pppstate
    ;;
esac

