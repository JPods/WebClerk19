//%attributes = {}

  //We will set the Window Title and the Buttons states according to the actual content and context
  // We use CALL FORM because we want to be sure that 4D has finished to update every list and objects

CALL FORM:C1391(Current form window:C827;"CF_UpdateOnContext")
