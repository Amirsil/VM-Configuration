export ZSH="/home/foo/.oh-my-zsh"
ZSH_THEME="bira"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Miscellaneous
alias py=python
alias la="ls -lAh"
alias sl=ls

arg() {
        if [ -z $1 ]
        then
                echo "Usage: arg [ARG_NUMBER]"
        else
                awk -v arg="$1" '{print $arg}'
        fi
}

##!## when piping to another command, make sure to escape the pipes
fwatch() {
  watch -n 1 "zsh -c \"source ~/.zshrc; $@\""
}
alias fwatch='fwatch '

# Network
alias ipa="ip -brief a"
alias ports="sudo firewall-cmd --list-all | grep -G '\sports:\s'"

editi() {
        if [ -z $1 ]
        then
                echo "Usage: editi [NETWORK-INTERFACE]"
        else
                vim /etc/sysconfig/network-scripts/ifcfg-$1
        fi
}

showi() {
        if [ -z $1 ]
        then
                echo "Usage: showi [NETWORK-INTERFACE]"
        else
                cat /etc/sysconfig/network-scripts/ifcfg-$1
        fi
}

expose() {
        if [ -z $1 ]
        then
                echo "Usage: expose [PORT]"
        else
                sudo firewall-cmd --permanent --add-port=$1/tcp
                sudo firewall-cmd --reload
        fi
}

block() {
        if [ -z $1 ]
        then
                echo "Usage: block [PORT]"
        else
                sudo firewall-cmd --permanent --remove-port=$1/tcp
                sudo firewall-cmd --reload
        fi
}

# Services
alias start="systemctl start"
alias stop="systemctl stop"
alias status="systemctl status"
alias restart="systemctl restart"
alias enable="systemctl enable"
alias disable="systemctl disable"
alias services="systemctl list-units -t service"
alias jc=journalctl

# Minikube
alias mk=minikube
alias kubectl="minikube kubectl --"

# Kubernetes
alias pods="kubectl get po"
alias events="kubectl get events --sort-by=.metadata.creationTimestamp"
alias kc=kubectl
source <(kubectl completion zsh 2>/dev/null)

apply() {
  if [ -z $1 ]
  then
        echo "Usage: apply [MANIFEST_FILE]"
  else
        kc apply -f $1
  fi
}

delete() {
  if [ -z $1 ]
  then
        echo "Usage: delete [MANIFEST_FILE]"
  else
        kc delete -f $1
  fi
}

run() {
        if [ -z $1 ] || [ -z $2 ]
        then
                echo "Usage: run [POD_NAME] [COMMAND]"
        else
                kc exec -it $1 -- $(sed 's/[^ ]* *//' <(echo $*))
        fi
}
