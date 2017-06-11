# -*- coding:utf-8 mode:sh -*-

# refer to http://qiita.com/nishina555/items/f4f1ddc6ed7b0b296825

# display rprompt for git
function rprompt-git-current-branch {
  local branch_name st branch_status

  if [ ! -e  ".git" ]; then
    # don't show no git directory
    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # clean
    branch_status="%F{green}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # untrack
    branch_status="%F{red}?"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # modified
    branch_status="%F{red}+"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # staged
    branch_status="%F{yellow}!"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # conflict
    echo "%F{red}!(conflict)"
    return
  else
    # etc
    branch_status="%F{blue}"
  fi
  # display branch name with color
  echo "${branch_status}[$branch_name]"
}

setopt prompt_subst
RPROMPT='`rprompt-git-current-branch`'
