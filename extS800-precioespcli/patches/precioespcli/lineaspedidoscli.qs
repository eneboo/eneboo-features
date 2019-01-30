
/** @class_declaration precioEspCli */
//////////////////////////////////////////////////////////////////
//// PRECIOESPCLI ////////////////////////////////////////////////
class precioEspCli extends oficial /** %from: oficial */ 
{
    //var referenciaEsp:String;
    function precioEspCli( context ) 
    { 
		oficial ( context ); 
	}
    function commonCalculateField(fN:String, cursor:FLSqlCursor):String 
    {
        return this.ctx.precioEspCli_commonCalculateField(fN, cursor);
    }
}

//// PRECIOESPCLI ////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition precioEspCli */
//////////////////////////////////////////////////////////////////
//// PRECIOESPCLI ////////////////////////////////////////////////
function precioEspCli_commonCalculateField(fN, cursor)
{
	//debug("SIAGAL >>>>>>>>>>> lineaspedidoscli.qs   precioEspCli_commonCalculateField");
	var util:FLUtil = new FLUtil();
	var valor:String;
		
	switch (fN) {
		case "pvpunitario":{
			
			var datosTP: Array = this.iface.datosTablaPadre(cursor);
			var codCliente: String;
			var referencia: String = cursor.valueBuffer("referencia");
	
			if (cursor.cursorRelation() && cursor.cursorRelation().table() == datosTP.tabla) {
				codCliente = cursor.cursorRelation().valueBuffer("codcliente");
			} else {
				codCliente = util.sqlSelect(datosTP.tabla, "codcliente", datosTP.where);
			}
			
			valor = util.sqlSelect("articulosclientes", "pvp", "referencia = '" + referencia + "' AND codcliente = '" + codCliente + "'");
			debug("SIAGAL >>>>>>>>>>> lineaspedidoscli.qs   precioEspCli_commonCalculateField Precio especial nivel Articulo("+ referencia +") - Cliente (" + codCliente + ") = ("+ valor +")");
			
			if (valor) {
				//debug("SIAGAL >>>>>>>>>>> lineaspedidoscli.qs   preciEspeCli_commonCalculateField HAY PRECIO ESPECIAL");
				if (util.sqlSelect("factalma_general", "avisoprecioesp", "1 = 1") == true ) {
					MessageBox.warning(util.translate("scripts","Aviso: Precio especial para este cliente y artículo.\n\nNo serán aplicados otros descuentos."),
					MessageBox.Ok, MessageBox.NoButton,MessageBox.NoButton);
					
				}
				
				
			} else { 
				//debug("SIAGAL >>>>>>>>>>> lineaspedidoscli.qs   precioEspCli_commonCalculateField NO HAY PRECIO ESPECIAL");
				valor = this.iface.__commonCalculateField(fN, cursor);
			}
		
			break;
		}
		default:{
			valor = this.iface.__commonCalculateField(fN, cursor);
			}
		}

	return valor;
}


//// PRECIOESPCLI ////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

