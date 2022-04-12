//%attributes = {}


C_COLLECTION:C1488($collection)
C_LONGINT:C283($error)
C_TEXT:C284($element)  // elements can be of various Types, not sure how to declare

For each ($element; $collection)
	// do stuff with each $element of the $collection
End for each 


For each ($element; $collection) While ($error=0)
	// do stuff with each $element of the $collection
	// loop will stop if $error is set to something other than 0
End for each 

