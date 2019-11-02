function archey() {
  user=$(whoami)
  hostname=$(hostname | sed 's/.local//g')
  distro="macOS $(sw_vers -productVersion)"
  kernel=$(uname)
  shell="$SHELL"
  terminal="$TERM ${TERM_PROGRAM//_/ }"
  term_font="$(kitty --debug-config | awk '/^font_family|^font_size/ {$1="";gsub("^ *","",$0);print $0}')"
  location="$(networksetup -getcurrentlocation)"
  cpu=$(sysctl -n machdep.cpu.brand_string)
  gpu="$(system_profiler SPDisplaysDataType | awk -F': ' '/^\ *Chipset Model:/ {printf $2 ", "}' | rev | cut -c3- | rev)"
  ram="$(( $(sysctl -n hw.memsize) / 1024 ** 3  )) GB"

  RED=$(tput       setaf 1 2>/dev/null)
  GREEN=$(tput     setaf 2 2>/dev/null)
  YELLOW=$(tput    setaf 3 2>/dev/null)
  BLUE=$(tput      setaf 4 2>/dev/null)
  PURPLE=$(tput    setaf 5 2>/dev/null)
  textColor=$(tput setaf 6 2>/dev/null)
  normal=$(tput    sgr0 2>/dev/null)

  fieldlist[${#fieldlist[@]}]="${textColor}User:${normal} ${user}${normal}"
  fieldlist[${#fieldlist[@]}]="${textColor}Hostname:${normal} ${hostname}${normal}"
  fieldlist[${#fieldlist[@]}]="${textColor}Distro:${normal} ${distro}${normal}"
  fieldlist[${#fieldlist[@]}]="${textColor}Kernel:${normal} ${kernel}${normal}"
  fieldlist[${#fieldlist[@]}]="${textColor}Shell:${normal} ${shell}${normal}"
  fieldlist[${#fieldlist[@]}]="${textColor}Terminal:${normal} ${terminal}${normal}"
  fieldlist[${#fieldlist[@]}]="${textColor}Font Family:${normal} ${term_font}${normal}"
  fieldlist[${#fieldlist[@]}]="${textColor}Network Location:${normal} ${location}${normal}"
  fieldlist[${#fieldlist[@]}]="${textColor}CPU:${normal} ${cpu}${normal}"
  fieldlist[${#fieldlist[@]}]="${textColor}GPU:${normal} ${gpu}${normal}"
  fieldlist[${#fieldlist[@]}]="${textColor}RAM:${normal} ${ram}${normal}"

  echo -e "
  ${GREEN#  }                 ###               ${fieldlist[0]}
  ${GREEN#  }               ####                ${fieldlist[1]}
  ${GREEN#  }               ###                 ${fieldlist[2]}
  ${GREEN#  }       #######    #######          ${fieldlist[3]}
  ${YELLOW# }     ######################        ${fieldlist[4]}
  ${YELLOW# }    #####################          ${fieldlist[5]}
  ${RED#    }    ####################           ${fieldlist[6]}
  ${RED#    }    ####################           ${fieldlist[7]}
  ${RED#    }    #####################          ${fieldlist[8]}
  ${PURPLE# }     ######################        ${fieldlist[9]}
  ${PURPLE# }      ####################         ${fieldlist[10]}
  ${BLUE#   }        ################           ${fieldlist[11]}
  ${BLUE#   }         ####     #####            ${fieldlist[12]}
  ${normal}
  "
}

function _cached_archey() {
  local CACHE_FILE_PATH=/tmp/archey-cache.txt
  [ -f $CACHE_FILE_PATH ] && cat $CACHE_FILE_PATH || archey | tee $CACHE_FILE_PATH
}

function _clear_cache_archey() {
  local CACHE_FILE_PATH=/tmp/archey-cache.txt
  rm -rf $CACHE_FILE_PATH
}
