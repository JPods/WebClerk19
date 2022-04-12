//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/19/18, 00:08:41
// ----------------------------------------------------
// Method: SyncEncryptSetup
// Description
// 
//
// Parameters
// ----------------------------------------------------

// Example

// generate new Key Pair
C_BLOB:C604($privKey; $pubKey)
GENERATE ENCRYPTION KEYPAIR:C688($privKey; $pubKey; 2048)


// Setup Certificate Signing Request information
ARRAY LONGINT:C221($SSLcodeArray; 6)
ARRAY TEXT:C222($SSLinfoArray; 6)

// Common Name
$SSLcodeArray{1}:=13
$SSLinfoArray{1}:="www.mydomain.com"

// Country Name (2 Letters)
$SSLcodeArray{2}:=14
$SSLinfoArray{2}:="US"

// Locality Name
$SSLcodeArray{3}:=15
$SSLinfoArray{3}:="San Jose"

// State or Province Name
$SSLcodeArray{4}:=16
$SSLinfoArray{4}:="California"

// Organization Name
$SSLcodeArray{5}:=17
$SSLinfoArray{5}:="My Company"

// Organization Unit
$SSLcodeArray{6}:=18
$SSLinfoArray{6}:="My Department or Title"

// generate $CSR
C_BLOB:C604($CSR)
GENERATE CERTIFICATE REQUEST:C691($privKey; $CSR; $SSLcodeArray; $SSLinfoArray)

// save $CSR to file
BLOB TO DOCUMENT:C526("$CSR.txt"; $CSR)

// save private key to file
BLOB TO DOCUMENT:C526("key.pem"; $privKey)

// save public key to file
BLOB TO DOCUMENT:C526("publickey.pem"; $pubKey)