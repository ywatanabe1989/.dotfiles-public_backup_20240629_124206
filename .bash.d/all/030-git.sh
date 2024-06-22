alias g='git'
alias st='git status'
alias branch='git branch'
alias switch='git switch'
alias checkout='git checkout'
alias fetch='git fetch'


# git-init () {
#     REPOSITORY_NAME=$(basename "$(pwd)")
#     GITHUB_OWNER=ywatanabe1989

#     if [ ! -f README.md ]; then
#        echo "# $REPOSITORY_NAME" > README.md
#     fi

#     if [ -d .git ]; then
#         read -p "Do you want to remove the existing .git directory? (y/n): " answer
#         if [ "$answer" = "y" ]; then
#             rm -rf .git
#             echo ".git directory removed."
#         else
#             echo "Operation cancelled."
#             return 1
#         fi
#     fi

#     # Check if remote repository exists
#     if gh repo view "$GITHUB_OWNER"/$REPOSITORY_NAME &> /dev/null; then
#         read -p "Remote repository https://github.com/$GITHUB_OWNER/$REPOSITORY_NAME already exists. Do you want to backup the existing repo and create a new one? (y/n) Or just delete it? (d): " answer
#         if [ "$answer" = "y" ]; then
#             TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
#             NEW_NAME="${REPOSITORY_NAME}_backup_${TIMESTAMP}"
#             gh repo rename $NEW_NAME --repo $GITHUB_OWNER/$REPOSITORY_NAME --yes
#             echo "Existing repository renamed to $NEW_NAME"
#         elif [ "$answer" = "d" ]; then
#             gh repo delete "$GITHUB_OWNER/$REPOSITORY_NAME" --yes
#             echo "Existing repository deleted"
#             # Wait for a bit and then try to create the new repository
#             echo "Waiting for GitHub to process the change..."
#             sleep 3
#         else
#             echo "Operation cancelled."
#             return 1
#         fi
#     fi

#     # Try to create new repository with retry
#     gh auth login --with-token < $HOME/.bash.d/secrets/access-tokens/github.txt
#     for i in {1..3}; do
#         if gh repo create "$REPOSITORY_NAME" --private; then
#             echo "Repository created successfully."
#             break
#         else
#             if [ $i -eq 3 ]; then
#                 echo "Failed to create repository after 3 attempts."
#                 return 1
#             fi
#             echo "Failed to create repository. Retrying in 10 seconds..."
#             sleep 3
#         fi
#     done

#     # Main branch
#     git init
#     git add README.md
#     git commit -m "first commit"
#     git branch -M main
#     git remote add origin git@github.com:$GITHUB_OWNER/$REPOSITORY_NAME.git
#     git push -u origin main || { echo "Failed to push to main branch"; return 1; }

#     # Develop branch
#     git branch -c develop
#     git switch develop
#     git add .
#     git commit -m "second commit" || true  # Commit only if there are changes
#     git push -u origin develop || { echo "Failed to push to develop branch"; return 1; }

#     # Create a pull request from develop to main only if there are differences
#     if [ $(git rev-list --count main..develop) -gt 0 ]; then
#         PR_URL=$(gh pr create --base main --head develop --title "Merge develop into main" --body "Automated pull request")

#         # Accept the pull request
#         if [ $? -eq 0 ]; then
#             PR_NUMBER=$(echo $PR_URL | awk -F'/' '{print $NF}')
#             gh pr merge $PR_NUMBER --merge --delete-branch
#         else
#             echo "Failed to create pull request"
#         fi
#     else
#         echo "No differences between main and develop, skipping pull request"
#     fi

#     git switch develop
# }


ad () {
    if [ $# -eq 0 ]; then
        git add .
    else
        for arg in "$@"; do
            git add "$arg"
        done
    fi
}

cm() {
    if [ -z "$*" ]; then
        now=`(date +'%Y-%m-%d-%H-%M-%S')`
        git commit -m "update-$now"
    else
        git commit -m "$*"
    fi
}

alias push='git push'

acp() {
    if [ -z "$*" ]; then
        ad && cm && git push
    else
        ad && cm "$*" && git push
    fi
}

# alias acp='ad && cm && push'
alias pull='git pull'
alias log="git log \
               --graph \
               --date=human \
               --decorate=short \
               --pretty=format:'%Cgreen%h %Creset%cd %Cblue%cn %Cred%d %Creset%s'"

git-unstage() {
    # Check if any arguments were provided
    if [ $# -eq 0 ]; then
        echo "Usage: git-unstage <file1> <file2> ..."
        echo "Error: No file specified to unstage."
        return 1
    fi

    # Unstage files specified in the arguments
    git restore --staged "$@"
}

git-untrack() {
    # Check if any arguments were provided
    if [ $# -eq 0 ]; then
        echo "Usage: git-untrack <file1> <directory1> ..."
        echo "Error: No file or directory specified to untrack."
        return 1
    fi

    # Untrack the files or directories specified in the arguments
    git rm --cached -r "$@"
    echo "Files and directories have been untracked but kept locally."

    # Optionally, automatically add these paths to .gitignore
    for path in "$@"; do
        echo "$path" >> .gitignore
    done
    echo "Untracked paths have been added to .gitignore."

    git add .gitignore
    git commit -m "Updated .gitignore with untracked paths"
}

git-find-large-files() {
    # Set the threshold size for large files
    local size_threshold=${1:-100M}

    # Find large files in the entire history of the repo
    git rev-list --objects --all |
        git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' |
        sed -n 's/^blob //p' |
        sort --numeric-sort --key=2 |
        cut -c 1-12,41- |
        $(command -v gnumfmt || echo numfmt) --to=iec-i --suffix=B --padding=7 --field=2 |
        awk -v threshold="$size_threshold" '$2+0 >= threshold+0 {print $2 "\t" $1}' |
        sort --human-numeric-sort --key=1
}

git-rm-eternal() {
    local fpath=$1
    read -p "Are you sure you want to remove $fpath from Git? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        # Temporarily stash other changes to ensure we don't commit them
        git stash push --keep-index

        # Remove the file from the current index (staging area)
        git rm -r --cached $fpath
        git commit -m "Stop tracking $fpath"

        # Remove the file from the entire history
        git filter-branch --force --index-filter \
            "git rm -r --cached --ignore-unmatch $fpath" \
            --prune-empty --tag-name-filter cat -- --all

        # Check if there are any stashed changes before popping
        if git stash list | grep -q 'stash@{0}'; then
            # Pop the stashed changes back
            git stash pop
        fi
    fi
}

git-configure-wyusuuke () {
    for lc in --local --global; do
        git config $lc user.email "wyusuuke@gmail.com"
        git config $lc user.name "Yusuke Watanabe"
        git config $lc init.templatedir "~/.git-templates"
        git config pull.ff only
    done
}


git-configure-ywatanabe-alumni () {
    for lc in --local --global; do
        git config $lc user.email "ywatanabe@alumni.u-tokyo.ac.jp"
        git config $lc user.name "Yusuke Watanabe"
        git config $lc init.templatedir "~/.git-templates"
        git config pull.ff only
    done
}

git-configure-ywatanabe-work () {
    for lc in --local --global; do
        git config $lc user.email "work@example.com"
        git config $lc user.name "Yusuke Watanabe"
        git config $lc init.templatedir "~/.git-templates"
        git config pull.rebase false
    done
}

git-add-gitignore-template() {
    local GITIGNORE_DEST="$PWD/.gitignore"
    local GITIGNORE_SRC_FILES=(
        "$HOME/.git-templates/.gitignore-templates/Custom/Secrets.gitignore"
        "$HOME/.git-templates/.gitignore-templates/Custom/LargeFiles.gitignore"
        "$HOME/.git-templates/.gitignore-templates/Custom/Development.gitignore"
        "$HOME/.git-templates/.gitignore-templates/Python.gitignore"
        "$HOME/.git-templates/.gitignore-templates/Custom/Singularity.gitignore"
        "$HOME/.git-templates/.gitignore-templates/TeX.gitignore"
        "$HOME/.git-templates/.gitignore-templates/Global/Emacs.gitignore"
    )

    # Ensure .gitignore exists
    if [[ ! -f "$GITIGNORE_DEST" ]]; then
        touch "$GITIGNORE_DEST"
        echo -e "\n.gitignore file was created at $GITIGNORE_DEST."
    else
        echo -e "\n.gitignore file already exists at $GITIGNORE_DEST."
    fi

    # Add the templates
    for GITIGNORE_SRC in "${GITIGNORE_SRC_FILES[@]}"; do
        local TAG="### Source: $GITIGNORE_SRC ###"

        # Check if the tag already exists in the .gitignore
        if ! grep -qF "$TAG" "$GITIGNORE_DEST"; then
            echo -e "\n$TAG\n$(cat "$GITIGNORE_SRC")" >> "$GITIGNORE_DEST"
            echo -e "\n$GITIGNORE_SRC has been added."
        else
            echo -e "\n$GITIGNORE_SRC is already included. Skipped."
        fi
    done

    # Create a .gitignore.strip file with whitespace removed
    sed 's/^[ \t]*//;s/[ \t]*$//' "$GITIGNORE_DEST" > "$GITIGNORE_DEST"_tmp
    # echo "Whitespace-stripped version created at $GITIGNORE_DEST"
    mv "$GITIGNORE_DEST"_tmp "$GITIGNORE_DEST"
}

git-tree() {
    git ls-tree -r --name-only HEAD | tree --fromfile
    }
