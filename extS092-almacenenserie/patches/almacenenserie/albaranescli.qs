
/** @class_declaration almacenEnSerie */
/////////////////////////////////////////////////////////////////
//// ALMACEN EN SERIE ///////////////////////////////////////////
class almacenEnSerie extends avisoObs /** %from: serieLocalCli */
{
  function almacenEnSerie(context)
  {
    avisoObs(context);
  }
  function init()
  {
    return this.ctx.almacenEnSerie_init();
  }

  function bufferChanged(fN: String)
  {
    return this.ctx.almacenEnSerie_bufferChanged(fN);
  }
}
//// ALMACEN EN SERIE ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition almacenEnSerie */
///////////////////////////////////////////////////////////
//// ALMACEN EN SERIE /////////////////////////////////////

function almacenEnSerie_init()
{

	this.iface.__init();

	var util:FLUtil = new FLUtil();
	var cursor: FLSqlCursor = this.cursor();

	if (this.child("fdbCodAlmacen") && cursor.modeAccess() == cursor.Insert) {
		if (cursor.valueBuffer("codserie") && cursor.valueBuffer("codserie") != "" )  {
			codAlmacen = util.sqlSelect("series", "codalmacen", "codserie = '" + cursor.valueBuffer("codserie") + "'");
			debug ("**** PEDIDOSCLI ***** >>>>>>>>>>> almacenEnSerie_init codAlmacen determinado por serie: " + codAlmacen);
			if (codAlmacen && codAlmacen != "") {
				this.child("fdbCodAlmacen").setValue(codAlmacen);
			}
		} else {
			// Debería ser prescindible, pois xa o establece antes no init heredado
			debug ("**** PEDIDOSCLI ***** >>>>>>>>>>> almacenEnSerie_init codAlmacen predeterminado pola empresa:" + flfactppal.iface.pub_valorDefectoEmpresa("codalmacen") );
			this.child("fdbCodAlmacen").setValue(flfactppal.iface.pub_valorDefectoEmpresa("codalmacen"));
		}
    }


}


function almacenEnSerie_bufferChanged(fN: String)
{

debug ("**** PEDIDOSCLI ***** >>>>>>>>>>> almacenEnSerie_bufferChanged");

	this.iface.__bufferChanged(fN);

	var util:FLUtil = new FLUtil();
	var cursor: FLSqlCursor = this.cursor();
	var resultado: Boolean = false;
	var codAlmacen: String;


	switch (fN) {

		case "codserie": {

			// Só podemos cambiar cando estamos en modo inserción
			if (cursor.valueBuffer("codserie") && cursor.valueBuffer("codserie") != "" && cursor.modeAccess() == cursor.Insert)  {
				codAlmacen = util.sqlSelect("series", "codalmacen", "codserie = '" + cursor.valueBuffer("codserie") + "'");
				debug ("**** PEDIDOSCLI ***** >>>>>>>>>>> almacenEnSerie_bufferChanged codAlmacen determinado por serie: " + codAlmacen);
				if (codAlmacen && codAlmacen != "") {
					this.child("fdbCodAlmacen").setValue(codAlmacen);
				} else {
					debug ("**** PEDIDOSCLI ***** >>>>>>>>>>> almacenEnSerie_bufferChanged codAlmacen predeterminado pola empresa:" + flfactppal.iface.pub_valorDefectoEmpresa("codalmacen") );
					this.child("fdbCodAlmacen").setValue(flfactppal.iface.pub_valorDefectoEmpresa("codalmacen"));
				}
			}

		}
	}



}


//// ALMACEN EN SERIE /////////////////////////////////////
///////////////////////////////////////////////////////////

