//%attributes = {"publishedWeb":true}
//Procedure: SrvrSrS_DoSrch
//Noah Dykoski  June 15, 1998 / 2:46 PM

C_BOOLEAN:C305($Delete)
C_LONGINT:C283($index)
For ($index; Size of array:C274(aServiceTableName); 1; -1)
	$Delete:=False:C215
	Case of 
		: (aServiceTableName{$index}="C")  //Customer
			GOTO RECORD:C242([Customer:2]; aServiceRecs{$index})
			If (srCustomer#"")
				$Delete:=([Customer:2]company:2#(srCustomer+"@"))
			End if 
			If (($Delete=False:C215) & (srLstName#""))
				$Delete:=([Customer:2]nameLast:23#(srLstName+"@"))
			End if 
			If (($Delete=False:C215) & (srPhone#""))
				$Delete:=([Customer:2]phone:13#(srPhone+"@"))
			End if 
			If (($Delete=False:C215) & (srState#""))
				$Delete:=([Customer:2]state:7#(srState+"@"))
			End if 
			If (($Delete=False:C215) & (srZip#""))
				$Delete:=([Customer:2]zip:8#(srZip+"@"))
			End if 
			If (($Delete=False:C215) & (srAction#""))
				$Delete:=([Customer:2]action:60#(srAction+"@"))
			End if 
			If (($Delete=False:C215) & (srActionDat#!00-00-00!))
				$Delete:=([Customer:2]actionDate:61#srActionDat)
			End if 
			If (($Delete=False:C215) & (srAdSource#""))
				$Delete:=([Customer:2]adSource:62#(srAdSource+"@"))
			End if 
			If (($Delete=False:C215) & (srSICCode#""))
				$Delete:=([Customer:2]sICCode:16#(srSICCode+"@"))
			End if 
			If (($Delete=False:C215) & (srProspect#""))
				$Delete:=([Customer:2]prospect:17#(srProspect+"@"))
			End if 
			If (($Delete=False:C215) & (srNeed#""))
				$Delete:=([Customer:2]need:21#(srNeed+"@"))
			End if 
			If (($Delete=False:C215) & (srQAThere#0))
				$Delete:=([Customer:2]questionAns:83#(srQAThere=1))
			End if 
			If (($Delete=False:C215) & (srRepID#""))
				$Delete:=([Customer:2]repID:58#(srRepID+"@"))
			End if 
			If (($Delete=False:C215) & (srsalesNameID#""))
				$Delete:=([Customer:2]salesNameID:59#(srsalesNameID+"@"))
			End if 
			If (($Delete=False:C215) & (srProfile1#""))
				$Delete:=([Customer:2]profile1:26#(srProfile1+"@"))
			End if 
			If (($Delete=False:C215) & (srProfile2#""))
				$Delete:=([Customer:2]profile2:27#(srProfile2+"@"))
			End if 
			If (($Delete=False:C215) & (srProfile3#""))
				$Delete:=([Customer:2]profile3:28#(srProfile3+"@"))
			End if 
			If (($Delete=False:C215) & (srProfile4#""))
				$Delete:=([Customer:2]profile4:29#(srProfile4+"@"))
			End if 
			If (($Delete=False:C215) & (srProfile5#""))
				$Delete:=([Customer:2]profile5:30#(srProfile5+"@"))
			End if 
			If (($Delete=False:C215) & (srProfile6#0))
				$Delete:=([Customer:2]profile6:31#(srProfile6=1))
			End if 
			If (($Delete=False:C215) & (srProfile7#0))
				$Delete:=([Customer:2]profile7:32#(srProfile7=1))
			End if 
		: (aServiceTableName{$index}="i")  //Contact
			GOTO RECORD:C242([Contact:13]; aServiceRecs{$index})
			If (srCustomer#"")
				$Delete:=([Contact:13]company:23#(srCustomer+"@"))
			End if 
			If (($Delete=False:C215) & (srLstName#""))
				$Delete:=([Contact:13]nameLast:4#(srLstName+"@"))
			End if 
			If (($Delete=False:C215) & (srPhone#""))
				$Delete:=([Contact:13]phone:30#(srPhone+"@"))
			End if 
			If (($Delete=False:C215) & (srState#""))
				$Delete:=([Contact:13]state:9#(srState+"@"))
			End if 
			If (($Delete=False:C215) & (srZip#""))
				$Delete:=([Contact:13]zip:11#(srZip+"@"))
			End if 
			If (($Delete=False:C215) & (srAction#""))
				$Delete:=([Contact:13]action:32#(srAction+"@"))
			End if 
			If (($Delete=False:C215) & (srActionDat#!00-00-00!))
				$Delete:=([Contact:13]actionDate:33#srActionDat)
			End if 
			If (($Delete=False:C215) & (srQAThere#0))
				$Delete:=([Contact:13]questionAns:40#(srQAThere=1))
			End if 
			If (($Delete=False:C215) & (srProfile1#""))
				$Delete:=([Contact:13]profile1:18#(srProfile1+"@"))
			End if 
			If (($Delete=False:C215) & (srProfile2#""))
				$Delete:=([Contact:13]profile2:19#(srProfile2+"@"))
			End if 
			If (($Delete=False:C215) & (srProfile3#""))
				$Delete:=([Contact:13]profile3:20#(srProfile3+"@"))
			End if 
			If (($Delete=False:C215) & (srProfile4#""))
				$Delete:=([Contact:13]profile4:21#(srProfile4+"@"))
			End if 
			If (($Delete=False:C215) & (srProfile5#""))
				$Delete:=([Contact:13]profile5:22#(srProfile5+"@"))
			End if 
			If (($Delete=False:C215) & (srProfile6#0))
				$Delete:=([Contact:13]profile6:36#(srProfile6=1))
			End if 
			If (($Delete=False:C215) & (srProfile7#0))
				$Delete:=([Contact:13]profile7:37#(srProfile7=1))
			End if 
		: (aServiceTableName{$index}="L")  //Lead
			GOTO RECORD:C242([Lead:48]; aServiceRecs{$index})
			If (srCustomer#"")
				$Delete:=([Lead:48]company:5#(srCustomer+"@"))
			End if 
			If (($Delete=False:C215) & (srLstName#""))
				$Delete:=([Lead:48]nameLast:2#(srLstName+"@"))
			End if 
			If (($Delete=False:C215) & (srPhone#""))
				$Delete:=([Lead:48]phone:4#(srPhone+"@"))
			End if 
			If (($Delete=False:C215) & (srState#""))
				$Delete:=([Lead:48]state:9#(srState+"@"))
			End if 
			If (($Delete=False:C215) & (srZip#""))
				$Delete:=([Lead:48]zip:10#(srZip+"@"))
			End if 
			If (($Delete=False:C215) & (srAction#""))
				$Delete:=([Lead:48]action:26#(srAction+"@"))
			End if 
			If (($Delete=False:C215) & (srActionDat#!00-00-00!))
				$Delete:=([Lead:48]actionDate:23#srActionDat)
			End if 
			If (($Delete=False:C215) & (srAdSource#""))
				$Delete:=([Lead:48]adSource:27#(srAdSource+"@"))
			End if 
			If (($Delete=False:C215) & (srSICCode#""))
				$Delete:=([Lead:48]sICCode:38#(srSICCode+"@"))
			End if 
			If (($Delete=False:C215) & (srProspect#""))
				$Delete:=([Lead:48]prospect:36#(srProspect+"@"))
			End if 
			If (($Delete=False:C215) & (srNeed#""))
				$Delete:=([Lead:48]need:37#(srNeed+"@"))
			End if 
			If (($Delete=False:C215) & (srQAThere#0))
				$Delete:=([Lead:48]questionAns:43#(srQAThere=1))
			End if 
			If (($Delete=False:C215) & (srRepID#""))
				$Delete:=([Lead:48]repID:12#(srRepID+"@"))
			End if 
			If (($Delete=False:C215) & (srsalesNameID#""))
				$Delete:=([Lead:48]salesNameID:13#(srsalesNameID+"@"))
			End if 
			If (($Delete=False:C215) & (srProfile1#""))
				$Delete:=([Lead:48]profile1:14#(srProfile1+"@"))
			End if 
			If (($Delete=False:C215) & (srProfile2#""))
				$Delete:=([Lead:48]profile2:15#(srProfile2+"@"))
			End if 
			If (($Delete=False:C215) & (srProfile3#""))
				$Delete:=([Lead:48]profile3:16#(srProfile3+"@"))
			End if 
			If (($Delete=False:C215) & (srProfile4#""))
				$Delete:=([Lead:48]profile4:17#(srProfile4+"@"))
			End if 
			If (($Delete=False:C215) & (srProfile5#""))
				$Delete:=([Lead:48]profile5:18#(srProfile5+"@"))
			End if 
			If (($Delete=False:C215) & (srProfile6#0))
				$Delete:=([Lead:48]profile6:19#(srProfile6=1))
			End if 
			If (($Delete=False:C215) & (srProfile7#0))
				$Delete:=([Lead:48]profile7:20#(srProfile7=1))
			End if 
		: (aServiceTableName{$index}="S")  //Service
			GOTO RECORD:C242([Service:6]; aServiceRecs{$index})
			If (($Delete=False:C215) & (srAction#""))
				$Delete:=([Service:6]action:20#(srAction+"@"))
			End if 
			If (($Delete=False:C215) & (srActionDat#!00-00-00!))
				TRACE:C157
				$Delete:=(Date:C102(DateTimeofDT([Service:6]dtAction:35; 1))#srActionDat)
			End if 
			If (($Delete=False:C215) & (srRepID#""))
				$Delete:=([Service:6]repID:2#(srRepID+"@"))
			End if 
			If (($Delete=False:C215) & (srsalesNameID#""))
				$Delete:=([Service:6]actionBy:12#(srsalesNameID+"@"))
			End if 
	End case 
	If ($Delete)
		DELETE FROM ARRAY:C228(aServiceTableName; $index)
		DELETE FROM ARRAY:C228(aServiceTime; $index)
		DELETE FROM ARRAY:C228(aServiceDate; $index)
		DELETE FROM ARRAY:C228(aServiceAction; $index)
		DELETE FROM ARRAY:C228(aServiceVariable; $index)
		DELETE FROM ARRAY:C228(aServiceCompany; $index)
		DELETE FROM ARRAY:C228(aServiceAttention; $index)
		DELETE FROM ARRAY:C228(aServiceRecs; $index)
	End if 
End for 
If (Size of array:C274(aServiceTableName)>0)
	ARRAY LONGINT:C221(aSrvLines; 1)
Else 
	ARRAY LONGINT:C221(aSrvLines; 0)
End if 