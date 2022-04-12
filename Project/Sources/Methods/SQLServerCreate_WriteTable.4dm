//%attributes = {"publishedWeb":true}
If (False:C215)
	//Date: 04/25/02
	//Who: Dan Bentson, Arkware
	//Description: Writes create table commands for SQLServer create scrips
End if 

C_LONGINT:C283($1; $tableNum; $j)
$tableNum:=$1

C_TEXT:C284($curTableName)
$curTableName:=Table name:C256($tableNum)  //fill in file name array

C_TEXT:C284(oPriKey)
oPriKey:=""



ARRAY TEXT:C222(oaSubtables; 0)
ARRAY TEXT:C222(oaIndexFields; 0)
ARRAY TEXT:C222(oaUniqueFields; 0)
// aFields, aFieldLen, aTypes are paralell
ARRAY TEXT:C222(oaFieldList; 0)
ARRAY LONGINT:C221(oaFieldLen; 0)
ARRAY LONGINT:C221(oaFieldTypes; 0)

For ($j; 1; Get last field number:C255($tableNum))  //Loop for fields
	SQLServerCreate_FieldRays($tableNum; $j)
End for 

// create primary key if no primary key was found
If (oPriKey="")
	oPriKey:=$curTableName+"ID"
End if 
// create a primary key for this table  
INSERT IN ARRAY:C227(oaFieldTypes; 1)
oaFieldTypes{1}:=-99
INSERT IN ARRAY:C227(oaFieldList; 1)
oaFieldList{1}:=oPriKey
INSERT IN ARRAY:C227(oaFieldLen; 1)
oaFieldLen{1}:=0

SEND PACKET:C103(myDoc; "CREATE TABLE "+msSQLLeft+$curTableName+msSQLRight+"(")
For ($curF; 1; Size of array:C274(oaFieldList))
	If (oaFieldTypes{$curF}=Is subtable:K8:11)
		SEND PACKET:C103(myDoc; "/*** SUBTABLE:"+oaFieldList{$curF}+"***/")
	Else 
		If (oaFieldTypes{$curF}=Is time:K8:8)
			SEND PACKET:C103(myDoc; "/*** TIME:"+oaFieldList{$curF}+"***/")
		Else   // not time or subtable - normal case
			If ($curF>1)
				SEND PACKET:C103(myDoc; ",")
			End if 
			SQLServerCreate_WriteField(oaFieldTypes{$curF}; oaFieldList{$curF}; oaFieldLen{$curF})
			If ($curF=1)
				SEND PACKET:C103(myDoc; theSQLIncrement)  //first col is id
			End if 
		End if 
	End if 
End for 
//primary key
SEND PACKET:C103(myDoc; ",PRIMARY KEY("+msSQLLeft+oPriKey+msSQLRight+"))"+endLineCmd+ovCR)

C_LONGINT:C283($indx; $uniq; $subt; $fia)

//indexes
C_LONGINT:C283($indx; $uniq; $subt)
For ($indx; 1; Size of array:C274(oaIndexFields))
	SEND PACKET:C103(myDoc; "CREATE INDEX "+msSQLLeft+"indx_"+$curTableName+"_"+oaIndexFields{$indx}+msSQLRight+" ON "+msSQLLeft+$curTableName+msSQLRight+"("+msSQLLeft+oaIndexFields{$indx}+msSQLRight+")")
	SEND PACKET:C103(myDoc; endLineCmd+ovCR)
End for 

//unique constraints
For ($uniq; 1; Size of array:C274(oaUniqueFields))
	SEND PACKET:C103(myDoc; "ALTER TABLE "+msSQLLeft+$curTableName+msSQLRight+" ADD CONSTRAINT "+msSQLLeft+"unique_"+$curTableName+"_"+oaUniqueFields{$uniq}+msSQLRight+" UNIQUE ("+msSQLLeft+oaUniqueFields{$uniq}+msSQLRight+")")
	SEND PACKET:C103(myDoc; endLineCmd+ovCR)
End for 

// subtables
For ($subt; 1; Size of array:C274(oaSubtables))
	INSERT IN ARRAY:C227(oaForeignTable; 1)
	oaForeignTable{1}:=$curTableName+"_"+oaSubtables{$subt}
	INSERT IN ARRAY:C227(oaForeignField; 1)
	oaForeignField{1}:=oPriKey
	INSERT IN ARRAY:C227(oaForeignRef; 1)
	oaForeignRef{1}:=$curTableName
	SEND PACKET:C103(myDoc; "CREATE TABLE "+msSQLLeft+$curTableName+"_"+oaSubtables{$subt}+msSQLRight+"("+oaSubtables{$subt}+"ID bigint "+vNotNull+","+oPriKey+" bigint,PRIMARY KEY("+msSQLLeft+oaSubtables{$subt}+"ID"+msSQLRight+"))")
	SEND PACKET:C103(myDoc; endLineCmd+ovCR)
End for 

SEND PACKET:C103(myDoc; ovCR)