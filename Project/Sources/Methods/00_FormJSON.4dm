//%attributes = {}


// HOWTO:FormEvents
//https://blog.4d.com/expanding-the-abilities-of-the-form-event-command/
If (FORM Event:C1606.code=On Clicked:K2:4)
	Case of 
		: (FORM Event:C1606.objectName="Save_button")
			
		: (FORM Event:C1606.objectName="Add_button")
			
		: (FORM Event:C1606.objectName="Remove_button")
			
	End case 
End if 

//https://developer.4d.com/docs/FormEditor/forms
// look at form in TableForms and Forms
//{
//"windowTitle" : "Hello World", 
//"windowMinWidth" : 220,
//"windowMinHeight" : 80,
//"method" : "HWexample", 
//"pages" : [
//null,
//{
//"objects" : {
//"text" : {
//"type" : "text", 
//"text" : "Hello World!", 
//"textAlign" : "center", 
//"left" : 50,
//"top" : 120,
//"width" : 120,
//"height" : 80
//}, 
//"image" : {
//"type" : "picture", 
//"pictureFormat" : "scaled", 
//"picture" : "/RESOURCES/Images/HW.png", 
//"alignment" : "center", 
//"left" : 70,
//"top" : 20,
//"width" : 75,
//"height" : 75
//}, 
//"button" : {
//"type" : "button", 
//"text" : "OK", 
//"action" : "Cancel", 
//"left" : 60,
//"top" : 160,


//"width" : 100,
//"height" : 20
//}
//}
//}
//]
//}