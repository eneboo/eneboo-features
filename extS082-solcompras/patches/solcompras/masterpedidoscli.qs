
/** @class_declaration ofertasProv */
/////////////////////////////////////////////////////////////////
//// OFERTAS_PROV //////////////////////////////////////////////
class ofertasProv extends envioMail /** %from: envioMail */
{
  function ofertasProv(context)
  {
    envioMail(context);
  }
  function init()
  {
    return this.ctx.ofertasProv_init();
  }
  function mostrarSolicitudOferta()
  {
    return this.ctx.ofertasProv_mostrarSolicitudOferta();
  }
}
//// OFERTAS_PROV //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition ofertasProv */
/////////////////////////////////////////////////////////////////
//// OFERTAS_PROV ///////////////////////////////////////////////
function ofertasProv_init()
{
  this.iface.__init();

  connect(this.child("tbnOferta"), "clicked()", this, "iface.mostrarSolicitudOferta");
}

function ofertasProv_mostrarSolicitudOferta()
{
  var cursor: FLSqlCursor = this.cursor();
  var util: FLUtil = new FLUtil();
  var hoy: Date = new Date();
  var idpresupuesto: String = cursor.valueBuffer("idpedido");

debug(">>>>>>>>>>> ofertasProv_mostrarSolicitudOferta");

  var qry: FLSqlQuery = new FLSqlQuery();
  qry.setTablesList("solpresupuestosprov");
  qry.setSelect("codsolicitud");
  qry.setFrom("solpresupuestosprov");
  qry.setWhere("idpedidocli = " + idpresupuesto);
  if (!qry.exec())
    return false;

  var curSolOferta: FLSqlCursor = new FLSqlCursor("solpresupuestosprov");
  var codSolicitud: String;
  if (qry.first()) {
    codSolicitud = qry.value("codsolicitud")
                   curSolOferta.select("codsolicitud = '" + codSolicitud + "'");
    curSolOferta.first();
    curSolOferta.editRecord();
  } else {
    var res: Number = MessageBox.warning(util.translate("scripts", "El presupuesto no tiene ninguna solicitud de oferta asignada.\n¿Desea crearla?"), MessageBox.Yes, MessageBox.No);
    if (res != MessageBox.Yes) {
      return true;
    }
    curSolOferta.setModeAccess(curSolOferta.Insert);
    curSolOferta.refreshBuffer();
    curSolOferta.setValueBuffer("codsolicitud", util.nextCounter("codsolicitud", curSolOferta));
    curSolOferta.setValueBuffer("idpedidocli", idpresupuesto);
    curSolOferta.setValueBuffer("codpedidocli", cursor.valueBuffer("codigo"));
    curSolOferta.setValueBuffer("fecha", hoy);

    debug(">>>> cursor.valueBuffer(codcliente)" + cursor.valueBuffer("codcliente"));

    curSolOferta.setValueBuffer("codcliente", cursor.valueBuffer("codcliente"));
    curSolOferta.setValueBuffer("nombrecliente", cursor.valueBuffer("nombrecliente"));

    codSolicitud = curSolOferta.valueBuffer("codsolicitud");
    if (!curSolOferta.commitBuffer()) {
      return false;
    }
    curSolOferta.select("codsolicitud = '" + codSolicitud + "'");
    curSolOferta.first();
    if (!flfacturac.iface.pub_cargarDatosSolOferta(curSolOferta))
      return false;
    curSolOferta.editRecord();
  }
}

//// OFERTAS_PROV ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

