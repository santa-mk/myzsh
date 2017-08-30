# -*- coding:utf-8 mode:sh -*-

# refer to http://qiita.com/nishina555/items/f4f1ddc6ed7b0b296825

# display prompt for git
function prompt-git-current-branch {
  local branch_name st branch_status
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  if [ "${branch_name}" = "" ]; then
    # don't show no git directory
    return
  fi
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # clean
    branch_status=""
    color="%F{green}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # untrack
    branch_status="?"
    color="%F{red}"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # modified
    branch_status="+"
    color="%F{red}"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # staged
    branch_status="!"
    color="%F{yellow}"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # conflict
    echo "%F{red}!(conflict)"
    return
  else
    # etc
    branch_status=""
    color="%F{blue}"
  fi
  # display branch name with color
  echo "${color}[$branch_name]${branch_status}"
}

setopt prompt_subst
PROMPT+='`prompt-git-current-branch`'
