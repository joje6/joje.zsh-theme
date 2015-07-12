eval fff='$FG[231]'
eval eee='$FG[252]'
eval ccc='$FG[007]'
eval gray='$FG[237]'
eval orange='$FG[214]'
eval lightorange='$FG[178]'
eval green='$FG[064]'
eval lightgreen='$FG[113]'
eval red='$FG[001]'
eval lightred='$FG[196]'
eval blue='$FG[032]'
eval lightblue='$FG[081]'

# echo $ZSH_JOJE_LABEL
# echo $ZSH_JOJE_CWD_LEVEL

# ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$lightcolor%}[%{$color%}"
# ZSH_THEME_GIT_PROMPT_SUFFIX=""
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$red%}+%{$lightcolor%}]%{$reset_color%} "
# ZSH_THEME_GIT_PROMPT_CLEAN="%{$lightcolor%}]%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_SVN_PROMPT_PREFIX=$ZSH_THEME_GIT_PROMPT_PREFIX
ZSH_THEME_SVN_PROMPT_SUFFIX=$ZSH_THEME_GIT_PROMPT_SUFFIX
ZSH_THEME_SVN_PROMPT_DIRTY=$ZSH_THEME_GIT_PROMPT_DIRTY
ZSH_THEME_SVN_PROMPT_CLEAN=$ZSH_THEME_GIT_PROMPT_CLEAN
ZSH_THEME_HG_PROMPT_PREFIX=$ZSH_THEME_GIT_PROMPT_PREFIX
ZSH_THEME_HG_PROMPT_SUFFIX=$ZSH_THEME_GIT_PROMPT_SUFFIX
ZSH_THEME_HG_PROMPT_DIRTY=$ZSH_THEME_GIT_PROMPT_DIRTY
ZSH_THEME_HG_PROMPT_CLEAN=$ZSH_THEME_GIT_PROMPT_CLEAN


is_git_inside() {
  if [[ "$(command git rev-parse --is-inside-work-tree 2> /dev/null)" == "true" ]]; then
    echo 1
  else
    echo 0
  fi
}

is_git_dirty() {
  local STATUS=''
  local FLAGS
  FLAGS=('--porcelain')
  if [[ "$(command git config --get oh-my-zsh.hide-dirty)" != "1" ]]; then
    if [[ $POST_1_7_2_GIT -gt 0 ]]; then
      FLAGS+='--ignore-submodules=dirty'
    fi
    if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]; then
      FLAGS+='--untracked-files=no'
    fi
    STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)
  fi
  if [[ -n $STATUS ]]; then
    echo 1
  else
    echo 0
  fi
}

vcs_status() {
  if [[ $(is_git_inside) == 1 ]]; then
    git_prompt_info
  elif [[ $(whence in_svn) != "" ]] && in_svn; then
    svn_prompt_info
  elif [[ $(whence in_hg) != "" ]] && in_hg; then
    hg_prompt_info
  else
    echo ""
  fi
}

__label_vcs() {
  if [[ $(vcs_status) == "" ]]; then
    echo ""
  else 
    if [[ $dirtycolor == "*" ]]; then
      if [[ $(is_git_dirty) == 1 ]]; then
        echo "%{$reset_color%}%{$lightcolor%}[%{$color%}$(vcs_status)%{$red%}+%{$lightcolor%}]%{$reset_color%}"
      else
        echo "%{$reset_color%}%{$lightcolor%}[%{$color%}$(vcs_status)%{$lightcolor%}]%{$reset_color%}"
      fi
    elif [[ $(is_git_dirty) == 1 ]]; then
      echo "%{$reset_color%}%{$lightcolor%}[%{$dirtycolor%}$(vcs_status)%{$lightcolor%}]%{$reset_color%}"
    else
      echo "%{$reset_color%}%{$lightcolor%}[%{$color%}$(vcs_status)%{$lightcolor%}]%{$reset_color%}"
    fi
  fi
}

# not in git
# untracked "Untracked files:" (lightred)
# modified "added to commit" "Changes not staged for commit:" (red)
# staged "Changes to be committed" (orange)
# committed "nothing to commit, working directory clean" (green)
# pushed "git diff origin/$(git name-rev --name-only HEAD)..HEAD --name-status 2>/dev/null" (blue)
# unknown (megenta)
function parse_git_status() {
  local git_status=""
  
  if [[ $(command git status | grep 'Changes not staged for commit:' 2> /dev/null) != "" ]]; then
    git_status="modified"
  elif [[ $(command git status | grep 'Untracked files:' 2> /dev/null) != "" ]]; then
    git_status="untracked"
  elif [[ $(command git status | grep 'Changes to be committed' 2> /dev/null) != "" ]]; then
    git_status="staged"
  elif [[ $(command git diff origin/$(git name-rev --name-only HEAD)..HEAD --name-status 2> /dev/null) == "" ]]; then
    git_status="pushed"
  elif [[ $(command git status | grep 'nothing to commit' 2> /dev/null) != "" ]]; then
    git_status="committed"
  else
    git_status="unknwon"
  fi
  
  echo $git_status
}

label_vcs() {
  local git_status=$(parse_git_status)
  # echo $git_status
  
  if [[ $(vcs_status) == "" ]]; then
    echo ""
  else
    local label_color=$ccc
    local label_lightcolor=$eee
    
    if [[ $git_status == "untracked" ]]; then
      label_color=$lightred
      label_lightcolor=$red
    elif [[ $git_status == "modified" ]]; then
      label_color=$red
      label_lightcolor=$lightred
    elif [[ $git_status == "staged" ]]; then
      label_color=$orange
      label_lightcolor=$lightorange
    elif [[ $git_status == "committed" ]]; then
      label_color=$green
      label_lightcolor=$lightgreen
    elif [[ $git_status == "pushed" ]]; then
      label_color=$blue
      label_lightcolor=$lightblue
    fi
    
    echo "%{$reset_color%}%{$label_lightcolor%}[%{$label_color%}$(vcs_status)%{$label_lightcolor%}]%{$reset_color%}"
  fi
}

label_cwd() {
  if [[ $ZSH_JOJE_CWD_LEVEL == "1" ]]; then
    echo "$ccc%1~"
  elif [[ $ZSH_JOJE_CWD_LEVEL == "2" ]]; then
    echo "$ccc%2~"
  elif [[ $ZSH_JOJE_CWD_LEVEL == "3" ]]; then
    echo "$ccc%3~"
  elif [[ $ZSH_JOJE_CWD_LEVEL == "4" ]]; then
    echo "$ccc%4~"
  elif [[ $ZSH_JOJE_CWD_LEVEL == "full" ]]; then
    echo "$ccc%~"
  else
    echo "$ccc%2~"
  fi
}

label_suffix() {
  echo "$eee:~$%b"
}

print_prompt() {
  if [[ $(vcs_status) == "" ]]; then
    echo "$(label_cwd)$(label_suffix) "
  elif [[ $ZSH_JOJE_LABEL == "vcs" ]]; then
    echo "$(label_vcs)$(label_suffix) "
  elif [[ $ZSH_JOJE_LABEL == "cwd" ]]; then
    echo "$(label_cwd)$(label_suffix) "
  elif [[ $ZSH_JOJE_LABEL == "cwd+vcs" ]]; then
    echo "$(label_cwd) $(label_vcs)$(label_suffix) "
  elif [[ $ZSH_JOJE_LABEL == "vcs+cwd" ]]; then
    echo "$(label_vcs) $(label_cwd)$(label_suffix) "
  else
    echo "$(label_vcs) $(label_cwd)$(label_suffix) "
  fi
}

PROMPT='$(print_prompt)'
