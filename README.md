# joje.zsh-theme
This is [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) theme.

## Installation
```sh
curl -L https://raw.githubusercontent.com/joje6/joje.zsh-theme/master/install.sh | zsh
```
Or
```sh
wget https://raw.githubusercontent.com/joje6/joje.zsh-theme/master/install.sh -O - | zsh
```

Or you can cloning and creating a symbol link by yourself:
```sh
mkdir -p $ZSH_CUSTOM/themes
cd $ZSH_CUSTOM/themes
git clone git://github.com/joje6/joje.zsh-theme.git joje
ln -s joje/*.zsh-theme .
```

And edit your `~/.zshrc`
```sh
ZSH_THEME=joje
```

## Setup Style
Edit your `~/.zprofile`(or `~/.zshrc`) file
```sh
export ZSH_JOJE_LABEL=vcs+cwd         # cwd vcs (vcs+cwd) cwd+vcs
export ZSH_JOJE_CWD_LEVEL=2           # 1 (2) 3 4 full
```

## Update
```sh
cd ~/.oh-my-zsh/custom/themes/joje
git pull --ff-only origin master
```

## Screenshot
![Screenshot](https://raw.github.com/joje6/joje.zsh-theme/master/screenshot.png)

- Status Color
  - untracked: lightred
  - modified: red
  - staged: orange
  - committed: green
  - pushed: blue
- OSX terminal color scheme [`smyck`](http://color.smyck.org/)
- Menlo Regular 10pt

## Notice
- Installer & README forked from ...
https://github.com/tonyseek/oh-my-zsh-seeker-theme

- And theme file modified from ...
https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/minimal.zsh-theme

:)