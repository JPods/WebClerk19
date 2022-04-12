//%attributes = {"publishedWeb":true}
//Procedure: BarC_MultiLabel
//October 25, 1995
If (False:C215)
	TCStrong_prf_v144_ThermoSet
	TCStrong_prf_v144_ThermoSRetok
	//02/19/03.prf
	//replaced plugin ThermoSet  
	TCStrong_prf_v142_ProcExt
	//01/30/03.prf
	//removed SuperLabel    
End if 

C_LONGINT:C283($i; $k; $w; myCount; $lbCnt; $cntItem; vi1; $doThisCnt; $result)
C_TEXT:C284(BarCode39)
C_DATE:C307(vDate)
C_TIME:C306(vTime)
C_BOOLEAN:C305($doSrch)
C_POINTER:C301($1; $2; $3; $ptFile; $ptItemCnt; $4; $5)
$sizeWindow:=1024+512
//File; Field Cnt holder; alt File srch)
vi1:=0
$doSrch:=False:C215
$doThisCnt:=Num:C11(Request:C163("Qty O/H or your count"; "Qty O/H"))
If (OK=1)
	<>aTableNums:=Table:C252(->[Item:4])  //in case of jotc is called
	//  ON EVENT CALL("jotcCmdQAction")
	READ ONLY:C145([Item:4])
	Path_Set(Storage:C1525.folder.jitLabelsF)
	Case of 
		: ($doThisCnt=0)
			$ptFile:=$1
			$ptItemCnt:=$2
		: ($doThisCnt>=1)
			$ptFile:=$1
			vi1:=$doThisCnt
			$ptItemCnt:=->vi1
	End case 
	If ($doThisCnt>=0)
		If (Count parameters:C259>2)
			$doSrch:=True:C214
		End if 
		ARRAY LONGINT:C221(aItemRecs; 0)
		ARRAY LONGINT:C221(aTmpLong1; 0)
		ARRAY LONGINT:C221(aTmpLong2; 0)
		ARRAY LONGINT:C221(aTmpLong3; 0)
		ARRAY TEXT:C222(aTmpText1; 0)
		$lbCnt:=0
		FIRST RECORD:C50($1->)
		$k:=Records in selection:C76($1->)
		$w:=0
		//ThermoInitExit ("Loading Records";$k;True)
		
		$viProgressID:=Progress New
		
		For ($i; 1; $k)
			If ($doSrch)
				If ([Item:4]itemNum:1#$3->)
					QUERY:C277([Item:4]; [Item:4]itemNum:1=$3->)
				End if 
			End if 
			//Thermo_Update ($i)
			ProgressUpdate($viProgressID; $i; $k; "Loading Records")
			
			If (<>ThermoAbort)
				$i:=$k
			End if 
			C_LONGINT:C283($thisRecCnt)
			$thisRecCnt:=Abs:C99($ptItemCnt->)
			$lbCnt:=$lbCnt+$thisRecCnt
			$cntItem:=0
			
			While ($cntItem<$thisRecCnt)
				$cntItem:=$cntItem+1
				$w:=$w+1
				INSERT IN ARRAY:C227(aItemRecs; $w)
				aItemRecs{$w}:=Record number:C243([Item:4])
				INSERT IN ARRAY:C227(aTmpLong1; $w)
				INSERT IN ARRAY:C227(aTmpLong2; $w)
				INSERT IN ARRAY:C227(aTmpLong3; $w)
				INSERT IN ARRAY:C227(aTmpText1; $w)
				
				Case of 
					: ($doSrch=False:C215)
					: ($4->="PO@")
						aTmpLong1{$w}:=Table:C252(->[PO:39])
						aTmpLong2{$w}:=$5->
						aTmpLong3{$w}:=$6->
					: ($4->="or@")
						aTmpLong1{$w}:=Table:C252(->[Order:3])
						aTmpLong2{$w}:=$5->
						aTmpLong3{$w}:=$6->
					: ($4->="In@")
						aTmpLong1{$w}:=Table:C252(->[Invoice:26])
						aTmpLong2{$w}:=$5->
						aTmpLong3{$w}:=$6->
					: ($4->="Ad@")
						aTmpLong1{$w}:=Table:C252(->[InventoryStack:29])
						aTmpLong2{$w}:=$5->
						aTmpLong3{$w}:=$6->
				End case 
			End while 
			NEXT RECORD:C51($1->)
		End for 
		//Thermo_Close
		
		Progress QUIT($viProgressID)
		
		If (Not:C34(ThermoAbort))
			vlongCnt:=0
			ARRAY TEXT:C222(SLVarNames; 3)
			ARRAY LONGINT:C221(SLVarTypes; 3)
			SLVarNames{1}:="vDate"
			SLVarTypes{1}:=4  //Type(vDate)
			SLVarNames{2}:="vTime"
			SLVarTypes{2}:=11  //Type(vTime)
			SLVarNames{3}:="BarCode39"
			SLVarTypes{3}:=0  //Type(BarCode39)
			vDate:=Current date:C33
			vTime:=Current time:C178
			//01/30/03.prf
			//SuperLabel (-$lbCnt;"";$sizeWindow;1;1;"BarC_Fill")//show editor + use procedur
		End if 
		ARRAY TEXT:C222(SLVarNames; 2)
		ARRAY LONGINT:C221(SLVarTypes; 2)
		ARRAY LONGINT:C221(aItemRecs; 0)
		ARRAY LONGINT:C221(aTmpLong1; 0)
		ARRAY LONGINT:C221(aTmpLong2; 0)
		ARRAY LONGINT:C221(aTmpLong3; 0)
	End if 
	READ WRITE:C146([Item:4])
	//  ON EVENT CALL("")
End if 