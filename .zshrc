## use a symbolic link to replace the fixed sock path, allowing for dynamic updates.
if [[ -n "$TMUX" ]]; then
  export SSH_AUTH_SOCK="$HOME/.ssh/$(basename "$(dirname "$TMUX")")-$(tmux display-message -p "#{session_id}" | tr -d '$').sock"
fi