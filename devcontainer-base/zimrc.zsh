zmodule ohmyzsh/ohmyzsh --root plugins \
  -f 'autopep8' \
  -f 'fd' \
  -f 'git-escape-magic' \
  -f 'gradle' \
  -f 'httpie' \
  -f 'ng' \
  -f 'pep8' \
  -f 'pip' \
  -f 'ripgrep'

zmodule '/usr/local/share/zsh/plugins' \
    -f 'procs' \
    -f 'starship'

if [ -f ~/.config/zsh/zim_before_compinit.zsh ]; then
    source ~/.config/zsh/zim_before_compinit.zsh
fi

# INSERT BEFORE COMPINIT

zmodule "$HOME/.config/zsh" -s 'completion.zsh'

zmodule ohmyzsh/ohmyzsh --root lib \
  -s 'clipboard.zsh' \
  -s 'compfix.zsh' \
  -s 'completion.zsh' \
  -s 'correction.zsh' \
  -s 'directories.zsh' \
  -s 'functions.zsh' \
  -s 'grep.zsh' \
  -s 'key-bindings.zsh' \
  -s 'misc.zsh' \
  -s 'spectrum.zsh' \
  -s 'termsupport.zsh' \

zmodule ohmyzsh/ohmyzsh --root plugins \
  -s 'command-not-found/command-not-found.plugin.zsh' \
  -s 'copybuffer/copybuffer.plugin.zsh' \
  -s 'copyfile/copyfile.plugin.zsh' \
  -s 'copypath/copypath.plugin.zsh' \
  -s 'dirhistory/dirhistory.plugin.zsh' \
  -s 'fzf/fzf.plugin.zsh' \
  -s 'git-escape-magic/git-escape-magic.plugin.zsh' \
  -s 'git/git.plugin.zsh' \
  -s 'git/git.plugin.zsh' \
  -s 'gradle/gradle.plugin.zsh' \
  -s 'grc/grc.plugin.zsh' \
  -s 'mvn/mvn.plugin.zsh' \
  -s 'pipenv/pipenv.plugin.zsh' \
  -s 'sudo/sudo.plugin.zsh' \
  -s 'zoxide/zoxide.plugin.zsh'

zmodule ~/.sdkman/bin -s 'sdkman-init.sh'
zmodule "$NVM_DIR" -s 'nvm.sh'
zmodule MichaelAquilina/zsh-you-should-use -s 'you-should-use.plugin.zsh'
zmodule Aloxaf/fzf-tab
zmodule "$HOME/.local/zsh/plugins/pipx" -s 'pipx.zsh'

# INSERT AFTER COMPINIT

zmodule ~/.config/zsh -s 'custom.zsh'
zmodule zsh-users/zsh-autosuggestions
zmodule zsh-users/zsh-syntax-highlighting
