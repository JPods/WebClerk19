//%attributes = {"publishedWeb":true}
C_BOOLEAN:C305($unLocked)
C_POINTER:C301($1; $2; $3)
$unLocked:=Not:C34($1->)
OBJECT SET ENTERABLE:C238($2->; $unLocked)
OBJECT SET ENTERABLE:C238($3->; $unLocked)