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
# Paths
#=====================================================================================================
# cargo
[ -d $HOME/.cargo ] && . "$HOME/.cargo/env"
export PATH="$HOME/.local/bin:$PATH"


#=====================================================================================================
# Extensions
#=====================================================================================================
# powerlevel10k
if [[ ! -d ~/.zsh/plugins/powerlevel10k ]]; then
    [[ ! -d ~/.zsh/plugins ]] && mkdir -p ~/.zsh/plugins
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/plugins/powerlevel10k
fi
source ~/.zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh

# command plugins
function check_plugin() {
    if [[ ! -f ~/.zsh/plugins/"$1"/"$1".zsh ]]; then
        [[ ! -d ~/.zsh/plugins ]] && mkdir -p ~/.zsh/plugins
        git clone --depth=1 https://github.com/zsh-users/"$1".git ~/.zsh/plugins/"$1"
    fi
    source ~/.zsh/plugins/"$1"/"$1".zsh
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
# Aliases & Keybindings
#=====================================================================================================

bindkey -v
bindkey -s 'jj' '\e'

alias tv='tmux split-window -v'
alias th='tmux split-window -h'
alias ta='tmux attach -t'
command -v exa &> /dev/null && alias ls='exa --icons'
command -v z &> /dev/null && alias cd="z"
command -v batcat &> /dev/null && alias cat="batcat"

