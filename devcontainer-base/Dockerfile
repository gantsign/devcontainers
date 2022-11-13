FROM ubuntu:focal

ENV	LC_ALL=en_GB.UTF-8

# Install OS packages
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    language-pack-en \
    && yes | unminimize \
    && apt-get -y upgrade --no-install-recommends \
    && apt-get -y install --no-install-recommends \
    apt-transport-https \
    boxes \
    bzip2 \
    ca-certificates \
    command-not-found \
    cowsay \
    curl \
    dirmngr \
    dnsutils \
    dos2unix \
    fd-find \
    file \
    fzf \
    git \
    gnupg-agent \
    gnupg2 \
    gzip \
    htop \
    iputils-ping \
    jq \
    less \
    make \
    man-db \
    mtr \
    multitail \
    neofetch \
    p7zip \
    pipenv \
    procps \
    pv \
    python-is-python3 \
    python3-venv \
    shellcheck \
    silversearcher-ag\
    software-properties-common \
    ssh-client \
    ssh-tools \
    sudo \
    tmux \
    traceroute \
    tree \
    unzip \
    vim \
    vim-airline \
    wget \
    xz-utils \
    zip \
    zsh \
    zstd \
    # Workaround https://bugs.launchpad.net/ubuntu/+source/rust-bat/+bug/1868517
    && apt-get -y install --no-install-recommends -o Dpkg::Options::="--force-overwrite" \
    hexyl \
    ripgrep \
    # Cleanup
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Dev containers
ARG USERNAME=dev
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive  \
    && bash -c "$(curl -fsSL "https://raw.githubusercontent.com/microsoft/vscode-dev-containers/main/script-library/common-debian.sh")" -- "false" "${USERNAME}" "${USER_UID}" "${USER_GID}" "false" "true" "true" \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install bat (using latest release rather than ubuntu package to get VS Code theme)
RUN URL="`curl -fsSL -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/sharkdp/bat/releases \
        | jq --raw-output '[.[] | select(.prerelease == false)] | .[0] | .assets | .[] | .browser_download_url | select(test(\"bat_[0-9\\\\.]+_amd64\\\\.deb\$\"))'`" \
    && curl -fsSL --output tmp.deb "${URL}" \
    && export DEBIAN_FRONTEND=noninteractive && dpkg -i ./tmp.deb && apt-get install -f \
    && rm -f tmp.deb

# Install btop
RUN URL="`curl -fsSL -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/aristocratos/btop/releases \
        | jq --raw-output '[.[] | select(.prerelease == false)] | .[0] | .assets | .[] | .browser_download_url | select(test(\"-x86_64-linux-musl\\\\.tbz\$\"))'`" \
    && curl -fsSL --output tmp.tbz "${URL}" \
    && mkdir -p /tmp/btop \
    && tar -C /tmp/btop --strip-components=2 -xvf tmp.tbz \
    && rm -f tmp.tbz \
    && cd /tmp/btop \
    && ./install.sh \
    && ./setuid.sh \
    && rm -rf /tmp/btop

# Install GitHub CLI
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    | gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
    | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install gh \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /usr/local/share/zsh/plugins/gh \
    && gh completion -s zsh > /usr/local/share/zsh/plugins/gh/_gh

# Install delta
RUN URL="`curl -fsSL -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/dandavison/delta/releases \
        | jq --raw-output '[.[] | select(.prerelease == false)] | .[0] | .assets | .[] | .browser_download_url | select(test(\"git-delta_[0-9\\\\.]+_amd64\\\\.deb\$\"))'`" \
    && curl -fsSL --output tmp.deb "${URL}" \
    && export DEBIAN_FRONTEND=noninteractive && dpkg -i ./tmp.deb && apt-get install -f \
    && rm -f tmp.deb

# Install duf
RUN URL="`curl -fsSL -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/muesli/duf/releases \
        | jq --raw-output '[.[] | select(.prerelease == false)] | .[0] | .assets | .[] | .browser_download_url | select(test(\"linux_amd64\\\\.deb\$\"))'`" \
    && curl -fsSL --output tmp.deb "${URL}" \
    && export DEBIAN_FRONTEND=noninteractive && dpkg -i ./tmp.deb && apt-get install -f \
    && rm -f tmp.deb

# Install dust
RUN URL="`curl -fsSL -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/bootandy/dust/releases \
        | jq --raw-output '[.[] | select(.prerelease == false)] | .[0] | .assets | .[] | .browser_download_url | select(test(\"x86_64-unknown-linux-gnu\\\\.tar\\\\.gz\$\"))'`" \
    && curl -fsSL --output tmp.tar.gz "${URL}" \
    && mkdir -p /usr/local/share/dust \
    && tar --strip-components=1 -C /usr/local/share/dust -xvf tmp.tar.gz \
    && ln -sf /usr/local/share/dust/dust /usr/local/bin/dust \
    && rm -f tmp.tar.gz

# Install emojify
RUN URL="`curl -fsSL -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/mrowa44/emojify/releases \
        | jq --raw-output '[.[] | select(.prerelease == false)] | .[0] | .tarball_url'`" \
    && curl -fsSL --output tmp.tar.gz "${URL}" \
    && mkdir -p /usr/local/share/emojify \
    && tar --strip-components=1 -C /usr/local/share/emojify -xvf tmp.tar.gz \
        --wildcards '*/emojify' --wildcards '*/LICENSE.md'\
    && ln -sf /usr/local/share/emojify/emojify /usr/local/bin/emojify \
    && rm -f tmp.tar.gz

# Install grc (using latest release rather than Ubuntu package for kubectl support)
RUN URL="`curl -fsSL -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/garabik/grc/releases \
        | jq --raw-output '[.[] | select(.prerelease == false)] | .[0] | .tarball_url'`" \
    && curl -fsSL --output tmp.tar.gz "${URL}" \
    && mkdir -p /tmp/grc \
    && tar --strip-components=1 -C /tmp/grc -xvf tmp.tar.gz \
    && rm -f tmp.tar.gz \
    && cd /tmp/grc \
    && ./install.sh \
    && rm -rf /tmp/grc \
    && mv /usr/local/zsh/site-functions/_grc /usr/local/share/zsh/site-functions \
    && mandb

# Install hurl
RUN URL="`curl -fsSL -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/Orange-OpenSource/hurl/releases \
        | jq --raw-output '[.[] | select(.prerelease == false)] | .[0] | .assets | .[] | .browser_download_url | select(test(\"hurl_[0-9\\\\.]+_amd64\\\\.deb\$\"))'`" \
    && curl -fsSL --output tmp.deb "${URL}" \
    && export DEBIAN_FRONTEND=noninteractive && dpkg -i ./tmp.deb && apt-get install -f \
    && rm -f tmp.deb

# Install hyperfine
RUN URL="`curl -fsSL -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/sharkdp/hyperfine/releases \
        | jq --raw-output '[.[] | select(.prerelease == false)] | .[0] | .assets | .[] | .browser_download_url | select(test(\"hyperfine_[0-9\\\\.]+_amd64\\\\.deb\$\"))'`" \
    && curl -fsSL --output tmp.deb "${URL}" \
    && export DEBIAN_FRONTEND=noninteractive && dpkg -i ./tmp.deb && apt-get install -f \
    && rm -f tmp.deb

# Install lazygit
RUN URL="`curl -fsSL -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/jesseduffield/lazygit/releases \
        | jq --raw-output '[.[] | select(.prerelease == false)] | .[0] | .assets | .[] | .browser_download_url | select(test(\"Linux_x86_64\\\\.tar\\\\.gz\$\"))'`" \
    && curl -fsSL --output tmp.tar.gz "${URL}" \
    && mkdir -p /usr/local/share/lazygit \
    && tar -C /usr/local/share/lazygit -xvf tmp.tar.gz \
    && ln -sf /usr/local/share/lazygit/lazygit /usr/local/bin/lazygit \
    && rm -f tmp.tar.gz

# Install lsd
RUN URL="`curl -fsSL -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/Peltoche/lsd/releases \
        | jq --raw-output '[.[] | select(.prerelease == false)] | .[0] | .assets | .[] | .browser_download_url | select(test(\"lsd_[0-9\\\\.]+_amd64\\\\.deb\$\"))'`" \
    && curl -fsSL --output tmp.deb "${URL}" \
    && export DEBIAN_FRONTEND=noninteractive && dpkg -i ./tmp.deb && apt-get install -f \
    && rm -f tmp.deb

# Install procs
RUN VERSION="`curl -fsSL -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/dalance/procs/releases \
        | jq --raw-output '[.[] | select(.prerelease == false)] | .[0].tag_name'`" \
    && URL="https://raw.githubusercontent.com/dalance/procs/${VERSION}/LICENSE" \
    && mkdir -p /usr/local/share/procs \
    && curl -fsSL --output /usr/local/share/procs/LICENSE "${URL}" \
    && URL="`curl -fsSL -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/dalance/procs/releases \
        | jq --raw-output \"[.[] | select(.prerelease == false)] | .[] | select(.tag_name == \\\"${VERSION}\\\") | .assets | .[] | .browser_download_url | select(test(\\\"x86_64-linux\\\\\\.zip\$\\\"))\"`" \
    && curl -fsSL --output tmp.zip "${URL}" \
    && unzip -d /usr/local/share/procs tmp.zip \
    && ln -sf /usr/local/share/procs/procs /usr/local/bin/procs \
    && rm -f tmp.zip \
    && mkdir -p /usr/local/share/zsh/plugins/procs \
    && cd /usr/local/share/zsh/plugins/procs \
    && procs --completion zsh

# Install sd
RUN VERSION="`curl -fsSL -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/chmln/sd/releases \
        | jq --raw-output '[.[] | select(.prerelease == false)] | .[0].tag_name'`" \
    && URL="https://raw.githubusercontent.com/chmln/sd/${VERSION}/LICENSE" \
    && mkdir -p /usr/local/share/sd \
    && curl -fsSL --output /usr/local/share/sd/LICENSE "${URL}" \
    && URL="`curl -fsSL -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/chmln/sd/releases \
        | jq --raw-output \"[.[] | select(.prerelease == false)] | .[] | select(.tag_name == \\\"${VERSION}\\\") | .assets | .[] | .browser_download_url | select(test(\\\"x86_64-unknown-linux-gnu\$\\\"))\"`" \
    && curl -fsSL --output /usr/local/share/sd/sd "${URL}" \
    && chmod +x /usr/local/share/sd/sd \
    && ln -sf /usr/local/share/sd/sd /usr/local/bin/sd

# Install starship
RUN VERSION="`curl -fsSL -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/starship/starship/releases \
        | jq --raw-output '[.[] | select(.prerelease == false)] | .[0].tag_name'`" \
    && URL="https://raw.githubusercontent.com/starship/starship/${VERSION}/LICENSE" \
    && mkdir -p /usr/local/share/starship \
    && curl -fsSL --output /usr/local/share/starship/LICENSE "${URL}" \
    && URL="`curl -fsSL -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/starship/starship/releases \
        | jq --raw-output \"[.[] | select(.prerelease == false)] | .[] | select(.tag_name == \\\"${VERSION}\\\") | .assets | .[] | .browser_download_url | select(test(\\\"x86_64-unknown-linux-gnu\\\\\\.tar\\\\\\.gz\$\\\"))\"`" \
    && curl -fsSL --output tmp.tar.gz "${URL}" \
    && tar -C /usr/local/share/starship -xvf tmp.tar.gz \
    && ln -sf /usr/local/share/starship/starship /usr/local/bin/starship \
    && rm -f tmp.tar.gz \
    && mkdir -p /usr/local/share/zsh/plugins/starship \
    && starship completions zsh > /usr/local/share/zsh/plugins/starship/_starship

# Install tokei
RUN VERSION="`curl -fsSL -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/XAMPPRocky/tokei/releases \
        | jq --raw-output '[.[] | select(.prerelease == false)] | .[0].tag_name'`" \
    && URL="https://raw.githubusercontent.com/XAMPPRocky/tokei/${VERSION}/LICENCE-MIT" \
    && mkdir -p /usr/local/share/tokei \
    && curl -fsSL --output /usr/local/share/tokei/LICENSE "${URL}" \
    && URL="`curl -fsSL -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/XAMPPRocky/tokei/releases \
        | jq --raw-output \"[.[] | select(.prerelease == false)] | .[] | select(.tag_name == \\\"${VERSION}\\\") | .assets | .[] | .browser_download_url | select(test(\\\"x86_64-unknown-linux-gnu\\\\\\.tar\\\\\\.gz\$\\\"))\"`" \
    && curl -fsSL --output tmp.tar.gz "${URL}" \
    && tar -C /usr/local/share/tokei -xvf tmp.tar.gz \
    && ln -sf /usr/local/share/tokei/tokei /usr/local/bin/tokei \
    && rm -f tmp.tar.gz

# Install zoxide
RUN URL="`curl -fsSL -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/ajeetdsouza/zoxide/releases \
        | jq --raw-output '[.[] | select(.prerelease == false)] | .[0] | .assets | .[] | .browser_download_url | select(test(\"x86_64-unknown-linux-musl\\\\.tar\\\\.gz\$\"))'`" \
    && curl -fsSL --output tmp.tar.gz "${URL}" \
    && mkdir -p /usr/local/share/zoxide \
    && tar -C /usr/local/share/zoxide -xvf tmp.tar.gz \
    && ln -sf /usr/local/share/zoxide/zoxide /usr/local/bin/zoxide \
    && mkdir -p /usr/local/share/man/man1/ \
    && mv -f /usr/local/share/zoxide/man/* /usr/local/share/man/man1/ \
    && mandb \
    && rm -f tmp.tar.gz \
    && mkdir -p /usr/local/share/zsh/plugins/zoxide \
    && zoxide init zsh > /usr/local/share/zsh/plugins/zoxide/zoxide.zsh
# Needs to have a later date than zoxide.zsh, so must be in a seaparate layer
RUN zsh -c 'zcompile -UR /usr/local/share/zsh/plugins/zoxide/zoxide.zsh'

# Configure Git
RUN git config --system pull.rebase 'true' && \
    git config --system core.autocrlf 'input' && \
    git config --system alias.ca 'commit --amend' && \
    git config --system alias.cane 'commit --amend --no-edit' && \
    git config --system alias.cb 'switch -c' && \
    git config --system alias.co 'checkout' && \
    git config --system alias.dev '!git-develop-branch' && \
    git config --system alias.exec '!exec ' && \
    git config --system alias.lds 'log --pretty=format:"%C(yellow)%h\ %ad%Cred%d\ %Creset%s%Cblue\ [%cn]" --decorate --date=short' && \
    git config --system alias.ll 'log --pretty=format:"%C(yellow)%h%Cred%d\ %Creset%s%Cblue\ [%cn]" --decorate --numstat' && \
    git config --system alias.ls 'log --pretty=format:"%C(yellow)%h%Cred%d\ %Creset%s%Cblue\ [%cn]" --decorate' && \
    git config --system alias.lt 'log --oneline --graph --decorate --all' && \
    git config --system alias.main '!git-main-branch' && \
    git config --system alias.po 'push origin HEAD' && \
    git config --system alias.pof 'push origin HEAD --force' && \
    git config --system alias.pop 'stash pop' && \
    git config --system alias.rod '!git rebase origin/$(git dev)' && \
    git config --system alias.rom '!git rebase origin/$(git main)' && \
    git config --system alias.root 'rev-parse --show-toplevel' && \
    git config --system alias.sdp '!git switch $(git dev) && git pull -p' && \
    git config --system alias.smp '!git switch $(git main) && git pull -p' && \
    git config --system alias.sw 'switch' && \
    git config --system log.date 'format:%a %Y-%m-%d %H:%M:%S %z' && \
    git config --system pager.diff 'delta' && \
    git config --system pager.log 'delta' && \
    git config --system pager.reflog 'delta' && \
    git config --system pager.show 'delta' && \
    git config --system delta.line-numbers 'true' && \
    # Adjust appearance to match bat theme
    git config --system delta.line-numbers-left-style '#619DD7' && \
    git config --system delta.line-numbers-right-style '#619DD7' && \
    git config --system delta.file-style 'white bold' && \
    git config --system delta.file-decoration-style 'white ol' && \
    git config --system delta.hunk-header-line-number-style '#619DD7' && \
    git config --system delta.hunk-header-decoration-style '#619DD7 ul' && \
    # Improve contrast between background and foreground colors
    git config --system delta.minus-style 'syntax #6A1212' && \
    git config --system delta.minus-non-emph-style 'syntax #481818' && \
    git config --system delta.minus-emph-style 'syntax #6A1212' && \
    git config --system delta.line-numbers-minus-style '#8C1717' && \
    git config --system delta.plus-style 'syntax #4C5631' && \
    git config --system delta.plus-non-emph-style 'syntax #383D28' && \
    git config --system delta.plus-emph-style 'syntax #4C5631' && \
    git config --system delta.line-numbers-plus-style '#7C8C4F' && \
    # Configure git to use vscode for difftool and mergetool
    git config --system difftool.code.cmd 'code --reuse-window --wait --diff "$LOCAL" "$REMOTE"' && \
    git config --system mergetool.code.cmd 'code --reuse-window --wait "$MERGED"' && \
    # Make vscode the default merge tool
    git config --system merge.tool 'code --reuse-window --wait' && \
    # Use vscode to edit commit messages
    git config --system core.editor 'code --reuse-window --wait'

RUN chsh -s /usr/bin/zsh ${USERNAME}
USER ${USERNAME}
WORKDIR /home/${USERNAME}

# Install NVM
RUN VERSION="`curl -fsSL -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/nvm-sh/nvm/releases \
        | jq --raw-output '[.[] | select(.prerelease == false)] | .[0].tag_name'`" \
    && curl -fsSL -o- "https://raw.githubusercontent.com/nvm-sh/nvm/${VERSION}/install.sh" | bash

# Install SDKMAN!
RUN curl -fsSL "https://get.sdkman.io" | bash \
    && echo '\n# Run for non-interactive shells (as ~/.bashrc terminates before loading SDKMAN!)\n\
if [[ $- != *i* ]]; then\n\
    export SDKMAN_DIR="$HOME/.sdkman"\n\
    [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"\n\
    source "$HOME/.config/sh/sdk_install.sh"\n\
fi' >> ~/.profile

# Install pipx
RUN export PATH="$HOME/.local/bin:$PATH" && python3 -m pip install --user pipx \
    && mkdir -p ~/.local/zsh/plugins/pipx \
    && register-python-argcomplete --shell bash pipx > ~/.local/zsh/plugins/pipx/pipx.zsh

# Install httpie (using pipx rather than Ubuntu package to get latest version)
RUN export PATH="$HOME/.local/bin:$PATH" && python3 -m pipx install httpie

# Install http-prompt
RUN export PATH="$HOME/.local/bin:$PATH" && python3 -m pipx install http-prompt

# Install glances (using pipx rather than Ubuntu package to get latest version)
RUN export PATH="$HOME/.local/bin:$PATH" && python3 -m pipx install glances

# Export additional bat themes for use by delta
RUN bat cache --build

# Copy configuration
COPY --chown=${USERNAME}:${USERNAME} config .config
COPY --chown=${USERNAME}:${USERNAME} vimrc.vim .vimrc
COPY --chown=${USERNAME}:${USERNAME} zshrc.zsh .zshrc
COPY --chown=${USERNAME}:${USERNAME} zimrc.zsh .zimrc

# So we can persist the history using a volume mount
RUN mkdir -p ~/.shell_history

# So we can persist the zoxide db using a volume mount
RUN mkdir -p ~/.local/share/zoxide

# To run zimfw install
RUN for i in $(seq 1 3); do timeout 30s \
    zsh -c 'export TERM=xterm && source ~/.zshrc' \
    && break || [ $i -lt 3 ]; done \
&& mkdir -p ~/.cache/zim/modules/ohmyzsh/cache/completions

CMD [ "zsh" ]
