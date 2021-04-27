# Defined in - @ line 1
function neovide --wraps='neovide.exe --wsl' --description 'alias neovide=neovide.exe --wsl'
  neovide.exe --wsl $argv;
end
