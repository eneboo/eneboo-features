
/** @class_declaration almacenLinea */
/////////////////////////////////////////////////////////////////
//// ALMACEN_LINEA //////////////////////////////////////////////
class almacenLinea extends envioMail /** %from: oficial */ {
	function almacenLinea( context ) { envioMail ( context ); }
	function datosLineaAlbaran(curLineaPedido:FLSqlCursor):Boolean {
		return this.ctx.almacenLinea_datosLineaAlbaran(curLineaPedido);
	}
}
//// ALMACEN_LINEA //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition almacenLinea */
/////////////////////////////////////////////////////////////////
//// ALMACEN_LINEA //////////////////////////////////////////////
function almacenLinea_datosLineaAlbaran(curLineaPedido:FLSqlCursor):Boolean
{
	if (!this.iface.__datosLineaAlbaran(curLineaPedido)) {
		return false;
	}
	with (this.iface.curLineaAlbaran) {
		setValueBuffer("codalmacen", curLineaPedido.valueBuffer("codalmacen"));
	}
	return true;
}
//// ALMACEN_LINEA //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

