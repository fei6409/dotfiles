# Styling for up-to-date Git status.
meta='%f'            # default foreground
clean='%76F'         # green foreground
modified='%178F'     # yellow foreground
untracked='%39F'     # blue foreground
conflicted='%196F'   # red foreground

function _append_commit_ref() {
  local branch=$(git branch --show-current 2>/dev/null)
  if [[ -n "${branch}" ]]; then
    # If local branch name or tag is at most 32 characters long, show it in full.
    # Otherwise show the first 12 … the last 12.
    (( ${#branch} > 32 )) && branch[13,-13]="…"
    res+="${clean}${branch//\%/%%}"  # escape %
    return
  fi

  # Finding tag is expensive, skip this for now
  # local tag=$(git tag --points-at HEAD 2>/dev/null)
  # if [[ -n "${tag}" ]]; then
  #   (( ${#tag} > 32 )) && tag[13,-13]="…"
  #   echo "${clean}${tag//\%/%%}"  # escape %
  #   return
  # fi

  local commit=$(git rev-parse --short HEAD 2>/dev/null)
  res+="${meta}@${clean}${commit[1,8]}"
}

function _append_action() {
  # Check the status of rebase/revert/bisect etc...
  if [[ -d "${g}/rebase-merge" ]]; then
    if [[ -f "${g}/rebase-merge/interactive" ]]; then
      res+="${conflicted}|rebase-i"
    else
      res+="${conflicted}|rebase-m"
    fi
  elif [[ -d "${g}/rebase-apply" ]]; then
    if [[ -f "${g}/rebase-apply/rebasing" ]]; then
      res+="${conflicted}|rebase"
    elif [[ -f "${g}/rebase-apply/applying" ]]; then
      res+="${conflicted}|am"
    else
      res+="${conflicted}|am/rebase"
    fi
  elif [[ -f "${g}/MERGE_HEAD" ]]; then
    res+="${conflicted}|merge"
  elif [[ -f "${g}/CHERRY_PICK_HEAD" ]]; then
    res+="${conflicted}|cherry-pick"
  elif [[ -f "${g}/REVERT_HEAD" ]]; then
    res+="${conflicted}|revert"
  elif [[ -f "${g}/BISECT_LOG" ]]; then
    res+="${conflicted}|bisect"
  fi
}

function _append_remote_info() {
  local remote=$(git rev-parse --abbrev-ref @{upstream} 2>/dev/null)

  # Show tracking branch name if it differs from local branch.
  if [[ -n "${remote}" ]]; then
    # Returns "<ahead><TAB><behind>"
    local lr=$(timeout 0.5 git rev-list --left-right --count HEAD...@{upstream})
    local ahead=$(cut -f1 <<< ${lr})
    local behind=$(cut -f2 <<< ${lr})

    res+="${meta}:${clean}${remote//\%/%%}"  # escape %
    # ⇣42 if behind the remote.
    (( behind )) && res+=" ${clean}⇣${behind}"
    # ⇡42 if ahead of the remote; no leading space if also behind the remote: ⇣42⇡42.
    (( ahead && !behind )) && res+=" "
    (( ahead )) && res+="${clean}⇡${ahead}"
  fi
}

function _append_status() {
  local stash=$(git stash list 2>/dev/null | wc -l | xargs)
  local conflict=$(git ls-files --unmerged 2>/dev/null | cut -f2 | sort -u | wc -l | xargs)
  # https://git-scm.com/docs/git-status
  local st=$(timeout 0.5 git status --porcelain 2>/dev/null)
  local stage=$(grep -E "^(M|T|A|D|R|C|U)" <<< ${st} | wc -l | xargs)
  local unstage=$(grep -E "^.(M|T|A|D|R|C|U)" <<< ${st} | wc -l | xargs)
  local untrack=$(grep -E "^\?\?" <<< ${st} | wc -l | xargs)

  # *42 if have stashes.
  (( stash )) && res+=" ${clean}≡${stash}"
  # ~42 if have merge conflicts.
  (( conflict )) && res+=" ${conflicted}~${conflict}"
  # +42 if have staged changes.
  (( stage )) && res+=" ${modified}+${stage}"
  # !42 if have unstaged changes.
  (( unstage )) && res+=" ${modified}!${unstage}"
  # ?42 if have untracked files.
  (( untrack )) && res+=" ${untracked}?${untrack}"
}

function prompt_my_git_prompt() {
  # Measure execution time
  local start_time="$(date +%s.%N)"

  local g=$(git rev-parse --git-dir 2>/dev/null)
  # Not in a Git repo
  [[ -z "${g}" ]] && return

  local res=""

  _append_commit_ref
  _append_action
  _append_remote_info
  _append_status

  local end_time="$(date +%s.%N)"
  local T=$(bc -l <<< "${end_time} - ${start_time}")
  # Warn on long execution time
  (( $(bc -l <<< "${T} >= 1") )) && res+=" ${conflicted}!${T}s"

  p10k segment -t "${res}"
}

function instant_prompt_my_git_prompt() {
  prompt_my_git_prompt
}
