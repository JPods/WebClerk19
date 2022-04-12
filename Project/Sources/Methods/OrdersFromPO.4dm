//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/01/13, 11:57:17
// ----------------------------------------------------
// Method: OrdersFromPO
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($i; $k)
ARRAY LONGINT:C221($aOrderNum; 0)
If (vHere=2)
	CREATE EMPTY SET:C140([Order:3]; "Current")
	$k:=Size of array:C274(aPOOrdRef)
	READ ONLY:C145([Order:3])
	For ($i; 1; $k)
		If (Find in array:C230($aOrderNum; aPOOrdRef{$i})<0)
			APPEND TO ARRAY:C911($aOrderNum; aPOOrdRef{$i})
			QUERY:C277([Order:3]; [Order:3]orderNum:2=aPOOrdRef{$i})
			ADD TO SET:C119([Order:3]; "Current")
			UNLOAD RECORD:C212([Order:3])
		End if 
	End for 
	USE SET:C118("Current")
	CLEAR SET:C117("Current")
	DB_ShowCurrentSelection(->[Order:3])
	
End if 


If (False:C215)
	C_LONGINT:C283(vi1; vi2)
	ARRAY LONGINT:C221(aLongInt1; 0)
	If (vHere=2)
		CREATE EMPTY SET:C140([Order:3]; "Current")
		vi2:=Size of array:C274(aPOOrdRef)
		READ ONLY:C145([Order:3])
		For (vi1; 1; vi2)
			If (Find in array:C230(aLongInt1; aPOOrdRef{vi1})<0)
				APPEND TO ARRAY:C911(aLongInt1; aPOOrdRef{vi1})
				QUERY:C277([Order:3]; [Order:3]orderNum:2=aPOOrdRef{vi1})
				ADD TO SET:C119([Order:3]; "Current")
				UNLOAD RECORD:C212([Order:3])
			End if 
		End for 
		USE SET:C118("Current")
		CLEAR SET:C117("Current")
		DB_ShowCurrentSelection(->[Order:3])
		ARRAY LONGINT:C221(aLongInt1; 0)
	End if 
End if 
