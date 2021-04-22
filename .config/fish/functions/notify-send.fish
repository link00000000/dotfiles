# Defined via `source`
function notify-send --wraps=notify-send.exe --description 'alias notify-send=notify-send.exe'
  notify-send.exe $argv; 
end
