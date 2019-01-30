
/** @class_declaration ctlDatosMod */
/////////////////////////////////////////////////////////////////
//// CONTROL DATOS MODIFICADOS //////////////////////////////////
class ctlDatosMod extends oficial /** %from: oficial */
{
    function ctlDatosMod( context )
	{
		oficial ( context );
	}

	function beforeCommit_atributosarticulos(cursor:FLSqlCursor):Boolean {
		return this.ctx.ctlDatosMod_beforeCommit_atributosarticulos(cursor);
	}
	
	function beforeCommit_articulos(cursor:FLSqlCursor):Boolean {
		return this.ctx.ctlDatosMod_beforeCommit_articulos(cursor);
	}

 


}
//// CONTROL DATOS MODIFICADOS //////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition ctlDatosMod */
/////////////////////////////////////////////////////////////////
//// CONTROL DATOS MODIFICADOS ///////////////////////////////

function ctlDatosMod_beforeCommit_atributosarticulos(cursor:FLSqlCursor):Boolean
{

	if (!this.iface.__beforeCommit_atributosarticulos(cursor)) {
		return false;
	}

	if (!flfactppal.iface.pub_controlDatosMod(cursor)) {
		return false;
	}

	return true;
}


function ctlDatosMod_beforeCommit_articulos(cursor:FLSqlCursor):Boolean
{

	if (!this.iface.__beforeCommit_articulos(cursor)) {
		return false;
	}

	if (!flfactppal.iface.pub_controlDatosMod(cursor)) {
		return false;
	}

	return true;
}

//// CONTROL DATOS MODIFICADOS ///////////////////////////////
//////////////////////////////////////////////////////////////

