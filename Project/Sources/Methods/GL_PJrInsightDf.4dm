//%attributes = {"publishedWeb":true}
//Procedure: GL_PJrInsightDf
//Noah Dykoski  February 6, 1999 / 3:25 PM
C_BOOLEAN:C305($0)  //use the custom post to insight (true) or the default (false)


var $entDefault : Object
$entDefault:=ds:C1482.Default.query("primeDefault = 1").first()
If (($entDefault.prJrnlToInsight#1) & ($entDefault.prJrnlToInsight#2))
	$entDefault.prJrnlToInsight:=1
End if 
$0:=($entDefault.prJrnlToInsight=2)
