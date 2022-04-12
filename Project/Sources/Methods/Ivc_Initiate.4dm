//%attributes = {"publishedWeb":true}
InitSalesVar
LoadCustomersInvoices  //   vIvcDirect:=False       
If ([Invoice:26]invoiceNum:2=0)
	[Invoice:26]invoiceNum:2:=CounterNew(->[Invoice:26])
End if 
newInv:=True:C214
vMod:=False:C215
[Invoice:26]orderNum:1:=1
[Invoice:26]dateShipped:4:=Current date:C33
[Invoice:26]packedBy:30:=Current user:C182