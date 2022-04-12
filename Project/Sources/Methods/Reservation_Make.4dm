//%attributes = {"publishedWeb":true}
//Method: Reservation_Make
//  C_REAL($1; $0)
//  C_BOOLEAN($2)  //order finalized
//  //
//  C_REAL($qtyAllocated; $qtyOrigThisRes; $qtyMaxAllowed; $qtyRun; $changeAllowcate)
//  C_LONGINT($i; $k; $DTCurr)
//  C_BOOLEAN($doFinal)
//  $doFinal:=$2
//  //5 min, 60*5 = 300
//  READ WRITE([Reservation])
//  If ($1>0)
//  $qtyRun:=$1
//  Else 
//  $qtyRun:=0
//  End if 
//  //
//  C_TEXT(vReservationStatus)
//  vReservationStatus:=""
//  ARRAY LONGINT($aRecNum; 0)
//  ARRAY LONGINT($aDTOriginated; 0)
//  ARRAY LONGINT($aDTLastAction; 0)
//  ARRAY LONGINT($aSalesOrd; 0)
//  ARRAY REAL($aQty; 0)
//  //array TEXT($aeventID;0)
//  ARRAY LONGINT($aeventID; 0)
//  QUERY([Reservation]; [Reservation]active=True; *)
//  QUERY([Reservation];  | [Reservation]eventLogid="Pending"; *)
//  QUERY([Reservation];  & [Reservation]itemNum=[Item]itemNum)
//  $k:=Records in selection([Reservation])
//  If ($k>0)
//  SELECTION TO ARRAY([Reservation]; $aRecNum; [Reservation]orderNum; $aSalesOrd; [Reservation]dtActionLast; $aDTLastAction; [Reservation]eventLogid; $aeventID; [Reservation]dtOriginated; $aDTOriginated; [Reservation]qtyReserved; $aQty)
//  UNLOAD RECORD([Reservation])
//  End if 
//  //
//  ARRAY LONGINT($aDoAction; 0)
//  ARRAY LONGINT($aDoRecNum; 0)
//  ARRAY REAL($aDoQty; 0)
//  $DTCurr:=DateTime_Enter
//  $qtyMaxAllowed:=[Item]qtyOnHand-[Item]qtyOnSalesOrder
//  //TRACE
//  If ($qtyMaxAllowed<=0)
//  $qtyRun:=0
//  If ($k>0)
//  For ($i; 1; $k)
//  $aDTLastAction{$i}:=-$DTCurr
//  End for 
//  ARRAY TO SELECTION($aDTLastAction; [Reservation]dtActionLast)
//  End if 
//  Else 
//  C_REAL($qtyReturn2Item; $qtyOffReserve)
//  C_REAL($qtyOnReservation)
//  C_LONGINT($DTNoAction; $DTEndCart; $DTCurr)
//  $DTNoAction:=$DTCurr-(<>vlCartTime*60)
//  $DTEndCart:=$DTCurr-(<>vlCartTime*60)
//  $i:=0
//  $qtyOnReservation:=0
//  $qtyOffReserve:=0
//  $qtyOnOrd:=0
//  $doNew:=True
//  While ($i<$k)
//  $i:=$i+1
//  INSERT IN ARRAY($aDoAction; 1; 1)
//  INSERT IN ARRAY($aDoRecNum; 1; 1)
//  INSERT IN ARRAY($aDoQty; 1; 1)
//  Case of 
//  : ($aSalesOrd{$i}>0)
//  $aDoAction{1}:=0
//  $qtyOnOrd:=$qtyOnOrd+$aQty{$i}
//  : ($aeventID{$i}=-3)  //"Pending")
//  $aDoAction{1}:=0
//  If (Locked([Item]))
//  $qtyOffReserve:=$qtyOffReserve+$aQty{$i}
//  Else 
//  [Reservation]eventLogid:=-1  //"ClearThis"//set to clear item on next round    
//  
//  //[Item]QtyAllocated:=[Item]QtyAllocated-$aQty{$i}
//  SAVE RECORD([Item])
//  SAVE RECORD([Reservation])
//  End if 
//  : (($DTEndCart>$aDTOriginated{$i}) | ($DTNoAction>$aDTLastAction{$i}))  //past
//  $aDoAction{1}:=-4
//  $aDoRecNum{1}:=$aRecNum{$i}
//  GOTO RECORD([Reservation]; $aDoRecNum{$i})
//  Repeat 
//  LOAD RECORD([Reservation])
//  [Reservation]active:=False
//  [Reservation]privateNote:="Expired"
//  Until (Not(Locked([Reservation])))
//  If (Locked([Item]))
//  [Reservation]eventLogid:=-3  //"Pending"//set to clear item on next round  
//  $qtyOffReserve:=$qtyOffReserve+$aQty{$i}
//  Else 
//  [Reservation]eventLogid:=-1  //"ClearThis"//set to clear item on next round    
//  //[Item]QtyAllocated:=[Item]QtyAllocated-$aQty{$i}
//  SAVE RECORD([Item])
//  End if 
//  SAVE RECORD([Reservation])
//  : ($aeventID{$i}#vleventID)
//  $aDoAction{1}:=-5
//  $aDoRecNum{1}:=$aRecNum{$i}
//  $aDoQty{1}:=$aQty{$i}
//  $qtyOnReservation:=$qtyOnReservation+$aQty{$i}
//  Else   //it is this customer with active reservations
//  $aDoAction{1}:=-1
//  $aDoRecNum{1}:=$aRecNum{$i}
//  $doNew:=False
//  $qtyOrigThisRes:=$aQty{$i}
//  End case 
//  End while 
//  $k:=Size of array($aDoAction)
//  $qtyMaxAllowed:=[Item]qtyOnHand-([Item]qtyAllocated*Num([Item]qtyAllocated>0))-$qtyOnOrd+$qtyOffReserve-$qtyOnReservation
//  //If ($qtyMaxAllowed>([Item]QtyOnHand-$qtyOnOrd))
//  //$qtyMaxAllowed:=[Item]QtyOnHand-$qtyOnOrd
//  //End if 
//  If ($qtyMaxAllowed<($qtyRun-$qtyOrigThisRes))
//  $qtyRun:=$qtyMaxAllowed
//  End if 
//  If (($doNew) & ($qtyRun>0))  //no action, on order
//  CREATE RECORD([Reservation])
//  
//  [Reservation]itemNum:=[Item]itemNum
//  [Reservation]dtActionLast:=$DTCurr
//  [Reservation]eventLogid:=vleventID
//  [Reservation]qtyReserved:=$qtyRun
//  [Reservation]dtOriginated:=$DTCurr
//  [Reservation]active:=True
//  If ([RemoteUser]name="")
//  [Reservation]nameNick:="Not Signed In"
//  Else 
//  [Reservation]nameNick:=[RemoteUser]name
//  End if 
//  [Reservation]description:=[Item]description
//  [Reservation]publish:=<>vlPublishReservations
//  [Reservation]customerID:=[RemoteUser]customerID
//  [Reservation]tableNum:=[RemoteUser]tableNum
//  [Reservation]dtReservation:=[Item]dtItemDate
//  [Reservation]publicNote:=pvLnComment
//  //If (Not(Locked([Item])))
//  //[Item]QtyAllocated:=[Item]QtyAllocated+$qtyRun
//  //End if 
//  SAVE RECORD([Reservation])
//  End if 
//  $i:=0
//  While ($i<$k)
//  $i:=$i+1
//  Case of 
//  : ($aDoAction{$i}=-4)
//  If ($aeventID{$i}=vleventID)
//  $qtyRun:=0
//  End if 
//  : ($aDoAction{$i}=-5)
//  //no action, another person
//  : ($aDoAction{$i}=-1)
//  GOTO RECORD([Reservation]; $aDoRecNum{$i})
//  LOAD RECORD([Reservation])
//  Repeat 
//  If ($doFinal)
//  
//  [Reservation]orderNum:=[Order]orderNum
//  [Reservation]remoteUserID:=[RemoteUser]idNum
//  [Reservation]nameNick:=[RemoteUser]name
//  [Reservation]publish:=<>vlPublishReservations
//  [Reservation]customerID:=[RemoteUser]customerID
//  [Reservation]tableNum:=[RemoteUser]tableNum
//  If (pvLnComment#"")
//  [Reservation]publicNote:=pvLnComment
//  End if 
//  End if 
//  If ([Reservation]nameNick="Not Signed In")
//  Case of 
//  : ([RemoteUser]name#"")
//  [Reservation]nameNick:=[RemoteUser]name
//  : ([RemoteUser]company#"")
//  [Reservation]nameNick:=[RemoteUser]company
//  : ([Customer]company#"")
//  [Reservation]nameNick:=[Customer]company
//  End case 
//  End if 
//  [Reservation]dtActionLast:=$DTCurr
//  [Reservation]qtyReserved:=$qtyRun
//  If (<>vlChangeReservations<=[RemoteUser]securityLevel)
//  [Reservation]allowChanges:=1
//  Else 
//  [Reservation]allowChanges:=0
//  End if 
//  Until (Not(Locked([Reservation])))
//  SAVE RECORD([Reservation])
//  End case 
//  End while 
//  //If (($qtyOnReservation+$qtyRun)#[Item]QtyAllocated)   //Do this in Tally Inven
//  //LOAD RECORD([Item])
//  //Repeat 
//  //[Item]Reservation:=True
//  //[Item]QtyAllocated:=$qtyOnReservation+$qtyRun
//  //Until (Not(Locked([Item])))
//  //SAVE RECORD([Item])
//  //End if 
//  End if 
//  $0:=$qtyRun
//  READ ONLY([Reservation])
//  UNLOAD RECORD([Reservation])
//  