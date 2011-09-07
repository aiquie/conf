
# загружаем дефолтный профиль оболочки
source /etc/profile

# поддержка цветов
autoload -U colors && colors

# Установка prompt
 PROMPT="%{$fg_bold[cyan]%} %~/%{$reset_color%} "
RPROMPT="%{$fg_bold[cyan]%}%*%{$reset_color%} %(?,:],:[)"

# совместимость с vi
bindkey -v

# сокращенный ввод
autoload -U compinit && compinit

# меню автодополнения
zmodload zsh/complist
zstyle ':completion:*' menu yes select

# цвета для файлов и папок в меню автодоплнения
export CLICOLOR=1
export LS_COLORS='di=34;40:ln=35;40:so=36;40:pi=32;40:ex=31;40:bd=33;40:cd=33;40:su=0;41:sg=0;41:tw=0;44:ow=0;44:'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# кэш для автодоплнений
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh_cache

# опция перехода по каталогам без команды cd
setopt AUTO_CD

# автодоплнения для ssh хостов
if [ -e ~/.ssh/known_hosts ] ; then
  hosts=(${${${(f)"$(<~/.ssh/known_hosts)"}%%\ *}%%,*})
  zstyle ':completion:*:hosts' hosts $hosts
fi

# рассказка для kill
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=$color[cyan]=$color[red]"

# история
export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000
setopt APPEND_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS

# нормальные клавиши
typeset -g -A key
bindkey '^?' backward-delete-char
bindkey '^[[2~' yank
bindkey '^[[3~' delete-char
bindkey '^[[5~' up-line-or-history
bindkey '^[[6~' down-line-or-history
bindkey '^[[1~' beginning-of-line
bindkey '^[[7~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[8~' end-of-line
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey '^[[C' forward-char
bindkey '^[[D' backward-char
bindkey '^[e' expand-cmd-path
bindkey '^i' expand-or-complete-prefix
bindkey ' ' magic-space

# поиск по истории
autoload -U predict-on
zle -N predict-on
zle -N predict-off
bindkey "^X" predict-on
bindkey "^Z" predict-off

# нахождение новых команд
_force_rehash() {
  (( CURRENT == 1 )) && rehash
  return 1
}
zstyle ':completion:::::' completer _force_rehash _complete

# дополнительные комманды
autoload -U zcalc zed

# экранируем спецсимволы в url
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# экспортируем переменные окружения
export PAGER=most
export EDITOR=vim
export PATH=~/.bin:${PATH}

# alias
alias vi='vim'
alias vimv='vimv --editor=vim'
alias df='df -h'
alias du='du -sh'
alias grep='grep --color=auto'
alias fgrep='grep --color=auto'
alias ls='ls -hF --color=auto'
alias feh='feh -F'

alias configure="grc --colour=auto configure"
alias traceroute="grc --colour=auto traceroute"
alias ping="grc --colour=auto ping"
alias netstat="grc --colour=auto netstat"
alias gcc="grc --colour=auto gcc"
alias make="grc --colour=auto make"
alias diff="grc --colour=auto diff"
alias cvs="grc --colour=auto cvs"
alias cat="grc --colour=auto cat"
alias tail="grc --colour=auto tail"
alias head="grc --colour=auto head"

alias -s {avi,mpeg,mpg,mov,flv}=mplayer
alias -s {ogg,mp3,wav,wma}=mplayer
alias -s {txt,log}=most
alias -s {png,gif,jpg,jpeg}=feh 
alias -s {pdf,djvu}=apvlv
alias -s {html}=uzbl-browser

[[ -z $DISPLAY ]] && {
    true
}
