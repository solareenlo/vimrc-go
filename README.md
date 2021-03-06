# vimrc-go
- my `vimrc` for Go

## Usage
```shell
# Install goimports
go get golang.org/x/tools/cmd/goimports

# Install gopls
GO111MODULE=on go get golang.org/x/tools/gopls@latest

# vim .zshrc
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH
# 重複パスを登録しない
typeset -U path PATH

# vim's color
curl -O https://raw.githubusercontent.com/lifepillar/vim-solarized8/master/scripts/solarized8.sh
sh solarized8.sh

# Snippets
curl https://raw.githubusercontent.com/solareenlo/vimrc-go/main/go.snippets -o ~/.vim/UltiSnips/go.snippets
```

## References
### LSP
- [golang/tools/gopls/](https://github.com/golang/tools/tree/master/gopls)

### Settings
- [vim-goを使わず、LSP（gopls）を使ってVimのGo開発環境を構築する](https://budougumi0617.github.io/2020/07/24/make_vimrc_with_lsp/)
- [Vim で Go 言語を書くために行った引越し作業 2020年度版](https://mattn.kaoriya.net/software/vim/20200106103137.htm)
- [mattn/vim-goimports](https://github.com/mattn/vim-goimports)
