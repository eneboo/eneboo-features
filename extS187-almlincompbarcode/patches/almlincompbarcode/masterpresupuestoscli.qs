
/** @class_declaration almacenLinea */
/////////////////////////////////////////////////////////////////
//// ALMACEN_LINEA //////////////////////////////////////////////
class almacenLinea extends ivaIncluido /** %from: ivaIncluido */ {
	function almacenLinea( context ) { ivaIncluido ( context ); }
	function datosLineaPedido(curLineaPresupuesto:FLSqlCursor):Boolean {
		return this.ctx.almacenLinea_datosLineaPedido(curLineaPresupuesto);
	}
}
//// ALMACEN_LINEA //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition almacenLinea */
/////////////////////////////////////////////////////////////////
//// ALMACEN_LINEA //////////////////////////////////////////////
function almacenLinea_datosLineaPedido(curLineaPresupuesto:FLSqlCursor):Boolean
{
	if (!this.iface.__datosLineaPedido(curLineaPresupuesto)) {
		return false;
	}
	with (this.iface.curLineaPedido) {
		setValueBuffer("codalmacen", curLineaPresupuesto.valueBuffer("codalmacen"));
	}
	return true;
}
//// ALMACEN_LINEA //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

