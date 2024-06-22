#!/bin/bash


gh-install() {
    -gh-install-ubuntu() {
        (type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
            && sudo mkdir -p -m 755 /etc/apt/keyrings \
            && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
            && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
            && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
            && sudo apt update \
            && sudo apt install gh -y
    }

    if-os "ubuntu" -gh-install-ubuntu
}


gh-upgrade() {
    -gh-upgrade-ubuntu() {
        sudo apt update
        sudo apt install gh
    }

    if-os "ubuntu" -gh-upgrade-ubuntu
}

# sudo apt install -y gitsome
if type gh > /dev/null 2>&1; then
    gh config set pager more > /dev/null
fi

alias gh-delete='gh repo-delete'
alias gh-login='gh auth login'
alias gh-logout='gh auth logout'
alias gh-view='gh repo view'
alias gh-create='gh repo create'




# # to switch GitHub CLI to use the personal access token
# switchToPersonalGitHub() {
#     # Log out from the current GitHub CLI session
#     gh auth logout && \
    #         # Decrypt the personal GitHub token and write it to a temporary file
#         decript -t github_token_p > /tmp/_.txt && \
    #             # Log in to GitHub CLI using the personal access token from the temporary file
#         gh auth login --with-token < /tmp/_.txt && \
    #             # Remove the temporary file containing the token for security
#         rm -rf /tmp/_.txt
# }

# # to switch GitHub CLI to use the work access token
# switchToWorkGitHub() {
#     # Log out from the current GitHub CLI session
#     gh auth logout && \
    #         # Decrypt the work GitHub token and write it to a temporary file
#         decript -t github_token_w > /tmp/_.txt && \
    #             # Log in to GitHub CLI using the work access token from the temporary file
#         gh auth login --with-token < /tmp/_.txt && \
    #             # Remove the temporary file containing the token for security
#         rm -rf /tmp/_.txt
# }


# EOF
