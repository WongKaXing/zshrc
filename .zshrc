
# ------------------------------
# oh-my-zsh
# ------------------------------

export ZSH="/Users/soc/.oh-my-zsh"
ZSH_THEME=""

plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
)

fpath=(~/.zsh/completions $fpath)
source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"

# ------------------------------
# PATH
# ------------------------------

# homebrew
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

# npm
export PATH="$HOME/.npm-global/bin:$PATH"

# python / pipx
export PATH="/opt/homebrew/opt/python@3.12/libexec/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"

# nvim
export EDITOR="/opt/homebrew/bin/nvim"

# zip2john
export PATH="/opt/homebrew/bin:$PATH"

# sqlmap
export PATH="/opt/homebrew/bin:$PATH"
export SQLMAP_OUTPUT="/Users/soc/Documents/Sqlmap/output"

# clash proxy (仅在代理处于活动状态时设置，否则curl会超时挂起))
if lsof -i :7897 -sTCP:LISTEN -t >/dev/null 2>&1; then
	export https_proxy=http://127.0.0.1:7897
	export http_proxy=http://127.0.0.1:7897
	export all_proxy=socks5://127.0.0.1:7897
fi


# ------------------------------
# Tool Initialization
# ------------------------------

source <(fzf --zsh)
eval "$(zoxide init zsh)"


# ------------------------------
# Aliases
# ------------------------------

alias a='yazi'
alias ba='brew update && brew upgrade && brew cleanup'
alias bc='echo "bc is disabled. Use \bc if you really need it."'
alias cld='claude --settings ~/.claude/settings.deepseek.json --permission-mode bypassPermissions'
alias clm='claude --settings ~/.claude/settings.mimo.json --permission-mode bypassPermissions'
alias clk='claude --settings ~/.claude/settings.kimi.json --permission-mode bypassPermissions'
alias cls='clear'
alias com='docker compose up -d'
alias cp='cp -r'
alias cy='docker compose -f ~/Documents/Docker/cyberchef/docker-compose.yml up -d'
alias cyst='docker stop cyberchef'
alias cz='cat ~/.zshrc'
alias dv='docker compose -f ~/Documents/Docker/dvwa/docker-compose.yml up -d'
alias dvst='docker stop dvwa dvwadb'
alias e='exit'
alias f='fzf'
alias icat='kitty +kitten icat'
alias images='docker images'
alias la='eza -la --icons --group-directories-first'
alias lg='lazygit'
alias ll='eza -lAh --icons --group-directories-first | sed "s/^/   /"'
alias ls='eza -x --icons --group-directories-first'
alias lt='eza --tree --icons'
alias nv='nvim'
alias nvc='nv ~/.claude.json'
alias nvk='nv ~/.config/kitty/kitty.conf'
alias nvz='nv ~/.zshrc'
alias op='open .'
alias pa='docker ps -a'
alias pan='docker compose -f ~/Documents/Docker/1panel/docker-compose.yml up -d'
alias panst='docker stop 1panel 1panelmysql'
alias pika='docker compose -f ~/Documents/Docker/pikachu/docker-compose.yml up -d'
alias pikast='docker stop pikachu pikadb'
alias pss='docker ps'
alias pyrun='uv run python'
alias re='sudo reboot'
alias rr='rm -rf'
alias rra='rm -rf *'
alias rrd='find . -name ".DS_Store" -type f -delete'
alias rrm='rm -rf main.py'
alias rrg='rm -rf .git'
alias xf='sudo xattr -rd com.apple.quarantine '
# sqlmap 通用前缀：清除代理
_sqlmap_unset='unset all_proxy HTTP_PROXY http_proxy HTTPS_PROXY https_proxy'
# sqlmap 别名（全部带 unset，VPN 开关均可使用）
alias sql="$_sqlmap_unset && sqlmap --batch"
alias soud='deactivate'
alias souk='clear && kitten @ load-config'
alias soup='source ./.venv/bin/activate'
alias souz='clear && source ~/.zshrc'
alias ssh='kitty +kitten ssh'
alias targz='tar xzvf'
alias te='tree'


# ------------------------------
# 功能
# ------------------------------

# yazi: cd to selected directory on exit
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/soc/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
