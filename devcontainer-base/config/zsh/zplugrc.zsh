# Load Oh My Zsh library (this configures a lot of the basic Zsh settings)
zplug 'robbyrussell/oh-my-zsh', use:'lib/*.zsh'

zplug "$HOME/.sdkman", from:local, use:'bin/sdkman-init.sh', defer:1

zplug "$NVM_DIR", from:local, use:'{nvm.sh,bash_completion}', defer:1

oh_my_zsh_plugins=(
   autopep8
   command-not-found
   copybuffer
   copydir
   copyfile
   dirhistory
   fd
   fzf
   git
   gradle
   gradle
   httpie
   ng
   pep8
   pip
   pipenv
   ripgrep
   sudo
)
for i ("$oh_my_zsh_plugins[@]") zplug "plugins/$i", from:oh-my-zsh, defer:1
unset oh_my_zsh_plugins

zplug 'zsh-users/zsh-autosuggestions', from:github, defer:1
zplug "$HOME/.local/zsh/plugins/pipx", from:local, use:'pipx.zsh', defer:1
zplug '/usr/local/share/zsh/plugins/gh', from:local, defer:1
zplug '/etc', from:local, use:'grc.zsh', defer:1
zplug '/usr/local/share/zsh/plugins/procs', from:local, defer:1
zplug '/usr/local/share/zsh/plugins/starship', from:local, defer:1
zplug '/usr/local/share/zsh/plugins/zoxide', from:local, defer:1
zplug 'b4b4r07/emoji-cli', from:github, defer:1
# fzf-tab must be loaded after fzf and ohmyzsh/lib/completion.zsh
# defer 2 is after compinit, fzf-tab must be loaded after compinit and before fast-syntax-highlighting
zplug 'Aloxaf/fzf-tab', from:github, defer:2
zplug 'MichaelAquilina/zsh-you-should-use', from:github, defer:1
# use fixed version of plugins with few users/stars
zplug 'mollifier/cd-gitroot', from:github, defer:1, at:66f6ba7549b9973eb57bfbc188e29d2f73bf31bb

# Must be after grc (both define mvn alias)
zplug 'plugins/mvn', from:oh-my-zsh, defer:2

# My constomizations (defer 2 to override most other plugins)
zplug "$HOME/.config/zsh", from:local, use:'custom.zsh', defer:2
zplug "$HOME/.config/sh", from:local, use:'sdk_install.sh', defer:2

# fast-syntax-highlighting must be loaded last (defer 3)
zplug 'zdharma/fast-syntax-highlighting', from:github, defer:3

# fzf-tab config
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
# remove bullet from results
zstyle ':fzf-tab:*' prefix ''
# always show group
zstyle ':fzf-tab:*' single-group color header
# preview apt package info
zstyle ':fzf-tab:complete:apt:*' fzf-preview '[[ $group == "[package]" ]] && apt-cache show $word'
