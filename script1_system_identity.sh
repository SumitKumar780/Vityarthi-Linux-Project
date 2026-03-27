#!/bin/bash
# =============================================================================
# Script 1: System Identity Report
# Author: [Your Name] | Registration: [Your Roll Number]
# Course: Open Source Software | Chosen Software: Python
# Description: Displays a system welcome screen with OS, kernel, user, uptime,
#              and license information relevant to the open source audit.
# =============================================================================

# --- Variables ---
STUDENT_NAME="[Your Name]"          # Replace with your actual name
REG_NUMBER="[Your Reg Number]"      # Replace with your registration number
SOFTWARE_CHOICE="Python"            # The open-source software being audited
SOFTWARE_LICENSE="PSF License (Python Software Foundation License)"

# --- Gather system information using command substitution ---
KERNEL=$(uname -r)                          # Kernel version
DISTRO=$(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')  # Distro name
USER_NAME=$(whoami)                         # Current logged-in user
HOME_DIR=$HOME                              # User's home directory
UPTIME=$(uptime -p)                         # Human-readable uptime
CURRENT_DATE=$(date '+%d %B %Y')            # Formatted date
CURRENT_TIME=$(date '+%H:%M:%S')            # Current time
OS_LICENSE="GPL v2 (GNU General Public License version 2)"  # Linux kernel license

# --- Display the system identity report ---
echo "========================================================"
echo "       OPEN SOURCE AUDIT — SYSTEM IDENTITY REPORT       "
echo "========================================================"
echo ""
echo "  Student  : $STUDENT_NAME"
echo "  Reg. No  : $REG_NUMBER"
echo "  Software : $SOFTWARE_CHOICE"
echo ""
echo "--------------------------------------------------------"
echo "  SYSTEM INFORMATION"
echo "--------------------------------------------------------"
echo ""
echo "  Distribution : $DISTRO"
echo "  Kernel       : $KERNEL"
echo "  Current User : $USER_NAME"
echo "  Home Dir     : $HOME_DIR"
echo "  Uptime       : $UPTIME"
echo "  Date         : $CURRENT_DATE"
echo "  Time         : $CURRENT_TIME"
echo ""
echo "--------------------------------------------------------"
echo "  LICENSE INFORMATION"
echo "--------------------------------------------------------"
echo ""
echo "  OS License       : $OS_LICENSE"
echo "  Audited Software : $SOFTWARE_CHOICE"
echo "  Software License : $SOFTWARE_LICENSE"
echo ""
echo "  NOTE: The PSF License grants you the freedom to use,"
echo "  modify, and distribute Python freely, provided the"
echo "  license notice is retained in derivative works."
echo ""
echo "========================================================"
echo "  Open Source: Built openly. Shared freely. Improved"
echo "  collectively. — The spirit behind $SOFTWARE_CHOICE"
echo "========================================================"
