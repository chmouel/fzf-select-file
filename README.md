# FZF select file zsh plugin

A simple plugin to let you select some files on the command line with fzf and exa

## Install

with [zplug](https://github.com/zplug/zplug)

```sh
zplug 'chmouel/fzf-select-file'
```

or whatever is your zsh plugin manager (ie: [vtplug](https://blog.chmouel.com/2022/03/18/vtplug-a-very-dumb-and-tiny-zsh-plugin-manager/))

You can as well simply git clone this repository and source the
`fzf-select-file.plugin.zsh` file if you want to do this just manually.

## Requirements

You need to have those tools installed:

* [fzf](https://github.com/junegunn/fzf)
* [exa](https://the.exa.website/)
* [bat](https://github.com/sharkdp/bat)

## Usage

C-x C-f (or control-x followed by control-f) will launch a fzf with a listing
from exa, you can select one or multiple file (Withe the tab keys) and it will
be added to the command line.

## Demo

https://user-images.githubusercontent.com/98980/212008664-d87d18c1-71c9-403f-9282-685002a54797.mp4

## Configuration

You can customize some variables

- `ZSH_FZF_SELECT_FILE_FZF_ARGS`: The arguments to fzf
- `ZSH_FZF_SELECT_FILE_EXA_ARGS`: The arguments to exa
- `ZSH_FZF_SELECT_FILE_BIND`: The keybinding to use default to "^x^f"

If you want to show every files including the hidden one you can use the `fzf_select_file_all` widget like this:

```bash
bindkey "^x^a"  fzf_select_file_all # bind control-x control-a to show all files including hidden one
```

## Copyright

[Apache-2.0](./LICENSE)

## TODO

- Add preview

## Authors

Chmouel Boudjnah

- Fediverse - <[@chmouel@fosstodon.org](https://fosstodon.org/@chmouel)>
- Twitter - <[@chmouel](https://twitter.com/chmouel)>
- Blog  - <[https://blog.chmouel.com](https://blog.chmouel.com)>

## Alternative

You can as well use the [FZF ZSH Plugin](https://github.com/unixorn/fzf-zsh-plugin) to get *everything* selected with fzf in zsh but no pretty exa listing in there...

## Thanks

- Inspired by this great plug-in <https://github.com/joshskidmore/zsh-fzf-history-search>
