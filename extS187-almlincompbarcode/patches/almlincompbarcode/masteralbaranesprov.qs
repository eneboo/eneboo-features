
/** @class_declaration almacenLinea */
/////////////////////////////////////////////////////////////////
//// ALMACEN_LINEA //////////////////////////////////////////////
class almacenLinea extends marcaImpresion /** %from: oficial */ {
	function almacenLinea( context ) { marcaImpresion ( context ); }
	function datosLineaFactura(curLineaAlbaran:FLSqlCursor):Boolean {
		return this.ctx.almacenLinea_datosLineaFactura(curLineaAlbaran);
	}
}
//// ALMACEN_LINEA //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition almacenLinea */
/////////////////////////////////////////////////////////////////
//// ALMACEN_LINEA //////////////////////////////////////////////
/** \D Copia los datos de una línea de albarán en una línea de factura
@param	curLineaAlbaran: Cursor que contiene los datos a incluir en la línea de factura
@return	True si la copia se realiza correctamente, false en caso contrario
\end */
function almacenLinea_datosLineaFactura(curLineaAlbaran:FLSqlCursor):Boolean
{
	if (!this.iface.__datosLineaFactura(curLineaAlbaran)) {
		return false;
	}
	with (this.iface.curLineaFactura) {
		setValueBuffer("codalmacen", curLineaAlbaran.valueBuffer("codalmacen"));
	}

	return true;
}
//// ALMACEN_LINEA //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

