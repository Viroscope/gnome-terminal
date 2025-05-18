
#!/usr/bin/env bash

# String table for user-facing messages

STR_USAGE="How to use: ./install.sh [-h] [-s <color style>] [-p <profile>]"
STR_OPTIONS="Options:"
STR_HELP="  -h, --help        Show this help message"
STR_SHOW_INFO="  Shows information about how to use this script."
STR_SCHEME_OPT="  -s style, --scheme style, --scheme=style"
STR_SCHEME_DESC="    Pick a color style for your terminal (for example: BlackGreen, BlackRed). If not given, you will be asked."
STR_PROFILE_OPT="  -p profile, --profile profile, --profile=profile"
STR_GREETING="This tool helps you easily change how your Gnome Terminal looks by setting up a new color style."
STR_GREETING+=" Don’t worry — you’ll be asked to pick a style (color scheme) and which terminal profile to use.\n\n"

STR_GREETING+="There is no 'uninstall' option , but you can always return your terminal colors to the original settings if you want.\n"
STR_GREETING+="If you’re not sure, make a new profile in your Terminal before running this, so nothing important is lost.\n\n"
STR_GREETING+="To go back to default colors later, use this command below from your Terminal:\n\n"
STR_GREETING+=" For Gnome Terminal 3.8 or newer: dconf reset -f /org/gnome/terminal/legacy/profiles:/\n"
STR_GREETING+=" For Gnome Terminal older than 3.8: gconftool-2 --recursive-unset /apps/gnome-terminal\n\n"
STR_GREETING+="This program by default is interactive and will guide you step by step, asking questions on what you want.\n"
STR_GREETING+="If you prefer, you can tell it exactly what to do all at once by using options.\n\n"
STR_GREETING+=" For example:\n\n"
STR_GREETING+="  ./install.sh --scheme=BlackGreen --profile=Hacker\n\n"
STR_GREETING+="For more help and options, run './install.sh --help'.\n\n"
STR_SELECT_SCHEME="Choose your favorite color style:"
STR_SELECTED="You chose:"
STR_SELECTED_SCHEME="  Color style:  "
STR_SELECTED_PROFILE="  Terminal profile: "
STR_CONFIRM="Do you want to change the colors for this profile with your chosen style?"
STR_CONTINUE_PROMPT="(Type YES to continue) "
STR_CONFIRMED="Okay! Your new colors are being applied."
