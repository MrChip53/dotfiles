GREEN_CHECK="%{$FG[010]%}✓%{$reset_color%}"
RED_X="%{$FG[001]%}✘%{$reset_color%}"

prompt_indicator_raw() {
  echo $'%B\u276f%b'
}

prompt_indicator() {
  echo "%(?.%{$FG[010]%}$(prompt_indicator_raw)%{$reset_color%}.%{$FG[001]%}$(prompt_indicator_raw)%{$reset_color%})"
}

username() {
  echo "%{$FG[177]%}%n%{$reset_color%}"
}

host() {
  echo "%{$FG[177]%}%m%{$reset_color%}"
}

directory() {
  echo "%{$FG[105]%}%0~%{$reset_color%}"
}

current_time() {
  echo "%{$FG[105]%}%*%{$reset_color%}"
}

return_status() {
  echo "%(?.${GREEN_CHECK}.${RED_X})"
}

open_bracket() {
  echo "%{$FG[008]%}[%{$reset_color%}"
}

close_bracket() {
  echo "%{$FG[008]%}]%{$reset_color%}"
}

at_sign() {
  echo "%{$FG[008]%}@%{$reset_color%}"
}

precmd_hook() {
  MESO_ONLINE_STATUS=`cat /opt/mesocheck/status.txt`

  MESO_STATUS="%{$FG[196]%}OFFLINE%{$reset_color%}"
  if [[ "$MESO_ONLINE_STATUS" == "0" ]]; then
    MESO_STATUS="%{$FG[040]%}ONLINE%{$reset_color%}"
  fi
}

meso_status() {
  echo "%{$FG[063]%}Mesocast: %{$reset_color%}${MESO_STATUS}"
}

hyphen() {
  echo "%{$FG[008]%}-%{$reset_color%}"
}

NEWLINE=$'\n'

autoload -U add-zsh-hook
add-zsh-hook precmd precmd_hook

# get_prompt_info
ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[008]%}[%{$FG[010]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$FG[008]%}] - %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="${RED_X}"
ZSH_THEME_GIT_PROMPT_CLEAN="${GREEN_CHECK}"

# git_prompt_status
ZSH_THEME_GIT_PROMPT_ADDED="%{$FG[cyan]%} ✈%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$FG[yellow]%} ✭%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$FG[red]%} ✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$FG[blue]%} ➦%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$FG[magenta]%} ✂%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$FG[white]%} ✱%{$reset_color%}"

PROMPT='%B$(open_bracket)$(username)$(at_sign)$(host)$(close_bracket) $(hyphen) \
$(open_bracket)$(current_time)$(close_bracket) $(hyphen) \
$(open_bracket)$(meso_status)$(close_bracket) $(hyphen) \
$(git_prompt_info)\
$(open_bracket)$(directory)$(close_bracket)\
%b${NEWLINE}$(prompt_indicator) '
RPROMPT='$(git_prompt_status)'
