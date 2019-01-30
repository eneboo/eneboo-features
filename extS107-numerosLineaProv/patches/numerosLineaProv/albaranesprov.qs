
/** @class_declaration numerosLineaProv */
/////////////////////////////////////////////////////////////////
//// NUMEROS LINEA /////////////////////////////////////////////
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
  function tbnSubir()
  {
    return this.ctx.numerosLineaProv_tbnSubir();
  }
  function tbnBajar()
  {
    return this.ctx.numerosLineaProv_tbnBajar();
  }
}
//// NUMEROS LINEA /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition numerosLineaProv */
/////////////////////////////////////////////////////////////////
//// NUMEROS LINEA /////////////////////////////////////////////
function numerosLineaProv_init()
{
  debug("Init");
  connect(this.child("tbnSubir"), "clicked()", this, "iface.tbnSubir");
  connect(this.child("tbnBajar"), "clicked()", this, "iface.tbnBajar");

  this.child("tdbLineasAlbaranesProv").putFirstCol("numlinea");

  this.iface.__init();
}

/** \D Mueve la línea seleccionada hacia arriba (antes) en el orden
\end */
function numerosLineaProv_tbnSubir()
{
  var cursor = this.child("tdbLineasAlbaranesProv").cursor();
  var row = this.child("tdbLineasAlbaranesProv").currentRow();

  if (!flfacturac.iface.intercambiarOrden(cursor, -1, "idalbaran")) {
    return false;
  }
  this.child("tdbLineasAlbaranesProv").refresh();
  row += -1;
  this.child("tdbLineasAlbaranesProv").setCurrentRow(row);
}

/** \D Mueve la línea seleccionada hacia abajo (después) en el orden
\end */
function numerosLineaProv_tbnBajar()
{
  var cursor = this.child("tdbLineasAlbaranesProv").cursor();
  var row = this.child("tdbLineasAlbaranesProv").currentRow();

  if (!flfacturac.iface.intercambiarOrden(cursor, 1, "idalbaran")) {
    return false;
  }
  this.child("tdbLineasAlbaranesProv").refresh();
  row += 1;
  this.child("tdbLineasAlbaranesProv").setCurrentRow(row);
}
//// NUMEROS LINEA /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

