# To support bash tab-completion on apps lacking native zsh tab-completion
autoload bashcompinit
bashcompinit

# Add support for Oh My Zsh completion cache
ZSH_COMPLETIONS_CACHE="$HOME/.cache/zim/modules/ohmyzsh/cache/completions"
if [[ -d "$ZSH_COMPLETIONS_CACHE" ]]; then
    (( ${fpath[(Ie)"$ZSH_COMPLETIONS_CACHE"]} )) || fpath=("$ZSH_COMPLETIONS_CACHE" $fpath)
fi
unset ZSH_COMPLETIONS_CACHE

# Load environment variables
[[ -f ~/.config/zsh/env.zsh ]] && source ~/.config/zsh/env.zsh

# Initialize the starship prompt
eval $(starship init zsh)

# zimfw init
ZIM_HOME=~/.cache/zim

# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

# Initialize modules.
source ${ZIM_HOME}/init.zsh
