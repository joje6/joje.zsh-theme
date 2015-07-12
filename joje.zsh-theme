eval fff='$FG[231]'
eval eee='$FG[007]'
eval gray='$FG[237]'
eval orange='$FG[214]'
eval lightorange='$FG[178]'
eval green='$FG[064]'
eval lightgreen='$FG[113]'
eval red='$FG[001]'
eval lightred='$FG[196]'
eval blue='$FG[032]'
eval lightblue='$FG[081]'

# echo $ZSH_JOJE_VCS_COLOR
# echo $ZSH_JOJE_VCS_DIRTY_COLOR
# echo $ZSH_JOJE_LABEL
# echo $ZSH_JOJE_CWD_LEVEL

dirtycolor="*"

if [[ $ZSH_JOJE_VCS_COLOR == "blue" ]]; then
  color=$blue;
  lightcolor=$lightblue;
elif [[ $ZSH_JOJE_VCS_COLOR == "green" ]]; then
  color=$green;
  lightcolor=$lightgreen;
elif [[ $ZSH_JOJE_VCS_COLOR == "orange" ]]; then
  color=$orange;
  lightcolor=$lightorange;
elif [[ $ZSH_JOJE_VCS_COLOR == "red" ]]; then
  color=$red;
  lightcolor=$lightred;
elif [[ $ZSH_JOJE_VCS_COLOR == "white" ]]; then
  color=$eee;
  lightcolor=$fff;
elif [[ $ZSH_JOJE_VCS_COLOR == "gray" ]]; then
  color=$eee;
  lightcolor=$gray;
else
  color=$blue;
  lightcolor=$lightblue;
fi

if [[ $ZSH_JOJE_VCS_DIRTY_COLOR == "blue" ]]; then
  dirtycolor=$blue;
elif [[ $ZSH_JOJE_VCS_DIRTY_COLOR == "green" ]]; then
  dirtycolor=$green;
elif [[ $ZSH_JOJE_VCS_DIRTY_COLOR == "orange" ]]; then
  dirtycolor=$orange;
elif [[ $ZSH_JOJE_VCS_DIRTY_COLOR == "red" ]]; then
  dirtycolor=$red;
elif [[ $ZSH_JOJE_VCS_DIRTY_COLOR == "lightblue" ]]; then
  dirtycolor=$lightblue;
elif [[ $ZSH_JOJE_VCS_DIRTY_COLOR == "lightgreen" ]]; then
  dirtycolor=$lightgreen;
elif [[ $ZSH_JOJE_VCS_DIRTY_COLOR == "lightorange" ]]; then
  dirtycolor=$lightorange;
elif [[ $ZSH_JOJE_VCS_DIRTY_COLOR == "lightred" ]]; then
  dirtycolor=$lightred;
elif [[ $ZSH_JOJE_VCS_DIRTY_COLOR == "gray" ]]; then
  dirtycolor=$eee;
elif [[ $ZSH_JOJE_VCS_DIRTY_COLOR == "white" ]]; then
  dirtycolor=$white;
fi

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

is_vcs_dirty() {
  if [[ $(is_git_inside) == 1 ]]; then
    echo $(is_git_dirty)
  elif [[ $(whence in_svn) != "" ]] && in_svn; then
    echo 0
  elif [[ $(whence in_hg) != "" ]] && in_hg; then
    echo 0
  else
    echo 0
  fi
}

label_vcs() {  
  if [[ $(vcs_status) == "" ]]; then
    echo ""
  else 
    if [[ $dirtycolor == "*" ]]; then
      if [[ $(is_vcs_dirty) == 1 ]]; then
        echo "%{$reset_color%}%{$lightcolor%}[%{$color%}$(vcs_status)%{$red%}+%{$lightcolor%}]%{$reset_color%}"
      else
        echo "%{$reset_color%}%{$lightcolor%}[%{$color%}$(vcs_status)%{$lightcolor%}]%{$reset_color%}"
      fi
    elif [[ $(is_vcs_dirty) == 1 ]]; then
      echo "%{$reset_color%}%{$lightcolor%}[%{$dirtycolor%}$(vcs_status)%{$lightcolor%}]%{$reset_color%}"
    else
      echo "%{$reset_color%}%{$lightcolor%}[%{$color%}$(vcs_status)%{$lightcolor%}]%{$reset_color%}"
    fi
  fi
}

label_cwd() {
  if [[ $ZSH_JOJE_CWD_LEVEL == "1" ]]; then
    echo "$eee%1~"
  elif [[ $ZSH_JOJE_CWD_LEVEL == "2" ]]; then
    echo "$eee%2~"
  elif [[ $ZSH_JOJE_CWD_LEVEL == "3" ]]; then
    echo "$eee%3~"
  elif [[ $ZSH_JOJE_CWD_LEVEL == "4" ]]; then
    echo "$eee%4~"
  elif [[ $ZSH_JOJE_CWD_LEVEL == "full" ]]; then
    echo "$eee%~"
  else
    echo "$eee%2~"
  fi
}

label_suffix() {
  echo "$fff:~$%b"
}

print_prompt() {
  # echo "$(is_git_inside) $(is_git_dirty)"

  if [[ $(vcs_status) == "" ]]; then
    echo '$(label_cwd)$(label_suffix) '
  elif [[ $ZSH_JOJE_LABEL == "vcs" ]]; then
    echo '$(label_vcs)$(label_suffix) '
  elif [[ $ZSH_JOJE_LABEL == "cwd" ]]; then
    echo '$(label_cwd)$(label_suffix) '
  elif [[ $ZSH_JOJE_LABEL == "cwd+vcs" ]]; then
    echo '$(label_cwd) $(label_vcs)$(label_suffix) '
  elif [[ $ZSH_JOJE_LABEL == "vcs+cwd" ]]; then
    echo '$(label_vcs) $(label_cwd)$(label_suffix) '
  else
    echo '$(label_vcs) $(label_cwd)$(label_suffix) '
  fi
}

PROMPT="$(print_prompt)"
