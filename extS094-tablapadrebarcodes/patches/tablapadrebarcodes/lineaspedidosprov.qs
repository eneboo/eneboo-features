
/** @class_declaration tablaPadreBarcodes */
/////////////////////////////////////////////////////////////////
//// TABLA PADRE BARCODES ///////////////////////////////////////
class tablaPadreBarcodes extends totalStocksDocs
{
  function tablaPadreBarcodes(context)
  {
    totalStocksDocs(context);
  }
  function datosTablaPadre(cursor: FLSqlCursor): Array {
    return this.ctx.tablaPadreBarcodes_datosTablaPadre(cursor);
  }

}
//// TABLA PADRE BARCODES ///////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition tablaPadreBarcodes */
/////////////////////////////////////////////////////////////////
//// TABLA PADRE BARCODES ///////////////////////////////////////

/* Substituye completamente a la oficial */
function tablaPadreBarcodes_datosTablaPadre(cursor: FLSqlCursor): Array {
  var datos: Array;
 // debug(">>>>>>>>>> lineaspedidosprov.qs   oficial_datosTablaPadre");

  datos = this.iface.__datosTablaPadre(cursor);
  if (datos)
    return datos;
 


  switch (cursor.table())
  {
    case "lineaspedidosprov": {
      datos.where = "idpedido = " + cursor.valueBuffer("idpedido");
      datos.tabla = "pedidosprov";
      break;
    }
    case "lineasalbaranesprov": {
      datos.where = "idalbaran = " + cursor.valueBuffer("idalbaran");
      datos.tabla = "albaranesprov";
      break;
    }
    case "lineasfacturasprov": {
      datos.where = "idfactura = " + cursor.valueBuffer("idfactura");
      datos.tabla = "facturasprov";
      break;
    }
  }
  var curRel: FLSqlCursor = cursor.cursorRelation();
  if (curRel && curRel.table() == datos.tabla)
  {
    datos["coddivisa"] = curRel.valueBuffer("coddivisa");
    datos["codproveedor"] = curRel.valueBuffer("codproveedor");
    datos["fecha"] = curRel.valueBuffer("fecha");
    datos["codserie"] = curRel.valueBuffer("codserie");
    datos["tasaconv"] = curRel.valueBuffer("tasaconv");
  } else {
    var qryDatos: FLSqlQuery = new FLSqlQuery;
    qryDatos.setTablesList(datos.tabla);
    qryDatos.setSelect("coddivisa, codproveedor, fecha, codserie, tasaconv");
    qryDatos.setFrom(datos.tabla);
    qryDatos.setWhere(datos.where);
    qryDatos.setForwardOnly(true);
    if (!qryDatos.exec())
    {
      return false;
    }
    if (!qryDatos.first())
    {
      return false;
    }
    datos["coddivisa"] = qryDatos.value("coddivisa");
    datos["codproveedor"] = qryDatos.value("codproveedor");
    datos["fecha"] = qryDatos.value("fecha");
    datos["codserie"] = qryDatos.value("codserie");
    datos["tasaconv"] = qryDatos.value("tasaconv");
  }
  return datos;
}


//// TABLA PADRE BARCODES ///////////////////////////////////////
/////////////////////////////////////////////////////////////////

