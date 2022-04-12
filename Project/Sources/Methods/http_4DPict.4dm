//%attributes = {"publishedWeb":true}
//Procedure: http_4DPict  //Friday, October 30, 1998
If (False:C215)
	//(P)http_4DPict (stream, request)
	//This procedure send back a picture conatianed in a field 
	// The URL of the picture should have the form :
	//     http://www.here.com/4DPict?file=2&rec=56&field=10{&format=GIF}
	//
	//Assumnes images are compressed with JPEG if they are QuickDraw type
	
	//
	//In the ACME demo, [Employee]photo is set to auto compress in JPEG
End if 
C_LONGINT:C283($i; $tableNum; $fieldNum)
C_LONGINT:C283($1; $type; $dummy; $err)
C_LONGINT:C283($size; $top; $left; $bottom; $right)
C_POINTER:C301($2; $pFile; $pField)
C_TEXT:C284($tableName; $fieldName)
C_BLOB:C604($pictureBlob)
$tableName:=WCapi_GetParameter("TableName"; "")
$rec:=Num:C11(WCapi_GetParameter("RecordNum"; ""))
$fieldName:=WCapi_GetParameter("FieldName"; "")
$format:=WCapi_GetParameter("format"; "")  //optionnal

$type:=1
$doRelease:=False:C215
$err:=Num:C11($rec>0)  //drop out if there is no record, NOTE the Zero record will not be read
$tableNum:=STR_GetTableNumber($tableName)
$size:=0
If (($tableNum>0) & ($err=0))
	$fieldNum:=STR_GetFieldNumber($tableName; $fieldName)
	If ($fieldNum>0)
		error:=0
		READ ONLY:C145($pFile->)
		GOTO RECORD:C242($pFile->; $rec)
		If (Record number:C243($pFile->)=-1)
			$err:=12
		Else 
			$doRelease:=True:C214
			$pfield:=(Field:C253($tableNum; $fieldNum))
			GET FIELD PROPERTIES:C258($tableNum; $fieldNum; $type)
			If ($type#3)  //test to see if this is a picture field, if not mark as $err = 2
				$err:=2
			Else 
				Case of 
					: (($format="") | ($format="@gif@"))
						$format:="GIFf"
					: (($format="PNGf") | ($format="@jpg@"))
						$format:="PNGf"
					: (($format="JPEG") | ($format="@jpg@"))
						$format:="JPEG"
					Else 
						$format:="GIFf"
				End case 
				PICTURE TO BLOB:C692($pfield->; $pictureBlob; $format)
				$size:=BLOB size:C605($pictureBlob)
			End if 
		End if 
	End if 
	If ($size>0)
		Case of 
			: ($format="GIFf")
				$err:=TCP Send($1; "HTTP/1.0 200 OK"+Storage:C1525.char.crlf+"MIME-Version: 1.0"+Storage:C1525.char.crlf+"Content-type: image/gif"+Storage:C1525.char.crlf+"Content-length: "+String:C10($size)+Storage:C1525.char.crlf+Storage:C1525.char.crlf)
				$err:=TCP Send Blob($1; $pictureBlob)
			: ($format="JPEG")
				$err:=TCP Send($1; "HTTP/1.0 200 OK"+Storage:C1525.char.crlf+"MIME-Version: 1.0"+Storage:C1525.char.crlf+"Content-type: image/jpeg"+Storage:C1525.char.crlf+"Content-length: "+String:C10($size)+Storage:C1525.char.crlf+Storage:C1525.char.crlf)
				$err:=TCP Send Blob($1; $pictureBlob)
			: ($format="PNGf")
				$err:=TCP Send($1; "HTTP/1.0 200 OK"+Storage:C1525.char.crlf+"MIME-Version: 1.0"+Storage:C1525.char.crlf+"Content-type: image/png"+Storage:C1525.char.crlf+"Content-length: "+String:C10($size)+Storage:C1525.char.crlf+Storage:C1525.char.crlf)
				$err:=TCP Send Blob($1; $pictureBlob)
		End case 
	End if 
	If ($doRelease)
		UNLOAD RECORD:C212($pFile->)
	End if 
	READ WRITE:C146($pFile->)
	
End if 
If ($err#0)
	$err:=TCP Send($1; "HTTP/1.0 404 OK"+Storage:C1525.char.crlf+"MIME-Version: 1.0"+Storage:C1525.char.crlf+"Content-type: text/plain"+Storage:C1525.char.crlf+Storage:C1525.char.crlf+"Error 404: Requested picture does not exist.")
End if 