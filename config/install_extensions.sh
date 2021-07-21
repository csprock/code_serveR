#!/bin/bash

if [-z $INSTALL_EXTENSIONS]; then
    echo "--- Initializing VS Code extensions ---"
    code-server --extensions-dir /config/extensions --install-extension Ikuyadeu.r
    code-server --extensions-dir /config/extensions --install-extension REditorSupport.r-lsp
    code-server --extensions-dir /config/extensions --install-extension GrapeCity.gc-excelviewer
else:
    echo "--- Skipping extension install ---"
fi