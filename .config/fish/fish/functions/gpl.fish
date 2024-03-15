# Defined in - @ line 1
function gpl --wraps='git pull origin ' --description 'alias gpl git pull origin '
  git pull origin  $argv;
end
