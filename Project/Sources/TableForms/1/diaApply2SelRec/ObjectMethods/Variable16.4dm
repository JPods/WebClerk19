cntFields:=Size of array:C274(aImpFields)+1
INSERT IN ARRAY:C227(aCntImpFlds; cntFields; 1)
INSERT IN ARRAY:C227(aImpFields; cntFields; 1)
INSERT IN ARRAY:C227(aBullets; cntFields; 1)
aCntImpFlds{cntFields}:=cntFields
aImpFields{cntFields}:=vStr255
aBullets{cntFields}:=""
HIGHLIGHT TEXT:C210(vStr255; 1; 255)
//  --  CHOPPED  AL_UpdateArrays(eImportList; -2)