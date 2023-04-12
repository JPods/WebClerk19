//%attributes = {}
/*
password 024!1010
1  https://vimeo.com/764140617
2  https://vimeo.com/764563979
3  https://vimeo.com/764572230
4  https://vimeo.com/764589668

some objects are too complex to stringify
property is a name of the value pair is does not have a type, 
  get the type of the value by with
$myValueType:=Value type($my_o.myProperty)
if an Object:
$aClass:=OB Class($my_o.myProperty)
$bool:=OB Instance of($my_o;$aClass)
Use Object get value and Object Set Value

cannot have a pointer a property, only the main object
cannot pass retun null form a function

Collections are not objects

Object is a reference, little need for pointers any longer

Objects and Blobs are similar, 
   Object have a RefCount
   access items in a blob with {}, [] in Object. 
*/
// important to reduce memory leaks
$object:=New object:C1471("lastName"; "james")  //, creates and adds a RefCount
$object2:=$object copies the reference and
CLEAR VARIABLE:C89($object)  // decrements the RefCount but the object remains
CLEAR VARIABLE:C89($object2)  // decrements the RefCount to zero to clear the variable

/*
Never use /.\etc in property names
*/

/*
Collections are a list of items with no index
Object is a valuePair with the Property name having 
  an index on the properties (Hash table)
*/

/*
Entity selection is an Object
// unordered (bit, on disk) and ordered Entity Selection (in memory)

*/

/*
Entity selections 3 ways Part 1: 46:45
Avoid the entitySelection.toCollection()
*/


/*  
Entity is a reference to a record, not a record
$result:=entity.save()   // make this common and deal with stamp changes
reload the entity from the record to reset the 
*/


/*  
Classes
- DataClass, table
- 4D private Class (Transporter, Signal, etc...)
    1:02
- 4D built-in Class (File, EnitySelection, Document)
    4D.zzz 1:03
    Class
    CryptoKey
    Directory
    File
    Folder
    Function
    Object
    WebForm
    WebFormItem
    ZipArchive
    ZipFile
    ZipFolder
        etc....
- User defined Classes
    cs.
    .slice(0;5)  and other 

All functions operate on the server

Once we have the data on the on the local machine 
we can use "local keyword" to execute on the client
   local Function getYoungest
   exposed Function (exposed to the Rest Client

Alias 1:10
exposed Alias Sell_Name Name  // if we do not want to expose actual name of propery
exposed Products_Sold  Products_2_Lines.Quantity (invoice database example)
exposed alias Products_A_Client InvoiceLine.Invoice.Customer 
    Products_2_Lines.Lines_2_Invoices.Invoices_2_Clients (invoice database example)
    to use relations to show products sold
    optimized for actions on server

$howManySold:=$productEnity.Products_Sold
$howManyClients:= $productEnity.Products_A_Client

1:16 Class extends Entity
Get, Set, Query, and Sort of Computed attributes handled through Events

1:22  query and sort (order by) managed by value pairs
$result:=new object("query"; $queryStr;"parameters";$parameters)

1:27:30 Extending DataClasses with functions
This is important in Big Four 

1:30 Empty Class in 4D creates problems.
*/



/*  
Day 2
44:00 tool tips and flipping between array and collection listboxes to vary height
46:00 Kanban
1:05 popup data entry tools, mover class
       excellent way to manage data entry and options in DataBrowser
       Resizer and mover classes
1:12 dynamic forms dataBrowser, related items 
1:22:45 Entry form creating
1:24    tags to entry form
1:34    buttons to open related and split screens

*/


/*  
Day 3
Need to share objects
0:01
Must take great care with locking 
0:14:00 Importance of [] 
   only shared objects can be put into storage
16: passing an object as a parameters:
      copy of object if it is a normal object
      reference to the object if it is a shared object
        use a customer entity as a shared object with working between customer,
           order, proposals, etc...
16:20 Storage is a Function, Storage is more than a shared object
      Storage is usable by a Client on the Server
20:50 Shared entity selection versus entity selection. 
         Must copy Shared entity selection to add or modify
20:00 Convert an alterable selection to shared by $invoices:=$invoices.copy(ck_shared)
   
*/
//passing into a function to confirm it is not shared
var $1; $invoices : cs:C1710.InvoiceSelection
var $2 : Boolean
$invoices:=$1
$shared:=$2
If (Not:C34(shared))
	$invoices:=$invoices.copy(ck shared:K85:29)
End if 


/*  
27:20 Locking Record
31:30 Using .lock(), .save(), .unlock() must check the status
*/
var $rec_e : Object
var $result : Object

// Pessimistic locking
$rec_e:=ds:C1482.Customer(5)
$result:=$rec_e.lock()
If ($result.success)
	// make changes
	$result:=$rec_e.save()
	$result:=$rec_e.unlock()
Else 
	//resolve 
End if 

// Optimisitic locking
Repeat 
	// make changes
	$result:=$rec_e.save()
	If (Not:C34($result.success))
		$rec_e.reload()
		// not .refresh()
	End if 
Until ($result.success)


/*  
ALWAYS USE && and II
// stops the query at the first false instead of 
instead of & and | 
funtion that returns true or false
*/


/*  
dk status locked // pessimistic lock in another process, mod in a running transaction
dk status stamp has changed // stamp changes with every save
dk status wrong permission // 
dk status serious error


.unlock() or RefCount = zero

// calling .lock() more than once you will increase the lock count
40:00
Begin and end every significant modifying action with .lock() and end with .unlock()
but if the lock count is not returned to zero it can cause locked records
*/


/*  
Server optimization
43:00
Current time and current date only once
48:00
While (-- Asking the server to do something, give it time)
  IDEL
end while


50:42
*/
//bad, two calls with server passing the data twice
$sel:=ds:C1482.Customer.query("nameFirst = :1"; "a").orderBy("nameLast")
//good, one call 
$sel:=ds:C1482.Customer.query("nameFirst = :1 order by nameLast"; "a")



/*  
59:00 if data is likely to be needed, use those values so 4D will pass them
Example you may be showing the name, but address and phone may be called
so use those values in the first record so they are automatically passed by the serve
for subsequent entities


Watcher

1:08 Cache Optimization

1:20 size difference based on approach

1:21:39 
learn this findIndex() and find()

1:22 shows on to load one entity instead of 80
buttons 1 and 2 
button 3 is the fastest way

1:24:33
entity:=Form.ds[$dataClassName].get($key)
*/

// HOWTO:findIndex
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		$keyPosition:=Form:C1466.entity.findIndex(Formula:C1597($1.value.key=$2); "_KEY")
		If ($keyPosition>=0)
			$key:=Form:C1466.entity[$keyPosition].data
			$entity:=Form:C1466.mainSelection(Num:C11($key))
		End if 
End case 


/*  
1:33
keys are case sensitive can be adapted with the @
searching across field by indexing the cashe
no transfer of data
replacement for keyTags

1:35:45: HOWTO:index

1:36:24 creating the cashe in the form On Load

*/
// create for each entity
Form:C1466.cacheIndexes:=New object:C1471
For each ($DS; Form:C1466.ds)
	Form:C1466.cacheIndexes[$DS]:=New object:C1471
End for each 
// 1:37:20
// CacheAnalyzer Class


/*  
1:42:00 indexing the cache of indexed fields
1:43:00 making a cluster into a classic Blob "{}"
   creating a bit table for all the possible values of each nameFirst, each nameLast, etc...
2:03:30 setting bytes in clusters
*/



/*  
Part 4 
Adjust Table Cache Priority
8:35, affects server cache
records are removed from cashe priority based on 
the time they have been cached

accessing date in the cache is ~1,000 times faster
*/
ADJUST TABLE CACHE PRIORITY:C1429([Customer:2]; Cache priority very high:K84:5)
// 14:00 setting a table to very low, rotates their place in the 
//cache to lower their space in cache
ADJUST TABLE CACHE PRIORITY:C1429([BOM:21]; Cache priority very low:K84:1)


/*  
Encapsulation, Polymorphism, Abstraction
Encapsulation:  aka hidden data, implementation is in the class with
  only the methods exposed
  Rectangle example 

Polymorphism: same name behaves differently within different classes

Abstraction: virtual classes

Remote data components  --  similar to SycRelationships with NTK. we will not use 4D server
34:00 summary of API call to retrive just the information needed
    extending the DataStore via DataStoreImplementation
    we can set up a SyncClass behavior.

  Pull data needed into a collection or object

         Model
     /          \
Updates      Manipulates
    |             |
  View         Controller
      \          /
          User

  Many of these nodes are connected via:
     -- SyncRelation for connection
     -- SyncRecord for hard-data 
     -- collections for soft-data, temporary that does not need a history

51:40 Make SyncRelation API calls formated in ds type notation
57:28 Extending a class with Alias 
   // exposed Alias City city


Cities is the dataClassName (table)

*/


/*  
Class of Cities is an extension of Table (dataClass) Cities
Class extends DataClass


1:09:00
    ****  send a post-request json with the request for data and it returns a collection
exposed Function GetCities($params : Object)->$result : Collection

$queryString:=""
$queryValues:=New object
$queryValues.parameters:=New collection
$count:=0

If ($params.ZIP#"")
$queryString:=$queryString+"ZipCode = :1"
$queryValues.parameters.push($params.ZIP)
$count+=1
End if 
If ($params.withClients)
$queryString:=$queryString+(" && "*Num($count>0))+"ClientsListCount > :"+String($count+1)
$queryValues.parameters.push(0)
$count+=1
End if 
Case of 
: (($queryString="") & ($params.max=0))
$sel:=ds.Cities.all()

: ($queryString="")
$sel:=ds.Cities.all()

Else 
$sel:=ds.Cities.query($queryString; $queryValues)
End case 

If ($params.max>0)
$sel:=$sel.slice(0; $params.max)
End if 


$attributes:=New collection("City"; "ZipCode"; "State"; "StateFull"; "Country"; "CountryFull"; "TCC"; "ClientsListCount")

if($params.attributes=null)  in SyncRelation, map the attributes
   $params.attributes:=$attributes
end if

$result:=$sel.toCollection($attributes; dk with primary key+dk with stamp)

*/


/*  

CitiesEntity is an extension of Cities
Class extends Entity

exposed Alias TCC TelephoneCountryCode

exposed Alias ClientsList theClientsList

exposed Function FullCityInfo()->$info : Object

$attributes:=New collection("City"; "ZipCode"; "State"; "StateFull"; "Country"; "CountryFull")
$info:=This.toObject($attributes; dk with primary key)

exposed Function get ClientsListCount()->$count : Integer

$count:=This.theClientsList.length

exposed Function get Full_Address($event : Object)->$result : Text
$result:=""
If (This=Null)
$result:="No Address"
Else 
Case of 
: (This.Country="US")
$result:=This.Zip_Code+"   "+This.City\
+Char(Carriage return)+This.State+"  "+This.StateFull+Char(Carriage return)+This.CountryFull

: (This.Country="FR")
$result:=This.Zip_Code+"   "+This.City\
+Char(Carriage return)+This.CountryFull

Else 
$result:=This.City+"   "+This.Zip_Code\
+Char(Carriage return)+This.State+Char(Carriage return)+This.Country
End case 
End if 


*/


/*  
CitiesSelection is an extention of Cities
Class extends EntitySelection

exposed Function GetCities_1()->$result : Collection

$attributes:=New collection("City"; "ZipCode"; "State"; "StateFull"; "Country"; "CountryFull"; "TCC"; "ClientsListCount")

$result:=This.toCollection($attributes; dk with primary key+dk with stamp)


*/


/*  
1:04:30
Using the Cities extention to have the server execute the query and return a collection
instead of having the server return a selection that the Client must then turn into a collection

return the dk with primary + dk with stamp
*/


/*  
Do not extend the ds.Cities, or any table as the other side may change table and field names.

Extend the dataStore itself so only the functions are called and
  the dataStore extension manages the Alias


Class extends DataStoreImplementation


exposed Function GetCities($params : Object)->$result : Collection

$queryString:=""
$queryValues:=New object
$queryValues.parameters:=New collection
$count:=0

If ($params.ZIP#"")
$queryString:=$queryString+"ZipCode = :1"
$queryValues.parameters.push($params.ZIP)
$count+=1
End if 
If ($params.withClients)
$queryString:=$queryString+(" && "*Num($count>0))+"ClientsListCount > :"+String($count+1)
$queryValues.parameters.push(0)
$count+=1
End if 
Case of 
: (($queryString="") & ($params.max=0))
$sel:=ds.Cities.all()

: ($queryString="")
$sel:=ds.Cities.all()

Else 
$sel:=ds.Cities.query($queryString; $queryValues)
End case 

If ($params.max>0)
$sel:=$sel.slice(0; $params.max)
End if 

$attributes:=New collection("City"; "ZipCode"; "State"; "StateFull"; "Country"; "CountryFull"; "TCC"; "ClientsListCount")
$result:=$sel.toCollection($attributes; dk with primary key+dk with stamp)


exposed Function Cities_Move2Local($withGS : Boolean)->$result : Collection

$cities:=ds.Cities.all()
$attributes:=New collection("ID"; "City"; "ZipCode"; "State"; "StateFull"; "Country"; "CountryFull"; "TCC"; "ClientsListCount")
If ($withGS)
$attributes.push("__GlobalStamp")
End if 
$result:=New collection
For each ($city; $cities)
$record:=New object("ZIP"; $city.ZipCode)
$record.content:=$city.toObject($attributes; dk with primary key+dk with stamp)
$result.push($record)
End for each 


exposed Function Cities_CheckModifs($stamps : Collection)->$result : Collection

$result:=New collection()

$DC:=ds.Cities
If ($stamps#Null)
For each ($stamp; $stamps)
$entity:=$DC.get($stamp.ID)
If ($entity.getStamp()>$stamp.stamp)
$result.push($stamp.ID)
End if 
End for each 
End if 


exposed Function Cities_CheckGlobalStamp($stamp : Integer)->$result : Integer

$sel:=ds.Cities.all()
$result:=$sel.max("__GlobalStamp")



exposed Function Cities_GetModified($stamp : Integer)->$result : Collection

$sel:=ds.Cities.all()
$max:=$sel.max("__GlobalStamp")
If ($max>$stamp)
$sel:=ds.Cities.query("__GlobalStamp > :1"; $stamp)
$attributes:=New collection("ID"; "City"; "ZipCode"; "State"; "StateFull"; "Country"; "CountryFull"; \
"TCC"; "ClientsListCount"; "__GlobalStamp")
$result:=New collection
For each ($city; $cities)
$record:=New object("ZIP"; $city.ZipCode)
$record.content:=$city.toObject($attributes; dk with primary key+dk with stamp)
$result.push($record)
End for each 
Else 
$result:=New collection
End if 


*/


/*  
1:19:00 makes a small local table, we will use SyncRecords for this with the data object storing the collection or path

see his method of Cities_Move2Local 

We may want a separate SyncEntity table to break out the foreign data
*/


/*  
Excellent way to check for modified
  exposed Function Cities_CheckModified  make a collection, send it in a post with a query for dtchange > than stamp
       add our dtSync and idUF
       4D uses __STAMP, "_"+"_"+"STAMP"
*/


/*  
1:40 use of __GlobalStamp between 4D databases
clever way to check for

*/
