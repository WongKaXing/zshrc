# export TERM="xterm-256color"  # 终端类型：启用 256 色支持（已注释）


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export EDITOR=/opt/homebrew/bin/nvim  # 默认文本编辑器：指定为 Neovim

# fastfetch: 禁用 instant prompt 后放在最前面，即开即显且不被清屏
if [[ -o interactive ]]; then
    fastfetch --pipe false 2>/dev/null
fi

# 禁用 p10k instant prompt，避免启动时清屏把 fastfetch 刷掉
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH  # 自定义可执行文件搜索路径（已注释）

# Path to your oh-my-zsh installation.
export ZSH="/Users/soc/.oh-my-zsh"  # oh-my-zsh 安装目录路径


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="agnoster"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$PATH"  # 手册页搜索路径（已注释）

# You may need to manually set your language environment
# export LANG=en_US.UTF-8  # 系统语言环境：英文 UTF-8（已注释）

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'  # SSH 远程会话时使用 vim
# else
#   export EDITOR='mvim'  # 本地会话时使用 MacVim
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"  # 编译架构标志：指定 x86_64（已注释）

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


#source .bashrc

#path

# homebrew bin path
export PATH="/opt/homebrew/bin:$PATH"  # 将 Homebrew 可执行文件目录加入系统路径

# source fzf
source <(fzf --zsh)

# uv autocompletion
eval "$(uv generate-shell-completion zsh)"

# python bin path

# Created by `pipx` on 2024-08-16 13:35:02
export PATH="$PATH:/Users/soc/.local/bin"  # pipx 安装的 Python 工具目录

# clash path
export https_proxy=http://127.0.0.1:7897 http_proxy=http://127.0.0.1:7897 all_proxy=socks5://127.0.0.1:7897  # 网络代理设置：HTTP/HTTPS/SOCKS5 代理指向本地 Clash

# python path
export PATH="$PATH:/opt/homebrew/bin/python3"  # Python3 可执行文件路径

# nvim path
export EDITOR="/opt/homebrew/bin/nvim"  # 默认编辑器路径：Neovim

eval "$(zoxide init zsh)"

# alias
alias a='yazi'
alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'
alias b='brew'
alias ba='brew upgrade && brew update && brew cleanup'
alias bc='echo "bc is disabled. Use \bc if you really need it."'
alias cld='claude --settings ~/.claude/settings.deepseek.json --permission-mode bypassPermissions'
alias clk='claude --settings ~/.claude/settings.kimi.json --permission-mode bypassPermissions'
alias cls='clear'
alias cp='cp -r'
alias cs='clear'
alias cz='cat ~/.zshrc'
alias gpa='cp -rf ~/.config/kitty/* ~/Documents/Git/kitty/ && cp -rf ~/.config/yazi/* ~/Documents/Git/yazi/ && cp -rf ~/.config/nvim/* ~/Documents/Git/nvim/ && cp -f ~/.zshrc ~/Documents/Git/zshrc/ && for d in kitty yazi nvim zshrc; do cd ~/Documents/Git/$d && find . -name ".DS_Store" -type f -delete && git add -A && (git diff --cached --quiet && echo "$d: no changes to commit" || git commit -m "update $(date +%Y-%m-%d)") && echo "\n************  Gitee  ************\n" && git push gitee && echo "\n************  GitHub  ************\n" && git push github; done && cd ~/Documents/Git/zshrc && echo "All configs synced and pushed."'
alias e='exit'
alias f='fzf'
alias g='git'
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
alias souk='source ~/.config/kitty/kitty.conf'
alias soup='source ./.venv/bin/activate'
alias souz='source ~/.zshrc'
alias ssh='kitty +kitten ssh'
alias targz='tar xzvf'
alias te='tree'
alias to='touch'
alias uvp='uv pip install'
# syncfg alias merged into gpa
alias zz='..'


# export NVM_DIR="$HOME/.nvm"  # Node Version Manager 安装目录（已注释）
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm  # 加载 nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion  # 加载 nvm 命令补全


# yazi Shell wrapper, 按`y`启用yazi，选到路径后退出yazi，即可定位到该路径
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# nvim pwd
export EDITOR="/opt/homebrew/bin/nvim"  # 默认编辑器：Neovim（备用设置）

export CLICOLOR=1  # 启用终端命令输出颜色（如 ls）
export CLICOLOR_FORCE=1  # 强制启用颜色输出，即使输出到管道也保留颜色

export PATH=~/.npm-global/bin:$PATH  # npm 全局安装包的可执行文件路径
