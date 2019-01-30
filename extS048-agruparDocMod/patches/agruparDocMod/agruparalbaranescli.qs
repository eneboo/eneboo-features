
/** @class_declaration agruparDocMod */
/////////////////////////////////////////////////////////////////
//// AGRUPAR DOC MOD ////////////////////////////////////////////
class agruparDocMod extends oficial
{
  function agruparDocMod(context)
  {
    oficial(context);
  }
  
  function init()
  {
    this.ctx.agruparDocMod_init();
  }
  
  function insertarLineaTabla(curAlbaranes: FLSqlCursor)
  {
    return this.ctx.agruparDocMod_insertarLineaTabla(curAlbaranes);
  }
  
}
//// AGRUPAR DOC MOD ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition agruparDocMod */
/////////////////////////////////////////////////////////////////
//// AGRUPAR DOC MOD ////////////////////////////////////////////

function agruparDocMod_init()
{
  this.iface.__init();
  
 
  this.child("fdbCodPago").setValue(""); 
  this.child("fdbDesCodPago").setValue("");  
  this.child("fdbCodAgente").setValue(""); 
  this.child("fLFieldDB17_3").setValue(""); 
  this.child("fLFieldDB8").setValue(""); 
  this.child("fLFieldDB9").setValue(""); 
  this.child("coddir").setValue(""); 

}

/** \D
* SUBSITUYE a la oficial para poder poner un NO por defecto
\end */
function agruparDocMod_insertarLineaTabla(curAlbaranes: FLSqlCursor)
{
  var util: FLUtil = new FLUtil;
  var numLinea: Number = this.iface.tblAlbaranes.numRows();
  this.iface.tblAlbaranes.insertRows(numLinea);
  this.iface.tblAlbaranes.setText(numLinea, this.iface.COL_INCLUIR, "No");
  this.iface.tblAlbaranes.setText(numLinea, this.iface.COL_CODIGO, curAlbaranes.valueBuffer("codigo"));
  this.iface.tblAlbaranes.setText(numLinea, this.iface.COL_FECHA, util.dateAMDtoDMA(curAlbaranes.valueBuffer("fecha")));
  this.iface.tblAlbaranes.setText(numLinea, this.iface.COL_TOTAL, util.roundFieldValue(curAlbaranes.valueBuffer("total"), "albaranescli", "total"));
  this.iface.tblAlbaranes.setText(numLinea, this.iface.COL_CLIENTE, curAlbaranes.valueBuffer("codcliente"));
  this.iface.tblAlbaranes.setText(numLinea, this.iface.COL_NOMBRE, curAlbaranes.valueBuffer("nombrecliente"));
  this.iface.tblAlbaranes.setText(numLinea, this.iface.COL_IDALBARAN, curAlbaranes.valueBuffer("idalbaran"));
}

//// AGRUPAR DOC MOD ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

