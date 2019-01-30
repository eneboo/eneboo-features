

/** @class_declaration ctdPdteServir */
//////////////////////////////////////////////////////////////
//// CANTIDAD PENDIENTE SERVIR ///////////////////////////////

class ctdPdteServir extends totalStocksDocs /** %from: oficial */
{
  function ctdPdteServir(context)
  {
    totalStocksDocs(context);
  }
  function validateForm()
  {
    return this.ctx.ctdPdteServir_validateForm();
  }

}

//// CANTIDAD PENDIENTE SERVIR ///////////////////////////////
//////////////////////////////////////////////////////////////







/** @class_definition ctdPdteServir */
//////////////////////////////////////////////////////////////
//// CANTIDAD PENDIENTE SERVIR ///////////////////////////////


function ctdPdteServir_validateForm()
{

//debug(">>>>>>>>>>>SIAGAL lineaspedidoscli.qs   ctdPdteServir_validateForm ");
  var _i = this.iface;
  if (!_i.__validateForm())
    return false;

  var cursor = this.cursor();

  cantidad =  parseFloat(cursor.valueBuffer("cantidad"));
	if (isNaN(cantidad))
		cantidad = 0;
    
  totalEnAlbaran =  parseFloat(cursor.valueBuffer("totalenalbaran"));
	if (isNaN(totalEnAlbaran))
		totalEnAlbaran = 0;
  

	cursor.setValueBuffer("totalpendiente", cantidad - totalEnAlbaran);
 
  return true;
}


//// CANTIDAD PENDIENTE SERVIR ///////////////////////////////
////////////////////////////////////////////////////////////// 
