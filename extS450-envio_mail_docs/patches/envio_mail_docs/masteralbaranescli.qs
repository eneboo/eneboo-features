
/** @class_declaration envioMail */
/////////////////////////////////////////////////////////////////
//// ENVIO_MAIL ////////////////////////////////////////////////
class envioMail extends numLinea /** %from: oficial */
{
  function envioMail(context)
  {
    numLinea(context);
  }
  function init()
  {
    return this.ctx.envioMail_init();
  }
  function enviarDocumento(codAlbaran: String, codCliente: String)
  {
    return this.ctx.envioMail_enviarDocumento(codAlbaran, codCliente);
  }
  function imprimir(codAlbaran: String)
  {
    return this.ctx.envioMail_imprimir(codAlbaran);
  }
  function dameParamInformeMail(idAlbaran)
  {
    return this.ctx.envioMail_dameParamInformeMail(idAlbaran);
  }
}

//// ENVIO_MAIL ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubEnvioMail */
/////////////////////////////////////////////////////////////////
//// PUB_ENVIO_MAIL /////////////////////////////////////////////
class pubEnvioMail extends head /** %from: head */
{
  function pubEnvioMail(context)
  {
    head(context);
  }
  function pub_enviarDocumento(codAlbaran: String, codCliente: String)
  {
    return this.enviarDocumento(codAlbaran, codCliente);
  }
}

//// PUB_ENVIO_MAIL /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition envioMail */
/////////////////////////////////////////////////////////////////
//// ENVIO_MAIL /////////////////////////////////////////////////
function envioMail_init()
{
  this.iface.__init();
  //this.child("tbnEnviarMail").close();
  connect(this.child("tbnEnviarMail"), "clicked()", this, "iface.enviarDocumento()");
}

function envioMail_enviarDocumento(codAlbaran: String, codCliente: String)
{
  var cursor: FLSqlCursor = this.cursor();
  var util: FLUtil = new FLUtil();

  if (!codAlbaran) {
    codAlbaran = cursor.valueBuffer("codigo");
  }

  if (!codCliente) {
    codCliente = cursor.valueBuffer("codcliente");
  }

  var tabla: String = "clientes";
  var emailCliente: String = flfactppal.iface.pub_componerListaDestinatarios(codCliente, tabla);
  if (!emailCliente) {
    return;
  }

  var rutaIntermedia: String = util.readSettingEntry("scripts/flfactinfo/dirCorreo");
  if (!rutaIntermedia.endsWith("/")) {
    rutaIntermedia += "/";
  }


  var fechaDocumento:String = cursor.valueBuffer("fecha").toString();;
  fechaDocumento = fechaDocumento.mid(8,2) + "-" + fechaDocumento.mid(5,2) + "-" + fechaDocumento.mid(0,4);

  var cuerpo: String = util.readSettingEntry("scripts/flfactinfo/emailAVCuerpo");

  cuerpo = cuerpo.replace("<CodDocumento>",codAlbaran);
  cuerpo = cuerpo.replace("<FechaDocumento>",fechaDocumento);
  cuerpo = cuerpo.replace("<CodCliente>",codCliente);
  cuerpo = cuerpo.replace("<NomCliente>",cursor.valueBuffer("nombrecliente"));

  var asunto: String = util.readSettingEntry("scripts/flfactinfo/emailAVAsunto");;

  asunto = asunto.replace("<CodDocumento>",codAlbaran);
  asunto = asunto.replace("<FechaDocumento>",fechaDocumento);
  asunto = asunto.replace("<CodCliente>",codCliente);
  asunto = asunto.replace("<NomCliente>",cursor.valueBuffer("nombrecliente"));


  var rutaDocumento: String = rutaIntermedia + "A_" + codAlbaran + ".pdf";

  var util: FLUtil = new FLUtil;
  var codigo, idAlbaran;
  if (codAlbaran) {
    codigo = codAlbaran;
    idAlbaran = util.sqlSelect("albaranescli", "idalbaran", "codigo = '" + codigo + "'");
  } else {
    if (!cursor.isValid()) {
      return;
    }
    codigo = cursor.valueBuffer("codigo");
    idAlbaran = cursor.valueBuffer("idalbaran");
  }

  var curImprimir: FLSqlCursor = new FLSqlCursor("i_albaranescli");
  curImprimir.setModeAccess(curImprimir.Insert);
  curImprimir.refreshBuffer();
  curImprimir.setValueBuffer("descripcion", "temp");
  curImprimir.setValueBuffer("d_albaranescli_codigo", codigo);
  curImprimir.setValueBuffer("h_albaranescli_codigo", codigo);
  var oParam = this.iface.dameParamInformeMail(idAlbaran);
  var oDatosPdf = new Object();
  oDatosPdf["pdf"] = true;
  oDatosPdf["ruta"] = rutaDocumento;
  oParam.datosPdf = oDatosPdf;
  flfactinfo.iface.pub_lanzaInforme(curImprimir, oParam);


  var arrayDest: Array = [];
  arrayDest[0] = [];
  arrayDest[0]["tipo"] = "to";
  arrayDest[0]["direccion"] = emailCliente;

  var arrayAttach: Array = [];
  arrayAttach[0] = rutaDocumento;

  //Rexistramos o envío do email na cabeceira
  flfactppal.iface.pub_marcarEnviadoMail(idAlbaran,"idalbaran","albaranescli");

  flfactppal.iface.pub_enviarCorreo(cuerpo, asunto, arrayDest, arrayAttach);
}

function envioMail_dameParamInformeMail(idAlbaran)
{
  var oParam = this.iface.dameParamInforme(idAlbaran);
  return oParam;
}

function envioMail_imprimir(codAlbaran: String)
{
  var util: FLUtil = new FLUtil;

  var datosEMail: Array = [];
  datosEMail["tipoInforme"] = "albaranescli";
  var codCliente: String;
  if (codAlbaran && codAlbaran != "") {
    datosEMail["codDestino"] = util.sqlSelect("albaranescli", "codcliente", "codigo = '" + codAlbaran + "'");
    datosEMail["codDocumento"] = codAlbaran;
  } else {
    var cursor: FLSqlCursor = this.cursor();
    datosEMail["codDestino"] = cursor.valueBuffer("codcliente");
    datosEMail["codDocumento"] = cursor.valueBuffer("codigo");
  }
  flfactinfo.iface.datosEMail = datosEMail;
  this.iface.__imprimir(codAlbaran);
}

//// ENVIO_MAIL /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

