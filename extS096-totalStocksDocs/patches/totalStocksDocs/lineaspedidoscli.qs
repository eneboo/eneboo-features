
/** @class_declaration totalStocksDocs */
////////////////////////////////////////////////////////////////
//// TOTAL STOCKS DOCS /////////////////////////////////////////
class totalStocksDocs extends avisoArtVentas /** %from: oficial */
{
  function totalStocksDocs(context)
  {
    avisoArtVentas(context);
  }
  function init()
  {
    this.ctx.totalStocksDocs_init();
  }
  function commonBufferChanged(fN: String, miForm: Object)
  {
    return this.ctx.totalStocksDocs_commonBufferChanged(fN, miForm);
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


function totalStocksDocs_init()
{
  this.iface.__init();
debug(">>>> Siagal lineaspedidosprov.qs  totalStocksDocs_init ");
  var cursor: FLSqlCursor = this.cursor();

  this.iface.totalStocks(cursor.valueBuffer("referencia"), cursor.valueBuffer("barcode"));

}


function totalStocksDocs_commonBufferChanged(fN: String, miForm: Object)
{

  var util: FLUtil = new FLUtil;
  var cursor: FLSqlCursor = miForm.cursor();
  var barcode: String = "";
  var referencia: String = cursor.valueBuffer("referencia");


  debug(">>>> Siagal lineaspedidosprov.qs  totalStocksDocs_commonBufferChanged fN: " + fN );
  switch (fN) {
    case "barcode": {
      barcode =  cursor.valueBuffer("barcode");
      this.iface.totalStocks(referencia,barcode);
      this.iface.__commonBufferChanged(fN, miForm);
      break;
    }
    case "referencia": {
      this.iface.totalStocks(referencia,barcode);
      this.iface.__commonBufferChanged(fN, miForm);
      break;
    }
    default: {
      this.iface.__commonBufferChanged(fN, miForm);
    }
  }
}



function totalStocksDocs_totalStocks(referencia: String, barCode: String)
{

	debug(">>>> Siagal lineaspedidosprov.qs  totalStocksDocs_totalStocks referencia: " + referencia + "  barcode: " + barCode);
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

