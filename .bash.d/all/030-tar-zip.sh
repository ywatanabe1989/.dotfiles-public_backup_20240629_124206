# Creates an archive (*.tar.gz) from given directory.
function mktar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function mkzip() { zip -r "${1%%/}.zip" "$1" ; }


