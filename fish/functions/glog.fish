# Defined in - @ line 1
function glog --wraps='git log' --description 'alias glog=git log'
  git log $argv;
end
