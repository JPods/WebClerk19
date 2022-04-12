//%attributes = {}
// In ComEx ORDA Folder
// https://www.youtube.com/watch?v=jnQ9C0IUsD8   // code examples starting at about 38:45
// https://kb.4d.com/assetid=77671
// C_OBJECT($1; $letsEncrypt_ob)
// C_TEXT(logger)
// C_LONGINT($code)
// C_BOOLEAN(AutoCopyCert_b; AskToCopyCert_b)
// If (Count parameters>0)
// If (Count parameters>1)
// C_BOOLEAN($2)
// // $2 is defined
// If ($2=True)
// // $2 is true
// AutoCopyCert_b:=True
// AskToCopyCert_b:=False
// Else 
// // $2 is false
// AutoCopyCert_b:=False
// AskToCopyCert_b:=False
// End if 
// Else 
// // $2 is not defined
// AutoCopyCert_b:=False
// AskToCopyCert_b:=True
// End if 
// 
// 
// $letsEncrypt_ob:=$1
// 
// 
// If (OB Is defined($letsEncrypt_ob; "ca"))
// C_TEXT(ca)
// ca:=OB Get($letsEncrypt_ob; "ca"; Is text)
// Else 
// ca:=""
// End if 
// 
// 
// If (ca="")
// C_TEXT($msg)
// $msg:="CA is not set; please include a CA property in the Object passed"
// ConsoleMessage($msg)
// ALERT($msg)
// Else 
// // ca is set so continue
// 
// caServerName:=Replace string(ca; "https://"; "")
// caServerName:=Replace string(caServerName; "http://"; "")
// caServerName:=Replace string(caServerName; "/"; "")
// caServerName:=Replace string(caServerName; "\\"; "")
// certificatesDir:=Get 4D folder(Database folder; *)+"letsencrypt"+Folder separator
// accountKeyDir:=certificatesDir+"_account"+Folder separator+caServerName+Folder separator
// accountKeyPath:=accountKeyDir+"key.pem"
// CREATE FOLDER(accountKeyDir; *)
// 
// 
// If (OB Is defined($letsEncrypt_ob; "deleteAccountKey"))
// If (OB Get($letsEncrypt_ob; "deleteAccountKey"; Is boolean))
// Acme_DeleteKey(accountKeyDir)
// End if 
// End if 
// 
// 
// 
// 
// logger:=""
// 
// ConsoleMessage("Started @ "+String(Current date; ISO date; Current time)+"\r")
// 
// WEB START SERVER
// If (OK=1)
// // started web server
// $code:=_initAccount($letsEncrypt_ob)
// If ($code>299)
// ALERT("error during account registration\rStatus: "+String($code))
// Else 
// _signDomains($letsEncrypt_ob)
// End if 
// Else 
// ConsoleMessage("web server could not start!")
// End if 
// 
// ConsoleMessage("Ended @ "+String(Current date; ISO date; Current time)+"\r")
// 
// OB SET($letsEncrypt_ob; "log"; logger)
// End if 
// End if 