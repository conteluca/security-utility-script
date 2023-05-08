# Utility scripts used for security

## Incremental Backup files with duplicity tool

* Incremental backup files with AES-256-CBC.
* backup.sh encrypt all files in an input directory and sign it for backup.

### Requirements

1. Install validity tool from https://duplicity.us/

#### Usage

1. Download backup.sh script from validity directory
2. Put backup.sh file into the same directory you want to encrypt and type:
 ```bash
    ./backup.sh dir-name
```
