//%attributes = {}
/*

Here is an example of how you might use 4D to send a request to the UPS API to get shipping costs for a package weighing 10 pounds from zip code 74135 to zip code 55112


// Set up the API endpoint and access key
$url = "https://www.ups.com/ups.app/xml/Rate"
$accessKey = "your_access_key"

// Set up the request XML
$requestXml = '<?xml version="1.0"?>
<AccessRequest xml:lang="en-US">
  <AccessLicenseNumber>your_access_license_number</AccessLicenseNumber>
  <UserId>your_user_id</UserId>
  <Password>your_password</Password>
</AccessRequest>
<?xml version="1.0"?>
<RatingServiceSelectionRequest xml:lang="en-US">
  <Request>
    <TransactionReference>
      <CustomerContext>Rate Request</CustomerContext>
      <XpciVersion>1.0</XpciVersion>
    </TransactionReference>
    <RequestAction>Rate</RequestAction>
    <RequestOption>Rate</RequestOption>
  </Request>
  <PickupType>
    <Code>01</Code>
  </PickupType>
  <Shipment>
    <Shipper>
      <Address>
        <PostalCode>74135</PostalCode>
        <CountryCode>US</CountryCode>
      </Address>
    </Shipper>
    <ShipTo>
      <Address>
        <PostalCode>55112</PostalCode>
        <CountryCode>US</CountryCode>
      </Address>
    </ShipTo>
    <Package>
      <PackagingType>
        <Code>02</Code>
      </PackagingType>
      <PackageWeight>
        <UnitOfMeasurement>
          <Code>LBS</Code>
        </UnitOfMeasurement>
        <Weight>10</Weight>
      </PackageWeight>
    </Package>
  </Shipment>
</RatingServiceSelectionRequest>'

// Set up the request headers
$headers = {
  "Content-Type": "application/x-www-form-urlencoded"
}

// Set up the request body
$body = "XML=" + base64.encode($requestXml)

// Send the request to the UPS API
$response = HTTP.POST.URLENCODED($url, $headers, $body)

// Check the response status
If ($response.status_code = 200)
  // Parse the response XML
  $responseXml = DOM.ParseXml($response.body)

  // Get the shipping costs from the response
  $costs = $responseXml.select.single.node("//RatedShipment")

  // Display the shipping costs
  For Each ($cost In $costs)
    Alert("Service: " + $cost.select.single.node("Service/Code").text + "\nCost: " + $cost.select.single.node("TotalCharges/MonetaryValue").text)
  End For
Else
  // Display an error message
  Alert("Request failed: " + $response.status_code + " " + $response.status_text)
End If





*/