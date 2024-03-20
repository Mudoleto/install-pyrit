#!/usr/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"


function ctrl_c(){
  echo -e "\n\n${redColour}[!]Saliendo.....\n${endColour}"
  tput cnorm;exit 0
}

#Ctrl + C
trap ctrl_c INT

function install_pyrit(){
  cd Pyrit
  sudo apt-get install libpcap-dev -y &>/dev/null
  echo -e "${yellowColour}[+]${endcolour}${grayColour}pyrit installation will start${endColour}"

  sudo python2.7 setup.py clean &>/dev/null
  if [[ $? == 0 ]]; then
    sudo python2.7 setup.py build &>/dev/null
    if [[ $? == 0 ]]; then
      sudo python2.7 setup.py install &>/dev/null
      if [[ $? == 0 ]]; then
        echo -e "${yellowColour}[+]${endColour}${greenColour}The pyrit installation is finished${endColour}"
        sudo ln -sf /usr/bin/python3.11 /usr/local/bin/python &>/dev/null
      else
        echo -e "${yellowColour}[!]${endColour}${redColour}Could not finish installation due to an error${endColour}"
      fi
    else
      echo -e "${yellowColour}[!]${endColour}${redColour}Could not finish installation due to an error${endColour}"
    fi
  else
    echo -e "${yellowColour}[!]${endColour}${redColour}Could not finish installation due to an error${endColour}"
  fi

}

function install_python2(){
  echo -e "${yellowColour}[+]${endColour}${purpleColour}We will proceed to download the python 2.7.18 version. please wait${endColour}"
  wget https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz &>/dev/null

  if [[ $? == 0 ]]; then
    echo -e "${yellowColour}[+]${endColour}${purpleColour}Python 2.7.18 has been successfully downloaded.Now the file will be unzipped and the installation will be performed.${endColour}"
    sleep 5
    python2_7="Python-2.7.18.tgz"
    tar -xf $python2_7 &>/dev/null
    if [[ $? == 0 ]]; then
      cd Python-2.7.18 &>/dev/null
      echo -e "${yellowColour}[+]${endColour}${blueColour}This process may take a few minutes, you can sit down for a drink or other activity.${endColour}"
      ./configure &>/dev/null
      if [[ $? == 0 ]]; then
        make &>/dev/null
        if [[ $? == 0 ]]; then
          sudo make install &>/dev/null
          if [[ $? == 0 ]]; then
            echo -e "${yellowColour}[+]${endColour}${greenColour}Python2.7 is already installed on your system.${endColour}"
            cd ..
            curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip.py &>/dev/null
            python2.7 get-pip.py &>/dev/null
            pip2 install scapy=2.5.0 &>/dev/null
            install_pyrit
          else
            echo -e "${yellowColour}[+]${endColour}${redColour}Could not finish installation due to an error${endColour}"
          fi
        else
          echo -e "${yellowColour}[+]${endColour}${redColour}Could not finish installation due to an error${endColour}"
        fi
      else
        echo -e "${yellowColour}[+]${endColour}${redColour}Could not finish installation due to an error${endColour}"
      fi
    else
      echo -e "${yellowColour}[+]${endColour}${redColour}The installation process could not be performed due to an error.${endColour}"
    fi
  else
    echo -e "${yellowColour}[!]${endColour}${redColour}Unable to download python 2.7.18 version${endColour}"
  fi
}

function github_clone_pyrit(){
  echo -e "${yellowColour}[+]${endColour}${grayColour}Downloading the Pyrit repository from JPaulMora, please wait for it${endColour}"
  git clone https://github.com/JPaulMora/Pyrit.git &>/dev/null

  if [[ $? == 0 ]]; then
    echo -e "${yellowColour}[+]${endColour}${grayColour}Successfully downloaded the repository${endColour}"
    install_python2 
  else
    echo -e "${redColour}[!]${endColour}${grayColour}Failed to download repository or no longer exists${endColour}"
    exit 0
  fi
}

function hive_five(){
  echo -e "${yellowColour}[+]${endColour}${grayColour}Welcome in a moment will begin the installation of the Pyrit tool developed by JPaulMora, all this process will be automatic, do not worry nothing happens, just sit and wait.${endcolour}${yellowColour}[+]${endColour}"

  sleep 5
  github_clone_pyrit
}

hive_five
