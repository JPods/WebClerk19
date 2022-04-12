//%attributes = {}
//// ----------------------------------------------------
//// User name (OS): williamjames
//// Date and time: 08/13/09, 15:41:30
//// ----------------------------------------------------
//// Method: SMTP_QuotedPrintable
//// Description
//// 
////
//// Parameters
//// ----------------------------------------------------
//
//C_TEXT($1;$2;$0)
//If (Count parameters=2)
//	$character_set_t:=$2
//	C_BLOB($quoted_printable_x)
//	//convert the unicode text to a blob of the target encoding 
//	
//	//was the following line a continuation of the line above?
//	
//	//$quoted_printable_x:=encode text ($1;$2)
//	C_TEXT($quoted_printable_t)
//	//repeat with every byte
//	For ($i;0;BLOB size($quoted_printable_x)-1)
//		Case of 
//			: ($quoted_printable_x{$i}=0x0020)
//				//the space character
//				$quoted_printable_t:=$quoted_printable_t+"=20"
//			: ($quoted_printable_x{$i}=0x003D)
//				//the equals sign
//				$quoted_printable_t:=$quoted_printable_t+"=3D"
//			: ($quoted_printable_x{$i}<0x007F)
//				//all other US-ASCII characters
//				$quoted_printable_t:=$quoted_printable_t+Char($quoted_printable_x{$i})
//			Else 
//				//extended characters
//				$quoted_printable_t:=$quoted_printable_t+"="+longint to hex($quoted_printable_x{$i})
//		End case 
//	End for 
//	$0:=$quoted_printable_t
//End if 
//
//