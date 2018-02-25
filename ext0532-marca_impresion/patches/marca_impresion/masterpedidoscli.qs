
/** @class_declaration marcaImpresion */
/////////////////////////////////////////////////////////////////
//// MARCA_IMPRESION ////////////////////////////////////////////
class marcaImpresion extends articuloscomp /** %from: oficial */
{
  function marcaImpresion(context)
  {
    articuloscomp(context);
  }
  function marcarPedidoImpreso(idPedido: String, impreso: Boolean): Boolean {
    return this.ctx.marcaImpresion_marcarPedidoImpreso(idPedido, impreso);
  }
}
//// MARCA_IMPRESION ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubMarcaImpresion */
/////////////////////////////////////////////////////////////////
//// PUB_MARCA_IMPRESION ////////////////////////////////////////
class pubMarcaImpresion extends pubEnvioMail /** %from: ifaceCtx */
{
  function pubMarcaImpresion(context)
  {
    pubEnvioMail(context);
  }
  function pub_marcarPedidoImpreso(idPedido: String, impreso: Boolean): Boolean {
    return this.marcarPedidoImpreso(idPedido, impreso);
  }
}
//// PUB_MARCA_IMPRESION ////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition marcaImpresion */
/////////////////////////////////////////////////////////////////
//// MARCA_IMPRESION ////////////////////////////////////////////
function marcaImpresion_marcarPedidoImpreso(idPedido: String, impreso: Boolean): Boolean {
  if (impreso)
  {
    return false;
  }

  var util: FLUtil = new FLUtil();
  var bloqueado: Boolean = false;
  var curPedido: FLSqlCursor = new FLSqlCursor("pedidoscli");
  curPedido.select("idpedido = " + idPedido);
  curPedido.first();
  curPedido.setActivatedCommitActions(false);
  curPedido.setActivatedCheckIntegrity(false);

  if (curPedido.valueBuffer("editable") == false)
  {
    curPedido.select("idpedido = " + idPedido);
    curPedido.first();
    curPedido.setUnLock("editable", true);
    bloqueado = true;
  }
  curPedido.select("idpedido = " + idPedido);
  curPedido.first();
  curPedido.setModeAccess(curPedido.Edit);
  curPedido.refreshBuffer();
  curPedido.setValueBuffer("impreso", true);
  if (!curPedido.commitBuffer())
  {
    return false;
  }

  if (bloqueado)
  {
    curPedido.select("idpedido = " + idPedido);
    curPedido.first();
    curPedido.setUnLock("editable", false);
  }
  return true;
}

//// MARCA_IMPRESION ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

