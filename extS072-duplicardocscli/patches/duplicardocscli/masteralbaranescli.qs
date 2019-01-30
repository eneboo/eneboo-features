
/** @class_declaration duplicarDocsCli */
/////////////////////////////////////////////////////////////////
//// DUPLICAR DOCS CLI //////////////////////////////////////////
class duplicarDocsCli extends orderCols /** %from: oficial */
{
  var curAlbaran: FLSqlCursor;
  var curLineaAlbaran: FLSqlCursor;

  function duplicarDocsCli(context)
  {
    orderCols(context);
  }
  function init()
  {
    return this.ctx.duplicarDocsCli_init();
  }
  function duplicarAlbaran_clicked()
  {
    return this.ctx.duplicarDocsCli_duplicarAlbaran_clicked();
  }
  function duplicarAlbaran(curAlbaran: FLSqlCursor)
  {
    return this.ctx.duplicarDocsCli_duplicarAlbaran(curAlbaran);
  }
  function duplicardatosAlbaran(curAlbaran: FLSqlCursor)
  {
    return this.ctx.duplicarDocsCli_duplicardatosAlbaran(curAlbaran);
  }
  function duplicarCampoAlbaran(nombreCampo, cursor, campoInformado)
  {
    return this.ctx.duplicarDocsCli_duplicarCampoAlbaran(nombreCampo, cursor, campoInformado);
  }
  function duplicarLineasAlbaran(idAlbaranOrigen: Number, idAlbaranDestino: Number)
  {
    return this.ctx.duplicarDocsCli_duplicarLineasAlbaran(idAlbaranOrigen, idAlbaranDestino);
  }
  function duplicarHijosAlbaran(idAlbaranOrigen, idAlbaranDestino)
  {
    return this.ctx.duplicarDocsCli_duplicarHijosAlbaran(idAlbaranOrigen, idAlbaranDestino);
  }
  function duplicarLineaAlbaran(curLineaAlbaran: FLSqlCursor, idAlbaran: Number)
  {
    return this.ctx.duplicarDocsCli_duplicarLineaAlbaran(curLineaAlbaran, idAlbaran);
  }
  function duplicarCampoLineaAlbaran(nombreCampo, cursor, campoInformado)
  {
    return this.ctx.duplicarDocsCli_duplicarCampoLineaAlbaran(nombreCampo, cursor, campoInformado);
  }
  function totalesAlbaran()
  {
    return this.ctx.duplicarDocsCli_totalesAlbaran();
  }

}

//// DUPLICAR DOCS CLI //////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition duplicarDocsCli */
/////////////////////////////////////////////////////////////////
//// DUPLICAR DOCS CLI //////////////////////////////////////////

function duplicarDocsCli_init()
{

  this.iface.__init();

  connect(this.child("toolButtonCopy"), "clicked()", this, "iface.duplicarAlbaran_clicked()");

}



function duplicarDocsCli_duplicarAlbaran_clicked()
{

  var util = new FLUtil;
  var cursor = this.cursor();

  var idAlbaran;
  cursor.transaction(false);
  try {
    idAlbaran = this.iface.duplicarAlbaran(cursor);
    if (idAlbaran) {
      cursor.commit();
    } else {
      cursor.rollback();
      return
    }
  } catch (e) {
    cursor.rollback();
    MessageBox.critical(util.translate("scripts", "Hubo un error en la copia del albaran:") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
    return;
  }
  this.iface.tdbRecords.refresh();

  var codAlbaran = util.sqlSelect("albaranescli", "codigo", "idalbaran = " + idAlbaran);
  MessageBox.information(util.translate("scripts", "Se ha generado el albarán de venta %1").arg(codAlbaran), MessageBox.Ok, MessageBox.NoButton);


}


function duplicarDocsCli_duplicarAlbaran(curAlbaran: FLSqlCursor)
{


  var util = new FLUtil();

  if (!this.iface.curAlbaran)
    this.iface.curAlbaran = new FLSqlCursor("albaranescli");

  util.createProgressDialog(util.translate("scripts", "Copiando oferta...."), 3);
  var progreso = 0;

  this.iface.curAlbaran.setModeAccess(this.iface.curAlbaran.Insert);
  this.iface.curAlbaran.refreshBuffer();

  progreso = 1;
  util.setProgress(progreso);

  if (!this.iface.duplicardatosAlbaran(curAlbaran)) {
    util.destroyProgressDialog();
    return false;
  }

  if (!this.iface.curAlbaran.commitBuffer()) {
    util.destroyProgressDialog();
    return false;
  }

  var idAlbaran = this.iface.curAlbaran.valueBuffer("idalbaran");

  progreso = 2;
  util.setProgress(progreso);

  if (!this.iface.duplicarLineasAlbaran(curAlbaran.valueBuffer("idalbaran"), idAlbaran)) {
    util.destroyProgressDialog();
    return false;
  }

  this.iface.curAlbaran.select("idalbaran = " + idAlbaran);
  if (this.iface.curAlbaran.first()) {
    this.iface.curAlbaran.setModeAccess(this.iface.curAlbaran.Edit);
    this.iface.curAlbaran.refreshBuffer();

    progreso = 3;
    util.setProgress(progreso);

    if (!this.iface.totalesAlbaran()) {
      util.destroyProgressDialog();
      return false;
    }
    if (this.iface.curAlbaran.commitBuffer() == false) {
      util.destroyProgressDialog();
      return false;
    }
  }
  util.destroyProgressDialog();
  return idAlbaran;
}


function duplicarDocsCli_duplicardatosAlbaran(curAlbaran)
{

  var util = new FLUtil();
  var fecha: String;
  var hora: String;
  if (curAlbaran.action() == "albaranescli") {
    var hoy = new Date();
    fecha = hoy.toString();
    hora = hoy.toString().right(8);
  } else {
    fecha = curAlbaran.valueBuffer("fecha");
    hora = curAlbaran.valueBuffer("hora");
  }

  var codEjercicio = curAlbaran.valueBuffer("codejercicio");


  with(this.iface.curAlbaran) {
    setValueBuffer("codejercicio", codEjercicio);
    setValueBuffer("fecha", fecha);
    setValueBuffer("hora", hora);
  }

  var aCamposLinea = util.nombreCampos("albaranescli");
  var totalCampos = aCamposLinea[0];

  var campoInformado = [];
  for (var i = 1; i <= totalCampos; i++) {
    campoInformado[aCamposLinea[i]] = false;
  }
  for (var i = 1; i <= totalCampos; i++) {
    if (!this.iface.duplicarCampoAlbaran(aCamposLinea[i], curAlbaran, campoInformado)) {
      util.destroyProgressDialog();
      return false;
    }
  }

  return true;
}




function duplicarDocsCli_duplicarCampoAlbaran(nombreCampo, cursor, campoInformado)
{

  if (campoInformado[nombreCampo]) {
    return true;
  }
  var nulo = false;

  switch (nombreCampo) {
    case "idalbaran":
    case "codejercicio":
    case "numero":
    case "codigo":
    case "impreso":
    case "enviadomailfecha":
    case "enviadomailhora":
    case "enviadomailidusuario":
    case "ptefactura":
    case "idfactura":
    case "enviadomail":
    case "abierto": {
      return true;
      break;
    }
    default: {
      if (cursor.isNull(nombreCampo)) {
        nulo = true;
      } else {
        valor = cursor.valueBuffer(nombreCampo);
      }
    }
  }
  if (nulo) {
    this.iface.curAlbaran.setNull(nombreCampo);
  } else {
    this.iface.curAlbaran.setValueBuffer(nombreCampo, valor);
  }
  campoInformado[nombreCampo] = true;

  return true;
}



function duplicarDocsCli_duplicarHijosAlbaran(idAlbaranOrigen, idAlbaranDestino)
{

  if (!this.iface.duplicarLineasAlbaran(idAlbaranOrigen, idAlbaranDestino)) {
    return false;
  }
  return true;
}

function duplicarDocsCli_duplicarLineaAlbaran(curLineaAlbaran, idAlbaran)
{

  var util = new FLUtil;
  if (!this.iface.curLineaAlbaran) {
    this.iface.curLineaAlbaran = new FLSqlCursor("lineasalbaranescli");
  }

  with(this.iface.curLineaAlbaran) {
    setModeAccess(Insert);
    refreshBuffer();
    setValueBuffer("idalbaran", idAlbaran);
  }

  var aCamposLinea = util.nombreCampos("lineasalbaranescli");
  var totalCampos = aCamposLinea[0];

  var campoInformado = [];
  for (var i = 1; i <= totalCampos; i++) {
    campoInformado[aCamposLinea[i]] = false;
  }

  for (var i = 1; i <= totalCampos; i++) {
    if (!this.iface.duplicarCampoLineaAlbaran(aCamposLinea[i], curLineaAlbaran, campoInformado)) {
      return false;
    }
  }

  //  if (!this.iface.duplicardatosLineaAlbaran(curLineaAlbaran))
  //    return false;

  if (!this.iface.curLineaAlbaran.commitBuffer()) {
    return false;
  }

  return this.iface.curLineaAlbaran.valueBuffer("idlinea");
}

function duplicarDocsCli_duplicarCampoLineaAlbaran(nombreCampo, cursor, campoInformado)
{

  if (campoInformado[nombreCampo]) {
    return true;
  }
  var nulo = false;

  switch (nombreCampo) {
    case "idlineapedido":
    case "idpedido":
    case "idalbaran":
    case "idlinea": {
      return true;
      break;
    }
    default: {
      if (cursor.isNull(nombreCampo)) {
        nulo = true;
      } else {
        valor = cursor.valueBuffer(nombreCampo);
      }
    }
  }
  if (nulo) {
    this.iface.curLineaAlbaran.setNull(nombreCampo);
  } else {
    this.iface.curLineaAlbaran.setValueBuffer(nombreCampo, valor);
  }
  campoInformado[nombreCampo] = true;

  return true;
}

function duplicarDocsCli_duplicarLineasAlbaran(idAlbaranOrigen: Number, idAlbaranDestino: Number)
{

  var curLineaAlbaran = new FLSqlCursor("lineasalbaranescli");
  curLineaAlbaran.select("idalbaran = " + idAlbaranOrigen);

  while (curLineaAlbaran.next()) {
    curLineaAlbaran.setModeAccess(curLineaAlbaran.Browse);
    curLineaAlbaran.refreshBuffer();
    if (!this.iface.duplicarLineaAlbaran(curLineaAlbaran, idAlbaranDestino))
      return false;
  }
  return true;
}

function duplicarDocsCli_totalesAlbaran()
{
  with(this.iface.curAlbaran) {

   setValueBuffer("neto", formalbaranescli.iface.pub_commonCalculateField("neto", this));
   setValueBuffer("totaliva", formalbaranescli.iface.pub_commonCalculateField("totaliva", this));
   setValueBuffer("totalrecargo", formalbaranescli.iface.pub_commonCalculateField("totalrecargo", this));
   setValueBuffer("totalirpf", formalbaranescli.iface.pub_commonCalculateField("totalirpf", this));
   setValueBuffer("total", formalbaranescli.iface.pub_commonCalculateField("total", this));
   setValueBuffer("totaleuros", formalbaranescli.iface.pub_commonCalculateField("totaleuros", this));
  }
  return true;
}


//// DUPLICAR DOCS CLI //////////////////////////////////////////
/////////////////////////////////////////////////////////////////

