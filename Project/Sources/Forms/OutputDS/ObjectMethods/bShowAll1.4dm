// OutputFormAllRecords
process_o.entitySave()
process_o.ents:=ds:C1482[process_o.dataClassName].all()
entry_o:=process_o.selectChanged()