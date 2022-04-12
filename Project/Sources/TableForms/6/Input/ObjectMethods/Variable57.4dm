//Case of 
//: (aContact>0)
//QUERY([Contact];[Contact]UniqueID=aContactUnique{aContact})  // Replaced GOTO Record in Selection
//[Service]RefName:=[Contact]FirstName+" "+[Contact]LastName//Parse
//_ContctRay (aContact{aContact})
//: ((Size of array(aContact)>0)&(aContact=0))
//aContact:=1
//End case 