//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Html_UrlFill
	//Date: 07/01/02
	//Who: Bill
	//Description: Build links without jitxUser
End if 

C_TEXT:C284($0; $2; $4)
C_POINTER:C301($1; $5)
C_LONGINT:C283($3; $theBreaks; $activeElements)
C_BOOLEAN:C305(<>doeventID)
$0:=""
$theBreaks:=$3
//trACE
//
$doName:=False:C215
If (Count parameters:C259>3)
	$doName:=True:C214
End if 
C_LONGINT:C283($i; $k; $fillCnt; $fillinc)
C_TEXT:C284($thefont)

$theFont:=""
$endFont:=""
$thetarget:=" target="+Txt_Quoted("Main_Frame")
$thecenter:=""
$endcenter:=""
$k:=Size of array:C274($1->)
For ($i; $k; 1; -1)
	If ($1->{$i}="")
		DELETE FROM ARRAY:C228($1->; $i; 1)
		If ($doName)
			DELETE FROM ARRAY:C228($5->; $i; 1)
		End if 
	End if 
End for 
$k:=Size of array:C274($1->)
Case of 
	: ($theBreaks>1)
		//trACE
		$remainder:=Mod:C98($k; $theBreaks)
		If ($remainder=0)
			$activeElements:=$k
			$fillCnt:=$k\$theBreaks
		Else 
			$fillCnt:=($k\$theBreaks)+1
			$activeElements:=$k
			$k:=$theBreaks*$fillCnt
		End if 
		
		
		$thecenter:="<center>"
		$endcenter:="</center>"
		
		$0:="<table width="+Txt_Quoted("100%")+"><tr><td valign="+Txt_Quoted("top")+" align="+Txt_Quoted("center")+" class="+Txt_Quoted("tdLinks")+">"
		
		$fillinc:=0
		For ($i; 1; $k)
			$fillinc:=$fillinc+1
			
			If ($i<=$activeElements)
				If ($doName)
					$0:=$0+"\r"+"<br><a href="+Txt_Quoted($2+$1->{$i})+$thetarget+">"+$theFont+$5->{$i}+$endFont+"</a>"
				Else 
					$0:=$0+"\r"+"<br><a href="+Txt_Quoted($2+$1->{$i})+$thetarget+">"+$theFont+$1->{$i}+$endFont+"</a>"
				End if 
			End if 
			//      
			If (($fillinc=$fillCnt) & ($i#$k))
				$0:=$0+"\r"+"</td><td valign="+Txt_Quoted("top")+" align="+Txt_Quoted("center")+" class="+Txt_Quoted("tdLinks")+">"
				$fillinc:=0
			End if 
		End for 
		$0:=$0+"\r"+"</td></tr></table>"
	: (($theBreaks<1) | ($theBreaks>30))
		For ($i; 1; $k)
			If ($i<=$activeElements)
				
				If ($doName)
					$0:=$0+"<a href="+Txt_Quoted($2+$1->{$i})+Txt_Quoted($thetarget)+">"+$theFont+$5->{$i}+$endFont+"</a>"+(", "*Num:C11($i<$k))
					
				Else 
					$0:=$0+"<a href="+Txt_Quoted($2+$1->{$i})+Txt_Quoted($thetarget)+">"+$theFont+$1->{$i}+$endFont+"</a>"+(", "*Num:C11($i<$k))
				End if 
				
				
			End if 
		End for 
	Else 
		For ($i; 1; $k)
			
			If ($i<=$activeElements)
				
				If ($doName)
					$0:=$0+"<br><a href="+Txt_Quoted($2+$1->{$i})+Txt_Quoted($thetarget)+">"+$theFont+$5->{$i}+$endFont+"</a>"
					
				Else 
					$0:=$0+"<br><a href="+Txt_Quoted($2+$1->{$i})+Txt_Quoted($thetarget)+">"+$theFont+$1->{$i}+$endFont+"</a>"
				End if 
				
				
			End if 
			
		End for 
End case 