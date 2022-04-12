C_TEXT:C284($googleMaps)
$googleMaps:="http://maps.google.com?hl=en&q="+[Invoice:26]address1:8+", "+[Invoice:26]city:10+", "+[Invoice:26]state:11+" "+[Invoice:26]zip:12+" "+[Invoice:26]country:13
Web_LaunchURL($googleMaps)