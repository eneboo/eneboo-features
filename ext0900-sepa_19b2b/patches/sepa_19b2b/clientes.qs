
/** @class_declaration sepa19b2b */
/////////////////////////////////////////////////////////////////
//// SEPA19B2B /////////////////////////////////////////////////
class sepa19b2b extends diasPago /** %from: oficial */ {
    function sepa19b2b( context ) { diasPago ( context ); }
    function init() {
    	return this.ctx.sepa19b2b_init();
    }
    function imprimirMandato() {
    	return this.ctx.sepa19b2b_imprimirMandato();
    }
}
//// SEPA19B2B /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition sepa19b2b */
/////////////////////////////////////////////////////////////////
//// SEPA19B2B /////////////////////////////////////////////////

function sepa19b2b_init() {
	var _i = this.iface;
	connect(this.child("tbnImprimirMandato"), "clicked()", _i, "imprimirMandato");
	debug("antes de inicializar");
	formmandatoscli.iface.pub_inicializarArrayTextos();
	debug("despues de inicializar");

	_i.__init();


}

function sepa19b2b_imprimirMandato() {
	var _i = this.iface;
	var curMandato = this.child("tdbMandatos").cursor();
	formmandatoscli.iface.pub_setValorCliente(curMandato.valueBuffer("codcliente"));

	var tipoInforme = curMandato.valueBuffer("tipo");

	if(!tipoInforme || tipoInforme == "") {
		return false;
	}

	var idMandato = curMandato.valueBuffer("idmandato");
	var curImprimir = new FLSqlCursor("i_mandatoscli");
	curImprimir.setModeAccess(curImprimir.Insert);
	curImprimir.refreshBuffer();
	curImprimir.setValueBuffer("descripcion", "temp");
	curImprimir.setValueBuffer("i_mandatoscli_idmandato", idMandato);

	var nombreInforme;

	switch (tipoInforme) {
		case "B2B": {
			nombreInforme = "i_mandatoscli_sepab2b";
			break;
		}
		case "CORE1*":
		case "CORE": {
			nombreInforme = "i_mandatoscli_sepa";
			break;
		}
		default: {
			return false;
		}
	}

	var idEmpresa = flfactppal.iface.pub_valorDefectoEmpresa("id");

	flfactinfo.iface.pub_lanzarInforme(curImprimir, nombreInforme, "", "", false, false, "empresa.id = " + idEmpresa);

	return true;
}

//// SEPA19B2B /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

