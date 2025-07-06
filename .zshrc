# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#=====================================================================================================
# History
#=====================================================================================================
HISTORY_IGNORE="(ls|l|ll|cd|pwd|exit|vim|.|..|...)"
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_find_no_dups
setopt hist_save_no_dups
setopt hist_verify
setopt hist_reduce_blanks
setopt share_history
setopt append_history


#=====================================================================================================
# Extensions
#=====================================================================================================
# cargo
[ -d $HOME/.cargo ] && . "$HOME/.cargo/env"

# powerlevel10k
if [[ ! -d ~/.zsh/powerlevel10k ]]; then
    [[ ! -d ~/.zsh/plugins ]] && mkdir -p ~/.zsh/plugins
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/plugins/powerlevel10k
fi
source ~/.zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme

# command plugins
function check_plugin() {
    if [[ ! -f ~/.zsh/plugins/"$1"/"$1".zsh ]]; then
        [[ ! -d ~/.zsh/plugins ]] && mkdir -p ~/.zsh/plugins
        git clone --depth=1 https://github.com/zsh-users/"$1".git ~/.local/share/zsh/plugins/"$1"
    fi
    source ~/.local/share/zsh/plugins/"$1"/"$1".zsh
}

check_plugin zsh-syntax-highlighting
check_plugin zsh-autosuggestions
check_plugin zsh-history-substring-search

unset -f check_plugin

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zoxide
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"


#=====================================================================================================
# Aliases
#=====================================================================================================

alias tv='tmux split-window -v'
alias th='tmux split-window -h'
alias ls='exa --icons'
alias ta='tmux attach -t'

export TERM=xterm-256color

_z_cd() {
    cd "$@" || return "$?"

    if [ "$_ZO_ECHO" = "1" ]; then
        echo "$PWD"
    fi
}

z() {
    if [ "$#" -eq 0 ]; then
        _z_cd ~
    elif [ "$#" -eq 1 ] && [ "$1" = '-' ]; then
        if [ -n "$OLDPWD" ]; then
            _z_cd "$OLDPWD"
        else
            echo 'zoxide: $OLDPWD is not set'
            return 1
        fi
    else
        _zoxide_result="$(zoxide query -- "$@")" && _z_cd "$_zoxide_result"
    fi
}

zi() {
    _zoxide_result="$(zoxide query -i -- "$@")" && _z_cd "$_zoxide_result"
}


alias za='zoxide add'

alias zq='zoxide query'
alias zqi='zoxide query -i'

alias zr='zoxide remove'
zri() {
    _zoxide_result="$(zoxide query -i -- "$@")" && zoxide remove "$_zoxide_result"
}


_zoxide_hook() {
    zoxide add "$(pwd -L)"
}

chpwd_functions=(${chpwd_functions[@]} "_zoxide_hook")
