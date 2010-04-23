# Use Ubuntu's nicely coloured prompt, with some git magic.
function parse_git_dirty() {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

black_background="\[\033[40m\]"
white="\[\033[1;37m\]"
blue="\[\033[0;34m\]"
yellow="\[\033[1;33m\]"
default_colour="\[\033[0m\]"

# PS1="${black_background}${white}\w${yellow}$(parse_git_branch)${default_colour} "
PS1="${blue}\w${yellow}\$(parse_git_branch)${default_colour} "

export CLICOLOR=1 # Make ls colour its output.
export LESS=-R  # Make less support ANSI colour sequences.
export EDITOR=vi
export RUBYOPT=rubygems # Make Ruby load rubygems without a require.

# Use fancy bash completion.
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

# RVM
if [[ -s /Users/pete/.rvm/scripts/rvm ]] ; then source /Users/pete/.rvm/scripts/rvm ; fi

export PATH=$PATH:~/bin

# Make ack ignore sql dumps.
export ACK_OPTIONS=--nosql
