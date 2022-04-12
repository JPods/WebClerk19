//%attributes = {"publishedWeb":true}
//Procedure: TIOI_IsStackPsh
//push element to Is List stack will be set latter
INSERT IN ARRAY:C227(aTIOIsStack; iTIOIsStkHd)
aTIOIsStack{iTIOIsStkHd}:=-1  //invalid index of last Is Command
iTIOIsStkHd:=iTIOIsStkHd+1  //next elem availiable