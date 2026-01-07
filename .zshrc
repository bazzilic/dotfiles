# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

setopt ignore_eof
bindkey '^d' delete-char

# 1) Tell ZLE to highlight the region between mark and cursor:
typeset -gA zle_highlight
# use reverse-video; you can also pick fg=/bg= colors, e.g. bg=4,fg=15
zle_highlight[region]='reverse'

# 2) (Optional) make the cursor line standout so you can always see it:
zle_highlight[cursor]='standout'

# 3) Re-bind your selection widgets if you haven’t already:
#    these set a mark then move, so ZLE knows “this” is the highlighted region

select-word-back() { zle set-mark-command; zle backward-word }
select-word-fwd()  { zle set-mark-command; zle forward-word }
select-line-begin(){ zle set-mark-command; zle beginning-of-line }
select-line-end()  { zle set-mark-command; zle end-of-line }

zle -N select-word-back
zle -N select-word-fwd
zle -N select-line-begin
zle -N select-line-end

# 4) Bind the Shift+… keys you’ve already got in iTerm2
bindkey '\e[1;4D' select-word-back    # ⇧⌥←
bindkey '\e[1;4C' select-word-fwd     # ⇧⌥→
bindkey '\e[1;2D' select-line-begin   # ⇧⌘←
bindkey '\e[1;2H' select-line-begin   # ⇧Home
bindkey '\e[1;2C' select-line-end     # ⇧⌘→
bindkey '\e[1;2F' select-line-end     # ⇧End

eval "$(/opt/homebrew/bin/brew shellenv)"

# revisit when Python version changes!
export PATH="$(brew --prefix)/opt/python@3.11/libexec/bin:$PATH"
export PATH="${HOME}/Library/Python/3.11/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

ZSH_THEME="powerlevel10k/powerlevel10k"

autoload -Uz compinit
compinit -C

source ~/.antidote/antidote.zsh
source ~/.zsh_plugins.zsh

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.

bindkey  '^[[A'   history-substring-search-up
bindkey  '^[[B'   history-substring-search-down

alias config="$(which git) --git-dir=\$HOME/.cfg/ --work-tree=\$HOME"

export PATH="$PATH:${HOME}/.local/bin:${HOME}/.dotnet/tools"

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

DROPBOX="${HOME}/Library/CloudStorage/Dropbox"
PROJECTS="${DROPBOX}/Projects"
SYNNAX="${PROJECTS}/Synnax"
alias dropbox="cd $DROPBOX"
alias proj="cd $PROJECTS"
alias synnax="cd $SYNNAX"

alias brch="brew update && brew outdated"
alias brup="brew upgrade && brew cleanup"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
