
/** @class_declaration duplicarDocsCli */
/////////////////////////////////////////////////////////////////
//// DUPLICAR DOCS CLI //////////////////////////////////////////
class duplicarDocsCli extends ofertasProv /** %from: oficial */
{
  var curPedido: FLSqlCursor;
  var curLineaPedido: FLSqlCursor;

  function duplicarDocsCli(context)
  {
    ofertasProv(context);
  }
  function init()
  {
    return this.ctx.duplicarDocsCli_init();
  }
  function duplicarPedido_clicked()
  {
    return this.ctx.duplicarDocsCli_duplicarPedido_clicked();
  }
  function duplicarPedido(curPedido: FLSqlCursor)
  {
    return this.ctx.duplicarDocsCli_duplicarPedido(curPedido);
  }
  function duplicardatosPedido(curPedido: FLSqlCursor)
  {
    return this.ctx.duplicarDocsCli_duplicardatosPedido(curPedido);
  }
  function duplicarCampoPedido(nombreCampo, cursor, campoInformado)
  {
    return this.ctx.duplicarDocsCli_duplicarCampoPedido(nombreCampo, cursor, campoInformado);
  }
  function duplicarLineasPedido(idPedidoOrigen: Number, idPedidoDestino: Number)
  {
    return this.ctx.duplicarDocsCli_duplicarLineasPedido(idPedidoOrigen, idPedidoDestino);
  }
  function duplicarHijosPedido(idPedidoOrigen, idPedidoDestino)
  {
    return this.ctx.duplicarDocsCli_duplicarHijosPedido(idPedidoOrigen, idPedidoDestino);
  }
  function duplicarLineaPedido(curLineaPedido: FLSqlCursor, idPedido: Number)
  {
    return this.ctx.duplicarDocsCli_duplicarLineaPedido(curLineaPedido, idPedido);
  }
  function duplicarCampoLineaPedido(nombreCampo, cursor, campoInformado)
  {
    return this.ctx.duplicarDocsCli_duplicarCampoLineaPedido(nombreCampo, cursor, campoInformado);
  }
  function totalesPedido()
  {
    return this.ctx.duplicarDocsCli_totalesPedido();
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

  connect(this.child("toolButtonCopy"), "clicked()", this, "iface.duplicarPedido_clicked()");

}



function duplicarDocsCli_duplicarPedido_clicked()
{

  var util = new FLUtil;
  var cursor = this.cursor();

  var idPedido;
  cursor.transaction(false);
  try {
    idPedido = this.iface.duplicarPedido(cursor);
    if (idPedido) {
      cursor.commit();
    } else {
      cursor.rollback();
      return
    }
  } catch (e) {
    cursor.rollback();
    MessageBox.critical(util.translate("scripts", "Hubo un error en la copia del pedido:") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
    return;
  }
  this.iface.tdbRecords.refresh();

  var codPedido = util.sqlSelect("pedidoscli", "codigo", "idpedido = " + idPedido);
  MessageBox.information(util.translate("scripts", "Se ha generado el pedido de cliente %1").arg(codPedido), MessageBox.Ok, MessageBox.NoButton);


}


function duplicarDocsCli_duplicarPedido(curPedido: FLSqlCursor)
{


  var util = new FLUtil();

  if (!this.iface.curPedido)
    this.iface.curPedido = new FLSqlCursor("pedidoscli");

  util.createProgressDialog(util.translate("scripts", "Copiando oferta...."), 3);
  var progreso = 0;

  this.iface.curPedido.setModeAccess(this.iface.curPedido.Insert);
  this.iface.curPedido.refreshBuffer();

  progreso = 1;
  util.setProgress(progreso);

  if (!this.iface.duplicardatosPedido(curPedido)) {
    util.destroyProgressDialog();
    return false;
  }

  if (!this.iface.curPedido.commitBuffer()) {
    util.destroyProgressDialog();
    return false;
  }

  var idPedido = this.iface.curPedido.valueBuffer("idpedido");

  progreso = 2;
  util.setProgress(progreso);

  if (!this.iface.duplicarLineasPedido(curPedido.valueBuffer("idpedido"), idPedido)) {
    util.destroyProgressDialog();
    return false;
  }

  this.iface.curPedido.select("idpedido = " + idPedido);
  if (this.iface.curPedido.first()) {
    this.iface.curPedido.setModeAccess(this.iface.curPedido.Edit);
    this.iface.curPedido.refreshBuffer();

    progreso = 3;
    util.setProgress(progreso);

    if (!this.iface.totalesPedido()) {
      util.destroyProgressDialog();
      return false;
    }
    if (this.iface.curPedido.commitBuffer() == false) {
      util.destroyProgressDialog();
      return false;
    }
  }
  util.destroyProgressDialog();
  return idPedido;
}


function duplicarDocsCli_duplicardatosPedido(curPedido)
{

  var util = new FLUtil();
  var fecha: String;
  var hora: String;
  if (curPedido.action() == "pedidoscli") {
    var hoy = new Date();
    fecha = hoy.toString();
    hora = hoy.toString().right(8);
  } else {
    fecha = curPedido.valueBuffer("fecha");
    hora = curPedido.valueBuffer("hora");
  }

  var codEjercicio = curPedido.valueBuffer("codejercicio");


  with(this.iface.curPedido) {
    setValueBuffer("codejercicio", codEjercicio);
    setValueBuffer("fecha", fecha);
    //setValueBuffer("hora", hora);
  }

  var aCamposLinea = util.nombreCampos("pedidoscli");
  var totalCampos = aCamposLinea[0];

  var campoInformado = [];
  for (var i = 1; i <= totalCampos; i++) {
    campoInformado[aCamposLinea[i]] = false;
  }
  for (var i = 1; i <= totalCampos; i++) {
    if (!this.iface.duplicarCampoPedido(aCamposLinea[i], curPedido, campoInformado)) {
      util.destroyProgressDialog();
      return false;
    }
  }

  return true;
}




function duplicarDocsCli_duplicarCampoPedido(nombreCampo, cursor, campoInformado)
{

  if (campoInformado[nombreCampo]) {
    return true;
  }
  var nulo = false;

  switch (nombreCampo) {
    case "idpedido":
    case "idpresupuesto":
    case "codejercicio":
    case "numero":
    case "codigo":
    case "tramitado":
    case "servido":
    case "impreso":
    case "editable":
    case "enviadomailfecha":
    case "enviadomailhora":
    case "enviadomailidusuario":
    case "enviado":
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
    this.iface.curPedido.setNull(nombreCampo);
  } else {
    this.iface.curPedido.setValueBuffer(nombreCampo, valor);
  }
  campoInformado[nombreCampo] = true;

  return true;
}



function duplicarDocsCli_duplicarHijosPedido(idPedidoOrigen, idPedidoDestino)
{

  if (!this.iface.duplicarLineasPedido(idPedidoOrigen, idPedidoDestino)) {
    return false;
  }
  return true;
}

function duplicarDocsCli_duplicarLineaPedido(curLineaPedido, idPedido)
{

  var util = new FLUtil;
  if (!this.iface.curLineaPedido) {
    this.iface.curLineaPedido = new FLSqlCursor("lineaspedidoscli");
  }

  with(this.iface.curLineaPedido) {
    setModeAccess(Insert);
    refreshBuffer();
    setValueBuffer("idpedido", idPedido);
  }

  var aCamposLinea = util.nombreCampos("lineaspedidoscli");
  var totalCampos = aCamposLinea[0];

  var campoInformado = [];
  for (var i = 1; i <= totalCampos; i++) {
    campoInformado[aCamposLinea[i]] = false;
  }

  for (var i = 1; i <= totalCampos; i++) {
    if (!this.iface.duplicarCampoLineaPedido(aCamposLinea[i], curLineaPedido, campoInformado)) {
      return false;
    }
  }

  //  if (!this.iface.duplicardatosLineaPedido(curLineaPedido))
  //    return false;

  if (!this.iface.curLineaPedido.commitBuffer()) {
    return false;
  }

  return this.iface.curLineaPedido.valueBuffer("idlinea");
}

function duplicarDocsCli_duplicarCampoLineaPedido(nombreCampo, cursor, campoInformado)
{

  if (campoInformado[nombreCampo]) {
    return true;
  }
  var nulo = false;

  switch (nombreCampo) {
    case "idpedido":
    case "idlinea":
    case "codigooferta":
    case "destino":
    case "idlineacli":
    case "codcliente":
    case "nombrecliente":
    case "totalenalbaran":
    case "totalpendiente": {
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
    this.iface.curLineaPedido.setNull(nombreCampo);
  } else {
    this.iface.curLineaPedido.setValueBuffer(nombreCampo, valor);
  }
  campoInformado[nombreCampo] = true;

  return true;
}

function duplicarDocsCli_duplicarLineasPedido(idPedidoOrigen: Number, idPedidoDestino: Number)
{

  var curLineaPedido = new FLSqlCursor("lineaspedidoscli");
  curLineaPedido.select("idpedido = " + idPedidoOrigen);

  while (curLineaPedido.next()) {
    curLineaPedido.setModeAccess(curLineaPedido.Browse);
    curLineaPedido.refreshBuffer();
    if (!this.iface.duplicarLineaPedido(curLineaPedido, idPedidoDestino))
      return false;
  }
  return true;
}

function duplicarDocsCli_totalesPedido()
{
  with(this.iface.curPedido) {

   setValueBuffer("neto", formpedidoscli.iface.pub_commonCalculateField("neto", this));
   setValueBuffer("totaliva", formpedidoscli.iface.pub_commonCalculateField("totaliva", this));
   setValueBuffer("totalrecargo", formpedidoscli.iface.pub_commonCalculateField("totalrecargo", this));
   setValueBuffer("totalirpf", formpedidoscli.iface.pub_commonCalculateField("totalirpf", this));
   setValueBuffer("total", formpedidoscli.iface.pub_commonCalculateField("total", this));
   setValueBuffer("totaleuros", formpedidoscli.iface.pub_commonCalculateField("totaleuros", this));
  }
  return true;
}


//// DUPLICAR DOCS CLI //////////////////////////////////////////
/////////////////////////////////////////////////////////////////

