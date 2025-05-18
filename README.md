# GNOME Terminal Color Scheme Installer

A tool to easily install and switch between custom color themes (schemes) for GNOME Terminal. Ships with modern dark color themes, such as **Black & Red** and **Black & Green**, and works with GNOME 3 and later, including Ubuntu's terminal.

## Features

- Quickly apply prebuilt color schemes to your GNOME Terminal profiles.
- Interactive mode: Guided, no-options-needed color scheme installer.
- Command-line mode: Target a specific terminal profile and color scheme.
- Works with GNOME 3.8+ and earlier versions.
- Easy to add your own custom color themes.

## Included Color Schemes

- **BlackRed**: A dark theme with red accents.
- **BlackGreen**: A dark theme with green highlights.

You can add more color schemes by copying the structure in the `colors/` directory.

## Installation

1. **Install dconf (if needed)**

   On Ubuntu/Debian:
   ```bash
   sudo apt-get install dconf-cli
   ```
   On other distributions, use your package manager to install `dconf`.

2. **Clone this repository**
   ```bash
   git clone https://github.com/dark-angel/gnome-terminal
   cd gnome-terminal
   ```

3. **Run the installer**
   ```bash
   ./install.sh
   ```

   The installer will guide you in selecting a color scheme and terminal profile. You can also use command-line options to skip the prompts.

## Usage

Run interactively:
```bash
./install.sh
```
With options (no prompts):
```bash
./install.sh --scheme=BlackGreen --profile=Default
```
For full help:
```bash
./install.sh --help
```

## Uninstall / Revert

To reset your terminal colors:
- For GNOME Terminal 3.8+:
  ```bash
  dconf reset -f /org/gnome/terminal/legacy/profiles:/
  ```
- For older versions:
  ```bash
  gconftool-2 --recursive-unset /apps/gnome-terminal
  ```

## Directory Structure

```
colors/             # Color schemes (BlackRed, BlackGreen, etc)
  <Scheme>/         # Each scheme has its own directory
    bg_color
    fg_color
    bd_color
    palette

src/                # Core installation and utility scripts
  profiles.sh       # Profile management functions
  strings.sh        # User-facing messages
  tools.sh          # Utility functions

install.sh          # Main installer script
INSTALL.md          # Install instructions (detailed)
README.md           # This file
```

## Requirements

- Bash
- dconf-cli (for GNOME 3.8+)
- gconftool-2 (for older GNOME)

---
