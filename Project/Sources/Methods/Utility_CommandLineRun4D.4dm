//%attributes = {}
/*
put a heartbeat on a machine. Excute command line to restart a failed machine
//https://kb.4d.com/assetid=79131
This will prevent the 4DClient Folder from being renamed
> cd C:\4D_Application\4DClient
> "4D_Application Client.exe" --headless
Since the command line is using the 4DClient directory as the current directory it cannot be renamed.

The following will work assuming the command prompt was opened and the current dirrectory was not changed and defaults to a drive like "C:":
> "C:\4D_Application\4DClient\4D_Application Client.exe" --headless

or the directory can be changed to the directory containing the client directory, as long as the client directory itself is not accessed:
> cd C:\4D_Application
> "4DClient\4D_Application Client.exe" --headless
*/

