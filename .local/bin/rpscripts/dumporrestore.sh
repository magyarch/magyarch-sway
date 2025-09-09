#!/usr/bin/env bash

if [[ ! -e $HOME/.rpfdump ]] ; then
  ratpoison -c "fdump" > $HOME/.rpfdump; ratpoison -c 'select -' -c only
  ratpoison -c "echo Window layout saved"
else
  ratpoison -c "frestore $(cat $HOME/.rpfdump)"
  rm -rf $HOME/.rpfdump
  ratpoison -c "echo Window layout restored"
fi
