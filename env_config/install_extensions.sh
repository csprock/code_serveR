#!/bin/bash

if [ "$INSTALL_EXTENSIONS" = "true" ]; then
    echo "*** Initializing VS Code extensions ***"
    while read p; do
        code-server --extensions-dir /config/extensions --install-extension $p
    done </tmp/extension_list
else
    echo "*** Skipping extension install ***"
fi