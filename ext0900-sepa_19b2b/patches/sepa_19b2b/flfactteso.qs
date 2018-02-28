
/** @class_declaration sepa19b2b */
/////////////////////////////////////////////////////////////////
//// SEPA19B2B //////////////////////////////////////////////////
class sepa19b2b extends diasPago /** %from: oficial */ {
  function sepa19b2b( context ) { diasPago ( context ); }
  function comprobarCuentasDomSEPA(idRemesa) {
  	return this.ctx.sepa19b2b_comprobarCuentasDomSEPA(idRemesa);
  }
}
//// SEPA19B2B //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubSepa19b2b */
/////////////////////////////////////////////////////////////////
//// PUB SEPA19B2B  /////////////////////////////////////////////
class pubSepa19b2b extends pubProveed /** %from: ifaceCtx */
{
  function pubSepa19b2b(context)
  {
    pubProveed(context);
  }
  function pub_comprobarCuentasDomSEPA(idRemesa)
  {
    return this.comprobarCuentasDomSEPA(idRemesa);
  }
}

//// PUB SEPA19B2B  /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition sepa19b2b */
/////////////////////////////////////////////////////////////////
//// SEPA19B2B //////////////////////////////////////////////////

function sepa19b2b_comprobarCuentasDomSEPA(idRemesa)
{
	var _i = this.iface;

  var qryRecibos = new FLSqlQuery;
  qryRecibos.setTablesList("pagosdevolcli,reciboscli,cuentasbcocli");
  qryRecibos.setSelect("r.codigo, r.codcliente, r.nombrecliente");
  qryRecibos.setFrom("pagosdevolcli pd INNER JOIN reciboscli r ON pd.idrecibo = r.idrecibo LEFT OUTER JOIN cuentasbcocli cc ON (r.codcliente = cc.codcliente AND r.codcuenta = cc.codcuenta)");
  qryRecibos.setWhere("pd.idremesa = " + idRemesa + " AND cc.codcuenta IS NULL ORDER BY codcliente, codigo");
  qryRecibos.setForwardOnly(true);

  if (!qryRecibos.exec()) {
  	return false;
  }

  debug(qryRecibos.sql());

  var msgError = "";
  var i = 0;

  while (qryRecibos.next()) {
    msgError += "\n" + sys.translate("Cliente: %1 (%2), Recibo %3").arg(qryRecibos.value("r.nombrecliente")).arg(qryRecibos.value("r.codcliente")).arg(qryRecibos.value("r.codigo"));
  }

  var mensaje = "Los siguientes recibos no tienen especificada una cuenta de domiciliación válida:\n" + msgError + "\n\nCorrija estos recibos para poder efectuar la remesa.";

  if (msgError != "") {
    sys.warnMsgBox(sys.translate(mensaje));

  	return false;
	}
	return true;
}

//// SEPA19B2B //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

