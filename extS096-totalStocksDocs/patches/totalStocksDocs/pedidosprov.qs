
/** @class_declaration totalStocksDocs */
////////////////////////////////////////////////////////////////
//// TOTAL STOCKS DOCS /////////////////////////////////////////
class totalStocksDocs extends ofertasProv /** %from: oficial */
{
  function totalStocksDocs(context)
  {
    ofertasProv(context);
  }
  function procesarEstadoLinea()
  {
    this.ctx.totalStocksDocs_procesarEstadoLinea();
  }
  function filtrarDatos()
  {
    return this.ctx.totalStocksDocs_filtrarDatos();
  }
  function totalStocks(referencia: String, barCode: String): Array {
    return this.ctx.totalStocksDocs_totalStocks(referencia,barCode);
  }

}
//// TOTAL STOCKS DOCS /////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition totalStocksDocs */
////////////////////////////////////////////////////////////////
//// TOTAL STOCKS DOCS /////////////////////////////////////////



/* Sobrecargamos a oficial que é a que está conectada co tdbArticulosPedProv  */
/* Non precisamos init por sobrecargar a oficial_procesarEstadoLinea */
function totalStocksDocs_procesarEstadoLinea()
{

  //debug(">>>> Siagal pedidosprov.qs  totalStocksDocs_procesarEstadoLinea ");
  this.iface.filtrarDatos();

  this.iface.__procesarEstadoLinea();

}


function totalStocksDocs_filtrarDatos()
{
  var cursor: FLSqlCursor = this.cursor();
  var referencia: String = this.child("tdbArticulosPedProv").cursor().valueBuffer("referencia");

  var barcode: String = this.child("tdbArticulosPedProv").cursor().valueBuffer("barcode");
  if (!barcode)
      barcode  = "";


  //debug(">>>> Siagal pedidosprov.qs  totalStocksDocs_filtrarDatos referencia: " + referencia + "  barcode: " + barCode);

  this.iface.totalStocks(referencia, barcode);



}



function totalStocksDocs_totalStocks(referencia: String, barCode: String)
{

	//debug(">>>> Siagal pedidosprov.qs  totalStocksDocs_totalStocks referencia: " + referencia + "  barcode: " + barCode);
  var util: FLUtil = new FLUtil();
  var andBarcode: String = "";
  if (barCode && barCode != "")
	andBarcode = " AND barcode = '" + barCode + "'";

  var totalCantidad: Number = util.sqlSelect("stocks", "sum(cantidad)", "referencia = '" + referencia + "'" + andBarcode);
  var totalPteRecibir: Number = util.sqlSelect("stocks", "sum(pterecibir)", "referencia = '" + referencia + "'" + andBarcode);
  var totalReservada: Number = util.sqlSelect("stocks", "sum(reservada)", "referencia = '" + referencia + "'" + andBarcode);
  var totalDisponible: Number = util.sqlSelect("stocks", "sum(disponible)", "referencia = '" + referencia + "'" + andBarcode);


  totalCantidad = AQUtil.formatoMiles(AQUtil.roundFieldValue(totalCantidad, "facturascli", "total"));
  totalPteRecibir = AQUtil.formatoMiles(AQUtil.roundFieldValue(totalPteRecibir, "facturascli", "total"));
  totalReservada = AQUtil.formatoMiles(AQUtil.roundFieldValue(totalReservada, "facturascli", "total"));
  totalDisponible = AQUtil.formatoMiles(AQUtil.roundFieldValue(totalDisponible, "facturascli", "total"));

  sys.setObjText(this, "lblTotalStocks", sys.translate("TOTALES cantidad en stock: %1  |  pendiente de recibir: %2  |  reservada: %3  |  disponible: %4").arg(totalCantidad).arg(totalPteRecibir).arg(totalReservada).arg(totalDisponible));

}

//// TOTAL STOCKS DOCS //////////////////////////////////////////
/////////////////////////////////////////////////////////////////

