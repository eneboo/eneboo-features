
/** @class_declaration ofertasProv */
/////////////////////////////////////////////////////////////////
//// OFERTAS_PROV //////////////////////////////////////////////
class ofertasProv extends bloqDocImpr /** %from: oficial */
{
  function ofertasProv(context)
  {
    bloqDocImpr(context);
  }
  function aceptarOferta(curLineaOferta: FLSqlCursor): Boolean {
    return this.ctx.ofertasProv_aceptarOferta(curLineaOferta);
  }
  function cargarDatosSolOferta(curSolOferta: FLSqlCursor): Boolean {
    return this.ctx.ofertasProv_cargarDatosSolOferta(curSolOferta);
  }
  function beforeCommit_presupuestosprov(curPresupuesto: FLSqlCursor): Boolean {
    return this.ctx.ofertasProv_beforeCommit_presupuestosprov(curPresupuesto);
  }
  function beforeCommit_pedidosprov(curPedido: FLSqlCursor): Boolean {
    return this.ctx.ofertasProv_beforeCommit_pedidosprov(curPedido);
  }

}
//// OFERTAS_PROV //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pub_ofertas_prov */
/////////////////////////////////////////////////////////////////
//// PUB_OFERTAS_PROV //////////////////////////////////////////
class pub_ofertas_prov extends head /** %from: head */
{
  function pub_ofertas_prov(context)
  {
    head(context);
  }
  function pub_aceptarOferta(curLineaOferta: FLSqlCursor): Boolean {
    return this.aceptarOferta(curLineaOferta);
  }
  function pub_cargarDatosSolOferta(curSolOferta: FLSqlCursor): Boolean {
    return this.cargarDatosSolOferta(curSolOferta);
  }
}

//// PUB_OFERTAS_PROV //////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition ofertasProv */
/////////////////////////////////////////////////////////////////
//// OFERTAS_PROV ///////////////////////////////////////////////
function ofertasProv_aceptarOferta(curLineaOferta: FLSqlCursor): Boolean {
  var util: FLUtil = new FLUtil();
  var referencia: String = curLineaOferta.valueBuffer("referencia");
  var descripcion: String = curLineaOferta.valueBuffer("descripcion");

debug (">>>SIAGAL >>> flfacturac.qs >>>>>>>>>> ofertasProv_aceptarOferta   referencia: " + referencia);
debug (">>>SIAGAL >>> flfacturac.qs >>>>>>>>>> ofertasProv_aceptarOferta   descripcion: " + descripcion);
  //SIAGAL se non hai barcode pasamos de filtrar por el
  var andBarcode: String = "";
  var barcode: String = curLineaOferta.valueBuffer("barcode");
  if (barcode)
	andBarcode = " AND barcode = '" + barcode + "'";


  if (!referencia || referencia == "")
  {
    MessageBox.information(util.translate("scripts", "No está informada la referencia del artículo"), MessageBox.Ok, MessageBox.NoButton);
    return false;
  }

  var codProveedor: String = curLineaOferta.valueBuffer("codproveedor");


  if (!codProveedor || codProveedor == "")
  {
    MessageBox.information(util.translate("scripts", "No está informado el código del proveedor"), MessageBox.Ok, MessageBox.NoButton);
    return false;
  }

  var precio: Number = curLineaOferta.valueBuffer("pvpunitario");
  if (!precio || precio == "")
  {
    MessageBox.information(util.translate("scripts", "No está informado el precio del artículo"), MessageBox.Ok, MessageBox.NoButton);
    return false;
  }
  var dto: Number = curLineaOferta.valueBuffer("dto");


  if (!util.sqlUpdate("lineaspresupuestosprov", "aprobado", false, "codsolicitud = '" +  curLineaOferta.valueBuffer("codsolicitud") + "' AND referencia = '" + referencia + "' AND descripcion = '" + descripcion + "'" + andBarcode))
    return false;

  if (!util.sqlUpdate("lineaspresupuestosprov", "aprobado", true, "codsolicitud = '" +  curLineaOferta.valueBuffer("codsolicitud") + "' AND referencia = '" + referencia + "' AND codproveedor = '" + codProveedor + "' AND descripcion = '" + descripcion + "'" + andBarcode))
    return false;

  var curLineaSolic: FLSqlCursor = new FLSqlCursor("lineassolpresupuestosprov");
  curLineaSolic.select("referencia = '" + referencia + "' AND codsolicitud = '" + curLineaOferta.valueBuffer("codsolicitud") + "' AND descripcion = '" + descripcion + "'" + andBarcode);
  if (!curLineaSolic.first())
    return false;

  curLineaSolic.setModeAccess(curLineaSolic.Edit);
  curLineaSolic.refreshBuffer();

  curLineaSolic.setValueBuffer("codproveedor", codProveedor);
  curLineaSolic.setValueBuffer("nombre", util.sqlSelect("proveedores", "nombre", "codproveedor = '" + codProveedor + "'"));
  curLineaSolic.setValueBuffer("coste", precio);
  curLineaSolic.setValueBuffer("pordtocoste", dto);
  curLineaSolic.setValueBuffer("margen", formRecordlineassolpresupuestosprov.iface.pub_commonCalculateField("margen", curLineaSolic));
  curLineaSolic.setValueBuffer("beneficio", formRecordlineassolpresupuestosprov.iface.pub_commonCalculateField("beneficio", curLineaSolic));
  curLineaSolic.setValueBuffer("confirmado", true);

  if (!curLineaSolic.commitBuffer())
    return false;

  return true;
}

function ofertasProv_cargarDatosSolOferta(curSolOferta: FLSqlCursor): Boolean {
  var util: FLUtil = new FLUtil();

  var idPedido: String = curSolOferta.valueBuffer("idpedidocli");
  if (!idPedido)
  {
    return false;
  }
  debug(">>> SIAGAL >>>>>>>>>>>>> flfactuac.qs >>> ofertasProv_cargarDatosSolOferta >> Tenemos pedido: " + idPedido);


  //Mellor o cargamos no porpio do formulario para evitar problemas co commit e rollback
  //SIAGAL arrastramos o código do cliente e o seu nome
  //var codCliente: String = util.sqlSelect("pedidoscli", "codcliente", "idpedido = " + idPedido);
  //var nombreCliente: String = util.sqlSelect("pedidoscli", "nombrecliente", "idpedido = " + idPedido);
  //debug(">>> SIAGAL >>>>>>>>>>>>> flfactuac.qs >>> ofertasProv_cargarDatosSolOferta >> codCliente: " + codCliente);
  //debug(">>> SIAGAL >>>>>>>>>>>>> flfactuac.qs >>> ofertasProv_cargarDatosSolOferta >> nombreCliente: " + nombreCliente);
  //curSolOferta.setValueBuffer("codcliente", codCliente);
  //curSolOferta.setValueBuffer("nombrecliente", nombreCliente);






  var qryLinea: FLSqlQuery = new FLSqlQuery();
  qryLinea.setTablesList("lineassolpresupuestosprov");
  qryLinea.setSelect("idlinea");
  qryLinea.setFrom("lineassolpresupuestosprov");
  qryLinea.setWhere("codsolicitud = '" + curSolOferta.valueBuffer("codsolicitud") + "'");
  if (!qryLinea.exec())
    return false;
  if (qryLinea.first())
  {
    var res: Number = MessageBox.warning(util.translate("scripts", "Se borraran los datos existentes antes de cargar los nuevos.\n¿Desea continuar?"), MessageBox.Yes, MessageBox.No);
    if (res == MessageBox.Yes) {
      util.sqlDelete("lineassolpresupuestosprov", "codsolicitud = '" + curSolOferta.valueBuffer("codsolicitud") + "'");
    } else {
      return;
    }
  }

  var qry: FLSqlQuery = new FLSqlQuery();
  qry.setTablesList("lineaspedidoscli");

  /* SIAGAL Cambiar por esto para agrupar por referencia
  qry.setSelect("referencia, SUM(cantidad)");
  qry.setFrom("lineaspedidoscli");
  qry.setWhere("idpedido = " + idPedido + " GROUP BY referencia");
  */

  qry.setSelect("referencia, SUM(cantidad), descripcion, talla, color, barcode");
  qry.setFrom("lineaspedidoscli");
  qry.setWhere("idpedido = " + idPedido + " GROUP BY referencia, descripcion, talla, color, barcode" );


  debug("Buscamos nas liñas do pedido: " + idPedido);
  if (!qry.exec()) {
    debug("A Query saiu mal!!!");
    return false;
	}
  var curLineasSolPresupuestosProv: FLSqlCursor = new FLSqlCursor("lineassolpresupuestosprov");

  var datosArticulo: Array;
  var descripcion: String;
  var precioVta: Number;
  var coste: Number;
  var dto: Number;
  var margen: Number;
  var beneficio: Number;
  var fecha: String;
  var oferta: String;
  var proveedores: Number;


  while (qry.next())
  {


    var referencia = qry.value("referencia");


    datosArticulo = flfactppal.iface.ejecutarQry("articulos a INNER JOIN articulosprov ap ON a.referencia = ap.referencia", "a.descripcion,ap.coste,ap.codproveedor,ap.dto,ap.nombre", "a.referencia = '" + referencia + "' AND ap.pordefecto = true", "articulos,articulosprov");

    //debug("Result = " + datosArticulo.result);

    if (datosArticulo.result != 1) {
      MessageBox.warning(util.translate("scripts", "Error al obtener los datos del artículo %1\nDebe existir al menos un proveedor para el artículo.").arg(referencia), MessageBox.Ok, MessageBox.NoButton);
    //      debug("Erros no artigo!!! saiu mal!!!");
      return false;
    }

    curLineasSolPresupuestosProv.setModeAccess(curLineasSolPresupuestosProv.Insert);
    curLineasSolPresupuestosProv.refreshBuffer();
    curLineasSolPresupuestosProv.setValueBuffer("codsolicitud", curSolOferta.valueBuffer("codsolicitud"));
    curLineasSolPresupuestosProv.setValueBuffer("referencia", qry.value("referencia"));

    //SIAGAL descripcion = datosArticulo["a.descripcion"];
    // Asi lo cogemos del pedido
    descripcion = qry.value("descripcion");





  //SIAGAL se non hai barcode pasamos de filtrar por el
  var talla: String = "";
  var color: String = "";
  var barcode: String = qry.value("barcode");
  if (barcode) {
	talla = qry.value("talla");
    color = qry.value("color");
  }

    curLineasSolPresupuestosProv.setValueBuffer("descripcion", descripcion);

    curLineasSolPresupuestosProv.setValueBuffer("talla", talla);
    curLineasSolPresupuestosProv.setValueBuffer("color", color);
    curLineasSolPresupuestosProv.setValueBuffer("barcode", barcode);

    //SIAGAL Así estaba antes cuando agrupaba por líneas
    //curLineasSolPresupuestosProv.setValueBuffer("canpresupuesto", qry.value("SUM(cantidad)"));
    //curLineasSolPresupuestosProv.setValueBuffer("cansolicitada", qry.value("SUM(cantidad)"));

    //Sin agrupar por líneas
    curLineasSolPresupuestosProv.setValueBuffer("canpresupuesto", qry.value("SUM(cantidad)"));
    curLineasSolPresupuestosProv.setValueBuffer("cansolicitada", qry.value("SUM(cantidad)"));

    //debug("CANTIDAD: " + qry.value("cantidad"));

    precioVta = util.sqlSelect("lineaspedidoscli", "pvpunitario", "referencia = '" + qry.value("referencia") + "' AND idpedido = " + idPedido);
    if (precioVta)
      curLineasSolPresupuestosProv.setValueBuffer("pvpunitario", precioVta);
    else
      curLineasSolPresupuestosProv.setValueBuffer("pvpunitario", 0);

    coste = datosArticulo["ap.coste"];
    if (coste)
      curLineasSolPresupuestosProv.setValueBuffer("coste", coste);
    else
      curLineasSolPresupuestosProv.setValueBuffer("coste", 0);

    dto = datosArticulo["ap.dto"];
    var dtoTotal: Number;
    if (dto) {
      curLineasSolPresupuestosProv.setValueBuffer("pordtocoste", dto);
      dtoTotal = (coste * dto) / 100;
    } else {
      curLineasSolPresupuestosProv.setValueBuffer("pordtocoste", 0);
      dtoTotal = 0;
    }

    if (precioVta != 0) {
      margen = (precioVta - (coste - dtoTotal)) * 100 / precioVta;
    } else {
      margen = 0;
    }
    curLineasSolPresupuestosProv.setValueBuffer("margen", margen);

    beneficio = precioVta - coste * (100 - dto) / 100;
    curLineasSolPresupuestosProv.setValueBuffer("beneficio", beneficio);

    curLineasSolPresupuestosProv.setValueBuffer("codproveedorant", datosArticulo["ap.codproveedor"]);
    curLineasSolPresupuestosProv.setValueBuffer("nombreant", datosArticulo["ap.nombre"]);

    var hoy: Date = new Date();
    var q: FLSqlQuery = new FLSqlQuery();
    q.setTablesList("presupuestosprov,lineaspresupuestosprov");
    q.setSelect("p.femision, p.idpresupuesto");
    q.setFrom("presupuestosprov p INNER JOIN lineaspresupuestosprov l ON p.idpresupuesto = l.idpresupuesto");
    q.setWhere("l.referencia = '" + qry.value("referencia") + "' ORDER BY p.femision DESC");
    if (!q.exec()) {

		return false;
		}
    if (q.first()) {
      fecha = q.value("p.femision");
      oferta = q.value("p.idpresupuesto");
    } else {
      fecha = hoy;
      oferta = "";
    }
    curLineasSolPresupuestosProv.setValueBuffer("fecha", fecha);
    curLineasSolPresupuestosProv.setValueBuffer("codoferta", oferta);

    proveedores = util.sqlSelect("articulosprov", "COUNT(codproveedor)", "referencia = '" + qry.value("referencia") + "'");
    curLineasSolPresupuestosProv.setValueBuffer("proveedores", proveedores);
    curLineasSolPresupuestosProv.setValueBuffer("confirmado", false);


    if (!curLineasSolPresupuestosProv.commitBuffer()) {
		//debug("Saimos por false!!!");
		return false;
		}
  }

	//debug("Saimos por True!!!");
  return true;
}

/* \C Se calcula el número del presupuesto como el siguiente de la secuencia asociada a su ejercicio y serie.
\end */
function ofertasProv_beforeCommit_presupuestosprov(curPresupuesto: FLSqlCursor): Boolean {
  var util: FLUtil = new FLUtil();
  var numero: String;

  switch (curPresupuesto.modeAccess())
  {
    case curPresupuesto.Insert: {
      if (curPresupuesto.valueBuffer("numero") == 0) {
        numero = this.iface.siguienteNumero(curPresupuesto.valueBuffer("codserie"), curPresupuesto.valueBuffer("codejercicio"), "npresupuestoprov");
        if (!numero)
          return false;
        curPresupuesto.setValueBuffer("numero", numero);
        curPresupuesto.setValueBuffer("codigo", formpresupuestosprov.iface.pub_commonCalculateField("codigo", curPresupuesto));
      }
      break;
    }

    case curPresupuesto.Del: {
     
      codigoPedido:String;
      codigoPedido = curPresupuesto.valueBuffer("codigopedidoprov");
      debug(">>>>>>>> Borrando una oferta con pedido:" + codigoPedido);
      
     	if (codigoPedido || util.sqlSelect("pedidoprov", "codigo", " codigo = '" + codigoPedido + "'")) {
          MessageBox.warning(util.translate("scripts", "Esta oferta no puede ser eliminada por esta actualmente\nasociada al pedido de proveedor "+ curPresupuesto.valueBuffer("codigopedidoprov")+ "\nElimina el pedido antes de eliminar esta oferta."), MessageBox.Ok, MessageBox.NoButton);
          return false;
      }   
      
      
      var codSolicitud: String = util.sqlSelect("solpresupuestosprov", "codsolicitud", "codsolicitud = '" + curPresupuesto.valueBuffer("codsolicitud") + "'");
      if (!codSolicitud)
        break;

      res = MessageBox.information(util.translate("scripts", "Va a eliminar una gestión de compra asociada a la solicitud ") + codSolicitud + util.translate("scripts", "\n¿Desea continuar?"), MessageBox.Yes, MessageBox.No);
      if (res != MessageBox.Yes)
        return false;

      //Ponemos la solicitud como no gestionada
      util.sqlUpdate("solpresupuestosprov", "gestionada", false, "codsolicitud = '" + curPresupuesto.valueBuffer("codsolicitud") + "'")


      break;

    }
  }

  return true;
}


function ofertasProv_beforeCommit_pedidosprov(curPedido: FLSqlCursor): Boolean {
  var util: FLUtil = new FLUtil;
  var idPedido: String;
  var res: Number;
  

  switch (curPedido.modeAccess())
  {
      /** \C Avisa al usuario de que intenta borrar un pedido asociado a una oferta. Si el usuario decide borrarlo igual debemos reestablecer la oferta
      \end */
    case curPedido.Del: {
     
      codPedidoProv = util.sqlSelect("presupuestosprov", "codigopedidoprov", "codigopedidoprov = '" + curPedido.valueBuffer("codigo") + "'");
      debug("ELIMINANDO OFERTAS DEL PEDIDO: " + codPedidoProv);
         
      if (!codPedidoProv)
        break;

      res = MessageBox.information(util.translate("scripts", "Va a eliminar un pedido asociado a una o varias ofertas.\nSi continua establecerá la(s) oferta(s) en estado Pendiente.\n¿Desea continuar?"), MessageBox.Yes, MessageBox.No);
      if (res != MessageBox.Yes)
        return false;

      //Ponemos la solicitud como no gestionada
      util.sqlUpdate("presupuestosprov", "estado", "Pendiente", "codigopedidoprov = '" + codPedidoProv + "'");
      util.sqlUpdate("presupuestosprov", "codigopedidoprov", "", "codigopedidoprov = '" + codPedidoProv + "'");

      break;
    }
  }

  if (!interna_beforeCommit_pedidosprov(curPedido))
    return false;

  return true;
}

//// OFERTAS_PROV ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
