
/** @class_declaration generarAlbDireccion */
/////////////////////////////////////////////////////////////////
//// GENERAR ALBARAN DIRECCION //////////////////////////////////

class generarAlbDireccion extends ofertasProv /** %from: oficial */
{
  function generarAlbDireccion(context)
  {
    ofertasProv(context);
  }
  function datosDirAlbaran(curPedido, where, datosAgrupacion)
  {
    return this.ctx.generarAlbDireccion_datosDirAlbaran(curPedido, where, datosAgrupacion);
  }
 
}
//// GENERAR ALBARAN DIRECCION //////////////////////////////////
/////////////////////////////////////////////////////////////////



/** @class_definition generarAlbDireccion */
/////////////////////////////////////////////////////////////////
//// GENERAR ALBARAN DIRECCION //////////////////////////////////

// SIAGAL Substituimos a oficial para, se existe unha dirección no pedido, que colla esa e non a de envío
function generarAlbDireccion_datosDirAlbaran(curPedido, where, datosAgrupacion)
{
  
  debug(">>>>>>>SIAGAL  masterpedidoscli.qs  generarAlbDireccion_datosDirAlbaran!");
  var _i = this.iface;
  var util = new FLUtil;
  var codCliente = curPedido.valueBuffer("codcliente");
  var direccion = curPedido.valueBuffer("direccion");
  var codDir = util.sqlSelect("dirclientes", "id", "codcliente = '" + codCliente + "' AND domenvio");
  
  with(_i.curAlbaran) {
    if ((!direccion || direccion == "") && codDir) {
      setValueBuffer("coddir", codDir);
      setValueBuffer("direccion", util.sqlSelect("dirclientes", "direccion", "id = " + codDir));
      setValueBuffer("codpostal", util.sqlSelect("dirclientes", "codpostal", "id = " + codDir));
      setValueBuffer("ciudad", util.sqlSelect("dirclientes", "ciudad", "id = " + codDir));
      setValueBuffer("provincia", util.sqlSelect("dirclientes", "provincia", "id = " + codDir));
      setValueBuffer("apartado", util.sqlSelect("dirclientes", "apartado", "id = " + codDir));
      setValueBuffer("codpais", util.sqlSelect("dirclientes", "codpais", "id = " + codDir));
    } else {
      codDir = curPedido.valueBuffer("coddir")
      if (codDir == 0) {
        setNull("coddir");
      } else  {
        setValueBuffer("coddir", curPedido.valueBuffer("coddir"));
      }
      setValueBuffer("direccion", curPedido.valueBuffer("direccion"));
      setValueBuffer("codpostal", curPedido.valueBuffer("codpostal"));
      setValueBuffer("ciudad", curPedido.valueBuffer("ciudad"));
      setValueBuffer("provincia", curPedido.valueBuffer("provincia"));
      setValueBuffer("apartado", curPedido.valueBuffer("apartado"));
      setValueBuffer("codpais", curPedido.valueBuffer("codpais"));
    }
  }
  return true;
}

//// GENERAR ALBARAN DIRECCION //////////////////////////////////
/////////////////////////////////////////////////////////////////

