
# Use this when cloning the repo to this folder
# Check if argument is provided
echo "Check if provided the arguement"
if [ "$#" -ne 2 ]; then
    echo "Usage: sh clone-stella-repo.sh <repo> <branch>"
    exit 1
fi


REPO_SSH_URL=$1 #clone the ssh repo not https
BRANCH=$2
REPO_NAME="stella-mb-feasibility-tools"
DOWNLOAD_ORB_SCRIPT="download-orb.sh"
SCRIPT_FOLDER="scripts"

#Clone    
echo "Cloning the repo under $REPO_NAME"
cd ../../
git clone $REPO_SSH_URL 

# Pull latest changes base on branch
echo "Adding input for branch to pull the changes"
cd "$REPO_NAME" 
git checkout -b "$BRANCH"
git pull origin "$BRANCH"

# Run the scripts"
echo "Running the scripts to download the orb_vocab.flow"
cd $SCRIPT_FOLDER
sh $DOWNLOAD_ORB_SCRIPT

# Successful clone and download
echo "Successfully clone repo and download the orb_vocab.flow"