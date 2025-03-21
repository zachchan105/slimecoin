 #!/usr/bin/env bash

 # Execute this file to install the slimecoin cli tools into your path on OS X

 CURRENT_LOC="$( cd "$(dirname "$0")" ; pwd -P )"
 LOCATION=${CURRENT_LOC%Slimecoin-Qt.app*}

 # Ensure that the directory to symlink to exists
 sudo mkdir -p /usr/local/bin

 # Create symlinks to the cli tools
 sudo ln -s ${LOCATION}/Slimecoin-Qt.app/Contents/MacOS/slimecoind /usr/local/bin/slimecoind
 sudo ln -s ${LOCATION}/Slimecoin-Qt.app/Contents/MacOS/slimecoin-cli /usr/local/bin/slimecoin-cli
