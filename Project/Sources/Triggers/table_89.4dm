//Trigger: Generic Parent
//Noah Dykoski 991206

Case of 
	: (Trigger event:C369=On Deleting Record Event:K3:3)
		//cascade delete GenericChild1/2 records
		QUERY:C277([GenericChild1:90]; [GenericChild1:90]idUniqueParent:2=[GenericParent:89]idUnique:1)
		DELETE SELECTION:C66([GenericChild1:90])
		QUERY:C277([GenericChild2:91]; [GenericChild2:91]idUniqueParent:2=[GenericParent:89]idUnique:1)
		DELETE SELECTION:C66([GenericChild2:91])
		QUERY:C277([GenericPC1:92]; [GenericPC1:92]idUniqueParent:1=[GenericParent:89]idUnique:1)
		DELETE SELECTION:C66([GenericPC1:92])
		QUERY:C277([GenericPC2:93]; [GenericPC2:93]idUniqueParent:1=[GenericParent:89]idUnique:1)
		DELETE SELECTION:C66([GenericPC2:93])
	: (Trigger event:C369=On Saving New Record Event:K3:1)
		If ([GenericParent:89]idUnique:1<=0)
			//[GenericParent]UniqueID:=Sequence number([GenericParent])  // ### jwm ### 20170818_1659 auto-increment
		End if 
End case 