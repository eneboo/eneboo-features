
/** @class_declaration reportUnico */
/////////////////////////////////////////////////////////////////
//// REPORT UNICO ///////////////////////////////////////////////
class reportUnico extends oficial {
	function reportUnico( context ) { oficial( context ); }
	function lanzar() {
		return this.ctx.reportUnico_lanzar();
	}
}
//// REPORT UNICO ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition reportUnico */
/////////////////////////////////////////////////////////////////
//// REPORT UNICO ///////////////////////////////////////////////
function reportUnico_lanzar()
{
	var cursor:FLSqlCursor = this.cursor();
	var pI = this.iface.obtenerParamInforme();
	if (!pI) {
		return;
	}
	var whereFijo:String = "PARAM_titulo\nFactura\nPARAM_tabla\nfacturasprov\nPARAM_subtabla\nfactura\nPARAM_orderdef\nfacturasprov.codigo\nPARAM_tablareldoc\nalbaranesprov\nPARAM_reldoc\nalbaran\n";
	pI.whereFijo = whereFijo + pI.whereFijo;
	debug("pI.WhereFijo --> " + pI.whereFijo);
	flfactinfo.iface.pub_lanzarInforme(cursor, pI.nombreInforme, pI.orderBy, "", false, false, pI.whereFijo);
}
//// REPORT UNICO ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

