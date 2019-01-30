
/** @class_declaration ctlDatosMod */
/////////////////////////////////////////////////////////////////
//// CONTROL DATOS MODIFICADOS //////////////////////////////////
class ctlDatosMod extends pubEnvioMail /** %from: oficial */
{
    function ctlDatosMod( context )
	{
		pubEnvioMail ( context );
	}
	function controlDatosMod(curT: FLSqlCursor): Boolean
	{
		return this.ctx.ctlDatosMod_controlDatosMod(curT);
	}
	function beforeCommit_dirclientes(curDirCli: FLSqlCursor): Boolean
	{
		return this.ctx.ctlDatosMod_beforeCommit_dirclientes(curDirCli);
	}
	function beforeCommit_dirproveedores(curDirProv: FLSqlCursor): Boolean
	{
		return this.ctx.ctlDatosMod_beforeCommit_dirproveedores(curDirProv);
	}
	function beforeCommit_cuentasbcocli(curCuenta: FLSqlCursor): Boolean {
		return this.ctx.ctlDatosMod_beforeCommit_cuentasbcocli(curCuenta);
	}
	function beforeCommit_cuentasbcopro(curCuenta: FLSqlCursor): Boolean
	{
		return this.ctx.ctlDatosMod_beforeCommit_cuentasbcopro(curCuenta);
	}
	function beforeCommit_provincias(curP: FLSqlCursor): Boolean
	{
		return this.ctx.ctlDatosMod_beforeCommit_provincias(curP);
	}
	function beforeCommit_clientes(curCliente: FLSqlCursor): Boolean {
		return this.ctx.ctlDatosMod_beforeCommit_clientes(curCliente);
	}
    function beforeCommit_proveedores(curProveedor: FLSqlCursor): Boolean {
		return this.ctx.ctlDatosMod_beforeCommit_proveedores(curProveedor);
	}
}
//// CONTROL DATOS MODIFICADOS //////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pub_ctlDatosMod */
/////////////////////////////////////////////////////////////////
//// PUB CONTROL DATOS MODIFICADOS //////////////////////////////
class pub_ctlDatosMod extends pubEnvioMail /** %from: head */
{
  function pub_ctlDatosMod(context)
  {
    head(context);
  }
    function pub_controlDatosMod(curT)
  {
    return this.controlDatosMod(curT);
  }
}
//// PUB CONTROL DATOS MODIFICADOS //////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition ctlDatosMod */
/////////////////////////////////////////////////////////////////
//// CONTROL DATOS MODIFICADOS ///////////////////////////////

function ctlDatosMod_controlDatosMod(curT)
{
  var _i = this.iface;
  switch (curT.modeAccess()) {
    case curT.Insert: {
      var d = new Date;
      curT.setValueBuffer("idusuarioalta", sys.nameUser());
      curT.setValueBuffer("idusuariomod", sys.nameUser());
      curT.setValueBuffer("fechaalta", d.toString());
      curT.setValueBuffer("horaalta", d.toString().right(8));
      curT.setValueBuffer("fechamod", d.toString());
      curT.setValueBuffer("horamod", d.toString().right(8));
      break;
    }
    case curT.Edit: {
      if (!_i.registrarCambioCursor(curT)) {
        break;
      }
      var d = new Date;
      curT.setValueBuffer("idusuariomod", sys.nameUser());
      curT.setValueBuffer("fechamod", d.toString());
      curT.setValueBuffer("horamod", d.toString().right(8));
      break;
    }
  }
  return true;
}



function ctlDatosMod_beforeCommit_dirclientes(curDirCli)
{
	if (!this.iface.__beforeCommit_dirclientes(curDirCli)) {
		return false;
	}

	if (!this.iface.controlDatosMod(curDirCli)) {
		return false;
	}

	return true;
}

function ctlDatosMod_beforeCommit_dirproveedores(curDirProv)
{
	if (!this.iface.__beforeCommit_dirproveedores(curDirProv)) {
		return false;
	}

	if (!this.iface.controlDatosMod(curDirProv)) {
		return false;
	}

	return true;
}

function ctlDatosMod_beforeCommit_clientes(curCliente)
{
  	if (!this.iface.__beforeCommit_clientes(curCliente)) {
		return false;
	}

	if (!this.iface.controlDatosMod(curCliente)) {
		return false;
	}

	return true;
}

function ctlDatosMod_beforeCommit_proveedores(curProveedor)
{
  	if (!this.iface.__beforeCommit_proveedores(curProveedor)) {
		return false;
	}

	if (!this.iface.controlDatosMod(curProveedor)) {
		return false;
	}

	return true;
}


function ctlDatosMod_beforeCommit_cuentasbcocli(curCuenta: FLSqlCursor): Boolean {
    if (!this.iface.__beforeCommit_cuentasbcocli(curCuenta)) {
		return false;
	}

	if (!this.iface.controlDatosMod(curCuenta)) {
		return false;
	}

	return true;
}

function ctlDatosMod_beforeCommit_cuentasbcopro(curCuenta)
{
   if (!this.iface.__beforeCommit_cuentasbcopro(curCuenta)) {
		return false;
	}

	if (!this.iface.controlDatosMod(curCuenta)) {
		return false;
	}

	return true;
}

function ctlDatosMod_beforeCommit_provincias(curP)
{
   if (!this.iface.__beforeCommit_provincias(curP)) {
		return false;
	}

	if (!this.iface.controlDatosMod(curP)) {
		return false;
	}

	return true;
}


//// CONTROL DATOS MODIFICADOS ///////////////////////////////
//////////////////////////////////////////////////////////////

