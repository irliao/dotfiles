# GitHub

## How to "reset" git commit history to a single commit
https://stackoverflow.com/questions/14969775/delete-all-git-commit-history

## .gitconfig reference

```
[user]
    name = Ian Ryan Liao
    email = ianryanliao@gmail.com
[core]
    quotepath = false
    whitespace=fix,-indent-with-non-tab,trailing-space,cr-at-eol
    excludesfile = /Users/talha/.gitignore
    trustctime = false
    pager = less -x1,5
	editor = nvim
[color]
    ui = always
[color "branch"]
    current = green
    local = magenta
    remote = yellow
[color "diff"]
    meta = yellow bold
    frag = magenta
    old = red
    new = green
    whitespace = white reverse
    commit = blue reverse
[color "status"]
    added = yellow
    changed = green
    untracked = cyan reverse
    branch = magenta
[push]
    default = simple
[alias]
    sb = status -sb
    sc = diff --name-only --diff-filter=U
    l = "!source ~/.githelper && pretty_git_log"
    ls = "!source ~/.githelper && pretty_git_log_stats"
    la = "!git l --all"
    lr = !git l -50 --graph
    lra = !git lr --all
    lg = !git l --graph
    lp = log --patch --decorate
    d = diff
    dc = diff --cached
    c = commit -v
    ca = !git c -a
    caa = !git c -a --amend
    cm = !git c --amend
    s = status --short
    ap = add -p
    ai = add -i
    ln = log --name-only
    dw = diff --word-diff=color
    chm = checkout master
    chb = checkout -b
    ch = checkout
	dcw = diff --cached --word-diff
[merge]
    conflictstyle = diff3
[diff]
	algorithm = patience
	compactionHeuristic = true
[pager]
	log = diff-highlight | less
	show = diff-highlight | less
	diff = diff-highlight | less
[interactive]
	diffFilter = diff-highlight
```
