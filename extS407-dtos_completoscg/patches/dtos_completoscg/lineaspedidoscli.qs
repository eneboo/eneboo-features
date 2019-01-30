
/** @class_declaration dtosCompletosCli */
/////////////////////////////////////////////////////////////////
//// DESCUENTOS COMPLETOS A CLIENTES ////////////////////////////
class dtosCompletosCli extends numLinea /** %from: oficial */
{
  function dtosCompletosCli(context)
  {
    numLinea(context);
  }
  function init()
  {
    return this.ctx.dtosCompletosCli_init();
  }
  function commonBufferChanged(fN: String, miForm: Object)
  {
    return this.ctx.dtosCompletosCli_commonBufferChanged(fN, miForm);
  }
  function dameValorDescuento(fN: String, cursor: FLSqlCursor, datosTP: Array): Number {
    return this.ctx.dtosCompletosCli_dameValorDescuento(fN, cursor, datosTP);
  }
  function commonCalculateField(fN: String, cursor: FLSqlCursor): String {
    return this.ctx.dtosCompletosCli_commonCalculateField(fN, cursor);
  }
}
//// DESCUENTOS COMPLETOS A CLIENTES ////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition dtosCompletosCli */
/////////////////////////////////////////////////////////////////
//// DESCUENTOS COMPLETOS A CLIENTES ////////////////////////////
function dtosCompletosCli_init()
{
  this.iface.__init();

  var util: FLUtil = new FLUtil();
  var cursor: FLSqlCursor = this.cursor();
  switch (cursor.modeAccess()) {
    case cursor.Insert: {
      this.child("fdbDtoPor").setValue(this.iface.calculateField("dtopor"));
      this.child("fdbDtoLineal").setValue(this.iface.calculateField("dtolineal"));
      break;
    }
  }
}

function dtosCompletosCli_commonCalculateField(fN: String, cursor: FLSqlCursor): String {
 var util: FLUtil = new FLUtil();
	debug("SIAGAL >>>>>>>>>>> lineaspedidoscli.qs <<<>>>  dtosCompletosCli_commonCalculateField + fn: " + fN + "   cursor" + cursor );
  var datosTP: Array = this.iface.datosTablaPadre(cursor);
  debug("SIAGAL >>>>>>>>>>> lineaspedidoscli.qs <<<>>>  dtosCompletosCli_commonCalculateField DESPOIS DE datosTP" );
  if (!datosTP)
  {
	  debug("SIAGAL >>>>>>>>>>> lineaspedidoscli.qs <<<>>>  dtosCompletosCli_commonCalculateField datosTP no existe" );
	return false;
  }
  var wherePadre: String = datosTP.where;
  var tablaPadre: String = datosTP.tabla;

debug("SIAGAL >>>>>>>>>>> lineaspedidoscli.qs <<<>>>  dtosCompletosCli_commonCalculateField wherePadre: " + wherePadre );
debug("SIAGAL >>>>>>>>>>> lineaspedidoscli.qs <<<>>>  dtosCompletosCli_commonCalculateField tablaPadre:" + tablaPadre);
	
	
	//SIAGAL Se hai prezo especial por artículo saltamos o desconto para que aplique o prezo especial
	//Non vamos ao cursorRelation porque ás veces non o ten, por exemplo ao pasar un albarán a factura
	var valorString = String;
	    if (wherePadre && wherePadre != "") {
			var codCliente:String = util.sqlSelect(tablaPadre, "codcliente", wherePadre);
			debug("SIAGAL >>>>>>>>>>> lineaspedidoscli.qs <<<>>>  dtosCompletosCli_commonCalculateField codCliente:" + codCliente);
		if (codCliente && codCliente != "") {
			valorString = util.sqlSelect("articulosclientes", "pvp", "referencia = '" + cursor.valueBuffer("referencia") + "' AND codcliente = '" + codCliente + "'");
		}
	} 
	 

	debug("SIAGAL >>>>>>>>>>> lineaspedidoscli.qs <<<>>>  dtosCompletosCli_commonCalculateField valor:" + valorString);
	if (!valorString || valorString == "") {
	  debug("SIAGAL >>>>>>>>>>> lineaspedidoscli.qs  <<<>>> dtosCompletosCli_commonCalculateField NON HAI PREZO ESPECIAL");
	  var valor: String;
	  switch (fN)
	  {
		case "dtopor": {
		  valor = this.iface.dameValorDescuento(fN, cursor, datosTP);
		  break;
		}
		case "dtolineal": {
		  valor = this.iface.dameValorDescuento(fN, cursor, datosTP);
		  break;
		}
		default: {
		  valor = this.iface.__commonCalculateField(fN, cursor);
		}
	  }
	  return valor;
    } else {
		debug("SIAGAL >>>>>>>>>>> lineaspedidoscli.qs <<<>>>  dtosCompletosCli_commonCalculateField no retorna VALOR");
		return this.iface.__commonCalculateField(fN, cursor);
	}
}



function dtosCompletosCli_commonBufferChanged(fN: String, miForm: Object)
{
  var cursor: FLSqlCursor = miForm.cursor();
  switch (fN) {
    case "referencia": {
      this.iface.__commonBufferChanged(fN, miForm);
      miForm.child("fdbDtoPor").setValue(this.iface.commonCalculateField("dtopor", cursor));
      miForm.child("fdbDtoLineal").setValue(this.iface.commonCalculateField("dtolineal", cursor));
      break;
    }
    default: {
      this.iface.__commonBufferChanged(fN, miForm);
    }
  }
  return true;
}


/// Propuesto por José Antonio
function dtosCompletosCli_dameValorDescuento(fN: String, cursor: FLSqlCursor, datosTP: Array): Number {
debug("SIAGAL >>>>>><<<<<<<<<< lineaspedidoscli.qs dtosCompletosCli_dameValorDescuento");	
  var util: FLUtil = new FLUtil();
  var valor: Number = 0;

  var referencia: String = cursor.valueBuffer("referencia");
  var codCliente: String;
  var hayCursorRelation: Boolean = false;

   if (cursor.cursorRelation() && cursor.cursorRelation().table() == datosTP.tabla)
  {
    codCliente = cursor.cursorRelation().valueBuffer("codcliente");
    hayCursorRelation = true;
  } else {
    hayCursorRelation = false;
    codCliente = util.sqlSelect(datosTP.tabla, "codcliente", datosTP.where);
  }
  debug("codCliente " + codCliente);

  var codFamilia: String = "";
  var codSubfamilia: String = "";
  if (referencia && referencia != "")
  {
    var datosArticulo: Array;
    datosArticulo = flfactppal.iface.pub_ejecutarQry("articulos", "codfamilia,codsubfamilia", "referencia = '" + referencia + "'");
    if (datosArticulo["result"] != 1) {
      return 0;
    }
    codFamilia = datosArticulo["codfamilia"];
    codSubfamilia = datosArticulo["codsubfamilia"];
  }
  var fecha: String;
  if (hayCursorRelation)
  {
    fecha = cursor.cursorRelation().valueBuffer("fecha");
  } else {
    fecha = util.sqlSelect(datosTP.tabla, "fecha", datosTP.where);
  }

  var codGrupo: String = "";

  codGrupo = util.sqlSelect("clientes", "codgrupo", "codcliente = '" + codCliente + "'" );

  if (!codGrupo)
  {
	  codGrupo = "" ;
  }


 //S//debug(">>>>>>>>>> dtosCompletosCli_dameValorDescuento codgrupo = " + codGrupo + " <<<<<<<<<<<<<<<< >>>> codCliente: " + codCliente);



  var criterios: Array;
  var datosIntervalo: Array;


  criterios["codcliente"] = codCliente;
  criterios["codgrupo"] = codGrupo;
  criterios["codfamilia"] = codFamilia;
  criterios["codsubfamilia"] = codSubfamilia;
  criterios["referencia"] = referencia;
  datosIntervalo = formRecorddtoscompletoscli.iface.pub_dameIntervaloDto(criterios, fecha);

  if (datosIntervalo)
  {
    valor = datosIntervalo[fN];
    if (datosIntervalo["sumar"]) {
      var otroDto: Number = this.iface.__commonCalculateField(fN, cursor);
      if (otroDto && !isNaN(otroDto)) {
        valor += parseFloat(otroDto);
      }
    }
  } else {
    var otroDto: Number = this.iface.__commonCalculateField(fN, cursor);
    if (!isNaN(otroDto))
    {
      valor += parseFloat(otroDto);
    }
  }

  if (!valor)
    valor = 0;

  return valor;
}

//// DESCUENTOS COMPLETOS A CLIENTES ////////////////////////////
/////////////////////////////////////////////////////////////////

