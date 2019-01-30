
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
  function commonCalculateField(fN: String, cursor: FLSqlCursor): String {
    return this.ctx.numerosLineaProv_commonCalculateField(fN, cursor);
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
      cursor.setValueBuffer("numlinea",this.iface.calculateField("numlinea"));
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
        case "lineaspedidosprov": {
          campoId = "idpedido";
          idTabla = cursor.valueBuffer("idpedido");
          break;
        }
        case "lineasalbaranesprov": {
          campoId = "idalbaran";
          idTabla = cursor.valueBuffer("idalbaran");
          break;
        }
        case "lineasfacturasprov": {
          campoId = "idfactura";
          idTabla = cursor.valueBuffer("idfactura");
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
