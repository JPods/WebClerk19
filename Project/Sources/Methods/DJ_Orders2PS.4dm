//%attributes = {}
// ----------------------------------------------------
// user name (os): williamjames
// date and time: 12/04/06, 12:49:29
// ----------------------------------------------------
// method: dj_orders2ps
// description
// 
//
// parameters
// ----------------------------------------------------


mydoc:=Create document:C266("")
If (ok=1)
	
	
	ALL RECORDS:C47([Invoice:26])
	REDUCE SELECTION:C351([Invoice:26]; 15)
	vi2:=Records in selection:C76([Invoice:26])
	vr8:=0
	vr9:=0
	For (vi1; 1; vi2)
		QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]invoiceNum:1=[Invoice:26]invoiceNum:2)
		vi4:=Records in selection:C76([InvoiceLine:54])
		FIRST RECORD:C50([InvoiceLine:54])
		vr8:=vr8+Records in selection:C76([InvoiceLine:54])
		For (vi3; 1; vi4)
			vr9:=vr9+[InvoiceLine:54]extendedPrice:11
			NEXT RECORD:C51([InvoiceLine:54])
		End for 
		NEXT RECORD:C51([Invoice:26])
	End for 
	
	SEND PACKET:C103(mydoc; "<?xml version="+Txt_Quoted("1.0")+"?>"+"\r")
	SEND PACKET:C103(mydoc; "<invoice xmlns:xsi="+Txt_Quoted("http://www.w3.org/2001/xmlschema-instance")+" nonamespaceschemalocation"+Txt_Quoted("invoicexcrm.xsd")+">"+"\r")
	SEND PACKET:C103(mydoc; "<invoicerec>"+"\r")
	SEND PACKET:C103(mydoc; "<transmissionheader>"+"\r")
	QUERY:C277([TallyResult:73]; [TallyResult:73]name:1="billingbatchnum")
	If ((Records in selection:C76([TallyResult:73])=1) & (Not:C34(Locked:C147([TallyResult:73]))))
		[TallyResult:73]longint1:7:=[TallyResult:73]longint1:7+1
		SAVE RECORD:C53([TallyMaster:60])
		SEND PACKET:C103(mydoc; " <billing_release_batch_nbr>"+String:C10([TallyResult:73]longint1:7)+"</billing_release_batch_nbr>"+"\r")
		REDUCE SELECTION:C351([TallyMaster:60]; 0)
		vtime1:=Current time:C178
		vtext5:=String:C10(vtime1; 1)
		vdate1:=Current date:C33
		vtext6:=String:C10(Year of:C25(vdate1); "0000")+" "+String:C10(Month of:C24(vdate1); "00")+" "+String:C10(Day of:C23(vdate1); "00")
		vtext6:=vtext6+"t"+vtext5
		SEND PACKET:C103(mydoc; " <datetime>"+vtext6+"</datetime>"+"\r")
		
		SEND PACKET:C103(mydoc; " <order_hdr_count>"+String:C10(vi2)+"</order_hdr_count>"+"\r")
		SEND PACKET:C103(mydoc; " <order_line_count>"+String:C10(vr8)+"</order_line_count>"+"\r")
		SEND PACKET:C103(mydoc; " <order_note_count>"+String:C10(vr8)+"</order_note_count>"+"\r")
		SEND PACKET:C103(mydoc; " <order_note_count>"+"0"+"</order_note_count>"+"\r")
		SEND PACKET:C103(mydoc; " <payment_count>"+"0"+"</payment_count>"+"\r")
		SEND PACKET:C103(mydoc; " <contract_count>"+"0"+"</contract_count>"+"\r")
		SEND PACKET:C103(mydoc; " <order_line_amt>"+String:C10(vr9; 2)+"</order_line_amt>"+"\r")
		SEND PACKET:C103(mydoc; " <payment_amt>"+"0"+"</payment_amt>"+"\r")
		SEND PACKET:C103(mydoc; " <acknowledge_req>"+"Y"+"</acknowledge_req>"+"\r")
		SEND PACKET:C103(mydoc; " <usage_indicator>"+"P"+"</usage_indicator>"+"\r")
		SEND PACKET:C103(mydoc; " <billing_source>"+"DJREPRINTS"+"</billing_source>"+"\r")
		SEND PACKET:C103(mydoc; " <batch_identifier>"+"INVOICE"+"</batch_identifier>"+"\r"+"\r")
		
		
		
		
		
		ARRAY TEXT:C222(atext1; 14)
		atext1{1}:="billing_release_batch_nbr"
		atext1{2}:="dj_bi_batch_nbr "
		atext1{3}:="datetime"
		atext1{4}:="order_hdr_count"
		atext1{5}:="order_line_count"
		atext1{6}:="order_note_count"
		atext1{7}:="payment_count"
		atext1{8}:="contract_count"
		atext1{9}:="order_line_amt"
		atext1{10}:="payment_amt"
		atext1{11}:="acknowledge_req"
		atext1{12}:="usage_indicator"
		atext1{13}:="billing_source"
		atext1{14}:="batch_identifier"
		
		
		
		
		ARRAY TEXT:C222(atext3; 4)
		atext3{1}:=" "
		atext3{2}:="  "
		atext3{3}:="   "
		atext3{4}:="    "
		
		FIRST RECORD:C50([Invoice:26])
		vr9:=0
		vr8:=0
		
		
		For (vi1; 1; vi2)
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Invoice:26]customerID:3)
			QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]invoiceNum:1=[Invoice:26]invoiceNum:2)
			
			SEND PACKET:C103(mydoc; "  <bi_hdr>"+"\r")
			
			
			SEND PACKET:C103(mydoc; atext3{2}+"<business_unit>"+"RP100"+"</business_unit>"+"\r")
			SEND PACKET:C103(mydoc; atext3{2}+"<bill_to_cust_ id>"+[Invoice:26]customerID:3+"</bill_to_cust_ id>"+"\r")  //"_jit_26_3jj"
			SEND PACKET:C103(mydoc; atext3{2}+"<address_seq_num>"+""+"</address_seq_num>"+"\r")
			SEND PACKET:C103(mydoc; atext3{2}+"<bill_source_id>"+"DJREPRINTS"+"</bill_source_id>"+"\r")
			SEND PACKET:C103(mydoc; atext3{2}+"<bill_type_id>"+"RRN"+"</bill_type_id>"+"\r")  // (regular), 
			SEND PACKET:C103(mydoc; atext3{2}+"<billing_frequency>"+""+"</billing_frequency>"+"\r")
			SEND PACKET:C103(mydoc; atext3{2}+"<bill_plan_id>"+""+"</bill_plan_id>"+"\r")
			SEND PACKET:C103(mydoc; atext3{2}+"<order_no>"+String:C10([Invoice:26]orderNum:1)+"</order_no>"+"\r")  //_jit_26_1jj
			SEND PACKET:C103(mydoc; atext3{2}+"<billing_specialist>"+""+"</billing_specialist>"+"\r")
			SEND PACKET:C103(mydoc; atext3{2}+"<sales_person>"+[Invoice:26]salesNameID:23+"</sales_person>"+"\r")  //"_jit_26_23jj"
			SEND PACKET:C103(mydoc; atext3{2}+"<collector>"+""+"</collector>"+"\r")
			SEND PACKET:C103(mydoc; atext3{2}+"<cr_analyst>"+""+"</cr_analyst>"+"\r")
			SEND PACKET:C103(mydoc; atext3{2}+"<dj_bi_soldto_nbr>"+""+"</dj_bi_soldto_nbr>"+"\r")
			SEND PACKET:C103(mydoc; atext3{2}+"<dj_bi_soldto_name>"+[Invoice:26]bill2Company:69+"</dj_bi_soldto_name>"+"\r")  //"_jit_26_69jj"
			
			
			
			vi4:=Records in selection:C76([InvoiceLine:54])
			FIRST RECORD:C50([InvoiceLine:54])
			vr8:=vr8+Records in selection:C76([InvoiceLine:54])
			For (vi3; 1; vi4)
				vr9:=vr9+[InvoiceLine:54]extendedPrice:11
				
				SEND PACKET:C103(mydoc; atext3{3}+"<bi_line>"+"\r")
				SEND PACKET:C103(mydoc; atext3{3}+"<trans_type_bi>"+"NOTE"+"</trans_type_bi>"+"\r")
				SEND PACKET:C103(mydoc; atext3{4}+"<dj_bi_user_n6_a dj_bi_line_nbr>"+String:C10([InvoiceLine:54]orderLineNum:48)+"</dj_bi_user_n6_a dj_bi_line_nbr>"+"\r")  //[invoiceline]uniqueordlnid   //_jit_54_47jj
				SEND PACKET:C103(mydoc; atext3{4}+"<dj_bi_user_n6_b>"+String:C10([InvoiceLine:54]seq:28)+"</dj_bi_user_n6_b>"+"\r")  //[invoiceline]sequence   //_jit_54_28jj
				
				SEND PACKET:C103(mydoc; atext3{4}+"<std_note_flag>"+"N"+"</std_note_flag>"+"\r")  //value=n  we do not have a standard note
				SEND PACKET:C103(mydoc; atext3{4}+"<internal_flag>"+"N"+"</internal_flag>"+"\r")  //[invoiceline]printthis
				SEND PACKET:C103(mydoc; atext3{4}+"<hdr_or_line_note>"+"L"+"</hdr_or_line_note>"+"\r")  //[invoiceline]printthis
				SEND PACKET:C103(mydoc; atext3{3}+"<text254>"+Substring:C12([InvoiceLine:54]comment:40; 1; 254)+"</text254>"+"\r")
				SEND PACKET:C103(mydoc; atext3{3}+"</bi_line>"+"\r")
				//
				SEND PACKET:C103(mydoc; atext3{3}+"<bi_line>"+"\r")
				SEND PACKET:C103(mydoc; atext3{4}+"<trans_type_bi>"+"ae"+"</trans_type_bi>"+"\r")
				SEND PACKET:C103(mydoc; atext3{4}+"<dj_bi_user_n6_a dj_bi_line_nbr>"+String:C10([InvoiceLine:54]orderLineNum:48)+"</dj_bi_user_n6_a dj_bi_line_nbr>"+"\r")  //[invoiceline]uniqueordlnid   //_jit_54_47jj
				SEND PACKET:C103(mydoc; atext3{4}+"<dj_bi_user_n6_b>"+String:C10([InvoiceLine:54]seq:28)+"</dj_bi_user_n6_b>"+"\r")  //[invoiceline]sequence   //_jit_54_28jj
				SEND PACKET:C103(mydoc; atext3{4}+"<bill_cycle_id>"+"M"+"</bill_cycle_id>"+"\r")
				SEND PACKET:C103(mydoc; atext3{4}+"<payment_method>"+""+"</payment_method>"+"\r")
				SEND PACKET:C103(mydoc; atext3{4}+"<bi_currency_cd>"+"USD"+"</bi_currency_cd>"+"\r")
				SEND PACKET:C103(mydoc; atext3{4}+"<invoice_dt>"+""+"</invoice_dt>"+"\r")
				SEND PACKET:C103(mydoc; atext3{4}+"<line_type>"+"REV"+"</line_type>"+"\r")
				SEND PACKET:C103(mydoc; atext3{4}+"<identifier>"+"REV"+"</identifier>"+"\r")  //value= 
				SEND PACKET:C103(mydoc; atext3{4}+"<descr>"+"REV"+"</descr>"+"\r")  //charge description= "revenue line"
				SEND PACKET:C103(mydoc; atext3{4}+"<unit_of_measure>"+"EA"+"</unit_of_measure>"+"\r")
				SEND PACKET:C103(mydoc; atext3{4}+"<qty>"+String:C10([InvoiceLine:54]qty:7; 2)+"</qty>"+"\r")  //[invoiceline]qtyshipped    //_jit_54_7jj
				SEND PACKET:C103(mydoc; atext3{4}+"<unit_amt>"+String:C10([InvoiceLine:54]unitPrice:9; 2)+"</unit_amt>"+"\r")  //[invoiceline]unitprice
				SEND PACKET:C103(mydoc; atext3{4}+"<tax_cd>"+[Invoice:26]taxJuris:33+"</tax_cd>"+"\r")  //must pass tax jurisdiction code.   _jit_26_33jj
				SEND PACKET:C103(mydoc; atext3{4}+"<tax_exempt_cert>"+[Customer:2]taxExemptid:56+"</tax_exempt_cert>"+"\r")  //[Customer]taxempt   _jit_2_56jj
				vtext5:=(("n"*Num:C11([InvoiceLine:54]taxJuris:14="no tax"))+("y"*Num:C11(Not:C34([InvoiceLine:54]taxJuris:14="no tax"))))
				SEND PACKET:C103(mydoc; atext3{4}+"<tax_exempt_flg>"+vtext5+"</tax_exempt_flg>"+"\r")  //y or n (if non-taxable)
				SEND PACKET:C103(mydoc; atext3{4}+"<gross_extended_amt>"+String:C10([InvoiceLine:54]extendedPrice:11; 2)+"</gross_extended_amt>"+"\r")  //[invoiceline]extendedprice     //_jit_54_11jj
				SEND PACKET:C103(mydoc; atext3{4}+"<amount>"+String:C10([InvoiceLine:54]extendedPrice:11; 2)+"</amount>"+"\r")
				SEND PACKET:C103(mydoc; atext3{4}+"<order_int_line_no>"+String:C10([InvoiceLine:54]orderLineNum:48)+"</order_int_line_no>"+"\r")  //[invoiceline]uniqueordlnid     //_jit_54_47jj
				SEND PACKET:C103(mydoc; atext3{4}+"<po_ref>"+[Invoice:26]customerPO:29+"</po_ref>"+"\r")  //"" - nd      _jit_26_29jj
				SEND PACKET:C103(mydoc; atext3{4}+"<contract_num>"+""+"</contract_num>"+"\r")  //this is not a required field or value. leave 
				SEND PACKET:C103(mydoc; atext3{4}+"<note_type>"+""+"</note_type>"+"\r")  //under note type=des
				SEND PACKET:C103(mydoc; atext3{4}+"<std_note_flag>"+"N"+"</std_note_flag>"+"\r")  //value=n  we do not have a standard note
				SEND PACKET:C103(mydoc; atext3{4}+"<internal_flag>"+"N"+"</internal_flag>"+"\r")  //[invoiceline]printthis
				SEND PACKET:C103(mydoc; atext3{4}+"<hdr_or_line_note>"+""+"</hdr_or_line_note>"+"\r")
				SEND PACKET:C103(mydoc; atext3{4}+"<std_note_cd>"+""+"</std_note_cd>"+"\r")
				SEND PACKET:C103(mydoc; atext3{4}+"<text254>"+[InvoiceLine:54]description:5+"</text254>"+"\r")  //_jit_54_5jj
				SEND PACKET:C103(mydoc; atext3{4}+"<rev_recog_basis>"+"INV"+"</rev_recog_basis>"+"\r")
				SEND PACKET:C103(mydoc; atext3{4}+"<billing_specialist>"+""+"</billing_specialist>"+"\r")
				SEND PACKET:C103(mydoc; atext3{3}+"</bi_line>"+"\r"+"\r")
				NEXT RECORD:C51([InvoiceLine:54])
			End for 
			SEND PACKET:C103(mydoc; "  </bi_hdr>"+"\r")
			NEXT RECORD:C51([Invoice:26])
		End for 
		SEND PACKET:C103(mydoc; "</transmissionheader>"+"\r")
		CLOSE DOCUMENT:C267(mydoc)
	End if 
End if 
If (False:C215)
	
End if 


