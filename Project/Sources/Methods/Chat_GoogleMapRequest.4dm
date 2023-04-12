//%attributes = {}
/*

This code sends a GET request to the Google Maps API with the specified address as a query string parameter. It then checks the response status code to determine whether the request was successful. If the request was successful, it parses the latitude and longitude from the response and displays them. If the request failed, it displays an error message.



// Set up the API endpoint and API key
$url = "https://maps.googleapis.com/maps/api/geocode/json"
$key = "your_api_key"

// Set up the address to geocode
$address = "1600 Amphitheatre Parkway, Mountain View, CA"

// Set up the query string parameters
$params = {
  "address": $address,
  "key": $key
}

// Send the request to the Google Maps API
$response = HTTP.GET.JSON($url, $params)

// Check the response status
If ($response.status_code = 200)
  // Get the latitude and longitude from the response
  $lat = $response.json.results[0].geometry.location.lat
  $lng = $response.json.results[0].geometry.location.lng

  // Display the latitude and longitude
  Alert("Latitude: " + $lat + "\nLongitude: " + $lng)
Else
  // Display an error message
  Alert("Request failed: " + $response.status_code + " " + $response.status_text)
End If


*/

