FROM ghcr.io/gantsign/devcontainer-dind

USER root
WORKDIR /

ARG USERNAME=dev

# Install k3s
RUN curl -fsSL https://get.k3s.io | INSTALL_K3S_SKIP_START=true \
    INSTALL_K3S_SKIP_ENABLE=true sh -s - --docker \
    && mkdir -p /usr/local/share/zsh/plugins/crictl \
    && bash -c "crictl --config <(echo '') completion zsh > /usr/local/share/zsh/plugins/crictl/crictl.zsh"
# Needs to have a later date than crictl.zsh, so must be in a seaparate layer
RUN zsh -c 'zcompile -UR /usr/local/share/zsh/plugins/crictl/crictl.zsh'

# Install Helm
RUN curl -fsSL https://baltocdn.com/helm/signing.asc | \
    APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 apt-key add - \
    && echo "deb https://baltocdn.com/helm/stable/debian/ all main"  \
        | tee /etc/apt/sources.list.d/helm-stable-debian.list \
    && apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install \
        helm \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install k9s
RUN URL="`curl -fsSL -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/derailed/k9s/releases \
        | jq --raw-output '[.[] | select(.prerelease == false)] | .[0] | .assets | .[] | .browser_download_url | select(test(\"k9s_Linux_amd64\\\\.tar\\\\.gz\$\"))'`" \
    && curl -fsSL --output tmp.tar.gz "${URL}" \
    && mkdir -p /usr/local/share/k9s \
    && tar -C /usr/local/share/k9s -xvf tmp.tar.gz \
    && ln -sf /usr/local/share/k9s/k9s /usr/local/bin/k9s \
    && rm -f tmp.tar.gz \
    && mkdir -p /usr/local/share/zsh/plugins/k9s \
    && k9s completion zsh | tee /usr/local/share/zsh/plugins/k9s/_k9s

# Install kubectx
RUN URL="`curl -fsSL -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/ahmetb/kubectx/releases \
        | jq --raw-output '[.[] | select(.prerelease == false)] | .[0] | .assets | .[] | .browser_download_url | select(test(\"kubectx_v[0-9\\\\.]+_linux_x86_64\\\\.tar\\\\.gz\$\"))'`" \
    && curl -fsSL --output tmp.tar.gz "${URL}" \
    && mkdir -p /usr/local/share/kubectx \
    && tar -C /usr/local/share/kubectx -xvf tmp.tar.gz \
    && ln -sf /usr/local/share/kubectx/kubectx /usr/local/bin/kubectx \
    && rm -f tmp.tar.gz

# Install kubens
RUN URL="`curl -fsSL -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/ahmetb/kubectx/releases \
        | jq --raw-output '[.[] | select(.prerelease == false)] | .[0] | .assets | .[] | .browser_download_url | select(test(\"kubens_v[0-9\\\\.]+_linux_x86_64\\\\.tar\\\\.gz\$\"))'`" \
    && curl -fsSL --output tmp.tar.gz "${URL}" \
    && mkdir -p /usr/local/share/kubens \
    && tar -C /usr/local/share/kubens -xvf tmp.tar.gz \
    && ln -sf /usr/local/share/kubens/kubens /usr/local/bin/kubens \
    && rm -f tmp.tar.gz

# Install Kustomize
RUN VERSION="`curl -fsSL -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/kubernetes-sigs/kustomize/releases \
        | jq --raw-output '[.[] | select(.prerelease == false) | select(.tag_name | startswith("kustomize"))] | .[0].tag_name'`" \
    && URL="https://raw.githubusercontent.com/kubernetes-sigs/kustomize/${VERSION}/LICENSE" \
    && mkdir -p /usr/local/share/kustomize \
    && URL="`curl -fsSL -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/kubernetes-sigs/kustomize/releases \
        | jq --raw-output \"[.[] | select(.prerelease == false)] | .[] | select(.tag_name == \\\"${VERSION}\\\") | .assets | .[] | .browser_download_url | select(test(\\\"linux_amd64\\\\\\.tar\\\\\\.gz\$\\\"))\"`" \
    && curl -fsSL --output tmp.tar.gz "${URL}" \
    && tar -C /usr/local/share/kustomize -xvf tmp.tar.gz \
    && ln -sf /usr/local/share/kustomize/kustomize /usr/local/bin/kustomize \
    && rm -f tmp.tar.gz \
    && mkdir -p /usr/local/share/zsh/plugins/kustomize \
    && kustomize completion zsh | tee /usr/local/share/zsh/plugins/kustomize/_kustomize

# Install Stern
RUN URL="`curl -fsSL -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/stern/stern/releases \
        | jq --raw-output '[.[] | select(.prerelease == false)] | .[0] | .assets | .[] | .browser_download_url | select(test(\"linux_amd64\\\\.tar\\\\.gz\$\"))'`" \
    && curl -fsSL --output tmp.tar.gz "${URL}" \
    && mkdir -p /usr/local/share/stern \
    && tar --strip-components=1 -C /usr/local/share/stern -xvf tmp.tar.gz \
    && ln -sf /usr/local/share/stern/stern /usr/local/bin/stern \
    && rm -f tmp.tar.gz

# Install telepresence
RUN URL='https://app.getambassador.io/download/tel2/linux/amd64/latest/telepresence' \
    && mkdir -p /usr/local/share/telepresence \
    && curl -fsSL --output /usr/local/share/telepresence/telepresence "${URL}" \
    && chmod a+x /usr/local/share/telepresence/telepresence \
    && ln -sf /usr/local/share/telepresence/telepresence /usr/local/bin/telepresence \
    && URL='https://raw.githubusercontent.com/telepresenceio/telepresence/release/v2/LICENSE' \
    && curl -fsSL --output /usr/local/share/telepresence/LICENSE "${URL}"

COPY k3s-start.sh /usr/local/share/k3s-start.sh

USER ${USERNAME}
WORKDIR /home/${USERNAME}

# Configure ZSH
RUN echo "zmodule '/usr/local/share/zsh/plugins' -f 'k9s' -f 'kustomize'" \
        | sed -i '/^# INSERT BEFORE COMPINIT/r /dev/stdin' ~/.zimrc \
    && echo "zmodule ohmyzsh/ohmyzsh --root plugins \
        -s 'helm/helm.plugin.zsh' -s 'kubectl/kubectl.plugin.zsh'" \
        | sed -i '/^# INSERT AFTER COMPINIT/r /dev/stdin' ~/.zimrc \
    && echo "zmodule '/usr/local/share/zsh/plugins/crictl' -s 'crictl.zsh'" \
        | sed -i '/^# INSERT AFTER COMPINIT/r /dev/stdin' ~/.zimrc \
    && echo "zmodule '$HOME/.config/zsh' -s 'kuberc.zsh'" \
        | sed -i '/^# INSERT AFTER COMPINIT/r /dev/stdin' ~/.zimrc

# Enable Kubernetes context and namespace in prompt
RUN mkdir -p ~/.config \
    && echo '[kubernetes]' >> ~/.config/starship.toml \
    && echo 'disabled = false' >> ~/.config/starship.toml

# Copy configuration
COPY --chown=${USERNAME}:${USERNAME} config .config

RUN echo 'export KUBECONFIG="$HOME/.kube/config"' >> ~/.config/zsh/env.zshrc

# Create .kube dir so it can be used for a volume mount
RUN umask 'u=rwx,go=' && mkdir -p "$HOME/.kube"

# To run zimfw install
RUN zsh -c 'export TERM=xterm && source ~/.zshrc'

USER root
WORKDIR /

ENTRYPOINT ["/usr/local/share/docker-init.sh", "/usr/local/share/k3s-start.sh"]
CMD ["sleep", "infinity"]
