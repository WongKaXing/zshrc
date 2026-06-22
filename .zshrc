
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


# ------------------------------
# Environment Variables
# ------------------------------

export EDITOR="/opt/homebrew/bin/nvim"

# clash proxy (only set when proxy is alive, otherwise curl hangs on timeout)
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
alias clk='claude --settings ~/.claude/settings.kimi.json --permission-mode bypassPermissions'
alias cls='clear'
alias cp='cp -r'
alias cz='cat ~/.zshrc'
alias e='exit'
alias f='fzf'
# alias gp='cp -rf ~/.config/starship.toml ~/Documents/Git/starship/ && cp -rf ~/.config/alacritty/* ~/Documents/Git/alacritty/ && cp -rf ~/.config/kitty/* ~/Documents/Git/kitty/ && cp -rf ~/.config/nvim/* ~/Documents/Git/nvim/ && cp -rf ~/.config/yazi/* ~/Documents/Git/yazi/ && cp -f ~/.zshrc ~/Documents/Git/zshrc/ && n=0 && for d in alacritty kitty nvim yazi zshrc starship; do n=$((n+1)) && printf "\n========= %s (%d/6) =========\n" "$d" $n && cd ~/Documents/Git/$d && find . -name ".DS_Store" -type f -delete && git add -A && (git diff --cached --quiet && echo "  (no changes)" || git commit -m "update $(date +%Y-%m-%d)") && printf "\n  >> Gitee:\n" && git push gitee && printf "\n  >> GitHub:\n" && git push github; done && printf "\n========= All configs synced and pushed. =========\n" && cd '
alias icat='kitty +kitten icat'
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
alias pyrun='uv run python'
alias re='sudo reboot'
alias rr='rm -rf'
alias rra='rm -rf *'
alias rrd='find . -name ".DS_Store" -type f -delete'
alias rrm='rm -rf main.py'
alias rrg='rm -rf .git'
alias xf='sudo xattr -rd com.apple.quarantine '
alias soup='source ./.venv/bin/activate'
alias soud='deactivate'
alias souz='clear && kitten @ load-config && source ~/.zshrc'
alias ssh='kitty +kitten ssh'
alias targz='tar xzvf'
alias te='tree'


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
