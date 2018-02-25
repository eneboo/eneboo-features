
/** @class_declaration bloqDocImpr */
/////////////////////////////////////////////////////////////////
//// BLOQUEO DOCUMENTOS IMPRESION ///////////////////////////////
class bloqDocImpr extends pedProvCli /** %from: oficial */ {
    function bloqDocImpr( context ) { pedProvCli ( context ); }

    function beforeCommit_presupuestoscli(curPresupuesto:FLSqlCursor):Boolean {
		return this.ctx.bloqDocImpr_beforeCommit_presupuestoscli(curPresupuesto);
	}

    function beforeCommit_pedidoscli(curPedido:FLSqlCursor):Boolean {
		return this.ctx.bloqDocImpr_beforeCommit_pedidoscli(curPedido);
	}

    function beforeCommit_albaranescli(curAlbaran:FLSqlCursor):Boolean {
		return this.ctx.bloqDocImpr_beforeCommit_albaranescli(curAlbaran);
	}

    function beforeCommit_facturascli(curFactura:FLSqlCursor):Boolean {
		return this.ctx.bloqDocImpr_beforeCommit_facturascli(curFactura);
	}
        function beforeCommit_pedidosprov(curPedido:FLSqlCursor):Boolean {
		return this.ctx.bloqDocImpr_beforeCommit_pedidosprov(curPedido);
	}

    function beforeCommit_albaranesprov(curAlbaran:FLSqlCursor):Boolean {
		return this.ctx.bloqDocImpr_beforeCommit_albaranesprov(curAlbaran);
	}

    function beforeCommit_facturasprov(curFactura:FLSqlCursor):Boolean {
		return this.ctx.bloqDocImpr_beforeCommit_facturasprov(curFactura);
	}


}
//// BLOQUEO DOCUMENTOS IMPRESION ///////////////////////////////
////////////////////////////////////////////////////////////////

/** @class_definition bloqDocImpr */
/////////////////////////////////////////////////////////////////
//// BLOQUEO DOCUMENTOS IMPRESION ///////////////////////////////

function bloqDocImpr_beforeCommit_presupuestoscli(curPresupuesto:FLSqlCursor):Boolean
{
	var util:FLUtil;
	if (curPresupuesto.modeAccess() == curPresupuesto.Del) {
		if (curPresupuesto.valueBuffer("impreso") == true && util.sqlSelect("empresa", "bloqprecliimp", " 1 = 1") == true )
		{
			MessageBox.warning(util.translate("scripts", "Según la configuración actual no es posible\neliminar un presupuesto impreso.\n\nContacte con un administrador si es necesario."), MessageBox.Ok, MessageBox.NoButton);
			return false
		}
    }

	if (!this.iface.__beforeCommit_presupuestoscli(curPresupuesto)) {
		return false;
	}

	return true;
}

function bloqDocImpr_beforeCommit_pedidoscli(curPedido:FLSqlCursor):Boolean
{
	var util:FLUtil;
	if (curPedido.modeAccess() == curPedido.Del) {
		if (curPedido.valueBuffer("impreso") == true && util.sqlSelect("empresa", "bloqpedcliimp", " 1 = 1") == true )
		{
			MessageBox.warning(util.translate("scripts", "Según la configuración actual no es posible\neliminar un pedido impreso.\n\nContacte con un administrador si es necesario."), MessageBox.Ok, MessageBox.NoButton);
			return false
		}
    }

	if (!this.iface.__beforeCommit_pedidoscli(curPedido)) {
		return false;
	}

	return true;
}

function bloqDocImpr_beforeCommit_albaranescli(curAlbaranes:FLSqlCursor):Boolean
{
	var util:FLUtil;
	if (curAlbaranes.modeAccess() == curAlbaranes.Del) {
		if (curAlbaranes.valueBuffer("impreso") == true && util.sqlSelect("empresa", "bloqalbcliimp", " 1 = 1") == true )
		{
			MessageBox.warning(util.translate("scripts", "Según la configuración actual no es posible\neliminar un albarán impreso.\n\nContacte con un administrador si es necesario."), MessageBox.Ok, MessageBox.NoButton);
			return false
		}
    }

	if (!this.iface.__beforeCommit_albaranescli(curAlbaranes)) {
		return false;
	}

	return true;
}

function bloqDocImpr_beforeCommit_facturascli(curFactura:FLSqlCursor):Boolean
{
	var util:FLUtil;
	if (curFactura.modeAccess() == curFactura.Del) {
		if (curFactura.valueBuffer("impreso") == true && util.sqlSelect("empresa", "bloqfaccliimp", " 1 = 1") == true )
		{
			MessageBox.warning(util.translate("scripts", "Según la configuración actual no es posible\neliminar una factura impresa.\n\nContacte con un administrador si es necesario."), MessageBox.Ok, MessageBox.NoButton);
			return false
		}
    }

	if (!this.iface.__beforeCommit_facturascli(curFactura)) {
		return false;
	}

	return true;
}

function bloqDocImpr_beforeCommit_pedidosprov(curPedido:FLSqlCursor):Boolean
{
	var util:FLUtil;
	if (curPedido.modeAccess() == curPedido.Del) {
		if (curPedido.valueBuffer("impreso") == true && util.sqlSelect("empresa", "bloqpedproimp", " 1 = 1") == true )
		{
			MessageBox.warning(util.translate("scripts", "Según la configuración actual no es posible\neliminar un pedido de proveedor impreso.\n\nContacte con un administrador si es necesario."), MessageBox.Ok, MessageBox.NoButton);
			return false
		}
    }

	if (!this.iface.__beforeCommit_pedidosprov(curPedido)) {
		return false;
	}

	return true;
}

function bloqDocImpr_beforeCommit_albaranesprov(curAlbaranes:FLSqlCursor):Boolean
{
	var util:FLUtil;
	if (curAlbaranes.modeAccess() == curAlbaranes.Del) {
		if (curAlbaranes.valueBuffer("impreso") == true && util.sqlSelect("empresa", "bloqalbproimp", " 1 = 1") == true )
		{
			MessageBox.warning(util.translate("scripts", "Según la configuración actual no es posible\neliminar un albarán de proveedor impreso.\n\nContacte con un administrador si es necesario."), MessageBox.Ok, MessageBox.NoButton);
			return false
		}
    }

	if (!this.iface.__beforeCommit_albaranesprov(curAlbaranes)) {
		return false;
	}

	return true;
}

function bloqDocImpr_beforeCommit_facturasprov(curFactura:FLSqlCursor):Boolean
{
	var util:FLUtil;
	if (curFactura.modeAccess() == curFactura.Del) {
		if (curFactura.valueBuffer("impreso") == true && util.sqlSelect("empresa", "bloqfacproimp", " 1 = 1") == true )
		{
			MessageBox.warning(util.translate("scripts", "Según la configuración actual no es posible\neliminar una factura de proveedor impresa.\n\nContacte con un administrador si es necesario."), MessageBox.Ok, MessageBox.NoButton);
			return false
		}
    }

	if (!this.iface.__beforeCommit_facturasprov(curFactura)) {
		return false;
	}

	return true;
}

//// BLOQUEO DOCUMENTOS IMPRESION ///////////////////////////////
////////////////////////////////////////////////////////////////

