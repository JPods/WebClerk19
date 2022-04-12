//%attributes = {}
//BarcodeInitArray
//James W Medlen
//06/24/2008

//myDoc:=Open document("Macintosh HD:Users:jmedlen:Desktop:Bar.gif";"GIFf")
//FileName:=Document
//CLOSE DOCUMENT(myDoc)
//DOCUMENT TO BLOB(Document;myBlob)
//BLOB TO PICTURE(myBlob;vgBar)

//myDoc:=Open document("Macintosh HD:Users:jmedlen:Desktop:Space.gif";"GIFf")
//FileName:=Document
//CLOSE DOCUMENT(myDoc)
//DOCUMENT TO BLOB(Document;myBlob)
//BLOB TO PICTURE(myBlob;vgSpace)

C_PICTURE:C286(vgBarcode; vgBar; vgSpace)

GET PICTURE FROM LIBRARY:C565("BarCodeBar"; vgBar)
GET PICTURE FROM LIBRARY:C565("BarCodeSpace"; vgSpace)

ARRAY PICTURE:C279(<>agBarcode; 107)
//ARRAY PICTURE(<>agBarcode4180;40)
//ARRAY PICTURE(<>agBarcode81107;107)

<>agBarcode{0}:=(vgBar*+2)+(vgSpace*+1)+(vgBar*+2)+(vgSpace*+2)+(vgBar*+2)+(vgSpace*+2)
<>agBarcode{1}:=(vgBar*+2)+(vgSpace*+2)+(vgBar*+2)+(vgSpace*+1)+(vgBar*+2)+(vgSpace*+2)
<>agBarcode{2}:=(vgBar*+2)+(vgSpace*+2)+(vgBar*+2)+(vgSpace*+2)+(vgBar*+2)+(vgSpace*+1)
<>agBarcode{3}:=(vgBar*+1)+(vgSpace*+2)+(vgBar*+1)+(vgSpace*+2)+(vgBar*+2)+(vgSpace*+3)
<>agBarcode{4}:=(vgBar*+1)+(vgSpace*+2)+(vgBar*+1)+(vgSpace*+3)+(vgBar*+2)+(vgSpace*+2)
<>agBarcode{5}:=(vgBar*+1)+(vgSpace*+3)+(vgBar*+1)+(vgSpace*+2)+(vgBar*+2)+(vgSpace*+2)
<>agBarcode{6}:=(vgBar*+1)+(vgSpace*+2)+(vgBar*+2)+(vgSpace*+2)+(vgBar*+1)+(vgSpace*+3)
<>agBarcode{7}:=(vgBar*+1)+(vgSpace*+2)+(vgBar*+2)+(vgSpace*+3)+(vgBar*+1)+(vgSpace*+2)
<>agBarcode{8}:=(vgBar*+1)+(vgSpace*+3)+(vgBar*+2)+(vgSpace*+2)+(vgBar*+1)+(vgSpace*+2)
<>agBarcode{9}:=(vgBar*+2)+(vgSpace*+2)+(vgBar*+1)+(vgSpace*+2)+(vgBar*+1)+(vgSpace*+3)

<>agBarcode{10}:=(vgBar*+2)+(vgSpace*+2)+(vgBar*+1)+(vgSpace*+3)+(vgBar*+1)+(vgSpace*+2)
<>agBarcode{11}:=(vgBar*+2)+(vgSpace*+3)+(vgBar*+1)+(vgSpace*+2)+(vgBar*+1)+(vgSpace*+2)
<>agBarcode{12}:=(vgBar*+1)+(vgSpace*+1)+(vgBar*+2)+(vgSpace*+2)+(vgBar*+3)+(vgSpace*+2)
<>agBarcode{13}:=(vgBar*+1)+(vgSpace*+2)+(vgBar*+2)+(vgSpace*+1)+(vgBar*+3)+(vgSpace*+2)
<>agBarcode{14}:=(vgBar*+1)+(vgSpace*+2)+(vgBar*+2)+(vgSpace*+2)+(vgBar*+3)+(vgSpace*+1)
<>agBarcode{15}:=(vgBar*+1)+(vgSpace*+1)+(vgBar*+3)+(vgSpace*+2)+(vgBar*+2)+(vgSpace*+2)
<>agBarcode{16}:=(vgBar*+1)+(vgSpace*+2)+(vgBar*+3)+(vgSpace*+1)+(vgBar*+2)+(vgSpace*+2)
<>agBarcode{17}:=(vgBar*+1)+(vgSpace*+2)+(vgBar*+3)+(vgSpace*+2)+(vgBar*+2)+(vgSpace*+1)
<>agBarcode{18}:=(vgBar*+2)+(vgSpace*+2)+(vgBar*+3)+(vgSpace*+2)+(vgBar*+1)+(vgSpace*+1)
<>agBarcode{19}:=(vgBar*+2)+(vgSpace*+2)+(vgBar*+1)+(vgSpace*+1)+(vgBar*+3)+(vgSpace*+2)

<>agBarcode{20}:=(vgBar*+2)+(vgSpace*+2)+(vgBar*+1)+(vgSpace*+2)+(vgBar*+3)+(vgSpace*+1)
<>agBarcode{21}:=(vgBar*+2)+(vgSpace*+1)+(vgBar*+3)+(vgSpace*+2)+(vgBar*+1)+(vgSpace*+2)
<>agBarcode{22}:=(vgBar*+2)+(vgSpace*+2)+(vgBar*+3)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+2)
<>agBarcode{23}:=(vgBar*+3)+(vgSpace*+1)+(vgBar*+2)+(vgSpace*+1)+(vgBar*+3)+(vgSpace*+1)
<>agBarcode{24}:=(vgBar*+3)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+2)+(vgBar*+2)+(vgSpace*+2)
<>agBarcode{25}:=(vgBar*+3)+(vgSpace*+2)+(vgBar*+1)+(vgSpace*+1)+(vgBar*+2)+(vgSpace*+2)
<>agBarcode{26}:=(vgBar*+3)+(vgSpace*+2)+(vgBar*+1)+(vgSpace*+2)+(vgBar*+2)+(vgSpace*+1)
<>agBarcode{27}:=(vgBar*+3)+(vgSpace*+1)+(vgBar*+2)+(vgSpace*+2)+(vgBar*+1)+(vgSpace*+2)
<>agBarcode{28}:=(vgBar*+3)+(vgSpace*+2)+(vgBar*+2)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+2)
<>agBarcode{29}:=(vgBar*+3)+(vgSpace*+2)+(vgBar*+2)+(vgSpace*+2)+(vgBar*+1)+(vgSpace*+1)

<>agBarcode{30}:=(vgBar*+2)+(vgSpace*+1)+(vgBar*+2)+(vgSpace*+1)+(vgBar*+2)+(vgSpace*+3)
<>agBarcode{31}:=(vgBar*+2)+(vgSpace*+1)+(vgBar*+2)+(vgSpace*+3)+(vgBar*+2)+(vgSpace*+1)
<>agBarcode{32}:=(vgBar*+2)+(vgSpace*+3)+(vgBar*+2)+(vgSpace*+1)+(vgBar*+2)+(vgSpace*+1)
<>agBarcode{33}:=(vgBar*+1)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+3)+(vgBar*+2)+(vgSpace*+3)
<>agBarcode{34}:=(vgBar*+1)+(vgSpace*+3)+(vgBar*+1)+(vgSpace*+1)+(vgBar*+2)+(vgSpace*+3)
<>agBarcode{35}:=(vgBar*+1)+(vgSpace*+3)+(vgBar*+1)+(vgSpace*+3)+(vgBar*+2)+(vgSpace*+1)
<>agBarcode{36}:=(vgBar*+1)+(vgSpace*+1)+(vgBar*+2)+(vgSpace*+3)+(vgBar*+1)+(vgSpace*+3)
<>agBarcode{37}:=(vgBar*+1)+(vgSpace*+3)+(vgBar*+2)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+3)
<>agBarcode{38}:=(vgBar*+1)+(vgSpace*+3)+(vgBar*+2)+(vgSpace*+3)+(vgBar*+1)+(vgSpace*+1)
<>agBarcode{39}:=(vgBar*+2)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+3)+(vgBar*+1)+(vgSpace*+3)

<>agBarcode{40}:=(vgBar*+2)+(vgSpace*+3)+(vgBar*+1)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+3)
<>agBarcode{41}:=(vgBar*+2)+(vgSpace*+3)+(vgBar*+1)+(vgSpace*+3)+(vgBar*+1)+(vgSpace*+1)
<>agBarcode{42}:=(vgBar*+1)+(vgSpace*+1)+(vgBar*+2)+(vgSpace*+1)+(vgBar*+3)+(vgSpace*+3)
<>agBarcode{43}:=(vgBar*+1)+(vgSpace*+1)+(vgBar*+2)+(vgSpace*+3)+(vgBar*+3)+(vgSpace*+1)
<>agBarcode{44}:=(vgBar*+1)+(vgSpace*+3)+(vgBar*+2)+(vgSpace*+1)+(vgBar*+3)+(vgSpace*+1)
<>agBarcode{45}:=(vgBar*+1)+(vgSpace*+1)+(vgBar*+3)+(vgSpace*+1)+(vgBar*+2)+(vgSpace*+3)
<>agBarcode{46}:=(vgBar*+1)+(vgSpace*+1)+(vgBar*+3)+(vgSpace*+3)+(vgBar*+2)+(vgSpace*+1)
<>agBarcode{47}:=(vgBar*+1)+(vgSpace*+3)+(vgBar*+3)+(vgSpace*+1)+(vgBar*+2)+(vgSpace*+1)
<>agBarcode{48}:=(vgBar*+3)+(vgSpace*+1)+(vgBar*+3)+(vgSpace*+1)+(vgBar*+2)+(vgSpace*+1)
<>agBarcode{49}:=(vgBar*+2)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+3)+(vgBar*+3)+(vgSpace*+1)

<>agBarcode{50}:=(vgBar*+2)+(vgSpace*+3)+(vgBar*+1)+(vgSpace*+1)+(vgBar*+3)+(vgSpace*+1)
<>agBarcode{51}:=(vgBar*+2)+(vgSpace*+1)+(vgBar*+3)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+3)
<>agBarcode{52}:=(vgBar*+2)+(vgSpace*+1)+(vgBar*+3)+(vgSpace*+3)+(vgBar*+1)+(vgSpace*+1)
<>agBarcode{53}:=(vgBar*+2)+(vgSpace*+1)+(vgBar*+3)+(vgSpace*+1)+(vgBar*+3)+(vgSpace*+1)
<>agBarcode{54}:=(vgBar*+3)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+1)+(vgBar*+2)+(vgSpace*+3)
<>agBarcode{55}:=(vgBar*+3)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+3)+(vgBar*+2)+(vgSpace*+1)
<>agBarcode{56}:=(vgBar*+3)+(vgSpace*+3)+(vgBar*+1)+(vgSpace*+1)+(vgBar*+2)+(vgSpace*+1)
<>agBarcode{57}:=(vgBar*+3)+(vgSpace*+1)+(vgBar*+2)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+3)
<>agBarcode{58}:=(vgBar*+3)+(vgSpace*+1)+(vgBar*+2)+(vgSpace*+3)+(vgBar*+1)+(vgSpace*+1)
<>agBarcode{59}:=(vgBar*+3)+(vgSpace*+3)+(vgBar*+2)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+1)

<>agBarcode{60}:=(vgBar*+3)+(vgSpace*+1)+(vgBar*+4)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+1)
<>agBarcode{61}:=(vgBar*+2)+(vgSpace*+2)+(vgBar*+1)+(vgSpace*+4)+(vgBar*+1)+(vgSpace*+1)
<>agBarcode{62}:=(vgBar*+4)+(vgSpace*+3)+(vgBar*+1)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+1)
<>agBarcode{63}:=(vgBar*+1)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+2)+(vgBar*+2)+(vgSpace*+4)
<>agBarcode{64}:=(vgBar*+1)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+4)+(vgBar*+2)+(vgSpace*+2)
<>agBarcode{65}:=(vgBar*+1)+(vgSpace*+2)+(vgBar*+1)+(vgSpace*+1)+(vgBar*+2)+(vgSpace*+4)
<>agBarcode{66}:=(vgBar*+1)+(vgSpace*+2)+(vgBar*+1)+(vgSpace*+4)+(vgBar*+2)+(vgSpace*+1)
<>agBarcode{67}:=(vgBar*+1)+(vgSpace*+4)+(vgBar*+1)+(vgSpace*+1)+(vgBar*+2)+(vgSpace*+2)
<>agBarcode{68}:=(vgBar*+1)+(vgSpace*+4)+(vgBar*+1)+(vgSpace*+2)+(vgBar*+2)+(vgSpace*+1)
<>agBarcode{69}:=(vgBar*+1)+(vgSpace*+1)+(vgBar*+2)+(vgSpace*+2)+(vgBar*+1)+(vgSpace*+4)

<>agBarcode{70}:=(vgBar*+1)+(vgSpace*+1)+(vgBar*+2)+(vgSpace*+4)+(vgBar*+1)+(vgSpace*+2)
<>agBarcode{71}:=(vgBar*+1)+(vgSpace*+2)+(vgBar*+2)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+4)
<>agBarcode{72}:=(vgBar*+1)+(vgSpace*+2)+(vgBar*+2)+(vgSpace*+4)+(vgBar*+1)+(vgSpace*+1)
<>agBarcode{73}:=(vgBar*+1)+(vgSpace*+4)+(vgBar*+2)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+2)
<>agBarcode{74}:=(vgBar*+1)+(vgSpace*+4)+(vgBar*+2)+(vgSpace*+2)+(vgBar*+1)+(vgSpace*+1)
<>agBarcode{75}:=(vgBar*+2)+(vgSpace*+4)+(vgBar*+1)+(vgSpace*+2)+(vgBar*+1)+(vgSpace*+1)
<>agBarcode{76}:=(vgBar*+2)+(vgSpace*+2)+(vgBar*+1)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+4)
<>agBarcode{77}:=(vgBar*+4)+(vgSpace*+1)+(vgBar*+3)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+1)
<>agBarcode{78}:=(vgBar*+2)+(vgSpace*+4)+(vgBar*+1)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+2)
<>agBarcode{79}:=(vgBar*+1)+(vgSpace*+3)+(vgBar*+4)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+1)

<>agBarcode{80}:=(vgBar*+1)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+2)+(vgBar*+4)+(vgSpace*+2)
<>agBarcode{81}:=(vgBar*+1)+(vgSpace*+2)+(vgBar*+1)+(vgSpace*+1)+(vgBar*+4)+(vgSpace*+2)
<>agBarcode{82}:=(vgBar*+1)+(vgSpace*+2)+(vgBar*+1)+(vgSpace*+2)+(vgBar*+4)+(vgSpace*+1)
<>agBarcode{83}:=(vgBar*+1)+(vgSpace*+1)+(vgBar*+4)+(vgSpace*+2)+(vgBar*+1)+(vgSpace*+2)
<>agBarcode{84}:=(vgBar*+1)+(vgSpace*+2)+(vgBar*+4)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+2)
<>agBarcode{85}:=(vgBar*+1)+(vgSpace*+2)+(vgBar*+4)+(vgSpace*+2)+(vgBar*+1)+(vgSpace*+1)
<>agBarcode{86}:=(vgBar*+4)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+2)+(vgBar*+1)+(vgSpace*+2)
<>agBarcode{87}:=(vgBar*+4)+(vgSpace*+2)+(vgBar*+1)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+2)
<>agBarcode{88}:=(vgBar*+4)+(vgSpace*+2)+(vgBar*+1)+(vgSpace*+2)+(vgBar*+1)+(vgSpace*+1)
<>agBarcode{89}:=(vgBar*+2)+(vgSpace*+1)+(vgBar*+2)+(vgSpace*+1)+(vgBar*+4)+(vgSpace*+1)

<>agBarcode{90}:=(vgBar*+2)+(vgSpace*+1)+(vgBar*+4)+(vgSpace*+1)+(vgBar*+2)+(vgSpace*+1)
<>agBarcode{91}:=(vgBar*+4)+(vgSpace*+1)+(vgBar*+2)+(vgSpace*+1)+(vgBar*+2)+(vgSpace*+1)
<>agBarcode{92}:=(vgBar*+1)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+1)+(vgBar*+4)+(vgSpace*+3)
<>agBarcode{93}:=(vgBar*+1)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+3)+(vgBar*+4)+(vgSpace*+1)
<>agBarcode{94}:=(vgBar*+1)+(vgSpace*+3)+(vgBar*+1)+(vgSpace*+1)+(vgBar*+4)+(vgSpace*+1)
<>agBarcode{95}:=(vgBar*+1)+(vgSpace*+1)+(vgBar*+4)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+3)
<>agBarcode{96}:=(vgBar*+1)+(vgSpace*+1)+(vgBar*+4)+(vgSpace*+3)+(vgBar*+1)+(vgSpace*+1)
<>agBarcode{97}:=(vgBar*+4)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+3)
<>agBarcode{98}:=(vgBar*+4)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+3)+(vgBar*+1)+(vgSpace*+1)
<>agBarcode{99}:=(vgBar*+1)+(vgSpace*+1)+(vgBar*+3)+(vgSpace*+1)+(vgBar*+4)+(vgSpace*+1)

<>agBarcode{100}:=(vgBar*+1)+(vgSpace*+1)+(vgBar*+4)+(vgSpace*+1)+(vgBar*+3)+(vgSpace*+1)
<>agBarcode{101}:=(vgBar*+3)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+1)+(vgBar*+4)+(vgSpace*+1)  //Code A
<>agBarcode{102}:=(vgBar*+4)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+1)+(vgBar*+3)+(vgSpace*+1)  // FNC1
<>agBarcode{103}:=(vgBar*+2)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+4)+(vgBar*+1)+(vgSpace*+2)  //StartA
<>agBarcode{104}:=(vgBar*+2)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+2)+(vgBar*+1)+(vgSpace*+4)  //StartB
<>agBarcode{105}:=(vgBar*+2)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+2)+(vgBar*+3)+(vgSpace*+2)  //StartC
<>agBarcode{106}:=(vgBar*+2)+(vgSpace*+3)+(vgBar*+3)+(vgSpace*+1)+(vgBar*+1)+(vgSpace*+1)+(vgBar*+2)  //Stop
<>agBarcode{107}:=(vgSpace*+9)  //Padding

//vgBarcode:=<>agBarcode{104}+<>agBarcode{40}+<>agBarcode{69}+<>agBarcode{76}+<>agBarcode{76}+<>agBarcode{79}+<>agBarcode{76}+<>agBarcode{106}
//vgBarcode := <>agBarcode{104}

//myDoc:=create document("Macintosh HD:Users:jmedlen:Desktop:Test.gif")
//If (OK=1)
//FileName:=Document
//CLOSE DOCUMENT(myDoc)
//End if cod

//PICTURE TO GIF(vgBarcode;myBlob)
//BLOB TO DOCUMENT(Document;myBlob)
//SET DOCUMENT TYPE(Document;"GIFf")

//SET PICTURE TO CLIPBOARD(vgBarcode)