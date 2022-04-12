//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-05-06T00:00:00, 14:07:47
// ----------------------------------------------------
// Method: SQLDropConstraint
// Description
// Modified: 05/06/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

If (False:C215)  // this is just a guess at an example of dropping Uniqueness
	If (False:C215)  //  http://doc.4d.com/4Dv13/4D/13.4/ALTER-TABLE.300-1225629.en.html
		Begin SQL
			
			Select * FROM Maps;
			Alter table Maps MODIFY Maps.UniqueID  DISABLE AUTO_INCREMENT; 
			
			ALTER TABLE Maps ADD CONSTRAINT myUniqueConstraint UNIQUE(UniqueID);
			
			ALTER TABLE Maps DROP CONSTRAINT myUniqueConstraint;
			
			ALTER TABLE Maps DROP CONSTRAINT (UniqueID);
			
		End SQL
	End if 
End if 

