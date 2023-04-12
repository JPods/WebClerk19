//%attributes = {}
/*
This code creates a payment request object, converts it to a JSON string, and then sends it to the PayPal API using the HTTP POST method. It then checks the response status code to determine whether the request was successful. If the request was successful, it redirects the user to the approval URL provided by PayPal. If the request failed, it displays an error message.

This code uses the HTTP module to send the request and the JSON module to parse the response. It also includes a helper function, getAccessToken, which is used to obtain an access token from PayPal that is required for making API requests
*/

//// Set up the URL and API credentials
//$url="https://api.sandbox.paypal.com/v1/payments/payment"
//$clientId="your_client_id"
//$secret="your_secret"

//// Set up the payment details
//$payment={
//"intent" : "sale", 
//"payer" : {
//"payment_method" : "paypal"
//}, 
//"transactions" : [{
//"amount" : {
//"total" : "10.00", 
//"currency" : "USD"
//}, 
//"description" : "Test payment"
//}], 
//"redirect_urls" : {
//"return_url" : "http://your-site.com/return", 
//"cancel_url" : "http://your-site.com/cancel"
//}
//}

//// Convert the payment details to a JSON string
//$paymentJson=JSON.stringify($payment)

//// Set up the request headers
//$headers={
//"Content-Type" : "application/json", 
//"Authorization" : "Bearer "+getAccessToken($clientId,$secret)
//}

//// Post the payment request to PayPal
//$response=HTTP.POST.JSON($url,$headers,$paymentJson)

//// Check the response status code
//If ($response.status_code=201)
//// Payment request was successful, redirect the user to the approval URL
//Redirect($response.json.links[1].href)
//Else 
//// Payment request failed, display an error message
//ALERT("Payment request failed: "+$response.status_code+" "+$response.status_text)

//// Function to get an access token from PayPal
//Function getAccessToken($clientId,$secret)
//// Set up the URL and request body
//$url="https://api.sandbox.paypal.com/v1/oauth2/token"
//$body="grant_type=client_credentials"

//// Set up the request headers
//$headers={
//"Content-Type" : "application/x-www-form-urlencoded", 
//"Authorization" : "Basic "+base64.encode($clientId+":"+$secret)
//}

//// Send the request to get the access token
//$response=HTTP.POST.URLENCODED($url,$headers,$body)

//// Return the access token
//return $response.json.access_token
//End Function