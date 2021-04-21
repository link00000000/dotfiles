# Defined in - @ line 1
function lynx --wraps='WWW_HOME=https://www.google.com lynx' --wraps='WWW_HOME=https://www.google.com command lynx' --description 'alias lynx=WWW_HOME=https://www.google.com command lynx'
  WWW_HOME=https://www.google.com command lynx $argv;
end
