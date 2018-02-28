
/** @class_declaration obtPrecioCompra */
/////////////////////////////////////////////////////////////////
//// OBTENER ULTIMO PRECIO COMPRA ///////////////////////////////
class obtPrecioCompra extends articuloscomp /** %from: oficial */ {

    var tbnObtenerUltimoPrecComp:Object;

    function obtPrecioCompra( context ) { articuloscomp ( context ); }
		function init() {
		return this.ctx.obtPrecioCompra_init();
	}
	function obtenerUltimoPrecioCompra() {
		return this.ctx.obtPrecioCompra_obtenerUltimoPrecioCompra();
	}
}
//// OBTENER ULTIMO PRECIO COMPRA ///////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition obtPrecioCompra */
/////////////////////////////////////////////////////////////////
//// OBTENER ULTIMO PRECIO COMPRA ///////////////////////////////

function obtPrecioCompra_init()
{
	this.iface.__init();

	this.iface.tbnObtenerUltimoPrecComp = this.child("tbnObtenerUltimoPrecComp");
	connect (this.iface.tbnObtenerUltimoPrecComp, "clicked()", this, "iface.obtenerUltimoPrecioCompra()");
}

function obtPrecioCompra_obtenerUltimoPrecioCompra()
{

//debug(">>>>>>>>>>>> CHEGAMOS!");

	var util:FLUtil = new FLUtil;
	var qryAlbaranes:FLSqlQuery = new FLSqlQuery();
	var cursor:FLSqlCursor = this.cursor();
	var pvpTotal:Number = 0;
	var cantidad:Number = 1;
	var pvpUnitarioFinal:Number = "0";

//select  pvptotal,cantidad,fecha,hora,* from lineasalbaranesprov inner join albaranesprov on albaranesprov.idalbaran = lineasalbaranesprov.idalbaran
//where referencia = '0'
//order by fecha desc,hora desc fetch first 1 rows only

	qryAlbaranes.setTablesList("lineasalbaranesprov,albaranesprov");
	qryAlbaranes.setSelect("l.pvptotal,l.cantidad");
	qryAlbaranes.setFrom("lineasalbaranesprov l inner join albaranesprov a on a.idalbaran = l.idalbaran ");
	qryAlbaranes.setWhere("l.referencia = '" + cursor.valueBuffer("referencia") + "'");
	qryAlbaranes.setOrderBy(" a.fecha desc, a.hora desc ");

	if (qryAlbaranes.exec()) {

		if(!qryAlbaranes.next()) {
				MessageBox.warning(util.translate("scripts", "No se encontraron albaranes de compra con el artículo '" + cursor.valueBuffer("referencia") + "'"), MessageBox.Ok, MessageBox.NoButton);
		} else {
			pvpTotal = qryAlbaranes.value("l.pvptotal");
			cantidad = qryAlbaranes.value("l.cantidad");

			if (cantidad == 0)
				cantidad = 1;

			pvpUnitarioFinal = (pvpTotal / cantidad)

//	debug(">>>>>>>>>>>>>>> cantidad" + cantidad);
//	debug(">>>>>>>>>>>>>>> pvpTotal" + pvpTotal);
//	debug(">>>>>>>>>>>>>>> pvpUnitarioFinal" + pvpUnitarioFinal);

			cursor.setValueBuffer("pvp",pvpUnitarioFinal);
		}
	}
}

//// OBTENER ULTIMO PRECIO COMPRA ///////////////////////////////
/////////////////////////////////////////////////////////////////

