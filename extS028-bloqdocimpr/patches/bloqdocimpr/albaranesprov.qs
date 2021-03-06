
/** @class_declaration bloqDocImpr */
/////////////////////////////////////////////////////////////////
//// BLOQUEO DOCUMENTOS IMPRESION ///////////////////////////////
class bloqDocImpr extends cambioIva /** %from: oficial */
{
  function bloqDocImpr(context)
  {
    cambioIva(context);
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
    if (cursor.valueBuffer("impreso") == true && util.sqlSelect("empresa", "bloqalbproimp", " 1 = 1") == true ) {
      if (util.sqlSelect("usuariosedicionimpresos", "iduser", " iduser = '" + sys.nameUser() + "'") == sys.nameUser()) {
       // MessageBox.warning(util.translate("scripts", "Este documento ya fue impreso pero\nel usuario " + sys.nameUser() + " puede editarlo igualmente.\n\nProcede con precauci�n."), MessageBox.Ok, MessageBox.NoButton);
      } else {
	MessageBox.warning(util.translate("scripts", "Seg�n la configuraci�n actual no es posible\neditar un albar�n de proveedor impreso.\n\nContacte con un administrador si es necesario."), MessageBox.Ok, MessageBox.NoButton);
	this.child("formalbaranesprov").setDisabled(true);
	//this.form.close();		
      }
    }
  }
    
}
//// BLOQUEO DOCUMENTOS IMPRESION ///////////////////////////////
/////////////////////////////////////////////////////////////////

