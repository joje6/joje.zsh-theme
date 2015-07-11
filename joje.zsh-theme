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
# echo $ZSH_JOJE_CWD_LEVEL

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
 
if [[ $ZSH_JOJE_CWD_LEVEL == "1" ]] then
  cwd_style='%1~'
elif [[ $ZSH_JOJE_CWD_LEVEL == "2" ]] then
  cwd_style='%2~'
elif [[ $ZSH_JOJE_CWD_LEVEL == "3" ]] then
  cwd_style='%3~'
elif [[ $ZSH_JOJE_CWD_LEVEL == "4" ]] then
  cwd_style='%4~'
elif [[ $ZSH_JOJE_CWD_LEVEL == "full" ]] then
  cwd_style='%~'
else
  cwd_style='%2'
fi


if [[ $ZSH_JOJE_LABEL == "vcs" ]] then
  PROMPT='$(vcs_status):~$%b '
elif [[ $ZSH_JOJE_LABEL == "cwd" ]] then
  PROMPT='$eee$cwd_style$fff:~$%b '
elif [[ $ZSH_JOJE_LABEL == "cwd+vcs" ]] then
  PROMPT='$eee$cwd_style $(vcs_status)$fff:~$%b '
elif [[ $ZSH_JOJE_LABEL == "vcs+cwd" ]] then
  PROMPT='$(vcs_status)$eee$cwd_style~$fff:~$%b '
else
  PROMPT='$(vcs_status)$eee$cwd_style~$fff:~$%b '
fi
