
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
	var COL_TIPO:Number;
	var currentRow:Number;
	var tblTipo:QTable;
    function oficial( context ) { interna( context ); } 
	function tblTipo_currentChanged(row:Number, col:Number) {
		return this.ctx.oficial_tblTipo_currentChanged(row, col);
	}
	function incluirFila(fila:Number, col:Number) {
		return this.ctx.oficial_incluirFila(fila, col);
	    }
	function actualizar() {
		return this.ctx.oficial_actualizar();
	}
	function generarTabla() {
		return this.ctx.oficial_generarTabla();
	}
	function insertarLineaTabla(curTipo:FLSqlCursor) {
		return this.ctx.oficial_insertarLineaTabla(curTipo);
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
                var util:FLUtil = new FLUtil;
	this.iface.tblTipo = this.child("tblTipo");
	var cursor:FLSqlCursor = this.cursor();
	connect(this.iface.tblTipo, "doubleClicked(int, int)", this, "iface.incluirFila");
	connect(this.iface.tblTipo, "currentChanged(int, int)", this, "iface.tblTipo_currentChanged");
	connect(this.child("pbnActualizar"), "clicked()", this, "iface.actualizar()");


	this.iface.generarTabla();

}

function oficial_tblTipo_currentChanged(row:Number, col:Number)
{
	this.iface.currentRow = row;
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

function interna_acceptedForm()
{
    
    var util:FLUtil = new FLUtil;
    var cursor:FLSqlCursor = this.cursor();
    cursor.commitBuffer();
    var curTipo:FLSqlCursor = new FLSqlCursor("vld_equipamientotipo");
    var curTablaTipo:FLSqlCursor = new FLSqlCursor("vld_tipo");
    var code:String = cursor.valueBuffer("codequipamiento");
    var codt:String;
    var codet:String;
    var numLinea:Number = this.iface.tblTipo.numRows();
    curTipo.select("equipamiento= '"+ cursor.valueBuffer("equipamiento") + "'");
    while (curTipo.next()) {
	curTipo.setModeAccess(curTipo.Del);
	curTipo.refreshBuffer();
	curTipo.commitBuffer();	
    }
    while (numLinea>0){
	numLinea = numLinea-1;
	if(this.iface.tblTipo.text(numLinea, this.iface.COL_INCLUIR)=="Si"){
	    curTablaTipo.select("tipo  = '" + this.iface.tblTipo.text(numLinea, this.iface.COL_TIPO) + "'");
	    curTablaTipo.first();
	    codt=curTablaTipo.valueBuffer("codtipo");
	    codet=code+codt;
	  
	    curTipo.setModeAccess(curTipo.Insert);
	    curTipo.refreshBuffer();
	    curTipo.setValueBuffer("codequiptipo", codet);
	    curTipo.setValueBuffer("tipo", this.iface.tblTipo.text(numLinea, this.iface.COL_TIPO));
	    curTipo.setValueBuffer("equipamiento", cursor.valueBuffer("equipamiento"));
	    }
	curTipo.commitBuffer();
    }
}



/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_incluirFila(fila:Number, col:Number)
{

	if (this.iface.tblTipo.numRows() == 0) return;
	if (this.iface.tblTipo.text(fila, this.iface.COL_INCLUIR) == "No") {
		this.iface.tblTipo.setText(fila, this.iface.COL_INCLUIR, "Si");
	} else {
		this.iface.tblTipo.setText(fila, this.iface.COL_INCLUIR, "No");
	}
}

function oficial_actualizar()
{
	var curTipo:FLSqlCursor = new FLSqlCursor("vld_tipo");
	var util:FLUtil = new FLUtil;
	var fila:Number;
	var codtipo:String = "000001"
	var numFilas:Number = this.iface.tblTipo.numRows();
	if(!curTipo.select("codtipo <> '" + codtipo + "' OR codtipo = '" + codtipo + "'")){
	   return;}
	while (curTipo.next()) {
		curTipo.setModeAccess(curTipo.Browse);
		curTipo.refreshBuffer();
		this.iface.insertarLineaTabla(curTipo);
	}
}

function oficial_insertarLineaTabla(curTipo:FLSqlCursor)
{
	var util:FLUtil = new FLUtil();
	var x:Number;
	x=0;
	var numLinea:Number = this.iface.tblTipo.numRows();
	var fila:Number = numLinea;
	while(fila>0){
	    fila = fila-1;
	    if(this.iface.tblTipo.text(fila, this.iface.COL_TIPO) == curTipo.valueBuffer("tipo"))
		x=1;
	}
	if(!x){
	    this.iface.tblTipo.insertRows(numLinea);
	    this.iface.tblTipo.setText(numLinea, this.iface.COL_INCLUIR, "No");
	    this.iface.tblTipo.setText(numLinea, this.iface.COL_TIPO, curTipo.valueBuffer("tipo"));
	}
	
   
}


function oficial_generarTabla()
{	
    
	this.iface.COL_TIPO = 0;
	this.iface.COL_INCLUIR = 1;
	var util:FLUtil = new FLUtil;
	
	this.iface.tblTipo.setNumCols(2);
	this.iface.tblTipo.setColumnWidth(this.iface.COL_TIPO, 220);
	this.iface.tblTipo.setColumnWidth(this.iface.COL_INCLUIR, 60);
	this.iface.tblTipo.setColumnLabels("/", "Tipo de vehículo/Incluir");
	
	
	var curTipo:FLSqlCursor = new FLSqlCursor("vld_equipamientotipo");
	var util:FLUtil = new FLUtil;
	var fila:Number;
	var equipamiento:String = this.child("fdbequipamiento").value();
	var numFilas:Number = this.iface.tblTipo.numRows();
	for (fila = 0; fila < numFilas; fila++)
		this.iface.tblTipo.removeRow(0);
	
	if(!curTipo.select("equipamiento  = '" + equipamiento + "'"))
	   return;
	while (curTipo.next()) {
		curTipo.setModeAccess(curTipo.Browse);
		curTipo.refreshBuffer();
		var numLinea:Number = this.iface.tblTipo.numRows();
		this.iface.tblTipo.insertRows(numLinea);
		this.iface.tblTipo.setText(numLinea, this.iface.COL_INCLUIR, "Si");
		this.iface.tblTipo.setText(numLinea, this.iface.COL_TIPO, curTipo.valueBuffer("tipo"));
	}
	
}











































































