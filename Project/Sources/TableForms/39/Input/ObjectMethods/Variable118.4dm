C_TEXT:C284($googleMaps)
$googleMaps:="http://maps.google.com?hl=en&q="+[PO:39]address1:9+", "+[PO:39]city:11+", "+[PO:39]state:12+" "+[PO:39]zip:13+" "+[PO:39]country:14
Web_LaunchURL($googleMaps)