C_OBJECT:C1216($sel)
// https://doc.4d.com/4Dv19/4D/19.1/entitySelectionminus.305-5652746.en.html
process_o.entitySave()
process_o.ents:=process_o.ents.minus(process_o.sel)
entry_o:=process_o.selectChanged()