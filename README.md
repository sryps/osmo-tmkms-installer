# Osmosis TMKMS with YubiHSM

* Setup on Ubuntu 20.4

## Requirements
Make sure yubihsm is plugged into server usb port before starting.
<br>
Make sure to run as non-root user with sudo permissions.

<hr>
<br><br>

Step 1: Run this script by pasting this into terminal:
```
bash <(curl -Ls https://raw.githubusercontent.com/sryps/osmo-tmkms-installer/main/osmosis/yubi-tmkms-installer.sh)
```      
<br><br>

After going through all prompts, terminal should output new yubihsm passwords. You will need these to encrypt and decrypt your validator key...
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
<br>
<hr>
<br><br>

Step 2: After you have the everything is installed and yubihsm is initialized you will need to replace the "password" in ~/home/$USER/yubihsm/tmkms.toml with the 24 word mnemonic in order to import your priv_validator_key.json
<br><br>
Example in tmkms.toml:
```
auth = { key = 1, password = "double section release consider diet pilot flip shell mother alone what fantasy much answer lottery crew nut reopen stereo square popular addict just animal" }
```
<br><br>
After password is updated in tmkms.toml, run:
```
tmkms yubihsm keys import -t json -i 1 ~/.osmosisd/config/priv_validator_key.json
```
<br><hr><br><br>
Once key is imported you will need to update the auth= key again to only give it access to sign. The validator key is #4 and the password is listed beside <i>- authkey 0x0004 [validator]: ...kms-validator-password-**************************************</i>
<br>It will look similar to this:
```
auth = { key = 4, password = "kms-validator-password-1x4anf3n8vqkzm0klrwljhcx72sankcw0" }
```
<br><hr><br><br>
Step 3: You will need to update your ~/.osmosisd/config/config.toml and comment out the priv_validator_key and fill out the priv_validator_laddr="tcp://localhost:46658"
<br><i>Feel free to edit tmkms.toml and put your own port number</i>
<br>
<hr>
<br><br>
Step 4: After priv_validator_key.json is imported onto yubihsm you should encrypt it using directions from iqlusion in link below and store offline.

<br><br>
For in-depth information checkout: <a href="https://github.com/iqlusioninc/tmkms/blob/main/README.yubihsm.md">https://github.com/iqlusioninc/tmkms/blob/main/README.yubihsm.md</a>
