
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
  
  function actualizar()
  {
    return this.ctx.agruparDocMod_actualizar();
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
  this.child("fdbCodAgente").setValue(""); 
  this.child("fLFieldDB17_3").setValue(""); 
  this.child("fLFieldDB8").setValue(""); 
  this.child("fLFieldDB9").setValue(""); 
  this.child("coddir").setValue(""); 
  this.child("fdbDesCodPago").setValue(""); 
 
}




/** \D
Actualiza la lista de albaranes en función de los criterios de búsqueda especificados
* SUBSITUYE a la oficial para poder poner un NO por defecto
\end */
function agruparDocMod_actualizar()
{
  var curPedidos: FLSqlCursor = new FLSqlCursor("pedidoscli");

  var tblPedidos: QTable = this.child("tblPedidos");
  var util: QTable = new FLUtil;
  var fila: Number;
  var numFilas: Number = tblPedidos.numRows();

  for (fila = 0; fila < numFilas; fila++)
    tblPedidos.removeRow(0);

  var where: String = formalbaranescli.iface.pub_whereAgrupacion(this.cursor());
  where += " ORDER BY codcliente,codalmacen DESC";
  if (!curPedidos.select(where))
    return;

  while (curPedidos.next()) {
    curPedidos.setModeAccess(curPedidos.Browse);
    curPedidos.refreshBuffer();
    with(tblPedidos) {
      insertRows(0);
      setText(0, 0, "No");
      setText(0, 1, curPedidos.valueBuffer("codigo"));
      setText(0, 2, util.dateAMDtoDMA(curPedidos.valueBuffer("fecha")));
      setText(0, 3, curPedidos.valueBuffer("total"));
      setText(0, 4, curPedidos.valueBuffer("codcliente"));
      setText(0, 5, curPedidos.valueBuffer("nombrecliente"));
      setText(0, 6, curPedidos.valueBuffer("idpedido"));
    }
  }
  this.iface.estado = "Seleccionando";
  this.iface.gestionEstado();

  if (tblPedidos.numRows() == 0)
    this.child("pushButtonAccept").enabled = false;
}

//// AGRUPAR DOC MOD ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

