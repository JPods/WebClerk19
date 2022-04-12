//%attributes = {"publishedWeb":true}
//Method: Http_ReadInRemotePage


//Sure this has been done !
//
//1)in Phantom, a commercial web si
//
//2)in the(quite outdated)"WebChecker"example in the ITK Example
//database !
//
//Best,
//--
//Christian Quest


//C_TEXT($0)
//C_LONGINT($stream;$status;$err)
//C_TEXT($temp;$request;$message)
//C_TEXT($serverip;$ourip;$page)
//C_TEXT($gcrlf)
//$gcrlf:=Char(13)+Char(10)
////$0:=""
//TRACE
//$serverip:="206.196.38.106"//The Web Servers IP address
//$ourip:="206.196.38.99"//Our IP Address
//$page:="/"//The URL to the page
//$message:=""
//$message:=$message+"GET "+$page+" HTTP/1.0"+$gcrlf+"Host: ""+$ourip+$gcrlf
//+$gcrlf+$gcrlf"
//$Stream:=ITK_TCPOpen ($serverip;80;32000;0;0;0;0)
//If ($Stream>0)//if the stream was established OK
//$Status:=ITK_TCPWaitConn ($Stream;8;8)// wait for stream to be open
//If ($Status=8)//a connection was established
//$err:=ITK_TCPSend ($stream;$message;0;0)//Send the request
//Repeat // Get the response,  Until assumes it is an HTML page 
//$err:=ITK_TCPRcv ($stream;$temp)
//$request:=$request+$temp
//IDLE
//$status:=ITK_TCPStatus ($stream)
//Until ((Position("</HTML>";$request)>0)|($status#8))
//End if 
//$Err:=ITK_TCPClose ($Stream)
//$Err:=ITK_TCPRelease ($Stream)
////$0:=$request
//CopyTEXT ($request)
//End if 