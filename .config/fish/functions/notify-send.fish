# Defined via `source`
function notify-send --wraps=notify-send.exe --description 'alias notify-send=notify-send.exe'
  if type -q notify-send.exe
    notify-send.exe $argv; 
  else
    echo "notify-send.exe must be installed on and available in the path of the Windows host"
    echo "GitHub Repository: https://github.com/vaskovsky/notify-send"
  end
end
