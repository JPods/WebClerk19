//%attributes = {"publishedWeb":true}
//
////Procedure: ST_ReplaceText
////Funziona come replace string, ma agisce con esattezza ASCII
////1) T Testo da trattare
////2) T Vecchio testo
////3) T Nuovo testo
////4) L Numero delle sostituzioni
//
//C_TEXT($0;$Risu)
//C_TEXT($1;$Testo)
//C_TEXT($2;$Vecchio)
//C_TEXT($3;$Nuovo)
//C_LONGINT($4;$Ripe)
//C_LONGINT($Posi;$Count)
//
//$Testo:=$1
//$Vecchio:=$2
//If (Count parameters>2)
//$Nuovo:=$3
//Else 
//$Nuovo:=""
//End if 
//If (Count parameters>3)
//$Ripe:=$4
//Else 
//$Ripe:=<>vEoF//Basta che sia pi di 32.000
//End if 
//
//$Risu:=""
//If ($Testo#"")
//If ($Ripe>0)
//$Posi:=ST_Position2($Vecchio;$Testo)
//If ($Posi=0)//Non vi sono corrispondenze
//$Risu:=$Testo//Ritorno il testo cos com
//Else //E stata trovata una corrispondenza
//$Count:=0
//While ($Posi>0)
//$Count:=$Count+1
//$Risu:=$Risu+Substring($Testo;1;$Posi-1)//Copio il testo
// precedente
//$Testo:=Substring($Testo;$Posi)//Considero solo la parte
// successiva di
//testo
//$Testo:=Replace string($Testo;$Vecchio;"";1)//Elimino la parte di
//testo vecchio
//$Risu:=$Risu+$Nuovo//Aggiungo il testo nuovo
//If ($Count>=$Ripe)
//$Posi:=0
//Else 
//$Posi:=ST_Position2($Vecchio;$Testo)
//End if 
//End while 
//$Risu:=$Risu+$Testo//Aggiungo la parte rimanente di testo
//End if 
//Else 
//$Risu:=$Testo//Ritorno il testo cos com
//End if 
//End if 
//
//$0:=$Risu
//