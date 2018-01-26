# Section for AEM
$failcount = $env:FAILCOUNT
# This will retrieve the last 24 hours worth of login failures.
# $logins = Get-EventLog -LogName security -After (Get-Date).AddHours(-24) | where-object {$_.EventID -eq 4625} | Measure
# Alternative option for getting ID count AND content filter
$logins = Get-EventLog -LogName security -After (Get-Date).AddHours(-24) | where-object {$_.EventID -eq 4625 -and $_.Message -notlike '*sophos*' -or '$env:computername'} | Measure
#Get count using $logins.count
if ($logins.count -gt $failcount){
write-host "<-Start Result->"
Write-host "CSMON-ResultMessage=fail"
write-host "<-End Result->"
$exit_val=1
}
else
{
write-host "<-Start Result->"
Write-host "CSMON-ResultMessage=ok"
write-host "<-End Result->"
$exit_val=0
}
Exit $exit_val