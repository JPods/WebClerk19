//Method: Label_PostOut
//See the TechNote on iLabel Printing for how to use this UserReport.
//Last update:  July 28, 2002
curTableNum:=Table:C252(->[Invoice:26])
$k:=Records in selection:C76(Table:C252(curTableNum)->)
FIRST RECORD:C50(Table:C252(curTableNum)->)
//ThermoInitExit (("Change records:  "+Table name(curTableNum));$k;True)
$viProgressID:=Progress New
For ($i; 1; $k)
	//Thermo_Update ($i)
	ProgressUpdate($viProgressID; $i; $k; "Records: "+Table name:C256(curTableNum))
	If (<>ThermoAbort)
		$i:=$k
	Else 
		//do something
		NEXT RECORD:C51(Table:C252(curTableNum)->)
	End if 
End for 
//Thermo_Close
Progress QUIT($viProgressID)
If (False:C215)
	CONFIRM:C162("Post Invoice Labels?")
	If (OK=1)
		v1:=Char:C90(34)
		v2:=Char:C90(9)  //+Char(34)+Char(44)
		v3:=Char:C90(44)
		vText9:=Storage:C1525.folder.jitF+"iLabels"+Folder separator:K24:12
		If (HFS_Exists(vText9)=0)
			CreateFolder_ReadWrite(vText9)
		End if 
		//Open data file "Labels_Data.txt" in the iLables folder,
		//located under the JIT application folder:
		vText9:=Storage:C1525.folder.jitF+"iLabels"+Folder separator:K24:12+"Labels_Data.txt"
		vi9:=HFS_Exists(vText9)
		If (vi9=1)  //if the file exists, delete it
			vi9:=HFS_Delete(vText9)
		End if 
		//create the new data file "Labels_Data.txt" down in the iLables folder:
		myDoc:=Create document:C266(vText9)
		If (OK=1)
			SEND PACKET:C103(myDoc; "Attention"+v2)  //attn
			SEND PACKET:C103(myDoc; "Company"+v2)  //Co
			vText3:="Address1&2"
			SEND PACKET:C103(myDoc; vText3+v2)  //add1
			SEND PACKET:C103(myDoc; "City"+v2)  //city
			SEND PACKET:C103(myDoc; "State"+v2)  //state
			SEND PACKET:C103(myDoc; "Zip"+v2)  //zip
			SEND PACKET:C103(myDoc; "City, St Zip"+v2)  //CityStZip
			SEND PACKET:C103(myDoc; "Country"+v2)  //country
			SEND PACKET:C103(myDoc; "vFrghtType"+v2)
			SEND PACKET:C103(myDoc; "vShipperID"+v2)
			SEND PACKET:C103(myDoc; "vShipper"+v2)
			SEND PACKET:C103(myDoc; "p_Phone"+v2)  //customer phone
			SEND PACKET:C103(myDoc; "p_DocPhone"+v2)  //Order phone
			SEND PACKET:C103(myDoc; "p_FAX"+v2)  //Order phone
			SEND PACKET:C103(myDoc; "InvoiceNum"+v2)
			SEND PACKET:C103(myDoc; "customerID"+Char:C90(13))  //CustID
			vi2:=Records in selection:C76([Invoice:26])
			FIRST RECORD:C50([Invoice:26])
			For (vi1; 1; vi2)
				UNLOAD RECORD:C212([Order:3])
				If ([Customer:2]customerID:1#[Invoice:26]customerID:3)
					QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Invoice:26]customerID:3)
				End if 
				If ([Invoice:26]idNumOrder:1>1)
					QUERY:C277([Order:3]; [Order:3]idNum:2=[Invoice:26]idNumOrder:1)
				End if 
				P_IvcHeadVars
				SEND PACKET:C103(myDoc; [Invoice:26]attention:38+v2)  //attn
				SEND PACKET:C103(myDoc; [Invoice:26]company:7+v2)  //Co
				If ([Invoice:26]address2:9#"")
					vText3:=[Invoice:26]address1:8+", "+[Invoice:26]address2:9
				Else 
					vText3:=[Invoice:26]address1:8
				End if 
				//Alert(vText3)
				SEND PACKET:C103(myDoc; vText3+v2)  //add1
				SEND PACKET:C103(myDoc; [Invoice:26]city:10+v2)  //city
				SEND PACKET:C103(myDoc; [Invoice:26]state:11+v2)  //state
				SEND PACKET:C103(myDoc; [Invoice:26]zip:12+v2)  //zip
				SEND PACKET:C103(myDoc; [Invoice:26]city:10+", "+[Invoice:26]state:11+"  "+[Invoice:26]zip:12+v2)  //CityStZip
				SEND PACKET:C103(myDoc; [Invoice:26]country:13+v2)  //country
				SEND PACKET:C103(myDoc; vFrghtType+v2)
				SEND PACKET:C103(myDoc; vShipperID+v2)
				SEND PACKET:C103(myDoc; vShipper+v2)
				SEND PACKET:C103(myDoc; p_Phone+v2)  //customer phone
				If (p_DocPhone="")
					p_DocPhone:=p_Phone
				End if 
				SEND PACKET:C103(myDoc; p_DocPhone+v2)  //Order phone
				SEND PACKET:C103(myDoc; p_FAX+v2)  //Order phone
				SEND PACKET:C103(myDoc; String:C10([Invoice:26]idNum:2; "000000")+String:C10(vi3; "00")+v2)
				SEND PACKET:C103(myDoc; [Invoice:26]customerID:3+Char:C90(13))
				NEXT RECORD:C51([Invoice:26])
			End for 
		End if 
		CLOSE DOCUMENT:C267(myDoc)  //close the data file
		
		//For this to work, first create a template file from within the iLabel program.
		//The template file needs to know to open the data file "Labels_Data.txt".
		//Save it to the "iLabels" folder (located within the JIT application folder).
		//Example:   ...jitClient\iLabels\Lb_Invoice_5960.tmp
		//This particular template is for the Avery 5960 labels.
		//You can clone this UserReport and edit this script to generate
		//template files for other label templates that you have saved here.
		vText8:=Storage:C1525.folder.jitF+"iLabels"+Folder separator:K24:12+"Lb_Invoice_5160.tmp"
		//Launch iLabel, using the contents of vText8 as the default template file.
		AE_MacLaunch(""; vText8)
	End if 
	If (vHere<2)
		UNLOAD RECORD:C212([Customer:2])
		UNLOAD RECORD:C212([Order:3])
	End if 
	If (False:C215)
		TRACE:C157
		TaxSalesReportData("Summary by GL")
		TRACE:C157
		CmmCalcMfgReps
	End if 
End if 