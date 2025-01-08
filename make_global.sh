#!/bin/bash

# Define colors for styling
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
RESET='\033[0m'

# Fun emojis
SUCCESS_EMOJI="🎉"
ERROR_EMOJI="❌"
INFO_EMOJI="ℹ️"
PROMPT_EMOJI="👉"

# Welcome message
echo -e "${CYAN}${INFO_EMOJI} Welcome to the Script Globalizer! ${SUCCESS_EMOJI}${RESET}"

# Prompt for script name
echo -e "${PROMPT_EMOJI} ${YELLOW}Enter the name of the script file (e.g., wireless.sh):${RESET}"
read -p "> " SCRIPT_NAME

# Check if the file exists
if [ ! -f "$SCRIPT_NAME" ]; then
  echo -e "${RED}${ERROR_EMOJI} The file '$SCRIPT_NAME' does not exist in the current directory!${RESET}"
  exit 1
fi

# Create ~/bin if it doesn't exist
if [ ! -d "$HOME/bin" ]; then
  echo -e "${INFO_EMOJI} ${YELLOW}Creating ~/bin directory...${RESET}"
  mkdir -p "$HOME/bin"
fi

# Copy the script to ~/bin
echo -e "${INFO_EMOJI} ${YELLOW}Copying $SCRIPT_NAME to ~/bin/...${RESET}"
cp "$SCRIPT_NAME" "$HOME/bin/"

# Make the script executable
echo -e "${INFO_EMOJI} ${YELLOW}Making $SCRIPT_NAME executable...${RESET}"
chmod +x "$HOME/bin/$SCRIPT_NAME"

# Add ~/bin to PATH if not already added
if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
  echo -e "${INFO_EMOJI} ${YELLOW}Adding ~/bin to your PATH...${RESET}"
  echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
  echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc # For Zsh users
  source ~/.bashrc 2>/dev/null || source ~/.zshrc
else
  echo -e "${SUCCESS_EMOJI} ${GREEN}~/bin is already in your PATH.${RESET}"
fi

# Confirmation message
echo -e "${SUCCESS_EMOJI} ${GREEN}$SCRIPT_NAME has been successfully copied to ~/bin and made globally accessible!${RESET}"
echo -e "${CYAN}You can run it from anywhere by typing '${SCRIPT_NAME%%.*}'. The original file remains untouched.${RESET}"
