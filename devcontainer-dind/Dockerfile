FROM ghcr.io/gantsign/devcontainer-base

USER root
WORKDIR /

ARG ENABLE_NONROOT_DOCKER=true
ARG USERNAME=dev
ARG USE_MOBY=false
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive  \
    # Install Docker
    && bash -c "$(curl -fsSL "https://raw.githubusercontent.com/microsoft/vscode-dev-containers/main/script-library/docker-in-docker-debian.sh")" -- "${ENABLE_NONROOT_DOCKER}" "${USERNAME}" "${USE_MOBY}" \
    # Install Docker tools
    && apt-get install --no-install-recommends -y ctop \
    # Cleanup
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Install dive
RUN URL="`curl -fsSL -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/wagoodman/dive/releases \
        | jq --raw-output '[.[] | select(.prerelease == false)] | .[0] | .assets | .[] | .browser_download_url | select(test(\"linux_amd64\\\\.deb\$\"))'`" \
    && curl -fsSL --output tmp.deb "${URL}" \
    && export DEBIAN_FRONTEND=noninteractive && dpkg -i ./tmp.deb && apt-get install -f \
    && rm -f tmp.deb

# Install lazydocker
RUN URL="`curl -fsSL -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/jesseduffield/lazydocker/releases \
        | jq --raw-output '[.[] | select(.prerelease == false)] | .[0] | .assets | .[] | .browser_download_url | select(test(\"Linux_x86_64\\\\.tar\\\\.gz\$\"))'`" \
    && curl -fsSL --output tmp.tar.gz "${URL}" \
    && mkdir -p /usr/local/share/lazydocker \
    && tar -C /usr/local/share/lazydocker -xvf tmp.tar.gz \
    && ln -sf /usr/local/share/lazydocker/lazydocker /usr/local/bin/lazydocker \
    && rm -f tmp.tar.gz

USER ${USERNAME}
WORKDIR /home/${USERNAME}

# Copy configuration
COPY --chown=${USERNAME}:${USERNAME} config .config

# Configure ZSH
RUN echo "zplug 'plugins/docker', from:oh-my-zsh, defer:1" >> ~/.config/zsh/zplugrc.zsh \
    && echo "zplug 'plugins/docker-compose', from:oh-my-zsh, defer:1" >> ~/.config/zsh/zplugrc.zsh

# To run zplug install
RUN zsh -c 'source /usr/share/zplug/init.zsh && zplug clear' \
    && zsh -c 'export TERM=xterm && source ~/.zshrc'

USER root
WORKDIR /

VOLUME [ "/var/lib/docker" ]

ENTRYPOINT ["/usr/local/share/docker-init.sh"]
CMD ["sleep", "infinity"]
