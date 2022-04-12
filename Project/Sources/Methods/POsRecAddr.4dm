//%attributes = {"publishedWeb":true}
C_TEXT:C284($temp)
C_LONGINT:C283($i; $k; $w)
$temp:=""
[PO:39]shipToCompany:8:=Storage:C1525.default.company
[PO:39]address1:9:=Storage:C1525.default.address1
[PO:39]address2:10:=Storage:C1525.default.address2
[PO:39]city:11:=Storage:C1525.default.city
[PO:39]state:12:=Storage:C1525.default.state
[PO:39]zip:13:=Storage:C1525.default.zip
[PO:39]country:14:=Storage:C1525.default.country
[PO:39]attention:26:=Current user:C182
$k:=Length:C16(Storage:C1525.default.phone)
For ($i; 1; $k)
	$w:=Character code:C91(Storage:C1525.default.phone[[$i]])
	$temp:=$temp+(Storage:C1525.default.phone[[$i]]*(Num:C11(($w>47) & ($w<58))))  //
End for 
[PO:39]phone:15:=$temp
$temp:=""
$k:=Length:C16(Storage:C1525.default.fax)
For ($i; 1; $k)
	$w:=Character code:C91(Storage:C1525.default.fax[[$i]])
	$temp:=$temp+(Storage:C1525.default.fax[[$i]]*(Num:C11(($w>47) & ($w<58))))  //
End for 
[PO:39]fax:16:=$temp
//  Put  the formating in the form  jFormatPhone(->[PO]phone; ->[PO]fax)
[PO:39]shipDate:36:=Current date:C33
[PO:39]shipVia:33:=Storage:C1525.default.shipVia
[PO:39]shipInstruct:31:=""