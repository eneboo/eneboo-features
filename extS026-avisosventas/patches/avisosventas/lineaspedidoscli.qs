
/** @class_declaration avisoArtVentas */
//////////////////////////////////////////////////////////
//// AVISO ARTICULO EN VENTAS ////////////////////////////
class avisoArtVentas extends dtosCompletosCli /** %from: oficial */
{
  function avisoArtVentas(context)
  {
    dtosCompletosCli(context);
  }
  function init()
  {
    return this.ctx.avisoArtVentas_init();
  }
  function commonBufferChanged(fN: String, miForm: Object)
  {
    return this.ctx.avisoArtVentas_commonBufferChanged(fN, miForm);
  }

}
//// AVISO ARTICULO EN VENTAS ///////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition avisoArtVentas */
//////////////////////////////////////////////////////////
//// AVISO ARTICULO EN VENTAS ////////////////////////////
function avisoArtVentas_init()
{
  this.iface.__init();

  var util: FLUtil = new FLUtil();
  var cursor: FLSqlCursor = this.cursor();
  switch (cursor.modeAccess()) {
    case cursor.Insert: {
		debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>> AVISO VENTAS  INSERT <<<<<<<<<<<<<<<<<<<<<<<<");

      break;
    }


  }
}



function avisoArtVentas_commonBufferChanged(fN: String, miForm: Object)
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = miForm.cursor();



	switch (fN) {
		case "referencia":{
			 // debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ESTAMOS CAMBIANDO REFERENCIA <<<<<<<<<<<<<<<<<<<<<<<<");
			  var tabla: String = cursor.table();
        	  var avisaremos: Boolean = false;
			  var avisoMessageBox: String = "";


			  switch (tabla) {
				case "lineaspresupuestoscli": {
				   	if (util.sqlSelect("articulos", "avisoventapre", "referencia = '" + cursor.valueBuffer("referencia") + "'")) {
						avisoMessageBox = util.sqlSelect("articulos", "avisoventapretexto", "referencia = '" + cursor.valueBuffer("referencia") + "'");
						avisaremos = true
					}

				  break;
				}
				case "lineaspedidoscli": {
				   	if (util.sqlSelect("articulos", "avisoventaped", "referencia = '" + cursor.valueBuffer("referencia") + "'")) {
						avisoMessageBox = util.sqlSelect("articulos", "avisoventapedtexto", "referencia = '" + cursor.valueBuffer("referencia") + "'");
						avisaremos = true
					}
				  break;
				}
				case "lineasalbaranescli": {
				   	if (util.sqlSelect("articulos", "avisoventaalb", "referencia = '" + cursor.valueBuffer("referencia") + "'")) {
						avisoMessageBox = util.sqlSelect("articulos", "avisoventaalbtexto", "referencia = '" + cursor.valueBuffer("referencia") + "'");
						avisaremos = true
					}
				  break;
				}
				case "lineasfacturascli": {
				   	if (util.sqlSelect("articulos", "avisoventafac", "referencia = '" + cursor.valueBuffer("referencia") + "'")) {
						avisoMessageBox = util.sqlSelect("articulos", "avisoventafactexto", "referencia = '" + cursor.valueBuffer("referencia") + "'");
						avisaremos = true
					}
				  break;
				}
			  }




			if (util.sqlSelect("articulos", "avisoventa", "referencia = '" + cursor.valueBuffer("referencia") + "'")) {
						if (avisaremos) {
							avisoMessageBox = avisoMessageBox + "\n\n";
						}

						avisoMessageBox = avisoMessageBox + util.sqlSelect("articulos", "avisoventatexto", "referencia = '" + cursor.valueBuffer("referencia") + "'");
						avisaremos = true
		       }

		    if (avisaremos) MessageBox.warning(util.translate("AVISO!", avisoMessageBox), MessageBox.Ok, MessageBox.NoButton,MessageBox.NoButton);


			this.iface.__commonBufferChanged(fN, miForm);
			//this.iface.__commonCalculateField(fN, cursor);
       	break;
		}
		default:{
			this.iface.__commonBufferChanged(fN, miForm);
			}
		}


	return true;
}





//// AVISO ARTICULO EN VENTAS ///////////////////////////////////
/////////////////////////////////////////////////////////////////

