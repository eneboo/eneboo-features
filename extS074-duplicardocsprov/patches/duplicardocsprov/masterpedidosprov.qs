
/** @class_declaration duplicarDocsProv */
/////////////////////////////////////////////////////////////////
//// DUPLICAR DOCS PROV /////////////////////////////////////////
class duplicarDocsProv extends ofertasProv /** %from: oficial */
{
  var curPedido: FLSqlCursor;
  var curLineaPedido: FLSqlCursor;

  function duplicarDocsProv(context)
  {
    ofertasProv(context);
  }
  function init()
  {
    return this.ctx.duplicarDocsProv_init();
  }
  function duplicarPedido_clicked()
  {
    return this.ctx.duplicarDocsProv_duplicarPedido_clicked();
  }
  function duplicarPedido(curPedido: FLSqlCursor)
  {
    return this.ctx.duplicarDocsProv_duplicarPedido(curPedido);
  }
  function duplicardatosPedido(curPedido: FLSqlCursor)
  {
    return this.ctx.duplicarDocsProv_duplicardatosPedido(curPedido);
  }
  function duplicarCampoPedido(nombreCampo, cursor, campoInformado)
  {
    return this.ctx.duplicarDocsProv_duplicarCampoPedido(nombreCampo, cursor, campoInformado);
  }
  function duplicarLineasPedido(idPedidoOrigen: Number, idPedidoDestino: Number)
  {
    return this.ctx.duplicarDocsProv_duplicarLineasPedido(idPedidoOrigen, idPedidoDestino);
  }
  function duplicarHijosPedido(idPedidoOrigen, idPedidoDestino)
  {
    return this.ctx.duplicarDocsProv_duplicarHijosPedido(idPedidoOrigen, idPedidoDestino);
  }
  function duplicarLineaPedido(curLineaPedido: FLSqlCursor, idPedido: Number)
  {
    return this.ctx.duplicarDocsProv_duplicarLineaPedido(curLineaPedido, idPedido);
  }
  function duplicarCampoLineaPedido(nombreCampo, cursor, campoInformado)
  {
    return this.ctx.duplicarDocsProv_duplicarCampoLineaPedido(nombreCampo, cursor, campoInformado);
  }
  function totalesPedido()
  {
    return this.ctx.duplicarDocsProv_totalesPedido();
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

  connect(this.child("toolButtonCopy"), "clicked()", this, "iface.duplicarPedido_clicked()");

}



function duplicarDocsProv_duplicarPedido_clicked()
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

  var codPedido = util.sqlSelect("pedidosprov", "codigo", "idpedido = " + idPedido);
  MessageBox.information(util.translate("scripts", "Se ha generado el pedido de proveedor %1").arg(codPedido), MessageBox.Ok, MessageBox.NoButton);


}


function duplicarDocsProv_duplicarPedido(curPedido: FLSqlCursor)
{


  var util = new FLUtil();

  if (!this.iface.curPedido)
    this.iface.curPedido = new FLSqlCursor("pedidosprov");

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


function duplicarDocsProv_duplicardatosPedido(curPedido)
{

  var util = new FLUtil();
  var fecha: String;
  var hora: String;
  if (curPedido.action() == "pedidosprov") {
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

  var aCamposLinea = util.nombreCampos("pedidosprov");
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




function duplicarDocsProv_duplicarCampoPedido(nombreCampo, cursor, campoInformado)
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



function duplicarDocsProv_duplicarHijosPedido(idPedidoOrigen, idPedidoDestino)
{

  if (!this.iface.duplicarLineasPedido(idPedidoOrigen, idPedidoDestino)) {
    return false;
  }
  return true;
}

function duplicarDocsProv_duplicarLineaPedido(curLineaPedido, idPedido)
{

  var util = new FLUtil;
  if (!this.iface.curLineaPedido) {
    this.iface.curLineaPedido = new FLSqlCursor("lineaspedidosprov");
  }

  with(this.iface.curLineaPedido) {
    setModeAccess(Insert);
    refreshBuffer();
    setValueBuffer("idpedido", idPedido);
  }

  var aCamposLinea = util.nombreCampos("lineaspedidosprov");
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

function duplicarDocsProv_duplicarCampoLineaPedido(nombreCampo, cursor, campoInformado)
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

function duplicarDocsProv_duplicarLineasPedido(idPedidoOrigen: Number, idPedidoDestino: Number)
{

  var curLineaPedido = new FLSqlCursor("lineaspedidosprov");
  curLineaPedido.select("idpedido = " + idPedidoOrigen);

  while (curLineaPedido.next()) {
    curLineaPedido.setModeAccess(curLineaPedido.Browse);
    curLineaPedido.refreshBuffer();
    if (!this.iface.duplicarLineaPedido(curLineaPedido, idPedidoDestino))
      return false;
  }
  return true;
}

function duplicarDocsProv_totalesPedido()
{
  with(this.iface.curPedido) {

   setValueBuffer("neto", formpedidosprov.iface.pub_commonCalculateField("neto", this));
   setValueBuffer("totaliva", formpedidosprov.iface.pub_commonCalculateField("totaliva", this));
   setValueBuffer("totalrecargo", formpedidosprov.iface.pub_commonCalculateField("totalrecargo", this));
   setValueBuffer("totalirpf", formpedidosprov.iface.pub_commonCalculateField("totalirpf", this));
   setValueBuffer("total", formpedidosprov.iface.pub_commonCalculateField("total", this));
   setValueBuffer("totaleuros", formpedidosprov.iface.pub_commonCalculateField("totaleuros", this));
  }
  return true;
}


//// DUPLICAR DOCS PROV /////////////////////////////////////////
/////////////////////////////////////////////////////////////////

