
/** @class_declaration funServiciosCli */
//////////////////////////////////////////////////////////////////
//// FUN_SERVICIOS_CLI ///////////////////////////////////////////
class funServiciosCli extends envioMail {
	function funServiciosCli( context ) { envioMail( context ); }
	function servicioConContrato(nodo:FLDomNode):String {
		return funServiciosCli_servicioConContrato(nodo)
	}
	function encabezadoAlbaranFactura(nodo:FLDomNode):String {
		return funServiciosCli_encabezadoAlbaranFactura(nodo)
	}
	function datosClienteServicio(nodo:FLDomNode):String {
		return funServiciosCli_datosClienteServicio(nodo)
	}
}
//// FUN_SERVICIOS_CLI ///////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration pubServicios */
/////////////////////////////////////////////////////////////////
//// PUB_INFO_VENCIMIENTOS //////////////////////////////////////
class pubServicios extends pubInfoVtos /** %from: pubInfoVtos */ {
    function pubServicios( context ) { pubInfoVtos ( context ); }
	function pub_datosClienteServicio(nodo:FLDomNode):Boolean {
                return this.datosClienteServicio(nodo);
    }
}

//// PUB_INFO_VENCIMIENTOS //////////////////////////////////////
/////////////////////////////////////////////////////////////////


		/// SIAGAL PARA MOSTRAR DATOS DE CLIENTE EN SERVICIO

/** @class_definition funServiciosCli */
/////////////////////////////////////////////////////////////////
//// FUN_SERVICIOS_CLI /////////////////////////////////////////////////

function funServiciosCli_servicioConContrato(nodo:FLDomNode):String
{
	var util:FLUtil = new FLUtil();
	var contratoMant:Boolean = nodo.attributeValue("servicioscli.contratomant");

	if (contratoMant == "true") return "C. Mant";
	return "";
}

function funServiciosCli_encabezadoAlbaranFactura(nodo:FLDomNode):String
{
	var util:FLUtil = new FLUtil();
	var idAlbaran:Number = nodo.attributeValue("albaranescli.idalbaran");

	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("servicioscli,tecnicos");
	q.setFrom("servicioscli s INNER JOIN tecnicos t ON s.codtecnico = t.codtecnico");
	q.setSelect("s.numservicio,s.fecha,s.contratomant,s.descripcion,s.solucion,t.apellidos,t.nombre");
	q.setWhere("s.idalbaran = " + idAlbaran);

	if (!q.exec()) return false;

	if (!q.first()) {
		return "MATERIALES";
	}

	var texto:String =
		util.translate("MetaData", "SERVICIO Nº ") + q.value(0) + "     " +
		util.translate("MetaData", "Fecha: ") + util.dateAMDtoDMA(q.value(1)) + "     " +
		util.translate("MetaData", "TÉCNICO: ") +
		q.value(5) + ", " + q.value(6);

	if (q.value(2) == "true")
		texto += "     " + util.translate("MetaData", "C. Mant");

	texto += "\n" +
		util.translate("MetaData", "DESCRIPCIÓN: ") +
		q.value(3) + "\n" +
		util.translate("MetaData", "SOLUCIÓN: ") +
		q.value(4);

	return texto;
}

function funServiciosCli_datosClienteServicio(nodo:FLDomNode):String
{
	var util:FLUtil = new FLUtil();
	var codCliente:String = nodo.attributeValue("servicioscli.codcliente");

	var nomCliente:String = util.sqlSelect("clientes", "nombre", "codcliente = '" + codCliente + "'");
	var tlfCliente:String = util.sqlSelect("clientes", "telefono1", "codcliente = '" + codCliente + "'");


	if (!nomCliente)
		return "";

	if (!tlfCliente) {
		return nomCliente;
	} else {
		return nomCliente + "\n" + "Teléfono.: " + tlfCliente;
	}



}

//// FUN_SERVICIOS_CLI ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////

