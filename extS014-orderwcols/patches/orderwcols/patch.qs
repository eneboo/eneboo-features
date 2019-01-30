
/** @class_declaration orderCols */
/////////////////////////////////////////////////////////////////
//// ORDER COLS /////////////////////////////////////////////////
class orderCols extends oficial {
    function orderCols( context ) { oficial ( context ); }
	function init() {
		return this.ctx.orderCols_init();
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

	var cursor:FLSqlCursor = this.cursor();
	var orden:Array = formRecordordercols.iface.pub_aplicarOrden(cursor);

	this.iface.tdbRecords.setOrderCols(orden);

	var anchos:Array = formRecordordercols.iface.pub_aplicarAnchos(cursor);
	if (anchos.length == orden.length) { 
	    for (var i = 0; i < anchos.length; i++) {
		  this.child("tdbLineasPresupuestosProv").setColumnWidth(orden[i], anchos[i]);
	    }
	} else {
	    MessageBox.warning(util.translate("scripts", "No se puede establecer el ancho de columnas al ser diferente\nel número de elementos de anchura que de columnas seleccionadas."), MessageBox.Ok, MessageBox.NoButton);

	}
	

	
	this.iface.tdbRecords.switchSortOrder(formRecordordercols.iface.pub_ascendenteDescendente(cursor));
	this.iface.tdbRecords.refresh();
}
//// ORDER COLS /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

