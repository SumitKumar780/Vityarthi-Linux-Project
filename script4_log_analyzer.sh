#!/bin/bash
# =============================================================================
# Script 4: Log File Analyzer
# Author: Sumit Kumar Sah| Registration: 24MIM10255
# Course: Open Source Software | Chosen Software: Python
# Description: Reads a log file line by line, counts keyword occurrences,
#              and prints a summary with the last 5 matching lines.
# Usage: ./script4_log_analyzer.sh <logfile> [keyword]
# Example: ./script4_log_analyzer.sh /var/log/syslog error
# =============================================================================

# --- Accept log file path from first argument ---
LOGFILE=$1
# Accept keyword from second argument; default to "error" if not provided
KEYWORD=${2:-"error"}

# --- Counter variable to track keyword matches ---
COUNT=0
# Array to store matching lines (for printing last 5)
MATCH_LINES=()

echo "========================================================"
echo "        LOG FILE ANALYZER"
echo "========================================================"
echo ""

# --- Validate that an argument was provided ---
if [ -z "$LOGFILE" ]; then
    echo "  ERROR: No log file specified."
    echo "  Usage: $0 <logfile> [keyword]"
    echo "  Example: $0 /var/log/syslog error"
    echo ""
    # Suggest common log files that exist on the system
    echo "  Common log files on this system:"
    for f in /var/log/syslog /var/log/messages /var/log/auth.log /var/log/kern.log; do
        [ -f "$f" ] && echo "    - $f"
    done
    exit 1
fi

# --- Do-while style retry loop: retry up to 3 times if file is empty or missing ---
MAX_RETRIES=3
ATTEMPT=0

while [ $ATTEMPT -lt $MAX_RETRIES ]; do
    ATTEMPT=$((ATTEMPT + 1))

    # Check if the file exists
    if [ ! -f "$LOGFILE" ]; then
        echo "  Attempt $ATTEMPT/$MAX_RETRIES: File '$LOGFILE' not found."
        if [ $ATTEMPT -lt $MAX_RETRIES ]; then
            echo "  Retrying in 2 seconds..."
            sleep 2
        fi
        continue   # Jump back to top of while loop
    fi

    # Check if the file is empty
    if [ ! -s "$LOGFILE" ]; then
        echo "  Attempt $ATTEMPT/$MAX_RETRIES: File '$LOGFILE' exists but is empty."
        if [ $ATTEMPT -lt $MAX_RETRIES ]; then
            echo "  Retrying in 2 seconds..."
            sleep 2
        fi
        continue
    fi

    # File exists and is not empty — break out of retry loop
    echo "  ✔ File found and readable: $LOGFILE"
    break
done

# --- Final check after retry loop: exit if file still unavailable ---
if [ ! -f "$LOGFILE" ] || [ ! -s "$LOGFILE" ]; then
    echo ""
    echo "  ERROR: Could not access a valid log file after $MAX_RETRIES attempts."
    exit 1
fi

echo "  Keyword  : '$KEYWORD' (case-insensitive)"
echo "  Log File : $LOGFILE"
echo "  File Size: $(du -sh "$LOGFILE" | cut -f1)"
echo ""
echo "--------------------------------------------------------"
echo "  SCANNING LOG FILE..."
echo "--------------------------------------------------------"
echo ""

# --- While-read loop: read the log file line by line ---
# IFS= preserves leading/trailing whitespace; -r prevents backslash escaping
while IFS= read -r LINE; do
    # If the current line contains the keyword (case-insensitive with -i flag)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))            # Increment the match counter
        MATCH_LINES+=("$LINE")          # Add matching line to array
    fi
done < "$LOGFILE"    # Redirect file into the while loop

# --- Print summary ---
echo "  Scan complete."
echo ""
echo "  Keyword '$KEYWORD' found $COUNT time(s) in:"
echo "  $LOGFILE"
echo ""

# --- Print the last 5 matching lines ---
if [ "$COUNT" -gt 0 ]; then
    echo "--------------------------------------------------------"
    echo "  LAST 5 MATCHING LINES"
    echo "--------------------------------------------------------"
    echo ""

    # Calculate start index to get last 5 entries from the array
    TOTAL=${#MATCH_LINES[@]}
    START=$(( TOTAL > 5 ? TOTAL - 5 : 0 ))

    # Loop from START index to end of array
    for (( i=START; i<TOTAL; i++ )); do
        echo "  [Match $(( i - START + 1 ))] ${MATCH_LINES[$i]}"
    done
    echo ""
else
    echo "  No lines matching '$KEYWORD' were found in the log file."
    echo "  Try a different keyword such as: error, warning, fail, denied"
fi

echo "========================================================"
echo "  TIP: Run this script against /var/log/syslog or"
echo "  /var/log/auth.log for meaningful results."
echo "========================================================"
