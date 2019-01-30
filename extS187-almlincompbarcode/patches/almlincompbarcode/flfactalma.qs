
/** @class_declaration almacenLinea */
/////////////////////////////////////////////////////////////////
//// ALMACEN_LINEA //////////////////////////////////////////////
class almacenLinea extends tallcolComp /** %from: tallcolComp */ {
	function almacenLinea( context ) { tallcolComp ( context ); }
	function controlStockPedidosCli(curLP:FLSqlCursor):Boolean {
		return this.ctx.almacenLinea_controlStockPedidosCli(curLP);
	}
	function controlStockPedidosProv(curLP:FLSqlCursor):Boolean {
		return this.ctx.almacenLinea_controlStockPedidosProv(curLP);
	}
	function controlStockAlbaranesCli(curLA:FLSqlCursor):Boolean {
		return this.ctx.almacenLinea_controlStockAlbaranesCli(curLA);
	}
	function controlStockAlbaranesProv(curLA:FLSqlCursor):Boolean {
		return this.ctx.almacenLinea_controlStockAlbaranesProv(curLA);
	}
	function controlStockFacturasCli(curLF:FLSqlCursor):Boolean {
		return this.ctx.almacenLinea_controlStockFacturasCli(curLF);
	}
	function controlStockFacturasProv(curLF:FLSqlCursor):Boolean {
		return this.ctx.almacenLinea_controlStockFacturasProv(curLF);
	}
	function controlStock( curLinea:FLSqlCursor, campo:String, signo:Number, codAlmacen:String ):Boolean {
		return this.ctx.almacenLinea_controlStock( curLinea, campo, signo, codAlmacen );
	}
	function cambiarStock(codAlmacen: String, barCode: String, referencia: String, variacion: Number, campo: String): Boolean {
    return this.ctx.almacenLinea_cambiarStock(codAlmacen, barCode, referencia, variacion, campo);
	}
	function controlStockPteRecibir(curLinea: FLSqlCursor, codAlmacen: String): Boolean
	{
		return this.ctx.almacenLinea_controlStockPteRecibir(curLinea, codAlmacen);
	}
	function actualizarStockPteRecibir(aArticulo: Array, codAlmacen: String, idPedido: String): Boolean {
		return this.ctx.almacenLinea_actualizarStockPteRecibir( aArticulo, codAlmacen, idPedido);
	}
	function consistenciaLinea(curLinea)
	{
		return this.ctx.almacenLinea_consistenciaLinea(curLinea);
	}
	function controlStockReservado(curLinea: FLSqlCursor, codAlmacen: String): Boolean
	{
		return this.ctx.almacenLinea_controlStockReservado(curLinea, codAlmacen);
	}
	function actualizarStockReservado(aArticulo: Array, codAlmacen: String, idPedido: String): Boolean {
		return this.ctx.almacenLinea_actualizarStockReservado(aArticulo, codAlmacen, idPedido);
	}
	function controlStockPedidosCliComp(curLP:FLSqlCursor):Boolean {
		return this.ctx.almacenLinea_controlStockPedidosCliComp(curLP);
	}
	function controlStockAlbaranesCliComp(curLA:FLSqlCursor):Boolean {
		return this.ctx.almacenLinea_controlStockAlbaranesCliComp(curLA);
	}
	function controlStockFacturasCliComp(curLF:FLSqlCursor):Boolean {
		return this.ctx.almacenLinea_controlStockFacturasCliComp(curLF);
	}
	function dameDatosStockLinea(curLinea: FLSqlCursor, curArticuloComp: FLSqlCursor): Array {
		return this.ctx.almacenLinea_dameDatosStockLinea(curLinea, curArticuloComp);
	}

	function obtenerAlmacen(curLinea:FLSqlCursor):String {
		return this.ctx.almacenLinea_obtenerAlmacen(curLinea);
	}



}
//// ALMACEN_LINEA //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition almacenLinea */
/////////////////////////////////////////////////////////////////
//// ALMACEN_LINEA //////////////////////////////////////////////
/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea
\end */
function almacenLinea_controlStockPedidosCli(curLP:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	//debug("******FLFACTALMA****** >>>>>> almacenLinea_controlStockPedidosCli");
	if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLP.valueBuffer("referencia") + "'")) {
		return true;
	}

	var codAlmacen:String = curLP.valueBuffer("codalmacen");
	if (!codAlmacen || codAlmacen == "") {
		var curRel:FLSqlCursor = curLP.cursorRelation();
		if (curRel && curRel.table() == "pedidoscli") {
			codAlmacen = curRel.valueBuffer("codalmacen");
		} else {
			codAlmacen = util.sqlSelect("pedidoscli", "codalmacen", "idpedido = " + curLP.valueBuffer("idpedido"));
		}
	}

	if (!codAlmacen || codAlmacen == "") {
		return true;
	}


	if (util.sqlSelect("articulos", "stockcomp", "referencia = '" + curLP.valueBuffer("referencia") + "'")) {
		if (!this.iface.controlStockPedidosCliComp(curLP)) { //Hacemos el control por componentes
		return false
		}
	} else {
		if (!this.iface.controlStockReservado(curLP, codAlmacen)) { //Control normal o por barCode
			return false;
		}
	}

	return true;

}



/** \C
Substituimos o control de pedido por esta por ser por compoñentes
\end */
function almacenLinea_controlStockPedidosCliComp(curLP:FLSqlCursor):Boolean
{

	//debug("******FLFACTALMA****** >>>>>> almacenLinea_controlStockPedidosCliComp");
	switch (curLP.modeAccess()) {
		case curLP.Insert: {

			if (!this.iface.generarEstructura(curLP)) {
				return false;
			}

			break;
		}
		case curLP.Edit: {
			if (this.iface.datosStockLineaCambian(curLP)) {
				if (!this.iface.borrarEstructura(curLP)) {
					return false;
				}
				if (!this.iface.generarEstructura(curLP)) {
					return false;
				}
			}
			break;
		}
	}
	return true;
}


/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea
en caso de que no venga de un pedido, o que la opción general de control
de stocks en pedidos esté inhabilitada
\end */
function almacenLinea_controlStockAlbaranesCli(curLA:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
//debug("******FLFACTALMA****** >>>>>> almacenLinea_controlStockAlbaranesCli");
	if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLA.valueBuffer("referencia") + "'")) {
		return true;
	}

//debug("******FLFACTALMA****** >>>>>> almacenLinea_controlStockAlbaranesCli HAI QUE VER O STOCK");
	var codAlmacen:String = curLA.valueBuffer("codalmacen");
	if (!codAlmacen || codAlmacen == "") {
		var curRel:FLSqlCursor = curLA.cursorRelation();
		if (curRel && curRel.table() == "albaranescli") {
			codAlmacen = curRel.valueBuffer("codalmacen");
		} else {
			codAlmacen = util.sqlSelect("albaranescli", "codalmacen", "idalbaran = " + curLA.valueBuffer("idalbaran"));
		}
//debug("******FLFACTALMA****** >>>>>> almacenLinea_controlStockAlbaranesCli o ALMACÉN é :" + codAlmacen);
	}
	if (!codAlmacen || codAlmacen == "") {
		return true;
	}


	if (util.sqlSelect("articulos", "stockcomp", "referencia = '" + curLA.valueBuffer("referencia") + "'")) {
		if (!this.iface.controlStockAlbaranesCliComp(curLA)) { //Hacemos el control por componentes
			return false
		}
	} else {
		if (!this.iface.controlStock( curLA, "cantidad", -1, codAlmacen )) { //Control normal o por barCode
			return false;
		}
	}


	return true;
}

/** \C
Substituimos o control de albaranes por esta por ser por compoñentes
\end */
function almacenLinea_controlStockAlbaranesCliComp(curLA:FLSqlCursor):Boolean
{
//debug("******FLFACTALMA****** >>>>>> almacenLinea_controlStockAlbaranesCliComp");

  var _i = this.iface;
  var idLineaPedido: String = curLA.valueBuffer("idlineapedido");
  var idLineaAlbaran: String = curLA.valueBuffer("idlinea");


  switch (curLA.modeAccess()) {
    case curLA.Insert: {
      if (!this.iface.generarEstructura(curLA)) {
        return false;
      }
      break;
    }
    case curLA.Edit: {
      if (this.iface.datosStockLineaCambian(curLA)) {
        if (!this.iface.borrarEstructura(curLA)) {
          return false;
        }
        if (!this.iface.generarEstructura(curLA)) {
          return false;
        }
      }
      break;
    }
  }
  //  }
  return true;
}

/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea
\end */
function almacenLinea_controlStockFacturasCli(curLF:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();

	//debug("******FLFACTALMA****** >>>>>> almacenLinea_controlStockFacturasCli");
	if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLF.valueBuffer("referencia") + "'")) {
		return true;
	}
	if (util.sqlSelect("facturascli", "automatica", "idfactura = " + curLF.valueBuffer("idfactura"))) {
		return true;
	}

	var codAlmacen:String = curLF.valueBuffer("codalmacen");
	if (!codAlmacen || codAlmacen == "") {
		var curRel:FLSqlCursor = curLF.cursorRelation();
		if (curRel && curRel.table() == "facturascli") {
			codAlmacen = curRel.valueBuffer("codalmacen");
		} else {
			codAlmacen = util.sqlSelect("facturascli", "codalmacen", "idfactura = " + curLF.valueBuffer("idfactura"));
		}
	}
	if (!codAlmacen || codAlmacen == "") {
		return true;
	}


	if (util.sqlSelect("articulos", "stockcomp", "referencia = '" + curLF.valueBuffer("referencia") + "'")) {
		if (!this.iface.controlStockFacturasCliComp(curLF)) { //Hacemos el control por componentes
			return false
		}
	} else {
		if (!this.iface.controlStock( curLF, "cantidad", -1, codAlmacen )) { //Control normal o por barCode
			return false;
		}
	}

	return true;
}


/** \C
Substituimos o control de facturas por esta por ser por compoñentes
\end */
function almacenLinea_controlStockFacturasCliComp(curLF:FLSqlCursor):Boolean
{
//debug("******FLFACTALMA****** >>>>>> almacenLinea_controlStockFacturasCliComp");

  var _i = this.iface;
  if (AQUtil.sqlSelect("articulos", "nostock", "referencia = '" + curLF.valueBuffer("referencia") + "'")) {
    return true;
  }
  if (AQUtil.sqlSelect("articulos", "nostock", "referencia = '" + curLF.valueBuffer("referencia") + "'")) {
    return true;
  }
  if (AQUtil.sqlSelect("facturascli", "automatica", "idfactura = " + curLF.valueBuffer("idfactura"))) {
    return true;
  }
  switch (curLF.modeAccess()) {
    case curLF.Insert: {
      if (!_i.generarEstructura(curLF)) {
        return false;
      }
      break;
    }
    case curLF.Edit: {
      if (_i.datosStockLineaCambian(curLF)) {
        if (!_i.borrarEstructura(curLF)) {
          return false;
        }
        if (!_i.generarEstructura(curLF)) {
          return false;
        }
      }
      break;
    }

  }
  return true;
}


/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea
\end */
function almacenLinea_controlStockPedidosProv(curLP:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
//debug("******FLFACTALMA****** >>>>>> almacenLinea_controlStockPedidosProv");
	if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLP.valueBuffer("referencia") + "'")) {
		return true;
	}

	var codAlmacen:String = curLP.valueBuffer("codalmacen");
	if (!codAlmacen || codAlmacen == "") {
		var curRel:FLSqlCursor = curLP.cursorRelation();
		if (curRel && curRel.table() == "pedidosprov") {
			codAlmacen = curRel.valueBuffer("codalmacen");
		} else {
			codAlmacen = util.sqlSelect("pedidosprov", "codalmacen", "idpedido = " + curLP.valueBuffer("idpedido"));
		}
	}
	if (!codAlmacen || codAlmacen == "") {
		return true;
	}

	if (!this.iface.controlStockPteRecibir(curLP, codAlmacen)) {
		return false;
	}

	return true;
}

/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea
\end */
function almacenLinea_controlStockAlbaranesProv(curLA:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
//debug("******FLFACTALMA****** >>>>>> almacenLinea_controlStockAlbaranesProv");
	if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLA.valueBuffer("referencia") + "'")) {
		return true;
	}
	var codAlmacen:String = curLA.valueBuffer("codalmacen");
	if (!codAlmacen || codAlmacen == "") {
		var curRel:FLSqlCursor = curLA.cursorRelation();
		if (curRel && curRel.table() == "albanesprov") {
			codAlmacen = curRel.valueBuffer("codalmacen");
		} else {
			codAlmacen = util.sqlSelect("albaranesprov", "codalmacen", "idalbaran = " + curLA.valueBuffer("idalbaran"));
		}
	}
	if (!codAlmacen || codAlmacen == "") {
		return true;
	}

	if (!this.iface.controlStock(curLA, "cantidad", 1, codAlmacen)) {
		return false;
	}
	return true;
}

/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea
\end */
function almacenLinea_controlStockFacturasProv(curLF:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
//debug("******FLFACTALMA****** >>>>>> almacenLinea_controlStockFacturasProv");
	if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLF.valueBuffer("referencia") + "'")) {
		return true;
	}
	if (util.sqlSelect("facturasprov", "automatica", "idfactura = " + curLF.valueBuffer("idfactura"))) {
		return true;
	}
	var codAlmacen:String = curLF.valueBuffer("codalmacen");
	if (!codAlmacen || codAlmacen == "") {
		var curRel:FLSqlCursor = curLF.cursorRelation();
		if (curRel && curRel.table() == "facturasprov") {
			codAlmacen = curRel.valueBuffer("codalmacen");
		} else {
			codAlmacen = util.sqlSelect("facturasprov", "codalmacen", "idfactura = " + curLF.valueBuffer("idfactura"));
		}
	}
	if (!codAlmacen || codAlmacen == "") {
		return true;
	}

	if (!this.iface.controlStock(curLF, "cantidad", 1, codAlmacen)) {
		return false;
	}
	return true;
}

/** \D Incrementa o decrementa el stock en función de la variación experimentada por una línea de documento de facturación
@param	curLinea: Cursor posicionado en la línea de documento de facturación
@param	campo: Campo a modificar
@param	operación: Indica si la cantidad debe sumarse o restarse del stock
@param	codAlmacen: Código del almacén asociado al stock a modificar
@return	True si el control se realiza correctamente, false en caso contrario
*/
function almacenLinea_controlStock( curLinea:FLSqlCursor, campo:String, signo:Number, codAlmacen:String ):Boolean
{
	//debug("******FLFACTALMA****** >>>>>> almacenLinea_controlStock");
	var variacion:Number;
	var cantidad:Number = parseFloat( curLinea.valueBuffer( "cantidad" ) );
	var cantidadPrevia:Number = parseFloat( curLinea.valueBufferCopy( "cantidad" ) );
	var codAlmacenViejo:String;


	var barCode:String = curLinea.valueBuffer( "barcode" )
	if (!barCode || barCode == "") {
		//debug("******FLFACTALMA****** >>>>>> almacenLinea_controlStock >> Pois non hai barcode: " + barCode);
		barCode = false;
	}
	//debug("******FLFACTALMA****** >>>>>> almacenLinea_controlStock >> barcode: " + barCode);

	if ( curLinea.table() == "lineaspedidoscli" || curLinea.table() == "lineaspedidosprov" ) {
		cantidad -= parseFloat( curLinea.valueBuffer( "totalenalbaran" ) );
		cantidadPrevia -= parseFloat( curLinea.valueBufferCopy( "totalenalbaran" ) );
	}

	switch(curLinea.modeAccess()) {
		case curLinea.Insert: {
			variacion = signo * cantidad;
			if ( !this.iface.cambiarStock( codAlmacen, barCode, curLinea.valueBuffer( "referencia" ), variacion, campo ) )
				return false;
			break;
		}
		case curLinea.Del: {
			variacion = signo * -1 * cantidad;
			if ( !this.iface.cambiarStock( codAlmacen, barCode, curLinea.valueBuffer( "referencia" ), variacion, campo ) )
				return false;
			break;
		}
		case curLinea.Edit: {
			codAlmacenViejo = curLinea.valueBufferCopy( "codalmacen" );
			if (codAlmacenViejo == "")
					{
					var curRel:FLSqlCursor = curLinea.cursorRelation();
					// Soamente se existe o curRelacionado para qei non de errores ao mover as liñas, por exemplo, que se produce un Edit
					if (curRel) 
						codAlmacenViejo = curRel.valueBufferCopy("codalmacen");
					}
			if (!codAlmacenViejo)
				codAlmacenViejo = codAlmacen;





			if ((curLinea.valueBuffer( "referencia" ) != curLinea.valueBufferCopy( "referencia" )) || codAlmacen != codAlmacenViejo ) {
				variacion = signo * -1 * cantidadPrevia;
				if ( !this.iface.cambiarStock( codAlmacenViejo,barCode, curLinea.valueBufferCopy( "referencia" ), variacion, campo ) )
					return false;
				variacion = signo * cantidad;
				if ( !this.iface.cambiarStock( codAlmacen, barCode, curLinea.valueBuffer( "referencia" ), variacion, campo, true ) )
					return false;
			}
			else {
				if(cantidad != cantidadPrevia);
				variacion = (cantidad - cantidadPrevia) * signo;
				if (!this.iface.cambiarStock( codAlmacen, barCode,curLinea.valueBuffer( "referencia" ), variacion, campo) )
					return false;
			}
			break;
		}
	}

	return true;
}

/*VA IMPLEMENTADA COMO LA DE BARCODE */

function almacenLinea_actualizarStockPteRecibir(aArticulo: Array, codAlmacen: String, idPedido: String): Boolean {
	//debug("******FLFACTALMA****** >>>>>> almacenLinea_actualizarStockPteRecibir");
	//debug("******FLFACTALMA****** >>>>>> almacenLinea_actualizarStockPteRecibir codAlmacen: " + codAlmacen);
	//debug("******FLFACTALMA****** >>>>>> almacenLinea_actualizarStockPteRecibir idPedido: " + idPedido);

  var util: FLUtil = new FLUtil;
  var referencia: String = aArticulo["referencia"];
  var barcode: String = "";
  if ("barcode" in aArticulo)
    barcode = aArticulo["barcode"];
//debug("******FLFACTALMA****** >>>>>> almacenLinea_actualizarStockPteRecibir referencia: " + referencia);
//debug("******FLFACTALMA****** >>>>>> almacenLinea_actualizarStockPteRecibir barcode: " + barcode);






  // Escollemos o almacén de línea, se nesta non hai nada o collemos do xenérico

  var idStock: String;

  if (!barcode || barcode == "")
  {
    idStock = util.sqlSelect("stocks", "idstock", "referencia = '" + referencia + "' AND (barcode IS NULL OR barcode = '') AND codalmacen = '" + codAlmacen + "'");
  } else {
    idStock = util.sqlSelect("stocks", "idstock", "referencia = '" + referencia + "' AND barcode = '" + barcode + "' AND codalmacen = '" + codAlmacen + "'" );
  }

//debug("******FLFACTALMA****** >>>>>> almacenLinea_actualizarStockPteRecibir idStock: " + idStock);

  if (!idStock)
  {
    var oArticulo = new Object();
    oArticulo.referencia = referencia;
    oArticulo.barcode  = barcode;
    idStock = this.iface.crearStock(codAlmacen, oArticulo);
    if (!idStock) {
      return false;
    }
  }

  var sqlWhereSelAlmacen: String = "(((lp.codalmacen is NULL or lp.codalmacen = '" + codAlmacen + "' ) AND p.codalmacen = '" + codAlmacen + "') or lp.codalmacen = '" + codAlmacen + "')";

  var pteRecibir: Number;
  if (!barcode || barcode == "")
  {
    pteRecibir = util.sqlSelect("lineaspedidosprov lp INNER JOIN pedidosprov p ON lp.idpedido = p.idpedido", "sum(lp.cantidad - lp.totalenalbaran)", sqlWhereSelAlmacen + " AND (p.servido IN ('No', 'Parcial') OR p.idpedido = " + idPedido + ") AND lp.referencia = '" + referencia + "' AND (barcode IS NULL OR barcode = '') AND (lp.cerrada IS NULL OR lp.cerrada = false)", "lineaspedidosprov,pedidosprov");
  } else {
    pteRecibir = util.sqlSelect("lineaspedidosprov lp INNER JOIN pedidosprov p ON lp.idpedido = p.idpedido", "sum(lp.cantidad - lp.totalenalbaran)", sqlWhereSelAlmacen + " AND (p.servido IN ('No', 'Parcial') OR p.idpedido = " + idPedido + ") AND lp.referencia = '" + referencia + "' AND barcode = '" + barcode + "' AND (lp.cerrada IS NULL OR lp.cerrada = false)", "lineaspedidosprov,pedidosprov");
  }

  if (isNaN(pteRecibir))
  {
    pteRecibir = 0;
  }
//debug("******FLFACTALMA****** >>>>>> almacenLinea_actualizarStockPteRecibir pteRecibir: " + pteRecibir);

  var curStock: FLSqlCursor = new FLSqlCursor("stocks");
  curStock.select("idstock = " + idStock);
  if (!curStock.first())
  {
    return false;
  }
  curStock.setModeAccess(curStock.Edit);
  curStock.refreshBuffer();
  curStock.setValueBuffer("pterecibir", pteRecibir);
  try  {
    if (!curStock.commitBuffer(true))
    {
      return false;
    }
  } catch (e)
  {
    if (!curStock.commitBuffer()) {
      return false;
    }
  }
  return true;
}


function almacenLinea_consistenciaLinea(curLinea)
{

	//HAY QUE MIRAR COMO VA CON LOS COMPUESTOS!!!!!

	//debug("******FLFACTALMA****** >>>>>> almacenLinea_consistenciaLinea");
  return true;
}

//La traemos de Barcode, comprobar con articulos compuestos
function almacenLinea_controlStockReservado(curLinea: FLSqlCursor, codAlmacen: String): Boolean {
	 //debug("******FLFACTALMA****** >>>>>> almacenLinea_controlStockReservado");
  var util: FLUtil = new FLUtil;

  var idPedido: String = curLinea.valueBuffer("idpedido");
  var aArticulo: Array = [];
  aArticulo["referencia"] = curLinea.valueBuffer("referencia");
  aArticulo["barcode"] = curLinea.valueBuffer("barcode");

  if ((aArticulo["referencia"] && aArticulo["referencia"] != "") || (aArticulo["barcode"] && aArticulo["barcode"] != ""))
  {
    if (!this.iface.actualizarStockReservado(aArticulo, codAlmacen, idPedido)) {
      return false;
    }
  }

  var aArticuloPrevio: Array = [];
  aArticuloPrevio["referencia"] = curLinea.valueBufferCopy("referencia");
  aArticuloPrevio["barcode"] = curLinea.valueBufferCopy("barcode");
  if ((aArticuloPrevio["referencia"] && aArticuloPrevio["referencia"] != "" && aArticuloPrevio["referencia"] != aArticulo["referencia"]) || (aArticuloPrevio["barcode"] && aArticuloPrevio["barcode"] != "" && aArticuloPrevio["barcode"] != aArticulo["barcode"]))
  {
    if (!this.iface.actualizarStockReservado(aArticuloPrevio, codAlmacen, idPedido)) {
      return false;
    }
  }

  return true;
}


//Traémola de BarCode mirar de facer tamén compoñentes
function almacenLinea_controlStockPteRecibir(curLinea: FLSqlCursor, codAlmacen: String): Boolean {
	 //debug("******FLFACTALMA****** >>>>>> almacenLinea_controlStockPteRecibir");
  var util: FLUtil = new FLUtil;


  var idPedido: String = curLinea.valueBuffer("idpedido");
  var aArticulo: Array = [];
  aArticulo["referencia"] = curLinea.valueBuffer("referencia");
  aArticulo["barcode"] = curLinea.valueBuffer("barcode");

  if ((aArticulo["referencia"] && aArticulo["referencia"] != "") || (aArticulo["barcode"] && aArticulo["barcode"] != ""))
  {
	//debug("******FLFACTALMA****** >>>>>> almacenLinea_controlStockPteRecibir  >>> Xusto antes de this.iface.actualizarStockPteRecibir ANTES DE PREVIO");
    if (!this.iface.actualizarStockPteRecibir(aArticulo, codAlmacen, idPedido)) {
      return false;
    }
  }

  var aArticuloPrevio: Array = [];
  aArticuloPrevio["referencia"] = curLinea.valueBufferCopy("referencia");
  aArticuloPrevio["barcode"] = curLinea.valueBufferCopy("barcode");
  if ((aArticuloPrevio["referencia"] && aArticuloPrevio["referencia"] != "" && aArticuloPrevio["referencia"] != aArticulo["referencia"]) || (aArticuloPrevio["barcode"] && aArticuloPrevio["barcode"] != "" && aArticuloPrevio["barcode"] != aArticulo["barcode"]))
  {
	//debug("******FLFACTALMA****** >>>>>> almacenLinea_controlStockPteRecibir  >>> Xusto antes de this.iface.actualizarStockPteRecibir DESPOIS DE PREVIO");
    if (!this.iface.actualizarStockPteRecibir(aArticuloPrevio, codAlmacen, idPedido)) {
      return false;
    }
  }

  return true;
}



//La traemos de Barcode, comprobar con articulos compuestos
function almacenLinea_actualizarStockReservado(aArticulo: Array, codAlmacen: String, idPedido: String): Boolean {
	 //debug("******FLFACTALMA****** >>>>>> almacenLinea_actualizarStockReservado");
  var util: FLUtil = new FLUtil;
  var referencia = aArticulo["referencia"];
  var barcode = "";
  if ("barcode" in aArticulo)
    barcode = aArticulo["barcode"];


  if (!referencia || referencia == "")
  {
    return true;
  }
  var idStock: String;
  if (!barcode || barcode == "")
  {
    idStock = util.sqlSelect("stocks", "idstock", "referencia = '" + referencia + "' AND (barcode IS NULL OR barcode = '') AND codalmacen = '" + codAlmacen + "'");
  } else {
    idStock = util.sqlSelect("stocks", "idstock", "referencia = '" + referencia + "' AND barcode = '" + barcode + "' AND codalmacen = '" + codAlmacen + "'");
  }
  if (!idStock)
  {
    var oArticulo = new Object();
    oArticulo.referencia = referencia;
    oArticulo.barcode  = barcode;
    idStock = this.iface.crearStock(codAlmacen, oArticulo);
    if (!idStock) {
      return false;
    }
  }

  //Vemos se hai almacén por liña, se non hai collemos o do pedido
  var sqlWhereSelAlmacen: String = "(((lp.codalmacen is NULL or lp.codalmacen = '" + codAlmacen + "' ) AND p.codalmacen = '" + codAlmacen + "') or lp.codalmacen = '" + codAlmacen + "')";

  var reservada: Number;
  if (!barcode || barcode == "")
  {
    reservada = util.sqlSelect("lineaspedidoscli lp INNER JOIN pedidoscli p ON lp.idpedido = p.idpedido", "sum(lp.cantidad - lp.totalenalbaran)", sqlWhereSelAlmacen + " AND (p.servido IN ('No', 'Parcial') OR p.idpedido = " + idPedido + ") AND lp.referencia = '" + referencia + "' AND (barcode IS NULL OR barcode = '') AND (lp.cerrada IS NULL OR lp.cerrada = false)", "lineaspedidoscli,pedidoscli");
  } else {
    reservada = util.sqlSelect("lineaspedidoscli lp INNER JOIN pedidoscli p ON lp.idpedido = p.idpedido", "sum(lp.cantidad - lp.totalenalbaran)", sqlWhereSelAlmacen + " AND (p.servido IN ('No', 'Parcial') OR p.idpedido = " + idPedido + ") AND lp.referencia = '" + referencia + "' AND barcode = '" + barcode + "' AND (lp.cerrada IS NULL OR lp.cerrada = false)", "lineaspedidoscli,pedidoscli");
  }
  if (isNaN(reservada))
  {
    reservada = 0;
  }

  var curStock: FLSqlCursor = new FLSqlCursor("stocks");
  curStock.select("idstock = " + idStock);
  if (!curStock.first())
  {
    return false;
  }
  curStock.setModeAccess(curStock.Edit);
  curStock.refreshBuffer();
  curStock.setValueBuffer("reservada", reservada);
  curStock.setValueBuffer("disponible", formRecordregstocks.iface.pub_commonCalculateField("disponible", curStock));
  if (!this.iface.comprobarStock(curStock))
  {
    return false;
  }
  try  {
    if (!curStock.commitBuffer(true))
    {
      return false;
    }
  } catch (e)
  {
    if (!curStock.commitBuffer()) {
      return false;
    }
  }
  return true;
}



/** \D Cambia un campo del stock según la variación especificada, controla se hai ou non barcode
@param  codAlmacen: Código del almacén asociado al stock
@param  barCode: Bar code asociado al stock
@param  referencia: Referencia asociada al stock
@param  variacion: Variación a aplicar
@param  campo: Nombre del campo a modificar
@return identificador del stock creado si la inserción es correcta, false en caso contrario
*/
function almacenLinea_cambiarStock(codAlmacen: String, barCode: String, referencia: String, variacion: Number, campo: String)
{
//debug("******FLFACTALMA****** >>>>>> almacenLinea_cambiarStock");
  var util: FLUtil = new FLUtil;
  var idStock: String;
  if (!referencia || referencia == "")
    return true;
//debug("******FLFACTALMA****** >>>>>> almacenLinea_cambiarStock >>> referencia: " + referencia);
//debug("******FLFACTALMA****** >>>>>> almacenLinea_cambiarStock >>> codAlmacen: " + codAlmacen);
//debug("******FLFACTALMA****** >>>>>> almacenLinea_cambiarStock >>> barCode: " + barCode);

  if (!barCode || barCode == "") {
    idStock = util.sqlSelect("stocks", "idstock", "referencia = '" + referencia + "' AND (barcode IS NULL OR barcode = '') AND codalmacen = '" + codAlmacen + "'");
    barCode = ""; //Lo forzamos para que no de error cuando lo busque por false
  } else {
    idStock = util.sqlSelect("stocks", "idstock", "referencia = '" + referencia + "' AND barcode = '" + barCode + "' AND codalmacen = '" + codAlmacen + "'");
  }

//debug("******FLFACTALMA****** >>>>>> almacenLinea_cambiarStock >>> idStock: " + idStock);
  if (!idStock) {
    var oArticulo = new Object();
    oArticulo.referencia = referencia;
    oArticulo.barcode  = barCode;
//debug("******FLFACTALMA****** >>>>>> almacenLinea_cambiarStock >>> NON HAI STOCK, DEBEMOS CREALO!");
    idStock = this.iface.crearStock(codAlmacen, oArticulo);
    if (!idStock)
      return false;
  }
  var curStock: FLSqlCursor = new FLSqlCursor("stocks");
  curStock.select("idstock = " + idStock);
  if (!curStock.first())
    return false;

  curStock.setModeAccess(curStock.Edit);
  curStock.refreshBuffer();

  var cantidadPrevia: Number = parseFloat(curStock.valueBuffer(campo));
  var nuevaCantidad: Number = cantidadPrevia + parseFloat(variacion);
  if (nuevaCantidad < 0 && campo == "cantidad") {
    if (!util.sqlSelect("articulos", "controlstock", "referencia = '" + referencia + "'")) {
      MessageBox.warning(util.translate("scripts", "No hay suficiente stock en el almacén %1 para el artículo %2 - %3.\nLa operación no puede realizarse").arg(codAlmacen).arg(referencia).arg(barCode), MessageBox.Ok, MessageBox.NoButton);
      return false;
    }
  }

  curStock.setValueBuffer(campo, nuevaCantidad);

  if (campo == "cantidad" || campo == "reservada") {
    curStock.setValueBuffer("disponible", formRecordregstocks.iface.pub_commonCalculateField("disponible", curStock));
  }
  //debug("CS ");
  try  {
    if (!curStock.commitBuffer(true)) {
      return false;
    }
  } catch (e) {
    if (!curStock.commitBuffer()) {
      return false;
    }
  }
  return true;
}




/** \D Obtiene los datos de almacén y fecha correspondientes a los movimientos asociados a una línea de facturación
 * La substituimos por esta por obtener el almacén de la línea y no del pedido
@param  curLinea: Cursor de la línea
@param  curArticuloComp: Cursor de la composición
@return array con los datos:
\end */
function almacenLinea_dameDatosStockLinea(curLinea, curArticuloComp)
{
//debug("******FLFACTALMA****** >>>>>> articomp_dameDatosStockLinea");
  var util: FLUtil = new FLUtil;
  var aDatos: Array = [];
  var aAux: Array;
  var tabla: String = curLinea.table();
  var curRelation: FLSqlCursor = curLinea.cursorRelation();
  var tablaRel: String = curRelation ? curRelation.table() : "";
  var codAlmacen: String, hora: String;

  switch (tabla) {
    case "lineaspedidoscli": {
      aDatos.idLinea = curLinea.valueBuffer("idlinea");
      aDatos.codAlmacen = this.iface.almacenLinea_obtenerAlmacen(curLinea);
      if (tablaRel == "pedidoscli") {
		aDatos.fechaPrev = curRelation.valueBuffer("fechasalida");
        aDatos.concepto = curRelation.valueBuffer("codigo");
        aDatos.concepto += " " + curRelation.valueBuffer("nombrecliente");
      } else {
        aAux = flfactppal.iface.pub_ejecutarQry("pedidoscli", "codalmacen,fechasalida,codigo,nombrecliente", "idpedido = " + curLinea.valueBuffer("idpedido"));
        if (aAux.result != 1) {
          return false;
        }
        aDatos.fechaPrev = aAux.fechasalida;
        aDatos.concepto = aAux.codigo;
        aDatos.concepto += " " + aAux.nombrecliente;
      }
      aDatos.concepto = sys.translate("Pedido cliente %1").arg(aDatos.concepto);
      break;
    }
    case "lineaspedidosprov": {
      aDatos.idLinea = curLinea.valueBuffer("idlinea");
      aDatos.codAlmacen = this.iface.almacenLinea_obtenerAlmacen(curLinea);
      if (tablaRel == "pedidosprov") {

        aDatos.fechaPrev = curRelation.valueBuffer("fechaentrada");
        aDatos.concepto = curRelation.valueBuffer("codigo");
        aDatos.concepto += " " + curRelation.valueBuffer("nombre");
      } else {
        aAux = flfactppal.iface.pub_ejecutarQry("pedidosprov", "codalmacen,fechaentrada,codigo,nombre", "idpedido = " + curLinea.valueBuffer("idpedido"));
        if (aAux.result != 1) {
          return false;
        }

        aDatos.fechaPrev = aAux.fechaentrada;
        aDatos.concepto = aAux.codigo;
        aDatos.concepto += " " + aAux.nombre;
      }
      aDatos.concepto = sys.translate("Pedido proveedor %1").arg(aDatos.concepto);
      break;
    }
    case "tpv_lineascomanda": {
      aDatos.idLinea = curLinea.valueBuffer("idtpv_linea");
      if (tablaRel == "tpv_comandas") {
        aDatos.codAlmacen = curRelation.valueBuffer("codalmacen");
        aDatos.fechaReal = curRelation.valueBuffer("fecha");
        hora = curRelation.valueBuffer("hora");
        aDatos.concepto = curRelation.valueBuffer("codigo");
        aDatos.concepto += " " + curRelation.valueBuffer("nombrecliente");
      } else {
        aAux = flfactppal.iface.pub_ejecutarQry("tpv_comandas", "codalmacen,fecha,hora,codigo,nombrecliente", "idtpv_comanda = " + curLinea.valueBuffer("idtpv_comanda"));
        if (aAux.result != 1) {
          return false;
        }
        aDatos.codAlmacen = aAux.codalmacen;
        aDatos.fechaReal = aAux.fecha;
        hora = aAux.hora;
        aDatos.concepto = aAux.codigo;
        aDatos.concepto += " " + aAux.nombrecliente;
      }
      aDatos.horaReal = hora.toString().right(8);
      aDatos.concepto = sys.translate("Venta TPV %1").arg(aDatos.concepto);
      break;
    }
    case "tpv_lineasvale": {
      aDatos.idLinea = curLinea.valueBuffer("idlinea");
      aDatos.fechaReal = curLinea.valueBuffer("fecha");
      hora = curLinea.valueBuffer("hora");
      aDatos.horaReal = hora.toString().right(8);
      aDatos.codAlmacen = curLinea.valueBuffer("codalmacen");
      aDatos.concepto = sys.translate("Vale TPV");
      break;
    }
    case "lineasalbaranescli": {
      aDatos.idLinea = curLinea.valueBuffer("idlinea");
       aDatos.codAlmacen = this.iface.almacenLinea_obtenerAlmacen(curLinea);
      if (tablaRel == "albaranescli") {

        aDatos.fechaReal = curRelation.valueBuffer("fecha");
        hora = curRelation.valueBuffer("hora");
        aDatos.concepto = curRelation.valueBuffer("codigo");
        aDatos.concepto += " " + curRelation.valueBuffer("nombrecliente");
      } else {
        aAux = flfactppal.iface.pub_ejecutarQry("albaranescli", "codalmacen,fecha,hora,codigo,nombrecliente", "idalbaran = " + curLinea.valueBuffer("idalbaran"));
        if (aAux.result != 1) {
          return false;
        }

        aDatos.fechaReal = aAux.fecha;
        hora = aAux.hora;
        aDatos.concepto = aAux.codigo;
        aDatos.concepto += " " + aAux.nombrecliente;
      }
      aDatos.horaReal = hora.toString().right(8);
      aDatos.concepto = sys.translate("Albarán cliente %1").arg(aDatos.concepto);
      break;
    }
    case "lineasalbaranesprov": {
      aDatos.idLinea = curLinea.valueBuffer("idlinea");
      aDatos.codAlmacen = this.iface.almacenLinea_obtenerAlmacen(curLinea);
      if (tablaRel == "albaranesprov") {

        aDatos.fechaReal = curRelation.valueBuffer("fecha");
        hora = curRelation.valueBuffer("hora");
        aDatos.concepto = curRelation.valueBuffer("codigo");
        aDatos.concepto += " " + curRelation.valueBuffer("nombre");
      } else {
        aAux = flfactppal.iface.pub_ejecutarQry("albaranesprov", "codalmacen,fecha,hora,codigo,nombre", "idalbaran = " + curLinea.valueBuffer("idalbaran"));
        if (aAux.result != 1) {
          return false;
        }

        aDatos.fechaReal = aAux.fecha;
        hora = aAux.hora;
        aDatos.concepto = aAux.codigo;
        aDatos.concepto += " " + aAux.nombre;
      }
      aDatos.horaReal = hora.toString().right(8);
      aDatos.concepto = sys.translate("Albarán proveedor %1").arg(aDatos.concepto);
      break;
    }
    case "lineasfacturascli": {
      aDatos.idLinea = curLinea.valueBuffer("idlinea");
       aDatos.codAlmacen = this.iface.almacenLinea_obtenerAlmacen(curLinea);
      if (tablaRel == "facturascli") {

        aDatos.fechaReal = curRelation.valueBuffer("fecha");
        hora = curRelation.valueBuffer("hora");
        aDatos.concepto = curRelation.valueBuffer("codigo");
        aDatos.concepto += " " + curRelation.valueBuffer("nombrecliente");
      } else {
        aAux = flfactppal.iface.pub_ejecutarQry("facturascli", "codalmacen,fecha,hora,codigo,nombrecliente", "idfactura = " + curLinea.valueBuffer("idfactura"));
        if (aAux.result != 1) {
          return false;
        }

        aDatos.fechaReal = aAux.fecha;
        hora = aAux.hora;
        aDatos.concepto = aAux.codigo;
        aDatos.concepto += " " + aAux.nombrecliente;
      }
      aDatos.horaReal = hora.toString().right(8);
      aDatos.concepto = sys.translate("Factura cliente %1").arg(aDatos.concepto);
      break;
    }
    case "lineasfacturasprov": {
      aDatos.idLinea = curLinea.valueBuffer("idlinea");
       aDatos.codAlmacen = this.iface.almacenLinea_obtenerAlmacen(curLinea);
      if (tablaRel == "facturasprov") {

        aDatos.fechaReal = curRelation.valueBuffer("fecha");
        hora = curRelation.valueBuffer("hora");
        aDatos.concepto = curRelation.valueBuffer("codigo");
        aDatos.concepto += " " + curRelation.valueBuffer("nombre");
      } else {
        aAux = flfactppal.iface.pub_ejecutarQry("facturasprov", "codalmacen,fecha,hora,codigo,nombre", "idfactura = " + curLinea.valueBuffer("idfactura"));
        if (aAux.result != 1) {
          return false;
        }

        aDatos.fechaReal = aAux.fecha;
        hora = aAux.hora;
        aDatos.concepto = aAux.codigo;
        aDatos.concepto += " " + aAux.nombre;
      }
      aDatos.horaReal = hora.toString().right(8);
      aDatos.concepto = sys.translate("Factura proveedor %1").arg(aDatos.concepto);
      break;
    }
    case "lineastransstock": {
      aDatos.idLinea = curLinea.valueBuffer("idlinea");
      if (tablaRel == "transstock") {
        aDatos.codAlmaOrigen = curRelation.valueBuffer("codalmaorigen");
        aDatos.codAlmaDestino = curRelation.valueBuffer("codalmadestino");
        aDatos.fechaReal = curRelation.valueBuffer("fecha");
        hora = curRelation.valueBuffer("hora");
      } else {
        aAux = flfactppal.iface.pub_ejecutarQry("transstock", "codalmaorigen,codalmadestino,fecha,hora", "idtrans = " + curLinea.valueBuffer("idtrans"));
        if (aAux.result != 1) {
          return false;
        }
        aDatos.codAlmaOrigen = aAux.codalmaorigen;
        aDatos.codAlmaDestino = aAux.codalmadestino;
        aDatos.fechaReal = aAux.fecha;
        hora = aAux.hora;
      }
      aDatos.horaReal = hora.toString().right(8);
      aDatos.concepto = sys.translate("Transferencia %1 desde %2 hasta %3").arg(curLinea.valueBuffer("idtrans")).arg(aDatos.codAlmaOrigen).arg(aDatos.codAlmaDestino);
      break;
    }
    case "composiciones": {
      aDatos.idLinea = curLinea.valueBuffer("idcomposicion");
      aDatos.codAlmacen = curLinea.valueBuffer("codalmacen");
      aDatos.fechaReal = curLinea.valueBuffer("fecha");
      hora = curLinea.valueBuffer("hora");;
      aDatos.horaReal = hora.toString().right(8);
      break;
    }
    case "lineascomposicion": {
      aDatos.idLinea = curLinea.valueBuffer("idlinea");
      aDatos.codAlmacen = curLinea.valueBuffer("codalmacen");
      if (tablaRel == "composiciones") {
        aDatos.fechaReal = curRelation.valueBuffer("fecha");
        hora = curRelation.valueBuffer("hora");
      } else {
        aAux = flfactppal.iface.pub_ejecutarQry("composiciones", "fecha,hora", "idcomposicion = " + curLinea.valueBuffer("idcomposicion"));
        if (aAux.result != 1) {
          return false;
        }
        aDatos.fechaReal = aAux.fecha;
        hora = aAux.hora;
      }
      aDatos.horaReal = hora.toString().right(8);
      break;
    }
    default: {
      aDatos = false;
    }
  }
  return aDatos;
}


// Nos devuelve el código de almacén de la línea y si no hay nada pues de la cabecera del documento.
function almacenLinea_obtenerAlmacen(curLinea:FLSqlCursor):String
{
	debug("******FLFACTALMA****** >>>>>> almacenLinea_obtenerAlmacen");
	var util: FLUtil = new FLUtil;
	var curRel:FLSqlCursor = curLinea.cursorRelation();
	var codAlmacen:String = curLinea.valueBuffer("codalmacen");

  //
	if (codAlmacen || codAlmacen != "") {
		debug("******FLFACTALMA****** >>>>>> almacenLinea_obtenerAlmacen ALMACÉN POR LIÑA Saímos con codAlmacen: " + codAlmacen);
		return codAlmacen;
	}


	if (curRel) {
		switch (curRel.table()) {
			case "pedidoscli": {
				codAlmacen = util.sqlSelect("pedidoscli", "codalmacen", "idpedido = " + curLinea.valueBuffer("idpedido"));
				debug("******FLFACTALMA****** >>>>>> almacenLinea_obtenerAlmacen PEDIDOSCLI buscada SQL saímos con codAlmacen: " + codAlmacen);
				return codAlmacen;
			}
			case "albaranescli": {
				codAlmacen = util.sqlSelect("albaranescli", "codalmacen", "idalbaran = " + curLinea.valueBuffer("idalbaran"));
				debug("******FLFACTALMA****** >>>>>> almacenLinea_obtenerAlmacen ALBARANESCLI buscada saímos con codAlmacen: " + codAlmacen);
				return codAlmacen;
			}
			case "facturascli": {
				codAlmacen = util.sqlSelect("facturascli", "codalmacen", "idfactura = " + curLinea.valueBuffer("idfactura"));
				debug("******FLFACTALMA****** >>>>>> almacenLinea_obtenerAlmacen FACTURASCLI buscada saímos con codAlmacen: " + codAlmacen);
				return codAlmacen;
			}
			case "pedidosprov": {
				codAlmacen = util.sqlSelect("pedidosprov", "codalmacen", "idpedido = " + curLinea.valueBuffer("idpedido"));
				debug("******FLFACTALMA****** >>>>>> almacenLinea_obtenerAlmacen PEDIDOSprov buscada saímos con codAlmacen: " + codAlmacen);
				return codAlmacen;
			}
			case "albaranesprov": {
				codAlmacen = util.sqlSelect("albaranesprov", "codalmacen", "idalbaran = " + curLinea.valueBuffer("idalbaran"));
				debug("******FLFACTALMA****** >>>>>> almacenLinea_obtenerAlmacen ALBARANESprov buscada saímos con codAlmacen: " + codAlmacen);
				return codAlmacen;
			}
			case "facturasprov": {
				codAlmacen = util.sqlSelect("facturasprov", "codalmacen", "idfactura = " + curLinea.valueBuffer("idfactura"));
				debug("******FLFACTALMA****** >>>>>> almacenLinea_obtenerAlmacen FACTURASprov buscada saímos con codAlmacen: " + codAlmacen);
				return codAlmacen;
			}
		}
	}
  
  
  // Se non funcionou o CurRelation imos directamente ao meollo, á liña, para cando se traspasa de un documento ao outro
  if (curLinea) {
		switch (curLinea.table()) {
			case "lineaspedidoscli": {
				codAlmacen = util.sqlSelect("pedidoscli", "codalmacen", "idpedido = " + curLinea.valueBuffer("idpedido"));
				debug("******FLFACTALMA****** >>>>>> almacenLinea_obtenerAlmacen lineasPEDIDOSCLI buscada SQL saímos con codAlmacen: " + codAlmacen);
				return codAlmacen;
			}
			case "lineasalbaranescli": {
				codAlmacen = util.sqlSelect("albaranescli", "codalmacen", "idalbaran = " + curLinea.valueBuffer("idalbaran"));
				debug("******FLFACTALMA****** >>>>>> almacenLinea_obtenerAlmacen lineasALBARANESCLI buscada saímos con codAlmacen: " + codAlmacen);
				return codAlmacen;
			}
			case "lineasfacturascli": {
				codAlmacen = util.sqlSelect("facturascli", "codalmacen", "idfactura = " + curLinea.valueBuffer("idfactura"));
				debug("******FLFACTALMA****** >>>>>> almacenLinea_obtenerAlmacen lineasFACTURASCLI buscada saímos con codAlmacen: " + codAlmacen);
				return codAlmacen;
			}
			case "lineaspedidosprov": {
				codAlmacen = util.sqlSelect("pedidosprov", "codalmacen", "idpedido = " + curLinea.valueBuffer("idpedido"));
				debug("******FLFACTALMA****** >>>>>> almacenLinea_obtenerAlmacen lineasPEDIDOSprov buscada saímos con codAlmacen: " + codAlmacen);
				return codAlmacen;
			}
			case "lineasalbaranesprov": {
				codAlmacen = util.sqlSelect("albaranesprov", "codalmacen", "idalbaran = " + curLinea.valueBuffer("idalbaran"));
				debug("******FLFACTALMA****** >>>>>> almacenLinea_obtenerAlmacen lineasALBARANESprov buscada saímos con codAlmacen: " + codAlmacen);
				return codAlmacen;
			}
			case "lineasfacturasprov": {
				codAlmacen = util.sqlSelect("facturasprov", "codalmacen", "idfactura = " + curLinea.valueBuffer("idfactura"));
				debug("******FLFACTALMA****** >>>>>> almacenLinea_obtenerAlmacen lineasFACTURASprov buscada saímos con codAlmacen: " + codAlmacen);
				return codAlmacen;
			}
		}
	}
  
  
  
debug("******FLFACTALMA****** >>>>>> almacenLinea_obtenerAlmacen ALMACÉN POR LIÑA FINAL DE TODO SAIMOS con codAlmacen: " + codAlmacen);
	return codAlmacen;

}






//// ALMACEN_LINEA //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

