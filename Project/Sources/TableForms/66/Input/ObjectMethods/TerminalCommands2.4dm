C_TEXT:C284($pathCerts; $pathacme; $zerossl)
C_LONGINT:C283($tallyMasterBreak)
$tallyMasterBreak:=Find in array:C230(aiLoText15; "----[TallyMaster]----")

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		ARRAY TEXT:C222(ailoText15; 0)
		APPEND TO ARRAY:C911(ailoText15; "MapTasQ TechNotes")
		APPEND TO ARRAY:C911(ailoText15; "MapTasQ Templates")
		
		$tallyMasterBreak:=TMAppendtoArray("MapTasQ"; ->aiLoText15)
		
		INSERT IN ARRAY:C227(ailoText15; 1; 1)
		ailoText15{1}:="MapTasQ Actions"
		ailoText15:=1
		
	: (ailoText15{ailoText15}="----[TallyMaster]----")  //Field List    
		TMTaskOpenTable("MapTasQ")
		// SORT ARRAY(ailoText15)
		
	: (aiLoText15>$tallyMasterBreak)  //Field List  
		C_TEXT:C284($name)
		$name:=ailoText15{ailoText15}
		QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="MapTasQ"; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]name:8=$name)
		C_TEXT:C284($template)
		iLoText1:=[TallyMaster:60]template:29
		iLoText2:=""
		vResponse:=""
		ExecuteText(0; [TallyMaster:60]script:9)
		REDUCE SELECTION:C351([TallyMaster:60]; 0)
		If (iLoText2="")
			If (vResponse="")
				iLoText3:="Results of TallyMasters scripts must be to iLoText2 or vResponse"
			End if 
		End if 
		// iLoText2:=output of script
		
	: (ailoText15{ailoText15}="MapTasQ TechNotes")
		
		<>vTN_OutSide:="MapTasQ"
		TN_Dialog
End case 