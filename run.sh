#!/usr/bin/bash
BUILD_DIR="./build"
SRC_DIR="./src"
LOG_DIR="./logs"
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
LOG_FILE="${LOG_DIR}/build_${TIMESTAMP}.log"

# Create build directory if it doesn't exist
if [ ! -d "$BUILD_DIR" ]; then
    mkdir "$BUILD_DIR"
    echo "Directory $BUILD_DIR created."
else
    echo "Directory $BUILD_DIR already exists."
fi

# Create logs directory if it doesn't exist
if [ ! -d "$LOG_DIR" ]; then
    mkdir "$LOG_DIR"
    echo "Directory $LOG_DIR created."
fi

# Remove the curly braces for variable expansion
CODE="${1}.c"

if [ -d "$SRC_DIR" ]; then
    CODE="${SRC_DIR}/${1}.c"
fi

# for better debugging you can uncomment below line
# set -xe

echo "Starting compilation at $(date)" | tee "$LOG_FILE"
echo "Compiling: $CODE" | tee -a "$LOG_FILE"

# Redirect both stdout and stderr to tee which writes to both terminal and log file
clang -Wall -Wextra "$CODE" -o "${BUILD_DIR}/${1}" 2>&1 | tee -a "$LOG_FILE"

# Check if compilation was successful
if [ ${PIPESTATUS[0]} -eq 0 ]; then
    echo -e "\nCompilation successful!" | tee -a "$LOG_FILE"
    echo "[application output]: ${BUILD_DIR}/${1}" | tee -a "$LOG_FILE"
    echo "====================" | tee -a "$LOG_FILE"
    ./build/${1} | tee -a "$LOG_FILE"
    echo -e "\n====================" | tee -a "$LOG_FILE"
else
    echo -e "\nCompilation failed! Check the log file: $LOG_FILE" | tee -a "$LOG_FILE"
    exit 1
fi

echo -e "\nLog file saved at: $LOG_FILE"
