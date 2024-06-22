alias d='cd ~/.dotfiles'

alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'

alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

set-current-directory ()
{
    # Define markers
    START_MARKER="### scd start ###"
    END_MARKER="### scd end ###"

    # Temporary file to hold new settings
    TMP_FILE=$(mktemp)

    # Create the new settings block
    echo "$START_MARKER" > $TMP_FILE
    echo "cd $(pwd)" >> $TMP_FILE
    echo "if [ -f env/bin/activate ]; then" >> $TMP_FILE
    echo "    source env/bin/activate" >> $TMP_FILE
    echo "fi" >> $TMP_FILE
    # echo "sleep 1" >> $TMP_FILE
    # echo "clear" >> $TMP_FILE
    echo "$END_MARKER" >> $TMP_FILE

    # Backup the original .bashrc file
    cp ~/.bashrc ~/.bashrc.bak

    # Remove old block if it exists
    sed -i "/$START_MARKER/,/$END_MARKER/d" ~/.bashrc

    # Append new block to the end of .bashrc
    cat $TMP_FILE >> ~/.bashrc

    # Remove the temporary file
    rm $TMP_FILE
}

alias scd="set-current-directory"
