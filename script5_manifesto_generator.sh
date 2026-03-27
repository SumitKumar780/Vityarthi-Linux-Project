#!/bin/bash
# =============================================================================
# Script 5: Open Source Manifesto Generator
# Author: [Your Name] | Registration: [Your Roll Number]
# Course: Open Source Software | Chosen Software: Python
# Description: Interactively asks the user three questions and generates a
#              personalised open-source philosophy statement saved to a .txt file.
# Usage: ./script5_manifesto_generator.sh
# =============================================================================

# --- Alias concept demonstrated via comment ---
# In a real shell session you might define: alias py='python3'
# Aliases are shorthand commands. Example (do not run inside script):
# alias ll='ls -alh'    # makes 'll' behave like 'ls -alh'
# alias audit='./script1_system_identity.sh'  # run audit with short command
# Aliases are shell conveniences — they cannot be exported to child scripts,
# which is why we demonstrate the concept here via comments.

echo "========================================================"
echo "        OPEN SOURCE MANIFESTO GENERATOR"
echo "========================================================"
echo ""
echo "  This script will generate your personal open-source"
echo "  philosophy statement based on your answers."
echo ""
echo "  Answer three short questions honestly."
echo "  Your manifesto will be saved as a .txt file."
echo ""
echo "--------------------------------------------------------"

# --- Read user input interactively using the 'read' command ---
# -p flag allows inline prompt text

read -p "  1. Name one open-source tool you use every day: " TOOL
echo ""

read -p "  2. In one word, what does 'freedom' mean to you? " FREEDOM
echo ""

read -p "  3. Name one thing you would build and share freely: " BUILD
echo ""

# --- Capture metadata ---
DATE=$(date '+%d %B %Y')          # Formatted date for the manifesto
AUTHOR=$(whoami)                  # Current user's username
OUTPUT="manifesto_${AUTHOR}.txt"  # Output filename includes username

echo "--------------------------------------------------------"
echo "  Generating your manifesto..."
echo "--------------------------------------------------------"
echo ""

# --- String concatenation: build the manifesto paragraph ---
# Each 'echo >>' appends a new line to the output file
# '>' creates/overwrites the file; '>>' appends to it

# Overwrite (or create) the file with the header
echo "========================================================" > "$OUTPUT"
echo "       MY OPEN SOURCE MANIFESTO" >> "$OUTPUT"
echo "========================================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  Author : $AUTHOR" >> "$OUTPUT"
echo "  Date   : $DATE" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "--------------------------------------------------------" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# --- The manifesto paragraph — built from user's three answers ---
# String concatenation using variables inline with echo
echo "  I believe in the power of open source." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  Every day, I rely on $TOOL — a tool built not by a" >> "$OUTPUT"
echo "  corporation seeking profit, but by people who believed" >> "$OUTPUT"
echo "  that good software should be shared. To me, that act" >> "$OUTPUT"
echo "  of sharing is the purest expression of $FREEDOM." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  The open-source movement rests on a simple idea: that" >> "$OUTPUT"
echo "  knowledge grows when it is given away. A tool built" >> "$OUTPUT"
echo "  in secret helps one person. A tool shared openly can" >> "$OUTPUT"
echo "  change the world." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  One day, I intend to build $BUILD and release it" >> "$OUTPUT"
echo "  freely — not because I have to, but because I" >> "$OUTPUT"
echo "  understand that every open-source project I depend on" >> "$OUTPUT"
echo "  was made by someone who made that same choice." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  I stand on the shoulders of giants. I will try to" >> "$OUTPUT"
echo "  be one for someone else." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "--------------------------------------------------------" >> "$OUTPUT"
echo "  This manifesto was generated on $DATE" >> "$OUTPUT"
echo "  as part of the Open Source Software Capstone Project." >> "$OUTPUT"
echo "========================================================" >> "$OUTPUT"

# --- Confirm the file was saved ---
echo "  ✔ Manifesto saved to: $OUTPUT"
echo ""

# --- Display the saved manifesto ---
echo "  Here is your manifesto:"
echo ""
cat "$OUTPUT"

echo ""
echo "========================================================"
echo "  Your manifesto is saved. Add it to your GitHub repo!"
echo "========================================================"
