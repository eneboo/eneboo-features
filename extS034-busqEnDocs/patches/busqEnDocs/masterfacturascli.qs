
/** @class_declaration busqEnDocs */
///////////////////////////////////////////////////////////
//// BUSQUEDA EN DOCUMENTOS ///////////////////////////////
class busqEnDocs extends orderCols /** %from: oficial */
{
    var filtroGuardadoDoc:String;
    var filtroOriginalDoc:String;
    var filtroNuevoDoc:String;
    var leBusquedaDoc:Object;
    var tbnBuscarDoc:Object;

    function busqEnDocs( context ) { orderCols ( context ); }
    function init() {
	    return this.ctx.busqEnDocs_init();
    }
    function cambioleBusquedaDoc() {
	    return this.ctx.busqEnDocs_cambioleBusquedaDoc();
    }
}
//// BUSQUEDA EN DOCUMENTOS ///////////////////////////////
///////////////////////////////////////////////////////////

/** @class_definition busqEnDocs */
///////////////////////////////////////////////////////////
//// BUSQUEDA EN DOCUMENTOS ///////////////////////////////

function busqEnDocs_init()
{
    this.iface.__init();
    //debug(">>>>>>> NO INIT do filtro");
    this.iface.leBusquedaDoc = this.child("leBusquedaDoc");
    this.iface.tbnBuscarDoc = this.child("tbnBuscarDoc");

    this.iface.filtroOriginalDoc = this.iface.tdbRecords.cursor().mainFilter();

    connect(this.iface.leBusquedaDoc, "returnPressed()", this, "iface.cambioleBusquedaDoc");
    connect(this.iface.tbnBuscarDoc, "clicked()", this, "iface.cambioleBusquedaDoc");

    this.iface.cambioleBusquedaDoc();
}

	/** \D Filtra los documentos por cliente tendo en conta o filtro das liñas
\end */
function busqEnDocs_cambioleBusquedaDoc()
{
  var util:FLUtil = new FLUtil();
  var busquedaTxt:String = this.iface.leBusquedaDoc.text;
  var filtroDoc:String;
  filtroDoc = "";

  if (this.iface.leBusquedaDoc.text != "") {
      this.iface.filtroOriginalDoc = this.iface.tdbRecords.cursor().mainFilter();
      filtroDoc = " AND facturascli.nombrecliente like upper('%" + busquedaTxt + "%')";
      this.iface.filtroNuevoDoc =  this.iface.filtroOriginalDoc + filtroDoc;
      this.iface.tdbRecords.cursor().setMainFilter(this.iface.filtroNuevoDoc);
      this.iface.tdbRecords.refresh();
      this.iface.filtroGuardadoDoc = this.iface.filtroOriginalDoc;
      this.iface.filtroNuevoDoc = "";
      this.iface.filtroOriginalDoc = "";
  } else {
      this.iface.filtroNuevoDoc = "";
      this.iface.filtroOriginalDoc = "";
      this.iface.tdbRecords.cursor().setMainFilter(this.iface.filtroGuardadoDoc);

  }

  this.iface.tdbRecords.refresh();

}

//// BUSQUEDA EN DOCUMENTOS ///////////////////////////////
///////////////////////////////////////////////////////////

