
/** @class_declaration cliDebaja */
/////////////////////////////////////////////////////////////////
//// CLIENTES DE BAJA //////////////////////////////////////////////////
class cliDebaja extends oficial /** %from: oficial */
{
	var filtroOriginal:String;
	var chkDebaja:Object;
	function cliDebaja( context ) { oficial ( context ); }
	function init() {
		return this.ctx.cliDebaja_init();
	}
	function cambioChkDebaja() {
		return this.ctx.cliDebaja_cambioChkDebaja();
	}
}
//// CLIENTES DE BAJA //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition cliDebaja */
/////////////////////////////////////////////////////////////////
//// CLIENTES DE BAJA //////////////////////////////////////////////////

function cliDebaja_init()
{
	this.iface.__init();

	this.iface.chkDebaja = this.child("chkDebaja");
	this.iface.filtroOriginal = this.iface.tdbRecords.cursor().mainFilter();
	connect(this.iface.chkDebaja, "clicked()", this, "iface.cambioChkDebaja");
	this.iface.cambioChkDebaja();
}

/** \D Filtra las tabla de clientes quitando los dados de baja
\end */
function cliDebaja_cambioChkDebaja()
{
	var util:FLUtil = new FLUtil();

	if (this.iface.chkDebaja.checked) {
		if (this.iface.filtroOriginal && this.iface.filtroOriginal != "")
			this.iface.tdbRecords.cursor().setMainFilter(this.iface.filtroOriginal + " AND debaja = false");
		else
			this.iface.tdbRecords.cursor().setMainFilter("debaja = false");
	} else {
		this.iface.tdbRecords.cursor().setMainFilter(this.iface.filtroOriginal);
	}

	this.iface.tdbRecords.refresh();
}

//// CLIENTES DE BAJA /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////

