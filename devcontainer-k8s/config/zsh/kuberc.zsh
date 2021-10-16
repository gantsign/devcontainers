if [[ ! -f "$HOME/.kube/config" ]] && [[ -s /etc/rancher/k3s/k3s.yaml ]]; then
    (umask 'u=rw,go=' && sudo cat /etc/rancher/k3s/k3s.yaml > "$HOME/.kube/config")
    kubectx k3s=default || true
fi
