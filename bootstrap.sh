#!/bin/bash
###################################################################
###################################################################
# UTILITY FUNCTIONS
banner () {
    echo ""
    echo "###################################################################"
    echo "###################################################################"
    banner::format_string "${@}"
    echo "###################################################################"
    echo "###################################################################"
    echo ""
}

banner::format_string () {
    local input_string="${*}"
    # local output_string=""
    for i in $(seq 0 $(("${#input_string}" - 1))); do
        result+="${input_string:$i:1} "
    done
    echo "${result% }"
    unset result
}
###################################################################
###################################################################

banner "UPDATE AND UPGRADE SYSTEM"
sudo apt-get update
sudo apt-get upgrade -y

###################################################################
banner "INSTALL PIP"
sudo apt install python3-pip -y

###################################################################
banner "INSTALL GITHUB CLI"
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
    && out=$(mktemp) \
    && wget -nv -O"${out}" https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    && cat "${out}" | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y

###################################################################
banner "INSTALL GCLOUD & GSUTIL"
sudo apt-get install apt-transport-https ca-certificates gnupg curl
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg \
    | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg -y
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" \
    | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt-get update \
    && sudo apt-get install google-cloud-cli -y

###################################################################
banner "GITHUB CLI AUTHENTICATION"
stty sane
gh auth login --git-protocol https --web <<< "y"

###################################################################
banner "GCLOUD AUTHENTICATION"
stty sane
gcloud auth login --launch-browser
