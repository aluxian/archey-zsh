function archey() {
  user=$(whoami)
  hostname=$(hostname | sed 's/.local//g')
  distro="macOS $(sw_vers -productVersion)"
  kernel=$(uname)
  shell="$SHELL"
  terminal="$TERM ${TERM_PROGRAM//_/ }"
  term_font="$(kitty --debug-config 2>/dev/null | awk '/^font_family|^font_size/ {$1="";gsub("^ *","",$0);print $0}')"
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

  echo -e "
  ${GREEN#  }                 ###               ${textColor}User:${normal} ${user}${normal}
  ${GREEN#  }               ####                ${textColor}Hostname:${normal} ${hostname}${normal}
  ${GREEN#  }               ###                 ${textColor}Distro:${normal} ${distro}${normal}
  ${GREEN#  }       #######    #######          ${textColor}Kernel:${normal} ${kernel}${normal}
  ${YELLOW# }     ######################        ${textColor}Shell:${normal} ${shell}${normal}
  ${YELLOW# }    #####################          ${textColor}Terminal:${normal} ${terminal}${normal}
  ${RED#    }    ####################           ${textColor}Font Family:${normal} ${term_font}${normal}
  ${RED#    }    ####################           ${textColor}Network Location:${normal} ${location}${normal}
  ${RED#    }    #####################          ${textColor}CPU:${normal} ${cpu}${normal}
  ${PURPLE# }     ######################        ${textColor}GPU:${normal} ${gpu}${normal}
  ${PURPLE# }      ####################         ${textColor}RAM:${normal} ${ram}${normal}
  ${BLUE#   }        ################           
  ${BLUE#   }         ####     #####            
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
