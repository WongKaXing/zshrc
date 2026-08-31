# ------------------------------
# oh-my-zsh
# ------------------------------

export ZSH="/Users/soc/.oh-my-zsh"
ZSH_THEME=""
zstyle ':omz:update' mode disabled

plugins=(
	zsh-autosuggestions
	zsh-syntax-highlighting
)

fpath=($ZDOTDIR/completions $fpath)
# Docker completions 必须在 oh-my-zsh (compinit) 之前加载
fpath=($HOME/.config/docker/completions $fpath)
source $ZSH/oh-my-zsh.sh

# vi mode
# bindkey -v
# setopt nobeep

# starship
eval "$(starship init zsh)"

# ------------------------------
# PATH
# ------------------------------

# dsh
export PATH="$HOME/.dsh/bin:$PATH"

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

# obsidian
export PATH="$PATH:/Applications/Obsidian.app/Contents/MacOS"

# python / pipx
export PATH="/opt/homebrew/opt/python@3.12/libexec/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"
export PATH="/Library/Frameworks/Python.framework/Versions/3.12/bin:${PATH}"

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
	# 大写形式（原 .zprofile 无条件设置，合并后改为仅在代理活动时生效）
	export HTTPS_PROXY=http://127.0.0.1:7897
	export HTTP_PROXY=http://127.0.0.1:7897
fi

# Fix terminal type for yazi and other TUI apps
export TERM=xterm-256color

# Homebrew - USTC mirror
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
export HOMEBREW_CASK_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-cask.git"
export HOMEBREW_PIP_INDEX_URL="https://mirrors.ustc.edu.cn/pypi/web/simple"

# XDG / config directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export DOCKER_CONFIG="$HOME/.config/docker"
export PUB_CACHE="$HOME/.local/share/pub-cache"

# API keys（敏感，存于 secrets.zsh，被 .gitignore 排除，不入库）
if [[ -f "$ZDOTDIR/secrets.zsh" ]]; then
	source "$ZDOTDIR/secrets.zsh"
fi

# ------------------------------
# Tool Initialization
# ------------------------------

# docker
# Docker Desktop completions (已在 oh-my-zsh 之前加载 fpath)

# fzf
source <(fzf --zsh)

# lazygit
# (no init needed, just alias)

# nvm (lazy load — 延迟加载，首次使用 node/npm/nvm 时才初始化)
export NVM_DIR="$HOME/.nvm"
lazy_load_nvm() {
  unset -f nvm node npm npx yarn pnpm corepack 2>/dev/null
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}
for cmd in nvm node npm npx yarn pnpm corepack; do
  eval "$cmd() { lazy_load_nvm; $cmd \"\$@\" }"
done

# zoxide
eval "$(zoxide init zsh)"

# ------------------------------
# Aliases
# ------------------------------

# --- system ---
alias a='yazi'
alias au='\
  echo "🍺 [1/4] 更新 Homebrew（系统工具和依赖）..."; \
  ba; \
  echo "----------------------------------------"; \
  echo ""; \
  echo "🟢 [2/4] 更新 Node.js (nvm) 和 npm 全局包..."; \
  lazy_load_nvm; \
  nvm install 22 --reinstall-packages-from=current; \
  nvm alias default 22; \
  npm install -g npm@latest; \
  npm outdated -g; \
  npm update -g; \
  echo "✅ Node: $(node -v), npm: $(npm -v)"; \
  echo "----------------------------------------"; \
  echo ""; \
  echo "🤖 [3/4] 检查并自动更新 Claude Code..."; \
  current=$(claude --version 2>/dev/null | awk "{print \$1}"); \
  latest=$(npm view @anthropic-ai/claude-code version 2>/dev/null); \
  if [ -z "$latest" ]; then \
    echo "⚠️ 无法获取 Claude Code 最新版本（检查网络）"; \
  elif [ "$current" = "$latest" ]; then \
    echo "✅ Claude Code 已是最新 ($current)"; \
  else \
    echo "⬆️ 发现新版: $latest (当前: $current)，正在更新..."; \
    npm install -g @anthropic-ai/claude-code@latest && echo "✅ Claude Code 更新完成"; \
  fi; \
  echo "----------------------------------------"; \
  echo ""; \
  echo "🔍 [4/4] 检查并自动更新 dsh..."; \
  dshup'
alias ch='rr ~/.thumbnails ~/.adobe ~/.ntfstool ~/.playwright-* ~/.dart-tool ~/.immich-photos-sync.log ~/.zsh-defer ~/.cc-switch ~/.claude.json ~/Temp ~/.zcompdump* 2>/dev/null; echo "✅ 已清理无用缓存"'
alias cls='clear'
alias cp='cp -r'
alias cpz='cp -r ~/.config/zsh/.zshrc ~/Documents/Git/zshrc/'
alias cz='cat ~/.config/zsh/.zshrc'
alias e='exit'
alias f='fzf'
alias fa='clear && LC_TIME=en_US.UTF-8 fastfetch'
alias ff='ffmpeg'
alias la='eza -la --icons --group-directories-first'
alias ll='eza -lAh --icons --group-directories-first | sed "s/^/   /"'
alias ls='eza -x --icons --group-directories-first'
alias lt='eza --tree --icons'
alias nv='nvim'
alias nvz='nv ~/.config/zsh/.zshrc'
alias op='open .'
alias re='sudo reboot'
alias rr='rm -rf'
alias rra='rm -rf *'
alias rrd='find . -name ".DS_Store" -type f -delete'
alias rrg='rm -rf .git'
alias rrm='rm -rf main.py'
alias souz='clear && source ~/.config/zsh/.zshrc'
alias sql="unset all_proxy HTTP_PROXY http_proxy HTTPS_PROXY https_proxy && sqlmap --batch"
alias targz='tar xzvf'
alias te='tree'
alias xf='sudo xattr -rd com.apple.quarantine '
alias zc='cd ~/.config'
alias zcl='cd ~/.claude'
alias zd='cd /tmp && cld'
alias zm='cd /tmp'
alias zz='z -'

# --- aibalance ---
alias aibre='cd /Users/soc/Documents/ClaudeDevelopment/AIBalanceApp/AIBalanceApp_macOS_v1.0.2 && killall AIBalanceApp 2>/dev/null; xcodebuild -scheme AIBalanceApp -configuration Release -destination "platform=macOS" -derivedDataPath /tmp/aibuild build && rm -rf /Applications/AIBalanceApp.app && ditto /tmp/aibuild/Build/Products/Release/AIBalanceApp.app /Applications/AIBalanceApp.app && open /Applications/AIBalanceApp.app'

# --- claude ---
alias cc='current=$(claude --version | awk "{print \$1}"); latest=$(npm view @anthropic-ai/claude-code version); [ "$current" = "$latest" ] && echo "✅ Claude Code 已是最新 ($current)" || echo "⬆️ 有新版: $latest (当前: $current) → npm i -g @anthropic-ai/claude-code@latest"'
alias clc='claude --settings ~/.claude/settings.chatgpt.json --permission-mode bypassPermissions'
alias cld='claude --settings ~/.claude/settings.deepseek.json --permission-mode bypassPermissions'
alias clk='claude --settings ~/.claude/settings.kimi.json --permission-mode bypassPermissions'
alias clm='claude --settings ~/.claude/settings.mimo.json --permission-mode bypassPermissions'
alias clmc='claude --settings ~/.claude/settings.mimo-chen.json --permission-mode bypassPermissions'
alias clw='claude --settings ~/.claude/settings.qwen.json --permission-mode bypassPermissions'
alias nvc='nv ~/.claude.json'

# --- dsh ---
alias dshde='ssh -f -N -L 3081:localhost:3080 debian'
alias dshh='dsh --profile headless'
alias dshre='lsof -tiTCP:3080 -sTCP:LISTEN | xargs kill 2>/dev/null; for i in {1..20}; do lsof -tiTCP:3080 -sTCP:LISTEN >/dev/null 2>&1 || break; sleep 0.5; done; nohup dsh web >/tmp/dsh-web.log 2>&1 & disown; echo "✅ dsh web 已重启 → http://localhost:3080"'
alias dshst='lsof -tiTCP:3080 -sTCP:LISTEN | xargs kill 2>/dev/null'
alias dshsync='rsync -avz -e "ssh -p 2222" ~/.dsh/ soc@100.67.58.98:~/.dsh/ --exclude sessions --exclude data --include "storages/dsh_memory.json" --exclude "storages/*" --exclude profiles/web/node_modules --exclude profiles/node_modules --exclude .anonymous-user-id --exclude .DS_Store && echo "✅ dsh 配置已同步到 Debian"'
alias dshup='installed=$(dsh --version 2>/dev/null); latest=$(npm view @deepseek-ai/dsh version 2>/dev/null); if [ -z "$latest" ]; then echo "⚠️ 无法获取最新版本（检查网络）"; elif [ "$installed" = "$latest" ]; then echo "✅ dsh 已是最新 ($installed)"; else echo "⬆️ 发现新版: $latest (当前: $installed)，正在更新..."; npm install -g @deepseek-ai/dsh@latest && echo "✅ 更新完成: $(dsh --version)；重启 web 生效: dshre"; fi'
alias dshw='nohup dsh web >/tmp/dsh-web.log 2>&1 & disown; echo "DSH Web UI → http://localhost:3080"'

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
alias dcomr='ssh debian "cd ~/docker && docker-compose"'
alias ddockge="ssh -f -N -L 5001:localhost:5001 debian 2>/dev/null; open http://localhost:5001"

# --- git ---
alias ga='git add .'
alias gm='git commit -m'
alias gpe='git push -u gitee main'
alias gpt='git push -u github main'

# --- homebrew ---
alias ba='brew update && ( set -o pipefail; brew upgrade 2>&1 | awk "BEGIN{f=0} /Warning: Not upgrading [0-9]* pinned packages:/{f=1} {if(!f) print}" ) && brew cleanup'
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
alias imgo="immich-go upload from-folder -s http://100.67.58.98:2283 -k \$IMMICH_API_KEY --manage-heic-jpeg StackCoverHEIC $HOME/Pictures/Photos Library.photoslibrary"
alias musicsyn="rsync -avz -e \"ssh -p 2222\" soc@100.67.58.98:~/docker/musicn/data/ ~/Music/musicn/"

# --- ssh ---
alias de='ssh -p 2222 soc@100.67.58.98'
alias dlm3u8='ssh soc@100.67.58.98 "/home/soc/bin/dl-m3u8"'
alias geta='scp soc@100.67.58.98:/home/soc/downloads/aria2/'

# --- tmux ---
alias nvt='nv ~/.config/tmux/tmux.conf'
alias t='tmux attach-session -t main 2>/dev/null || tmux new-session -s main'
alias tkill='tmux kill-server'
alias tl='tmux ls'

# --- uv ---
alias ur="uv run"

# ------------------------------
# Function
# ------------------------------

# 列出 Debian 远程目录文件（方便复制确切文件名）
dlls() {
    ssh debian-home ls -lh "${1:-/home/soc/downloads/aria2/}"
}

# 从 Debian 拉文件到 Mac（断点续传 + 进度条）
dlpull() {
    if [[ -z "$1" ]]; then
        echo "Usage: dlpull <remote-path> [local-dest]" >&2
        return 1
    fi
    local src="$1"
    local dest="${2:-$HOME/Downloads/debian-pull/}"
    mkdir -p "$dest"
    rsync -avzPs "debian-home:$src" "$dest"
}

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
