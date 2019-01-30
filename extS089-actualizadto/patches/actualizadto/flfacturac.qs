
/** @class_declaration actualizaDto */
////////////////////////////////////////////////////////
//// ACTUALIZA DESCONTO  ///////////////////////////////

class actualizaDto extends ctdPdteServir /** %from: oficial */
{
  function actualizaDto(context)
  {
    ctdPdteServir(context);
  }
   function actualizarArticulosProv(curLinea)
  {
    return this.ctx.actualizaDto_actualizarArticulosProv(curLinea);
  }

}

//// ACTUALIZA DESCONTO ///////////////////////////////
///////////////////////////////////////////////////////

/** @class_definition actualizaDto */
////////////////////////////////////////////////////////
//// ACTUALIZA DESCONTO  ///////////////////////////////
/* Sobrecarga a oficial sustituindoa para que se actualice tamén o dto por proveedor */
function actualizaDto_actualizarArticulosProv(cursor)
{
  var _i = this.iface;

  var tablaDoc = cursor.table();
  var actualizarArtProv = flfacturac.iface.pub_valorDefecto("actualizarartprov");
  if ((tablaDoc == "albaranesprov" && actualizarArtProv != "Albaranes de proveedor") || (tablaDoc == "facturasprov" && actualizarArtProv != "Facturas de proveedor")) {
    return true;
  }
  var nTabla;
  var nClave;
  switch (tablaDoc) {
    case "albaranesprov": {
      nTabla = "lineasalbaranesprov";
      nClave = "idalbaran";
      break;
    }
    case "facturasprov": {
      nTabla = "lineasfacturasprov";
      nClave = "idfactura";
      break;
    }
  }

  var _i = this.iface;
  var codProveedor = cursor.valueBuffer("codproveedor");
  var nombreProv = cursor.valueBuffer("nombre");
  var codDivisa = cursor.valueBuffer("coddivisa");

  var qryLineas = new FLSqlQuery();
  qryLineas.setTablesList(nTabla);
  qryLineas.setSelect("referencia, pvpunitario, dtopor");
  qryLineas.setFrom(nTabla);
  qryLineas.setWhere(nClave + " = " + cursor.valueBuffer(nClave));

  if (!qryLineas.exec()) {
    return false;
  }

  var curArtProv = new FLSqlCursor("articulosprov");
  var hayOtroArtProv, porDefecto, referencia;
  while (qryLineas.next()) {
    referencia = qryLineas.value("referencia");
    if (!referencia || referencia == "") {
      continue;
    }
    curArtProv.select("referencia = '" + referencia + "' AND codproveedor = '" + codProveedor + "'");
    if (!curArtProv.first()) {
      hayOtroArtProv = AQUtil.sqlSelect("articulosprov", "id", "referencia = '" + referencia + "'");
      porDefecto = (!hayOtroArtProv || isNaN(hayOtroArtProv)) ? true : false;
      curArtProv.setModeAccess(curArtProv.Insert);
      curArtProv.refreshBuffer();
      curArtProv.setValueBuffer("codproveedor", codProveedor);
      curArtProv.setValueBuffer("nombre", nombreProv);
      curArtProv.setValueBuffer("referencia", referencia);
      curArtProv.setValueBuffer("pordefecto", porDefecto);
    } else {
      curArtProv.setModeAccess(curArtProv.Edit);
      curArtProv.refreshBuffer();
    }
    curArtProv.setValueBuffer("coddivisa", codDivisa);
    curArtProv.setValueBuffer("coste", qryLineas.value("pvpunitario"));
    curArtProv.setValueBuffer("dto", qryLineas.value("dtopor"));    
    debug(">>>>>>>>>>>>>>> flfacturac.qs >>>> actualizaDto_actualizarArticulosProv >>> " + referencia + " - " + qryLineas.value("pvpunitario") + " - " + qryLineas.value("dtopor"));
    if (!curArtProv.commitBuffer()) {
      return false;
    }
  }

  return true;
}

//// ACTUALIZA DESCONTO ///////////////////////////////
///////////////////////////////////////////////////////

