/***************************************************************************
                 lineaspresupuestosprov.qs  -  description
                             -------------------
    begin                : lun may 11 2009
    copyright            : (C) 2009 by InfoSiAL S.L.
    email                : mail@infosial.com
 ***************************************************************************/
/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

/** @file */

/** @class_declaration interna */
////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
class interna
{
  var ctx: Object;
  function interna(context)
  {
    this.ctx = context;
  }
  function init()
  {
    this.ctx.interna_init();
  }
  function validateForm(): Boolean 
  { 
    return this.ctx.interna_validateForm(); 
  }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna
{
  function oficial(context)
  {
    interna(context);
  }
  function bufferChanged(fN: String)
  {
    return this.ctx.oficial_bufferChanged(fN);
  }
  function commonBufferChanged(fN: String, miForm: Object)
  {
    return this.ctx.oficial_commonBufferChanged(fN, miForm);
  }
  function commonCalculateField(fN: String, cursor: FLSqlCursor): String {
    return this.ctx.oficial_commonCalculateField(fN, cursor);
  }
  function datosTablaPadre(cursor: FLSqlCursor): Array {
    return this.ctx.oficial_datosTablaPadre(cursor);
  }
  function totalStocks(referencia: String, barCode: String)
  {
    return this.ctx.oficial_totalStocks(referencia,barCode);
  }
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_declaration numerosLineaProv */
/////////////////////////////////////////////////////////////////
//// NUMEROS DE LÍNEA ///////////////////////////////////////////
class numerosLineaProv extends oficial /** %from: oficial */
{
  function numerosLineaProv(context)
  {
    oficial(context);
  }
  function init()
  {
    return this.ctx.numerosLineaProv_init();
  }
  function commonCalculateField(fN: String, cursor: FLSqlCursor): String {
    return this.ctx.numerosLineaProv_commonCalculateField(fN, cursor);
  }
}
//// NUMEROS DE LÍNEA ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////



/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends numerosLineaProv
{
  function head(context)
  {
    numerosLineaProv(context);
  }
  
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head
{
  function ifaceCtx(context)
  {
    head(context);
  }
}

const iface = new ifaceCtx(this);
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition interna */
////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
/** \C
Este formulario realiza la gestión de las líneas de solicitudes de ofertas de proveedores.
\end */
function interna_init()
{
  var util: FLUtil = new FLUtil();
  var cursor: FLSqlCursor = this.cursor();

  connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");

  this.iface.totalStocks(cursor.valueBuffer("referencia"), cursor.valueBuffer("barcode"));
  
  
  // Filtro para barcodes do artículo
  if (cursor.valueBuffer("referencia") == "" || cursor.isNull("referencia"))
    this.child("fdbBarCode").setFilter("");
  else
    this.child("fdbBarCode").setFilter("referencia = '" + cursor.valueBuffer("referencia") + "'");
  
  
  
  if (cursor.modeAccess() == cursor.Insert && cursor.cursorRelation()) {
    if (cursor.cursorRelation().table() == "presupuestosprov") {
      var codProveedor: String = cursor.cursorRelation().valueBuffer("codproveedor");
      if (codProveedor && codProveedor != "") {
        cursor.setValueBuffer("codproveedor", codProveedor);
        cursor.setValueBuffer("nombreproveedor", cursor.cursorRelation().valueBuffer("nombreproveedor"));
      }
    }
  }
  
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////


function oficial_bufferChanged(fN: String)
{
  this.iface.commonBufferChanged(fN, form);

}


function oficial_commonBufferChanged(fN: String, miForm: Object)
{
	
	debug(">>>> Siagal lineaspresupuestosprov.qs  commonbufferchanged fN" + fN);
	

  var util: FLUtil = new FLUtil();
  var cursor: FLSqlCursor = this.cursor();

  switch (fN) {
    case "referencia": {
      miForm.child("fdbPvpUnitario").setValue(this.iface.commonCalculateField("pvpunitario", miForm.cursor()));
      miForm.child("fdbDto").setValue(this.iface.commonCalculateField("dto", miForm.cursor()));
      if (cursor.valueBuffer("referencia") == "" || cursor.isNull("referencia")) {
        miForm.child("fdbBarCode").setFilter("");
        miForm.child("fdbDescripcion").setValue("");
        miForm.child("fdbBarCode").setValue("");
      } else {
        var referencia = cursor.valueBuffer("referencia");
        miForm.child("fdbBarCode").setFilter("referencia = '" + referencia + "'");
        if (!AQUtil.sqlSelect("atributosarticulos", "referencia", "barcode = '" + cursor.valueBuffer("barcode") + "' AND referencia = '" + referencia + "'")) {
          miForm.child("fdbBarCode").setValue("");
          
        }
      }
      
      this.iface.totalStocks(cursor.valueBuffer("referencia"), cursor.valueBuffer("barcode"));
      break;
    }
    case "barcode": {
      if (cursor.valueBuffer("barcode") == "" || cursor.isNull("barcode")) {
        miForm.child("fdbTalla").setValue("");
        miForm.child("fdbColor").setValue("");
      } else {
        var ref = this.iface.commonCalculateField("referencia", cursor)
        if (ref && ref != "") {
          miForm.child("fdbReferencia").setValue(ref);
          miForm.child("fdbPvpUnitario").setValue(this.iface.commonCalculateField("pvpunitario", miForm.cursor()));
          miForm.child("fdbDto").setValue(this.iface.commonCalculateField("dtopor", miForm.cursor()));
         }
      }
      this.iface.totalStocks(cursor.valueBuffer("referencia"), cursor.valueBuffer("barcode"));
      
      break;
    }
  }
}

function oficial_commonCalculateField(fN: String, cursor: FLSqlCursor): String {
  var util: FLUtil = new FLUtil();
  var valor: String;

  var datosTP: Array = this.iface.datosTablaPadre(cursor);
  if (!datosTP)
    return false;
  var wherePadre: String = datosTP.where;
  var tablaPadre: String = datosTP.tabla;

  switch (fN)
  {
    case "referencia": {
      valor = util.sqlSelect("atributosarticulos", "referencia", "barcode = '" + cursor.valueBuffer("barcode") + "'");
       debug(">>>>>>>>>>>>>>>>>>>>>< referencia:" +valor);
      if (!valor) {
        valor = "";
      }
      break;
    }
    case "pvpunitario": {
      var codProveedor: String = datosTP["codproveedor"];
      valor = util.sqlSelect("articulosprov", "coste", "referencia = '" + cursor.valueBuffer("referencia") + "' AND codproveedor = '" + codProveedor + "'");
      debug(">>>>>>>>>>>>>>>>>>>>>< pvpunitario:" +valor);
      break;
      
      //var codProveedor: String = datosTP["codproveedor"];
      //var codDivisa: String = datosTP["coddivisa"];
      
      
     /* 
      var qryBarcode: FLSqlQuery = new FLSqlQuery();
      with(qryBarcode) {
        setTablesList("barcodeprov");
        setSelect("coste");
        setFrom("barcodeprov");
        setWhere("barcode = '" + cursor.valueBuffer("barcode") + "' AND codproveedor = '" + codProveedor + "'");
        setForwardOnly(true);
      }
      if (!qryBarcode.exec()) {
        return false;
      }
      if (!qryBarcode.first()) {
        var codProveedor: String = datosTP["codproveedor"];
        //var codDivisa: String = datosTP["coddivisa"];
        valor = util.sqlSelect("articulosprov", "coste", "referencia = '" + cursor.valueBuffer("referencia") + "' AND codproveedor = '" + codProveedor + "'");
      } else {
        valor = qryBarcode.value("coste");
            // var tasaConv: Number = datosTP["tasaconv"];
            // valor = parseFloat(valor) / tasaConv;
      }
      break;*/
    }
    case "dto": {
      var codProveedor: String = datosTP["codproveedor"];
      valor = util.sqlSelect("articulosprov", "dto", "referencia = '" + cursor.valueBuffer("referencia") + "' AND codproveedor = '" + codProveedor + "'");
      debug(">>>>>>>>>>>>>>>>>>>>>< dto:" +valor);
      break;
    }  
    
    default: {
      valor = "";
    }

  }
  return valor;
}


function oficial_datosTablaPadre(cursor: FLSqlCursor): Array {
  var datos: Array;
  
  if (!cursor) 
    return;
  
  switch (cursor.table())
  {
    case "lineaspresupuestosprov": {
      datos.where = "idpresupuesto = " + cursor.valueBuffer("idpresupuesto");
      datos.tabla = "presupuestosprov";
      break;
    }
  }
  var curRel: FLSqlCursor = cursor.cursorRelation();
  if (curRel && curRel.table() == datos.tabla)
  {
    //datos["coddivisa"] = curRel.valueBuffer("coddivisa");
    datos["codproveedor"] = curRel.valueBuffer("codproveedor");
    datos["femision"] = curRel.valueBuffer("femision");
    datos["codserie"] = curRel.valueBuffer("codserie");
  } else {
    var qryDatos: FLSqlQuery = new FLSqlQuery;
    qryDatos.setTablesList(datos.tabla);
    qryDatos.setSelect("codproveedor, femision, codserie");
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
   // datos["coddivisa"] = qryDatos.value("coddivisa");
    datos["codproveedor"] = qryDatos.value("codproveedor");
    datos["fecha"] = qryDatos.value("fecha");
    datos["codserie"] = qryDatos.value("codserie");
  }
  return datos;
}



function oficial_totalStocks(referencia: String, barCode: String)
{
	
	debug(">>>> Siagal lineaspresupuestosprov.qs  oficial_totalStocks referencia: " + referencia + "  barcode: " + barCode);
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


function interna_validateForm(): Boolean {
  var cursor: FLSqlCursor = this.cursor();

  if (!flfacturac.iface.pub_validarLinea(cursor))
    return false;

  return true;

}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition numerosLineaProv */
/////////////////////////////////////////////////////////////////
//// NÚMEROS DE LÍNEA ///////////////////////////////////////////
function numerosLineaProv_init()
{
  this.iface.__init();

  var cursor: FLSqlCursor = this.cursor();
  switch (cursor.modeAccess()) {
    case cursor.Insert: {
      cursor.setValueBuffer("numlinea",this.iface.commonCalculateField("numlinea", cursor));
      break;
    }
  }
}

function numerosLineaProv_commonCalculateField(fN: String, cursor: FLSqlCursor): String {
  var util: FLUtil = new FLUtil();
  var valor: String;

  switch (fN)
  {
    case "numlinea": {
      var tabla: String = cursor.table();
      var idTabla: String;
      var campoId: String;
      switch (tabla) {
        case "lineaspresupuestosprov": {
          campoId = "idpresupuesto";
          idTabla = cursor.valueBuffer("idpresupuesto");
          break;
        }
      }
      valor = parseInt(util.sqlSelect(tabla, "numlinea", campoId + " = " + idTabla + " ORDER BY numlinea DESC"));
      if (isNaN(valor)) {
        valor = 0;
      }
      valor++;
      break;
    }
    default: {
      valor = this.iface.__commonCalculateField(fN, cursor);
    }
  }
  return valor;
}

//// NÚMEROS DE LÍNEA ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
