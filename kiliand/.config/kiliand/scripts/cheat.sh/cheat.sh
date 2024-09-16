#!/usr/bin/env bash
selected=`cat ~/.config/kiliand/scripts/cheat.sh/languages.list ~/.config/kiliand/scripts/cheat.sh/commands.list | fzf`
if [[ -z $selected ]]; then
    exit 0
fi

read -p "Enter Query: " query

if grep -qs "$selected" ~/.config/kiliand/scripts/cheat.sh/languages.list; then
    query=`echo $query | tr ' ' '+'`
    tmux neww bash -c "curl -s cht.sh/$selected/$query | less"
else
    tmux neww bash -c "curl -s cht.sh/$selected~$query | less"
fi

