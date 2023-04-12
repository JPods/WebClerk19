//https://www.youtube.com/watch?v=PudDtdIYRio
// look at minute 12 for a form example
// use this for maintenance records and financial transations

// https://www.youtube.com/watch?v=zVqczFZr124&t=0s for creating blockchain in javaScript
Class constructor
	This:C1470.chain:=New collection:C1472
	This:C1470.chain.push(This:C1470.createGenesisBlock())  // create the first block ti the chain
	
Function createGenesisBlock()->$block : cs:C1710.cBlock
	//create the first Block in the Chain
	
	$block:=cs:C1710.cBlock.new("Genesis Block"; "")  // previousHash is empty string
	
	
Function getLaskBlock()->$lastBlock : cs:C1710.cBlock
	$lastBlock:=This:C1470.chain[This:C1470.chain.length-1]  // get the previous object in the collection
	
Function push($data : Variant)
	var $newBlock; $lastBlock : cs:C1710.cBlock
	
	$lastBlock:=This:C1470.getLaskBlock()
	$newBlock:=cs:C1710.cBlock.new($data; $lastBlock.hash)  // creates a new Block
	// push the new block onto the chain
	
	This:C1470.chain.push($newBlock)
	
	
Function isValid->$isTrue : Boolean
	
	// returns True if the block chain is valid
	If (This:C1470.chain.length=1)
		$isTrue:=This:C1470.chain[0].isValid()
	Else 
		// test the chain sequence
		var $i : Integer
		$isTrue:=True:C214
		
		For ($i; 1; This:C1470.chain.length-1)
			$isTrue:=$isTrue & \
				(This:C1470.chain[$i].isValid()) & \
				(This:C1470.chain[$i].previousHash=This:C1470.chain[$i-1].calculateHash())
			
		End for 
		
	End if 
	