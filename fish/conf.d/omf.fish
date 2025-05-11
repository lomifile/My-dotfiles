# Path to Oh My Fish install.
set -q XDG_DATA_HOME
and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
or set -gx OMF_PATH "$HOME/.local/share/omf"

bind \cf '~/.config/fish/tmux_sessionizer.fish'
bind \cq 'tmux detach'
bind \ca attach_session
bind \cl 'tmux ls'

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish
fenv source ~/.nix-profile/etc/profile.d/nix.sh
