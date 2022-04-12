//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/13/13, 10:55:48
// ----------------------------------------------------
// Method: Preg_Example
// Description
// 
//
// Parameters
// ----------------------------------------------------

//Script Preg Match All 20111006
//The REGEX Plugin defines . as any character except line feed \n (NOT carriage return \r)
//you either have to replace \r with \n to use . or negate it [^\r.]
//(?m) at the beginning makes the match Multi Line each line of text matches ^ and $


ARRAY TEXT:C222(atMatches; 0; 0)

vText:=""+"\r"
vText:=vText+"Server:        192.168.1.15"+"\r"
vText:=vText+"Address:    192.168.1.15#53"+"\r"
vText:=vText+""+"\r"
vText:=vText+"Non-authoritative answer:"+"\r"
vText:=vText+"jpods.com    mail exchanger = 0 smtp.secureserver.net."+"\r"
vText:=vText+"jpods.com    mail exchanger = 10 mailstore1.secureserver.net."+"\r"
vText:=vText+""+"\r"
vText:=vText+"Authoritative answers can be found from:"+"\r"
vText:=vText+"com    nameserver = d.gtld-servers.net."+"\r"
vText:=vText+"com    nameserver = f.gtld-servers.net."+"\r"
vText:=vText+"com    nameserver = i.gtld-servers.net."+"\r"
vText:=vText+"com    nameserver = b.gtld-servers.net."+"\r"
vText:=vText+"com    nameserver = j.gtld-servers.net."+"\r"
vText:=vText+"com    nameserver = e.gtld-servers.net."+"\r"
vText:=vText+"com    nameserver = c.gtld-servers.net."+"\r"
vText:=vText+"com    nameserver = l.gtld-servers.net."+"\r"
vText:=vText+"com    nameserver = g.gtld-servers.net."+"\r"
vText:=vText+"com    nameserver = a.gtld-servers.net."+"\r"
vText:=vText+"com    nameserver = k.gtld-servers.net."+"\r"
vText:=vText+"com    nameserver = m.gtld-servers.net."+"\r"
vText:=vText+"com    nameserver = h.gtld-servers.net."+"\r"
vText:=vText+"b.gtld-servers.net    internet address = 192.33.14.30"+"\r"
vText:=vText+"b.gtld-servers.net    has AAAA address 2001:503:231d::2:30"+"\r"
vText:=vText+"c.gtld-servers.net    internet address = 192.26.92.30"+"\r"
vText:=vText+"d.gtld-servers.net    internet address = 192.31.80.30"+"\r"
vText:=vText+"e.gtld-servers.net    internet address = 192.12.94.30"+"\r"
vText:=vText+"f.gtld-servers.net    internet address = 192.35.51.30"+"\r"
vText:=vText+"g.gtld-servers.net    internet address = 192.42.93.30"+"\r"
vText:=vText+"h.gtld-servers.net    internet address = 192.54.112.30"+"\r"
vText:=vText+"i.gtld-servers.net    internet address = 192.43.172.30"+"\r"
vText:=vText+"j.gtld-servers.net    internet address = 192.48.79.30"+"\r"
vText:=vText+"k.gtld-servers.net    internet address = 192.52.178.30"+"\r"

//"(?m)^.*?mail exchanger = 0 .*?\.$"
vText:=Replace string:C233(vText; "\r"; "\n")
viMatch:=Preg Match All("(?m)^.*?mail exchanger = (\\d*)\\s*(.*?)\\.?$"; vText; atMatches; Regex Multi Line)
vText1:=""
If (viMatch>=1)
	ALERT:C41(String:C10(viMatch))
	For (vi1; 1; Size of array:C274(atMatches))
		ALERT:C41(atMatches{vi1}{1}+", "+atMatches{vi1}{2}+", "+atMatches{vi1}{3})
		vText1:=vText1+atMatches{vi1}{1}+", "+atMatches{vi1}{2}+", "+atMatches{vi1}{3}+"\r"
	End for 
	SET TEXT TO PASTEBOARD:C523(vText1)
End if 

ALERT:C41("Done")


If (False:C215)
	//Script Customers Bad Email
	QUERY:C277([Customer:2]; [Customer:2]email:81#""; *)
	QUERY:C277([Customer:2])
	QUERY SELECTION BY FORMULA:C207([Customer:2]; Preg Match("^(?!.*\\.\\..*)(?!.*@.*@.*)[\\w!#$%&'*+-/=?^_//{|}~]+@.+\\..{2,5}$"; [Customer:2]email:81)=0)
End if 



//     Email Regex 20110518
//     
//     regex    ^(?!.*\.\..*)(?!.*@.*@.*)[\w!#$%&'*+-/=?^_//{|}~]+@.+\..{2,5}$
//     
//     ^    start of string
//     (?!.*\.\..*)    negative look ahead can not have two periods (dots) in a row
//     (?!.*@.*@.*)    negative look ahead can not have two at signs
//     [    begin character class
//     \w    any word character (a-z, A-Z, 0-9, _, and some 8-bit characters)
//         ! # $ % & ' * + - / = ? ^ _ // { | } ~  allowed characters in an email address
//     ]    end of character class
//     +    one or more characters
//     @    at sign
//     .+    one or more characters
//     \.    period (dot)
//     .{2,5}    2 to 5 characters
//     $    end of string

