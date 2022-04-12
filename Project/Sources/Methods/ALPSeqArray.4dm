//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-07-25T00:00:00, 10:51:27
// ----------------------------------------------------
// Method: ALPSeqArray
// Description
// Modified: 07/25/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


If (vsrcRow#vdestRow)
	$seqSize:=Size of array:C274(aOSeq)
	
	Case of 
		: (vdestRow=$seqSize)
			aOSeq{vsrcRow}:=$seqSize+1
		: (vdestRow=1)
			aOSeq{vsrcRow}:=0
		Else 
			For ($seqInc; 1; $seqSize)
				If (aOSeq{$seqInc}=vdestRow)
					aOSeq{$seqInc}:=aOSeq{$seqInc}-1
				Else 
					aOSeq{$seqInc}:=aOSeq{$seqInc}+1
				End if 
			End for 
	End case 
	
End if 




//  Alfred Griffin, Green Bank, RFP