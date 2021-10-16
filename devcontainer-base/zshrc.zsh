# To support bash tab-completion on apps lacking native zsh tab-completion
autoload bashcompinit
bashcompinit

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
