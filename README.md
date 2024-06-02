# nico's dotfiles

I'm using rcm to manage my dotfiles, if you don't know it go [get it][rcm].

## How to use

Before starting you need to setup [rcm][rcm].

```bash
echo "DOTFILES_DIRS=\"${PWD}/src\"" > ~/.rcrc
```

Every app has its own tag, to list the available tags:

```bash
ls src | sed 's/tag-//g'
```

There are some configurations that leak into one another, like for example
there's a _tmux_ config to accommodate _neovim_.

To install a tag:

```bash
rcup -t <tag>
```

[rcm]: https://github.com/thoughtbot/rcm

### TMUX

To install tpm:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```
