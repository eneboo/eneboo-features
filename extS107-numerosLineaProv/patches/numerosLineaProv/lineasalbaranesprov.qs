
/** @class_declaration numerosLineaProv */
/////////////////////////////////////////////////////////////////
//// NUMEROS DE LÍNEA ///////////////////////////////////////////
class numerosLineaProv extends barCode /** %from: oficial */
{
  function numerosLineaProv(context)
  {
    barCode(context);
  }
  function init()
  {
    return this.ctx.numerosLineaProv_init();
  }
}
//// NUMEROS DE LÍNEA ///////////////////////////////////////////
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
      debug("SIAGAL >>>>>>> lineasalbaranesprov.qs >>>>>>>>>>>>> numerosLineaProv_init   CURSOR INSERT");
      cursor.setValueBuffer("numlinea",this.iface.calculateField("numlinea"));
      break;
    }
  }
}
//// NÚMEROS DE LÍNEA ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////

