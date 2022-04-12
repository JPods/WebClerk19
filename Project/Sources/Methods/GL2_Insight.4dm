//%attributes = {"publishedWeb":true}

//// Modified by: Bill James (2022-01-13T06:00:00Z)
//// Method: GL2_Insight
//// Description 
//// Parameters
//// ----------------------------------------------------



//KeyModifierCurrent
//If ((OptKey=1) & (CmdKey=0) & (CtlKey=0) & (ShftKey=1))
////Noah 980727  
////kept for safety,  should delete after new code verified.  
//GL_Post(->[SalesJournal]; False; 1)
//GL_Post(->[CashJournal]; False; 1)
//GL_Post(->[PurchaseJournal]; False; 1)
//Else 
////Noah 980727  
////eventually delete above code and leave this  
//GL_PostInsight(->[SalesJournal])
//GL_PostInsight(->[CashJournal])
//If (Not(GL_PJrInsightDf))
//GL_PostInsight(->[PurchaseJournal])
//End if 
//End if 