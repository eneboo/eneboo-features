/***************************************************************************
                                 ordercols.qs
                            -------------------
   begin                : 03-01-2019
   copyright            : Siagal
   email                : jaller@ssiagal.com
***************************************************************************/
/***************************************************************************
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; version 2 of the License.               *
 ***************************************************************************/
/***************************************************************************
   Este  programa es software libre. Puede redistribuirlo y/o modificarlo
   bajo  los  t�rminos  de  la  Licencia  P�blica General de GNU   en  su
   versi�n 2, publicada  por  la  Free  Software Foundation.
 ***************************************************************************/

////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
class interna {
	var ctx:Object;
	function interna( context ) { this.ctx = context; }
	function init() { this.ctx.interna_init(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var tbnObjectName:Object;
	function oficial( context ) { interna( context ); } 
	function setObjectName() {
		return this.ctx.oficial_setObjectName();
	}
	function aplicarOrden(cursor:FLSqlCursor):Array {
		return this.ctx.oficial_aplicarOrden(cursor);
	}
	function aplicarAnchos(cursor:FLSqlCursor):Array {
		return this.ctx.oficial_aplicarAnchos(cursor);
	}
	function ascendenteDescendente(cursor:FLSqlCursor):Number {
		return this.ctx.oficial_ascendenteDescendente(cursor);
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends oficial {
	function head( context ) { oficial ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
	function ifaceCtx( context ) { head( context ); }
	function pub_aplicarOrden(cursor:FLSqlCursor):Array {
		return this.aplicarOrden(cursor);
	}
	function pub_aplicarAnchos(cursor:FLSqlCursor):Array {
	    return this.aplicarAnchos(cursor);
	}
	function pub_ascendenteDescendente(cursor:FLSqlCursor):Number {
	    return this.ascendenteDescendente(cursor);
	}
	
}

const iface = new ifaceCtx( this );
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////

/** \C 
\end */
function interna_init()
{
	this.iface.tbnObjectName = this.child("tbnObjectName");
	connect(this.iface.tbnObjectName, "clicked()", this, "iface.setObjectName");
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_setObjectName()
{
	var idPrueba:Array = new Array();
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil;
	var idModulo:String = cursor.valueBuffer("idmodule");
	var where:String = "";
	var valor:String = "";
	
	var curLista:FLSqlCursor = new FLSqlCursor("flfiles");
	if (idModulo && idModulo != "")
		where = "idmodulo = '" + idModulo + "' AND ";
	where += "nombre LIKE '%.mtd'";
	curLista.select(where);
	var i:Number = 0;
	while (curLista.next()){
		curLista.setModeAccess(curLista.Browse);
		curLista.refreshBuffer();
		idPrueba[i++] = curLista.valueBuffer("nombre");
	}
	var name:String = Input.getItem(util.translate("scripts", "Seleccione la tabla"), idPrueba, false, "opcion");
	if (!name)
		return;
		
	for (var i:Number = 0; (name.toString().charAt(i) != "."); i++) {
		valor += name.toString().charAt(i);
	}

	if (!valor)
		return;

	this.child("fdbNombre").setValue(valor);


	// Establecemos el valor de campos con el orden 
	// actual de la tabla
	var curTabla:FLSqlCursor = new FLSqlCursor(valor);
	var fieldList:String = util.nombreCampos(curTabla.table());
	// Construimos la cadena
	var campo:String;
	var cuenta:Number = parseFloat(fieldList[0]);
	var n:Number = 6;
	for (var i:Number = 1; i <= cuenta; i++) {
		if(i==cuenta){
			campo += fieldList[i];
		} else {
			campo += fieldList[i] + ",";
		}
		n = n - 1;
		if(n == 0){
			campo += "\n";
			n = 6;
		}
	}
	this.child("fdbCamposTabla").setValue(campo);

}

/** \D Aplica el orden establecido en el master que llame a la funci�n
@return	Cadena con el orden de columnas
\end */
function oficial_aplicarOrden(cursor:FLSqlCursor):Array
{
	var util:FLUtil = new FLUtil();
	var tabla:String = cursor.table();
	var whereUsuario:String;

	var orderTable:String = util.sqlSelect("ordercols","nombre","nombre = '" + tabla + "' AND iduser = '" + sys.nameUser() + "'");
	
	//Se non se topa por usuario se po�en as  xen�ricas
	if (!orderTable || orderTable == "" ) {
		orderTable = util.sqlSelect("ordercols","nombre","nombre = '" + tabla + "'");
		whereUsuario = "";
	} else {
		whereUsuario = " AND iduser = '" + sys.nameUser() + "'";
	}
	
	
	
	var campos:String;
	var orden:Array = [];

	if (orderTable) {
		campos = util.sqlSelect("ordercols","campos","nombre = '" + tabla + "'" + whereUsuario);
		orden = campos.split(",");
	}

	return orden;
}



/** \D Aplica los anchos establecidos en el master que llame a la funci�n
@return	Cadena con el orden de columnas
\end */
function oficial_aplicarAnchos(cursor:FLSqlCursor):Array
{
	var util:FLUtil = new FLUtil();
	var tabla:String = cursor.table();
	var whereUsuario:String;

	var orderTable:String = util.sqlSelect("ordercols","nombre","nombre = '" + tabla + "' AND iduser = '" + sys.nameUser() + "'");
	
	//Se non se topa por usuario se po�en as  xen�ricas
	if (!orderTable || orderTable == "" ) {
		orderTable = util.sqlSelect("ordercols","nombre","nombre = '" + tabla + "'");
		whereUsuario = "";
	} else {
		whereUsuario = " AND iduser = '" + sys.nameUser() + "'";
	}
	
	var anchos:String;
	var anchosOrdenados:Array = [];
	if (orderTable) {
		anchos = util.sqlSelect("ordercols","anchos","nombre = '" + tabla + "'" + whereUsuario);
		anchosOrdenados = anchos.split(",");
	}

	return anchosOrdenados;
}

/** \D Decide si se establece orden ascendente o descentente en la primera columna
@return	Cadena con el orden de columnas
\end */
function oficial_ascendenteDescendente(cursor:FLSqlCursor):Number
{
	var util:FLUtil = new FLUtil();
	var tabla:String = cursor.table();
	var whereUsuario:String;
	var descendente:Boolean;
	
	
	var orderTable:String = util.sqlSelect("ordercols","nombre","nombre = '" + tabla + "' AND iduser = '" + sys.nameUser() + "'");
	
	//Se non se topa por usuario se po�en as  xen�ricas
	if (!orderTable || orderTable == "" ) {
		whereUsuario = "";
	} else {
		whereUsuario = " AND iduser = '" + sys.nameUser() + "'";
	}
	

	descendente = util.sqlSelect("ordercols","descendente","nombre = '" + tabla + "' " + whereUsuario);
	
	//debug(">>>>>>>>>>> SIAGAL ordercols.qs oficial_ascendenteDescendente descendente: " + descendente);
	
	
	if (descendente) {
			return 0;
	} else {
			return 1;
	}
	
}



//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
