
class interna {
    var ctx:Object;
    function interna( context ) { this.ctx = context; }
    function init() { this.ctx.interna_init();}
    function acceptedForm() { this.ctx.interna_acceptedForm(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var COL_INCLUIR:Number;
	var COL_EQUIPAMIENTO:Number;
	var currentRow:Number;
	var tblEquipamiento:QTable;
    function oficial( context ) { interna( context ); } 

	/*function pbnAddDel_clicked() {
		return this.ctx.oficial_pbnAddDel_clicked();
	}*/
	function incluirFila(fila:Number, col:Number) {
		return this.ctx.oficial_incluirFila(fila, col);
	    }
	function actualizar() {
		return this.ctx.oficial_actualizar();
	}
	function generarTabla() {
		return this.ctx.oficial_generarTabla();
	}
	function insertarLineaTabla(curEquipamiento:FLSqlCursor) {
		return this.ctx.oficial_insertarLineaTabla(curEquipamiento);
	}
	function lanzarHistorico(){
	    return this.ctx.oficial_lanzarHistorico();
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends oficial {
    function head( context ) { oficial ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
    function ifaceCtx( context ) { head( context ); }
}

const iface = new ifaceCtx( this );
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition interna */
////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////

function interna_init()
{
    
	this.iface.tblEquipamiento = this.child("tblEquipamiento");
	var cursor:FLSqlCursor = this.cursor();

	connect(this.iface.tblEquipamiento, "doubleClicked(int, int)", this, "iface.incluirFila");
	connect(this.child("toolButtonActualizar"), "clicked()", this, "iface.actualizar()");
	connect(this.child("pbnHistorico"), "clicked()", this, "iface.lanzarHistorico()");


	var util:FLUtil = new FLUtil();
	this.iface.generarTabla();

}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

function interna_acceptedForm()
{
    
    var util:FLUtil = new FLUtil;
    var cursor:FLSqlCursor = this.cursor();
    cursor.commitBuffer();
    var curEquipamiento:FLSqlCursor = new FLSqlCursor("vld_equipamientovehiculo");
    var curTablaEquipamiento:FLSqlCursor = new FLSqlCursor("vld_equipamiento");
    var codv:String = cursor.valueBuffer("codvehiculo");
    var code:String;
    var codve:String;
    var numLinea:Number = this.iface.tblEquipamiento.numRows();
    curEquipamiento.select("codvehiculo= '"+ cursor.valueBuffer("codvehiculo") + "'")
   while (curEquipamiento.next()) {
    curEquipamiento.setModeAccess(curEquipamiento.Del);
    curEquipamiento.refreshBuffer();
     curEquipamiento.commitBuffer();}
    while (numLinea>0){
	numLinea = numLinea-1;
	if(this.iface.tblEquipamiento.text(numLinea, this.iface.COL_INCLUIR)=="Si"){
	    
	    curTablaEquipamiento.select("equipamiento = '" + this.iface.tblEquipamiento.text(numLinea, this.iface.COL_EQUIPAMIENTO) + "'");
	    curTablaEquipamiento.first();
	    code = curTablaEquipamiento.valueBuffer("codequipamiento");
	    codve = codv + code;
	    
	    curEquipamiento.setModeAccess(curEquipamiento.Insert);
	    curEquipamiento.refreshBuffer();
	    curEquipamiento.setValueBuffer("codequipvehi", codve);
	    curEquipamiento.setValueBuffer("equipamiento", this.iface.tblEquipamiento.text(numLinea, this.iface.COL_EQUIPAMIENTO));
	    curEquipamiento.setValueBuffer("tipo", this.child("fdbtipo").value());
	    curEquipamiento.setValueBuffer("codvehiculo", cursor.valueBuffer("codvehiculo"));
	    }
	curEquipamiento.commitBuffer();
    }

}



/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_tblAlbaranes_currentChanged(row:Number, col:Number)
{
	this.iface.currentRow = row;
}


function oficial_incluirFila(fila:Number, col:Number)
{
	if (this.iface.tblEquipamiento.numRows() == 0) return;
	
	if (this.iface.tblEquipamiento.text(fila, this.iface.COL_INCLUIR) == "No") {
		this.iface.tblEquipamiento.setText(fila, this.iface.COL_INCLUIR, "Si");
	} else {
		this.iface.tblEquipamiento.setText(fila, this.iface.COL_INCLUIR, "No");
	}
}

function oficial_actualizar()
{
          
	var curEquipamiento:FLSqlCursor = new FLSqlCursor("vld_equipamientotipo");
	var util:FLUtil = new FLUtil;
	var fila:Number;
	var tipo:String = this.child("fdbtipo").value();
	var numFilas:Number = this.iface.tblEquipamiento.numRows();
	
	if(!curEquipamiento.select("tipo = '" + tipo + "'")){
	   return;}
	while (curEquipamiento.next()) {
		curEquipamiento.setModeAccess(curEquipamiento.Browse);
		curEquipamiento.refreshBuffer();
		this.iface.insertarLineaTabla(curEquipamiento);
	}
}

function oficial_insertarLineaTabla(curEquipamiento:FLSqlCursor)
{
	var util:FLUtil = new FLUtil();
	var x:Number;
	x=0;
	var numLinea:Number = this.iface.tblEquipamiento.numRows();
	var fila:Number = numLinea;
	while(fila>0){
	    fila=fila-1;
	    if (this.iface.tblEquipamiento.text(fila, this.iface.COL_EQUIPAMIENTO) == curEquipamiento.valueBuffer("equipamiento"))
		x=1;
	}
	    if (!x){
		  this.iface.tblEquipamiento.insertRows(numLinea);
		  this.iface.tblEquipamiento.setText(numLinea, this.iface.COL_INCLUIR, "No");
		  this.iface.tblEquipamiento.setText(numLinea, this.iface.COL_EQUIPAMIENTO, curEquipamiento.valueBuffer("equipamiento"));
	      }
   
}


function oficial_generarTabla()
{
	this.iface.COL_INCLUIR = 1;
	this.iface.COL_EQUIPAMIENTO = 0;

	this.iface.tblEquipamiento.setNumCols(2);
	this.iface.tblEquipamiento.setColumnWidth(this.iface.COL_INCLUIR, 60);
	this.iface.tblEquipamiento.setColumnWidth(this.iface.COL_EQUIPAMIENTO, 220);
	this.iface.tblEquipamiento.setColumnLabels("/", "Equipamiento/Incuir");
	
	
	
	var curEquipamiento:FLSqlCursor = new FLSqlCursor("vld_equipamientovehiculo");
	var util:FLUtil = new FLUtil;
	var fila:Number;
	var vehiculo:String = this.child("fdbcodvehiculo").value();
	var numFilas:Number = this.iface.tblEquipamiento.numRows();
	for (fila = 0; fila < numFilas; fila++)
		this.iface.tblEquipamiento.removeRow(0);
	
	if(!curEquipamiento.select("codvehiculo  = '" + vehiculo + "'"))
	   return;
	while (curEquipamiento.next()) {
		curEquipamiento.setModeAccess(curEquipamiento.Browse);
		curEquipamiento.refreshBuffer();
		var numLinea:Number = this.iface.tblEquipamiento.numRows();
		this.iface.tblEquipamiento.insertRows(numLinea);
		this.iface.tblEquipamiento.setText(numLinea, this.iface.COL_INCLUIR, "Si");
		this.iface.tblEquipamiento.setText(numLinea, this.iface.COL_EQUIPAMIENTO, curEquipamiento.valueBuffer("equipamiento"));
	}
}

function oficial_lanzarHistorico()
{
    var cursor:FLSqlCursor = this.cursor();
	var q = new FLSqlQuery("vld_historico");
	q.setValueParam("cod", cursor.valueBuffer("codvehiculo"));
	var rptViewer = new FLReportViewer();
	rptViewer.setReportTemplate("vld_historico");
	rptViewer.setReportData(q);
	rptViewer.renderReport();
	rptViewer.exec();
}









































































































































































