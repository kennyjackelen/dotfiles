alias diff='git difftool -dir-diff -t kdiff3'
alias prod='ssh root@prd.kennyjackelen.com'

function e() {
  sublime "$@" &
}

alias aliases='e ~/.bash_aliases'

function commit() {
  if [ -z "$(git status --porcelain)" ]; then 
    echo "No changes to commit.";
    return;
  fi

  diff

  echo "Proceed with commit?"
  select yn in "Yes" "No"; do
      case $yn in
          Yes ) break;;
          No ) exit;;
      esac
  done

  echo "Please enter a commit message."
  read msg
  if [ -z "$msg" ]; then
    echo "Invalid message."
  else
    git commit -m '$msg'
  fi
}

function compare() {
  ssh prd.kennyjackelen.com "cat \"$@\"" > /tmp/comparison.txt
  kdiff3 "$@" /tmp/comparison.txt &
}