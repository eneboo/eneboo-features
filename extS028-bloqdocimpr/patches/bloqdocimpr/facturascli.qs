
/** @class_declaration bloqDocImpr */
/////////////////////////////////////////////////////////////////
//// BLOQUEO DOCUMENTOS IMPRESION ///////////////////////////////
class bloqDocImpr extends numerosLinea /** %from: oficial */
{
  function bloqDocImpr(context)
  {
    numerosLinea(context);
  }
  function init()
  {
    return this.ctx.bloqDocImpr_init();
  }

}
//// BLOQUEO DOCUMENTOS IMPRESION ///////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition bloqDocImpr */
/////////////////////////////////////////////////////////////////
//// BLOQUEO DOCUMENTOS IMPRESION ///////////////////////////////

function bloqDocImpr_init()
{
  this.iface.__init();
  var util:FLUtil = new FLUtil();
  var cursor: FLSqlCursor = this.cursor();

  if (cursor.modeAccess() == cursor.Edit) {
    if (cursor.valueBuffer("impreso") == true && util.sqlSelect("empresa", "bloqfaccliimp", " 1 = 1") == true ) {
     	  MessageBox.warning(util.translate("scripts", "Seg�n la configuraci�n actual no es posible\neditar una factura impresa.\n\nContacte con un administrador si es necesario."), MessageBox.Ok, MessageBox.NoButton);
	  this.child("formFacturasCli").setDisabled(true);
	  //this.form.close();		
    }
  }

}
//// BLOQUEO DOCUMENTOS IMPRESION ///////////////////////////////
/////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// N�MEROS DE L�NEA ///////////////////////////////////////////

