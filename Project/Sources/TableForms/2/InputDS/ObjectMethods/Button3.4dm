var $script : Text

$script:="QUERY([Document]; [Document]customerID=\""+process_o.cur.customerID+"\"; *)"+"\r"
$script:=$script+"QUERY([Document]; & ;[Document]tableNum=2)"
ProcessTableOpen(Table:C252(->[Document:100]); $script; process_o.cur.company)


