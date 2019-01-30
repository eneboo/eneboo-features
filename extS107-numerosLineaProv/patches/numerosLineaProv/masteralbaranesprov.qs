
/** @class_declaration numerosLineaProv */
/////////////////////////////////////////////////////////////////
//// NUMEROS DE LÍNEA ///////////////////////////////////////////
class numerosLineaProv extends barCode /** %from: oficial */
{
  var numLinea_: Number;
  function numerosLineaProv(context)
  {
    barCode(context);
  }
  function generarFactura(where: String, curAlbaran: FLSqlCursor, datosAgrupacion: Array): Number {
    return this.ctx.numerosLineaProv_generarFactura(where, curAlbaran, datosAgrupacion);
  }

  function dameSelectLineasAlbaran(idAlbaran, idFactura)
  {
    return this.ctx.numerosLineaProv_dameSelectLineasAlbaran(idAlbaran, idFactura);
  }
  function datosLineaFactura(curLineaAlbaran: FLSqlCursor): Boolean {
    return this.ctx.numerosLineaProv_datosLineaFactura(curLineaAlbaran);
  }
}
//// NUMEROS DE LÍNEA ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition numerosLineaProv */
/////////////////////////////////////////////////////////////////
//// NÚMEROS DE LÍNEA ///////////////////////////////////////////
function numerosLineaProv_generarFactura(where: String, curAlbaran: FLSqlCursor, datosAgrupacion: Array): Number {
  this.iface.numLinea_ = 0;

  var idFactura: String = this.iface.__generarFactura(where, curAlbaran, datosAgrupacion);
  if (!idFactura)
  {
    return false;
  }

  return idFactura;
}

// function numLinea_copiaLineasAlbaran(idAlbaran:Number, idFactura:Number):Boolean
// {
//  var curLineaAlbaran:FLSqlCursor = new FLSqlCursor("lineasalbaranescli");
//  curLineaAlbaran.select("idalbaran = " + idAlbaran + " ORDER BY numlinea");
//
//  while (curLineaAlbaran.next()) {
//    curLineaAlbaran.setModeAccess(curLineaAlbaran.Browse);
//    if (!this.iface.copiaLineaAlbaran(curLineaAlbaran, idFactura))
//      return false;
//  }
//  return true;
// }

function numerosLineaProv_dameSelectLineasAlbaran(idAlbaran, idFactura)
{
  var s = "idalbaran = " + idAlbaran + " ORDER BY numlinea";
  return s;
}


function numerosLineaProv_datosLineaFactura(curLineaAlbaran: FLSqlCursor): Boolean {
  if (!this.iface.__datosLineaFactura(curLineaAlbaran))
  {
    return false;
  }

  this.iface.numLinea_++;
  this.iface.curLineaFactura.setValueBuffer("numlinea", this.iface.numLinea_);

  return true;
}

//// NÚMEROS DE LÍNEA ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////

