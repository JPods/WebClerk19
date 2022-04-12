//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: WccListSave
	//Date: 03/11/03
	//Who: Bill
	//Description: Save a list of records from the web
End if 
C_TEXT:C284($txtPage; $txtPart)
C_REAL:C285($runQty; $qty; $runPrice; pUnitPrice; pExtPrice; addDiscount)
C_TEXT:C284(vText1; vText2; vText3; vText4; vText5; vText6; vText7; vText8; vText9; vText10)
C_LONGINT:C283($err; $pTest; $vlBeenHere; vlBeenHere)
C_LONGINT:C283($1; $4; $tableNum)
C_POINTER:C301($2)
C_TEXT:C284($3; $tableName)
If (Count parameters:C259=4)
	$tableName:=$3
	$tableNum:=$4
Else 
	$tableName:=WCapi_GetParameter("TableName"; "")
	$tableNum:=STR_GetTableNumber($tableName)
End if 
$doPage:="Error.html"
vResponse:="No valid table."
vText9:=""
$madeBy:=[RemoteUser:57]customerID:10
$madeByTable:=[RemoteUser:57]tableNum:9
If ($tableNum>0)
	vResponse:="No RecordNum Delimiters."
	If (Position:C15("RecordNum"; $2->)>0)
		$doPage:=WCapi_GetParameter("jitPageOne"; "")
		If ($doPage="")
			$doPage:="CWS"+$tableName+".html"
		End if 
		zzz:=1  //should this be a list page, should
		// $doPage:=WCapi_GetParameter("jitPageList";"")
		If ($2->="Get@")  //must be here to catch the last item or it gets zeroed
			$p:=Position:C15(Storage:C1525.char.crlf; $2->)
			If ($p>0)
				$2->:=Substring:C12($2->; 1; $p-1)
			End if 
		End if 
		//
		//$mySort:=""
		//$p:=Position("_jitSort";$2->)
		//If ($p>0)
		//$showLast:=0
		//$mySort:=Substring($2->;$p;80)//clip the sort command, get enough
		// 
		//$p:=Position(<>endTag;$mySort)//find the end
		//$mySort:=Substring($mySort;1;$p+1)
		//$showLast:=Http_DoSort ($mySort)
		//$mySort:="&"+$mySort+"&"
		//End if 
		CREATE EMPTY SET:C140((Table:C252($tableNum))->; "Current")
		C_LONGINT:C283($p; $pEqual; $pEnd; $pCR; $pEndSeg)
		$endLoop:=False:C215
		Repeat 
			vText7:=""
			$p:=Position:C15("RecordNum"; $2->)  //do the lines  
			$2->:=Substring:C12($2->; $p+4)  //clip off thru the "&" string     
			$pNext:=Position:C15("RecordNum"; $2->)  //do the lines
			If ($pNext=0)
				vText7:="Get /Reco"+$2->
				$endLoop:=True:C214
				$2->:=""
			Else 
				vText7:="Get /Reco"+Substring:C12($2->; 1; $pNext-1)+" HTTP/"  //clip incoming to a single item record
				
			End if 
			$saveMe:=WCapi_GetParameter("SaveMe"; "")
			If ($saveMe="on")
				$recordNum:=Num:C11(WCapi_GetParameter("RecordNum"; ""))
				READ WRITE:C146(Table:C252($tableNum)->)
				If ($recordNum>0)  //must have at least one record
					GOTO RECORD:C242(Table:C252($tableNum)->; $recordNum)
					$newRec:=False:C215
				Else 
					CREATE RECORD:C68(Table:C252($tableNum)->)
					$newRec:=True:C214
				End if 
				vResponse:="Changes Posted."
				WC_Parse($tableNum; ->vText7)
				ADD TO SET:C119((Table:C252($tableNum))->; "Current")
				
				If ($madeBy#"")  //coming from Community Server
					Case of 
						: ($tableName="TallyResult")
							[TallyResult:73]customerID:30:=$madeBy
							[TallyResult:73]tableNum:3:=$madeByTable
							SAVE RECORD:C53([TallyResult:73])
							//If ([TallyResult]DTCreated=0)
							//[TallyResult]DTCreated:=DateTime_Enter 
							//End if 
						: ($tableName="Document")
							[Document:100]customerID:7:=$madeBy
							[Document:100]tableNum:6:=$madeByTable
							SAVE RECORD:C53([Document:100])
					End case 
				End if 
			End if 
		Until ($endLoop)
		USE SET:C118("Current")
		CLEAR SET:C117("Current")
	End if 
End if 
$err:=WC_PageSendWithTags($1; WC_DoPage($doPage; ""); 0)

//  