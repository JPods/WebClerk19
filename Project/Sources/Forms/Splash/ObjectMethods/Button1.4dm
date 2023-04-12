


$new_o:=cs:C1710.cProcess.new("Clean"; "Order")

$childProcess:=New process:C317("Process_Clean"; 0; String:C10(Count user processes:C343)+"-"+$new_o.dataClassName; $new_o)