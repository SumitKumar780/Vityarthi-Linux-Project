#!/bin/bash
# =============================================================================
# Script 2: FOSS Package Inspector
# Author: [Your Name] | Registration: [Your Roll Number]
# Course: Open Source Software | Chosen Software: Python
# Description: Checks if a package is installed, displays version and license
#              details, and prints a philosophy note using a case statement.
# Usage: ./script2_package_inspector.sh [optional-package-name]
# =============================================================================

# --- Set the package to inspect (default: python3, or accept from argument) ---
PACKAGE=${1:-python3}   # Use command-line argument if provided, else default to python3

echo "========================================================"
echo "        FOSS PACKAGE INSPECTOR"
echo "========================================================"
echo ""
echo "  Inspecting package: $PACKAGE"
echo ""

# --- Check if the system uses RPM or APT package manager ---
# This makes the script portable across Fedora/CentOS (RPM) and Ubuntu/Debian (APT)
if command -v rpm &>/dev/null; then
    PKG_MANAGER="rpm"
elif command -v dpkg &>/dev/null; then
    PKG_MANAGER="dpkg"
else
    echo "  ERROR: No supported package manager found (rpm/dpkg)."
    exit 1
fi

echo "  Package Manager Detected: $PKG_MANAGER"
echo ""
echo "--------------------------------------------------------"
echo "  INSTALLATION STATUS"
echo "--------------------------------------------------------"
echo ""

# --- Check installation and display package details ---
if [ "$PKG_MANAGER" = "rpm" ]; then
    # For RPM-based systems (Fedora, CentOS, RHEL)
    if rpm -q "$PACKAGE" &>/dev/null; then
        echo "  ✔ $PACKAGE is INSTALLED on this system."
        echo ""
        echo "  Package Details:"
        rpm -qi "$PACKAGE" | grep -E "^(Name|Version|License|Summary|URL)" | \
            while IFS=: read -r key value; do
                echo "    $key :$value"
            done
    else
        echo "  ✘ $PACKAGE is NOT installed on this system."
        echo "  To install, run: sudo dnf install $PACKAGE"
    fi
else
    # For APT-based systems (Ubuntu, Debian)
    if dpkg -l "$PACKAGE" 2>/dev/null | grep -q "^ii"; then
        echo "  ✔ $PACKAGE is INSTALLED on this system."
        echo ""
        echo "  Package Details:"
        dpkg -l "$PACKAGE" 2>/dev/null | grep "^ii" | \
            awk '{printf "    Version  : %s\n    Package  : %s\n    Description: %s\n", $3, $2, $5}'
        # Show more info via apt-cache if available
        if command -v apt-cache &>/dev/null; then
            echo ""
            apt-cache show "$PACKAGE" 2>/dev/null | grep -E "^(Homepage|License|Maintainer)" | \
                while IFS=: read -r key value; do
                    echo "    $key :$value"
                done
        fi
    else
        echo "  ✘ $PACKAGE is NOT installed on this system."
        echo "  To install, run: sudo apt install $PACKAGE"
    fi
fi

echo ""
echo "--------------------------------------------------------"
echo "  OPEN SOURCE PHILOSOPHY NOTE"
echo "--------------------------------------------------------"
echo ""

# --- Case statement: print a philosophy note based on the package name ---
# Each case represents a major open-source package and its philosophical significance
case $PACKAGE in
    python3 | python)
        echo "  Python: Created by Guido van Rossum and governed by the"
        echo "  Python Software Foundation. Python's PSF License is one"
        echo "  of the most permissive in the open-source world — it lets"
        echo "  anyone use, modify, and distribute Python without restriction."
        echo "  It embodies the belief that a programming language should"
        echo "  belong to its community, not a corporation."
        ;;
    httpd | apache2)
        echo "  Apache: The web server that built the open internet."
        echo "  Released under the Apache 2.0 license — free to use,"
        echo "  modify, and distribute, even in proprietary products."
        ;;
    mysql | mysql-server)
        echo "  MySQL: Open source at the heart of millions of apps."
        echo "  Its dual GPL/commercial license tells a fascinating story"
        echo "  about how open-source projects navigate sustainability."
        ;;
    vlc | vlc-media-player)
        echo "  VLC: Built by students at a Paris university who just"
        echo "  wanted to stream video. Now it plays anything, anywhere."
        echo "  A perfect example of scratching your own itch — openly."
        ;;
    git)
        echo "  Git: Linus Torvalds built this when a proprietary tool"
        echo "  let him down. It is now the backbone of all software"
        echo "  collaboration. Open source tools often outlive the"
        echo "  proprietary alternatives they replaced."
        ;;
    firefox)
        echo "  Firefox: A nonprofit browser fighting for an open web."
        echo "  When Internet Explorer dominated, Mozilla proved that"
        echo "  community-driven software could win on quality alone."
        ;;
    libreoffice)
        echo "  LibreOffice: Born from a community fork of OpenOffice."
        echo "  A living lesson in why open-source licenses matter — the"
        echo "  community forked the project when corporate control"
        echo "  threatened its open future."
        ;;
    *)
        # Default case for packages not explicitly listed
        echo "  $PACKAGE: Every open-source package carries the story"
        echo "  of someone who chose to build in the open and share"
        echo "  their work freely with the world."
        ;;
esac

echo ""
echo "========================================================"
