//%attributes = {}
//// TRY
//ARRAY TEXT($a; 1)
//$a{1}:=“test1”
//$a{2}:=“test2”  //Jump to the next Catch
//$a{3}:=“test3”
//$a{4}:=“test4”
//CATCH(“errormethod”)

////currently how you would need to do now
//ARRAY TEXT($a; 1)
//ON ERR CALL(“errormethod”)
//If (error=0)
//$a{1}:=“test1”
//End if 
//If (error=0)
//$a{2}:=“test2”  //Jumps 2 ERRORMETHOD picked above
//End if   //RETURNS TO NEXT LINE IN CODE
//If (error=0)
//$a{3}:=“test3”
//End if 
//If (error=0)
//$a{4}:=“test4”
//End if 
//ON ERR CALL ("")