# Osmosis TMKMS with YubiHSM

## Script is incomplete - do not use yet...
* Setup on Ubuntu 20.4

## Requirements
Make sure yubihsm is plugged into server usb port before starting.
Make sure to run as non-root user.

<hr>
<br><br>

Step 1: Run this script by pasting this into terminal:
```
bash <(curl -Ls https://raw.githubusercontent.com/sryps/osmo-tmkms-installer/main/osmosis/yubi-tmkms-installer.sh)
```      
<br><br>

Terminal should output new yubihsm passwords. You will need this to encrypt and decrypt your validator key...
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

<hr>
<br><br>

Step 2: After you have the yubihsm initialized you will need to replace the "password" in ~/home/$USER/yubihsm/tmkms.toml with the 24 word mnemonic before importing your priv_validator_key.json
After password is updated, run:
```
tmkms yubihsm keys import -t json -i 1 ~/.osmosisd/config/priv_validator_key.json
```


<hr>
<br><br>
After priv_validator_key.json is imported onto yubihsm you should encrypt it using directions from iqlusion in link below and store offline.


For in-depth information checkout: <a href="https://github.com/iqlusioninc/tmkms/blob/main/README.yubihsm.md">https://github.com/iqlusioninc/tmkms/blob/main/README.yubihsm.md</a>
