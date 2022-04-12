//%attributes = {"publishedWeb":true}
//Procedure: Trng_ItemList
QUERY:C277([Item:4]; [Item:4]mfrid:53="Demo")
curTableNum:=Table:C252(->[Item:4])
StructureFields(curTableNum)
ARRAY LONGINT:C221(aFieldLns; 14)
aFieldLns{1}:=1
aFieldLns{2}:=7
aFieldLns{3}:=2
aFieldLns{4}:=3
aFieldLns{5}:=13
aFieldLns{6}:=14
aFieldLns{7}:=8
aFieldLns{8}:=11
aFieldLns{9}:=26
aFieldLns{10}:=35
aFieldLns{11}:=36
aFieldLns{12}:=37
aFieldLns{13}:=38
aFieldLns{14}:=60
aFieldLns{15}:=28
MatchAdd(False:C215; Size of array:C274(aMatchType))
EI_Calc