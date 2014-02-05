#!/bin/sh

AUTOLOGIN=1

if [ "$AUTOLOGIN" == "1" ] ; then

    # enable autologin
    /bin/login -f root

else

    # disable autologin
    /bin/login

fi

