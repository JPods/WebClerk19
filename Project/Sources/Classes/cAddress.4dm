Class constructor($entity : Object)
	If ($entity#Null:C1517)
		This:C1470.address1:=""
		This:C1470.address2:=""
		This:C1470.city:=""
		This:C1470.state:=""
		This:C1470.zip:=""
		This:C1470.country:=""
		This:C1470.country2:=""
		This:C1470.country3:=""
		This:C1470.carrier:=Null:C1517
	Else 
		This:C1470.address1:=$entity.address1
		This:C1470.address2:=$entity.address2
		This:C1470.city:=$entity.city
		This:C1470.state:=$entity.state
		This:C1470.zip:=$entity.zip
		This:C1470.country:=$entity.country
		// add lookup for country code
		This:C1470.country2:=""  //$entity.country2
		This:C1470.country3:=$entity.country3
		This:C1470.carrier:=""  //""
	End if 
	
Function get addressOnly->$addressOnly : Text
	Case of 
		: ((This:C1470.country="USA") | (This:C1470.country="US") | (This:C1470.country=""))
			$addressOnly:=((This:C1470.address1+Char:C90(Carriage return:K15:38))*(Num:C11(This:C1470.address1#"")))\
				+((This:C1470.address2+Char:C90(Carriage return:K15:38))*(Num:C11(This:C1470.address2#"")))\
				+This:C1470.city+", "+This:C1470.state+"  "+This:C1470.zip\
				+((Char:C90(Carriage return:K15:38)+This:C1470.country)*(Num:C11(This:C1470.country#"")))
			
		: ((This:C1470.Country="France") | (This:C1470.Country="FR"))
			$addressOnly:=((This:C1470.address1+Char:C90(Carriage return:K15:38))*(Num:C11(This:C1470.address1#"")))\
				+((This:C1470.address2+Char:C90(Carriage return:K15:38))*(Num:C11(This:C1470.address2#"")))\
				+Char:C90(Carriage return:K15:38)+This:C1470.Zip_Code+"   "+This:C1470.City\
				+Char:C90(Carriage return:K15:38)+This:C1470.Country
			
		Else 
			$addressOnly:=((This:C1470.address1+Char:C90(Carriage return:K15:38))*(Num:C11(This:C1470.address1#"")))\
				+((This:C1470.address2+Char:C90(Carriage return:K15:38))*(Num:C11(This:C1470.address2#"")))\
				+This:C1470.city+", "+This:C1470.state+"  "+This:C1470.zip\
				+((Char:C90(Carriage return:K15:38)+This:C1470.country)*(Num:C11(This:C1470.country#"")))
	End case 
	
	
Function get addressFull($who : Text)->$addressFull : Text
	If ($who="person")
		$addressFull:=This:C1470.nameFirst+" "+This:C1470.nameLast+Char:C90(Carriage return:K15:38)+This:C1470.addressOnly
	Else 
		// :((count parameters=0)|($who="company"))
		
		$addressFull:=This:C1470.company+Char:C90(Carriage return:K15:38)+This:C1470.addressOnly
		
	End if 
	
	
	