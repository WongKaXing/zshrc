# p10k prompt
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# ------------------------------
# oh-my-zsh
# ------------------------------

export ZSH="/Users/soc/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh


# ------------------------------
# PATH
# ------------------------------

# homebrew
export PATH="/opt/homebrew/bin:$PATH"

# npm
export PATH="$HOME/.npm-global/bin:$PATH"

# python / pipx
export PATH="$PATH:/opt/homebrew/bin/python3"
export PATH="$PATH:$HOME/.local/bin"


# ------------------------------
# Environment Variables
# ------------------------------

export EDITOR="/opt/homebrew/bin/nvim"

# clash proxy
export https_proxy=http://127.0.0.1:7897
export http_proxy=http://127.0.0.1:7897
export all_proxy=socks5://127.0.0.1:7897


# ------------------------------
# Tool Initialization
# ------------------------------

source <(fzf --zsh)
eval "$(uv generate-shell-completion zsh)"
eval "$(zoxide init zsh)"


# ------------------------------
# Aliases
# ------------------------------

alias a='yazi'
alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'
alias b='brew'
alias ba='brew upgrade && brew update && brew cleanup'
alias bc='echo "bc is disabled. Use \bc if you really need it."'
alias cld='claude --settings ~/.claude/settings.deepseek.json --permission-mode bypassPermissions'
alias clk='claude --settings ~/.claude/settings.kimi.json --permission-mode bypassPermissions'
alias cp='cp -r'
alias cs='clear'
alias cz='cat ~/.zshrc'
alias e='exit'
alias f='fzf'
alias g='git'
alias gc='git clone'
alias gdd='git add .'
alias gmm='git commit -m'
alias gs='git status'
alias icat='kitty +kitten icat'
alias la='eza -lAh --icons --group-directories-first | sed "s/^/   /"'
alias lg='lazygit'
alias ll='eza -la --icons --group-directories-first'
alias ls='eza -x --icons --group-directories-first'
alias lt='eza --tree --icons'
alias m3d='/Users/soc/Downloads/m3u8-downloader -sp=/Users/soc/Downloads'
alias mm='cd /Users/soc/Library/Application\ Support/MarkMind'
alias ne='neofetch'
alias nv='nvim'
alias nv.='nvim .'
alias nvc='nv ~/.claude.json'
alias nvk='nv ~/.config/kitty/kitty.conf'
alias nvz='nv ~/.zshrc'
alias op='open .'
alias pip='pip3'
alias pr='uv run python'
alias py='python3'
alias pye='deactivate'
alias re='sudo reboot'
alias rfmm='rm -rf /Users/soc/Library/Application\ Support/MarkMind'
alias rr='rm -rf'
alias rra='rm -rf *'
alias rrd='find . -name ".DS_Store" -type f -delete'
alias rrg='rm -rf .git'
alias souk='kitten @ load-config'
alias soup='source ./.venv/bin/activate'
alias souz='clear && source ~/.zshrc'
alias ssh='kitty +kitten ssh'
alias targz='tar xzvf'
alias te='tree'
alias upip='uv pip install'


# ------------------------------
# Functions
# ------------------------------

# yazi: cd to selected directory on exit
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
