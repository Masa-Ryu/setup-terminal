# style
zstyle :compinstall filename '~/.zshrc'
autoload -Uz colors
autoload -Uz compinit
colors
compinit -u

zstyle ':completion:*:default' menu select
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt share_history
setopt append_history
setopt inc_append_history
setopt hist_reduce_blanks
setopt hist_ignore_space
setopt hist_no_store
setopt auto_pushd
setopt auto_cd
setopt correct
setopt cdable_vars
setopt print_eight_bit
setopt nonomatch
setopt list_types
setopt list_packed
precmd(){print ""}

# keybind
bindkey -v