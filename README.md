# tmkms

Script is incomplete - do not use yet...

```
bash <(curl -Ls https://raw.githubusercontent.com/sryps/osmo-tmkms-installer/main/osmosis/yubi-tmkms-installer.sh)
```      

Terminal should output new yubihsm passwords...
record them safely...

then run:
```
tmkms yubihsm keys import -t json -i 1 ~/.osmosisd/config/priv_validator_key.json
```

NOTES:

*Run as non-root user

*Remove ~/.osmosisd/config/priv_validator_key.json after imported & encrypted on yubihsm
