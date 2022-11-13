export COLORTERM="${COLORTERM:-truecolor}"

export PATH="$HOME/.local/bin:$PATH"
export CDPATH='.:/workspaces'

# Workaround for https://github.com/starship/starship/issues/2176
export LC_ALL='en_GB.UTF-8'

export PAGER="less"

# Needed by some Oh My ZSH plugins
export ZSH_CACHE_DIR="$HOME/.cache/zim/modules/ohmyzsh/cache"

# So we can persist the history between container instances
HISTFILE="$HOME/.shell_history/zsh_history"

HISTORY_IGNORE='(cd ..|cd..|cd-|cd -|cd -2|zi|*VAULT_TOKEN*|*X-Vault-Token*|*create secret*|*password*|*Authorization*)'

# Gray color for autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=247'

export NVM_DIR="$HOME/.nvm"

# fzf settings. Uses sharkdp/fd for a faster alternative to `find`.
if [ $commands[fd] ]; then
    FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git --exclude .cache'
    FZF_CTRL_T_COMMAND='fd --type f --hidden --exclude .git --exclude .cache'
    FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
elif [ $commands[fdfind] ]; then
    # Ubuntu OS package uses fdfind
    FZF_DEFAULT_COMMAND='fdfind --type f --hidden --exclude .git --exclude .cache'
    FZF_CTRL_T_COMMAND='fdfind --type f --hidden --exclude .git --exclude .cache'
    FZF_ALT_C_COMMAND='fdfind --type d --hidden --exclude .git'
fi

# man pages with colour
if [ $commands[bat] ]; then
    # bat's man syntax highlighting only works well with the default theme
    export MANPAGER="sh -c 'col -bx | bat -l man -p --pager less --theme default'"
    # bat's default this is a little too garish
    export BAT_THEME='Visual Studio Dark+'
elif [ $commands[batcat] ]; then
    # Ubuntu OS package uses batcat
    # bat's man syntax highlighting only works well with the default theme
    export MANPAGER="sh -c 'col -bx | batcat -l man -p --pager less --theme default'"
    # Ubuntu OS package doesn't currently have Visual Studio Dark+ theme
fi
