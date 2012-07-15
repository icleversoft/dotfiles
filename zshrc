autoload colors; colors;
setopt prompt_subst

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%b%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="*"              # Text to display if the branch is dirty
ZSH_THEME_GIT_PROMPT_CLEAN=""               # Text to display if the branch is clean

# get the name of the branch we are on
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

parse_git_dirty () {
  if [[ -n $(git status -s 2> /dev/null) ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

PROMPT='%{$fg[blue]%}%~%{$reset_color%}$(git_prompt_info) '

function rbenv_prompt_info() {
  rbenv version | sed "s/^\([^ ]*\).*$/\1/"
}

RPROMPT='%{$fg[yellow]%}$(rbenv_prompt_info)%{$reset_color%}'

# Completion.

autoload -U compinit
compinit -i

# History.
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY

# Customize to your needs...
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin:~/.bin

# rbenv
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"

# A few useful aliases:
alias be="bundle exec"
alias gf="git fetch"
alias gco="git checkout"
alias gm="git merge --no-ff"
alias gff="git merge --ff-only"

# We use the full path here to work around this nasty bug: http://www.tpope.net/node/108
# In particular, calling "filetype indent off" in my vimrc was causing vim to
# always exit with a non-zero status. Very annoying for git commit.
export EDITOR=/usr/bin/vim

export CLICOLOR=1                                         # Make ls colour its output.
export LESS=-R                                            # Make less support ANSI colour sequences.
# export RUBYOPT=rubygems                                   # Make Ruby load rubygems without a require.
export ACK_OPTIONS="--nosql --type-set cucumber=.feature --type-set sass=.sass" # Make ack ignore sql dumps, and search cucumber features.

# Set Java home, and hope we never use it.
# export JAVA_HOME=`/usr/libexec/java_home`

export RAILS_CACHE_CLASSES=true
