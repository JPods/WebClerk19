//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/28/09, 03:24:44
// ----------------------------------------------------
// Method: TIO_DecConst
// Description
//  Reason:  <>ciTInFRTkn
//
// Parameters
// ----------------------------------------------------

//TextOut Row Types: < 100 are direct types, > 100 are derived types
C_LONGINT:C283(<>ciTOutWrite)
<>ciTOutWrite:=1
C_LONGINT:C283(<>ciTOutFRTxt)
<>ciTOutFRTxt:=2
C_LONGINT:C283(<>ciTOutFRDoc)
<>ciTOutFRDoc:=3
C_LONGINT:C283(<>ciTOutBName)
<>ciTOutBName:=4
C_LONGINT:C283(<>ciTOutEName)
<>ciTOutEName:=5
C_LONGINT:C283(<>ciTOutBLoop)
<>ciTOutBLoop:=6
C_LONGINT:C283(<>ciTOutELoop)
<>ciTOutELoop:=7
C_LONGINT:C283(<>ciTOutVersn)
<>ciTOutVersn:=8
C_LONGINT:C283(<>ciTOutTxOut)
<>ciTOutTxOut:=9
C_LONGINT:C283(<>ciTOutDbug)
<>ciTOutDbug:=10
C_LONGINT:C283(<>ciTOutBlank)
<>ciTOutBlank:=11
C_LONGINT:C283(<>ciTOutFRTkn)
<>ciTOutFRTkn:=101
//
//TextIn Row Types: < 100 are direct types, > 100 are derived types
C_LONGINT:C283(<>ciTInReadNm)
<>ciTInReadNm:=1
C_LONGINT:C283(<>ciTInReadSt)
<>ciTInReadSt:=2
C_LONGINT:C283(<>ciTInRdToSt)
<>ciTInRdToSt:=3
C_LONGINT:C283(<>ciTInUnRead)
<>ciTInUnRead:=4
C_LONGINT:C283(<>ciTInPutBuf)
<>ciTInPutBuf:=5
C_LONGINT:C283(<>ciTInSetBuf)
<>ciTInSetBuf:=6
C_LONGINT:C283(<>ciTInFRTxt)
<>ciTInFRTxt:=7
C_LONGINT:C283(<>ciTInFRDoc)
<>ciTInFRDoc:=8
C_LONGINT:C283(<>ciTInBIsLst)
<>ciTInBIsLst:=9
C_LONGINT:C283(<>ciTInIsBuff)
<>ciTInIsBuff:=10
C_LONGINT:C283(<>ciTInReadEr)
<>ciTInReadEr:=11
C_LONGINT:C283(<>ciTInIsEOF)
<>ciTInIsEOF:=12
C_LONGINT:C283(<>ciTInIsOthr)
<>ciTInIsOthr:=13
C_LONGINT:C283(<>ciTInEIsLst)
<>ciTInEIsLst:=14
C_LONGINT:C283(<>ciTInBName)
<>ciTInBName:=15
C_LONGINT:C283(<>ciTInEName)
<>ciTInEName:=16
C_LONGINT:C283(<>ciTInBLoop)
<>ciTInBLoop:=17
C_LONGINT:C283(<>ciTInELoop)
<>ciTInELoop:=18
C_LONGINT:C283(<>ciTInExitLp)
<>ciTInExitLp:=19
C_LONGINT:C283(<>ciTInQuit)
<>ciTInQuit:=20
C_LONGINT:C283(<>ciTInStop)
<>ciTInStop:=21
C_LONGINT:C283(<>ciTInVersn)
<>ciTInVersn:=22
C_LONGINT:C283(<>ciTInTextIn)
<>ciTInTextIn:=23
C_LONGINT:C283(<>ciTInDebug)
<>ciTInDebug:=24
C_LONGINT:C283(<>ciTInBlank)
<>ciTInBlank:=25
C_LONGINT:C283(<>ciTInFRTkn)
<>ciTInFRTkn:=101
C_LONGINT:C283(<>ciTInBLpNoI)  //Begin Loop w/ No Iterator
<>ciTInBLpNoI:=102
//
//Generic Types for returning from TIO_ParseNumber
//### jwm ### 20131011_1736 replaced Mac OS Roman characters with Unicode
//http://en.wikipedia.org/wiki/Mac_OS_Roman
C_LONGINT:C283(<>ciTIOMarker)  //marks the begining of a string w/ wild card characters
<>ciTIOMarker:=224  //high enough that it isn't some extended char like , =A to 4D.
<>ciTIOMarker:=0x2021  //### jwm ### 20131011_1711 unicode equivalent ""
C_TEXT:C284(<>csTIOAnyChr)
<>csTIOAnyChr:="*"
C_LONGINT:C283(<>ciTIOAnyChr)  //0 or more of any char
//<>ciTIOAnyChr:=225
<>ciTIOAnyChr:=0x00B7  //### jwm ### 20131011_1711 unicode equivalent ""
C_TEXT:C284(<>csTIO1Char)
<>csTIO1Char:="?"
C_LONGINT:C283(<>ciTIO1Char)  //any single char
//<>ciTIO1Char:=226
<>ciTIO1Char:=0x201A  //### jwm ### 20131011_1711 unicode equivalent ""
C_TEXT:C284(<>csTIO1Num)
<>csTIO1Num:="1"
C_LONGINT:C283(<>ciTIO1Num)  //any single 0-9 num chars
//<>ciTIO1Num:=227
<>ciTIO1Num:=0x201E  //### jwm ### 20131011_1711 unicode equivalent ""
C_TEXT:C284(<>csTIO1Alpha)
<>csTIO1Alpha:="a"
C_LONGINT:C283(<>ciTIO1Alpha)  //any single a-z,A-Z chars
//<>ciTIO1Alpha:=228
<>ciTIO1Alpha:=0x2030  //### jwm ### 20131011_1711 unicode equivalent ""
C_TEXT:C284(<>csTIOAnyNum)
<>csTIOAnyNum:="#"
C_LONGINT:C283(<>ciTIOAnyNum)  //0 or more 0-9 num chars
//<>ciTIOAnyNum:=229
<>ciTIOAnyNum:=0x00C2  //### jwm ### 20131011_1711 unicode equivalent ""
C_TEXT:C284(<>csTIOAnyAlp)
<>csTIOAnyAlp:="@"
C_LONGINT:C283(<>ciTIOAnyAlp)  //0 or more a-z,A-Z chars
//<>ciTIOAnyAlp:=230
<>ciTIOAnyAlp:=0x00CA  //### jwm ### 20131011_1711 unicode equivalent ""
//
//Results of Text-In Parsing from TIOI_ReadFile
C_LONGINT:C283(<>ciTIOINoErr)
<>ciTIOINoErr:=1  //Text-In succeded reading a Text-In File
C_LONGINT:C283(<>ciTIOIParse)
<>ciTIOIParse:=0  //Text-In Failed while Parsing the Text-In File
C_LONGINT:C283(<>ciTIOIName)
<>ciTIOIName:=-1  //Text-In Failed while checking the File Name
C_LONGINT:C283(<>ciTIOIData)
<>ciTIOIData:=-2  //Text-In Failed while checking the File Data
C_LONGINT:C283(<>ciTIOIFile)
<>ciTIOIFile:=-3  //Text-In Failed: the input file bad or doesn't exist