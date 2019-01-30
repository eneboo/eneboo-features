
/** @class_declaration ctlDatosMod */
/////////////////////////////////////////////////////////////////
//// CONTROL DATOS MODIFICADOS //////////////////////////////////
class ctlDatosMod extends numLinea /** %from: oficial */
{
    function ctlDatosMod( context )
	{
		numLinea ( context );
	}

    function beforeCommit_tpv_agentes(curComanda: FLSqlCursor): Boolean
	{
		return this.ctx.ctlDatosMod_beforeCommit_tpv_agentes(curComanda);
	}
	
	function beforeCommit_tpv_arqueos(curComanda: FLSqlCursor): Boolean
	{
		return this.ctx.ctlDatosMod_beforeCommit_tpv_arqueos(curComanda);
	}
	
	function beforeCommit_tpv_comandas(curComanda: FLSqlCursor): Boolean
	{
		return this.ctx.ctlDatosMod_beforeCommit_tpv_comandas(curComanda);
	}

	function beforeCommit_tpv_lineascomanda(curComanda: FLSqlCursor): Boolean
	{
		return this.ctx.ctlDatosMod_beforeCommit_tpv_lineascomanda(curComanda);
	}

}
//// CONTROL DATOS MODIFICADOS //////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition ctlDatosMod */
/////////////////////////////////////////////////////////////////
//// CONTROL DATOS MODIFICADOS ///////////////////////////////


function ctlDatosMod_beforeCommit_tpv_agentes(curA)
{
	if (!this.iface.__beforeCommit_tpv_agentes(curA)) {
		return false;
	}

	if (!flfactppal.iface.pub_controlDatosMod(curA)) {
		return false;
	}

	return true;
}

function ctlDatosMod_beforeCommit_tpv_arqueos(curA)
{
	if (!this.iface.__beforeCommit_tpv_arqueos(curA)) {
		return false;
	}

	if (!flfactppal.iface.pub_controlDatosMod(curA)) {
		return false;
	}

	return true;
}

function ctlDatosMod_beforeCommit_tpv_comandas(curA)
{
	if (!this.iface.__beforeCommit_tpv_comandas(curA)) {
		return false;
	}

	if (!flfactppal.iface.pub_controlDatosMod(curA)) {
		return false;
	}

	return true;
}

function ctlDatosMod_beforeCommit_tpv_lineascomanda(curA)
{
	
	if (!flfactppal.iface.pub_controlDatosMod(curA)) {
		return false;
	}

	return true;
}

//// CONTROL DATOS MODIFICADOS ///////////////////////////////
//////////////////////////////////////////////////////////////

