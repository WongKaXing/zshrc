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

# script
export PATH="$PATH:$HOME/script"

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

# Fix terminal type for TUI apps；但保留 kitty 的 xterm-kitty（否则 yazi 认不出 Kitty 图形协议，图片预览变马赛克）
[[ $TERM != xterm-kitty ]] && export TERM=xterm-256color

# Homebrew - USTC mirror
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
export HOMEBREW_CASK_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-cask.git"
export HOMEBREW_PIP_INDEX_URL="https://mirrors.ustc.edu.cn/pypi/web/simple"

# ollama (Debian 远程模型服务)
export OLLAMA_HOST="100.67.58.98:11434"

# XDG / config directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export PUB_CACHE="$HOME/.local/share/pub-cache"

# API keys（敏感，存于 secrets.zsh，被 .gitignore 排除，不入库）
if [[ -f "$ZDOTDIR/secrets.zsh" ]]; then
    source "$ZDOTDIR/secrets.zsh"
fi

# ------------------------------
# Tool Initialization
# ------------------------------

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
# z 的 Tab 补全改为列出 zoxide 缓存目录（补全函数见 completions/_z，必须紧跟在 init 之后重新注册）
compdef _z z

# ------------------------------
# Aliases
# ------------------------------

# --- system ---
alias a='yazi'
alias au='\
  echo "🍺 [1/3] 更新 Homebrew（系统工具和依赖）..."; \
  ba; \
  echo "----------------------------------------"; \
  echo ""; \
  echo "🟢 [2/3] 更新 Node.js (nvm) 和 npm 全局包（已排除 dsh，交 [3/3] 处理）..."; \
  lazy_load_nvm; \
  nvm install 22 --reinstall-packages-from=current; \
  nvm alias default 22; \
  npm install -g npm@latest; \
  echo "📦 全局包可更新情况（已跳过 @deepseek-ai/*）："; \
  npm outdated -g 2>/dev/null | grep -v "^@deepseek-ai/" || true; \
  pkgs=($(npm ls -g --depth=0 --parseable 2>/dev/null | grep "/node_modules/" | sed "s#.*/node_modules/##" | grep -v "^@deepseek-ai/" | grep -v "^npm$")); \
  if (( ${#pkgs[@]} )); then npm update -g "${pkgs[@]}"; fi; \
  echo "✅ Node: $(node -v), npm: $(npm -v)"; \
  echo "----------------------------------------"; \
  echo ""; \
  echo "🔍 [3/3] 检查并自动更新 dsh..."; \
  dshup'
alias c='clear'
alias ch='rr ~/.thumbnails ~/.adobe ~/.ntfstool ~/.playwright-* ~/.dart-tool ~/.immich-photos-sync.log ~/.zsh-defer ~/Temp ~/.zcompdump* 2>/dev/null; echo "✅ 已清理无用缓存"'
alias cls='clear'
alias cp='cp -r'
alias cpz='cp -r ~/.config/zsh/.zshrc ~/Documents/Git/zshrc/ && cd ~/Documents/Git/zshrc/'
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
alias s='sudo !!'
alias souz='clear && source ~/.config/zsh/.zshrc'
alias sql="unset all_proxy HTTP_PROXY http_proxy HTTPS_PROXY https_proxy && sqlmap --batch"
alias targz='tar xzvf'
alias te='tree'
alias xf='sudo xattr -rd com.apple.quarantine '
alias zc='cd ~/.config'
alias zk='cd ~/.config/kitty/'
alias zm='cd /tmp'
alias zs='cd /Users/soc/Library/Application\ Support/'
alias zu='cd /Users/soc/Documents/Ukulele/个人曲谱'
alias zz='z -'
alias z1='cd /Users/soc/Applications/.1'

# --- aibalance ---
alias aibre='cd /Users/soc/Documents/ClaudeDevelopment/AIBalanceApp/AIBalanceApp_macOS_v1.0.2 && killall AIBalanceApp 2>/dev/null; xcodebuild -scheme AIBalanceApp -configuration Release -destination "platform=macOS" -derivedDataPath /tmp/aibuild build && rm -rf /Applications/AIBalanceApp.app && ditto /tmp/aibuild/Build/Products/Release/AIBalanceApp.app /Applications/AIBalanceApp.app && open /Applications/AIBalanceApp.app'

# --- git ---
alias ga='git status'
alias gc='git clone'
alias gpe='git push -u gitee main'
alias gpt='git push -u github main'
alias gr='git remote -v'

# --- homebrew ---
alias ba='brewba'
alias bc='echo "bc is disabled. Use \bc if you really need it."'
alias cb='brew cleanup -s && rm -rf ~/Library/Caches/Homebrew/*'

# --- kitty ---
alias icat='kitty +kitten icat'
alias nvk='nv ~/.config/kitty/kitty.conf'
alias souk='clear && kitten @ load-config'
alias ssh='kitty +kitten ssh'

# --- lazygit ---
alias lg='lazygit'

# --- lua ---
alias lj='luajit'
alias lu='lua'

# --- ollama ---
alias br='ssh -p 2222 soc@100.67.58.98 "~/ollama/daily-brief.sh"'
alias o14='ollama run qwen3:14b'
alias o8='ollama run qwen3:8b'
alias ols='ollama list'
alias omc='ssh -p 2222 -t soc@100.67.58.98 /home/soc/ollama/.venv/bin/python /home/soc/ollama/mchat.py'
alias ops='ollama ps'

# --- python ---
alias pyrun='uv run python'
alias soud='deactivate'
alias soup='source ./.venv/bin/activate'

# --- rsync (sync) ---
alias imgo="immich-go upload from-folder -s http://100.67.58.98:2283 -k \$IMMICH_API_KEY --manage-heic-jpeg StackCoverHEIC $HOME/Pictures/Photos Library.photoslibrary"
alias musicsyn="rsync -avz -e \"ssh -p 2222\" soc@100.67.58.98:~/docker/musicn/data/ ~/Music/musicn/"

# --- ssh ---
alias de='ssh debian'
alias dlm3u8='ssh soc@100.67.58.98 "/home/soc/bin/dl-m3u8"'
alias geta='scp soc@100.67.58.98:/home/soc/downloads/aria2/'

# --- ukulele ---
alias uke='cd /Users/soc/Documents/Ukulele && npm run dev'
alias ukeb='cd /Users/soc/Documents/Ukulele && nohup npm run dev > /tmp/uke-dev.log 2>&1 &'
alias ukek='lsof -tiTCP:5173 -sTCP:LISTEN | xargs kill'
alias ukel='tail -f /tmp/uke-dev.log'
# 练习用：构建后跑静态预览，不受源码改动影响（dev 会 HMR 重载，练习时别用）
alias ukep='cd /Users/soc/Documents/Ukulele && npm run build && nohup npm run preview > /tmp/uke-preview.log 2>&1 & sleep 3; echo "小U练习室 → http://localhost:4173/"'
alias ukepk='lsof -tiTCP:4173 -sTCP:LISTEN | xargs kill'

# --- uv ---
alias ur="uv run"

# ------------------------------
# Function
# ------------------------------

# 下载 B 站视频（自动合并 mp4）并转成 H.264；用法: bili <视频页URL>
bili() {
    yt-dlp --cookies-from-browser edge -P "$HOME/Downloads" \
        -f "bv*+ba/b" --merge-output-format mp4 \
        --exec 'h264ify {}' "$@"
}

# 只下载 B 站音频并转成 mp3；用法: bilia <视频页URL>
bilia() {
    yt-dlp --cookies-from-browser edge -P "$HOME/Downloads" \
        -f "ba/b" -x --audio-format mp3 --audio-quality 0 "$@"
}

# ba 的实现：brew update / upgrade / cleanup；输出逐行转斜体（终端下强制彩色）
brewba() {
    setopt localoptions pipefail
    local -a hb=(brew)
    [[ -t 1 ]] && hb=(env HOMEBREW_COLOR=1 brew)
    {
        "${hb[@]}" update &&
            ("${hb[@]}" upgrade 2>&1 | awk 'BEGIN{f=0} /Warning: Not upgrading [0-9]* pinned packages:/{f=1} {if(!f) print}') &&
            "${hb[@]}" cleanup
    } 2>&1 | italicize
}

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

# 逐行包成斜体（kitty 的 italic_font）；每遇 \e[0m 重置后重新开启斜体，
# 非终端输出（重定向/管道）原样透传，避免转义符写进日志
italicize() {
    if [[ -t 1 ]]; then
        sed $'s/\x1b\\[0m/\x1b[0m\x1b[3m/g; s/^/\x1b[3m/; s/$/\x1b[0m/'
    else
        cat
    fi
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
    IFS= read -r -d '' cwd <"$tmp"
    [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$tmp"
    rm -f -- "$tmp"
}
