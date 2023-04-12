//%attributes = {}
// testing the individual block

If (False:C215)  //
	var block1; block2 : cs:C1710.cBlockChain
	
	var $myDate : cs:C1710.cDateTime
	$myDate:=cs:C1710.cDateTime.new()
	
	//ALERT($myDate.toString())
	//TRACE
	
	
	block1:=cs:C1710.cBlockChain.new("Block 1"; "")
	block2:=cs:C1710.cBlockChain.new("Block 2"; block1.hash)
	
	
	ASSERT:C1129(block1.isValid(); "Block 1 is valid")
	ASSERT:C1129(block2.isValid(); "Block 2 is valid")
	
	block1.data:="Block One"
	
	ASSERT:C1129(block1.isValid()=False:C215; "Block 1 is not valid anymore")
	
	
End if 
// Unit testing the blockchain

var $blockChain : cs:C1710.cBlockChain

$blockChain:=cs:C1710.cBlockChain.new()

$blockChain.push("Block 1")
$blockChain.push("2")
$blockChain.push(cs:C1710.cBlockChain.new())  // yes we can have a blockchain of blockchains

ASSERT:C1129($blockChain.isValid(); "Block 1 is valid")

$blockChain.chain[1].data:="2"  // this is tampering

ASSERT:C1129($blockChain.isValid()=False:C215; "Blockchain no longer valid")


//  
