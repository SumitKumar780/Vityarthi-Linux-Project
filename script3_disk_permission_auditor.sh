#!/bin/bash
# =============================================================================
# Script 3: Disk and Permission Auditor
# Author: [Your Name] | Registration: [Your Roll Number]
# Course: Open Source Software | Chosen Software: Python
# Description: Loops through key system directories and reports disk usage and
#              permissions. Also checks Python's specific config directories.
# =============================================================================

# --- List of important system directories to audit ---
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/usr/lib" "/var")

echo "========================================================"
echo "        DISK AND PERMISSION AUDITOR"
echo "========================================================"
echo ""
echo "  System: $(hostname)"
echo "  Date  : $(date '+%d %B %Y %H:%M:%S')"
echo ""
echo "--------------------------------------------------------"
echo "  SYSTEM DIRECTORY AUDIT"
echo "--------------------------------------------------------"
printf "  %-20s %-30s %-8s\n" "Directory" "Permissions (perm user group)" "Size"
echo "  ------------------------------------------------------------"

# --- For loop: iterate over each directory in the array ---
for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        # Extract permissions, owner user, and owner group using awk
        PERMS=$(ls -ld "$DIR" | awk '{print $1, $3, $4}')
        # Get human-readable size; suppress permission errors with 2>/dev/null
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)
        printf "  %-20s %-30s %-8s\n" "$DIR" "$PERMS" "$SIZE"
    else
        # Directory does not exist on this system
        printf "  %-20s %s\n" "$DIR" "[ does not exist on this system ]"
    fi
done

echo ""
echo "--------------------------------------------------------"
echo "  PYTHON-SPECIFIC DIRECTORY AUDIT"
echo "--------------------------------------------------------"
echo ""

# --- Array of Python-related directories to check ---
# These are the directories Python uses for config, libraries, and logs
PYTHON_DIRS=(
    "/usr/lib/python3"
    "/usr/lib/python3.11"
    "/usr/local/lib/python3.11"
    "/usr/bin/python3"
    "/etc/python3"
    "/usr/local/bin/python3"
)

echo "  Checking Python installation directories..."
echo ""

# --- For loop over Python directories ---
FOUND=0   # Counter to track how many Python dirs were found
for PDIR in "${PYTHON_DIRS[@]}"; do
    if [ -e "$PDIR" ]; then
        # Get permissions and ownership for the path
        PERMS=$(ls -ld "$PDIR" | awk '{print $1, $3, $4}')
        # Get size (files and directories both handled)
        if [ -d "$PDIR" ]; then
            SIZE=$(du -sh "$PDIR" 2>/dev/null | cut -f1)
        else
            SIZE=$(du -sh "$PDIR" 2>/dev/null | cut -f1)
        fi
        printf "  %-35s %-30s %-8s\n" "$PDIR" "$PERMS" "${SIZE:-N/A}"
        FOUND=$((FOUND + 1))   # Increment counter
    fi
done

# --- Check if any Python directories were found ---
if [ "$FOUND" -eq 0 ]; then
    echo "  No Python-specific directories found."
    echo "  Python may not be installed, or it may be in a non-standard location."
    echo "  Try: which python3"
else
    echo ""
    echo "  Total Python directories found: $FOUND"
fi

echo ""
echo "--------------------------------------------------------"
echo "  PYTHON EXECUTABLE LOCATIONS"
echo "--------------------------------------------------------"
echo ""

# --- Use command -v to find Python executables ---
for PY_CMD in python python3 python3.11 python3.12; do
    PY_PATH=$(command -v "$PY_CMD" 2>/dev/null)
    if [ -n "$PY_PATH" ]; then
        # Get the version string from the executable
        PY_VERSION=$("$PY_CMD" --version 2>&1)
        echo "  Found: $PY_PATH => $PY_VERSION"
    fi
done

echo ""
echo "--------------------------------------------------------"
echo "  DISK USAGE SUMMARY"
echo "--------------------------------------------------------"
echo ""

# --- Show overall disk usage for the filesystem ---
df -h / | awk 'NR==1{print "  "$0} NR==2{print "  "$0}'

echo ""
echo "========================================================"
echo "  NOTE: Permissions are shown as: [rwx bits] [owner] [group]"
echo "  Python runs under the current user unless invoked as root."
echo "  Config files in /etc are owned by root for security."
echo "========================================================"
