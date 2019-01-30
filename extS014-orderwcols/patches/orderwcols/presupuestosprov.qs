
/** @class_declaration orderCols */
/////////////////////////////////////////////////////////////////
//// ORDER COLS /////////////////////////////////////////////////
class orderCols extends oficial {
    function orderCols( context ) { oficial ( context ); }
	function init() {
		return this.ctx.orderCols_init();
	}
    function filtrarDatos() {
		return this.ctx.orderCols_filtrarDatos();
	}
}
/////////////////////////////////////////////////////////////////
//// ORDER COLS /////////////////////////////////////////////////

/** @class_definition orderCols */
/////////////////////////////////////////////////////////////////
//// ORDER COLS /////////////////////////////////////////////////
function orderCols_init()
{
	
  	this.iface.__init();

	var util: FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.child("tdbLineasPresupuestosProv").cursor();
	var orden:Array = formRecordordercols.iface.pub_aplicarOrden(cursor);
	this.child("tdbLineasPresupuestosProv").setOrderCols(orden);


	var anchos:Array = formRecordordercols.iface.pub_aplicarAnchos(cursor);
	if (anchos.length == orden.length) { 
	    for (var i = 0; i < anchos.length; i++) {
		  this.child("tdbLineasPresupuestosProv").setColumnWidth(orden[i], anchos[i]);
	    }
	} else {
	    MessageBox.warning(util.translate("scripts", "No se puede establecer el ancho de columnas al ser diferente\nel número de elementos de anchura que de columnas seleccionadas."), MessageBox.Ok, MessageBox.NoButton);

	}

	this.child("tdbLineasPresupuestosProv").switchSortOrder(formRecordordercols.iface.pub_ascendenteDescendente(cursor));
	this.child("tdbLineasPresupuestosProv").refresh(); 	
	
}

/* Sobrecargamos a oficial que é a que está conectada co tdbArticulosPedProv  */
/* Non precisamos init por sobrecargar a oficial_procesarEstadoLinea */
function orderCols_filtrarDatos()
{
  /* Deixamos os anchos das columnas */
  
	var util: FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.child("tdbLineasPresupuestosProv").cursor();
	var orden:Array = formRecordordercols.iface.pub_aplicarOrden(cursor);
	var anchos:Array = formRecordordercols.iface.pub_aplicarAnchos(cursor);
	if (anchos.length == orden.length) {
	    for (var i = 0; i < anchos.length; i++) {
		  this.child("tdbLineasPresupuestosProv").setColumnWidth(orden[i], anchos[i]);
	    }
	} else {
	    MessageBox.warning(util.translate("scripts", "No se puede establecer el ancho de columnas al ser diferente\nel nÃºmero de elementos de anchura que de columnas seleccionadas."), MessageBox.Ok, MessageBox.NoButton);

	}

	this.child("tdbLineasPresupuestosProv").refresh();
	this.iface.__filtrarDatos();

}
//// ORDER COLS /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

