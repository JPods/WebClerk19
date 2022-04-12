//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-08-27T00:00:00, 07:55:54
// ----------------------------------------------------
// Method: jsonExample
// Description
// Modified: 08/27/17
// 
// 
//
// Parameters
// ----------------------------------------------------
// If (OB Is defined($ptFieldOb->;"keytext"))

ARRAY BOOLEAN:C223(boolean_array_in; 0)
APPEND TO ARRAY:C911(boolean_array_in; True:C214)
APPEND TO ARRAY:C911(boolean_array_in; False:C215)
APPEND TO ARRAY:C911(boolean_array_in; True:C214)

ARRAY REAL:C219(real_array_in; 0)
APPEND TO ARRAY:C911(real_array_in; 1.1)
APPEND TO ARRAY:C911(real_array_in; 2.2)
APPEND TO ARRAY:C911(real_array_in; 3.3)

ARRAY TEXT:C222(text_array_in; 0)
APPEND TO ARRAY:C911(text_array_in; "monday")
APPEND TO ARRAY:C911(text_array_in; "tuesday")
APPEND TO ARRAY:C911(text_array_in; "wednesday")

ARRAY OBJECT:C1221(object_array_in; 0)  // setup the outside array of objects
C_OBJECT:C1216($empty_object)  // create a null value object

C_OBJECT:C1216($simple_object)
// $simple_object:=JSON Parse("{}")  // create a {} value object
// or
$simple_object:=New object:C1471

C_OBJECT:C1216($object_with_a_few_elements)  // create object with several value pairs
$object_with_a_few_elements:=JSON Parse:C1218("{}")
OB SET:C1220($object_with_a_few_elements; "Number"; Pi:K30:1)
OB SET:C1220($object_with_a_few_elements; "Text"; "Hello world!")
OB SET:C1220($object_with_a_few_elements; "Boolean"; True:C214)

APPEND TO ARRAY:C911(object_array_in; $empty_object)  // put into the json array the null object
APPEND TO ARRAY:C911(object_array_in; $simple_object)  // put into the json array the {} object
APPEND TO ARRAY:C911(object_array_in; $object_with_a_few_elements)  // put into the json array the object with 3 value pairs

// end of exercise #1


C_OBJECT:C1216(object)
object:=JSON Parse:C1218("{}")
OB SET ARRAY:C1227(object; "boolean_array_in"; boolean_array_in)
OB SET ARRAY:C1227(object; "real_array_in"; real_array_in)
OB SET ARRAY:C1227(object; "text_array_in"; text_array_in)
OB SET ARRAY:C1227(object; "object_array_in"; object_array_in)

C_TEXT:C284($cr)
$cr:=Char:C90(Carriage return:K15:38)

C_TEXT:C284($dump_text)
$dump_text:=""
$dump_text:=$dump_text+"JSON Stringify of complete object."
$dump_text:=$dump_text+$cr

C_TEXT:C284($json)
$dump_text:=$dump_text+JSON Stringify:C1217(object; *)+$cr+$cr  // convert the json to a string
$dump_text:=$dump_text+$cr

SET TEXT TO PASTEBOARD:C523($dump_text)

$dump_text:=$dump_text+"----------------------------------------------------------"+$cr
$dump_text:=$dump_text+"Pull each type out into a Boolean array"+$cr
$dump_text:=$dump_text+"----------------------------------------------------------"+$cr

ARRAY BOOLEAN:C223(boolean_array_out; 0)
ARRAY REAL:C219(real_array_out; 0)
ARRAY TEXT:C222(text_array_out; 0)
ARRAY OBJECT:C1221(object_array_out; 0)

OB GET ARRAY:C1229(object; "boolean_array_in"; boolean_array_out)
OB GET ARRAY:C1229(object; "boolean_array_in"; real_array_out)
OB GET ARRAY:C1229(object; "boolean_array_in"; text_array_out)
OB GET ARRAY:C1229(object; "boolean_array_in"; object_array_out)

$dump_text:=$dump_text+"Source array boolean_array_in"+$cr
$dump_text:=$dump_text+JSON Stringify array:C1228(boolean_array_in)+$cr+$cr

$dump_text:=$dump_text+"Output array boolean_array_out"+$cr
$dump_text:=$dump_text+JSON Stringify array:C1228(boolean_array_out)+$cr+$cr

$dump_text:=$dump_text+"Output array real_array_out"+$cr
$dump_text:=$dump_text+JSON Stringify array:C1228(real_array_out)+$cr+$cr

$dump_text:=$dump_text+"Output array text_array_out"+$cr
$dump_text:=$dump_text+JSON Stringify array:C1228(text_array_out)+$cr+$cr

$dump_text:=$dump_text+"Output array object_array_out"+$cr
$dump_text:=$dump_text+JSON Stringify array:C1228(object_array_out)+$cr+$cr

$dump_text:=$dump_text+"----------------------------------------------------------"+$cr
$dump_text:=$dump_text+"Pull each type out into a Real array"+$cr
$dump_text:=$dump_text+"----------------------------------------------------------"+$cr

ARRAY BOOLEAN:C223(boolean_array_out; 0)
ARRAY REAL:C219(real_array_out; 0)
ARRAY TEXT:C222(text_array_out; 0)
ARRAY OBJECT:C1221(object_array_out; 0)

OB GET ARRAY:C1229(object; "real_array_in"; boolean_array_out)
OB GET ARRAY:C1229(object; "real_array_in"; real_array_out)
OB GET ARRAY:C1229(object; "real_array_in"; text_array_out)
OB GET ARRAY:C1229(object; "real_array_in"; object_array_out)

$dump_text:=$dump_text+"Source array real_array_in"+$cr
$dump_text:=$dump_text+JSON Stringify array:C1228(real_array_in)+$cr+$cr

$dump_text:=$dump_text+"Output array boolean_array_out"+$cr
$dump_text:=$dump_text+JSON Stringify array:C1228(boolean_array_out)+$cr+$cr

$dump_text:=$dump_text+"Output array real_array_out"+$cr
$dump_text:=$dump_text+JSON Stringify array:C1228(real_array_out)+$cr+$cr

$dump_text:=$dump_text+"Output array text_array_out"+$cr
$dump_text:=$dump_text+JSON Stringify array:C1228(text_array_out)+$cr+$cr

$dump_text:=$dump_text+"Output array object_array_out"+$cr
$dump_text:=$dump_text+JSON Stringify array:C1228(object_array_out)+$cr+$cr

$dump_text:=$dump_text+"----------------------------------------------------------"+$cr
$dump_text:=$dump_text+"Pull each type out into a Text array"+$cr
$dump_text:=$dump_text+"----------------------------------------------------------"+$cr

ARRAY BOOLEAN:C223(boolean_array_out; 0)
ARRAY REAL:C219(real_array_out; 0)
ARRAY TEXT:C222(text_array_out; 0)
ARRAY OBJECT:C1221(object_array_out; 0)

OB GET ARRAY:C1229(object; "text_array_in"; boolean_array_out)
OB GET ARRAY:C1229(object; "text_array_in"; real_array_out)
OB GET ARRAY:C1229(object; "text_array_in"; text_array_out)
OB GET ARRAY:C1229(object; "text_array_in"; object_array_out)

$dump_text:=$dump_text+"Source array text_array_in"+$cr
$dump_text:=$dump_text+JSON Stringify array:C1228(text_array_in)+$cr+$cr

$dump_text:=$dump_text+"Output array boolean_array_out"+$cr
$dump_text:=$dump_text+JSON Stringify array:C1228(boolean_array_out)+$cr+$cr

$dump_text:=$dump_text+"Output array real_array_out"+$cr
$dump_text:=$dump_text+JSON Stringify array:C1228(real_array_out)+$cr+$cr

$dump_text:=$dump_text+"Output array text_array_out"+$cr
$dump_text:=$dump_text+JSON Stringify array:C1228(text_array_out)+$cr+$cr

$dump_text:=$dump_text+"Output array object_array_out"+$cr
$dump_text:=$dump_text+JSON Stringify array:C1228(object_array_out)+$cr+$cr

$dump_text:=$dump_text+"----------------------------------------------------------"+$cr
$dump_text:=$dump_text+"Pull each type out into a Object array"+$cr
$dump_text:=$dump_text+"----------------------------------------------------------"+$cr

ARRAY BOOLEAN:C223(boolean_array_out; 0)
ARRAY REAL:C219(real_array_out; 0)
ARRAY TEXT:C222(text_array_out; 0)
ARRAY OBJECT:C1221(object_array_out; 0)

OB GET ARRAY:C1229(object; "object_array_in"; boolean_array_out)
OB GET ARRAY:C1229(object; "object_array_in"; real_array_out)
OB GET ARRAY:C1229(object; "object_array_in"; text_array_out)
OB GET ARRAY:C1229(object; "object_array_in"; object_array_out)

$dump_text:=$dump_text+"Source array object_array_in"+$cr
$dump_text:=$dump_text+JSON Stringify array:C1228(object_array_in)+$cr+$cr

$dump_text:=$dump_text+"Output array boolean_array_out"+$cr
$dump_text:=$dump_text+JSON Stringify array:C1228(boolean_array_out)+$cr+$cr

$dump_text:=$dump_text+"Output array real_array_out"+$cr
$dump_text:=$dump_text+JSON Stringify array:C1228(real_array_out)+$cr+$cr

$dump_text:=$dump_text+"Output array text_array_out"+$cr
$dump_text:=$dump_text+JSON Stringify array:C1228(text_array_out)+$cr+$cr

$dump_text:=$dump_text+"Output array object_array_out"+$cr
$dump_text:=$dump_text+JSON Stringify array:C1228(object_array_out)+$cr+$cr

SET TEXT TO PASTEBOARD:C523($dump_text)