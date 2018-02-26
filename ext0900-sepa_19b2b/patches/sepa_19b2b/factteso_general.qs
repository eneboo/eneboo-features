
/** @class_declaration sepa19b2b */
/////////////////////////////////////////////////////////////////
//// SEPA192B2 //////////////////////////////////////////////////
class sepa19b2b extends pagareProv /** %from: oficial */ {
	function sepa19b2b( context ) { pagareProv ( context ); }
	function init() {
		return this.ctx.sepa19b2b_init();
	}
	function tbnCalcularMandatoPagos_clicked() {
		return this.ctx.sepa19b2b_tbnCalcularMandatoPagos_clicked();
	}
}
//// SEPA192B2 //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition sepa19b2b */
/////////////////////////////////////////////////////////////////
//// SEPA192B2 //////////////////////////////////////////////////

function sepa19b2b_init()
{
	var _i = this.iface;

	_i.__init();

	connect(this.child("tbnCalcularMandatoPagos"), "clicked()", _i, "tbnCalcularMandatoPagos_clicked");
}

function sepa19b2b_tbnCalcularMandatoPagos_clicked()
{
	var _i = this.iface;

	var curMandato = new FLSqlCursor("mandatoscli");
	curMandato.select("1 = 1");

	AQUtil.createProgressDialog("Actualizando mandatos...", curMandato.size());
	var p = 0;
	var q = new FLSqlQuery();

	while(curMandato.next()) {
		curMandato.setModeAccess(curMandato.Edit);
		curMandato.refreshBuffer();

		AQUtil.setProgress(p++);

		var fechaFirma = curMandato.valueBuffer("fechafirma");
		fechaFirma = fechaFirma && fechaFirma != "" ? fechaFirma : "2009-10-31";

		q.setSelect("p.idpagodevol");
		q.setFrom("reciboscli r INNER JOIN pagosdevolcli p ON r.idrecibo = p.idrecibo");
		q.setWhere("r.estado NOT IN ('Emitido', 'Devuelto') AND r.codcuenta = '" + curMandato.valueBuffer("codcuentacliente") + "' AND (p.idremesa IS NOT NULL AND p.idremesa <> 0) AND p.fecha >= '" + fechaFirma + "' AND p.idmandato IS NULL");
		//q.setTablesList("reciboscli, pagosdevolcli");

		if(!q.exec()) {
			AQUtil.destroyProgressDialog();
			debug(q.sql());
			sys.warnMsgBox(sys.translate("La consulta falló."));
			return false;
		}

		while(q.next()) {
			if (!AQUtil.execSql("UPDATE pagosdevolcli SET idmandato = " + curMandato.valueBuffer("idmandato") + " WHERE idpagodevol = " + q.value("p.idpagodevol"))) {
				AQUtil.destroyProgressDialog();
				sys.warnMsgBox(sys.translate("Ocurrió un error durante la actualización de los pagos."));
				return false;
			}
		}

		curMandato.setValueBuffer("numefectos", formRecordmandatoscli.iface.commonCalculateField("numefectos", curMandato));

		if(!curMandato.commitBuffer()) {
			AQUtil.destroyProgressDialog();
			sys.warnMsgBox(sys.translate("Ocurrió un error durante la actualización de los mandatos."));
			return false;
		}
	}
	AQUtil.destroyProgressDialog();
	sys.infoMsgBox(sys.translate("La acción se completó correctamente."));
	return true;
}

//// SEPA192B2 //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

