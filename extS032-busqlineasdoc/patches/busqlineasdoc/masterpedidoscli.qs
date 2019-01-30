
/** @class_declaration busqLineasDocs */
//////////////////////////////////////////////////////////////////
//// BUSQUEDA EN LINEAS DOCUMENTOS ///////////////////////////////
class busqLineasDocs extends barCode /** %from: oficial */
{
	var filtroOriginal:String;
	var leBusqueda:Object;
	var tbnBuscar:Object;

	function busqLineasDocs( context ) { barCode ( context ); }
	function init() {
		return this.ctx.busqLineasDocs_init();
	}
	function cambioleBusqueda() {
		return this.ctx.busqLineasDocs_cambioleBusqueda();
	}
}
//// BUSQUEDA EN LINEAS DOCUMENTOS ///////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition busqLineasDocs */
//////////////////////////////////////////////////////////////////
//// BUSQUEDA EN LINEAS DOCUMENTOS ///////////////////////////////

function busqLineasDocs_init()
{
		this.iface.__init();
		this.iface.leBusqueda = this.child("leBusqueda");
		this.iface.tbnBuscar = this.child("tbnBuscar");

		this.iface.filtroOriginal = this.iface.tdbRecords.cursor().mainFilter();

		connect(this.iface.leBusqueda, "returnPressed()", this, "iface.cambioleBusqueda");
		connect(this.iface.tbnBuscar, "clicked()", this, "iface.cambioleBusqueda");

		this.iface.cambioleBusqueda();
}

	/** \D Filtra las tabla de documentos por el contenido en líneas en referencia o descripción
\end */
	function busqLineasDocs_cambioleBusqueda()
{
		var util:FLUtil = new FLUtil();
		var busquedaTxt:String;

		busquedaTxt =  "";
		busquedaTxt = this.iface.leBusqueda.text;

		if (this.iface.leBusqueda.text != '') {
			if (this.iface.filtroOriginal && this.iface.filtroOriginal != "")
			{
				this.iface.tdbRecords.cursor().setMainFilter(this.iface.filtroOriginal + " AND idpedido in (select idpedido from lineaspedidoscli where upper(referencia) like upper('%" + busquedaTxt + "%') or upper(descripcion) like upper('%" + busquedaTxt + "%'))");
			}
			else
			{
				this.iface.tdbRecords.cursor().setMainFilter("");
			}
		} else {
			this.iface.tdbRecords.cursor().setMainFilter(this.iface.filtroOriginal);
		}

		this.iface.tdbRecords.refresh();
}

//// BUSQUEDA EN LINEAS DOCUMENTOS ///////////////////////////////
/////////////////////////////////////////////////////////////////

