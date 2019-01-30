
/** @class_declaration duplicarDocsProv */
/////////////////////////////////////////////////////////////////
//// DUPLICAR DOCS PROV /////////////////////////////////////////
class duplicarDocsProv extends etiBarcode /** %from: oficial */
{
  var curAlbaran: FLSqlCursor;
  var curLineaAlbaran: FLSqlCursor;

  function duplicarDocsProv(context)
  {
    etiBarcode(context);
  }
  function init()
  {
    return this.ctx.duplicarDocsProv_init();
  }
  function duplicarAlbaran_clicked()
  {
    return this.ctx.duplicarDocsProv_duplicarAlbaran_clicked();
  }
  function duplicarAlbaran(curAlbaran: FLSqlCursor)
  {
    return this.ctx.duplicarDocsProv_duplicarAlbaran(curAlbaran);
  }
  function duplicardatosAlbaran(curAlbaran: FLSqlCursor)
  {
    return this.ctx.duplicarDocsProv_duplicardatosAlbaran(curAlbaran);
  }
  function duplicarCampoAlbaran(nombreCampo, cursor, campoInformado)
  {
    return this.ctx.duplicarDocsProv_duplicarCampoAlbaran(nombreCampo, cursor, campoInformado);
  }
  function duplicarLineasAlbaran(idAlbaranOrigen: Number, idAlbaranDestino: Number)
  {
    return this.ctx.duplicarDocsProv_duplicarLineasAlbaran(idAlbaranOrigen, idAlbaranDestino);
  }
  function duplicarHijosAlbaran(idAlbaranOrigen, idAlbaranDestino)
  {
    return this.ctx.duplicarDocsProv_duplicarHijosAlbaran(idAlbaranOrigen, idAlbaranDestino);
  }
  function duplicarLineaAlbaran(curLineaAlbaran: FLSqlCursor, idAlbaran: Number)
  {
    return this.ctx.duplicarDocsProv_duplicarLineaAlbaran(curLineaAlbaran, idAlbaran);
  }
  function duplicarCampoLineaAlbaran(nombreCampo, cursor, campoInformado)
  {
    return this.ctx.duplicarDocsProv_duplicarCampoLineaAlbaran(nombreCampo, cursor, campoInformado);
  }
  function totalesAlbaran()
  {
    return this.ctx.duplicarDocsProv_totalesAlbaran();
  }

}

//// DUPLICAR DOCS PROV /////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition duplicarDocsProv */
/////////////////////////////////////////////////////////////////
//// DUPLICAR DOCS PROV /////////////////////////////////////////

function duplicarDocsProv_init()
{

  this.iface.__init();

  connect(this.child("toolButtonCopy"), "clicked()", this, "iface.duplicarAlbaran_clicked()");

}



function duplicarDocsProv_duplicarAlbaran_clicked()
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

  var codAlbaran = util.sqlSelect("albaranesprov", "codigo", "idalbaran = " + idAlbaran);
  MessageBox.information(util.translate("scripts", "Se ha generado el albarán de proveedor %1").arg(codAlbaran), MessageBox.Ok, MessageBox.NoButton);


}


function duplicarDocsProv_duplicarAlbaran(curAlbaran: FLSqlCursor)
{


  var util = new FLUtil();

  if (!this.iface.curAlbaran)
    this.iface.curAlbaran = new FLSqlCursor("albaranesprov");

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


function duplicarDocsProv_duplicardatosAlbaran(curAlbaran)
{

  var util = new FLUtil();
  var fecha: String;
  var hora: String;
  if (curAlbaran.action() == "albaranesprov") {
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

  var aCamposLinea = util.nombreCampos("albaranesprov");
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




function duplicarDocsProv_duplicarCampoAlbaran(nombreCampo, cursor, campoInformado)
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



function duplicarDocsProv_duplicarHijosAlbaran(idAlbaranOrigen, idAlbaranDestino)
{

  if (!this.iface.duplicarLineasAlbaran(idAlbaranOrigen, idAlbaranDestino)) {
    return false;
  }
  return true;
}

function duplicarDocsProv_duplicarLineaAlbaran(curLineaAlbaran, idAlbaran)
{

  var util = new FLUtil;
  if (!this.iface.curLineaAlbaran) {
    this.iface.curLineaAlbaran = new FLSqlCursor("lineasalbaranesprov");
  }

  with(this.iface.curLineaAlbaran) {
    setModeAccess(Insert);
    refreshBuffer();
    setValueBuffer("idalbaran", idAlbaran);
  }

  var aCamposLinea = util.nombreCampos("lineasalbaranesprov");
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

function duplicarDocsProv_duplicarCampoLineaAlbaran(nombreCampo, cursor, campoInformado)
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

function duplicarDocsProv_duplicarLineasAlbaran(idAlbaranOrigen: Number, idAlbaranDestino: Number)
{

  var curLineaAlbaran = new FLSqlCursor("lineasalbaranesprov");
  curLineaAlbaran.select("idalbaran = " + idAlbaranOrigen);

  while (curLineaAlbaran.next()) {
    curLineaAlbaran.setModeAccess(curLineaAlbaran.Browse);
    curLineaAlbaran.refreshBuffer();
    if (!this.iface.duplicarLineaAlbaran(curLineaAlbaran, idAlbaranDestino))
      return false;
  }
  return true;
}

function duplicarDocsProv_totalesAlbaran()
{
  with(this.iface.curAlbaran) {

   setValueBuffer("neto", formalbaranesprov.iface.pub_commonCalculateField("neto", this));
   setValueBuffer("totaliva", formalbaranesprov.iface.pub_commonCalculateField("totaliva", this));
   setValueBuffer("totalrecargo", formalbaranesprov.iface.pub_commonCalculateField("totalrecargo", this));
   setValueBuffer("totalirpf", formalbaranesprov.iface.pub_commonCalculateField("totalirpf", this));
   setValueBuffer("total", formalbaranesprov.iface.pub_commonCalculateField("total", this));
   setValueBuffer("totaleuros", formalbaranesprov.iface.pub_commonCalculateField("totaleuros", this));
  }
  return true;
}


//// DUPLICAR DOCS PROV /////////////////////////////////////////
/////////////////////////////////////////////////////////////////

