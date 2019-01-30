
/** @class_declaration ctlStockMinMax */
/////////////////////////////////////////////////////////////////
//// CONTROL STOCKS MINIMO E MAXIMO /////////////////////////////
class ctlStockMinMax extends almacenLinea /** %from: tallcolComp */ 
{
  function ctlStockMinMax(context) {
    almacenLinea(context);
  }

  function cambiarStock(codAlmacen: String, barCode: String, referencia: String, variacion: Number, campo: String): Boolean {
	return this.ctx.ctlStockMinMax_cambiarStock(codAlmacen, barCode, referencia, variacion, campo);
  }

  function generarMoviStock(curLinea: FLSqlCursor, codLote: String, cantidad: Number, curArticuloComp: FLSqlCursor, idProceso: String): Boolean {
    return this.ctx.ctlStockMinMax_generarMoviStock(curLinea, codLote, cantidad, curArticuloComp, idProceso);
  }

  function controlMinMaxComp(curLinea: FLSqlCursor, datosArt: Array, cantidad: Number): Boolean {
    return this.ctx.ctlStockMinMax_controlMinMaxComp(curLinea, datosArt, cantidad);
  }
  
    
  function obtenerSignoCantidad(curLinea: FLSqlCursor, cantidad: Number): Number {
      return this.ctx.ctlStockMinMax_obtenerSignoCantidad(curLinea, cantidad);
  }



}
//// CONTROL STOCKS MINIMO E MAXIMO /////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition ctlStockMinMax */
/////////////////////////////////////////////////////////////////
//// CONTROL STOCKS MINIMO E MAXIMO /////////////////////////////


/** \D Controla o Stock Máximo e Mínimo. En primeiro lugar o busca no barcode, se non existe barcode,
 * ou non o obtén, o vai buscar ao do almacén, e por último o obtén da ficha do artículo se non existe nos anteriores.
 * OLLO! Falamos de que non exista, se é 0 traballa co 0.
@param  codAlmacen: Almacén en xogo
@param  barCode: Barcode de tallas e colores
@param  referencia: Referencia
@param  variacion: variación de stock (+ ou -)
@param  campo:
@return True o False para que continúe ou non coa operación que chamou a esta función.
\end */
function ctlStockMinMax_cambiarStock(codAlmacen: String, barCode: String, referencia: String, variacion: Number, campo: String)
{

	var util: FLUtil = new FLUtil;

	var stockMin: Number;
	var stockMax: Number;
	var stockActual: Number;

	//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_cambiarStock");

	if (barCode && barCode != "")  {
		if (referencia && referencia != "") {
			//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_cambiarStock OBTEMOS O STOCK MINIMO E MAXIMO DO ARTICULO con BARCODE POR ALMACÉN");
			// Buscamos antes no Almacén
			stockMin = util.sqlSelect("stocks", "stockmin", "referencia = '" + referencia + "' AND codalmacen = '" + codAlmacen + "' AND barcode = '" + barCode + "'");
			stockMax = util.sqlSelect("stocks", "stockmax", "referencia = '" + referencia + "' AND codalmacen = '" + codAlmacen + "' AND barcode = '" + barCode + "'");
			stockActual = util.sqlSelect("stocks", "cantidad", "referencia = '" + referencia + "' AND codalmacen = '" + codAlmacen + "' AND barcode = '" + barCode + "'");

			//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_cambiarStock stockMin: " + stockMin + "   stockMax: " + stockMax + "    stockActual: " + stockActual);

			if (!stockActual)
				stockActual = 0;

			// Busscamos por último na ficha do artículo os seus stocks máximos
			if (!stockMin && !stockMax) {
				//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_cambiarStock OBTEMOS O STOCK MINIMO E MAXIMO DO GENÉRICO DO ARTÍCULO con BARCODE");
				stockMin = util.sqlSelect("articulos", "stockmin", "referencia = '" + referencia + "'");
				stockMax = util.sqlSelect("articulos", "stockmax", "referencia = '" + referencia + "'");
				//MessageBox.warning(util.translate("scripts", "No se pudo obtener los stocks mínimo y máximo por almacén, se obtendrán de los genéricos del artículo.\n%1 - %2  Stock: %3 \nStock mínimo: %4  Stock máximo: %5.\n").arg(referencia).arg(barCode).arg(stockActual).arg(stockMin).arg(stockMax), MessageBox.Ok, MessageBox.NoButton);
			}
		} else {
			//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_cambiarStock NON HAI REFERENCIA, SAIMOS");
			return this.iface.__cambiarStock(codAlmacen,barCode,referencia,variacion,campo);
		}

    } else {
		if (referencia && referencia != "") {
			//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_cambiarStock OBTEMOS O STOCK MINIMO E MAXIMO DO ARTICULO sen BARCODE POR ALMACÉN");
			stockMin = util.sqlSelect("stocks", "stockmin", "referencia = '" + referencia + "' AND codalmacen = '" + codAlmacen + "'");
			stockMax = util.sqlSelect("stocks", "stockmax", "referencia = '" + referencia + "' AND codalmacen = '" + codAlmacen + "'");
			stockActual = util.sqlSelect("stocks", "cantidad", "referencia = '" + referencia + "' AND codalmacen = '" + codAlmacen + "'");

			//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_cambiarStock stockMin: " + stockMin + "   stockMax: " + stockMax + "    stockActual: " + stockActual);

			if (!stockActual)
				stockActual = 0;

			if (!stockMin && !stockMax) {
				//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_cambiarStock OBTEMOS O STOCK MINIMO E MAXIMO DO GENÉRICO DO ARTICULO");
				stockMin = util.sqlSelect("articulos", "stockmin", "referencia = '" + referencia + "'");
				stockMax = util.sqlSelect("articulos", "stockmax", "referencia = '" + referencia + "'");
				//MessageBox.warning(util.translate("scripts", "No se pudo obtener los stocks mínimo y máximo por almacén, se obtendrán de los genéricos del artículo.\n%1  Stock: %2 \nStock mínimo: %3  Stock máximo: %4.\n").arg(referencia).arg(stockActual).arg(stockMin).arg(stockMax), MessageBox.Ok, MessageBox.NoButton);
			}
		} else {
			//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_cambiarStock NON HAI REFERENCIA, SAIMOS");
			return this.iface.__cambiarStock(codAlmacen,barCode,referencia,variacion,campo);
		}


    }


    var stockFinal: Number = stockActual + variacion;

    var refCompleta:String = referencia;

	//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_cambiarStock Referencia: " + referencia + " Barcode: " + barCode);
	//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_cambiarStock stockMin: " + stockMin + " stockMax: " + stockMax + " stockActual: " + stockActual);
	//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_cambiarStock variacion: " + variacion + " astockFinal: " + stockFinal);

	var distanciaMin: Number = stockMin - stockFinal
	var distanciaMax: Number = stockFinal - stockMax

	if (!barCode && barCode != "")
		refCompleta = refCompleta + " - " + barCode

	// Por debaixo do stock mínimo
	if (stockFinal < stockMin) {
		var resMin: Number = MessageBox.warning(util.translate("scripts", "El artículo %1 para el almacén %2 tiene establecido un stock mínimo de %3.\nSi se continúa se dejará el stock en %4, una diferencia de %5 por debajo del stock mínimo.\n\n¿Continuar con la operación?.").arg(refCompleta).arg(codAlmacen).arg(stockMin).arg(stockFinal).arg(distanciaMin), MessageBox.No, MessageBox.Yes);
		if (resMin == MessageBox.Yes) {
			//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_cambiarStock BAIXO STOCK MINIMO ACTUALIZAMOS IGUAL EL STOCK");
			return this.iface.__cambiarStock(codAlmacen,barCode,referencia,variacion,campo);
        } else {
			//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_cambiarStock BAIXO STOCK MINIMO NO ACTUALIZAMOS EL STOCK");
			return false;
		}
    }

    // Por riba do stock máximo
    if (stockFinal > stockMax) {
		var resMax: Number = MessageBox.warning(util.translate("scripts", "El artículo %1 para el almacén %2 tiene establecido un stock máximo de %3.\nSi se continúa se dejará el stock en %4, una diferencia de %5 por encima del stock máximo.\n\n¿Continuar con la operación?.").arg(refCompleta).arg(codAlmacen).arg(stockMax).arg(stockFinal).arg(distanciaMax), MessageBox.No, MessageBox.Yes);
		if (resMax == MessageBox.Yes) {
			//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_cambiarStock SOBRE STOCK MAXIMO ACTUALIZAMOS IGUAL EL STOCK");
			return this.iface.__cambiarStock(codAlmacen,barCode,referencia,variacion,campo);
        } else {
			//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_cambiarStock SOBRE STOCK MAXIMO NO ACTUALIZAMOS EL STOCK");
			return false;
		}
    }


	// Se non se controlou a saida devolvemos o que nos de a función pai
	return this.iface.__cambiarStock(codAlmacen,barCode,referencia,variacion,campo);

}



/** Genera uno o más movimientos de stock asociados a una línea de documento de facturación
 * Sustitue á de artículos compostos para poder controlar máximos e mínimos.
\end */

function ctlStockMinMax_generarMoviStock(curLinea: FLSqlCursor, codLote: String, cantidad: Number, curArticuloComp: FLSqlCursor, idProceso: String): Boolean {
  var util: FLUtil = new FLUtil;
//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_generarMoviStock");
  var idLinea: String;
  var idPadre: String;
  var fechaPrev: String;
  var fechaReal: String;
  var horaReal: String;
  var codAlmacen: String;
  var codAlmacenOrigen: String;
  var codAlmacenDestino: String;
  var referencia: String;
  var datosArt: Array;

  var tabla: String = curLinea.table();



  switch (tabla)
  {
    case "lineaspedidoscli":  {
      if (curLinea.valueBuffer("cerrada")) {
        return true;
      }
      break;

      /// Se usa en la regeneración automática de stocks. Fuerza la creación de un movimiento pendiente que luego será albaranado
      //       if (curLinea.valueBuffer("cerrada")) {
      //        var totalAlb = curLinea.valueBuffer("totalenalbaran");
      //        if (totalAlb > 0) {
      //          var canMov = parseFloat(AQUtil.sqlSelect("movistock", "SUM(cantidad)", "idlineapc = " + curLinea.valueBuffer("idlinea") + " AND estado = 'HECHO'"));
      //          canMov = isNaN(canMov) ? 0 : canMov;
      //          canMov *= -1;
      //          var resto = totalAlb - canMov;
      //          if (resto > 0) {
      //            cantidad = resto;
      //            break;
      //          }
      //        }
      //        return true;
      //      }
    }
    case "lineaspedidosprov": {
      if (curLinea.valueBuffer("cerrada")) {
        return true;
      }
      break;
      //      if (curLinea.valueBuffer("cerrada")) {
      //        var totalAlb = curLinea.valueBuffer("totalenalbaran");
      //        if (totalAlb > 0) {
      //          var canMov = parseFloat(AQUtil.sqlSelect("movistock", "SUM(cantidad)", "idlineapp = " + curLinea.valueBuffer("idlinea") + " AND estado = 'HECHO'"));
      //          canMov = isNaN(canMov) ? 0 : canMov;
      //          var resto = totalAlb - canMov;
      //          if (resto > 0) {
      //            cantidad = resto;
      //            break;
      //          }
      //        }
      //        return true;
      //      }
      //      break;
    }
    case "tpv_lineascomanda": {
      var curR = curLinea.cursorRelation();
      var tipoDoc = curR ? curR.valueBuffer("tipodoc") : AQUtil.sqlSelect("tpv_comandas", "tipodoc", "idtpv_comanda = " + curLinea.valueBuffer("idtpv_comanda"));

      //debug("tpv_lineascomanda tipoDoc: " + tipoDoc);

      if (tipoDoc == "presupuesto") {
        return true;
      }
      break;
    }
  }

  if (curArticuloComp)
  {
    datosArt = this.iface.datosArticulo(curArticuloComp, false, curLinea);
  } else {
    datosArt = this.iface.datosArticulo(curLinea, codLote);
  }
  if (datosArt["referencia"] == "")
  {
    return true;
  }
  if (!cantidad || isNaN(cantidad))
  {
    cantidad = this.iface.establecerCantidad(curLinea);
  }
  if (!cantidad)
  {
    return true;
  }


//Intervimos e controlamos os compostos
  if (!this.iface.controlMinMaxComp(curLinea, datosArt,cantidad)) {
	 return false;
  }


  /** Para artículos compuestos que no son fabricados, se crean tantos movimientos de stock como componentes haya */
  if (this.iface.generarMoviStockComponentes(datosArt, idProceso))
  {
    var nuevaCantidad: Number;
    var curAC: FLSqlCursor = new FLSqlCursor("articuloscomp");
    curAC.select("refcompuesto = '" + datosArt["referencia"] + "'");
    var hayComponentes = false;
    while (curAC.next()) {
      hayComponentes = true;
      curAC.setModeAccess(curAC.Browse);
      curAC.refreshBuffer();
      nuevaCantidad = cantidad * curAC.valueBuffer("cantidad");
      if (!this.iface.generarMoviStock(curLinea, codLote, nuevaCantidad, curAC)) {
        return false;
      }
    }
    if (hayComponentes) {
      return true;
    }
  }
  var aDatosStockLinea: Array = this.iface.dameDatosStockLinea(curLinea, curArticuloComp);
  if (!aDatosStockLinea)
  {
    return false;
  }

  if (!this.iface.curMoviStock)
  {
    this.iface.curMoviStock = new FLSqlCursor("movistock");
  }

  aDatosStockLinea.cantidad = cantidad;
  aDatosStockLinea.idProceso = idProceso;
  aDatosStockLinea.codLote = codLote;

  if (!this.iface.creaRegMoviStock(curLinea, datosArt, aDatosStockLinea, curArticuloComp))
  {
    return false;
  }

  return true;
}


/** Controla os stocks min e max nos compostos
\end */
function ctlStockMinMax_controlMinMaxComp(curLinea: FLSqlCursor, datosArt: Array, cantidad: Number): Boolean {


	var util: FLUtil = new FLUtil;
	var codAlmacen: String = this.iface.obtenerAlmacen(curLinea);
	var referencia: String = datosArt["referencia"];
	var barCode: String = datosArt["barcode"];
	//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_controlMinMaxComp");

	if (!codAlmacen || codAlmacen == "")
		return true;  //Saimos e continuamos o proceso anterior
		
		
	  //Saltamos o control cando o stock é por compoñentes.  
	var stockComp: Boolean = false;
	stockComp = util.sqlSelect("articulos", "stockcomp", "referencia = '" + referencia + "'");
	if (stockComp)
	  return true;
	  
	  
	  
	  //Obtemos o signo da cantidade según onde esteamos
	cantidad = this.iface.ctlStockMinMax_obtenerSignoCantidad(curLinea, cantidad);
	debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_controlMinMaxComp CANTIDAD xa procesada: " + cantidad);
       

	var stockMin: Number;
	var stockMax: Number;
	var stockActual: Number;

	//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_controlMinMaxComp");

	if (barCode && barCode != "")  {
		if (referencia && referencia != "") {
			//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_controlMinMaxComp OBTEMOS O STOCK MINIMO E MAXIMO DO ARTICULO con BARCODE POR ALMACÉN");
			// Buscamos antes no Almacén
			stockMin = util.sqlSelect("stocks", "stockmin", "referencia = '" + referencia + "' AND codalmacen = '" + codAlmacen + "' AND barcode = '" + barCode + "'");
			stockMax = util.sqlSelect("stocks", "stockmax", "referencia = '" + referencia + "' AND codalmacen = '" + codAlmacen + "' AND barcode = '" + barCode + "'");
			stockActual = util.sqlSelect("stocks", "cantidad", "referencia = '" + referencia + "' AND codalmacen = '" + codAlmacen + "' AND barcode = '" + barCode + "'");

			//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_controlMinMaxComp stockMin: " + stockMin + "   stockMax: " + stockMax + "    stockActual: " + stockActual);

			if (!stockActual)
				stockActual = 0;

			// Busscamos por último na ficha do artículo os seus stocks máximos
			if (!stockMin && !stockMax) {
				//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_controlMinMaxComp OBTEMOS O STOCK MINIMO E MAXIMO DO GENÉRICO DO ARTÍCULO con BARCODE");
				stockMin = util.sqlSelect("articulos", "stockmin", "referencia = '" + referencia + "'");
				stockMax = util.sqlSelect("articulos", "stockmax", "referencia = '" + referencia + "'");
				//MessageBox.warning(util.translate("scripts", "No se pudo obtener los stocks mínimo y máximo por almacén, se obtendrán de los genéricos del artículo.\n%1 - %2  Stock: %3 \nStock mínimo: %4  Stock máximo: %5.\n").arg(referencia).arg(barCode).arg(stockActual).arg(stockMin).arg(stockMax), MessageBox.Ok, MessageBox.NoButton);
			}
		} else {
			//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_controlMinMaxComp NON HAI REFERENCIA, SAIMOS");
			return true; //Saimos e que continúe o proceso
		}

    } else {
		if (referencia && referencia != "") {
			//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_controlMinMaxComp OBTEMOS O STOCK MINIMO E MAXIMO DO ARTICULO sen BARCODE POR ALMACÉN");
			stockMin = util.sqlSelect("stocks", "stockmin", "referencia = '" + referencia + "' AND codalmacen = '" + codAlmacen + "'");
			stockMax = util.sqlSelect("stocks", "stockmax", "referencia = '" + referencia + "' AND codalmacen = '" + codAlmacen + "'");
			stockActual = util.sqlSelect("stocks", "cantidad", "referencia = '" + referencia + "' AND codalmacen = '" + codAlmacen + "'");

			//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_controlMinMaxComp stockMin: " + stockMin + "   stockMax: " + stockMax + "    stockActual: " + stockActual);

			if (!stockActual)
				stockActual = 0;

			if (!stockMin && !stockMax) {
				//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_controlMinMaxComp OBTEMOS O STOCK MINIMO E MAXIMO DO GENÉRICO DO ARTICULO");
				stockMin = util.sqlSelect("articulos", "stockmin", "referencia = '" + referencia + "'");
				stockMax = util.sqlSelect("articulos", "stockmax", "referencia = '" + referencia + "'");
				//MessageBox.warning(util.translate("scripts", "No se pudo obtener los stocks mínimo y máximo por almacén, se obtendrán de los genéricos del artículo.\n%1  Stock: %2 \nStock mínimo: %3  Stock máximo: %4.\n").arg(referencia).arg(stockActual).arg(stockMin).arg(stockMax), MessageBox.Ok, MessageBox.NoButton);
			}
		} else {
			//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_controlMinMaxComp NON HAI REFERENCIA, SAIMOS");
			return true;
		}


    }


    var stockFinal: Number = stockActual + cantidad;
    var refCompleta:String = referencia;
    //debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_controlMinMaxComp codAlmacen: " + codAlmacen );
	//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_controlMinMaxComp Referencia: " + referencia + " Barcode: " + barCode);
	//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_controlMinMaxComp stockMin: " + stockMin + " stockMax: " + stockMax + " stockActual: " + stockActual);
	//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_controlMinMaxComp OLLO!!variacion: " + cantidad + " astockFinal: " + stockFinal);

	var distanciaMin: Number = stockMin - stockFinal
	var distanciaMax: Number = stockFinal - stockMax

	if (!barCode && barCode != "")
		refCompleta = refCompleta + " - " + barCode

	// Por debaixo do stock mínimo
	if (stockFinal < stockMin) {
		var resMin: Number = MessageBox.warning(util.translate("scripts", "El artículo %1 para el almacén %2 tiene establecido un stock mínimo de %3.\nSi se continúa se dejará el stock en %4, una diferencia de %5 por debajo del stock mínimo.\n\n¿Continuar con la operación?.").arg(refCompleta).arg(codAlmacen).arg(stockMin).arg(stockFinal).arg(distanciaMin), MessageBox.No, MessageBox.Yes);
		if (resMin == MessageBox.Yes) {
			//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_controlMinMaxComp BAIXO STOCK MINIMO ACTUALIZAMOS IGUAL EL STOCK");
			return true
        } else {
			//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_controlMinMaxComp BAIXO STOCK MINIMO NO ACTUALIZAMOS EL STOCK");
			return false;
		}
    }

    // Por riba do stock máximo
    if (stockFinal > stockMax) {
		var resMax: Number = MessageBox.warning(util.translate("scripts", "El artículo %1 para el almacén %2 tiene establecido un stock máximo de %3.\nSi se continúa se dejará el stock en %4, una diferencia de %5 por encima del stock máximo.\n\n¿Continuar con la operación?.").arg(refCompleta).arg(codAlmacen).arg(stockMax).arg(stockFinal).arg(distanciaMax), MessageBox.No, MessageBox.Yes);
		if (resMax == MessageBox.Yes) {
			//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_cambiarStock SOBRE STOCK MAXIMO ACTUALIZAMOS IGUAL EL STOCK");
			return true;
        } else {
			//debug("******FLFACTALMA****** >>>>>> ctlStockMinMax_cambiarStock SOBRE STOCK MAXIMO NO ACTUALIZAMOS EL STOCK");
			return false;
		}
    }


	// Se non se controlou a saida devolvemos o que nos de a función pai
	return true;


}






/* Devolvemos a cantidade co signo que corresponda según o que esteamos a facer */
function ctlStockMinMax_obtenerSignoCantidad(curLinea: FLSqlCursor, cantidad: Number): Number {
  var tabla: String = curLinea.table();
  switch (tabla) {
    case "lineaspresupuestoscli": {
      cantidad = parseFloat(cantidad) * -1;
      break;
    }
    case "lineaspedidoscli": {
      cantidad = parseFloat(cantidad) * -1;
      break;
    }
    case "lineaspedidosprov": {
     cantidad = parseFloat(cantidad) * -1;
      break;
    }
    case "tpv_lineascomanda": {
      cantidad = parseFloat(cantidad) * -1;
      break;
    }
    case "lineasalbaranescli": {
     cantidad = parseFloat(cantidad) * -1;
      break;
    }
    case "lineasfacturascli": {
     cantidad = parseFloat(cantidad) * -1;
      break;
    }
    case "lineascomposicion": {
      cantidad = parseFloat(cantidad) * -1;
      break;
    }

  }
  return cantidad;  

}






//// CONTROL STOCKS MÍNIMO E MAXIMO /////////////////////////////
/////////////////////////////////////////////////////////////////

