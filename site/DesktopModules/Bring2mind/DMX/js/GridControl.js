function onCallbackError(e){confirm("Invalid data has been entered. View details?")&&alert(e)}function onDelete(e){return!!confirm("Delete record?")}function editRow(e,t){e.edit(e.getItemFromClientId(t))}function updateRow(e){e.EditingDirty=!0,e.editComplete()}function addRow(e){var t=e.Table.addEmptyRow();t.SetValue(0,-1,!0),t.SetValue(1,t.Index,!0),e.edit(t)}function deleteRow(e,t){e.deleteItem(e.getItemFromClientId(t))}function moveUpRow(e,t){var a=e.getItemFromClientId(t),n=a.Index;if(n>0){var o=a.GetMember("ViewOrder").Value,r=e.Table.GetRow(a.Index-1);a.SetValue(1,r.GetMember("ViewOrder").Value),r.SetValue(1,o),moveItem(e,n,!0)}}function moveDownRow(e,t){var a=e.getItemFromClientId(t),n=a.Index;if(n<e.Table.getRowCount()-1){var o=a.GetMember("ViewOrder").Value,r=e.Table.GetRow(a.Index+1);a.SetValue(1,r.GetMember("ViewOrder").Value),r.SetValue(1,o),moveItem(e,n,!1)}}function moveItem(e,t,a){var n=e.get_table(),o=a?t-1:t+1;if(o>=0&&o<n.getRowCount()){var r=n.Data[o];n.Data[o]=n.Data[t],n.Data[t]=r,e.render()}}