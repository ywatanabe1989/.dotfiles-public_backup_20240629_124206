# Compiling Emacs
``` bash
find ~/.emacs.d/ -name '*.elc' | xargs rm
find ~/.emacs.d/ -name '*.el' | xargs emacs -batch -f batch-byte-compiel
```

