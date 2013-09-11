#!/bin/sh

SSID=virt2real
PASSPHRASE=12345678

uaputl sys_cfg_ssid "$SSID"
uaputl sys_cfg_protocol 32
uaputl sys_cfg_wpa_passphrase "$PASSPHRASE"
uaputl sys_cfg_cipher 8 8
uaputl sys_cfg_channel 0 1
uaputl bss_start

