if (Get-Process komorebi -ErrorAction SilentlyContinue) 
{
    taskkill /f /im komorebi.exe
}
else
{
    komorebic start -c $Env:USERPROFILE\komorebi.json --whkd
}
