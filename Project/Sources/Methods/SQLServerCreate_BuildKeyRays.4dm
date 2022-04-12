//%attributes = {"publishedWeb":true}
If (False:C215)
	//Date: 04/30/02
	//Who: Dan Bentson, Arkware
	//Description: List of fields from tables primary keys
End if 

ARRAY TEXT:C222(oaKeysName; 0)
ARRAY TEXT:C222(oaKeysPrimaryTable; 0)


INSERT IN ARRAY:C227(oaKeysPrimaryTable; 1)
oaKeysPrimaryTable{1}:="Customer"
INSERT IN ARRAY:C227(oaKeysName; 1)
oaKeysName{1}:="customerID"

INSERT IN ARRAY:C227(oaKeysPrimaryTable; 1)
oaKeysPrimaryTable{1}:="Order"
INSERT IN ARRAY:C227(oaKeysName; 1)
oaKeysName{1}:="OrderNum"

INSERT IN ARRAY:C227(oaKeysPrimaryTable; 1)
oaKeysPrimaryTable{1}:="Item"
INSERT IN ARRAY:C227(oaKeysName; 1)
oaKeysName{1}:="ItemNum"

INSERT IN ARRAY:C227(oaKeysPrimaryTable; 1)
oaKeysPrimaryTable{1}:="Rep"
INSERT IN ARRAY:C227(oaKeysName; 1)
oaKeysName{1}:="RepID"

INSERT IN ARRAY:C227(oaKeysPrimaryTable; 1)
oaKeysPrimaryTable{1}:="Carrier"
INSERT IN ARRAY:C227(oaKeysName; 1)
oaKeysName{1}:="CarrierID"

INSERT IN ARRAY:C227(oaKeysPrimaryTable; 1)
oaKeysPrimaryTable{1}:="Jobs"
INSERT IN ARRAY:C227(oaKeysName; 1)
oaKeysName{1}:="JobID"

INSERT IN ARRAY:C227(oaKeysPrimaryTable; 1)
oaKeysPrimaryTable{1}:="Invoice"
INSERT IN ARRAY:C227(oaKeysName; 1)
oaKeysName{1}:="InvoiceNum"

INSERT IN ARRAY:C227(oaKeysPrimaryTable; 1)
oaKeysPrimaryTable{1}:="Term"
INSERT IN ARRAY:C227(oaKeysName; 1)
oaKeysName{1}:="termID"

INSERT IN ARRAY:C227(oaKeysPrimaryTable; 1)
oaKeysPrimaryTable{1}:="Vendor"
INSERT IN ARRAY:C227(oaKeysName; 1)
oaKeysName{1}:="VendorID"

INSERT IN ARRAY:C227(oaKeysPrimaryTable; 1)
oaKeysPrimaryTable{1}:="PO"
INSERT IN ARRAY:C227(oaKeysName; 1)
oaKeysName{1}:="PONum"

INSERT IN ARRAY:C227(oaKeysPrimaryTable; 1)
oaKeysPrimaryTable{1}:="Proposal"
INSERT IN ARRAY:C227(oaKeysName; 1)
oaKeysName{1}:="ProposalNum"

INSERT IN ARRAY:C227(oaKeysPrimaryTable; 1)
oaKeysPrimaryTable{1}:="Currencies"
INSERT IN ARRAY:C227(oaKeysName; 1)
oaKeysName{1}:="CurrencyID"

INSERT IN ARRAY:C227(oaKeysPrimaryTable; 1)
oaKeysPrimaryTable{1}:="Eventlog"
INSERT IN ARRAY:C227(oaKeysName; 1)
oaKeysName{1}:="eventID"

INSERT IN ARRAY:C227(oaKeysPrimaryTable; 1)
oaKeysPrimaryTable{1}:="LoadTag"
INSERT IN ARRAY:C227(oaKeysName; 1)
oaKeysName{1}:="LoadTagID"

INSERT IN ARRAY:C227(oaKeysPrimaryTable; 1)
oaKeysPrimaryTable{1}:="GenericParent"
INSERT IN ARRAY:C227(oaKeysName; 1)
oaKeysName{1}:="GenericParentID"

INSERT IN ARRAY:C227(oaKeysPrimaryTable; 1)
oaKeysPrimaryTable{1}:="GenericChild1"
INSERT IN ARRAY:C227(oaKeysName; 1)
oaKeysName{1}:="GenericChild1ID"

INSERT IN ARRAY:C227(oaKeysPrimaryTable; 1)
oaKeysPrimaryTable{1}:="GenericChild2"
INSERT IN ARRAY:C227(oaKeysName; 1)
oaKeysName{1}:="GenericChild2ID"

INSERT IN ARRAY:C227(oaKeysPrimaryTable; 1)
oaKeysPrimaryTable{1}:="POReceipts"
INSERT IN ARRAY:C227(oaKeysName; 1)
oaKeysName{1}:="ReceiptID"
