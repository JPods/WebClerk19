//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/15/11, 15:01:29
// ----------------------------------------------------
// Method: LabelsFill
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1)
C_TEXT:C284($2)
QUERY:C277([Template:130]; [Template:130]tableNum:2=$1; *)
QUERY:C277([Template:130];  & [Template:130]name:3=$2)

ARRAY TEXT:C222(aiLoText8; 0)
Case of 
	: (Records in selection:C76([Template:130])>1)
		FIRST RECORD:C50([Template:130])
		If (allowAlerts_boo)
			ALERT:C41("Multiple Template records.")
		End if 
		TextToArray([Template:130]packedList:5; ->aiLoText8; ","; True:C214)
		$k:=Size of array:C274(aiLoText8)
		C_POINTER:C301($ptVariable)
		If ($k>99)
			$k:=99
		End if 
		For ($i; 1; $k)
			$ptVariable:=Get pointer:C304("vLabel"+String:C10($i; "000"))
			$ptVariable->:=aiLoText8{$i}
		End for 
	: (Records in selection:C76([Template:130])=1)
		TextToArray([Template:130]packedList:5; ->aiLoText8; ","; True:C214)
		$k:=Size of array:C274(aiLoText8)
		If ($k>99)
			$k:=99
		End if 
		For ($i; 1; $k)
			$ptVariable:=Get pointer:C304("vLabel"+String:C10($i; "000"))
			$ptVariable->:=aiLoText8{$i}
		End for 
		
	: ($1=Table:C252(->[GenericChild1:90]))
		$textBlock:=""
		$textBlock:=$textBlock+"GenericChild1ID,GenericParentID,Name,Purpose,Publish,LI01,LI02,LI03,LI04,LI05,"
		$textBlock:=$textBlock+"LI06,Bool01,Bool02,Bool03,Bool04,Bool05,Bool06,R01,R02,R03,R04,R05,R06,D01,D02,"
		$textBlock:=$textBlock+"D03,D04,D05,D06,H01,H02,H03,H04,DT01,DT02,DT03,DT04,A80_01,A80_02,A40_01,"
		$textBlock:=$textBlock+"A40_02,A40_03,A40_04,T01,T02,T03,T04,P01,P02,Blob01,Blob02,idNum,DTDeath,"
		$textBlock:=$textBlock+"customerID,TableNum,ItemNum,TemplateName"
		If (False:C215)
			$textBlock:="GenericChild1ID,GenericParentID,Name,Purpose,Publish,LI01,LI02,LI03,LI04,LI05"
			$textBlock:=$textBlock+"LI06"
			$textBlock:=$textBlock+",Bool01,Bool02,Bool03,Bool04,Bool05,Bool06,R01,R02,R03,R04,R05,R06,D01"
			$textBlock:=$textBlock+",D02,D03,D04"
			$textBlock:=$textBlock+",D05,D06,H01,H02,H03,H04,DT01,DT02,DT03,DT04,A80_01,A80_02,A40_01,A40_02,A40_03"
			$textBlock:=$textBlock+",A40_04,T01,T02,T03,T04,P01,P02,Blob01,Blob02,idNum,DTDeath,customerID,TableNum"
			$textBlock:=$textBlock+",ItemNum,TemplateName"
		End if 
		TextToArray($textBlock; ->aiLoText8; ",")
		$k:=Size of array:C274(aiLoText8)
		If ($k>99)
			$k:=99
		End if 
		For ($i; 1; $k)
			$ptVariable:=Get pointer:C304("vLabel"+String:C10($i; "000"))
			$ptVariable->:=aiLoText8{$i}
		End for 
		
	: ($1=Table:C252(->[GenericChild2:91]))
		$textBlock:=""
		$textBlock:=$textBlock+"GenericChild2ID,GenericParentID,Name,Purpose,Publish,LI01,LI02,LI03,LI04,"
		$textBlock:=$textBlock+"Bool01,Bool02,Bool03,Bool04,R01,R02,R03,R04,D01,D02,D03,D04,H01,H02,DT01,"
		$textBlock:=$textBlock+"DT02,DT03,A80_01,A40_01,A40_02,A40_03,A40_04,T01,T02,T03,T04,P01,P02,"
		$textBlock:=$textBlock+"Blob01,Blob02,idNum,customerID,TableNum,ItemNum,TemplateName"
		
		If (False:C215)
			$textBlock:="GenericChild2ID,GenericParentID,Name,Purpose,Publish,LI01,LI02,LI03,LI04"
			$textBlock:=$textBlock+",Bool01,Bool02"
			$textBlock:=$textBlock+",Bool03,Bool04,R01,R02,R03,R04,D01,D02,D03,D04,H01,H02,DT01,DT02,DT03,A80_01"
			$textBlock:=$textBlock+",A40_01,A40_02,A40_03,A40_04,T01,T02,T03,T04,P01,P02,Blob01,Blob02,idNum"
			$textBlock:=$textBlock+",customerID,TableNum,ItemNum,TemplateName"
		End if 
		TextToArray($textBlock; ->aiLoText8; ",")
		$k:=Size of array:C274(aiLoText8)
		If ($k>99)
			$k:=99
		End if 
		For ($i; 1; $k)
			$ptVariable:=Get pointer:C304("vLabel"+String:C10($i; "000"))
			$ptVariable->:=aiLoText8{$i}
		End for 
		
		
	: (($1=Table:C252(->[Item:4])) | ($1=Table:C252(->[Item:4])))
		vLabel050:=<>vItemsType
		vLabel051:=vItemsProfile1
		vLabel052:=vItemsProfile2
		vLabel053:=vItemsProfile3
		vLabel054:=vItemsProfile4
		vLabel055:="Profile5"
		vLabel056:="Profile6"
		
		vLabel071:=<>tcPriceLvlA
		vLabel072:=<>tcPriceLvlB
		vLabel073:=<>tcPriceLvlC
		vLabel074:=<>tcPriceLvlD
		
		vLabel061:="Indicator1"
		vLabel062:="Indicator2"
		vLabel063:="Indicator3"
		vLabel064:="Indicator4"
		vLabel065:="Indicator5"
		vLabel066:="Indicator6"
		vLabel067:="Indicator7"
		
		vLabel005:=<>vItemSpecProfile1
		vLabel006:=<>vItemSpecProfile2
		vLabel007:=<>vItemSpecProfile3
		vLabel008:=<>vItemSpecProfile4
		vLabel009:=<>vItemSpecProfile5
		vLabel010:=<>vItemSpecProfile6
		vLabel011:=<>vItemSpecProfile7
		vLabel012:=<>vItemSpecProfile8
		vLabel013:=<>vItemSpecProfile9
		vLabel014:=<>vItemSpecProfile10
		vLabel015:=<>vItemSpecProfile11
		vLabel016:=<>vItemSpecProfile12
		vLabel017:=<>vItemSpecProfile13
		vLabel018:=<>vItemSpecProfile14
		vLabel019:=<>vItemSpecProfile15
		vLabel020:=<>vItemSpecProfile16
		vLabel021:=<>vItemSpecProfile17
		vLabel022:=<>vItemSpecProfile18
		vLabel023:=<>vItemSpecProfile19
		vLabel024:=<>vItemSpecProfile20
		vLabel025:=<>vItemSpecProfile21
		
		vLabel030:="Profile30"
		vLabel031:="Profile31"
		vLabel032:="Profile32"
		vLabel033:="Profile33"
		vLabel034:="Profile34"
		
		
End case 
REDUCE SELECTION:C351([Template:130]; 0)