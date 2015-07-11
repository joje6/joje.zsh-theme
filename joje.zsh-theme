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

# echo $ZSH_JOJE_COLOR
# echo $ZSH_JOJE_LABEL

if [[ $ZSH_JOJE_COLOR == "blue" ]] then
  color=$blue;
  lightcolor=$lightblue;
elif [[ $ZSH_JOJE_COLOR == "green" ]] then
  color=$green;
  lightcolor=$lightgreen;
elif [[ $ZSH_JOJE_COLOR == "orange" ]] then
  color=$orange;
  lightcolor=$lightorange;
elif [[ $ZSH_JOJE_COLOR == "red" ]] then
  color=$red;
  lightcolor=$lightred;
elif [[ $ZSH_JOJE_COLOR == "white" ]] then
  color=$eee;
  lightcolor=$fff;
else
  color=$blue;
  lightcolor=$lightblue;
fi

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$lightcolor%}[%{$color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$red%}+%{$lightcolor%}]%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$lightcolor%}]%{$reset_color%} "
ZSH_THEME_SVN_PROMPT_PREFIX=$ZSH_THEME_GIT_PROMPT_PREFIX
ZSH_THEME_SVN_PROMPT_SUFFIX=$ZSH_THEME_GIT_PROMPT_SUFFIX
ZSH_THEME_SVN_PROMPT_DIRTY=$ZSH_THEME_GIT_PROMPT_DIRTY
ZSH_THEME_SVN_PROMPT_CLEAN=$ZSH_THEME_GIT_PROMPT_CLEAN
ZSH_THEME_HG_PROMPT_PREFIX=$ZSH_THEME_GIT_PROMPT_PREFIX
ZSH_THEME_HG_PROMPT_SUFFIX=$ZSH_THEME_GIT_PROMPT_SUFFIX
ZSH_THEME_HG_PROMPT_DIRTY=$ZSH_THEME_GIT_PROMPT_DIRTY
ZSH_THEME_HG_PROMPT_CLEAN=$ZSH_THEME_GIT_PROMPT_CLEAN

vcs_status() {
  if [[ $(whence in_svn) != "" ]] && in_svn; then
    svn_prompt_info
  elif [[ $(whence in_hg) != "" ]] && in_hg; then
    hg_prompt_info
  else
    git_prompt_info
  fi
}

if [[ $ZSH_JOJE_LABEL == "cwd-1" ]] then
  PROMPT='$(vcs_status)$eee%1~$fff:~$%b '
elif [[ $ZSH_JOJE_LABEL == "cwd-2" ]] then
  PROMPT='$(vcs_status)$eee%2~$fff:~$%b '
elif [[ $ZSH_JOJE_LABEL == "cwd-3" ]] then
  PROMPT='$(vcs_status)$eee%3~$fff:~$%b '
elif [[ $ZSH_JOJE_LABEL == "cwd-full" ]] then
  PROMPT='$(vcs_status)$eee%~$fff:~$%b '
elif [[ $ZSH_JOJE_LABEL == "vcs-only" ]] then
  PROMPT='$(vcs_status):~$%b '
elif [[ $ZSH_JOJE_LABEL == "cwd-only" ]] then
  PROMPT='$eee%~$fff:~$%b '
else
  PROMPT='$(vcs_status)$eee%2~$fff:~$%b '
fi


