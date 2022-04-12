//%attributes = {"publishedWeb":true}
// Modified by: Bill James (2015-12-16T00:00:00: qqqWords TestThis)
// 
// 
//   // ----------------------------------------------------
//   // User name (OS): Bill James
//   // Date and time: 2015-05-28T00:00:00, 14:08:15
//   // ----------------------------------------------------
//   // Method: KeywordCombine
//   // Description
//   // Modified: 05/28/15
//   // Structure: CEv13_131005
//   // 
//   //
//   // Parameters
//   // ----------------------------------------------------
// 
// 
// 
// C_POINTER($1;$ptSub)
// C_TEXT($0;$gotoPages;$6)
// C_TEXT($2;$3;$tweenValues;$tweenKeys)
// C_Longint($kSub;$iSub;$cntPara;$cntClip;$doThis;$4;$5)
// 
// $cntPara:=Count parameters
// $ptSub:=(->[Item]KeySub)
// $tweenValues:="="
// $tweenKeys:="; "
// $cntClip:=4
// $doThis:=0
// If ($cntPara>0)
// $ptSub:=$1
// If ($cntPara>1)
// $tweenValues:=$2
// If ($cntPara>2)
// $tweenKeys:=$3
// If ($cntPara>3)
// $cntClip:=$4
// If ($cntPara>4)
// $doThis:=$5
// If ($cntPara>5)
// $gotoPages:=$6
// End if 
// End if 
// End if 
// End if 
// End if 
// End if 
// $kSub:=Records in sub_selection($ptSub->)
// Case of 
// : ($doThis=0)
// $0:=""
// ALL SUBRECORDS([Item]KeySub)
// FIRST SUBRECORD([Item]KeySub)
// For ($iSub;1;$kSub)
// If (#"jjInternal")
// $0:=$0+($tweenKeys*Num($0#""))+Substring(;1;$cntClip)+($tweenValues*Num(#""))+
// End if 
// NEXT SUBRECORD([Item]KeySub)
// End for 
// : ($doThis=1)
// $0:="<Table class="+Txt_Quoted ("TableKeyWords")+" border=1>"+"\r"+"<TR><TD class="+Txt_Quoted ("TtKeyWords")+">Reference</td><TD class="+Txt_Quoted ("TtKeyWords")+">Value</td><TD class="+Txt_Quoted ("TtKeyWords")+">Similar</td></tr>"+"\r"
// ALL SUBRECORDS([Item]KeySub)
// FIRST SUBRECORD([Item]KeySub)
// For ($iSub;1;$kSub)
// If (#"jjInternal")
// $0:=$0+"\r"+"<TR><TD class="+Txt_Quoted ("TdKeyWords")+">"++"</TD>"
// $0:=$0+"\r"+"<TD class="+Txt_Quoted ("TdKeyWords")+">"++"</TD>"
// $0:=$0+"\r"+"<TD class="+Txt_Quoted ("TdKeyWords")+">"
// $0:=$0+"<a href="+Txt_Quoted ("/item_List?ItemType="+[Item]typeID+"&keywords="++$gotoPages)+">Similar</a></TD></TR>"
// End if 
// NEXT SUBRECORD([Item]KeySub)
// End for 
// $0:=$0+"</table>"
// End case 