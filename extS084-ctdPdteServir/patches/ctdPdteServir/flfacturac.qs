
/** @class_declaration ctdPdteServir */
//////////////////////////////////////////////////////////////
//// CANTIDAD PENDIENTE SERVIR ///////////////////////////////

class ctdPdteServir extends ctlDatosMod /** %from: oficial */
{
  function ctdPdteServir(context)
  {
    ctlDatosMod(context);
  }
  function restarCantidadCli(idLineaPedido, idLineaAlbaran)
  {
    return this.ctx.ctdPdteServir_restarCantidadCli(idLineaPedido, idLineaAlbaran);
  }
  function sirveLineaPedidoCli(curLA)
  {
    return this.ctx.ctdPdteServir_sirveLineaPedidoCli(curLA);
  }
  function restarCantidadProv(idLineaPedido, idLineaAlbaran)
  {
    return this.ctx.ctdPdteServir_restarCantidadProv(idLineaPedido, idLineaAlbaran);
  }
  function sirveLineaPedidoProv(curLA)
  {
    return this.ctx.ctdPdteServir_sirveLineaPedidoProv(curLA);
  }

}

//// CANTIDAD PENDIENTE SERVIR ///////////////////////////////
//////////////////////////////////////////////////////////////

/** @class_definition ctdPdteServir */
//////////////////////////////////////////////////////////////
//// CANTIDAD PENDIENTE SERVIR ///////////////////////////////

/** \D
Substituye a la OFICIAL
Cambia el valor del campo totalalbaran y totalpendiente de una determinada línea de pedido, calculándolo como la suma de cantidades en otras líneas distintas de la línea de albarán indicada
@param idLineaPedido: Identificador de la línea de pedido
@param idLineaAlbaran: Identificador de la línea de albarán
\end */
function ctdPdteServir_restarCantidadCli(idLineaPedido, idLineaAlbaran)
{
  var _i = this.iface;
  var cantidad = parseFloat(AQUtil.sqlSelect("lineasalbaranescli", "SUM(cantidad)", "idlineapedido = " + idLineaPedido + " AND idlinea <> " + idLineaAlbaran));
  var cantidadPedido: Number;
  if (isNaN(cantidad))
    cantidad = 0;

 //debug ("******>>>> flfact.qs ctdPdteServir_restarCantidadCli    cantidad: " + cantidad + "     cantidadPedido: " + cantidadPedido);

  var curLineaPedido = new FLSqlCursor("lineaspedidoscli");
  curLineaPedido.select("idlinea = " + idLineaPedido);
  if (curLineaPedido.first()) {
    curLineaPedido.setModeAccess(curLineaPedido.Edit);
    curLineaPedido.refreshBuffer();
    curLineaPedido.setValueBuffer("totalenalbaran", cantidad);

	cantidadPedido =  parseFloat(curLineaPedido.valueBuffer("cantidad"));
	if (isNaN(cantidadPedido))
		cantidadPedido = 0;

	curLineaPedido.setValueBuffer("totalpendiente", cantidadPedido - cantidad);


    if (!curLineaPedido.commitBuffer()) {
      return false;
    }
  }
  return true;
}

/* Substitue á oficial para poder actualizar o totalpendiente */
function ctdPdteServir_sirveLineaPedidoCli(curLA)
{
  var _i = this.iface;

  var idLineaPedido = curLA.valueBuffer("idlineapedido");
  if (idLineaPedido == 0) {
    return true;
  }
  var idPedido = curLA.valueBuffer("idpedido");
  var referencia = curLA.valueBuffer("referencia");
  var idLineaAlbaran = curLA.valueBuffer("idlinea");
  var canAlbaran = curLA.valueBuffer("cantidad");

  if (idLineaPedido == 0) {
    return true;
  }

  var cantidadServida;
  var curLineaPedido = new FLSqlCursor("lineaspedidoscli");
  curLineaPedido.select("idlinea = " + idLineaPedido);
  curLineaPedido.setModeAccess(curLineaPedido.Edit);
  if (!curLineaPedido.first()) {
    return true;
  }

  var cantidadPedido = parseFloat(curLineaPedido.valueBuffer("cantidad"));
  var query = new FLSqlQuery();
  query.setTablesList("lineasalbaranescli");
  query.setSelect("SUM(cantidad)");
  query.setFrom("lineasalbaranescli");
  query.setWhere("idlineapedido = " + idLineaPedido + " AND idlinea <> " + idLineaAlbaran);
  if (!query.exec()) {
    return false;
  }
  if (query.next()) {
    var canOtros = parseFloat(query.value("SUM(cantidad)"));
    if (isNaN(canOtros)) {
      canOtros = 0;
    }
    cantidadServida = canOtros + parseFloat(canAlbaran);
  }
  if (cantidadServida > cantidadPedido) {
    cantidadServida = cantidadPedido;
  }


  /* SIAGAL Actualiza la cantidad pendiente de servir */
  var cantidadPedido  =  parseFloat(curLineaPedido.valueBuffer("cantidad"));
  if (isNaN(cantidadPedido))
	 cantidadPedido = 0;
  curLineaPedido.setValueBuffer("totalpendiente", cantidadPedido - cantidadServida);



  curLineaPedido.setValueBuffer("totalenalbaran", cantidadServida);
  if (!curLineaPedido.commitBuffer()) {
    return false;
  }

  return true;
}


/** \D
Substituye a la OFICIAL
Cambia el valor del campo totalalbaran y totalpendiente de una determinada línea de pedido de una determinada línea de pedido, calculándolo como la suma de cantidades en otras líneas distintas de la línea de albarán indicada
@param idLineaPedido: Identificador de la línea de pedido
@param idLineaAlbaran: Identificador de la línea de albarán
\end */
function ctdPdteServir_restarCantidadProv(idLineaPedido, idLineaAlbaran)
{
  var _i = this.iface;


  var cantidad = parseFloat(AQUtil.sqlSelect("lineasalbaranesprov", "SUM(cantidad)", "idlineapedido = " + idLineaPedido + " AND idlinea <> " + idLineaAlbaran));
  if (isNaN(cantidad))
    cantidad = 0;

  var cantidadPedido: Number;
  if (isNaN(cantidad))
    cantidad = 0;


  var curLineaPedido = new FLSqlCursor("lineaspedidosprov");
  curLineaPedido.select("idlinea = " + idLineaPedido);
  if (curLineaPedido.first()) {
    curLineaPedido.setModeAccess(curLineaPedido.Edit);
    curLineaPedido.refreshBuffer();
    curLineaPedido.setValueBuffer("totalenalbaran", cantidad);

	cantidadPedido =  parseFloat(curLineaPedido.valueBuffer("cantidad"));
	if (isNaN(cantidadPedido))
		cantidadPedido = 0;

	curLineaPedido.setValueBuffer("totalpendiente", cantidadPedido - cantidad);



    if (!curLineaPedido.commitBuffer()) {
      return false;
    }
  }
  return true;
}



/* Substitue á oficial para poder actualizar o totalpendiente */
function ctdPdteServir_sirveLineaPedidoProv(curLA)
{
  var _i = this.iface;

  var idLineaPedido = curLA.valueBuffer("idlineapedido");
  if (idLineaPedido == 0) {
    return true;
  }
  var idPedido = curLA.valueBuffer("idpedido");
  var referencia = curLA.valueBuffer("referencia");
  var idLineaAlbaran = curLA.valueBuffer("idlinea");
  var canAlbaran = curLA.valueBuffer("cantidad");

  var cantidadServida;
  var curLineaPedido = new FLSqlCursor("lineaspedidosprov");
  curLineaPedido.select("idlinea = " + idLineaPedido);
  curLineaPedido.setModeAccess(curLineaPedido.Edit);
  if (!curLineaPedido.first()) {
    return true;
  }
  var cantidadPedido = parseFloat(curLineaPedido.valueBuffer("cantidad"));
  var query = new FLSqlQuery();
  query.setTablesList("lineasalbaranesprov");
  query.setSelect("SUM(cantidad)");
  query.setFrom("lineasalbaranesprov");
  query.setWhere("idlineapedido = " + idLineaPedido + " AND idlinea <> " + idLineaAlbaran);
  if (!query.exec()) {
    return false;
  }
  if (query.next()) {
    var canOtros = parseFloat(query.value("SUM(cantidad)"));
    if (isNaN(canOtros)) {
      canOtros = 0;
    }
    cantidadServida = canOtros + parseFloat(canAlbaran);
  }
  if (cantidadServida > cantidadPedido) {
    cantidadServida = cantidadPedido;
  }


  /* SIAGAL Actualiza la cantidad pendiente de servir */
  var cantidadPedido  =  parseFloat(curLineaPedido.valueBuffer("cantidad"));
  if (isNaN(cantidadPedido))
	 cantidadPedido = 0;
  curLineaPedido.setValueBuffer("totalpendiente", cantidadPedido - cantidadServida);



  curLineaPedido.setValueBuffer("totalenalbaran", cantidadServida);
  if (!curLineaPedido.commitBuffer()) {
    return false;
  }

  return true;
}


//// CANTIDAD PENDIENTE SERVIR ///////////////////////////////
//////////////////////////////////////////////////////////////
