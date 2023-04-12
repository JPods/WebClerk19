//%attributes = {"publishedWeb":true}
//Method: Sync_Echo

C_LONGINT:C283($rslt; $i)
C_BOOLEAN:C305($doThis)
C_LONGINT:C283($1)
$rslt:=1
myDocName:=""
If (Count parameters:C259=0)
	CONFIRM:C162("Are you sure you wish to read an SyncEcho file?")
	If (OK=1)
		CONFIRM:C162("This cannot be undone!?!?!")
	End if 
Else 
	OK:=$1
	myDocName:=""
End if 
If (OK=1)
	$myOK:=EI_OpenDoc(->myDocName; ->myDoc; "Open Echo File"; ""; Storage:C1525.folder.jitExportsF)  //;jitQRsF
	If ($myOK=1)
		
		If (False:C215)  //rewrite into web service
			TCStrong_prf_v142_RWVar
			WebService_Version0001
			//$doc:=OpenVarFile(myDocName)
			//If (ReadWriteVarErr =0)
			//ReadVarArray ($doc;aSyFile)
			//ReadVarArray ($doc;aSyField)
			//ReadVarArray ($doc;aSyType)
			//ReadVarArray ($doc;aSyMatWas)
			//ReadVarArray ($doc;aSyMatIs)
			//CloseVarFile ($doc)
			//$rslt:=ReadWriteVarErr 
		End if 
	End if 
End if 
//
If ($rslt=0)
	SORT ARRAY:C229(aSyFile; aSyField; aSyType; aSyMatWas; aSyMatIs)
	CREATE RECORD:C68([Service:6])
	
	//[Service]ActionDate:=Current date
	//[Service]ActionTime:=Current time
	[Service:6]dtAction:35:=DateTime_DTTo
	[Service:6]actionBy:12:=Current user:C182
	[Service:6]process:4:="Echo Errors"
	[Service:6]action:20:="Echo Errors"
	For ($i; 1; Size of array:C274(aSyFile))
		$theType:=$theType
		Case of 
			: (($theType=0) | ($theType=2))
				Case of 
					: (Table:C252(->[Customer:2])=aSyFile{$i})
						$doThis:=ConsolidateRecs(Table:C252(aSyFile{$i}); ->aSyMatWas{$i}; ->aSyMatIs{$i}; True:C214)
					: (Table:C252(->[Item:4])=aSyFile{$i})
						$doThis:=ConsolidateRecs(Table:C252(aSyFile{$i}); ->aSyMatWas{$i}; ->aSyMatIs{$i}; True:C214)
					Else 
						QUERY:C277(Table:C252(aSyFile{$i})->; Field:C253(aSyFile{$i}; aSyField{$i})->=aSyMatWas{$i})
						If (Records in selection:C76(Table:C252(aSyFile{$i})->)=1)
							Field:C253(aSyFile{$i}; aSyField{$i})->:=aSyMatIs{$i}
							SAVE RECORD:C53(Table:C252(aSyFile{$i})->)
						End if 
				End case 
			: (($theType=1) | ($theType=8) | ($theType=9))
				Case of 
					: (Table:C252(->[Order:3])=aSyFile{$i})
						$doThis:=ConsolidateRecs(Table:C252(aSyFile{$i}); ->aSyMatWas{$i}; ->aSyMatIs{$i}; True:C214)
					Else 
						QUERY:C277(Table:C252(aSyFile{$i})->; Field:C253(aSyFile{$i}; aSyField{$i})->=Num:C11(aSyMatWas{$i}))
						If (Records in selection:C76(Table:C252(aSyFile{$i})->)=1)
							Field:C253(aSyFile{$i}; aSyField{$i})->:=Num:C11(aSyMatIs{$i})
							SAVE RECORD:C53(Table:C252(aSyFile{$i})->)
						End if 
				End case 
				////: ($theType=11)
				////Field(aSyFile{$i};aSyField{$i}):=Time(aSyMatIs{$i})
				////: ($theType=4)
				////Field(aSyFile{$i};aSyField{$i}):=Date(aSyMatIs{$i})
				////: ($theType=6)
				////Field(aSyFile{$i};aSyField{$i}):=((aSyMatIs{$i}="1")|
				////(aSyMatIs{$i}="true")|(aSyMatIs{$i}="Yes")|(aSyMatIs{$i}
				//="Y"))
				////: ($theType="P")
				////ALERT("Picture Files may not be imported.  Use the Clipboard.
				//")
		End case 
		UNLOAD RECORD:C212(Table:C252(aSyFile{$i})->)
	End for 
	SAVE RECORD:C53([Service:6])
End if 