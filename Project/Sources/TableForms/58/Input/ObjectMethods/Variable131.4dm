C_LONGINT:C283(bContacts)
C_TEXT:C284($script)
$script:="QUERY([DocPath];[DocPath]TechNoteUniqueID="+String:C10([TechNote:58]idUnique:1)+")"
ProcessTableOpen(Table:C252(->[Document:100]); $script; "TechNotes: "+[TechNote:58]Name:2)