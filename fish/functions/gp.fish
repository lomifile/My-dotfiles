# Defined in - @ line 1
function gp --wraps='git push origin ' --description 'alias gp git push origin '
  git push origin  $argv;
end
