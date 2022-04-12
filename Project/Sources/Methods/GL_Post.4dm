//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 04/22/21, 12:42:49
// ----------------------------------------------------
// Method: GL_Post
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($source)
C_TEXT:C284($mystring)
C_POINTER:C301($1)
C_LONGINT:C283($FileNum; $3; $result; $i; $k)  //1, insight; 2, atOnce; 3, Great Plains; 4, MYOB
C_BOOLEAN:C305($2)
C_TEXT:C284($temName)
C_TEXT:C284($myDocName)
Path_Set(Storage:C1525.folder.jitAudits)
$FileNum:=Table:C252($1)
C_LONGINT:C283($OK)
$OK:=0
QUERY:C277($1->; Field:C253($FileNum; 8)->=0)
jsetDefaultFile($1)
myOK:=5000
File_Select("Pending Records are in the Current Selection. Click OK to proceed.")
$OK:=myOK
$k:=Records in selection:C76($1->)
If (($k>0) & ($OK=1))
	Case of 
		: ($1=(->[SalesJournal:50]))
			$temName:="Exp_SJ"
		: ($1=(->[PurchaseJournal:51]))
			$temName:="Exp_PJ"
		: ($1=(->[CashJournal:52]))
			$temName:="Exp_CJ"
	End case 
	$temName:=$temName+"_"+Date_strYrMmDd(Current date:C33)
	sumDoc:=EI_UniqueDoc(Storage:C1525.folder.jitAudits+$temName)
	$OK:=OK
	If ($OK=1)
		ORDER BY:C49($1->; Field:C253($FileNum; 2)->)
		CREATE EMPTY SET:C140($1->; "Errors")
		FIRST RECORD:C50($1->)
		
		Case of   //header information, if required
			: ($3=1)  //Insight
			: ($3=2)  //At Once
			: ($3=3)  //Great Plains
			: ($3=4)  //MYOB
			: ($3=5)  //QuickBooks
			: ($3=6)  //MultiLedger    
				$source:=Field:C253($FileNum; 2)->
				SEND PACKET:C103(sumDoc; "skip"+"\t"+String:C10(Field:C253($FileNum; 3)->; 1)+"\t"+Substring:C12($source; 1; 2)+Substring:C12($source; 6; 2)+Substring:C12($source; 9; 4))
		End case 
		$i:=0
		$source:=""
		$mystring:="Imported from theCustomer."
		TRACE:C157
		While ($i<$k)
			$i:=$i+1
			LOAD RECORD:C52($1->)
			If (Locked:C147($1->))
				BEEP:C151
				ADD TO SET:C119($1->; "Errors")
			End if 
			Case of 
				: ($2)
					If (Field:C253($FileNum; 2)->#$source)
						$source:=Field:C253($FileNum; 2)->
					End if 
					If (GLError=0)
						Field:C253($FileNum; 8)->:=1
					Else 
						ADD TO SET:C119($1->; "Errors")
						Field:C253($FileNum; 8)->:=GLError
					End if 
					SAVE RECORD:C53($1->)
				Else 
					Case of 
						: ($3=1)  //Insight
							SEND PACKET:C103(sumDoc; Field:C253($FileNum; 2)->+"\t"+String:C10(Field:C253($FileNum; 3)->)+"\t"+String:C10(Field:C253($FileNum; 6)->)+"\t"+Field:C253($FileNum; 1)->+"\t"+Field:C253($FileNum; 2)->+"\t"+String:C10(Field:C253($FileNum; 4)->)+"\t"+String:C10(Field:C253($FileNum; 5)->)+"\t"+$mystring+"\r")
						: ($3=2)  //At Once
							SEND PACKET:C103(sumDoc; Field:C253($FileNum; 1)->+"\t"+String:C10((Field:C253($FileNum; 4)->)-(Field:C253($FileNum; 5)->))+"\t")
						: ($3=3)  //Great Plains
							SEND PACKET:C103(sumDoc; "0"+"\t"+Substring:C12(Field:C253($FileNum; 1)->; 1; 4)+"\t"+Substring:C12(Field:C253($FileNum; 1)->; 5; 3)+"\t"+Substring:C12(Field:C253($FileNum; 1)->; 10; 3)+"\t"+String:C10((Field:C253($FileNum; 4)->)-(Field:C253($FileNum; 5)->))+"\t"+String:C10(Field:C253($FileNum; 3)->)+"\t"+"tc"+Substring:C12(Field:C253($FileNum; 2)->; 1; 2)+"\t"+Field:C253($FileNum; 2)->+"\r")
						: ($3=4)  //MYOB    August 7, 1995
							TRACE:C157
							C_TEXT:C284($jrnlID)
							$jrnlID:=Field:C253($FileNum; 2)->
							$jrnlID:="S"+Substring:C12($jrnlID; 5; 3)+Substring:C12($jrnlID; 9; 4)
							If (Field:C253($FileNum; 4)->=0)
								SEND PACKET:C103(sumDoc; $jrnlID+"\t"+String:C10(Field:C253($FileNum; 3)->; 1)+"\t"+Field:C253($FileNum; 2)->+"\t"+Field:C253($FileNum; 1)->+"\t"+""+"\t"+String:C10(Field:C253($FileNum; 5)->)+"\t"+Field:C253($FileNum; 10)->+"\r")
							Else 
								SEND PACKET:C103(sumDoc; $jrnlID+"\t"+String:C10(Field:C253($FileNum; 3)->; 1)+"\t"+Field:C253($FileNum; 2)->+"\t"+Field:C253($FileNum; 1)->+"\t"+String:C10(Field:C253($FileNum; 4)->)+"\t"+""+"\t"+Field:C253($FileNum; 10)->+"\r")
							End if 
						: ($3=5)  //QuickBooks
							SEND PACKET:C103(sumDoc; "SPL"+"\t"+Field:C253($FileNum; 1)->+"\t"+String:C10((Field:C253($FileNum; 4)->)-(Field:C253($FileNum; 5)->))+"\t")
						: ($3=6)  //MultiLedger              
							SEND PACKET:C103(sumDoc; "\t"+Field:C253($FileNum; 1)->+"\t"+"\t"+Substring:C12(Field:C253($FileNum; 7)->; 1; 25)+"\t"+String:C10((Field:C253($FileNum; 4)->)-(Field:C253($FileNum; 5)->)))
					End case 
					Field:C253($FileNum; 8)->:=2
					SAVE RECORD:C53($1->)
			End case 
			NEXT RECORD:C51($1->)
		End while 
		Case of   //ending information, if required
			: ($3=1)  //Insight
			: ($3=2)  //At Once
			: ($3=3)  //Great Plains
			: ($3=4)  //MYOB
			: ($3=5)  //QuickBooks
			: ($3=6)  //MultiLedger              
				SEND PACKET:C103(sumDoc; "\r")
		End case 
		If (Not:C34($2))
			CLOSE DOCUMENT:C267(sumDoc)
		End if 
	End if 
	If (Records in set:C195("Errors")>0)
		USE SET:C118("Errors")
		ALERT:C41("These locked records must be manual marked as JrnlComplete is true.")
		ProcessTableOpen($1)
	End if 
	CLEAR SET:C117("Errors")
End if 