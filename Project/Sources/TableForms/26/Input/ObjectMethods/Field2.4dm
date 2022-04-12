

ARRAY TEXT:C222($atTaxes; 0)
APPEND TO ARRAY:C911($atTaxes; "<BTax Summary")
APPEND TO ARRAY:C911($atTaxes; "-")
APPEND TO ARRAY:C911($atTaxes; "Sales:\t\t"+String:C10([Invoice:26]salesTax:19; "$ ###,###,##0.00"))
APPEND TO ARRAY:C911($atTaxes; "Cost:\t\t"+String:C10([Invoice:26]taxOnCost:88; "$ ###,###,##0.00"))
APPEND TO ARRAY:C911($atTaxes; "Shipping:\t"+String:C10([Invoice:26]taxOnShipping:105; "$ ###,###,##0.00"))
APPEND TO ARRAY:C911($atTaxes; "-")
APPEND TO ARRAY:C911($atTaxes; "<BTotal:\t\t"+String:C10([Invoice:26]taxTotal:106; "$ ###,###,##0.00"))

// build Choice List
$vtPopup:=""
For ($viChoice; 1; Size of array:C274($atTaxes))
	If ($viChoice=1)
		$vtPopup:=$atTaxes{$viChoice}
	Else 
		$vtPopup:=$vtPopup+";"+$atTaxes{$viChoice}
	End if 
End for 

// Set default choice
$viDefault:=0  // Sharpsville
$viChoice:=Pop up menu:C542($vtPopup; $viDefault)

// check for valid choice
If ($viChoice>1)
	// for display only no action is taken
End if 
