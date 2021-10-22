# Windows Server Local Administrators

.SYNOPSIS
------------------------
Windows-Server-Local-Administrators.ps1

.DESCRIPTION
------------------------
Generates a CSV report with users members of the local Administrators group from all domain member Windows servers
Requires to be executed from a domain controller, or a member server with Active Directory module enabled

.AUTHOR
------------------------
mircea.g

.TESTED
------------------------
- Windows Server 2008 R2
- Windows Server 2012 R2
- Windows Server 2016
- Windows Server 2019

.REQUIREMENTS
------------------------
Needs WinRM enabled and working on remote Windows servers queried

.USE
------------------------
1. Rename script as "Windows-Server-Local_Administrators.ps1"
2. Copy script to e.g. C:\Scripts\
3. Open PowerShell as "Administrator"
4. Execute ```Set-ExecutionPolicy RemoteSigned -Scope CurrentUser```
5. Execute script e.g. ```C:\Scripts\Windows-Server-Local-Administrators.ps1```
6. Collect logs generated at C:\Scripts\Windows-Server-Local-Administrators.csv
