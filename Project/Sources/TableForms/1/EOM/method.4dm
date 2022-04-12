Case of 
	: (Before:C29)
		C_POINTER:C301($ptBut)
		C_DATE:C307($chDate)
		C_LONGINT:C283($i)
		vdDateBeg:=Date_ThisMon(Current date:C33; 0)
		vdDateEnd:=Date_ThisMon(Current date:C33; 1)
		For ($i; 1; 9)
			$ptBut:=Get pointer:C304("b"+String:C10($i))
			$ptBut->:=1
		End for 
		b3:=0
		b10:=0
		b11:=0
		vSJName:="SJ "+Date_strYrMmDd(vdDateEnd)
		vCJName:="CJ "+Date_strYrMmDd(vdDateEnd)
		vPJName:="PJ "+Date_strYrMmDd(vdDateEnd)
		//  v4:="PO's "+String(vdDateEnd)
	: (Outside call:C328)
		Prs_OutsideCall
End case 
