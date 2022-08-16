#asdf direnv install hook
eval "$(/Users/kunthar/.asdf/shims/direnv hook bash)"
export GREP_OPTIONS='--color=always'

#kunthar PAT flux needed
export GITHUB_TOKEN=sure_it_is_revealed_;__;

# Disable auto update of brew
export HOMEBREW_NO_AUTO_UPDATE=1

# cowsay Acme not found fix
eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"


#Powerline settings
export LC_ALL=en_US.UTF-8
#export PATH="$PATH:$HOME/Library/Python/3.9/bin"

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
source $HOME/Library/Python/3.9/lib/python/site-packages/powerline/bindings/bash/powerline.sh

# https://github.com/phiresky/ripgrep-all 
# fzf addon

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

rga-fzf() {
	RG_PREFIX="rga --files-with-matches"
	local file
	file="$(
		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
				--phony -q "$1" \
				--bind "change:reload:$RG_PREFIX {q}" \
				--preview-window="70%:wrap"
	)" &&
	echo "opening $file" &&
	xdg-open "$file"
}

# Cowsay check if lose Acme Perl module
/opt/homebrew/bin/fortune -s | /opt/homebrew/bin/cowsay -f "$(ls /opt/homebrew/share/cows | /opt/homebrew/bin/gshuf -n 1)" |  /opt/homebrew/bin/lolcat

alias mem="top -l 1 -s 0 | grep PhysMem"

export GRAPHVIZ_DOT=/opt/local/bin/dot

alias buzz_dude="fortune -s | /opt/homebrew/bin/cowsay  -f "$(ls  /opt/homebrew/share/cows | /opt/homebrew/bin/gshuf  -n 1)" | lolcat"
alias fl_run='flask run -h localhost'
alias hava="curl -4 http://wttr.in/Izmir"
alias flushdns='dscacheutil -flushcache;sudo killall -HUP mDNSResponder;say flushed'
alias show_netstat_apps="sudo lsof -i -n -P | grep TCP"
alias show_netstat_ports="sudo lsof -iTCP -sTCP:LISTEN -n -P"
alias show_3rdparty_kernel_modules="kextstat | grep -v com.apple"
alias goerl='cd ~/development/erlang'
alias netstat_osx="sudo lsof -i -P"
#alias tar='gnutar'
alias ls='ls -GF'
alias godev='cd ~/development/'
alias ll='ls -Gal'
alias l='ls -GalH'
alias rmds='find . -name '*.DS_Store' -type f -delete'
alias ggrep='grep -irs --colour '
alias gbr='git branch'
alias gbra='git branch -a'
alias gst='git status'
alias cal='paste <(cal 2019) <(cal 2020)'
alias vm_start='VBoxManage startvm containers --type headless'
alias crontab="VIM_CRONTAB=true crontab"
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias k=/Users/kunthar/.asdf/shims/kubectl

#Functions section 


function KubeDelete(){
    
    kubectl config view --minify | grep namespace
    echo "Check if namespace is correct, if so, write it down again!"
    read -r NSVAR
    echo "Define sub type to delete. Warning, all of selected type items will be totally deleted! You can ctrl+c"
    read -r SUBTYPE

    if [[  -n "$NSVAR" ]]; then
            echo "Setting namespace..."
            echo "NSVAR is:  $NSVAR"
            /Users/kunthar/.asdf/shims/kubectl config set-context --current  --namespace $NSVAR
           echo "Executing with given sub type: $SUBTYPE" 
           /Users/kunthar/.asdf/shims/kubectl delete $SUBTYPE $(kubectl get $SUBTYPE | awk 'NR >= 2  { print $1 }')
    else
        echo "Doin notin bruh, empty namespace"
    fi
}

function ff(){
    sudo /usr/bin/find . -iname "$1"
}


function dis(){

  docker images | awk '{print $7}'| sort -h | awk '$0 ~ /[0-9.]+GB/ { $0 = int($0 * 1000) "MB" }1' | awk '$0 ~ /[0-9.]+kB/ {$0= int($0/1000)"MB"}1' | sed 's/[MGk]B//g' | awk '{sum+=$0;} END{print sum/1000 " GB"; print sum " MB"; print sum*1000 " kB"}'

}

function BytesToHuman() {
    read StdIn

    b=${StdIn:-0}; d=''; s=0; S=(Bytes {K,M,G,T,E,P,Y,Z}iB)
    while ((b > 1024)); do
        d="$(printf ".%02d" $((b % 1024 * 100 / 1024)))"
        b=$((b / 1024))
        let s++
    done
    echo "$b$d ${S[$s]}"

} # BytesToHuman ()


function docker_kill_and_rm() {
   /usr/local/bin/docker kill $1 && /usr/local/bin/docker rm $1

}

function jcurl() {
    curl "$@" | json_pp | pygmentize -l json;
}

export -f jcurl

function auth_jcurl() {
    curl -H "Accept: application/json" -H "Content-Type: application/json" -H "X-User-Email: $1" -H "X-User-Token: $2" ${@:3} | json_pp | pygmentize -l json;

}

export -f auth_jcurl

function netstat_show_by_port() { sudo lsof -iTCP:"$@" -sTCP:LISTEN ;}

export HISTCONTROL=erasedups
export HISTSIZE=9000000
export HISTFILESIZE=9000000
shopt -s histappend

function gco() { git checkout "$@" ;}

#export PS1="[\u@\h \w]\\
#export PS1="[\u@\h \w]\\$

export PS1="\[\e[38;05;24m\]______________________________________________\n\[\e[38;05;33m\] \w \n λ \u : \[\e[0m\]"

[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

#export PATH=/Users/kunthar/Library/Android/sdk/platform-tools/:$PATH
export PATH=/usr/local/bin:$PATH

#caf path added
export PATH=$PATH:/usr/local/include/caf/

export PATH=$PATH:/Users/kunthar/development/apps
#export PATH=$PATH:/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin/

export PATH=/Users/kunthar/development/apps/plantum:$PATH
export PATH=/usr/local/include/:$PATH
export PATH=/usr/local/include/:$PATH:/Users/kunthar/development/cloudz/kubermatic/kubeone/


export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
export PATH=/opt/homebrew/Cellar/perl/5.34.0/lib/perl5/site_perl/5.34.0/Acme/:/opt/homebrew/Cellar/perl/5.34.0/bin/:$PATH

#export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

   # Set config variables first
   #GIT_PROMPT_ONLY_IN_REPO=1

   # GIT_PROMPT_FETCH_REMOTE_STATUS=0   # uncomment to avoid fetching remote status
   # GIT_PROMPT_IGNORE_SUBMODULES=1 # uncomment to avoid searching for changed files in submodules

   # GIT_PROMPT_SHOW_UPSTREAM=1 # uncomment to show upstream tracking branch
   # GIT_PROMPT_SHOW_UNTRACKED_FILES=all # can be no, normal or all; determines counting of untracked files

   # GIT_PROMPT_SHOW_CHANGED_FILES_COUNT=0 # uncomment to avoid printing the number of changed files

   # GIT_PROMPT_STATUS_COMMAND=gitstatus_pre-1.7.10.sh # uncomment to support Git older than 1.7.10

   # GIT_PROMPT_START=...    # uncomment for custom prompt start sequence
   # GIT_PROMPT_END=...      # uncomment for custom prompt end sequence

   # as last entry source the gitprompt script
   # GIT_PROMPT_THEME=Custom # use custom theme specified in file GIT_PROMPT_THEME_FILE (default ~/.git-prompt-colors.sh)
   # GIT_PROMPT_THEME_FILE=~/.git-prompt-colors.sh
   #GIT_PROMPT_THEME=Solarized # use theme optimized for solarized color scheme
   #source /Users/kunthar/work/zetaops/repos/github/.bash-git-prompt/gitprompt.sh

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# asdf setup
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

export ASDFROOT=$HOME/.asdf
export ASDFINSTALLS=$HOME/.asdf/installs

. ~/.asdf/plugins/java/set-java-home.bash

export GOPATH=$(go env GOPATH)
export PATH="$PATH:$(go env GOPATH)/bin"


## bash it additions 
# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

#flutter web browser setup
export CHROME_EXECUTABLE='/Applications/Brave Browser.app/Contents/MacOS/Brave Browser'

## Path to the bash it configuration
export BASH_IT="/Users/kunthar/.bash_it"
#
## Lock and Load a custom theme file.
## Leave empty to disable theming.
## location /.bash_it/themes/

export BASH_IT_THEME='zork'

#
## Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
#export SDKMAN_DIR="/Users/kunthar/.sdkman"
#[[ -s "/Users/kunthar/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/kunthar/.sdkman/bin/sdkman-init.sh"

#export PATH="$HOME/.poetry/bin:$PATH"

export PATH="/usr/local/opt/python/libexec/bin:$PATH"

#export ANDROID_HOME=/Users/$USER/Library/Android/sdk
#export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

#kubectl asdf plugin kubectl!!! 
source <(kubectl completion bash)


[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# Helper function loading various enable-able files
function _load_bash_it_files() {

  subdirectory="$1"

  if [ ! -d "${BASH_IT}/${subdirectory}/enabled" ]
  then
    continue
  fi
  FILES="${BASH_IT}/${subdirectory}/enabled/*.bash"
  for config_file in $FILES
  do
    echo ${config_file}

    if [ -e "${config_file}" ]; then
      time source $config_file
    fi
  done
}

# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="/usr/local/opt/curl/bin:/usr/local/opt/cython/bin:$PATH:"

#psql client library without postgresql added
export PATH="$PATH:/opt/homebrew/opt/libpq/bin"


export PATH="/usr/local/sbin:$PATH"
export PATH="/opt/homebrew/opt/python@3.10/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Volumes/flash/development/cloudz/google-cloud-sdk/path.bash.inc' ]; then . '/Volumes/flash/development/cloudz/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Volumes/flash/development/cloudz/google-cloud-sdk/completion.bash.inc' ]; then . '/Volumes/flash/development/cloudz/google-cloud-sdk/completion.bash.inc'; fi

## Load Bash It
source "$BASH_IT"/bash_it.sh
