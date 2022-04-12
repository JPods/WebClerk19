//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/16/21, 21:15:51
// ----------------------------------------------------
// Method: LBX_seqMov
// Description
// 
// Parameters
// ----------------------------------------------------


//local Function seqMove($es : cs.EntitySelection; $en : cs.Entity; $Position : Integer; $seqName : Text)  // resequence the $en within $es to its new position $Position
var $1; $es; $2; $en : Object
var $3; $Position : Integer
var $0 : Integer

$es:=$1
$en:=$2
$Position:=$3

var $seqFieldName : Text
var $newPosition : Integer  // this will start out as $Position, but if $Position=-1, then it will become $es.length (to put it to the bottom)
$seqFieldName:="seq"
If (Count parameters:C259>3)  // if they supply a name for the sequence field, use it instead of the default 'Seq'
	$seqFieldName:=$seqName
End if 
$newPosition:=$Position  // assume we will move it here
// —— Handle 'special' positions BOTTOM (<0) and TOP (0)
Case of 
	: ($Position<0)  // to bottom of the list
		$newPosition:=$es.length
	: ($Position=0)  // to front
		$newPosition:=1
End case 
var $obj_Result : Object  // the result object of Entity .save( ) or .unlock( )
var $esAffected : Object  //cs.EntitySelection  // this will be the collection of entities that need to be shifted to accomodate the repositioning
var $entity : Object  //cs.Entity  // ...within the For each [ ] this is the entity being shifted
// —— NOTE: This CASE statement does nothing if the $en is not actually being shifted anywhere.
Case of 
	: ($en.seq<$newPosition)  // if $en is being moved DOWN the list
		$query:=$seqFieldName+" > :1 AND "+$seqFieldName+" <= :2"
		$esAffected:=$es.query($query; $en.seq; $newPosition)  // these are all the records that need to be shifted UP
		For each ($entity; $esAffected)
			$entity.seq:=$entity.seq-1
			$obj_Result:=$entity.save()
		End for each 
		$en.seq:=$newPosition
		$obj_Result:=$en.save()
	: ($en.seq>$newPosition)  // if $en is being moved UP the list
		$query:=$seqFieldName+" >= :1 AND "+$seqFieldName+" < :2"
		$esAffected:=$es.query($query; $newPosition; $en.seq)  // these are all the records that need to be shifted UP
		For each ($entity; $esAffected)
			$entity.seq:=$entity.seq+1
			$obj_Result:=$entity.save()
		End for each 
		$en.seq:=$newPosition
		$obj_Result:=$en.save()
End case 

$es:=$es.orderBy("seq")
$0:=$newPosition