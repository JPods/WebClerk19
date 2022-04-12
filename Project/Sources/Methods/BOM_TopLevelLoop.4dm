//%attributes = {"publishedWeb":true}
//Procedure BOM_TopLevelLoop
//Peter Fleming
//01/05/02
//James W. Medlen
//### jwm ### 20120109_1449
//added choices for Retired and Models Only (Profile 1 = "model")
//### jwm ### 20120228 modified method to correclty handle models not at top level.


C_BOOLEAN:C305($ItemHasParent; $vbAll; $vbRetired; $vbAdd)
ARRAY TEXT:C222(aItemStack; 0)

CONFIRM:C162("Include All Top Level Items or Models Only \r\rItems Profile1 = model"; "All"; "Models Only")

If (OK=1)
	$vbAll:=True:C214
Else 
	$vbAll:=False:C215
End if 

CONFIRM:C162("Include Retired Items"; "Yes"; "No")

If (OK=1)
	$vbRetired:=True:C214
Else 
	$vbRetired:=False:C215
End if 

//Start stack with item

INSERT IN ARRAY:C227(aItemStack; 1)
aItemStack{1}:=[Item:4]itemNum:1
CREATE SET:C116([Item:4]; "Current_Items")  //### jwm ### 20120109_1449 save current selected items
$ItemHasParent:=False:C215

Repeat 
	
	//Check for parents of top item on stack - Search BOM file on ChildItem
	
	QUERY:C277([BOM:21]; [BOM:21]ChildItem:2=aItemStack{1})
	QUERY:C277([Item:4]; [Item:4]itemNum:1=aItemStack{1})
	
	If (Records in selection:C76([BOM:21])>0)
		$ItemHasParent:=True:C214
	Else 
		$ItemHasParent:=False:C215
	End if 
	
	//If no [BOM] record, then item is in no BOM (No W/U)
	//Add to top level item list if not already there
	//and remove top item from stack.
	//Items that are top level to begin with (no parents) are not put in the result
	// jwm added choices for including Profile1 = model and excluding retired items
	
	$vbAdd:=False:C215
	// All Top Level and  Models or Models only
	If ((((Records in selection:C76([BOM:21])=0) & ($vbAll=True:C214)) | ([Item:4]profile1:35="model")))
		// Only false when excluding Retired Items and the Item is retired
		If (Not:C34(($vbRetired=False:C215) & ([Item:4]retired:64=True:C214)))
			$vbAdd:=True:C214  //add to Top Level Items
		End if 
	End if 
	
	If ($vbAdd)
		If (Find in array:C230(<>aTopLevelItem; aItemStack{1})<0)
			INSERT IN ARRAY:C227(<>aTopLevelItem; 1)
			<>aTopLevelItem{1}:=aItemStack{1}
		End if 
	End if 
	
	If ($ItemHasParent)
		
		//Is used in BOM(s) and thus has parent(s))
		//For each BOM record add parent to stack if not already there
		//Then remove child (top item) from stack
		
		NoItemHadParent:=False:C215
		
		For ($i; 1; Records in selection:C76([BOM:21]))
			If (Find in array:C230(aItemStack; [BOM:21]ItemNum:1)<0)
				INSERT IN ARRAY:C227(aItemStack; 2)
				aItemStack{2}:=[BOM:21]ItemNum:1
			End if 
			NEXT RECORD:C51([BOM:21])
		End for 
		
		DELETE FROM ARRAY:C228(aItemStack; 1)
		
	Else   //item has no parents 
		
		DELETE FROM ARRAY:C228(aItemStack; 1)
		
	End if 
	
Until (Size of array:C274(aItemStack)=0)
USE SET:C118("Current_Items")  //### jwm ### 20120109_1449 restore current selected items
CLEAR SET:C117("Current_Items")




