//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: SQLServerCreate_Start  
	//Date: 04/25/02
	//Who: Dan Bentson, Arkware
	//Description: Writes SQLServer create scripts
	// This method is not called from anywhere
End if 

// **************************************
// * IN ORDER TO RUN PROPERLY THIS MUST BE RUN IN 6.7.2
// * 6.0.6 Does not detect Unique fields

C_TEXT:C284(msSQLLeft; msSQLRight; endLineCmd)
C_TEXT:C284(theSQLIncrement)
CONFIRM:C162("Sending to MS SQL")
If (OK=1)
	msSQLLeft:="["
	msSQLRight:="]"
	theSQLIncrement:=" IDENTITY(1,1) NOT FOR REPLICATION"
	endLineCmd:=""
	vNotNull:=""
Else 
	msSQLLeft:=""
	msSQLRight:=""
	theSQLIncrement:=" AUTO_INCREMENT NOT NULL"
	endLineCmd:=";"
	vNotNull:="Not Null"
End if 

C_LONGINT:C283($i; $j)
ovCR:=Char:C90(13)

myDoc:=Create document:C266("")

// aForeignField, aForeignRef, aForeignTable are paralell
ARRAY TEXT:C222(oaForeignField; 0)
ARRAY TEXT:C222(oaForeignTable; 0)
ARRAY TEXT:C222(oaForeignRef; 0)

SQLServerCreate_BuildKeyRays
$myCount:=Get last table number:C254
C_LONGINT:C283($myCount)
//qqq:=1
For ($i; 1; $myCount)  //Loop for files
	SQLServerCreate_WriteTable($i)
End for 

//foreign keys
C_LONGINT:C283($forkey)
For ($forkey; 1; Size of array:C274(oaForeignField))
	SEND PACKET:C103(myDoc; "ALTER TABLE "+msSQLLeft+oaForeignTable{$forkey}+msSQLRight+" ADD CONSTRAINT "+msSQLLeft+"fk_"+oaForeignTable{$forkey}+"_"+oaForeignField{$forkey}+msSQLRight+" FOREIGN KEY("+msSQLLeft+oaForeignField{$forkey}+msSQLRight+") REFERENCES "+msSQLLeft+oaForeignRef{$forkey}+msSQLRight+"("+msSQLLeft+oaForeignField{$forkey}+msSQLRight+")")
	SEND PACKET:C103(myDoc; endLineCmd+ovCR)
End for 


CLOSE DOCUMENT:C267(myDoc)
ALERT:C41("Finished")