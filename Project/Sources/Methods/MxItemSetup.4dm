//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-07-02T00:00:00, 07:17:59
// ----------------------------------------------------
// Method: MxItemSetup
// Description
// Modified: 07/02/13
// 
// 
//
// Parameters
// $1 [Item]Class
// $2 is pointer to the desired PricePointField

// ----------------------------------------------------
C_TEXT:C284($1; $theClass)  //Class
C_POINTER:C301($2; $thePriceField)  //PriceField
C_LONGINT:C283($3; $theAction)  // 
C_TEXT:C284($4; $longDesc)  //long description
C_LONGINT:C283($5; $numDetails)  //number of Details


//030310

//Item Class
//Price Point

MxFillArray(0)
TRACE:C157
FIRST RECORD:C50([Item:4])
LOAD RECORD:C52([Item:4])
If (Count parameters:C259#5)
	$theClass:=[Item:4]class:92
	$thePriceField:=(->[Item:4]priceA:2)
	$theAction:=2
	$longDesc:=$theClass
	$numDetails:=5
End if 
ARRAY LONGINT:C221($aRecNum; 0)
ARRAY TEXT:C222($aItemNum; 0)
ARRAY REAL:C219($aQtyOH; 0)  //On Hand
ARRAY TEXT:C222($aShortName; 0)  //XXL, XL, L, M, etc...
ARRAY TEXT:C222($aTierName; 0)  //Red, Green, Blue
ARRAY LONGINT:C221($aSequence; 0)  //column num
ARRAY LONGINT:C221($aTier; 0)  //row num
ARRAY REAL:C219($aPrice; 0)  //row num
QUERY:C277([Item:4]; [Item:4]class:92=$1)
SELECTION TO ARRAY:C260([Item:4]; $aRecNum; $2->; $aPrice; [Item:4]itemNum:1; $aItemNum; [Item:4]qtyOnHand:14; $aQtyOH; [Item:4]profile2:36; $aTierName; [Item:4]profile1:35; $aShortName; [Item:4]indicator1:95; $aTier; [Item:4]indicator2:96; $aSequence)
// REDUCE SELECTION([Item];0)
MULTI SORT ARRAY:C718($aTier; >; $aSequence; >; $aItemNum; >; $aRecNum; $aPrice; $aQtyOH; $aShortName; $aTierName)
QUERY:C277([Catalog:102]; [Catalog:102]classid:2=$1)
TextToArray([Catalog:102]headers:5; ->aText9; ", ")
$maxUseSize:=Size of array:C274(aText9)
//
$curSeq:=0
$curTier:=0
$i:=1
$k:=Size of array:C274($aItemNum)
If ($k>0)
	$curTier:=$aTier{1}
	$w:=Size of array:C274(aMxCat01)+1
	MxFillArray(-3; $w; $numDetails)
	Repeat 
		While ($curTier=$aTier{$i})
			//
			aMxClass{$w}:=$1
			aMxDescription{$w}:=$aTierName{$i}
			aMxClass{$w+1}:=$1
			aMxDescription{$w+1}:=$aTierName{$i}
			aMxClass{$w+2}:=$1
			aMxDescription{$w+2}:=$aTierName{$i}
			If ($numDetails>3)  //ItemNum
				aMxClass{$w+3}:=$1
				aMxDescription{$w+3}:=$aTierName{$i}
				If ($numDetails>4)  //ShortName & Sequence
					aMxClass{$w+4}:=$1
					aMxDescription{$w+4}:=$aTierName{$i}
				End if 
			End if 
			
			//
			$rayFound:=Find in array:C230(aText9; $aShortName{$i})
			If (($rayFound>0) & ($rayFound<40))
				C_POINTER:C301($ptRay)
				$ptRay:=Get pointer:C304("aMxCat"+String:C10($rayFound; "00"))
				$ptRay->{$w}:=$aItemNum{$i}
				$ptRay->{$w+1}:=String:C10($aRecNum{$i})
				$ptRay->{$w+2}:=String:C10($aQtyOH{$i})
				If ($numDetails>3)
					$ptRay->{$w+3}:=String:C10($aPrice{$i})
					If ($numDetails>4)
						$ptRay->{$w+4}:=$aShortName{$i}
					End if 
				End if 
			Else 
				aMxDescription{$w}:="Mis-match"
			End if 
			If ($i<$k)
				$i:=$i+1
			Else 
				$curTier:=-1
			End if 
		End while 
		If (($i<=$k) & ($curTier>0))
			$curTier:=$aTier{$i}
			$w:=Size of array:C274(aMxCat01)+1
			MxFillArray(-3; $w; $numDetails)
		End if 
	Until ($curTier=-1)
End if 
Case of 
	: ($3=1)
		vText1:=""
		$k:=Size of array:C274(aMxDescription)
		For ($i; 1; $k)
			vText1:=vText1+aMxClass{$i}+"\t"+aMxDescription{$i}+"\t"
			For ($incRay; 1; $maxUseSize)
				$ptRay:=Get pointer:C304("aMxCat"+String:C10($incRay; "00"))
				vText1:=vText1+$ptRay->{$i}+"\t"
			End for 
			vText1:=vText1+"\r"
		End for 
		SET TEXT TO PASTEBOARD:C523(vText1)
	: ($3=2)
		vText1:="<Table Border=1 cellpadding=1 cellspacing=1 width="+Txt_Quoted("100%")+">"
		vText1:=vText1+"<TR>"+"\r"+"<TD CLASS="+Txt_Quoted("MxHeader")+">"+$1+"</TD>"
		For ($i; 1; $maxUseSize)
			vText1:=vText1+"<TD CLASS="+Txt_Quoted("MxClass")+">"+aText9{$i}+"</TD>"
		End for 
		vText1:=vText1+"</TR>"+"\r"
		$k:=Size of array:C274(aMxDescription)
		For ($i; 1; $k)
			vText1:=vText1+"<TR>"+"\r"+"<TD CLASS="+Txt_Quoted("MxTier")+">"+aMxDescription{$i}+"</TD>"
			For ($incRay; 1; $maxUseSize)
				$ptRay:=Get pointer:C304("aMxCat"+String:C10($incRay; "00"))
				
				vText1:=vText1+"<TD CLASS="+Txt_Quoted("MxData")+">"+$ptRay->{$i}+"</TD>"
			End for 
			vText1:=vText1+"</TR>"+"\r"
		End for 
		vText1:=vText1+"</Table>"+"\r"
		SET TEXT TO PASTEBOARD:C523(vText1)
		
	: ($3=3)
		vText1:="<Table Border=1 cellpadding=1 cellspacing=1 width=100%>"
		vText1:=vText1+"<TR>"+"\r"+"<TD CLASS="+Txt_Quoted("MxHeader")+">"+$1+"</TD>"
		For ($i; 1; $maxUseSize)
			vText1:=vText1+"<TD CLASS="+Txt_Quoted("MxClass")+">"+aText9{$i}+"</TD>"
		End for 
		vText1:=vText1+"</TR>"+"\r"
		$k:=Size of array:C274(aMxDescription)
		For ($i; 1; $k)
			If (Mod:C98($i; 5)=1)
				vText1:=vText1+"<TR>"+"\r"+"<TD CLASS="+Txt_Quoted("MxTier")+">"+aMxDescription{$i}+"</TD>"
				For ($incRay; 1; $maxUseSize)
					$ptRay:=Get pointer:C304("aMxCat"+String:C10($incRay; "00"))
					vText1:=vText1+"<TD CLASS="+Txt_Quoted("MxData")+"><INPUT TYPE="+Txt_Quoted("text")+" NAME="+Txt_Quoted("ItemNum"+$ptRay->{$i})+" VALUE="+Txt_Quoted("")+" Length=10 size=10>"
					vText1:=vText1+"<BR>"+$ptRay->{$i+2}+" // "+$ptRay->{$i+3}+"</TD>"+"\r"
					
				End for 
				vText1:=vText1+"</TR>"+"\r"
			End if 
		End for 
		vText1:=vText1+"</Table>"+"\r"
		SET TEXT TO PASTEBOARD:C523(vText1)
		
	: ($3=11)
		Case of 
			: ($maxUseSize=1)
				ARRAY LONGINT:C221(aItemLines; 0)
				
				
				
				
				
		End case 
End case 
ALERT:C41("Results on Clipboard")