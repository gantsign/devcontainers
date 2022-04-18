# To support bash tab-completion on apps lacking native zsh tab-completion
autoload bashcompinit
bashcompinit

# Add support for Oh My Zsh completion cache
ZSH_COMPLETIONS_CACHE="$HOME/.zplug/repos/robbyrussell/oh-my-zsh/cache/completions"
if [[ -d "$ZSH_COMPLETIONS_CACHE" ]]; then
    (( ${fpath[(Ie)"$ZSH_COMPLETIONS_CACHE"]} )) || fpath=("$ZSH_COMPLETIONS_CACHE" $fpath)
fi
unset ZSH_COMPLETIONS_CACHE

# Zplug init
source /usr/share/zplug/init.zsh

# Load environment variables
[[ -f ~/.config/zsh/env.zsh ]] && source ~/.config/zsh/env.zsh

# Initialize the starship prompt
eval $(starship init zsh)

# Load Zplug config
[[ -f ~/.config/zsh/zplugrc.zsh ]] && source ~/.config/zsh/zplugrc.zsh

# Install and load the plugins
zplug check || zplug install
zplug load
