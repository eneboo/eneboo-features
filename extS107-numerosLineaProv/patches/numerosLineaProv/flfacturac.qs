/** @class_declaration numerosLineaProv */
/////////////////////////////////////////////////////////////////
//// NUMEROS LINEA PROV ////////////////////////////////////////
class numerosLineaProv extends oficial
{
  function numerosLineaProv(context)
  {
    oficial(context);
  }
  function controlNumLinea(curLinea)
  {
    return this.ctx.numerosLineaProv_controlNumLinea(curLinea);
  }
  function afterCommit_lineaspresupuestosprov(curLP)
  {
    return this.ctx.numerosLineaProv_afterCommit_lineaspresupuestosprov(curLP);
  }
  function afterCommit_lineaspedidosprov(curLP)
  {
    return this.ctx.numerosLineaProv_afterCommit_lineaspedidosprov(curLP);
  }
  function afterCommit_lineasalbaranesprov(curLA)
  {
    return this.ctx.numerosLineaProv_afterCommit_lineasalbaranesprov(curLA);
  }
  function afterCommit_lineasfacturasprov(curLF)
  {
    return this.ctx.numerosLineaProv_afterCommit_lineasfacturasprov(curLF);
  }
}
//// NUMEROS LINEA PROV /////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition numerosLineaProv */
/////////////////////////////////////////////////////////////////
//// NUMEROS LINEA PROV ////////////////////////////////////////
/** \D Mueve la línea seleccionada hacia arriba o hacia abajo en función de la dirección
*/

function numerosLineaProv_afterCommit_lineaspresupuestosprov(curLP)
{
  var _i = this.iface;
  try {
    if (!_i.__afterCommit_lineaspresupuestosprov(curLP)) {
      return false;
    }
  } catch (e) {}

  if (!_i.controlNumLinea(curLP)) {
    return false;
  }
  return true;
}

function numerosLineaProv_afterCommit_lineaspedidosprov(curLP)
{
  var _i = this.iface;
  if (!_i.__afterCommit_lineaspedidosprov(curLP)) {
    return false;
  }
  if (!_i.controlNumLinea(curLP)) {
    return false;
  }
  return true;
}

function numerosLineaProv_afterCommit_lineasalbaranesprov(curLA)
{
  var _i = this.iface;
  if (!_i.__afterCommit_lineasalbaranesprov(curLA)) {
    return false;
  }
  if (!_i.controlNumLinea(curLA)) {
    return false;
  }
  return true;
}

function numerosLineaProv_afterCommit_lineasfacturasprov(curLF)
{
  var _i = this.iface;
  if (!_i.__afterCommit_lineasfacturasprov(curLF)) {
    return false;
  }
  if (!_i.controlNumLinea(curLF)) {
    return false;
  }
  return true;
}

/** \D Si existe una línea con el mismo número, el resto de líneas se renumera para evitar duplicidades
  \end */
function numerosLineaProv_controlNumLinea(curLinea)
{
  if (curLinea.modeAccess() != curLinea.Insert && curLinea.modeAccess() != curLinea.Edit) {
    return  true;
  }
  var tabla = curLinea.table();
  switch (tabla) {
    case "lineaspresupuestoscli": {
      idDoc = "idpresupuesto";
      break;
    }
    case "lineaspedidoscli": {
      idDoc = "idpedido";
      break;
    }
    case "lineasalbaranescli": {
      idDoc = "idalbaran";
      break;
    }
    case "lineasfacturascli": {
      idDoc = "idfactura";
      break;
    }
    case "lineaspresupuestosprov": {
      idDoc = "idpresupuesto";
      break;
    }
    case "lineaspedidosprov": {
      idDoc = "idpedido";
      break;
    }
    case "lineasalbaranesprov": {
      idDoc = "idalbaran";
      break;
    }
    case "lineasfacturasprov": {
      idDoc = "idfactura";
      break;
    }
  }
  var valorIdDoc = curLinea.valueBuffer(idDoc);
  var idLinea = curLinea.valueBuffer("idlinea");
  var numLinea = curLinea.valueBuffer("numlinea");
  debug("select idlinea from " + tabla + " where " + idDoc + " = " + valorIdDoc + " AND idlinea <> " + idLinea + " AND numlinea = " + numLinea);
  var idLineaDup = AQUtil.sqlSelect(tabla, "idlinea", idDoc + " = " + valorIdDoc + " AND idlinea <> " + idLinea + " AND numlinea = " + numLinea);
  if (!idLineaDup) {
    return true;
  }
  var curLineas = new FLSqlCursor(tabla);
  curLineas.setActivatedCheckIntegrity(false);
  curLineas.setActivatedCommitActions(false);
  curLineas.select(idDoc + " = " + valorIdDoc + " AND idlinea <> " + idLinea + " AND numlinea >= " + numLinea + " ORDER BY numlinea, idlinea");
  while (curLineas.next()) {
    numLinea++;
    curLineas.setModeAccess(curLineas.Edit);
    curLineas.refreshBuffer()        ;
    curLineas.setValueBuffer("numlinea", numLinea);
    if (!curLineas.commitBuffer()) {
      return false;
    }
  }
  return true;
}
//// NUMEROS LINEA PROV /////////////////////////////////////////
/////////////////////////////////////////////////////////////////
