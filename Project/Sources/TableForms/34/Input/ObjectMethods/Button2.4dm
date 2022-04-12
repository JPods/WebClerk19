[CallReport:34]EmailStatus:45:=""
[CallReport:34]EmailVerified:46:=!00-00-00!

SMTP_EmailBuild(->[CallReport:34])
Execute_TallyMaster([CallReport:34]Subject:14; "eMailCallReports")
SMTP_SendMsg

