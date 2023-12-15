GREEN_CHECK="%{$FG[010]%}✓"
RED_X="%{$FG[001]%}✘"

right_triangle() {
  echo $'\ue0b0'
}

semi_circle_left() {
  echo $'\ue0b6'
}

semi_circle_right() {
  echo $'\ue0b4'
}

prompt_indicator_raw() {
  echo $'%B\ue0cc%b '
}

prompt_indicator() {
  echo "%(?.%{$FG[010]%}$(prompt_indicator_raw)%{$reset_color%}.%{$FG[001]%}$(prompt_indicator_raw)%{$reset_color%})"
}

arrow_start() {
  echo "%{$FG[$ARROW_FG]%}%{$BG[$ARROW_BG]%}%B"
}

arrow_end() {
  echo "%b%{$reset_color%}%{$FG[$NEXT_ARROW_FG]%}%{$BG[$NEXT_ARROW_BG]%}$(right_triangle)%{$reset_color%}"
}

circle_start() {
  echo "%{$reset_color%}%{$FG[$ARROW_BG]%}$(semi_circle_left)%{$FG[$ARROW_FG]%}%{$BG[$ARROW_BG]%}%B"
}

circle_end() {
  echo "%b%{$reset_color%}%{$FG[$NEXT_ARROW_FG]%}%{$BG[$NEXT_ARROW_BG]%}$(semi_circle_right)%{$reset_color%}"
}

precmd_hook() {
  MESO_ONLINE_STATUS=`cat /opt/mesocheck/status.txt`

  MESO_STATUS="${RED_X}"
  if [[ "$MESO_ONLINE_STATUS" == "0" ]]; then
    MESO_STATUS="${GREEN_CHECK}"
  fi
}

username() {
  ARROW_FG="183"
  ARROW_BG="055"
  NEXT_ARROW_BG="093"
  NEXT_ARROW_FG="055"
  echo "$(circle_start) %n $(arrow_end)"
}

current_time() {
  ARROW_FG="183"
  ARROW_BG="093"
  NEXT_ARROW_BG="099"
  NEXT_ARROW_FG="093"
  echo "$(arrow_start) %* $(arrow_end)"
}

meso_status() {
  ARROW_FG="183"
  ARROW_BG="099"
  NEXT_ARROW_BG="105"
  NEXT_ARROW_FG="099"
  echo "$(arrow_start) Mesocast${MESO_STATUS} $(arrow_end)"
}

directory() {
  ARROW_FG="183"
  ARROW_BG="105"
  NEXT_ARROW_BG=""
  NEXT_ARROW_FG="105"
  echo "$(arrow_start) %0~ $(circle_end)"
}

NEWLINE=$'\n'

autoload -U add-zsh-hook
add-zsh-hook precmd precmd_hook

# get_prompt_info
ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="${RED_X}"
ZSH_THEME_GIT_PROMPT_CLEAN="${GREEN_CHECK}"

# git_prompt_status
ZSH_THEME_GIT_PROMPT_ADDED="%{$FG[cyan]%} ✈%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$FG[yellow]%} ✭%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$FG[red]%} ✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$FG[blue]%} ➦%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$FG[magenta]%} ✂%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$FG[white]%} ✱%{$reset_color%}"

PROMPT='%B$(username)\
$(current_time)\
$(meso_status)\
$(directory)\
$(git_prompt_info)\
%b${NEWLINE}$(prompt_indicator) '
RPROMPT='$(git_prompt_status)'
