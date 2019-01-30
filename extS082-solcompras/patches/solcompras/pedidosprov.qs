
/** @class_declaration ofertasProv */
/////////////////////////////////////////////////////////////////
//// OFERTAS_PROV //////////////////////////////////////////////
class ofertasProv extends almacenEnSerie /** %from: almacenEnSerie */
{

  function ofertasProv(context)
  {
    almacenEnSerie(context);
  }
  function init()
  {
    return this.ctx.ofertasProv_init();
  }



}
//// OFERTAS_PROV //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition ofertasProv */
/////////////////////////////////////////////////////////////////
//// OFERTAS_PROV ///////////////////////////////////////////////

function ofertasProv_init()
{

	this.iface.__init();

	var cursor: FLSqlCursor = this.cursor();
	var util: FLUtil = new FLUtil();

	//Se está tramitado pois pechamos
    if (cursor.modeAccess() == cursor.Edit) {
		if (cursor.valueBuffer("tramitado"))
		{
			this.child("tabWidget8").setTabEnabled("proveedor", false);
			this.child("tabWidget8").setTabEnabled("datos", false);

			this.child("fdbEnviado").setDisabled(true);
			this.child("fdbTramitado").setDisabled(true);
			this.child("fdbFechaEnvio").setDisabled(true);

			if (cursor.valueBuffer("enviado")) {
				//Deixamos cambiar a data
				this.child("fdbFechaEnvio").setDisabled(false);

			}


			this.child("tdbArticulosPedProv").setDisabled(true)
			this.child("tbnTallasCol").setDisabled(true)
			this.child("tbnPedidosCli").setDisabled(true)

			//this.form.close();
		}
    }



}


//// OFERTAS_PROV ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

