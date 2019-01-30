
/** @class_declaration ctlDatosMod */
/////////////////////////////////////////////////////////////////
//// CONTROL DATOS MODIFICADOS //////////////////////////////////
class ctlDatosMod extends ofertasProv /** %from: oficial */
{
    function ctlDatosMod( context )
	{
		ofertasProv ( context );
	}

	function beforeCommit_presupuestoscli(curPresupuesto:FLSqlCursor):Boolean {
		return this.ctx.ctlDatosMod_beforeCommit_presupuestoscli(curPresupuesto);
	}

    function beforeCommit_pedidoscli(curPedido:FLSqlCursor):Boolean {
		return this.ctx.ctlDatosMod_beforeCommit_pedidoscli(curPedido);
	}

    function beforeCommit_albaranescli(curAlbaran:FLSqlCursor):Boolean {
		return this.ctx.ctlDatosMod_beforeCommit_albaranescli(curAlbaran);
	}

    function beforeCommit_facturascli(curFactura:FLSqlCursor):Boolean {
		return this.ctx.ctlDatosMod_beforeCommit_facturascli(curFactura);
	}
        function beforeCommit_pedidosprov(curPedido:FLSqlCursor):Boolean {
		return this.ctx.ctlDatosMod_beforeCommit_pedidosprov(curPedido);
	}

    function beforeCommit_albaranesprov(curAlbaran:FLSqlCursor):Boolean {
		return this.ctx.ctlDatosMod_beforeCommit_albaranesprov(curAlbaran);
	}

    function beforeCommit_facturasprov(curFactura:FLSqlCursor):Boolean {
		return this.ctx.ctlDatosMod_beforeCommit_facturasprov(curFactura);
	}

  function beforeCommit_lineaspresupuestoscli(curL: FLSqlCursor): Boolean {
    return this.ctx.ctlDatosMod_beforeCommit_lineaspresupuestoscli(curL);
  }
  function beforeCommit_lineaspedidoscli(curL: FLSqlCursor): Boolean {
    return this.ctx.ctlDatosMod_beforeCommit_lineaspedidoscli(curL);
  }
  function beforeCommit_lineaspedidosprov(curL: FLSqlCursor): Boolean {
    return this.ctx.ctlDatosMod_beforeCommit_lineaspedidosprov(curL);
  }
  function beforeCommit_lineasalbaranescli(curL: FLSqlCursor): Boolean {
    return this.ctx.ctlDatosMod_beforeCommit_lineaspedidoscli(curL);
  }
  function beforeCommit_lineasalbaranesprov(curL: FLSqlCursor): Boolean {
    return this.ctx.ctlDatosMod_beforeCommit_lineasalbaranesprov(curL);
  }
    function beforeCommit_lineasfacturascli(curL: FLSqlCursor): Boolean {
    return this.ctx.ctlDatosMod_beforeCommit_lineasfacturascli(curL);
  }
  function beforeCommit_lineasfacturasprov(curL: FLSqlCursor): Boolean {
    return this.ctx.ctlDatosMod_beforeCommit_lineasfacturasprov(curL);
  }



}
//// CONTROL DATOS MODIFICADOS //////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition ctlDatosMod */
/////////////////////////////////////////////////////////////////
//// CONTROL DATOS MODIFICADOS ///////////////////////////////

function ctlDatosMod_beforeCommit_presupuestoscli(curPresupuesto:FLSqlCursor):Boolean
{

	if (!this.iface.__beforeCommit_presupuestoscli(curPresupuesto)) {
		return false;
	}

	if (!flfactppal.iface.pub_controlDatosMod(curPresupuesto)) {
		return false;
	}

	return true;
}

function ctlDatosMod_beforeCommit_pedidoscli(curPedido:FLSqlCursor):Boolean
{
	if (!this.iface.__beforeCommit_pedidoscli(curPedido)) {
		return false;
	}

	if (!flfactppal.iface.pub_controlDatosMod(curPedido)) {
		return false;
	}

	return true;
}

function ctlDatosMod_beforeCommit_albaranescli(curAlbaranes:FLSqlCursor):Boolean
{

	if (!this.iface.__beforeCommit_albaranescli(curAlbaranes)) {
		return false;
	}

	if (!flfactppal.iface.pub_controlDatosMod(curAlbaranes)) {
		return false;
	}

	return true;
}

function ctlDatosMod_beforeCommit_facturascli(curFactura:FLSqlCursor):Boolean
{
	if (!this.iface.__beforeCommit_facturascli(curFactura)) {
		return false;
	}

	if (!flfactppal.iface.pub_controlDatosMod(curFactura)) {
		return false;
	}

	return true;
}

function ctlDatosMod_beforeCommit_pedidosprov(curPedido:FLSqlCursor):Boolean
{

	if (!this.iface.__beforeCommit_pedidosprov(curPedido)) {
		return false;
	}

	if (!flfactppal.iface.pub_controlDatosMod(curPedido)) {
		return false;
	}

	return true;
}

function ctlDatosMod_beforeCommit_albaranesprov(curAlbaranes:FLSqlCursor):Boolean
{

	if (!this.iface.__beforeCommit_albaranesprov(curAlbaranes)) {
		return false;
	}

	if (!flfactppal.iface.pub_controlDatosMod(curAlbaranes)) {
		return false;
	}

	return true;
}

function ctlDatosMod_beforeCommit_facturasprov(curFactura:FLSqlCursor):Boolean
{


	if (!this.iface.__beforeCommit_facturasprov(curFactura)) {
		return false;
	}

	if (!flfactppal.iface.pub_controlDatosMod(curFactura)) {
		return false;
	}

	return true;
}

function ctlDatosMod_beforeCommit_lineaspresupuestoscli(curL)
{

	if (!this.iface.__beforeCommit_lineaspresupuestoscli(curL)) {
		return false;
	}

	if (!flfactppal.iface.pub_controlDatosMod(curL)) {
		return false;
	}

  return true;
}

function ctlDatosMod_beforeCommit_lineaspedidoscli(curL)
{

	if (!this.iface.__beforeCommit_lineaspedidoscli(curL)) {
		return false;
	}

	if (!flfactppal.iface.pub_controlDatosMod(curL)) {
		return false;
	}

  return true;
}


function ctlDatosMod_beforeCommit_lineaspedidosprov(curL)
{

	if (!this.iface.__beforeCommit_lineaspedidosprov(curL)) {
		return false;
	}

	if (!flfactppal.iface.pub_controlDatosMod(curL)) {
		return false;
	}

  return true;
}

function ctlDatosMod_beforeCommit_lineasalbaranescli(curL)
{

	if (!this.iface.__beforeCommit_lineasalbaranescli(curL)) {
		return false;
	}

	if (!flfactppal.iface.pub_controlDatosMod(curL)) {
		return false;
	}

  return true;
}

function ctlDatosMod_beforeCommit_lineasalbaranesprov(curL)
{

	if (!this.iface.__beforeCommit_lineasalbaranesprov(curL)) {
		return false;
	}

	if (!flfactppal.iface.pub_controlDatosMod(curL)) {
		return false;
	}

  return true;
}

function ctlDatosMod_beforeCommit_lineasfacturascli(curL)
{

	if (!this.iface.__beforeCommit_lineasfacturascli(curL)) {
		return false;
	}

	if (!flfactppal.iface.pub_controlDatosMod(curL)) {
		return false;
	}

  return true;
}

function ctlDatosMod_beforeCommit_lineasfacturasprov(curL)
{

	if (!this.iface.__beforeCommit_lineasfacturasprov(curL)) {
		return false;
	}

	if (!flfactppal.iface.pub_controlDatosMod(curL)) {
		return false;
	}

  return true;
}


//// CONTROL DATOS MODIFICADOS ///////////////////////////////
//////////////////////////////////////////////////////////////

