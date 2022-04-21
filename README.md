# tmkms

## Script is incomplete - do not use yet...
* Setup on Ubuntu 20.4
<br><br>

Step 1: Run this script by pasting this into terminal:
```
bash <(curl -Ls https://raw.githubusercontent.com/sryps/osmo-tmkms-installer/main/osmosis/yubi-tmkms-installer.sh)
```      
<br><br>

Terminal should output new yubihsm passwords...
Output should look like this (record them safely):
```
$ tmkms yubihsm setup
This process will *ERASE* the configured YubiHSM2 and reinitialize it:

- YubiHSM serial: 9876543210

Authentication keys with the following IDs and passwords will be created:

- key 0x0001: admin:

    double section release consider diet pilot flip shell mother alone what fantasy
    much answer lottery crew nut reopen stereo square popular addict just animal

- authkey 0x0002 [operator]:  kms-operator-password-1k02vtxh4ggxct5tngncc33rk9yy5yjhk
- authkey 0x0003 [auditor]:   kms-auditor-password-1s0ynq69ezavnqgq84p0rkhxvkqm54ks9
- authkey 0x0004 [validator]: kms-validator-password-1x4anf3n8vqkzm0klrwljhcx72sankcw0
- wrapkey 0x0001 [primary]:   21a6ca8cfd5dbe9c26320b5c4935ff1e63b9ab54e2dfe24f66677aba8852be13

*** Are you SURE you want erase and reinitialize this HSM? (y/N):
```

<br><br>

Step 2: After you have the yubihsm initialized you will need to replace the "password" in ~/home/$USER/yubihsm/tmkms.toml with the 24 word mnemonic before importing your priv_validator_key.json
After password is updated, run:
```
tmkms yubihsm keys import -t json -i 1 ~/.osmosisd/config/priv_validator_key.json
```



NOTES:

*Run as non-root user

*Remove ~/.osmosisd/config/priv_validator_key.json after imported & encrypted on yubihsm
