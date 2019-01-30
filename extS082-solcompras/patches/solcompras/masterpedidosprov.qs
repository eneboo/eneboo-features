
/** @class_declaration ofertasProv */
/////////////////////////////////////////////////////////////////
//// OFERTAS_PROV //////////////////////////////////////////////
class ofertasProv extends etiBarcode /** %from: etiBarcode */
{

  function ofertasProv(context)
  {
    etiBarcode(context);
  }
  function init()
  {
    return this.ctx.ofertasProv_init();
  }
  function marcarTramitado_clicked() {
    return this.ctx.ofertasProv_marcarTramitado_clicked();
  }
  function marcarEnviado_clicked() {
    return this.ctx.ofertasProv_marcarEnviado_clicked();
  }


}
//// OFERTAS_PROV //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition ofertasProv */
/////////////////////////////////////////////////////////////////
//// OFERTAS_PROV ///////////////////////////////////////////////

function ofertasProv_init()
{

	this.iface.__init();



    connect(this.child("tbnMarcarTramitado"), "clicked()", this, "iface.marcarTramitado_clicked");
    connect(this.child("tbnMarcarEnviado"), "clicked()", this, "iface.marcarEnviado_clicked");

	this.child("tableDBRecords").setColumnWidth("servido", 45);
	this.child("tableDBRecords").setColumnWidth("editable", 45);
	this.child("tableDBRecords").setColumnWidth("impreso", 45);
	this.child("tableDBRecords").setColumnWidth("tramitado", 45);
	this.child("tableDBRecords").setColumnWidth("enviado", 45);


}



function ofertasProv_marcarTramitado_clicked() {


  var _i = this.iface;
  var util: FLUtil;
  var cursor = this.cursor();


  var idPedido: Number = cursor.valueBuffer("idpedido");

    debug (">>>>> SIAGAL masterpedidosprov.ofertasProv_marcarTramitado_clicked() idpedido " + idPedido);

  if (!idPedido) {
    MessageBox.warning(util.translate("scripts", "No hay ningún registro seleccionado"), MessageBox.Ok, MessageBox.NoButton);
  }

  var tramitado: Boolean = true;
  var res: Number;

   if (cursor.valueBuffer("enviado")) {
      MessageBox.warning(util.translate("scripts", "El pedido ya fue enviado, no se puede marcar como NO TRAMITADO."), MessageBox.Ok, MessageBox.NoButton);
      return false
  }


  if (!cursor.valueBuffer("editable")) {
      MessageBox.warning(util.translate("scripts", "El pedido ya ha sido servido completamente y no puede ser modificado."), MessageBox.Ok, MessageBox.NoButton);
  } else {

	if (cursor.valueBuffer("tramitado")) {
		res = MessageBox.information(util.translate("scripts", "El pedido seleccionado ya fue tramitado.\n¿Desea marcarlo como NO TRAMITADO?"), MessageBox.Yes, MessageBox.No);
	    if (res == MessageBox.Yes) {
			tramitado = false;
		}
    }



  var curPedido = new FLSqlCursor("pedidosprov");

  //Se queremos que se poida modificar incluso cando o pedido estea servido
  //curPedido.select("idpedido = " + idPedido);
  //if (curPedido.first()) {
  //  curPedido.setUnLock("editable", true);
  //}

  curPedido.select("idpedido = " + idPedido);
  curPedido.setModeAccess(curPedido.Edit);
  if (curPedido.first()) {
    curPedido.setValueBuffer("tramitado", tramitado);
    if (!curPedido.commitBuffer()) {
       MessageBox.warning(util.translate("scripts", "Hubo algún problema marcando el pedido"), MessageBox.Ok, MessageBox.NoButton);
    }
  }


	this.iface.tdbRecords.refresh();
  }

}


function ofertasProv_marcarEnviado_clicked() {


  var _i = this.iface;
  var util: FLUtil;
  var cursor = this.cursor();


  var idPedido: Number = cursor.valueBuffer("idpedido");

  //debug (">>>>> SIAGAL masterpedidosprov.ofertasProv_marcarEnviado_clicked() idpedido " + idPedido);

  if (!idPedido) {
    MessageBox.warning(util.translate("scripts", "No hay ningún registro seleccionado"), MessageBox.Ok, MessageBox.NoButton);
  }

  var enviado: Boolean = true;
  var fechaEnvio: Date;
  var res: Number;


  if (!cursor.valueBuffer("tramitado")) {
      MessageBox.warning(util.translate("scripts", "Solo se pueden enviar pedidos que estén previamente tramitados."), MessageBox.Ok, MessageBox.NoButton);
      return false
  }

  if (!cursor.valueBuffer("editable")) {
      MessageBox.warning(util.translate("scripts", "El pedido ya ha sido servido completamente y no puede ser modificado."), MessageBox.Ok, MessageBox.NoButton);
  } else {

	if (cursor.valueBuffer("enviado")) {
		res = MessageBox.information(util.translate("scripts", "El pedido seleccionado ya fue Enviado.\n¿Desea marcarlo como NO ENVIADO?"), MessageBox.Yes, MessageBox.No);
	    if (res == MessageBox.Yes) {
			enviado = false;
			fechaEnvio = "";
		}
    }



	var curPedido = new FLSqlCursor("pedidosprov");

	//Se queremos que se poida modificar incluso cando o pedido estea servido
	//curPedido.select("idpedido = " + idPedido);
	//if (curPedido.first()) {
	//  curPedido.setUnLock("editable", true);
	//}

	curPedido.select("idpedido = " + idPedido);
	curPedido.setModeAccess(curPedido.Edit);
	if (curPedido.first()) {
	curPedido.setValueBuffer("enviado", enviado);
	curPedido.setValueBuffer("fechaenvio", fechaEnvio);
		if (!curPedido.commitBuffer()) {
		   MessageBox.warning(util.translate("scripts", "Hubo algún problema marcando el pedido"), MessageBox.Ok, MessageBox.NoButton);
		}
	}
	this.iface.tdbRecords.refresh();
  }



}





//// OFERTAS_PROV ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
