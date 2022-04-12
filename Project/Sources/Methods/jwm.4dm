//%attributes = {}
If (False:C215)
	
	//4D Notes & Revisions
	
	// 03/29/2019; 12:20 - Reverted changes made by AZM to Query Editor
	
	// 04/05/2016 10:30 - Method: Http_ReturnOS
	// ### jwm ### 20160405_1027  find cookie OperatingSystem if found set to cookie value
	
	//04/12/2013 15:52 - Method: voidCurOrder
	//### jwm ### 20130412_1550 QtyOnHand should never change due to an Order changed [Order]ln'LnQtyShipped to 0 zero
	
	//04/12/2013 11:52 -  Method: Pricing_Update
	//### jwm ### 20130412_1150 changed <>tcsiteID to [Order]siteID
	
	//04/12/2013 11:38 -  Method: NxPvPOs
	//### jwm ### 20130412_1134 added vsiteID
	
	//04/11/2013 13:56 - Method: Or_CompleteSelected
	//### jwm ### 20130411_1353 changed <>tcsiteID to vsiteID
	
	//04/11/2013 9:24 - Method: OR_CancelPast
	//### jwm ### 20130411_0921 changed <>tcsiteID to [Order]siteID
	
	//04/10/2013 17:06 - Method: OrdLineCalc
	//??? jwm ??? 20130405_1643 should not change QOH when deleting a order Line
	//### jwm ### 20130405_1540 changed <>tcsiteID to [Order]siteID
	//### jwm ### 20130405_1646 changed -[Order]ln'LnQtyShipped to 0 (Zero)
	//### jwm ### 20130410_1627 changed from <>tcsiteID to [Order]siteID
	//### jwm ### 20130410_1629 changed from <>tcsiteID to [Order]siteID
	//### jwm ### 20130410_1630 changed <>tcsiteID to vsiteID (chack to make sure coming from packing window)
	//### jwm ### 20130410_1703 changes to order lines should never effect inventory 
	//### jwm ### 20130410_1704 $dOnHand set to 0 above changes to Order lines should never effect inventory
	//### jwm ### 20130411_0913 parameter 10 changed to $dOnHand for all calls to Invt_dRecCreate $dOnHand = 0
	
	//04/04/2013 17:32 - IvcLnLoadRec
	//### jwm ### 20130404_1723 changed <>tcsiteID to [Invoice]siteID
	//### jwm ### 20130404_1727 changed <>tcsiteID to [Invoice]siteID
	
	//04/04/2013 15:21 - Method: BOM_Multi2
	//04/04/2013 15:20 - currently orphaned method make sure to set vsiteID in calling procedure
	//### jwm ### 20130404_1509 changed <>tcsiteID to vsiteID
	//### jwm ### 20130404_1510 changed <>tcsiteID to vsiteID
	//### jwm ### 20130404_1511 changed <>tcsiteID to vsiteID
	//### jwm ### 20130404_1513 changed <>tcsiteID to vsiteID
	//### jwm ### 20130404_1514 changed <>tcsiteID to vsiteID
	//### jwm ### 20130404_1515 changed <>tcsiteID to vsiteID
	//### jwm ### 20130404_1516 changed <>tcsiteID to vsiteID
	
	//04/04/2013 10:59 - Method: acceptInvoice
	//### jwm ### 20130404_1058 set for any potential dInventory
	
	//04/04/2013 10:26 - Method: Object Method: b11
	//### jwm ### 20130404_1022 use existing siteID from dInventory record
	
	//04/04/2013 10:02 - Method: BOM_ChildCost
	//### jwm ### 20130404_0956 changed <>tcsiteID to vsiteID
	//### jwm ### 20130404_0957 changed <>tcsiteID to vsiteID
	//### jwm ### 20130404_0958 changed <>tcsiteID to vsiteID
	//### jwm ### 20130404_0959 changed <>tcsiteID to vsiteID
	
	//03/21/2013 12:31 -  Method: Bom_ApplyIvcLn
	//### jwm ### 20130321_1229 changed <>tcsiteID to [InvoiceLine]siteID
	//### jwm ### 20130321_1230 changed <>tcsiteID to [InvoiceLine]siteID
	
	//03/21/2013 12:05 - Method: IVNT_dRayInit
	//### jwm ### 20130308_1643 changed dSite size from 4 to 40
	
	//03/21/2013 12:03 - Method: INVT_dInvtApply
	//### jwm ### 20130319_1429 we dont want to override the siteID for the entire Array
	//### jwm ### 20130319_1439 use original dsiteID array only
	
	//03/21/2013 12:02 - Method: InvtAdjDiaSave
	//### jwm ### 20130319_1332 changed <>tcsiteID to vsiteID
	
	//03/21/2013 12:00 - Method: BOM_QtyChange
	//### jwm ### 20130319_1337 Changed <>tcsiteID to vsiteID
	//### jwm ### 20130319_1350 Changed <>tcsiteID to vsiteID
	
	//03/21/2013 11:59 - Object Method: [WOdraw]diaSignOut.bAcceptB
	//### jwm ### 20130319_1706 Changed <>tcsiteID to vsiteID add drop down to Form [WOdraw]diaSignOut
	
	//03/21/2013 11:58 - Object Method: [WorkOrder]iWorkOrders_9.ItemNum
	//### jwm ### 20130319_1551 changed <>tcsiteID to [Invoice]siteID
	
	//03/21/2013 11:56 - Object Method: [Control]MTl_SignOut.b1
	//### jwm ### 20130319_1352 <>tcsiteID changed to vsiteID
	
	//03/19/2013 16:53 - Method: Rebuild_dInvtry
	//### jwm ### 20130319_1645 changed <>tcsiteID to [Invoice]siteID
	//### jwm ### 20130319_1655 changed <>tcsiteID to [Order]siteID
	//### jwm ### 20130319_1656 changed <>tcsiteID to [PO]siteID
	
	//03/19/2013 14:35 - Method: Compiler_Arrays
	//### jwm ### 20130319_1433 changed DSITE from 4 to 40
	
	//03/19/2013 14:16 - Object Method: [Default]Invt_dRecCreate.b5
	//### jwm ### 20130319_1401 changed <>tcsiteID to siteID
	
	//03/19/2013 13:32 - InvtAdjDiaSave
	//### jwm ### 20130319_1332 changed <>tcsiteID to siteID
	
	//03/08/2013 16:02 - Method: Invt_dRecCreate
	//### jwm ### 20130308_1558 string size $14 changed from 4 to 40
	
	
	//CE2010zmb Begin
	//01/29/2013 10:44 - WO_TransferCreate
	//### jwm ### 20130129_1040 was > 7  line 32
	
	
	//CE2010zmb End
	
	//12/06/2011 14:27 - set database parameters in Server Startup and Startup methods test to eliminate VPN errors ComEx11r6yn_07_12i
	//srch:  ### jwm ### 20111206 Database timeout parameters
	//ServerStartup 
	
	//11/29/2011 16:58 - Do Not Override Freight Billing for Contacts when loading shipping addres in order
	
	
	
	//11/21/2011 13:09 - Employees input form ### jwm ### 20111121 subform for territories was causing ptCurTable to be set to [Territory]
	
	
	
	//10/21/2011 14:35 - Added [InvoiceLine]ProfileReal1 and [InvoiceLine]ProfileReal2
	//OK
	
	
	//10/19/2011 09:10 - ### jwm ### 20111019 added to prevent error message in interpreted mode
	//Method: Execute_TallyMaster
	//C_BOOLEAN(allowAlerts_boo)//###_jwm_### 20111019 added to prevent error message in interpreted mode
	
	//07/27/2011 13:50 - DscntSetAll, DscntSetPrice, LN_PricePoint changed calls to these methods to use [Order]DateOrdered instead of [Order]DateNeeded
	//Done 
	
	
	//06/13/2011 15:31 - Records_Out Line 17 ### jwm ### 20110613 Enable passing in of file name for scripting
	//Done
	
	
	
	//05/12/2011 11:55 - shipWtCost Line 4 ORDER SUBRECORDS BY([Carrier]WeightChart;[Carrier]WeightChart'Weight;>)//### jwm ### 20110512 Make sure that weight records are sorted in ascending order
	
	
	
	//05/12/2011 11:12 - ImpShipWtCh Line 56 $theField:=Replace string($theField;Char(9);"")//### jwm ### 20110512 remove tabs inserted by Excel
	//04/13/2011 08:42 - PKShippingCost updated to remove unloading of invoice record and moved humdred wieght calculation after case statement.
	//04/12/2011 12:48 - changed direction of link from [Item]ItemNum to [ItemSpec]ItemNum new method PKShippingCost
	//03/02/2011 10:23 - Object Method: [Contact].oContacts_9.iLo20String1 Added letter F for FaxList to Contacts Output Layout
	//02/21/2011 13:01 - [SpecialDiscount]iSpecDscnts_9 - If (([SpecialDiscount]PriceBase<1)|([SpecialDiscount]PriceBase>5))//### jwm ### 20110220 was 4 and did not allow for 5 = MSRP
	//02/17/2011 10:45 - TIO_ParseRawTxt trim leading spaces using While statement update to resolve pointing to a character past the end of the string
	//02/16/2011 10:50 - objet method [EDISetID].iEDISetIDs_.b3 $theText:=Get_FolderName ("Source/Destination Folder";"")   //### jwm ### 20110216
	//02/15/2011 10:53 - ShippingCost deleted call to tallymaster record ShippingCalc
	//02/15/2011 09:16 - ShippingCost added case to handle [Carrier]Script at line 48-49
	//10/22/2010 11:26 - Added field 70 ItemNum and field 71 ItemDescription to table Service and ItemNum Sevice Input layout
	//10/04/2010 17:01 - WC_PageSendWithTags updated to return converted file pointer $4 $4->:=BLOB to text(blobPageOut;UTF8 text without length)   //### jwm ### 20101004 would not post to document
	//09/27/2010 16:09 - CE11r6yn_07_11l GL_JrnlSale added dialog similar to GL_JrnlPrch for Ken
	//09/21/2010 17:11 - PKArrayManage new conditional if invoice exists use invoice insure shipping else use orders insure shipping
	//09/15/2010 08:23 - CE11r6yn_07_11k updated CreateOrdInvRay now calculating the Invoice Lines Qty Remain = Qty Shipped + Qty Backlog
	//09/13/2010 10:38 - CE11r6yn_07_11i installed structure on server contains the following updates: [OrderLine] Output Layout doubled menus fixed reset layout to menu #2 to match iLoPagePopUpMenuBar method, [Invoice] input layout added Rounding to [Invoice]Amount to prevent 4D math error with very small values (should be zero), Quick Quote Amount Available label and value replaces quantity on Hand,
	//09/13/2010 10:38 - [InvoiceLine] QtyBacklogged was not correct due to the the QtyRemain being set wrong in the method CreateOrdInvRay.
	//09/10/2010 09:46 - CE11r6yn_07 updated Form Method iInvoices_9 Round [Invoice]Amount to <>tcDecimalTt to avoid 0 zero calculation error that creates infintesimally small value 
	//02/10/2010 09:45 - CE2004yk1 commented out barcode procedure in Inoive inout layout
	//02/08/2010 15:27 - CE2004yk1 updated TMiLoScripts Universal iLoScript method
	//02/08/2010 15:27 - CE2004yk1 updated setChTax DoTax Choice to force Sales Tax
	//02/08/2010 15:27 - CE2004yk1 updated eContactsAreaList remove locking of Cusstomers record
	//02/08/2010 15:27 - CE2004yk1 updated aPSPPProcess iLoScript method Proposals
	//02/08/2010 15:27 - CE2004yk1 updated aPoSIvcProcess iLoScript method POs
	//02/08/2010 15:27 - CE2004yk1 updated aiSIvcProcess iLoScript method Invoices
	//02/02/2010 13:33 - CE2004yk1 updated PKArrayManage to set [LoadTag]DateCreated.
	//01/14/2010 22:10 - CE2004r7yj_03 updated method 333Http_UserGet to resolve customer record number when logged in as contact.
	//01/14/2010 22:08 - CE2004r7yj_02 updates method STARTUP with ASG soft client server licenses
	
End if 