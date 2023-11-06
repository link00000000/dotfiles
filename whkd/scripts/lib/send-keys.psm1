<#
    Valid keys: https://learn.microsoft.com/en-us/office/vba/Language/Reference/user-interface-help/sendkeys-statement#remarks
#>
function Send-Keys {
    param ([string] $Keys)

    $wshell = New-Object -ComObject wscript.shell
    $wshell.SendKeys($Keys)
}

Export-ModuleMember -Function Send-Keys
