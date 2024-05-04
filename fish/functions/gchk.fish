# Defined in - @ line 1
function gb --wraps='git checkout' --description 'alias gb=git checkout'
  git checkout $argv;
end
