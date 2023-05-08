# Utility scripts used for security

## Encrypt files with openssl tool

* Encrypt all files with AES-256-CBC.
* encrypt.sh encrypt all files in an input directory and calculate cryptographic sha512 digest.

### Requirements

1. Install openssl tool from https://www.openssl.org/

#### Usage

1. Download encrypt.sh script from openssl directory
2. Put encrypt.sh file into the same directory you want to encrypt and type:
 ```bash
    ./encrypt.sh dir-name
```
3. Insert passphrase and confirm. 

#### Desired Output
If dir-name contains file.txt then encript.sh:
  - create encrypted file named file.aes
  - create cryptographic digest with sha512 file named file.sha512
  - remove the plaintext file.txt

## Decrypt files with openssl tool

* Decrypt all AES-256-CBC encrypted files.
* decrypt.sh decrypt all files in an input directory and calculate the corrisponding cryptographic sha512 digest for integrity check.

### Requirements

1. Install openssl tool from https://www.openssl.org/

#### Usage

1. Download decrypt.sh script from openssl directory
2. Put decrypt.sh file into the same directory you want to decrypt and type:
 ```bash
    ./decrypt.sh dir-name
```
3. Insert passphrase for decryption. 

#### Desired Output
If dir-name contains file.aes then decript.sh:
  - create decrypted file named file.txt
  - calculate sha512 digest and check the corrisponding hash contained into file.sha512
  - remove file.aes and file.sha512 if tif the sha512 check was successful

