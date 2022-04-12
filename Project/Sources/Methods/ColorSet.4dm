//%attributes = {}
C_TEXT:C284($1)
C_LONGINT:C283($0)

Case of 
		
	: ($1="background")
		
		$angle:=((Selected record number:C246([Customer:2])/Records in selection:C76([Customer:2])))*2*Pi:K30:1
		
		$red:=0x00E0+Round:C94(0x001F*Cos:C18($angle); 0)
		$angle:=$angle+(2*Pi:K30:1/3)
		
		$green:=0x00E0+Round:C94(0x001F*Cos:C18($angle); 0)
		$angle:=$angle+(2*Pi:K30:1/3)
		
		$blue:=0x00E0+Round:C94(0x001F*Cos:C18($angle); 0)
		
		$0:=($red << 16)+($green << 8)+$blue
		
		
	: ($1="fontcolor")
		
		$angle:=((Selected record number:C246([Customer:2])/Records in selection:C76([Customer:2])))*2*Pi:K30:1
		
		$red:=0x0040+Round:C94(0x0040*Cos:C18($angle); 0)
		$angle:=$angle+(2*Pi:K30:1/3)
		
		$green:=0x0040+Round:C94(0x0040*Cos:C18($angle); 0)
		$angle:=$angle+(2*Pi:K30:1/3)
		
		$blue:=0x0040+Round:C94(0x0040*Cos:C18($angle); 0)
		
		$0:=($red << 16)+($green << 8)+$blue
		
	: ($1="fontstyle")
		
		$n:=Selected record number:C246([Customer:2])
		
		$0:=Choose:C955(($n-1)%4; Plain:K14:1; Italic:K14:3; Bold:K14:2; Underline:K14:4)
		
End case 