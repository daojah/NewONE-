$InactiveDays = New-TimeSpan -days 56
$LastLogonTimeMark= (get-date) - $InactiveDays
Get-QADuser -IncludedProperties lastLogontimeStamp|
?{$_.lastLogontimeStamp -lt $LastLogonTimeMark}| sort lastLogontimeStamp| ft Name,lastLogontimeStamp, whenCreated –AutoSize