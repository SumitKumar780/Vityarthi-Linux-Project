# OSS Audit — Python
### Open Source Software Capstone Project

---

| Field | Details |
|---|---|
| **Student Name** | Sumit Kumar Sah |
| **Registration Number** | 24MIM10255 |
| **Course** | Open Source Software (NGMC) |
| **Chosen Software** | Python (PSF License) |
| **Repo Name** | oss-audit-[24MIM10255] |

---

## About This Project

This repository is the technical submission for the **Open Source Audit** capstone project. The audited software is **Python** — one of the world's most widely used programming languages, governed by the Python Software Foundation and released under the PSF License.

The project includes five shell scripts that demonstrate practical Linux command-line skills, a full written report (submitted separately as PDF), and this README.

---

## Repository Contents

```
oss-audit-[rollnumber]/
├── script1_system_identity.sh       # System Identity Report
├── script2_package_inspector.sh     # FOSS Package Inspector
├── script3_disk_permission_auditor.sh  # Disk and Permission Auditor
├── script4_log_analyzer.sh          # Log File Analyzer
├── script5_manifesto_generator.sh   # Open Source Manifesto Generator
└── README.md                        # This file
```

---

## Script Descriptions

### Script 1 — System Identity Report
**File:** `script1_system_identity.sh`

Displays a formatted welcome screen showing the Linux distribution name, kernel version, current logged-in user, home directory, system uptime, current date and time, and the open-source license that covers the OS and the audited software (Python).

**Key concepts used:** variables, `echo`, command substitution (`$()`), output formatting.

---

### Script 2 — FOSS Package Inspector
**File:** `script2_package_inspector.sh`

Checks whether Python (or any specified package) is installed on the system using either `rpm` or `dpkg` depending on the distribution. Displays version, license, and summary information. A `case` statement prints a philosophy note about the package.

**Key concepts used:** `if-then-else`, `case` statement, `rpm -qi` / `dpkg -l`, pipe with `grep`, command-line arguments.

---

### Script 3 — Disk and Permission Auditor
**File:** `script3_disk_permission_auditor.sh`

Loops through a list of critical system directories (`/etc`, `/var/log`, `/home`, `/usr/bin`, `/tmp`, etc.) and reports the permissions, owner, group, and disk usage of each. Also checks Python-specific installation directories.

**Key concepts used:** `for` loop, arrays, `ls -ld`, `du -sh`, `awk`, `cut`, conditional checks with `[ -d ]` and `[ -e ]`.

---

### Script 4 — Log File Analyzer
**File:** `script4_log_analyzer.sh`

Reads a log file line by line and counts how many lines contain a specified keyword (default: `error`). Implements a do-while style retry loop if the file is missing or empty, and prints the last 5 matching lines.

**Key concepts used:** `while read` loop, `if-then`, counter variables, arrays, command-line arguments (`$1`, `$2`), retry loop.

---

### Script 5 — Open Source Manifesto Generator
**File:** `script5_manifesto_generator.sh`

Interactively asks the user three questions using `read -p`, then composes a personalised open-source philosophy paragraph using string concatenation with the answers. Saves the manifesto to a `.txt` file named after the current user, and prints it to the terminal.

**Key concepts used:** `read` for user input, string concatenation, file writing with `>` and `>>`, `date` command, aliases concept (demonstrated via comments).

---

## How to Run the Scripts on Linux

### Step 1 — Clone the repository
```bash
git clone https://github.com/[your-username]/oss-audit-[rollnumber].git
cd oss-audit-[rollnumber]
```

### Step 2 — Make scripts executable
```bash
chmod +x script1_system_identity.sh
chmod +x script2_package_inspector.sh
chmod +x script3_disk_permission_auditor.sh
chmod +x script4_log_analyzer.sh
chmod +x script5_manifesto_generator.sh
```

### Step 3 — Run each script

**Script 1 — System Identity Report**
```bash
./script1_system_identity.sh
```

**Script 2 — FOSS Package Inspector**
```bash
# Inspect Python (default)
./script2_package_inspector.sh

# Inspect any other package
./script2_package_inspector.sh git
./script2_package_inspector.sh vlc
```

**Script 3 — Disk and Permission Auditor**
```bash
./script3_disk_permission_auditor.sh
```

**Script 4 — Log File Analyzer**
```bash
# Analyze syslog for 'error' (default keyword)
./script4_log_analyzer.sh /var/log/syslog

# Analyze with a custom keyword
./script4_log_analyzer.sh /var/log/auth.log failed

# On Fedora/CentOS (messages instead of syslog)
./script4_log_analyzer.sh /var/log/messages warning
```

**Script 5 — Manifesto Generator**
```bash
./script5_manifesto_generator.sh
# Follow the interactive prompts
# Your manifesto will be saved as manifesto_[username].txt
```

---

## Dependencies

| Dependency | Purpose | Check with |
|---|---|---|
| `bash` (v4+) | Run all scripts | `bash --version` |
| `python3` | Audited software | `python3 --version` |
| `rpm` or `dpkg` | Script 2 package inspection | `which rpm` or `which dpkg` |
| `du`, `df`, `ls` | Script 3 disk audit | Pre-installed on all Linux |
| `grep`, `awk`, `cut` | Text processing | Pre-installed on all Linux |
| `uname`, `uptime`, `date` | Script 1 system info | Pre-installed on all Linux |

All dependencies are standard Linux utilities. No additional installations are required beyond Python itself.

---

## Notes

- Scripts are tested on Ubuntu 22.04 LTS and Fedora 38. They should work on any modern Linux distribution.
- Script 2 automatically detects whether the system uses `rpm` (Fedora/CentOS) or `dpkg` (Ubuntu/Debian).
- Script 4 requires a readable log file path as an argument. On systems where `/var/log/syslog` does not exist, use `/var/log/messages`.
- The project report PDF is submitted separately on the VITyarthi portal.

---

## License

Scripts in this repository are submitted as academic coursework. The audited software, Python, is released under the **Python Software Foundation (PSF) License**.
