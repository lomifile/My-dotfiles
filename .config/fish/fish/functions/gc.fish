# Defined in - @ line 1
function gc --wraps='git add . && git commit -m ' --description 'alias gc git add . && git commit -m '
  git add . && git commit -m  $argv;
end
