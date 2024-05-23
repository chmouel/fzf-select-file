# FZF select file zsh plugin

A simple plugin to let you select some files on the command line with fzf and [eza](https://github.com/eza-community/eza)

## Install

Using [zplug](https://github.com/zplug/zplug)

```sh
zplug 'chmouel/fzf-select-file'
```

Or any ZSH plugin manager (I use this own made one
[vtplug](https://blog.chmouel.com/2022/03/18/vtplug-a-very-dumb-and-tiny-zsh-plugin-manager/))

You can as well simply git clone this repository and source the
`fzf-select-file.plugin.zsh` file if you want to do this just manually.

## Requirements

You need to have those tools installed:

- [fzf](https://github.com/junegunn/fzf) (for selection)
- [eza](https://github.com/eza-community/eza) (for listing)
- [bat](https://github.com/sharkdp/bat) (for preview)

## Usage

C-x C-f (or control-x followed by control-f) will launch fzf with a listing
from eza, you can select one or multiple files (with the tab keys) and it will
be added to the command line. If you have a word on the command line it will be
used as the initial query for fzf and replaced with the results.

By default it will show the files without the 'hidden' files (the ones starting
with a dot) if you want to include them you can use the C-x C-a (or control-x
followed by control-a) keybinding to show them.

While in selection it will show a preview with bat for
files or eza for directories (may fail on unknown files to bat) press
`control-v` to hide the preview.

## Demo

<https://github.com/chmouel/fzf-select-file/assets/98980/438c5e77-b6da-45b1-b5ed-e8eb61a93fa5>

## Configuration

You can customize some variables

- `ZSH_FZF_SELECT_FILE_FZF_ARGS`: The arguments to fzf.
- `ZSH_FZF_SELECT_FILE_EZA_BINARY`: The binary to use for eza, default to `eza`.
- `ZSH_FZF_SELECT_FILE_EZA_COLORS`: The eza colors to use default to `da=00`.
- `ZSH_FZF_SELECT_FILE_EZA_ARGS`: The arguments to eza.
- `ZSH_FZF_SELECT_FILE_BIND`: The keybinding to use default to "^x^f".
- `ZSH_FZF_SELECT_ALL_FILES_BIND`: The keybinding to use default when selecting
  all files including the dot files, default to `^x^a`.
- `ZSH_FZF_SELECT_FILE_FZF_PREVIEW`: The preview shell command (see source for default).

## TIPS

If you want to make Control-x Control-f select all you just need to set this in your config file before loading the plugin:

```zsh
ZSH_FZF_SELECT_ALL_FILES_BIND="^x^f"
```

## Copyright

[Apache-2.0](./LICENSE)

## Blog

- <https://blog.chmouel.com/posts/selecting-files-in-zsh-with-fzf/>

## Authors

Chmouel Boudjnah

- Fediverse - <[@chmouel@fosstodon.org](https://fosstodon.org/@chmouel)>
- Twitter - <[@chmouel](https://twitter.com/chmouel)>
- Blog - <[https://blog.chmouel.com](https://blog.chmouel.com)>

## Alternative

You can as well use the [FZF ZSH
Plugin](https://github.com/unixorn/fzf-zsh-plugin) to get _everything_ selected
with fzf in zsh but no pretty eza listing in there...

## Thanks

- Inspired by this great plug-in <https://github.com/joshskidmore/zsh-fzf-history-search>
