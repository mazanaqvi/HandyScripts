#!/bin/bash

# Define some colors for styling
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
RESET='\033[0m'

# Fun emojis
SUCCESS_EMOJI="🎉"
ERROR_EMOJI="❌"
INFO_EMOJI="ℹ️"
CONNECT_EMOJI="🔌"
PROMPT_EMOJI="👉"
WINK_EMOJI="😉"

# Cool header
echo -e "${CYAN}${INFO_EMOJI} Welcome to the ADB Connector by Mazanaqvi! ${WINK_EMOJI}${RESET}"
echo -e "${CYAN}Let's get you connected!${RESET}"

# Prompt for IP address
echo -e "${PROMPT_EMOJI} ${YELLOW}Enter the IP address of the Android device:${RESET}"
read -p "> " IP

# Prompt for port
echo -e "${PROMPT_EMOJI} ${YELLOW}Enter the port:${RESET}"
read -p "> " PORT

# Check if IP and port are provided
if [ -z "$IP" ] || [ -z "$PORT" ]; then
  echo -e "${RED}${ERROR_EMOJI} Both IP address and port are required!${RESET}"
  exit 1
fi

# Attempt to connect to the device
echo -e "${CYAN}${CONNECT_EMOJI} Connecting to ${IP}:${PORT}...${RESET}"
adb connect "$IP:$PORT"

# Check connection status
if [ $? -eq 0 ]; then
  echo -e "${GREEN}${SUCCESS_EMOJI} Successfully connected to ${IP}:${PORT}! Enjoy debugging, Mazanaqvi! ${WINK_EMOJI}${RESET}"
else
  echo -e "${RED}${ERROR_EMOJI} Failed to connect to ${IP}:${PORT}. Please check the IP address, port, and device settings.${RESET}"
fi
