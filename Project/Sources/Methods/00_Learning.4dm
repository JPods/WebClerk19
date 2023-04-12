//%attributes = {}
//copperfield
//CONFIRM("Update costs based on costMSC")
//If (OK=1)
//var rec_o; sel_o : Object
//sel_o:=ds.Item.query("dateLastCost = :1"; !2022-12-31!)
//For each (rec_o; sel_o)
//If (rec_o.costMSC#0)
//rec_o.costLastInShip:=rec_o.costMSC
//rec_o.costAverage:=rec_o.costMSC
//rec_o.priceA:=rec_o.costMSC*2
//rec_o.priceB:=rec_o.priceA
//rec_o.priceC:=rec_o.priceA
//rec_o.priceD:=rec_o.priceA
//rec_o.save()
//End if 
//End for each 
//End if 

//https://blog.4d.com/easily-customize-the-entry-order-of-your-dynamic-forms/
// https://blog.4d.com/more-sophisticated-orda-queries-with-formulas/
// https://blog.4d.com/new-formula-more-power-behind-simplicity/
//https://blog.4d.com/how-to-create-a-dynamic-form-from-a-table-in-3-steps/
//https://blog.4d.com/project-databases-style-sheet/

//https://blog.4d.com/convert-classic-4d-forms-to-dynamic-forms/
// Work this one https://blog.4d.com/discover-the-power-of-dynamic-forms/

//2019
// manage applications build properties
// https://blog.4d.com/easily-manage-your-applications-information/
//https://blog.4d.com/orda-member-methods-to-get-the-structure-information/

// 2021
//https://blog.4d.com/a-magic-show-awaits-you-with-ordas-calculated-attributes/
//https://blog.4d.com/need-a-magic-wand-here-are-computed-class-properties/
//https://blog.4d.com/apply-naming-conventions-with-form-macros/

// 2022
//https://blog.4d.com/year-in-review-top-five-features-from-2022/

//https://blog.4d.com/form-and-subform-communication-made-easy/
//OBJECT Get subform container value
//OBJECT SET SUBFORM CONTAINER VALUE

//https://blog.4d.com/4d-language-improvements/
//return 
//break
//continue

$salary:=$employee.salary || $minSalary
$a+=5
// equals to $a:=$a+5
// +=, -=, /=, *=
$label:=($size>1000) ? "big" : "small"

//To and from the web, Record passing
//  https://blog.4d.com/orda-member-methods-to-get-the-structure-information/
//C_OBJECT($1; $inputSelection; $newEntitySelection)
//C_COLLECTION($esContent)
//$inputSelection:=$1
//ALERT(String($inputSelection.length)+" entities are going to be duplicated")
//$esContent:=$inputSelection.toCollection("address")
//$newEntitySelection:=$inputSelection.getDataClass().fromCollection($esContent)
//alert(String($newEntitySelection.length) + " entities have been created")


// SET DATABASE PARAMETER for logging errors

// setRemoteContextInfo
// Blog

//  https://www.youtube.com/watch?v=0d_a-9iNV8s

// https://4dmethod.com/2020/11/11/november-18-meeting-quickly-open-things-in-4d-development-environment-and-sync-code-between-projects-cannon-smith/

//  Data Explorer
//  https://www.youtube.com/watch?v=0d_a-9iNV8s

//https://blog.4d.com/system-worker-vs-launch-external-process/
//https://blog.4d.com/system-worker-file-transfer-class-to-use-curl-for-ftp-ftps-sftp-http
//https://blog.4d.com/system-worker-file-transfer-class-to-use-dropbox-or-gdrive/


// running a background application 
var $sw : Object
If (Is macOS:C1572)
	$sw:=4D:C1709.SystemWorker.new("ping -c 1 www.google.com")
Else 
	$sw:=4D:C1709.SystemWorker.new("ping -n 1 www.google.com")
End if 

// can pass additional attributes
If (Is macOS:C1572)
	$sw:=4D:C1709.SystemWorker.new("ping -c 1 www.google.com"; New object:C1471("onData"; Formula:C1597(MESSAGE:C88($2.data))))
Else 
	$sw:=4D:C1709.SystemWorker.new("ping -n 1 www.google.com"; New object:C1471("encoding"; "IBM437"; "onData"; Formula:C1597(MESSAGE:C88($2.data))))
End if 
// https://youtu.be/RZvj8RfosMw
// ProgressBar example at 12:00

// HOWTO:ProgressBar

//var $para : cs.cSystemWorker_callback
//$para:=cs.cSystemWorker_callback.new(Formula(ProgressCallback); 
//$sw:=cs.cSystemWorker_callback.new()
//If (Is macOS)
//$sw:=4D.SystemWorker.new("ping -c 1 www.google.com"; New object("onData"; Formula(MESSAGE($2.data))))
//Else 
//$sw:=4D.SystemWorker.new("ping -n 1 www.google.com"; New object("encoding"; "IBM437"; "onData"; Formula(MESSAGE($2.data))))
//End if 




// HOWTO:images

/*  
Just found a simple workaround: CONVERT PICTURE($img; ".bmp") 
CONVERT PICTURE($img; ".jpg") rotates a jpeg picture with TIFF 
orientation different from 1, creating a brand new correctly 
rotated image with no orientation metadata. No slower than 
a rotation with SVG or SIPS. The size (KB) of the image grows, 
but no more than with a rotation with SVG or SIPS.

https://discuss.4d.com/t/picture-rotation-4d-for-ios/20254/7
You can use PHP with the GD Library (already included in 4D) and imagerotate, which will rotate the picture on a specific angle. This is a centered rotation, image is rotated around its center. For rotating 1 picture, it’s heavy, for 4D has to load the PHP package.
I’ve distributed an example on how to use GD library in 4D along with the V17 training some years ago. It was named PictureEffects.4dbase.
You can use SVG and SVG_ROTATION_CENTERED which will do the same, with approximatively the same time.
You can use components dedicated to picture manipulations.

https://doc.4d.com/4Dv18/4D/18.4/SET-PICTURE-METADATA.301-5233427.en.html

*/

// https://blog.4d.com/new-formula-think-outside-the-box/

$object:=New object:C1471(\
"mainText"; "Are you sure you want to empty the trash?"; \
"additionalText"; "You can't undo this action."; \
"okText"; "Empty Trash"; \
"cancelText"; "Cancel"\
)
//$object.okAction:=Formula(myMethod("Trash"; "ok"))
//$object.cancelAction:=Formula(myMethod("Trash";"cancel"))
//// Define common functions
//If (Storage.ƒ=Null)
//Use (Storage)
//Storage.ƒ:=New shared object
//Use (Storage.ƒ)
//// Register the function in Storage
//Storage.ƒ.isValid:=Formula(....)
//Storage.ƒ.computeX:=Formula(....)
//End use 
//End use 
//End if 
