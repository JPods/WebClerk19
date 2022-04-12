//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/20/07, 10:05:51
// ----------------------------------------------------
// Method: dCashArrayManage
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1; $2; $3; $4; $areaListID)
If (Count parameters:C259=4)
	$areaListID:=$4
End if 
C_BOOLEAN:C305($expandPrime)
$expandPrime:=False:C215
Case of 
	: ($1=0)
		ARRAY LONGINT:C221(adCashSequence; 0)
		
		ARRAY REAL:C219(adCashRunningBalance; 0)
		ARRAY REAL:C219(adCashAvailable; 0)
		
		ARRAY TEXT:C222(adCashNameID; 0)
		ARRAY DATE:C224(adCashDate; 0)
		ARRAY TEXT:C222(adCashTerms; 0)
		ARRAY REAL:C219(adCashAmount; 0)
		ARRAY LONGINT:C221(adCashRecNum; 0)
		
		ARRAY TEXT:C222(adCashApplyCustomer; 0)
		ARRAY LONGINT:C221(adCashApplyTable; 0)
		ARRAY LONGINT:C221(adCashApplyDoc; 0)
		
		ARRAY TEXT:C222(adCashRecieveCustomer; 0)
		ARRAY LONGINT:C221(adCashReceiveTable; 0)
		ARRAY LONGINT:C221(adCashReceiveDoc; 0)
		
		ARRAY LONGINT:C221(adCashLinesSelect; 0)
		
	: ($1>0)
		SELECTION TO ARRAY:C260([DCash:62]changeAmount:5; adCashAmount; [DCash:62]dateEvent:6; adCashDate; [DCash:62]terms:9; adCashTerms; [DCash:62]nameID:12; adCashNameID; [DCash:62]customerIDApply:1; adCashApplyCustomer; [DCash:62]docApply:3; adCashApplyDoc; [DCash:62]tableApply:2; adCashApplyTable; [DCash:62]customerIDReceive:7; adCashRecieveCustomer; [DCash:62]docReceive:4; adCashReceiveDoc; [DCash:62]tableReceive:8; adCashReceiveTable; [DCash:62]; adCashRecNum)
		
		ARRAY REAL:C219(adCashRunningBalance; $1)
		ARRAY REAL:C219(adCashAvailable; $1)
		ARRAY LONGINT:C221(adCashSequence; $1)
		$expandPrime:=True:C214
		
		
	: ($1=-3)
		$w:=$2
		$cnt:=$3
		INSERT IN ARRAY:C227(adCashSequence; 1)
		INSERT IN ARRAY:C227(adCashRunningBalance; $w; 1)
		INSERT IN ARRAY:C227(adCashAvailable; $w; 1)
		//
		INSERT IN ARRAY:C227(adCashNameID; $w; 1)
		INSERT IN ARRAY:C227(adCashRecNum; $w; 1)
		INSERT IN ARRAY:C227(adCashDate; $w; 1)
		INSERT IN ARRAY:C227(adCashTerms; $w; 1)
		INSERT IN ARRAY:C227(adCashAmount; $w; 1)
		//
		INSERT IN ARRAY:C227(adCashApplyCustomer; $w; 1)
		INSERT IN ARRAY:C227(adCashApplyTable; $w; 1)
		INSERT IN ARRAY:C227(adCashApplyDoc; $w; 1)
		//
		INSERT IN ARRAY:C227(adCashRecieveCustomer; $w; 1)
		INSERT IN ARRAY:C227(adCashReceiveTable; $w; 1)
		INSERT IN ARRAY:C227(adCashReceiveDoc; $w; 1)
		
	: ($1=-1)
		$w:=$2
		$cnt:=$3
		DELETE FROM ARRAY:C228(adCashSequence; $w; 1)
		DELETE FROM ARRAY:C228(adCashRunningBalance; $w; 1)
		DELETE FROM ARRAY:C228(adCashAvailable; $w; 1)
		//
		DELETE FROM ARRAY:C228(adCashNameID; $w; 1)
		DELETE FROM ARRAY:C228(adCashRecNum; $w; 1)
		DELETE FROM ARRAY:C228(adCashDate; $w; 1)
		DELETE FROM ARRAY:C228(adCashTerms; $w; 1)
		DELETE FROM ARRAY:C228(adCashAmount; $w; 1)
		//
		DELETE FROM ARRAY:C228(adCashApplyCustomer; $w; 1)
		DELETE FROM ARRAY:C228(adCashApplyTable; $w; 1)
		DELETE FROM ARRAY:C228(adCashApplyDoc; $w; 1)
		//
		DELETE FROM ARRAY:C228(adCashRecieveCustomer; $w; 1)
		DELETE FROM ARRAY:C228(adCashReceiveTable; $w; 1)
		DELETE FROM ARRAY:C228(adCashReceiveDoc; $w; 1)
		
		
End case 



If ($expandPrime)
	dCashArrayManage(-3; 1; 1)  //add line for document being paid.
	$w:=1
	If (adCashReceiveTable{1}=26)
		QUERY:C277([Invoice:26]; [Invoice:26]idNum:2=adCashReceiveDoc{1})
		adCashAvailable{$w}:=[Invoice:26]balanceDue:44
		adCashAmount{$w}:=[Invoice:26]total:18
		adCashDate{$w}:=[Invoice:26]dateDocument:35
		adCashTerms{$w}:=[Invoice:26]terms:24
		adCashNameID{$w}:=[Invoice:26]producedBy:65
		adCashRecNum{$w}:=Record number:C243([Invoice:26])
		//
		adCashApplyCustomer{$w}:=""
		adCashApplyDoc{$w}:=-1
		adCashApplyTable{$w}:=-1
		//
		adCashRecieveCustomer{$w}:=[Invoice:26]customerID:3
		adCashReceiveDoc{$w}:=[Invoice:26]idNum:2
		adCashReceiveTable{$w}:=26
		
		adCashRunningBalance{$w}:=0
	End if 
	
	
	
	$w:=Size of array:C274(adCashAvailable)+1
	dCashArrayManage(-3; $w; 1)  //add line for document being paid.
	
	If (adCashApplyTable{2}=26)
		QUERY:C277([Invoice:26]; [Invoice:26]idNum:2=adCashApplyDoc{1})
		adCashAvailable{$w}:=[Invoice:26]balanceDue:44
		adCashAmount{$w}:=[Invoice:26]total:18
		adCashDate{$w}:=[Invoice:26]dateDocument:35
		adCashTerms{$w}:=[Invoice:26]terms:24
		adCashNameID{$w}:=[Invoice:26]producedBy:65
		adCashRecNum{$w}:=Record number:C243([Invoice:26])
		//
		adCashApplyCustomer{$w}:=[Invoice:26]customerID:3
		adCashApplyDoc{$w}:=[Invoice:26]idNum:2
		adCashApplyTable{$w}:=26
		//
		adCashRecieveCustomer{$w}:=""
		adCashReceiveDoc{$w}:=-1
		adCashReceiveTable{$w}:=-1
		
		adCashRunningBalance{$w}:=0
	End if 
	//
	If (adCashApplyTable{2}=28)
		QUERY:C277([Payment:28]; [Payment:28]idNum:8=adCashApplyDoc{1})
		adCashAvailable{$w}:=[Payment:28]amountAvailable:19
		adCashAmount{$w}:=[Payment:28]amount:1
		adCashDate{$w}:=[Payment:28]dateDocument:10
		adCashTerms{$w}:=[Payment:28]typePayment:6
		adCashNameID{$w}:=[Payment:28]takeBy:42
		adCashRecNum{$w}:=Record number:C243([Payment:28])
		//
		adCashApplyCustomer{$w}:=[Payment:28]customerID:4
		adCashApplyDoc{$w}:=[Payment:28]idNum:8
		adCashApplyTable{$w}:=28
		//
		adCashRecieveCustomer{$w}:=""
		adCashReceiveDoc{$w}:=-1
		adCashReceiveTable{$w}:=-1
		
		adCashRunningBalance{$w}:=0
	End if 
	
	$w:=Size of array:C274(adCashAvailable)
	For ($inc; 1; $w)
		adCashSequence{$inc}:=$inc
	End for 
	
	
	ARRAY LONGINT:C221(adCashLinesSelect; 0)
	
	If (False:C215)
		adCashAmount{$w}:=[DCash:62]changeAmount:5
		adCashDate{$w}:=[DCash:62]dateEvent:6
		adCashTerms{$w}:=[DCash:62]terms:9
		adCashNameID{$w}:=[DCash:62]nameID:12
		adCashApplyCustomer{$w}:=[DCash:62]customerIDApply:1
		adCashApplyDoc{$w}:=[DCash:62]docApply:3
		adCashApplyTable{$w}:=[DCash:62]tableApply:2
		adCashRecieveCustomer{$w}:=[DCash:62]customerIDReceive:7
		adCashReceiveDoc{$w}:=[DCash:62]docReceive:4
		adCashReceiveTable{$w}:=[DCash:62]tableReceive:8
		adCashRecNum{$w}:=Record number:C243([DCash:62])
	End if 
	
	
End if 

If ($areaListID>0)
	//  --  CHOPPED  AL_UpdateArrays($areaListID; -2)
End if 

If (False:C215)
	
	ARRAY REAL:C219(adCashRunningBalance; $1)
	If (adCashReceiveTable{1}=26)
		Case of 
			: (adCashReceiveTable{1}=26)
				QUERY:C277([Invoice:26]; [Invoice:26]idNum:2=adCashReceiveDoc{1})
				
				
				adCashAmount{$w}:=[Invoice:26]total:18
				adCashDate{$w}:=Current date:C33
				adCashTerms{$w}:=[Invoice:26]terms:24
				adCashNameID{$w}:=[Invoice:26]producedBy:65
				adCashRecNum{$w}:=Record number:C243([Invoice:26])
				//
				adCashApplyCustomer{$w}:=""
				adCashApplyDoc{$w}:=-1
				adCashApplyTable{$w}:=-1
				//
				adCashRecieveCustomer{$w}:=[Invoice:26]customerID:3
				adCashReceiveDoc{$w}:=[Invoice:26]idNum:2
				adCashReceiveTable{$w}:=26
				
				adCashRunningBalance{$w}:=0
				
				ARRAY LONGINT:C221(adCashLinesSelect; 0)
				
				If (False:C215)
					adCashAmount{$w}:=[DCash:62]changeAmount:5
					adCashDate{$w}:=[DCash:62]dateEvent:6
					adCashTerms{$w}:=[DCash:62]terms:9
					adCashNameID{$w}:=[DCash:62]nameID:12
					adCashApplyCustomer{$w}:=[DCash:62]customerIDApply:1
					adCashApplyDoc{$w}:=[DCash:62]docApply:3
					adCashApplyTable{$w}:=[DCash:62]tableApply:2
					adCashRecieveCustomer{$w}:=[DCash:62]customerIDReceive:7
					adCashReceiveDoc{$w}:=[DCash:62]docReceive:4
					adCashReceiveTable{$w}:=[DCash:62]tableReceive:8
					adCashRecNum{$w}:=Record number:C243([DCash:62])
				End if 
				
				
				
		End case 
	End if 
End if 

