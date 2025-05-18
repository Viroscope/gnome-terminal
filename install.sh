#!/usr/bin/env bash
dir=$(dirname "$0")

declare -a schemes
schemes=($(cd $dir/colors && echo * && cd - > /dev/null))

source $dir/src/tools.sh
source $dir/src/profiles.sh
source $dir/src/strings.sh

show_help() {
  echo "$STR_USAGE"
  echo
  echo "$STR_OPTIONS"
  echo "$STR_HELP"
  echo "$STR_SHOW_INFO"
  echo "$STR_SCHEME_OPT"
  echo "$STR_SCHEME_DESC"
  echo "$STR_PROFILE_OPT"
  echo "$STR_PROFILE_DESC"
}

validate_scheme() {
  local profile=$1
  in_array $scheme "${schemes[@]}" || die "$scheme is not a valid scheme" 2
}

set_profile_colors() {
  local profile=$1
  local scheme=$2
  local scheme_dir=$dir/colors/$scheme

  local bg_color_file=$scheme_dir/bg_color
  local fg_color_file=$scheme_dir/fg_color
  local bd_color_file=$scheme_dir/bd_color

  if [ "$newGnome" = "1" ]
    then local profile_path=$dconfdir/$profile

    # set color palette
    dconf write $profile_path/palette "$(to_dconf < $scheme_dir/palette)"

    # set foreground, background and highlight color
    palette_string="$(to_dconf < $scheme_dir/palette | tr -d '
')"
    dconf write $profile_path/palette "$palette_string"
    dconf write "$profile_path/background-color" "'$(cat "$bg_color_file")'"
    dconf write "$profile_path/foreground-color" "'$(cat "$fg_color_file")'"

    # make sure the profile is set to not use theme colors
    dconf write $profile_path/use-theme-colors "false"

    # set highlighted color to be different from foreground color
    dconf write $profile_path/bold-color-same-as-fg "false"

  else
    local profile_path=$gconfdir/$profile

    # set color palette
    gconftool-2 -s -t string $profile_path/palette "$(to_gconf < $scheme_dir/palette)"

    # set foreground, background and highlight color
    gconftool-2 -s -t string $profile_path/bold_color $(cat $bd_color_file)
    gconftool-2 -s -t string $profile_path/background_color \
        $(cat $bg_color_file)
    gconftool-2 -s -t string $profile_path/foreground_color \
        $(cat $fg_color_file)

    # make sure the profile is set to not use theme colors
    gconftool-2 -s -t bool $profile_path/use_theme_colors false

    # set highlighted color to be different from foreground color
    gconftool-2 -s -t bool $profile_path/bold_color_same_as_fg false
  fi
}

interactive_help() {
  echo -en "$STR_GREETING"
}


interactive_select_scheme() {
  echo "$STR_SELECT_SCHEME"
  select scheme
  do
    if [[ -z $scheme ]]
    then
      die "ERROR: Invalid selection -- ABORTING!" 2
    fi
    break
  done
  echo
}

interactive_confirm() {
  local confirmation

  echo "$STR_SELECTED"
  echo
  echo "$STR_SELECTED_SCHEME$scheme"
  echo "$STR_SELECTED_PROFILE$(get_profile_name "$profile") ($profile)"
  echo
  echo "$STR_CONFIRM"
  echo -n "$STR_CONTINUE_PROMPT"

  read confirmation
  if [[ $(echo $confirmation | tr '[:lower:]' '[:upper:]') != YES ]]
  then
    die "ERROR: Confirmation failed -- ABORTING!"
  fi

  echo "$STR_CONFIRMED"
}

while [ $# -gt 0 ]
do
  case $1 in
    -h | --help )
      show_help
      exit 0
    ;;
    --scheme=* )
      scheme=${1#*=}
    ;;
    -s | --scheme )
      scheme=$2
      shift
    ;;
    --profile=* )
      profile=${1#*=}
    ;;
    -p | --profile )
      profile=$2
      shift
    ;;
  esac
  shift
done

if [[ -z "$scheme" ]] || [[ -z "$profile" ]]
then
  interactive_help
  # Instead of stopping, continue to prompt for missing info
fi

if [[ -z "$scheme" ]]
then
  interactive_select_scheme "${schemes[@]}"
fi

if [[ -z "$profile" ]]
then
  if [ "$newGnome" = "1" ]
    then check_empty_profile
  fi
  interactive_select_profile "${profiles[@]}"
  interactive_confirm
fi

if [[ -n "$scheme" ]]
  then validate_scheme $scheme
else
  interactive_select_scheme "${schemes[@]}"
fi

if [[ -n "$profile" ]]
  then if [ "$newGnome" = "1" ]
    then profile="$(get_uuid "$profile")"
  fi
  validate_profile $profile
else
  if [ "$newGnome" = "1" ]
    then check_empty_profile
  fi
  interactive_select_profile "${profiles[@]}"
  interactive_confirm
fi

