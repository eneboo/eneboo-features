/***************************************************************************
                 masterpresupuestosprov.qs  -  description
                             -------------------
    begin                : lun sep 08 2008
    copyright            : (C) 2008 by InfoSiAL S.L.
    email                : mail@infosial.com
 ***************************************************************************/
/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

/** @file */

/** @class_declaration interna */
////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
class interna
{
  var ctx: Object;
  function interna(context)
  {
    this.ctx = context;
  }
  function init()
  {
    return this.ctx.interna_init();
  }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna
{
  var tdbRecords: FLTableDB;
  var chkPendiente: Object;
  var chkEnviada: Object;
  var chkRecibida: Object;
  var chkAnulada: Object;
  var chkTodas: Object;
  var filtroProcedencia_: String;
  var filtroEstado_: String;
  var valor_: String;
  var curLineaOferta: FLSqlCursor;
  var tipoInsercion_: String;
  var pbnGenerarPedido: Object;
  var curPedido: FLSqlCursor;
  var curLineaPedido: FLSqlCursor;
  var curPresupuesto: FLSqlCursor;
  var curLineaPresupuesto: FLSqlCursor;

  var mensajeFinal: String;


  function oficial(context)
  {
    interna(context);
  }
  function imprimir(codPresupuesto: String)
  {
    return this.ctx.oficial_imprimir(codPresupuesto);
  }
  function filtrarTabla()
  {
    return this.ctx.oficial_filtrarTabla();
  }
  function filtroEstado(): String {
    return this.ctx.oficial_filtroEstado();
  }
  function filtroProcedencia()
  {
    return this.ctx.oficial_filtroProcedencia();
  }
  function refrescarFiltro(opcion: String)
  {
    return this.ctx.oficial_refrescarFiltro(opcion);
  }
  function introduccionDatos_clicked()
  {
    return this.ctx.oficial_introduccionDatos_clicked();
  }
  //  function introduccionDatos(codPresupuesto:String):Boolean {
  //    return this.ctx.oficial_introduccionDatos(codPresupuesto);
  //  }
  //  function generarLineas(curDatos:FLSqlCursor):Boolean {
  //    return this.ctx.oficial_generarLineas(curDatos);
  //  }
  //  function actualizarArticulosProv(xmlLinea:FLDomElement, codProveedor:String):Boolean {
  //    return this.ctx.oficial_actualizarArticulosProv(xmlLinea, codProveedor);
  //  }
  function commonCalculateField(fN: String, cursor: FLSqlCursor): String {
    return this.ctx.oficial_commonCalculateField(fN, cursor);
  }
  function generarPedido_clicked()
  {
    return this.ctx.oficial_generarPedido_clicked();
  }
  function generarPedido(curPresupuesto: FLSqlCursor): Number {
    return this.ctx.oficial_generarPedido(curPresupuesto);
  }
  function datosPedido(curPresupuesto: FLSqlCursor): Boolean {
    return this.ctx.oficial_datosPedido(curPresupuesto);
  }
  function copiaLineas(idPresupuesto: Number, idPedido: Number): Boolean {
    return this.ctx.oficial_copiaLineas(idPresupuesto, idPedido);
  }
  function copiaLineaPresupuesto(curLineaPresupuesto: FLSqlCursor, idPedido: Number): Number {
    return this.ctx.oficial_copiaLineaPresupuesto(curLineaPresupuesto, idPedido);
  }
  function totalesPedido(): Boolean {
    return this.ctx.oficial_totalesPedido();
  }
  function datosLineaPedido(curLineaPresupuesto: FLSqlCursor): Boolean {
    return this.ctx.oficial_datosLineaPedido(curLineaPresupuesto);
  }
  function comprobarPedidosAbertos(curPresupuesto: FLSqlCursor): String {
    return this.ctx.oficial_comprobarPedidosAbertos(curPresupuesto);
  }
  function buscarPedidosAbiertos(codProveedor: String): Array {
    return this.ctx.oficial_buscarPedidosAbiertos(codProveedor);
  }
  function duplicarPresupuesto_clicked()
  {
    return this.ctx.oficial_duplicarPresupuesto_clicked();
  }
  function duplicarPresupuesto(curPresupuesto: FLSqlCursor)
  {
    return this.ctx.oficial_duplicarPresupuesto(curPresupuesto);
  }
  function duplicardatosPresupuesto(curPresupuesto: FLSqlCursor)
  {
    return this.ctx.oficial_duplicardatosPresupuesto(curPresupuesto);
  }
  function duplicarCampoPresupuesto(nombreCampo, cursor, campoInformado)
  {
    return this.ctx.oficial_duplicarCampoPresupuesto(nombreCampo, cursor, campoInformado);
  }
  function duplicarLineasPresupuesto(idPresupuestoOrigen: Number, idPresupuestoDestino: Number)
  {
    return this.ctx.oficial_duplicarLineasPresupuesto(idPresupuestoOrigen, idPresupuestoDestino);
  }
  function duplicarHijosPresupuesto(idPresupuestoOrigen, idPresupuestoDestino)
  {
    return this.ctx.oficial_duplicarHijosPresupuesto(idPresupuestoOrigen, idPresupuestoDestino);
  }
  function duplicarLineaPresupuesto(curLineaPresupuesto: FLSqlCursor, idPresupuesto: Number)
  {
    return this.ctx.oficial_duplicarLineaPresupuesto(curLineaPresupuesto, idPresupuesto);
  }
  function duplicarCampoLineaPresupuesto(nombreCampo, cursor, campoInformado)
  {
    return this.ctx.oficial_duplicarCampoLineaPresupuesto(nombreCampo, cursor, campoInformado);
  }
  function totalesPresupuesto()
  {
    return this.ctx.oficial_totalesPresupuesto();
  }
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration orderCols */
/////////////////////////////////////////////////////////////////
//// ORDER COLS /////////////////////////////////////////////////
class orderCols extends oficial /** %from: oficial */ {
    function orderCols( context ) { oficial ( context ); }
	function init() {
		return this.ctx.orderCols_init();
	}
    function reordenarColumnas() {
		return this.ctx.orderCols_reordenarColumnas();
	}
}
/////////////////////////////////////////////////////////////////
//// ORDER COLS /////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends orderCols
{
  function head(context)
  {
    orderCols(context);
  }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head
{
  function ifaceCtx(context)
  {
    head(context);
  }
  function pub_imprimir(codPresupuesto: String)
  {
    return this.imprimir(codPresupuesto);
  }
  function pub_commonCalculateField(fN: String, cursor: FLSqlCursor): String {
    return this.commonCalculateField(fN, cursor);
  }
}

const iface = new ifaceCtx(this);
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition interna */
////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
function interna_init()
{
  this.iface.chkPendiente = this.child("chkPendiente");
  this.iface.chkEnviada = this.child("chkEnviada");
  this.iface.chkRecibida = this.child("chkRecibida");
  this.iface.chkAnulada = this.child("chkAnulada");
  this.iface.chkTodas = this.child("chkTodas");
  this.iface.tdbRecords = this.child("tableDBRecords");
  this.iface.pbnGenerarPedido = this.child("pbnGenerarPedido");

  connect(this.child("toolButtonPrint"), "clicked()", this, "iface.imprimir");
  connect(this.child("tbnOferta"), "clicked()", this, "iface.filtroProcedencia()");
  connect(this.child("gbnOfertas"), "clicked(int)", this, "iface.refrescarFiltro()");
  connect(this.child("tbnIntroduccionDatos"), "clicked()", this, "iface.introduccionDatos_clicked()");
  connect(this.iface.pbnGenerarPedido, "clicked()", this, "iface.generarPedido_clicked");

  connect(this.child("toolButtonCopy"), "clicked()", this, "iface.duplicarPresupuesto_clicked()");

  if (this.iface.chkPendiente)
    connect(this.iface.chkPendiente, "clicked()", this, "iface.filtroEstado()");
  if (this.iface.chkEnviada)
    connect(this.iface.chkEnviada, "clicked()", this, "iface.filtroEstado()");
  if (this.iface.chkRecibida)
    connect(this.iface.chkRecibida, "clicked()", this, "iface.filtroEstado()");
  if (this.iface.chkAnulada)
    connect(this.iface.chkAnulada, "clicked()", this, "iface.filtroEstado()");
  if (this.iface.chkTodas)
    connect(this.iface.chkTodas, "clicked()", this, "iface.filtroEstado()");

  this.iface.tipoInsercion_ = false;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \C
Al pulsar el botón imprimir se lanzará el informe correspondiente a la oferta seleccionada (en caso de que el módulo de informes esté cargado)
\end */
function oficial_imprimir(codPresupuesto: String)
{
  if (sys.isLoadedModule("flfactinfo")) {
    var codigo: String;
    if (codPresupuesto) {
      codigo = codPresupuesto;
    } else {
      if (!this.cursor().isValid())
        return;
      codigo = this.cursor().valueBuffer("codigo");
    }
    var curImprimir: FLSqlCursor = new FLSqlCursor("i_presupuestosprov");
    curImprimir.setModeAccess(curImprimir.Insert);
    curImprimir.refreshBuffer();
    curImprimir.setValueBuffer("descripcion", "temp");
    curImprimir.setValueBuffer("d_presupuestosprov_codigo", codigo);
    curImprimir.setValueBuffer("h_presupuestosprov_codigo", codigo);
    flfactinfo.iface.pub_lanzarInforme(curImprimir, "i_presupuestosprov");
  } else
    flfactppal.iface.pub_msgNoDisponible("Informes");
}

function oficial_filtrarTabla()
{
  var filtro: String = "";
  if (this.iface.filtroProcedencia_ && this.iface.filtroProcedencia_ != "") {
    filtro = this.iface.filtroProcedencia_;
  }
  if (this.iface.filtroEstado_ && this.iface.filtroEstado_ != "") {
    if (filtro != "")
      filtro += " AND ";
    filtro += this.iface.filtroEstado_;
  }
  if (!this.iface.filtroProcedencia_ && !this.iface.filtroEstado_) {
    filtro = "";
  }

  debug("FILTRO " + filtro);
  this.iface.tdbRecords.cursor().setMainFilter(filtro);
  this.iface.tdbRecords.refresh();
}

function oficial_filtroProcedencia()
{
  var util: FLUtil = new FLUtil();
  var cursor: FLSqlCursor = this.cursor();

  var opcion: Number = this.child("gbnOfertas").selectedId;
  switch (opcion) {
    case 0: {
      var proveedor: Object = new FLFormSearchDB("proveedores");
      var curProveedor: FLSqlCursor = proveedor.cursor();
      proveedor.setMainWidget();
      var codProveedor: String = proveedor.exec("codproveedor");
      if (codProveedor) {
        var nombre: String = util.sqlSelect("proveedores", "nombre", "codproveedor = '" + codProveedor + "'");
        this.child("txtValor").setText(codProveedor + ":  " + nombre);
      } else {
        this.child("txtValor").setText(this.iface.valor_);
      }
      this.iface.filtroProcedencia_ = "codproveedor = '" + codProveedor + "'";
      break;
    }
    case 1: {
      var presupuesto: Object = new FLFormSearchDB("pedidoscli");
      var curPresupuesto: FLSqlCursor = presupuesto.cursor();
      presupuesto.setMainWidget();
      var codPresupuesto: String = presupuesto.exec("codigo");
      if (codPresupuesto) {
        this.child("txtValor").setText(codPresupuesto);
      } else {
        this.child("txtValor").setText(this.iface.valor_);
      }
      this.iface.filtroProcedencia_ = "codpedidocli = '" + codPresupuesto + "'";
      break;
    }
    case 2: {
      var articulo: Object = new FLFormSearchDB("articulos");
      //      var curPresupuesto:FLSqlCursor = articulo.cursor();
      articulo.setMainWidget();
      var referencia: String = articulo.exec("referencia");
      if (referencia) {
        this.child("txtValor").setText(referencia + ": " + util.sqlSelect("articulos", "descripcion", "referencia = '" + referencia + "'"));
      } else {
        this.child("txtValor").setText(this.iface.valor_);
      }
      this.iface.filtroProcedencia_ = "idpresupuesto IN (SELECT idpresupuesto FROM lineaspresupuestosprov WHERE referencia = '" + referencia + "')";
      break;
    }
  }
  this.iface.filtrarTabla();
}

function oficial_filtroEstado()
{
  var filtro: String = "";
  var listaEstados = "";

  if (this.iface.chkPendiente && this.iface.chkPendiente.checked)
    listaEstados += "'Pendiente'";

  if (this.iface.chkEnviada && this.iface.chkEnviada.checked) {
    if (listaEstados != "")
      listaEstados += ", ";
    listaEstados += "'Tramitada'";
  }

  if (this.iface.chkRecibida && this.iface.chkRecibida.checked) {
    if (listaEstados != "")
      listaEstados += ", ";
    listaEstados += "'Aprobada'";
  }

  if (this.iface.chkAnulada && this.iface.chkAnulada.checked) {
    if (listaEstados != "")
      listaEstados += ", ";
    listaEstados += "'Anulada'";
  }

  if (listaEstados != "") {
    filtro = "estado IN (" + listaEstados + ")";
  } /*else {
    filtro = "1 = 2";
  }*/

  this.iface.filtroEstado_ = filtro;
  this.iface.filtrarTabla();
}

function oficial_refrescarFiltro(opcion: Number)
{
  var util: FLUtil = new FLUtil();
  var cursor: FLSqlCursor = this.cursor();

  switch (opcion) {
    case 0: {
      this.iface.valor_ = util.translate("scripts", "Indique proveedor...");
      break;
    }
    case 1: {
      this.iface.valor_ = util.translate("scripts", "Indique pedido...");
      break;
    }
    case 2: {
      this.iface.valor_ = util.translate("scripts", "Indique artículo...");
      break;
    }
  }
  this.child("txtValor").setText(this.iface.valor_);
  this.iface.filtroProcedencia_ = "";
  this.iface.filtrarTabla();
}

function oficial_introduccionDatos_clicked()
{
  var cursor: FLSqlCursor = this.cursor();
  var util: FLUtil = new FLUtil();

  this.iface.tipoInsercion_ = "Precios";

  this.child("toolButtonEdit").animateClick();
  //  var curOferta:FLSqlCursor = this.iface.tdbRecords.cursor();
  //  var codPresupuesto:String = util.sqlSelect("presupuestosprov", "codigo", "idpresupuesto = " + curOferta.valueBuffer("idpresupuesto"));
  //
  //  if (!this.iface.introduccionDatos(codPresupuesto))
  //    return;
  //
  //  this.iface.tdbRecords.refresh();
}

// function oficial_introduccionDatos(codPresupuesto:String):Boolean
// {
//  var util:FLUtil = new FLUtil();
//  util.sqlDelete("datosofertaprov", "usuario = '" + sys.nameUser() + "'");
//
//  var f:Object = new FLFormSearchDB("datosofertaprov");
//  var curDatos:FLSqlCursor = f.cursor();
//  curDatos.setModeAccess(curDatos.Insert);
//  curDatos.refreshBuffer();
//  curDatos.setValueBuffer("usuario", sys.nameUser());
//
//  var idPresupuesto:String = util.sqlSelect("presupuestosprov", "idpresupuesto", "codigo = '" + codPresupuesto + "'");
//  curDatos.setValueBuffer("idpresupuestoprov", idPresupuesto);
//  curDatos.setValueBuffer("codpresupuestoprov", codPresupuesto);
//  var codProveedor:String = util.sqlSelect("presupuestosprov", "codproveedor", "codigo = '" + codPresupuesto + "'");
//  if (codProveedor)
//    curDatos.setValueBuffer("codproveedor", codProveedor);
//
//  if (!curDatos.commitBuffer())
//    return false;;
//
//  curDatos.select("usuario = '" + sys.nameUser() + "'");
//  if (!curDatos.first())
//    return false;
//
//  curDatos.setModeAccess(curDatos.Edit);
//  curDatos.refreshBuffer();
//
//  f.setMainWidget();
//  curDatos.refreshBuffer();
//  var acpt:String = f.exec("usuario");
//  if (!acpt)
//    return false;
//
//  var idBuffer:String = curDatos.valueBuffer("id");
//  curDatos.commitBuffer();
//  curDatos.select("id = " + idBuffer);
//  if (!curDatos.first())
//    return false;
//
//  curDatos.setModeAccess(curDatos.Browse);
//  curDatos.refreshBuffer();
//
//  curDatos.transaction(false);
//  try {
//    if (this.iface.generarLineas(curDatos)) {
//      curDatos.commit();
//    } else {
//      curDatos.rollback();
//    }
//  }
//  catch (e) {
//    curDatos.rollback();
//    MessageBox.critical(util.translate("scripts", "Hubo un error en la generación de las líneas:\n%1").arg(e), MessageBox.Ok, MessageBox.NoButton);
//  }
//  return true;
// }

// function oficial_generarLineas(curDatos:FLSqlCursor):Boolean
// {
//  var util:FLUtil = new FLUtil;
//
//  var cursor:FLSqlCursor = this.cursor();
//  var codProveedor:String = cursor.valueBuffer("codproveedor");
//  var contenido:String = curDatos.valueBuffer("datos");
//  var docXML:FLDomDocument = new FLDomDocument;
//  if (!docXML.setContent(contenido)) {
//    return false;
//  }
//
//  var listaXMLLineas:FLDomNodeList = docXML.firstChild().childNodes();
//  var xmlLinea:FLDomElement;
//  for (var i:Number = 0; i < listaXMLLineas.length(); i++) {
//    xmlLinea = listaXMLLineas.item(i).toElement();
//    var curLineasOferta:FLSqlCursor = new FLSqlCursor("lineaspresupuestosprov");
//    curLineasOferta.select("idlinea = " + xmlLinea.attribute("IdLinea"));
//    if (!curLineasOferta.first())
//      return false;
//    curLineasOferta.setModeAccess(curLineasOferta.Edit);
//    curLineasOferta.refreshBuffer();
//
//    curLineasOferta.setValueBuffer("pvpunitario", xmlLinea.attribute("Coste"));
//    curLineasOferta.setValueBuffer("dto", xmlLinea.attribute("Dto"));
//    curLineasOferta.setValueBuffer("plazo", xmlLinea.attribute("Plazo"));
//
//    if (!curLineasOferta.commitBuffer())
//      return false;
//
//    if (curDatos.valueBuffer("actualizarprov") == true) {
//      if (!this.iface.actualizarArticulosProv(xmlLinea, codProveedor))
//        return false;
//    }
//  }
//
//  return true;
// }

// function oficial_actualizarArticulosProv(xmlLinea:FLDomElement, codProveedor:String):Boolean
// {
//  var util:FLUtil = new FLUtil();
//  var nombreProveedor:String = util.sqlSelect("proveedores", "nombre", "codproveedor = '" + codProveedor + "'");
//  var curArticulosProv:FLSqlCursor = new FLSqlCursor("articulosprov");
//  curArticulosProv.select("referencia = '" + xmlLinea.attribute("Referencia") + "' AND codproveedor = '" + codProveedor + "'");
//  if (!curArticulosProv.first()) {
//    curArticulosProv.setModeAccess(curArticulosProv.Insert);
//    curArticulosProv.refreshBuffer();
//
//    curArticulosProv.setValueBuffer("referencia", xmlLinea.attribute("Referencia"));
//    curArticulosProv.setValueBuffer("codproveedor", codProveedor);
//    curArticulosProv.setValueBuffer("nombre", nombreProveedor);
//    curArticulosProv.setValueBuffer("coste", xmlLinea.attribute("Coste"));
//    curArticulosProv.setValueBuffer("dto", xmlLinea.attribute("Dto"));
//    curArticulosProv.setValueBuffer("plazo", xmlLinea.attribute("Plazo"));
//    curArticulosProv.setValueBuffer("coddivisa", "EUR");
//
//    if (!curArticulosProv.commitBuffer())
//      return false;
//  }
//  curArticulosProv.setModeAccess(curArticulosProv.Edit);
//  curArticulosProv.refreshBuffer();
//
//  curArticulosProv.setValueBuffer("coste", xmlLinea.attribute("Coste"));
//  curArticulosProv.setValueBuffer("dto", xmlLinea.attribute("Dto"));
//  curArticulosProv.setValueBuffer("plazo", xmlLinea.attribute("Plazo"));
//
//  if (!curArticulosProv.commitBuffer())
//    return false;
//
//  return true;
// }

function oficial_commonCalculateField(fN: String, cursor: FLSqlCursor): String {
  var util: FLUtil = new FLUtil();
  var valor: String;

  switch (fN)
  {
      /** \C
      El --código-- se construye como la concatenación de --codserie--, --codejercicio-- y --numero--
      \end */
    case "codigo": {
      valor = flfacturac.iface.pub_construirCodigo(cursor.valueBuffer("codserie"), cursor.valueBuffer("codejercicio"), cursor.valueBuffer("numero"));
      break;
    }
  }
  return valor;
}

function oficial_generarPedido_clicked()
{
  var util: FLUtil = new FLUtil;
  var cursor: FLSqlCursor = this.cursor();
  var resultadoComPedAbertos: String;

  var idPresupuesto: String = cursor.valueBuffer("idpresupuesto");
  if (!idPresupuesto)
    return false;

  if (cursor.valueBuffer("estado") != "Aprobada")
  {
    MessageBox.warning(util.translate("scripts", "Para poder generar el pedido la oferta debe estar en estado Aprobada."), MessageBox.Ok, MessageBox.NoButton);
    return false;
  }

  if (!util.sqlSelect("lineaspresupuestosprov", "idlinea", "idpresupuesto = " + idPresupuesto + " AND aprobado"))
  {
    MessageBox.warning(util.translate("scripts", "La oferta seleccionada no contiene ninguna línea aprobada."), MessageBox.Ok, MessageBox.NoButton);
    return false;
  }


  resultadoComPedAbertos = this.iface.comprobarPedidosAbertos(cursor);

  switch (resultadoComPedAbertos) {
    case "CANCELA": {
      debug("oficial_generarPedido_clicked  CANCELAMOS XENERACION DE PEDIDO");
      return false;
      break;
    }
    case "NOVO": {
      debug("oficial_generarPedido_clicked  GENERAMOS PEDIDO NOVO");
      cursor.transaction(false);
      try {
        if (this.iface.generarPedido(cursor))
          cursor.commit();
        else
          cursor.rollback();
      } catch (e) {
        cursor.rollback();
        MessageBox.critical(util.translate("scripts", "Hubo un error en la generación del pedido:") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
      }
      break;
    }
     default: {
      debug("oficial_generarPedido_clicked  DEBEMOS INTEGRAR O ASUNTO NO PEDIDO: " + resultadoComPedAbertos);
      var idPedido: String = util.sqlSelect("pedidosprov", "idpedido", "codigo = '" + resultadoComPedAbertos + "'");

      if (!idPedido) {
          MessageBox.critical(util.translate("scripts", "Hubo un error sleccionando el pedido:") + resultadoComPedAbertos, MessageBox.Ok, MessageBox.NoButton);
          return false;
      }

      if (!this.iface.copiaLineas(idPresupuesto, idPedido)) {
           MessageBox.critical(util.translate("scripts", "Hubo un error integrando lineas en el pedido:") + resultadoComPedAbertos, MessageBox.Ok, MessageBox.NoButton);
        return false;
      }

      this.iface.curPedido.select("idpedido = " + idPedido);
      if (this.iface.curPedido.first())
      {
        this.iface.curPedido.setModeAccess(this.iface.curPedido.Edit);
        this.iface.curPedido.refreshBuffer();

        if (!this.iface.totalesPedido())
          return false;

        if (this.iface.curPedido.commitBuffer() == false)
          return false;
      }



      //SIAGAL Como non retornamos false poñemos o estado en tramitado
      util.sqlUpdate("presupuestosprov", "estado", "Tramitada", "idpresupuesto = " + idPresupuesto);
      util.sqlUpdate("presupuestosprov", "codigopedidoprov", resultadoComPedAbertos, "idpresupuesto = " + idPresupuesto);


      break;
    }
  }

  this.iface.tdbRecords.refresh();



}






function oficial_generarPedido(curPresupuesto: FLSqlCursor): Number {
  var util: FLUtil;

  var idPresupuesto: String = curPresupuesto.valueBuffer("idpresupuesto");
  if (!idPresupuesto)
    return false;


  if (!this.iface.curPedido)
    this.iface.curPedido = new FLSqlCursor("pedidosprov");

  this.iface.curPedido.setModeAccess(this.iface.curPedido.Insert);
  this.iface.curPedido.refreshBuffer();
  this.iface.curPedido.setValueBuffer("idpresupuesto", idPresupuesto);

  if (!this.iface.datosPedido(curPresupuesto))
    return false;

  if (!this.iface.curPedido.commitBuffer())
    return false;

  var idPedido: Number = this.iface.curPedido.valueBuffer("idpedido");

  if (!this.iface.copiaLineas(idPresupuesto, idPedido))
    return false;

  this.iface.curPedido.select("idpedido = " + idPedido);
  if (this.iface.curPedido.first())
  {
    this.iface.curPedido.setModeAccess(this.iface.curPedido.Edit);
    this.iface.curPedido.refreshBuffer();

    if (!this.iface.totalesPedido())
      return false;

    if (this.iface.curPedido.commitBuffer() == false)
      return false;
  }

  //SIAGAL Como non retornamos false poñemos o estado en tramitado
  util.sqlUpdate("presupuestosprov", "estado", "Tramitada", "idpresupuesto = " + idPresupuesto);
  util.sqlUpdate("presupuestosprov", "codigopedidoprov", this.iface.curPedido.valueBuffer("codigo"), "idpresupuesto = " + idPresupuesto);


  return idPedido;
}

/** \D Informa los datos de un pedido a partir de los de un presupuesto
@param  curPresupuesto: Cursor que contiene los datos a incluir en el pedido
@return True si el cálculo se realiza correctamente, false en caso contrario
\end */
function oficial_datosPedido(curPresupuesto: FLSqlCursor): Boolean {
  var util: FLUtil;

  var hoy: Date = new Date();
  var fecha: String = hoy.toString();

  var codEjercicio: String = curPresupuesto.valueBuffer("codejercicio");
  var fechaEntrada: String = curPresupuesto.valueBuffer("frecepcion");

  var datosDoc: Array = flfacturac.iface.pub_datosDocFacturacion(fecha, codEjercicio, "pedidosprov");
  if (!datosDoc.ok)
    return false;
  if (datosDoc.modificaciones == true)
  {
    codEjercicio = datosDoc.codEjercicio;
    fecha = datosDoc.fecha;
  }

  var codProveedor: String = curPresupuesto.valueBuffer("codproveedor");
  var cifNif: String = util.sqlSelect("proveedores", "cifnif", "codproveedor = '" + codProveedor + "'");
  var codPago: String = util.sqlSelect("proveedores", "codpago", "codproveedor = '" + codProveedor + "'");
  if (!codPago || codPago == "")
    codPago = flfactppal.iface.pub_valorDefectoEmpresa("codpago");
  var codDivisa: String = util.sqlSelect("proveedores", "coddivisa", "codproveedor = '" + codProveedor + "'");
  if (!codDivisa || codDivisa == "")
    codDivisa = flfactppal.iface.pub_valorDefectoEmpresa("coddivisa");
  var tasaConv: Number = util.sqlSelect("divisas", "tasaconv", "coddivisa = '" + codDivisa + "'");

  with(this.iface.curPedido)
  {
    setValueBuffer("codserie", curPresupuesto.valueBuffer("codserie"));
    setValueBuffer("codejercicio", codEjercicio);
    //setValueBuffer("irpf", curPresupuesto.valueBuffer("irpf"));   NON TEMOS IRPF NESTE PUNTO
    setValueBuffer("fecha", fecha);
    setValueBuffer("codalmacen", flfactppal.iface.pub_valorDefectoEmpresa("codalmacen"));
    setValueBuffer("codpago", codPago);
    setValueBuffer("coddivisa", codDivisa);
    setValueBuffer("tasaconv", tasaConv);
    setValueBuffer("codproveedor", codProveedor);
    setValueBuffer("cifnif", cifNif);
    setValueBuffer("nombre", curPresupuesto.valueBuffer("nombreproveedor"));
    setValueBuffer("recfinanciero", 0);
    setValueBuffer("observaciones", curPresupuesto.valueBuffer("observaciones"));
    setValueBuffer("fechaentrada", fechaEntrada);

    //Agora vai na liña setValueBuffer("codigooferta", curPresupuesto.valueBuffer("codigo"));


  }

  return true;
}

/** \D
Copia las líneas de un pedido como líneas de su albarán asociado
@param idPresupuesto: Identificador del pedido
@param idPedido: Identificador del pedido
\end */
function oficial_copiaLineas(idPresupuesto: Number, idPedido: Number): Boolean {
  var curLineaPresupuesto: FLSqlCursor = new FLSqlCursor("lineaspresupuestosprov");
  curLineaPresupuesto.select("idpresupuesto = " + idPresupuesto + " AND aprobado");
  while (curLineaPresupuesto.next())
  {
    curLineaPresupuesto.setModeAccess(curLineaPresupuesto.Browse);
    curLineaPresupuesto.refreshBuffer();
    if (!this.iface.copiaLineaPresupuesto(curLineaPresupuesto, idPedido))
      return false;
  }
  return true;
}

function oficial_copiaLineaPresupuesto(curLineaPresupuesto: FLSqlCursor, idPedido: Number): Number {
  if (!this.iface.curLineaPedido)
    this.iface.curLineaPedido = new FLSqlCursor("lineaspedidosprov");

  with(this.iface.curLineaPedido)
  {
    setModeAccess(Insert);
    refreshBuffer();
    setValueBuffer("idpedido", idPedido);
  }

  if (!this.iface.datosLineaPedido(curLineaPresupuesto))
    return false;

  if (!this.iface.curLineaPedido.commitBuffer())
    return false;

  return this.iface.curLineaPedido.valueBuffer("idlinea");
}

/** \D Copia los datos de una línea de presupuesto en una línea de pedido
@param  curLineaPresupuesto: Cursor que contiene los datos a incluir en la línea de pedido
@return True si la copia se realiza correctamente, false en caso contrario
\end */
function oficial_datosLineaPedido(curLineaPresupuesto: FLSqlCursor): Boolean {
  var dto: Number = curLineaPresupuesto.valueBuffer("dto");

  var util = new FLUtil;

  //debug(">>>>>>>>><<<<<<<<<<<>>>>>>>>>><<<<<<<<<< oficial_datosLineaPedido");

  //SIAGAL para obter e pasar ás liñas do pedido o cliente relacionado
  //debug(">>>>>>>>><<<<<<<<<<<>>>>>>>>>><<<<<<<<<< oficial_datosLineaPedido    idpresupuesto:" + curLineaPresupuesto.valueBuffer("idpresupuesto"));
  var codCliente: String = util.sqlSelect("presupuestosprov", "codcliente", "idpresupuesto = " + curLineaPresupuesto.valueBuffer("idpresupuesto"));
  var nombreCliente: String = util.sqlSelect("presupuestosprov", "nombrecliente", "idpresupuesto = " + curLineaPresupuesto.valueBuffer("idpresupuesto"));
  var codigoOferta:String = util.sqlSelect("presupuestosprov", "codigo", "idpresupuesto = " + curLineaPresupuesto.valueBuffer("idpresupuesto"));
   // debug(">>>>>>>>><<<<<<<<<<<>>>>>>>>>><<<<<<<<<< codCliente: " + codCliente);
    //debug(">>>>>>>>><<<<<<<<<<<>>>>>>>>>><<<<<<<<<< nombreCliente: " + nombreCliente);

  var codImpuesto: String;
  var iva: Number;
  var recargo: Number;
  var irpf: Number;
  var fecha: Date = util.sqlSelect("presupuestosprov", "frecepcion", "idpresupuesto = " + curLineaPresupuesto.valueBuffer("idpresupuesto"));
  var codSerie: String = util.sqlSelect("presupuestosprov", "codserie", "idpresupuesto = " + curLineaPresupuesto.valueBuffer("idpresupuesto"));
  var pvpSinDto: Number;
  var pvpTotal: Number;
  var dtoPor: Number
  var codTalla: String;
  var codColor:String;
  var barCode:String;


  with(this.iface.curLineaPedido)
  {
    setValueBuffer("idlineapresupuesto", curLineaPresupuesto.valueBuffer("idlinea"));
    setValueBuffer("pvpunitario", curLineaPresupuesto.valueBuffer("pvpunitario"));
    setValueBuffer("cantidad", curLineaPresupuesto.valueBuffer("cantidad"));
    setValueBuffer("referencia", curLineaPresupuesto.valueBuffer("referencia"));
    setValueBuffer("descripcion", curLineaPresupuesto.valueBuffer("descripcion"));
    setValueBuffer("numlinea", curLineaPresupuesto.valueBuffer("numlinea"));



    if (dto)
      setValueBuffer("dtopor", dto);
    else
      setValueBuffer("dtopor", 0);

    //SIAGAL pasamos os barcodes
    codTalla = curLineaPresupuesto.valueBuffer("talla");
    codColor = curLineaPresupuesto.valueBuffer("color");
    barCode = curLineaPresupuesto.valueBuffer("barcode");
    debug(">>>>>masterpresupuestosprov.qs   oficial_datosLineaPedido     talla: " + codTalla + "      color: " + codColor + "          barcode: " + barCode);

    setValueBuffer("talla",codTalla);
    setValueBuffer("color", codColor);
    setValueBuffer("barcode", barCode);


    //SIAGAL facemos esto para deixar pasar referencias en branco, pero non terán IVA
    codImpuesto = formRecordlineaspedidosprov.iface.pub_commonCalculateField("codimpuesto", this);
    if (!codImpuesto)
      codImpuesto = "";

    //SIAGAL Impostos, pasamos do commonCalculateField
    iva = flfacturac.iface.pub_campoImpuesto("iva", codImpuesto, fecha, "prov");
    if (isNaN(iva))
       iva = "";


    if (flfactppal.iface.pub_valorDefectoEmpresa("recequivalencia" == true)) {
      recargo = flfacturac.iface.pub_campoImpuesto("recargo", codimpuesto, fecha, "prov");
    } else {
      recargo = "";
    }
    if (isNaN(recargo))
        recargo = "";


    irpf = util.sqlSelect("series", "irpf", "codserie = '" + codSerie + "'");
    if (isNaN(irpf))
        irpf = "";

    pvpSinDto = parseFloat(curLineaPresupuesto.valueBuffer("pvpunitario")) * parseFloat(curLineaPresupuesto.valueBuffer("cantidad"));
    pvpSinDto = util.roundFieldValue(pvpSinDto, "lineaspedidosprov", "pvptotal");

    dtoPor = (curLineaPresupuesto.valueBuffer("pvpsindto") * curLineaPresupuesto.valueBuffer("dtopor")) / 100;
    dtoPor = util.roundFieldValue(dtoPor, "lineaspedidosprov", "pvpsindto");
    pvpTotal = curLineaPresupuesto.valueBuffer("pvpsindto") - parseFloat(dtoPor);  // aquí se tiveramos dtoLineal  - cursor.valueBuffer("dtolineal")

    debug(">>>>>masterpresupuestosprov.qs   oficial_datosLineaPedido     codimpuesto: " + codImpuesto + "      iva: " + iva + "       recargo: " + recargo + "      irpf: " + irpf);
    debug(">>>>>masterpresupuestosprov.qs   oficial_datosLineaPedido     pvpSinDto: " + pvpSinDto + "      dtoPor: " + dtoPor + "       pvpTotal: " + pvpTotal);


    setValueBuffer("codimpuesto", codImpuesto);
    setValueBuffer("iva", iva );
    setValueBuffer("recargo", recargo);
    setValueBuffer("irpf", irpf);
    setValueBuffer("pvpsindto", formRecordlineaspedidosprov.iface.pub_commonCalculateField("pvpsindto", this));
    setValueBuffer("pvptotal", formRecordlineaspedidosprov.iface.pub_commonCalculateField("pvptotal", this));


    //SIAGAL Pasamos o cliente da cabeceira ás liñas do pedido
    //debug(">>>>>>>>><<<<<<<<<<<>>>>>>>>>><<<<<<<<<< codCliente: " + codCliente);
    //debug(">>>>>>>>><<<<<<<<<<<>>>>>>>>>><<<<<<<<<< nombreCliente: " + nombreCliente);
    setValueBuffer("codcliente", codCliente);
    setValueBuffer("nombrecliente", nombreCliente);
    setValueBuffer("codigooferta", codigoOferta);


    //Pasamos o destino de liña a liña
    debug("Imos pasar o destino>>>" + curLineaPresupuesto.valueBuffer("destino"))
    setValueBuffer("destino", curLineaPresupuesto.valueBuffer("destino"));


  }
  return true;
}

/** \D Informa los datos de un pedido referentes a totales (I.V.A., neto, etc.)
@return True si el cálculo se realiza correctamente, false en caso contrario
\end */
function oficial_totalesPedido(): Boolean {
  with(this.iface.curPedido)
  {
    setValueBuffer("neto", formpedidosprov.iface.pub_commonCalculateField("neto", this));
    setValueBuffer("totaliva", formpedidosprov.iface.pub_commonCalculateField("totaliva", this));
    setValueBuffer("totalirpf", formpedidosprov.iface.pub_commonCalculateField("totalirpf", this));
    setValueBuffer("totalrecargo", formpedidosprov.iface.pub_commonCalculateField("totalrecargo", this));
    setValueBuffer("total", formpedidoscli.iface.pub_commonCalculateField("total", this));
    setValueBuffer("totaleuros", formpedidosprov.iface.pub_commonCalculateField("totaleuros", this));
  }
  return true;
}


function oficial_comprobarPedidosAbertos(curPresupuesto: FLSqlCursor): String {


  var util: FLUtil;
  var codProveedor: String = curPresupuesto.valueBuffer("codproveedor");

    var numeroPedidosAbiertos: Number = util.sqlSelect("pedidosprov", "SUM(1)", "codproveedor = '" + codProveedor + "'");


 //debug(">>> SIAGAL masterpresupuestosprov.qs >>>> oficial_comprobarPedidosAbertos  codProveedor: " + codProveedor);
 //debug(">>> SIAGAL masterpresupuestosprov.qs >>>> oficial_comprobarPedidosAbertos  numeroPedidosAbiertos: " + numeroPedidosAbiertos);
  //DE MOMENTO SALIMOS Y SEGUIMOS COMO HASTA AHORA
 // return true;



	var pedidosAbiertos: Array;



  delete pedidosAbiertos;
  pedidosAbiertos = this.iface.buscarPedidosAbiertos(codProveedor);
  if (pedidosAbiertos.length > 0) {

    var dialog = new Dialog;
    dialog.caption = "Pedidos abiertos";
    dialog.okButtonText = "Aceptar"
    dialog.cancelButtonText = "Cancelar";

    var gbx = new GroupBox;

    var nombreProv: String = util.sqlSelect("proveedores", "nombre", "codproveedor = '" + codProveedor + "'");
    gbx.title = util.translate("scripts", "Existen pedidos abiertos para el proveedor %1 - %2. Selecciona el pedido al cual asociar las líneas:").arg(codProveedor).arg(nombreProv);
    dialog.add(gbx)
    var pedidos: Array = new Array();
    pedidos[0] = new RadioButton;
    pedidos[0].text = "Pedido nuevo";
    pedidos[0].checked = false;
    gbx.add(pedidos[0]);

    for (var i = 0; i < pedidosAbiertos.length; i++) {
      pedidos[i + 1] = new RadioButton;
      pedidos[i + 1].text = util.translate("scripts", "Pedido %1 del %2    Importe: %3").arg(pedidosAbiertos[i][1]).arg(util.dateAMDtoDMA(pedidosAbiertos[i][2])).arg(util.roundFieldValue(parseFloat(pedidosAbiertos[i][3]), "pedidosprov", "total"));
      if (i == pedidosAbiertos.length - 1) {
        pedidos[i + 1].checked = true;
      } else {
        pedidos[i + 1].checked = false;
      }
      gbx.add(pedidos[i + 1]);
    }

    if (!dialog.exec()) {
      return "CANCELA";
    }

    if (dialog.cancelButtonText)

    var codigoPedidoSeleccionado: String;
    if (pedidos[0].checked) {
      return "NOVO";
    } else {
    for (var i = 1; i <= pedidosAbiertos.length; i++) {
        if (pedidos[i].checked) {
          codigoPedidoSeleccionado = pedidosAbiertos[i - 1][1];
        }
      }
      //  MessageBox.critical(util.translate("scripts", "La opción de integrar en el pedido %1 se está implementando.\nA ver que pasa").arg(codigoPedidoSeleccionado), MessageBox.Ok, MessageBox.NoButton);
      return codigoPedidoSeleccionado;
    }
  } else {
      //NON hai pedidos abertos, hai que facer un novo
      return "NOVO";

  }







}

function oficial_buscarPedidosAbiertos(codProveedor: String): Array {
  var array: Array = new Array();
  var tam: Number = 0;
  var q: FLSqlQuery = new FLSqlQuery();
  q.setTablesList("pedidosprov");
  q.setSelect("idpedido,codigo,fecha,total");
  q.setFrom("pedidosprov");
  q.setWhere("abierto AND codproveedor = '" + codProveedor + "' ORDER BY fecha");

  if (!q.exec())
  {
    return false;
  }
  while (q.next())
  {
    array[tam] = new Array();
    array[tam][0] = q.value("idpedido");
    array[tam][1] = q.value("codigo");
    array[tam][2] = q.value("fecha");
    array[tam][3] = q.value("total");
   debug(">>> SIAGAL masterpresupuestosprov.qs >>>> oficial_buscarPedidosAbiertos  datos " + array[tam][0] + ", " + array[tam][1] + ", " + array[tam][2] + ", " + array[tam][3]);
    tam ++;
  }
  return array;
}


function oficial_duplicarPresupuesto_clicked()
{

  var util = new FLUtil;
  var cursor = this.cursor();

  var idPresupuesto;
  cursor.transaction(false);
  try {
    idPresupuesto = this.iface.duplicarPresupuesto(cursor);
    if (idPresupuesto) {
      cursor.commit();
    } else {
      cursor.rollback();
      return
    }
  } catch (e) {
    cursor.rollback();
    MessageBox.critical(util.translate("scripts", "Hubo un error en la copia del presupuesto:") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
    return;
  }
  this.iface.tdbRecords.refresh();

  var codPresupuesto = util.sqlSelect("presupuestosprov", "codigo", "idpresupuesto = " + idPresupuesto);
  MessageBox.information(util.translate("scripts", "Se ha generado la oferta de compra %1").arg(codPresupuesto), MessageBox.Ok, MessageBox.NoButton);
}


function oficial_duplicarPresupuesto(curPresupuesto: FLSqlCursor)
{


  var util = new FLUtil();

  if (!this.iface.curPresupuesto)
    this.iface.curPresupuesto = new FLSqlCursor("presupuestosprov");

  util.createProgressDialog(util.translate("scripts", "Copiando oferta...."), 3);
  var progreso = 0;

  this.iface.curPresupuesto.setModeAccess(this.iface.curPresupuesto.Insert);
  this.iface.curPresupuesto.refreshBuffer();

  progreso = 1;
  util.setProgress(progreso);

  if (!this.iface.duplicardatosPresupuesto(curPresupuesto)) {
    util.destroyProgressDialog();
    return false;
  }

  if (!this.iface.curPresupuesto.commitBuffer()) {
    util.destroyProgressDialog();
    return false;
  }

  var idPresupuesto = this.iface.curPresupuesto.valueBuffer("idpresupuesto");

  progreso = 2;
  util.setProgress(progreso);

  if (!this.iface.duplicarLineasPresupuesto(curPresupuesto.valueBuffer("idpresupuesto"), idPresupuesto)) {
    util.destroyProgressDialog();
    return false;
  }

  this.iface.curPresupuesto.select("idpresupuesto = " + idPresupuesto);
  if (this.iface.curPresupuesto.first()) {
    this.iface.curPresupuesto.setModeAccess(this.iface.curPresupuesto.Edit);
    this.iface.curPresupuesto.refreshBuffer();

    progreso = 3;
    util.setProgress(progreso);

    if (!this.iface.totalesPresupuesto()) {
      util.destroyProgressDialog();
      return false;
    }
    if (this.iface.curPresupuesto.commitBuffer() == false) {
      util.destroyProgressDialog();
      return false;
    }
  }
  util.destroyProgressDialog();
  return idPresupuesto;
}


function oficial_duplicardatosPresupuesto(curPresupuesto)
{

  var util = new FLUtil();
  var fecha: String;
  var hora: String;
  if (curPresupuesto.action() == "presupuestosprov") {
    var hoy = new Date();
    fecha = hoy.toString();
    hora = hoy.toString().right(8);
  } else {
    fecha = curPresupuesto.valueBuffer("fecha");
    hora = curPresupuesto.valueBuffer("hora");
  }

  var codEjercicio = curPresupuesto.valueBuffer("codejercicio");


  with(this.iface.curPresupuesto) {
    setValueBuffer("codejercicio", codEjercicio);
    setValueBuffer("femision", fecha);
    //setValueBuffer("hora", hora);
  }

  var aCamposLinea = util.nombreCampos("presupuestosprov");
  var totalCampos = aCamposLinea[0];

  var campoInformado = [];
  for (var i = 1; i <= totalCampos; i++) {
    campoInformado[aCamposLinea[i]] = false;
  }
  for (var i = 1; i <= totalCampos; i++) {
    if (!this.iface.duplicarCampoPresupuesto(aCamposLinea[i], curPresupuesto, campoInformado)) {
      util.destroyProgressDialog();
      return false;
    }
  }

  return true;
}




function oficial_duplicarCampoPresupuesto(nombreCampo, cursor, campoInformado)
{

  if (campoInformado[nombreCampo]) {
    return true;
  }
  var nulo = false;

  switch (nombreCampo) {
    case "idpresupuesto":
    case "codejercicio":
    case "numero":
    case "codigo":
    case "codcliente":
    case "codpedidocli":
    case "idpedidocli":
    case "nombrecliente":
    case "frecepcion":
    case "estado":
    case "codigopedidoprov": {
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
    this.iface.curPresupuesto.setNull(nombreCampo);
  } else {
    this.iface.curPresupuesto.setValueBuffer(nombreCampo, valor);
  }
  campoInformado[nombreCampo] = true;

  return true;
}



function oficial_duplicarHijosPresupuesto(idPresupuestoOrigen, idPresupuestoDestino)
{

  if (!this.iface.duplicarLineasPresupuesto(idPresupuestoOrigen, idPresupuestoDestino)) {
    return false;
  }
  return true;
}

function oficial_duplicarLineaPresupuesto(curLineaPresupuesto, idPresupuesto)
{

  var util = new FLUtil;
  if (!this.iface.curLineaPresupuesto) {
    this.iface.curLineaPresupuesto = new FLSqlCursor("lineaspresupuestosprov");
  }

  with(this.iface.curLineaPresupuesto) {
    setModeAccess(Insert);
    refreshBuffer();
    setValueBuffer("idpresupuesto", idPresupuesto);
  }

  var aCamposLinea = util.nombreCampos("lineaspresupuestosprov");
  var totalCampos = aCamposLinea[0];

  var campoInformado = [];
  for (var i = 1; i <= totalCampos; i++) {
    campoInformado[aCamposLinea[i]] = false;
  }

  for (var i = 1; i <= totalCampos; i++) {
    if (!this.iface.duplicarCampoLineaPresupuesto(aCamposLinea[i], curLineaPresupuesto, campoInformado)) {
      return false;
    }
  }

  //  if (!this.iface.duplicardatosLineaPresupuesto(curLineaPresupuesto))
  //    return false;

  if (!this.iface.curLineaPresupuesto.commitBuffer()) {
    return false;
  }

  return this.iface.curLineaPresupuesto.valueBuffer("idlinea");
}

function oficial_duplicarCampoLineaPresupuesto(nombreCampo, cursor, campoInformado)
{

  if (campoInformado[nombreCampo]) {
    return true;
  }
  var nulo = false;

  switch (nombreCampo) {
    case "idpresupuesto":
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
    this.iface.curLineaPresupuesto.setNull(nombreCampo);
  } else {
    this.iface.curLineaPresupuesto.setValueBuffer(nombreCampo, valor);
  }
  campoInformado[nombreCampo] = true;

  return true;
}

function oficial_duplicarLineasPresupuesto(idPresupuestoOrigen: Number, idPresupuestoDestino: Number)
{
 
  var curLineaPresupuesto = new FLSqlCursor("lineaspresupuestosprov");
  curLineaPresupuesto.select("idpresupuesto = " + idPresupuestoOrigen);

  while (curLineaPresupuesto.next()) {
    curLineaPresupuesto.setModeAccess(curLineaPresupuesto.Browse);
    curLineaPresupuesto.refreshBuffer();
    if (!this.iface.duplicarLineaPresupuesto(curLineaPresupuesto, idPresupuestoDestino))
      return false;
  }
  return true;
}

function oficial_totalesPresupuesto()
{
  with(this.iface.curPresupuesto) {
   // Deixámolo por compatibilidade
   // setValueBuffer("neto", formfacturascli.iface.pub_commonCalculateField("neto", this));
   // setValueBuffer("totaliva", formfacturascli.iface.pub_commonCalculateField("totaliva", this));
   // setValueBuffer("totalrecargo", formfacturascli.iface.pub_commonCalculateField("totalrecargo", this));
   // setValueBuffer("totalirpf", formfacturascli.iface.pub_commonCalculateField("totalirpf", this));
   // setValueBuffer("total", formfacturascli.iface.pub_commonCalculateField("total", this));
   // setValueBuffer("totaleuros", formfacturascli.iface.pub_commonCalculateField("totaleuros", this));
  }
  return true;
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition orderCols */
/////////////////////////////////////////////////////////////////
//// ORDER COLS /////////////////////////////////////////////////
function orderCols_init()
{
	this.iface.__init();
   connect(this.child("tableDBRecords").cursor(), "newBuffer()", this, "iface.reordenarColumnas");


  var util: FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var orden:Array = formRecordordercols.iface.pub_aplicarOrden(cursor);

	this.child("tableDBRecords").setOrderCols(orden);

  var anchos:Array = formRecordordercols.iface.pub_aplicarAnchos(cursor);
  if (anchos.length == orden.length) {
		for (var i = 0; i < anchos.length; i++) {
      this.child("tableDBRecords").setColumnWidth(orden[i], anchos[i]);
    }
	} else {
     MessageBox.warning(util.translate("scripts", "No se puede establecer el ancho de columnas al ser diferente\nel nÃºmero de elementos de anchura que de columnas seleccionadas."), MessageBox.Ok, MessageBox.NoButton);
  }

 this.child("tableDBRecords").switchSortOrder(formRecordordercols.iface.pub_ascendenteDescendente(cursor));

	this.child("tableDBRecords").refresh();
}


function orderCols_reordenarColumnas()
{
  /* Deixamos os anchos das columnas soamente */

	var util: FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.child("tableDBRecords").cursor();
	var orden:Array = formRecordordercols.iface.pub_aplicarOrden(cursor);
	var anchos:Array = formRecordordercols.iface.pub_aplicarAnchos(cursor);
	if (anchos.length == orden.length) {
	    for (var i = 0; i < anchos.length; i++) {
		  this.child("tableDBRecords").setColumnWidth(orden[i], anchos[i]);
	    }
	} else {
	    MessageBox.warning(util.translate("scripts", "No se puede establecer el ancho de columnas al ser diferente\nel nÃºmero de elementos de anchura que de columnas seleccionadas."), MessageBox.Ok, MessageBox.NoButton);

	}

	this.child("tableDBRecords").refresh();


}
//// ORDER COLS /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

