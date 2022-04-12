//%attributes = {}
// (PM) HTTPD_AppendResponse
// Appends data to the output buffer
// $1 = Pointer to text or blob variable
// sets data into vblWCResponse
// to size in  WC_SendHeaders($socket)
// to send in WC_SendBody($socket)

C_POINTER:C301($1; $data)

$data:=$1

Case of 
	: (Type:C295($data->)=Is text:K8:3)
		TEXT TO BLOB:C554($data->; vblWCResponse; UTF8 text without length:K22:17; *)
		$data->:=""
		
	: (Type:C295($data->)=Is BLOB:K8:12)
		COPY BLOB:C558($data->; vblWCResponse; 0; BLOB size:C605(vblWCResponse); BLOB size:C605($data->))
		SET BLOB SIZE:C606($data->; 0)
		
End case 
