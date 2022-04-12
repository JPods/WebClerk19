//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/14/08, 18:38:08
// ----------------------------------------------------
// Method: BarcodeReturnCharImge
// Description
// 
//
// Parameters
// ----------------------------------------------------

ARRAY TEXT:C222(<>aBarCodePattern128; 103)
ARRAY LONGINT:C221(<>BarCodeAscii128; 103)

//ascii value minus 31

<>aBarCodePattern128{1}:="212222"  //SP  --  SP
<>aBarCodePattern128{2}:="222122"  //!  --  !
<>aBarCodePattern128{3}:="222221"  //"  --  "
<>aBarCodePattern128{4}:="121223"  //#  --  #
<>aBarCodePattern128{5}:="121322"  //$  --  $
<>aBarCodePattern128{6}:="131222"  //%  --  %
<>aBarCodePattern128{7}:="122213"  //&  --  &
<>aBarCodePattern128{8}:="122312"  //'  --  '
<>aBarCodePattern128{9}:="132212"  //(  --  (
<>aBarCodePattern128{10}:="221213"  //)  --)
<>aBarCodePattern128{11}:="221312"  //*  --  *
<>aBarCodePattern128{12}:="231212"  //+  --  +
<>aBarCodePattern128{13}:="112232"  //,  --  ,
<>aBarCodePattern128{14}:="122132"  //-  --  -
<>aBarCodePattern128{15}:="122231"  //.  --  .
<>aBarCodePattern128{16}:="113222"  ///  --  /
<>aBarCodePattern128{17}:="123122"  //0  --  0
<>aBarCodePattern128{18}:="123221"  //1  --  1
<>aBarCodePattern128{19}:="223211"  //2  --  2
<>aBarCodePattern128{20}:="221132"  //3  --  3
<>aBarCodePattern128{21}:="221231"  //4  --  4
<>aBarCodePattern128{22}:="213212"  //5  --  5
<>aBarCodePattern128{23}:="223112"  //6  --  6
<>aBarCodePattern128{24}:="312131"  //7  --  7
<>aBarCodePattern128{25}:="311222"  //8  --  8
<>aBarCodePattern128{26}:="321122"  //9  --  9
<>aBarCodePattern128{27}:="321221"  //:  --  :
<>aBarCodePattern128{28}:="312212"  //;  --  ;
<>aBarCodePattern128{29}:="322112"  //<  --  <
<>aBarCodePattern128{30}:="322211"  //=  --  =
<>aBarCodePattern128{31}:="212123"  //>  --  >
<>aBarCodePattern128{32}:="212321"  //?  --  ?
<>aBarCodePattern128{33}:="232121"  //@  --  @
<>aBarCodePattern128{34}:="111323"  //A  --  A
<>aBarCodePattern128{35}:="131123"  //B  --  B
<>aBarCodePattern128{36}:="131321"  //C  --  C
<>aBarCodePattern128{37}:="112313"  //D  --  D
<>aBarCodePattern128{38}:="132113"  //E  --  E
<>aBarCodePattern128{39}:="132311"  //F  --  F
<>aBarCodePattern128{40}:="211313"  //G  --  G
<>aBarCodePattern128{41}:="231113"  //H  --  H
<>aBarCodePattern128{42}:="231311"  //I  --  I
<>aBarCodePattern128{43}:="112133"  //J  --  J
<>aBarCodePattern128{44}:="112331"  //K  --  K
<>aBarCodePattern128{45}:="132131"  //L  --  L
<>aBarCodePattern128{46}:="113123"  //M  --  M
<>aBarCodePattern128{47}:="113321"  //N  --  N
<>aBarCodePattern128{48}:="133121"  //O  --  O
<>aBarCodePattern128{49}:="313121"  //P  --  P
<>aBarCodePattern128{50}:="211331"  //Q  --  Q
<>aBarCodePattern128{51}:="231131"  //R  --  R
<>aBarCodePattern128{52}:="213113"  //S  --  S
<>aBarCodePattern128{53}:="213311"  //T  --  T
<>aBarCodePattern128{54}:="213131"  //U  --  U
<>aBarCodePattern128{55}:="311123"  //V  --  V
<>aBarCodePattern128{56}:="311321"  //W  --  W
<>aBarCodePattern128{57}:="331121"  //X  --  X
<>aBarCodePattern128{58}:="312113"  //Y  --  Y
<>aBarCodePattern128{59}:="312311"  //Z  --  Z
<>aBarCodePattern128{60}:="332111"  //[  --  [
<>aBarCodePattern128{61}:="314111"  //"\ -- \"
<>aBarCodePattern128{62}:="221411"  //]  --  ]
<>aBarCodePattern128{63}:="431111"  //^  --  ^
<>aBarCodePattern128{64}:="111224"  //_  --  _
<>aBarCodePattern128{65}:="111422"  //'  --  NUL
<>aBarCodePattern128{66}:="121124"  //a  --  SOH
<>aBarCodePattern128{67}:="121421"  //b  --  STX
<>aBarCodePattern128{68}:="141122"  //c  --  ETX
<>aBarCodePattern128{69}:="141221"  //d  --  EOT
<>aBarCodePattern128{70}:="112214"  //e  --  ENQ
<>aBarCodePattern128{71}:="112412"  //f  --  ACK
<>aBarCodePattern128{72}:="122114"  //g  --  BEL
<>aBarCodePattern128{73}:="122411"  //h  --  BS
<>aBarCodePattern128{74}:="142112"  //i  --  HT
<>aBarCodePattern128{75}:="142211"  //j  --  LF
<>aBarCodePattern128{76}:="241211"  //k  --  VT
<>aBarCodePattern128{77}:="221114"  //l  --  FF
<>aBarCodePattern128{78}:="413111"  //m  --  CR
<>aBarCodePattern128{79}:="241112"  //n  --  SO
<>aBarCodePattern128{80}:="134111"  //o  --  SI
<>aBarCodePattern128{81}:="111242"  //p  --  DLE
<>aBarCodePattern128{82}:="121142"  //q  --  DC1
<>aBarCodePattern128{83}:="121241"  //r  --  DC2
<>aBarCodePattern128{84}:="114212"  //s  --  DC3
<>aBarCodePattern128{85}:="124112"  //t  --  DC4
<>aBarCodePattern128{86}:="124211"  //u  --  NAK
<>aBarCodePattern128{87}:="411212"  //v  --  SYN
<>aBarCodePattern128{88}:="421112"  //w  --  ETB
<>aBarCodePattern128{89}:="421211"  //x  --  CAN
<>aBarCodePattern128{90}:="212141"  //y  --  EM
<>aBarCodePattern128{91}:="214121"  //z  --  SUB
<>aBarCodePattern128{92}:="412121"  //{  --  ESC
<>aBarCodePattern128{93}:="111143"  //|  --  FS
<>aBarCodePattern128{94}:="111341"  //}  --  GS
<>aBarCodePattern128{95}:="131141"  //~  --  RS
<>aBarCodePattern128{96}:="114113"  //DEL  --  US
<>aBarCodePattern128{97}:="114311"  //FNC 3  --  FNC 3
<>aBarCodePattern128{98}:="411113"  //FNC 2  --  FNC 2
<>aBarCodePattern128{99}:="411311"  //SHIFT  --  SHIFT
<>aBarCodePattern128{100}:="113141"  //CODE C  --  CODE C
<>aBarCodePattern128{101}:="114131"  //FNC 4  --  CODE B
<>aBarCodePattern128{102}:="311141"  //CODE A  --  FNC 4
<>aBarCodePattern128{103}:="411131"  //FNC 1  --  FNC 1



