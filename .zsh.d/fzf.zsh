if type fzf &> /dev/null; then
    # Auto-completion
    # ---------------
    [[ $- == *i* ]] && source "/usr/local/Cellar/fzf/0.17.4/shell/completion.zsh" 2> /dev/null

    # Key bindings
    # ------------
    source "/usr/local/Cellar/fzf/0.17.4/shell/key-bindings.zsh"
fi

