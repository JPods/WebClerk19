//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-07-17T00:00:00, 22:28:27
// ----------------------------------------------------
// Method: SSLCreateCerts
// Description
// Modified: 07/17/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------




C_TEXT:C284($keyPublic; $keyPrivate; $cert)
// GENERATE ENCRYPTION KEYPAIR([Customer]SSLPrivateKey;[Customer]SSLPublicKey)


//  https://devcenter.heroku.com/articles/ssl-certificate-self
//  Terminal Commands
//   which openssl  // to determine which and if openssl is installed


// "server" is the name of the domain or "localhost" or "127.0.0.1"

//  $ openssl genrsa -des3 -passout pass:x -out server.pass.key 2048
//  $ openssl genrsa -des3 -passout pass:x -out localhost.pass.key 2048


//  $ openssl genrsa -des3 -passout pass:x -out webclerk.com.pass.key 2048

//  ...
//  $ openssl rsa -passin pass:x -in server.pass.key -out server.key
//  $ sudo openssl rsa -passin pass:x -in localhost.pass.key -out localhost.key 

// sudo openssl rsa -passin pass:x -in webclerk.com.pass.key -out webclerk.com.key 
//  writing RSA key


//  $ rm server.pass.key
//  $ rm localhost.pass.key

//  $ rm webclerk.com.pass.key

//  $ openssl req -new -key server.key -out server.csr
//  $ openssl req -new -key webclerk.com.key -out webclerk.com.csr

//  ...
//  Country Name (2 letter code) [AU]:US
//  State or Province Name (full name) [Some-State]:California
//  ...
//  A challenge password []

//  $ openssl req -new -key localhost.key -out localhost.csr


// convert the csr into a cert

//  $ openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
//  $ openssl x509 -req -days 365 -in localhost.csr -signkey localhost.key -out localhost.crt


//  Port forwarding:  https://www.youtube.com/watch?v=F3E91Ta7eAQ
//  http://superuser.com/questions/872309/osx-yosemite-cant-bind-brew-nginx-to-port-80


// single call to create key and cert, self-signed
// $ sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout local.example.com.key -out local.example.com.key.crt




//  must execute from Terminal at each reboot
// redirects my machine to operate without stating ports
//  echo""
//  rdr pass inet proto tcp from any to any port 80->127.0.0.1 port 8080

// this is the command to port forward
// echo "
// rdr pass inet proto tcp from any to any port 80->127.0.0.1 port 8080
//  " | sudo pfctl -ef -

// echo "
//  rdr pass inet proto tcp from any to any port 443->127.0.0.1 port 8443
//   " | sudo pfctl -ef -
