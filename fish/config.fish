function attach_session
    tmux ls
    echo -n 'Attach session'
    set session (read)
    tmux attach -t $session
end

bind \cf '~/.config/fish/tmux_sessionizer.fish'
bind \cq 'tmux detach'
bind \ca attach_session
bind \cl 'tmux ls'
