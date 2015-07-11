# joje.zsh-theme
This is [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) theme.

## Installation
```sh
curl -L https://raw.github.com/joje6/joje.zsh-theme/master/install.sh | zsh
```
Or
```sh
wget https://raw.github.com/joje6/joje.zsh-theme/master/install.sh -O - | zsh
```

Or you can cloning and creating a symbol link by yourself:
```sh
mkdir -p $ZSH_CUSTOM/themes
cd $ZSH_CUSTOM/themes
git clone git://github.com/tonyseek/oh-my-zsh-seeker-theme.git joje
ln -s joje/*.zsh-theme .
```

And edit your `~/.zshrc`
```sh
ZSH_THEME=joje
```

## Setup Style
Edit your `~/.zprofile`(or `~/.zshrc`) file
```sh
export ZSH_JOJE_COLOR=blue    # (blue) green orange red white
export ZSH_JOJE_LABEL=cwd-2   # cwd-1 cwd-2 (cwd-3) cwd-full cwd-only git-only
```

## Update
```sh
cd $HOME/.oh-my-zsh/custom/themes/joje
git pull --ff-only origin master
```

## Notice
- This packages's Installer & README forked from ...
https://github.com/tonyseek/oh-my-zsh-seeker-theme

- And theme file modified from ...
https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/minimal.zsh-theme

:)