//%attributes = {"publishedWeb":true}

//  HARVESTQQQ
////Procedure: Http_PORecvd
//C_LONGINT($error)
//ARRAY TEXT(aText1; 0)
//$error:=1
//If ((vHere>1) & (ptCurTable=(->[PO])) & (Size of array(aPOLineNum)=0))
//C_LONGINT($rslt; $doc)
//C_TEXT($locItems; $myDocName)
//If ($myDocName="")
//$myDocName:=Get_FileName("Select the PO to update."; "")
//End if 
//If ($myDocName#"")
//$error:=0

//C_LONGINT($error; $grp1; $grpCnt1; $grp2; $grpCnt2; $grp3; $grpCnt3)
//C_LONGINT($1)
//$grp1:=1  //starting array
//$grpCnt1:=11  //count of arrays
//$grp2:=$grp1+$grpCnt1  //9
//$grpCnt2:=12
//$grp3:=$grp2+$grpCnt2  //21
//$grpCnt3:=9
////
//AL_RemoveArrays(ePoList; $grp3; $grpCnt3)
//AL_RemoveArrays(ePoList; $grp2; $grpCnt2)
//AL_RemoveArrays(ePoList; $grp1; $grpCnt1)
////

//If (False)  //rewrite into web service
//TCStrong_prf_v142_RWVar
//WebService_Version0001

////$doc:=OpenVarFile ($myDocName)
////ReadVarArray($doc;aText1)
////ReadVarArray ($doc;aPOQtyOrder)
////ReadVarArray ($doc;aPOQtyRcvd)
////ReadVarArray ($doc;aPOQtyNow)
////ReadVarArray ($doc;aPOLnCmplt)
////ReadVarArray ($doc;aPoQtyBL)
////ReadVarArray ($doc;aPODescpt)
////ReadVarArray ($doc;aPOUnitCost)
////ReadVarArray ($doc;aPODiscnt)
////ReadVarArray ($doc;aPoDscntUP)
////ReadVarArray ($doc;aPOExtCost)
////ReadVarArray ($doc;aPOVATax)
////ReadVarArray ($doc;aPOTaxable)
////ReadVarArray ($doc;aPOUnitMeas)
////ReadVarArray ($doc;aPoUnitWt)
////ReadVarArray ($doc;aPoBackLog)
////ReadVarArray ($doc;aPOLineNum)
////ReadVarArray ($doc;aPODateExp)
////ReadVarArray ($doc;aPOOrdRef)
////ReadVarArray ($doc;aPODateRcvd)
////ReadVarArray ($doc;aPOSerialRc)
////ReadVarArray ($doc;aPOSerialNm)
////ReadVarArray ($doc;aPOVndrAlph)
////ReadVarArray ($doc;aPoItemNum)
////ReadVarArray ($doc;aPOLineAction)
////ReadVarArray ($doc;aPoPQBIR)
////ReadVarArray ($doc;aPoSeq)
////ReadVarArray ($doc;aPoLComment)
////ReadVarArray ($doc;aPoNPCosts)
////ReadVarArray ($doc;aPoDuties)
////ReadVarArray ($doc;aPoExtWt)
//////
////ReadVarArray ($doc;aPOCustRef)
////ReadVarArray ($doc;aPoSiteRef)
////CloseVarFile($doc)
//End if 


//POLineALDefine(ePoList)
//REDUCE SELECTION([Vendor]; 0)
//QUERY([Vendor]; [Vendor]customerIDAtVend=aText1{1}; *)
//QUERY([Vendor];  & [Vendor]company=aText1{37})
//If ((aText1{35}#"") & (Records in selection([Vendor])=0))
//QUERY([Vendor]; [Vendor]dunsNumber=aText1{35})
//End if 
//If (Records in selection([Vendor])=0)
//CREATE RECORD([Vendor])
//[Vendor]vendorID:=String(CounterNew(->[Vendor]))
//[Vendor]customerIDAtVend:=aText1{1}
//[Vendor]company:=aText1{37}
//[Vendor]dunsNumber:=aText1{35}
//[Vendor]domain:=aText1{36}  //:=Storage.default.domain
//[Vendor]company:=aText1{37}  //:=<>tc_Company
//[Vendor]address1:=aText1{38}  //:=<>tc_Address1
//[Vendor]address2:=aText1{39}  //:=<>tc_Address2
//[Vendor]city:=aText1{40}  //:=<>tc_City
//[Vendor]state:=aText1{41}  //:=<>tc_State
//[Vendor]zip:=aText1{42}  //:=<>tc_Zip
//[Vendor]country:=aText1{43}  //:=<>tc_Country    
//[Vendor]email:=aText1{44}  //:=Storage.default.email      
//ParsePhone(aText1{45}; ->[Vendor]phone; <>tcLocalArea)
//ParsePhone(aText1{46}; ->[Vendor]fax; <>tcLocalArea)
//[Vendor]terms:=aText1{16}  //:=[Order]Terms
//[Vendor]attention:=[Order]takenBy
//[Vendor]shipInstruct:=aText1{25}
//SAVE RECORD([Vendor])
//End if 
//loadVendor2PO
//If (Num(aText1{2})#[PO]idNum)  //:=[Order]CustPONum
//ALERT("PO Number was listed at vendor as:  "+aText1{2})
//End if 
//[PO]vendorDocid:=aText1{47}  //:=String([Order]OrderNum)  
//[PO]dateOrdered:=Date(aText1{3})  //:=String([Order]DateOrdered)
//[PO]dateNeeded:=Date(aText1{4})  //:=String([Order]DateNeeded)
////[PO]AttnOther:=aText1{5}//:=[Order]RepID
//[PO]salesNameID:=aText1{6}  //:=[Order]SalesName
//[PO]shipVia:=aText1{7}  //:=[Order]ShipVia
//[PO]shipToCompany:=aText1{8}  //:=[Order]Company
//[PO]address1:=aText1{9}  //:=[Order]Address1
//[PO]address2:=aText1{10}  //:=[Order]Address2
//[PO]city:=aText1{11}  //:=[Order]City
//[PO]state:=aText1{12}  //:=[Order]State
//[PO]zip:=aText1{13}  //:=[Order]Zip
//[PO]country:=aText1{14}  //:=[Order]Country
//// :=aText1{15}//:=[Order]TypeSale
//[PO]terms:=aText1{16}  //:=[Order]Terms
////:=aText1{17}//:=String([Order]Amount)
////:=aText1{18}//:=String([Order]SalesTax)
////:=aText1{19}//:=String([Order]ShipTotal)
//// :=aText1{20}//:=String([Order]Total)
//[PO]comment:=aText1{21}  //:=[Order]Comment
//[PO]attention:=aText1{22}  //:=[Order]OrdTakenNameID
//[PO]attnOther:=aText1{23}  //:=[Order]Attention
//[PO]fob:=aText1{24}  //:=[Order]FOB
//[PO]shipInstruct:=aText1{25}  //:=[Order]ShipInstruction
//[PO]profile1:=aText1{26}  //:=[Order]Profile1
//[PO]profile2:=aText1{27}  //:=[Order]Profile2
//[PO]profile3:=aText1{28}  //:=[Order]Profile3
//[PO]docType:=aText1{29}  //:=[Order]DocType
//[PO]docReference:=aText1{30}  //:=[Order]DocReference
//[PO]buyer:=aText1{31}  //:=[Order]OrderedBy
//[PO]phone:=[Vendor]phone  //
//vMod:=calcPO(vMod)
////:=aText1{33}//:=[Order]AddressBillTo
////:=aText1{34}//:=[Order]Bill2Company
//[PO]vendorCompany:=aText1{37}
//End if 

//End if 