//%attributes = {"publishedWeb":true}
//Procedure: SRpt_RecvInPeri
//reports the number of invoices and amount into arrays w/ totals
C_DATE:C307($dateBeg)
C_LONGINT:C283($numMon; $i; $prevMon)
$dateBeg:=Date_ThisMon(Date:C102(vText1); 0)
//Date(String(Month of(Date(vText1)))+"/1/"+String(Year of(Date(vText1))))
$numMon:=vR1  //--number of months
ARRAY DATE:C224(aTmpDate1; $numMon)
ARRAY REAL:C219(aTmpReal1; $numMon)
ARRAY REAL:C219(aTmpReal2; $numMon)
ARRAY LONGINT:C221(aTmpLong1; $numMon)
vR3:=0
vR2:=0
For ($i; 1; $numMon)
	vdDateEnd:=Date_ThisMon($dateBeg; 1)
	SRpt_ByAcctInPe(->[Invoice:26]; ->[Invoice:26]customerID:3; ->[Customer:2]customerID:1; <>ptInvoiceDateFld; $dateBeg; vdDateEnd)
	aTmpDate1{$i}:=vdDateEnd
	aTmpReal1{$i}:=Sum:C1([Invoice:26]amount:14)
	If ($i>1)
		$prevMon:=$i-1
		aTmpReal2{$i}:=aTmpReal1{$i}-aTmpReal1{$prevMon}
	Else 
		aTmpReal2{$i}:=0
	End if 
	aTmpLong1{$i}:=Records in selection:C76([Invoice:26])
	$dateBeg:=vdDateEnd+1
	vR2:=vR2+aTmpLong1{$i}
	vR3:=vR3+aTmpReal1{$i}
End for 