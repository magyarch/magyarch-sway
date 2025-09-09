#!/bin/sh

declare options=("web
chat
edit
music
games
video
Quit")

choice=$(echo -e "${options[@]}" | dmenu -i -c -g 1 -l 20 -fn 'JetBrains Mono Nerd Font-12' -p 'Groups: ' -nb '#1a1a1a' -sb '#2e8b57')

case "$choice" in
    quit)
        echo "program terminated." && exit 1
    ;;
    web)
	    choice=exec ratpoison -c "gselect 1" -c "select -" -c "only" -c "next" -c "echo web"
    ;;
    chat)
	    choice=exec ratpoison -c "gselect 2" -c "select -" -c "only" -c "next" -c "echo chat"
    ;;
    edit)
	    choice=exec ratpoison -c "gselect 3" -c "select -" -c "only" -c "next" -c "echo edit"
    ;;
    music)
	    choice=exec ratpoison -c "gselect 4" -c "select -" -c "only" -c "next" -c "echo music"
    ;;
    games)
	    choice=exec ratpoison -c "gselect 5" -c "select -" -c "only" -c "next" -c "echo games"
    ;;
    video)
        choice=exec ratpoison -c "gselect 6" -c "select -" -c "only" -c "next" -c "echo video"
esac

"$choice"
