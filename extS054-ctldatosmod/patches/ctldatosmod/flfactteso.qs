
/** @class_declaration ctlDatosMod */
/////////////////////////////////////////////////////////////////
//// CONTROL DATOS MODIFICADOS //////////////////////////////////
class ctlDatosMod extends pubEnvioMail /** %from: oficial */
{
    function ctlDatosMod( context )
	{
		pubEnvioMail ( context );
	}
	function beforeCommit_reciboscli(cursor: FLSqlCursor): Boolean
	{
		return this.ctx.ctlDatosMod_beforeCommit_reciboscli(cursor);
	}
	function beforeCommit_recibosprov(cursor: FLSqlCursor): Boolean
	{
		return this.ctx.ctlDatosMod_beforeCommit_recibosprov(cursor);
	}

}
//// CONTROL DATOS MODIFICADOS //////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition ctlDatosMod */
/////////////////////////////////////////////////////////////////
//// CONTROL DATOS MODIFICADOS ///////////////////////////////



function ctlDatosMod_beforeCommit_reciboscli(cursor)
{
	//if (!this.iface.__beforeCommit_reciboscli(cursor)) {
	//	return false;
	//}

	if (!flfactppal.iface.pub_controlDatosMod(cursor)) {
		return false;
	}

	return true;
}

function ctlDatosMod_beforeCommit_recibosprov(cursor)
{
	//if (!this.iface.__beforeCommit_recibosprov(cursor)) {
	//	return false;
	//}

	if (!flfactppal.iface.pub_controlDatosMod(cursor)) {
		return false;
	}

	return true;
}



//// CONTROL DATOS MODIFICADOS ///////////////////////////////
//////////////////////////////////////////////////////////////

