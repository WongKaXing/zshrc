# ------------------------------
# oh-my-zsh
# ------------------------------

export ZSH="/Users/soc/.oh-my-zsh"
ZSH_THEME=""

plugins=(
	zsh-autosuggestions
	zsh-syntax-highlighting
)

fpath=(~/.zsh/completions $fpath)
source $ZSH/oh-my-zsh.sh

# vi mode
# bindkey -v
# setopt nobeep

# starship
eval "$(starship init zsh)"

# ------------------------------
# PATH
# ------------------------------

# homebrew
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

# java
export JAVA_HOME="/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"

# npm
export PATH="$HOME/.npm-global/bin:$PATH"

# nvim
export EDITOR="/opt/homebrew/bin/nvim"

# python / pipx
export PATH="/opt/homebrew/opt/python@3.12/libexec/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"

# sqlmap
export SQLMAP_OUTPUT="/Users/soc/Documents/Sqlmap/output"

# ------------------------------
# Environment
# ------------------------------

# clash proxy (仅在代理处于活动状态时设置，否则curl会超时挂起)
if lsof -i :7897 -sTCP:LISTEN -t >/dev/null 2>&1; then
	export https_proxy=http://127.0.0.1:7897
	export http_proxy=http://127.0.0.1:7897
	export all_proxy=socks5://127.0.0.1:7897
fi

# Fix terminal type for yazi and other TUI apps
export TERM=xterm-256color

# ------------------------------
# Tool Initialization
# ------------------------------

# fzf
source <(fzf --zsh)

# lazygit
# (no init needed, just alias)

# zoxide
eval "$(zoxide init zsh)"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Docker Desktop completions
fpath=(/Users/soc/.docker/completions $fpath)
autoload -Uz compinit
compinit

# ------------------------------
# Aliases
# ------------------------------

# --- system ---
alias a='yazi'
alias cls='clear'
alias cp='cp -r'
alias cz='cat ~/.zshrc'
alias cpz='cp -r ~/.zshrc ~/Documents/Git/zshrc/'
alias e='exit'
alias f='fzf'
alias fa='clear && LC_TIME=en_US.UTF-8 fastfetch'
alias imgo='immich-go upload from-folder -s http://100.67.58.98:2283 -k 8khNazoGsUgcF696qc8bRJFyPtNBe9BDYTvWlZWXY --manage-heic-jpeg StackCoverHEIC ~/Pictures/Photos\ Library.photoslibrary'
alias la='eza -la --icons --group-directories-first'
alias ll='eza -lAh --icons --group-directories-first | sed "s/^/   /"'
alias ls='eza -x --icons --group-directories-first'
alias lt='eza --tree --icons'
alias nv='nvim'
alias nvz='nv ~/.zshrc'
alias op='open .'
alias re='sudo reboot'
alias rr='rm -rf'
alias rra='rm -rf *'
alias rrd='find . -name ".DS_Store" -type f -delete'
alias rrm='rm -rf main.py'
alias rrg='rm -rf .git'
alias souz='clear && source ~/.zshrc'
alias sql="unset all_proxy HTTP_PROXY http_proxy HTTPS_PROXY https_proxy && sqlmap --batch"
alias targz='tar xzvf'
alias te='tree'
alias xf='sudo xattr -rd com.apple.quarantine '
alias zc='cd ~/.config'
alias zd='cd /tmp && cld'
alias zm='cd /tmp'
alias zz='z -'
alias zcl='cd ~/.claude'

# --- claude ---
alias cc='current=$(claude --version | awk "{print \$1}"); latest=$(npm view @anthropic-ai/claude-code version); [ "$current" = "$latest" ] && echo "✅ Claude Code 已是最新 ($current)" || echo "⬆️ 有新版: $latest (当前: $current) → npm i -g @anthropic-ai/claude-code@latest"'
alias cld='claude --settings ~/.claude/settings.deepseek.json --permission-mode bypassPermissions'
alias clk='claude --settings ~/.claude/settings.kimi.json --permission-mode bypassPermissions'
alias clm='claude --settings ~/.claude/settings.mimo.json --permission-mode bypassPermissions'
alias clw='claude --settings ~/.claude/settings.qwen.json --permission-mode bypassPermissions'
alias nvc='nv ~/.claude.json'

# --- docker (local) ---
# 系统级
alias dcom='docker compose up -d'
alias dim='docker images'
alias dps='docker ps --format "table {{.Names}} {{.Ports}}"'
alias dpsa='docker ps -a'


# cyberchef
alias cy='docker compose -f ~/Documents/Docker/cyberchef/docker-compose.yml up -d'
alias cyst='docker stop cyberchef'

# dockge
alias dg='docker compose -f ~/Documents/Docker/dockge/docker-compose.yml up -d'
alias dgst='docker stop dockge'

# dvwa
alias dv='docker compose -f ~/Documents/Docker/dvwa/docker-compose.yml up -d'
alias dvst='docker stop dvwa dvwadb'

# pikachu
alias pika='docker compose -f ~/Documents/Docker/pikachu/docker-compose.yml up -d'
alias pikast='docker stop pikachu pikadb'

# --- docker (Debian remote) ---
alias dcom='ssh debian "cd ~/docker && docker-compose"'
alias ddockge="ssh -f -N -L 5001:localhost:5001 debian 2>/dev/null; open http://localhost:5001"


# --- git ---
alias ga='git add .'
alias gm='git commit -m'
alias gpe='git push -u gitee main'
alias gpt='git push -u github main'

# --- homebrew ---
alias ba='brew update && brew upgrade && brew cleanup'
alias bc='echo "bc is disabled. Use \bc if you really need it."'
alias cb='brew cleanup -s && rm -rf ~/Library/Caches/Homebrew/*'

# --- kitty ---
alias icat='kitty +kitten icat'
alias nvk='nv ~/.config/kitty/kitty.conf'
alias souk='clear && kitten @ load-config'
alias ssh='kitty +kitten ssh'

# --- lazygit ---
alias lg='lazygit'

# --- python ---
alias pyrun='uv run python'
alias soud='deactivate'
alias soup='source ./.venv/bin/activate'

# --- rsync (sync) ---
alias gamepush='rsync -avz /Users/soc/Documents/Docker/douyin-game/ soc@100.67.58.98:/home/soc/douyin-game/ -e "ssh -p 2222"'
alias musicsyn="rsync -avz -e \"ssh -p 2222\" soc@100.67.58.98:~/docker/musicn/data/ ~/Music/musicn/"

# --- ssh ---
alias de='ssh -p 2222 soc@100.67.58.98'
alias dlm3u8='ssh soc@100.67.58.98 "/home/soc/bin/dl-m3u8"'
alias geta='scp soc@100.67.58.98:/home/soc/downloads/aria2/'

# ------------------------------
# Function
# ------------------------------

# 让 sudo 支持 alias 展开
sudo() {
  if [[ -n "${aliases[$1]}" ]]; then
    eval "command sudo ${aliases[$1]} \${@:2}"
  elif type "$1" &>/dev/null; then
    command sudo "$@"
  else
    command sudo $(whence -p "$1") "${@:2}"
  fi
}

# yazi: cd to selected directory on exit
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$tmp"
	rm -f -- "$tmp"
}
