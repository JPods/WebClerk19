//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-26T06:00:00Z)
// Method: Ledger_RayInit
// Description
// Parameters
// ----------------------------------------------------

var $ent : Object

var $1; $actionCount : Integer
var $i; $k : Integer
$actionCount:=$1
Case of 
	: ($actionCount>-1)  // zero or more
		ARRAY TEXT:C222(aLdgAcct; $1)  //$ent.AcctKey
		ARRAY TEXT:C222(aLdgidForeign; $1)  //$ent.AcctKey
		ARRAY TEXT:C222(aLdgJrnl; $1)  //$ent.SourceKey
		ARRAY TEXT:C222(aLdgTerms; $1)  //$ent.Terms
		ARRAY LONGINT:C221(aLdgUnique; $1)  //$ent.DTCreated
		ARRAY LONGINT:C221(aLdgDocType; $1)  //$ent.CreatingDocType
		ARRAY LONGINT:C221(aLdgDocId; $1)  //$ent.DocRefID
		ARRAY DATE:C224(aLdgDocDt; $1)  //$ent.DateDocument
		ARRAY DATE:C224(aLdgDue; $1)  //$ent.DateDue
		ARRAY DATE:C224(aLdgExpire; $1)  //$ent.ExpireDate
		ARRAY REAL:C219(aLdgValue; $1)  // $ent.Debit
		ARRAY REAL:C219(aLdgCredit; $1)  //$ent.Credit
		ARRAY REAL:C219(aLdgDscPot; $1)
		ARRAY REAL:C219(aLdgOrig; $1)  //
		ARRAY TEXT:C222(aLdgComnt; $1)
		ARRAY LONGINT:C221(aLdgRecs; $1)
		ARRAY TEXT:C222(aLdgTableName; $1)
		
	: ($actionCount=-3)
		$k:=Size of array:C274(aLdgAcct)
		For ($i; 1; $k)
			
			
			$ent:=ds:C1482.Ledger.new()
			$ent.idForeign:=aLdgidForeign{$i}
			$ent.tableName:=aLdgTableName{$i}
			$ent.customerID:=aLdgAcct{$i}
			$ent.tableNum:=aLdgDocType{$i}
			$ent.docRefid:=aLdgDocId{$i}
			$ent.dateDue:=aLdgDue{$i}
			$ent.dateDocument:=aLdgDocDt{$i}
			$ent.unAppliedValue:=aLdgValue{$i}
			$ent.sourceKey:=aLdgJrnl{$i}
			$ent.expireDate:=aLdgExpire{$i}
			$ent.terms:=aLdgTerms{$i}
			$ent.origValue:=aLdgOrig{$i}
			$ent.discntPotential:=aLdgDscPot{$i}
			$ent.save()
			var $process : Integer
		End for 
		Ledger_RayInit(0)
End case 
