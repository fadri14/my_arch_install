if status is-interactive
    set -g fish_greeting ''

    export EDITOR=/usr/bin/nvim
    export PATH="$HOME/.config/myscripts/:$PATH"
    export PATH="$PATH:$HOME/.cargo/bin/"
    export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock

    bind \eh 'wtype !!\n'
    bind \e\r 'wtype -M ctrl -k f -m ctrl ; wtype \n'
    bind \er 'wtype -M alt -k Left -m alt'
    bind \en 'wtype -M alt -k Right -m alt'
    bind \ew backward-kill-path-component
    bind \eg 'wtype " | grep "'

    starship init fish | source
    zoxide init --cmd e fish | source
end
