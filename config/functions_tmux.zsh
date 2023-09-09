ide() {
  if [ "$#" -eq 0 ]; then
    tmux split-window -v
    tmux split-window -h
    tmux resize-pane -D 15
    tmux select-pane -t 1
  else
    case $1 in
    1)
      tmux split-window -v
      tmux resize-pane -D 15
      tmux select-pane -D
      clear
      ;;
    2)
      tmux split-window -h
      tmux split-window -v
      tmux resize-pane -D 15
      tmux select-pane -t 1
      tmux split-window -v
      tmux select-pane -t 1
      clear
      ;;
    3)
      tmux split-window -v
      ;;
    4)
      tmux split-window -h
      ;;
    py)
      tmux split-window -v
      tmux split-window -h
      tmux resize-pane -D 15
      tmux select-pane -t 1
      clear
      ;;
    *)
      echo [ERROR] "$1" is an invalid argument.
      ;;
    esac
  fi
}
