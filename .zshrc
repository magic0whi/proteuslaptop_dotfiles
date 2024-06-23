autoload -Uz compinit promptinit
compinit
promptinit

# print an empty line before the PROMPT is rendered
precmd() { print "" }

zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES
zstyle ':completion::complete:*' gain-privileges 1

# Zsh Shell coloring start
# Reset
Color_Off=$'\e[m'       # Text Reset

# Regular Colors
Black=$'\e[0;30m'        # Black
Red=$'\e[0;31m'          # Red
Green=$'\e[0;32m'        # Green
Yellow=$'\e[0;33m'       # Yellow
Blue=$'\e[0;34m'         # Blue
Purple=$'\e[0;35m'       # Purple
Cyan=$'\e[0;36m'         # Cyan
White=$'\e[0;37m'        # White

# Bold
BBlack=$'\e[1;30m'       # Black
BRed=$'\e[1;31m'         # Red
BGreen=$'\e[1;32m'       # Green
BYellow=$'\e[1;33m'      # Yellow
BBlue=$'\e[1;34m'        # Blue
BPurple=$'\e[1;35m'      # Purple
BCyan=$'\e[1;36m'        # Cyan
BWhite=$'\e[1;37m'       # White

# Underline
UBlack=$'\e[4;30m'       # Black
URed=$'\e[4;31m'         # Red
UGreen=$'\e[4;32m'       # Green
UYellow=$'\e[4;33m'      # Yellow
UBlue=$'\e[4;34m'        # Blue
UPurple=$'\e[4;35m'      # Purple
UCyan=$'\e[4;36m'        # Cyan
UWhite=$'\e[4;37m'       # White

# Background
On_Black=$'\e[40m'       # Black
On_Red=$'\e[41m'         # Red
On_Green=$'\e[42m'       # Green
On_Yellow=$'\e[43m'      # Yellow
On_Blue=$'\e[44m'        # Blue
On_Purple=$'\e[45m'      # Purple
On_Cyan=$'\e[46m'        # Cyan
On_White=$'\e[47m'       # White

# High Intensity
IBlack=$'\e[0;90m'       # Black
IRed=$'\e[0;91m'         # Red
IGreen=$'\e[0;92m'       # Green
IYellow=$'\e[0;93m'      # Yellow
IBlue=$'\e[0;94m'        # Blue
IPurple=$'\e[0;95m'      # Purple
ICyan=$'\e[0;96m'        # Cyan
IWhite=$'\e[0;97m'       # White

# Bold High Intensity
BIBlack=$'\e[1;90m'      # Black
BIRed=$'\e[1;91m'        # Red
BIGreen=$'\e[1;92m'      # Green
BIYellow=$'\e[1;93m'     # Yellow
BIBlue=$'\e[1;94m'       # Blue
BIPurple=$'\e[1;95m'     # Purple
BICyan=$'\e[1;96m'       # Cyan
BIWhite=$'\e[1;97m'      # White

# High Intensity backgrounds
On_IBlack=$'\e[0;100m'   # Black
On_IRed=$'\e[0;101m'     # Red
On_IGreen=$'\e[0;102m'   # Green
On_IYellow=$'\e[0;103m'  # Yellow
On_IBlue=$'\e[0;104m'    # Blue
On_IPurple=$'\e[10;95m'  # Purple
On_ICyan=$'\e[0;106m'    # Cyan
On_IWhite=$'\e[0;107m'   # White
# Zsh Shell coloring end

# Set default prompt to redhat theme
#prompt redhat
source /usr/share/git/completion/git-prompt.sh
# %3~ Show folder levels max to 3
setopt PROMPT_SUBST; PS1='[%{$BRed%}%n%{$Color_Off%}@%{$BBlue%}%m%{$Color_Off%} %{$BBlue%}%3~%{$Color_Off%} %{$BCyan%}$(__git_ps1 "(%s)")%{$Color_Off%}]%{$BGreen%}%(#.#.$)%{$Color_Off%} '

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete
[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
        autoload -Uz add-zle-hook-widget
        function zle_application_mode_start { echoti smkx }
        function zle_application_mode_stop { echoti rmkx }
        add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
        add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

# History settings
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY

# You need install zsh-syntax-highlighting zsh-autosuggestions zsh-history-substring-search
export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)
export ZSH_AUTOSUGGEST_USE_ASYNC=true
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

setopt extendedglob

export SHELL=/bin/zsh

[ -f $HOME/.bashrc ] && source $HOME/.bashrc
# Completion for alias gitdot
compdef gitdot='git'
