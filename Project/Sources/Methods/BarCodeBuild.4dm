//%attributes = {}
//BarCodeBuild
//James W. Medlen
//06/24/2008
// added Code128 C all numbers

//BarcodeInitArray 

//C_PICTURE(vgBarcode;$0)
C_PICTURE:C286(vgBarcode)
C_LONGINT:C283(viChar; viSum; viCheckSum; viPos)
C_REAL:C285(vrVScale; vrHScale; $2)
C_TEXT:C284(vtString; vtType; $1; $3)

vi3:=Count parameters:C259

Case of 
	: (vi3=3)
		vtString:=$1
		vrVScale:=$2
		vrHScale:=1
		vtType:=$3
		//vrHScale:=$3 //Horizontal Scale did not work may need to be scaled when building array
		vrHScale:=1
	: (vi3=2)
		vtString:=$1
		vrVScale:=$2
		vrHScale:=1
		vtType:="C"
	: (vi3=1)
		vtString:=$1
		vrVScale:=1
		vrHScale:=1
		vtType:="C"
End case 

If (vtType="A")
	// need to determin offset if any
End if 

If (vtType="GSC")  // GSC-128 has an Application Code That requires FNC1 as a prefix
	
	If (Match regex:C1019("^\\d+$"; vtString; 1))  // all numeric "TypeC"
		viMod:=Length:C16(vtString)%2
		
		If (viMod=1)  // if odd number of digits
			vtString:="0"+vtString  // pad with a zero to get even number of digits
		End if 
		
		vgBarcode:=<>agBarcode{105}  //START Code128 C
		vgBarcode:=vgBarcode+<>agBarcode{102}  //FNC1
		vi4:=Length:C16(vtString)
		viSum:=105+102
		viPos:=1  // checksum starts at position 2 
		
		For (vi3; 1; vi4; 2)
			viPos:=viPos+1
			viChar:=Num:C11(vtString[[vi3]]+vtString[[vi3+1]])
			viSum:=viSum+(viChar*viPos)
			vgBarcode:=vgBarcode+<>agBarcode{viChar}
		End for 
		
	Else   // alphanumeric"TypeB"
		vgBarcode:=<>agBarcode{104}  //START Code128 B
		vi4:=Length:C16(vtString)
		viSum:=104
		For (vi3; 1; vi4)
			
			vtChar:=vtString[[vi3]]
			viChar:=Character code:C91(vtChar)
			viChar:=viChar-32
			viSum:=viSum+(viChar*vi3)
			vgBarcode:=vgBarcode+<>agBarcode{viChar}
			
		End for 
		
	End if 
	
End if 

If (vtType="C")
	// must be all numeric numbers only
	If (Match regex:C1019("^\\d+$"; vtString; 1))
		vtType:="C"
		viMod:=Length:C16(vtString)%2
		
		If (viMod=1)  // if odd number of digits
			vtString:="0"+vtString  // pad with a zero to get even number of digits
		End if 
		
		vgBarcode:=<>agBarcode{105}  //START Code128 C
		vi4:=Length:C16(vtString)
		viSum:=105
		viPos:=0
		For (vi3; 1; vi4; 2)
			
			viPos:=viPos+1
			viChar:=Num:C11(vtString[[vi3]]+vtString[[vi3+1]])
			viSum:=viSum+(viChar*viPos)
			vgBarcode:=vgBarcode+<>agBarcode{viChar}
			
		End for 
	Else 
		vtType:="B"  // alpha-numeric
	End if 
End if 

If (vtType="B")
	
	vgBarcode:=<>agBarcode{104}  //START Code128 B
	vi4:=Length:C16(vtString)
	viSum:=104
	For (vi3; 1; vi4)
		
		vtChar:=vtString[[vi3]]
		viChar:=Character code:C91(vtChar)
		viChar:=viChar-32
		viSum:=viSum+(viChar*vi3)
		vgBarcode:=vgBarcode+<>agBarcode{viChar}
		
	End for 
	
End if 

// finish barcode

viCheckSum:=Mod:C98(viSum; 103)
viChar:=viCheckSum
vgBarcode:=vgBarcode+<>agBarcode{viChar}
viChar:=106  //Stop
vgBarcode:=vgBarcode+<>agBarcode{viChar}
viChar:=107  //Padding
vgBarcode:=<>agBarcode{viChar}+vgBarcode+<>agBarcode{viChar}
//vertical scale
vgBarcode:=vgBarcode*|vrVScale
//horizontal scale
vgBarcode:=vgBarcode*+vrHScale

// ### jwm ### 20160524_1636 test this ###
// converting the picture in the report works test to se if this works here without converting it on the report.
CONVERT PICTURE:C1002(vgBarcode; ".PNG")  // conversion to png

$vPointer:=->vgBarcode  // pass a pointer

$0:=vgBarcode

//myDoc:=create document("Macintosh HD:Users:jmedlen:Desktop:Test.gif")
//If (OK=1)
//FileName:=Document
//CLOSE DOCUMENT(myDoc)
//End if 

//PICTURE TO GIF(vgBarcode;myBlob)
//BLOB TO DOCUMENT(Document;myBlob)
//SET DOCUMENT TYPE(Document;"GIFf")
//SET PICTURE TO CLIPBOARD(vgBarcode)