
/** @class_declaration gdArticulos */
/////////////////////////////////////////////////////////////////
/// GD ARTICULOS  ////////////////////////////////////////////////
class gdArticulos extends etiBarcode /** %from: oficial */
{
  function gdArticulos(context)
  {
    etiBarcode(context);
  }
 function init()
  {
    return this.ctx.gdArticulos_init();
  }
}
/// GD ARTICULOS  ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition gdArticulos */
//////////////////////////////////////////////////////////////////
/// GD ARTICULOS  ////////////////////////////////////////////////

function gdArticulos_init()
{


  var util = new FLUtil();
  var cursor = this.cursor();


  this.iface.__init();


 /// Gestión documental
  if (sys.isLoadedModule("flcolagedo")) {
    var datosGD: Array;
    datosGD["txtRaiz"] = cursor.valueBuffer("referencia") + ": " + cursor.valueBuffer("descripcion");
    datosGD["tipoRaiz"] = "articulos";
    datosGD["idRaiz"] = cursor.valueBuffer("referencia");
    flcolagedo.iface.pub_gestionDocumentalOn(this, datosGD);
  } else {
    this.child("tbwDocumentos").setTabEnabled("gesdocu", false);
  }

}
/// GD ARTICULOS  ////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

