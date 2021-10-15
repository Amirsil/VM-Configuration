# Source global definitions
if [ -f /etc/bashrc ]; then
				. /etc/bashrc
fi

alias py=python
alias la="ls -lAh"
alias sl=ls

alias start="systemctl start"
alias stop="systemctl stop"
alias status="systemctl status"
alias restart="systemctl restart"
alias enable="systemctl enable"
alias disable="systemctl disable"
alias services="systemctl list-units -t service"

alias pods="kubectl get po"
alias watch="watch -n 1 "
alias events="kubectl get events --sort-by=.metadata.creationTimestamp"
alias kc=kubectl
alias jc=journalctl
alias ka=kubeadm
alias mk=minikube
alias ipa="ip -brief a"
alias ports="sudo firewall-cmd --list-all | grep -G '\sports:\s'"
source <(kubectl completion bash 2>/dev/null)

# Using minikube
alias kubectl="minikube kubectl --"

# Custom bash prompt configuration
source ~/pureline/pureline ~/.pureline.conf

function run() {
	if [ -z $1 ] || [ -z $2 ]
	then
		echo Usage: run [POD_NAME] [COMMAND]
	else
		kc exec -it $1 -- $(sed 's/[^ ]* *//' <(echo $*))
	fi
}

function arg() {
	if [ -z $1 ]
	then
		echo "Usage: arg [ARG_NUMBER]"
	else
		awk -v arg="$1" '{print $arg}'
	fi
}

function editi() {
	if [ -z $1 ]
	then
		echo Usage: editi [NETWORK-INTERFACE]
	else
		vim /etc/sysconfig/network-scripts/ifcfg-$1
	fi
}

function showi() {
	if [ -z $1 ]
	then
		echo Usage: showi [NETWORK-INTERFACE]
	else
		cat /etc/sysconfig/network-scripts/ifcfg-$1
	fi
}
function expose() {
	if [ -z $1 ]
	then
		echo Usage: expose [PORT]
	else
		sudo firewall-cmd --permanent --add-port=$1/tcp
		sudo firewall-cmd --reload
	fi
}
function block() {
	if [ -z $1 ]
	then
		echo Usage: block [PORT]
	else
		sudo firewall-cmd --permanent --remove-port=$1/tcp
		sudo firewall-cmd --reload
	fi
}
