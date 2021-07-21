#!/bin/bash

echo "--- Initializing VS Code extensions ---"
code-server --extensions-dir /config/extensions --install-extension Ikuyadeu.r
code-server --extensions-dir /config/extensions --install-extension REditorSupport.r-lsp
code-server --extensions-dir /config/extensions --install-extension GrapeCity.gc-excelviewer

