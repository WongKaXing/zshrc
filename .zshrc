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

# starship
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

 # fzf
source <(fzf --zsh)
 # zoxide
eval "$(zoxide init zsh)"


# ------------------------------
# Aliases
# ------------------------------

# claude
alias cld='claude --settings ~/.claude/settings.deepseek.json --permission-mode bypassPermissions'
alias clk='claude --settings ~/.claude/settings.kimi.json --permission-mode bypassPermissions'
alias clm='claude --settings ~/.claude/settings.mimo.json --permission-mode bypassPermissions'
alias clw='claude --settings ~/.claude/settings.qwen.json --permission-mode bypassPermissions'

# docker
alias com='docker compose up -d'
alias cy='docker compose -f ~/Documents/Docker/cyberchef/docker-compose.yml up -d'
alias cyst='docker stop cyberchef'
alias dv='docker compose -f ~/Documents/Docker/dvwa/docker-compose.yml up -d'
alias dvst='docker stop dvwa dvwadb'
alias images='docker images'
alias pa='docker ps -a'
alias pan='docker compose -f ~/Documents/Docker/1panel/docker-compose.yml up -d'
alias panst='docker stop 1panel 1panelmysql'
alias pika='docker compose -f ~/Documents/Docker/pikachu/docker-compose.yml up -d'
alias pikast='docker stop pikachu pikadb'
alias pss='docker ps'

# eza
alias la='eza -la --icons --group-directories-first'
alias ll='eza -lAh --icons --group-directories-first | sed "s/^/   /"'
alias ls='eza -x --icons --group-directories-first'
alias lt='eza --tree --icons'


# homebrew
alias ba='brew update && brew upgrade && brew cleanup'
alias bc='echo "bc is disabled. Use \bc if you really need it."'

# lazygit
alias lg='lazygit'

# system
alias cls='clear'
alias cp='cp -r'
alias cz='cat ~/.zshrc'
alias e='exit'
alias f='fzf'
alias icat='kitty +kitten icat'
alias nv='nvim'
alias nvc='nv ~/.claude.json'
alias nvk='nv ~/.config/kitty/kitty.conf'
alias nvz='nv ~/.zshrc'
alias op='open .'
alias re='sudo reboot'
alias rr='rm -rf'
alias rra='rm -rf *'
alias rrd='find . -name ".DS_Store" -type f -delete'
alias rrm='rm -rf main.py'
alias rrg='rm -rf .git'
alias xf='sudo xattr -rd com.apple.quarantine '
alias soud='deactivate'
alias souk='clear && kitten @ load-config'
alias soup='source ./.venv/bin/activate'
alias souz='clear && source ~/.zshrc'
alias ssh='kitty +kitten ssh'
alias targz='tar xzvf'
alias te='tree'
alias zc='cd ~/.config'
alias zz='z -'

# sqlmap
# sqlmap 通用前缀：清除代理
_sqlmap_unset='unset all_proxy HTTP_PROXY http_proxy HTTPS_PROXY https_proxy'
# sqlmap 别名（全部带 unset，VPN 开关均可使用）
alias sql="$_sqlmap_unset && sqlmap --batch"

# uv
alias pyrun='uv run python'

# yazi
alias a='yazi'


# ------------------------------
# Function
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
