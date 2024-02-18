#!/bin/bash
#
# Use expansion with a default random key. Don't overwrite the value if it was set in the .env

generate_key() {
  # $1 is the key name
  # Zero-length value check, which means we don't allow zero length keys
  
  # https://unix.stackexchange.com/a/41418
  if [ -z "${!1}" ]
  then
    KEY=$(openssl rand -base64 24)
    # Add the key to the .env file the first time it is generated
    # ... and a newline https://stackoverflow.com/questions/9741433/appending-a-line-break-to-an-output-file-in-a-shell-script
    echo $'\n'"${1}=${KEY}" >> /config/.env
    # Export for envsubst below
    export "${1}=${KEY}"
  else 
    # Export for envsubst below
    export "${1}=${!1}"
  fi
}

generate_key READUP_API_KEY
generate_key READUP_HASHID_SALT
generate_key READUP_READVER_ENC_KEY
generate_key READUP_TOKENIZATION_ENC_KEY

#
# Finds all files with .template in their path, substitutes environment files into them
# with envsubst, and then writes out the outcome to the same path without .template
find /config -type f -name "*.template*" -exec sh -c \
    'echo Substituting {} ...; envsubst < {} > $(echo {} | sed "s/\.template//")' \;
