
# Homebrew - USTC mirror
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
export HOMEBREW_CASK_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-cask.git"
export HOMEBREW_PIP_INDEX_URL="https://mirrors.ustc.edu.cn/pypi/web/simple"
export HTTP_PROXY=http://127.0.0.1:7897
export HTTPS_PROXY=http://127.0.0.1:7897
eval "$(/opt/homebrew/bin/brew shellenv)"


# Created by `pipx` on 2024-08-16 13:35:02
export PATH="$PATH:/Users/soc/.local/bin"

# Setting PATH for Python 3.12
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.12/bin:${PATH}"
export PATH

# Added by Obsidian
export PATH="$PATH:/Applications/Obsidian.app/Contents/MacOS"

