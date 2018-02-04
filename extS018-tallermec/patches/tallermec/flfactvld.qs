/***************************************************************************
                 flfactvld.qs  -  description
                             -------------------
    begin                : 2011
    copyright            : 2011 SIAGAL
    email                : jaller@siagal.com
 ***************************************************************************/
/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

/** @file */

/** @class_declaration interna */
////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
class interna {
    var ctx:Object;
    function interna( context ) { this.ctx = context; }
	function afterCommit_servicioscli(curServicio:FLSqlCursor):Boolean{
	    return this.ctx.interna_afterCommit_servicioscli(curServicio);
	}
	function afterCommit_lineasservicioscli(curLS:FLSqlCursor):Boolean{
	    return this.ctx.interna_afterCommit_lineasservicioscli(curLS);
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var curReciboCli:FLSqlCursor;
    function oficial( context ) { interna( context ); }

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



/* Al pasalr el servicio a un albarán, las cantidades de Stock no se restarán en el albarán*/
function interna_afterCommit_servicioscli(curServicio:FLSqlCursor):Boolean
{
    var idServicio:Number;
    var referencia:String;
    var curLineas:FLSqlCursor = new FLSqlCursor("lineasservicioscli");
    var curAlmacen:FLSqlCursor = new FLSqlCursor("stocks");
    var cantidad:Number;
    //MessageBox.warning("siagal_afterCommit_servicioscli. \n Cousas de Stock.", MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
   
  
    switch (curServicio.modeAccess()){
    case curServicio.Del:{
	    break;
	}
    case curServicio.Edit:{
	    if(curServicio.valueBuffer("editable")==false){
		idServicio = curServicio.valueBuffer("idservicio");
		curLineas.select("idservicio = " + idServicio);
		while (curLineas.next()){
		    curLineas.setModeAccess(curLineas.Browse);
		    curLineas.refreshBuffer();
		    referencia = curLineas.valueBuffer("referencia");
		    curAlmacen.select("referencia = '" + referencia + "'");
			if(curAlmacen.first()){
			curAlmacen.setModeAccess(curAlmacen.Edit);
			curAlmacen.refreshBuffer();
			cantidad = curAlmacen.valueBuffer("cantidad") + curLineas.valueBuffer("cantidad");
			curAlmacen.setValueBuffer("cantidad", cantidad);
			curAlmacen.setValueBuffer("disponible", cantidad);
			curAlmacen.commitBuffer();
		    }
		    }
	    }
	    break;
	}
    case curServicio.Insert:{
	    break;
	}
    case curServicio.Browse:{
	    break;
	}
	    
    }

    return true;
}


/* Se sumará o se restará la cantidad de Stock del produto según la operación realizada */
function interna_afterCommit_lineasservicioscli(curLS:FLSqlCursor):Boolean
{
    var referencia:String;
    var cantidad:Number;
    var curAlmacen:FLSqlCursor = new FLSqlCursor("stocks");
    //MessageBox.warning("siagal_afterCommit_lineasservicioscli. \n Calculo de Stock.", MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
  
     switch (curLS.modeAccess()){
    case curLS.Del:{
	debug("interna_afterCommit_lineasservicioscli:  CURSOR EN DELETE");
	    referencia = curLS.valueBuffer("referencia");
	    curAlmacen.select("referencia = '" + referencia + "'");
	    if(curAlmacen.first()){
		curAlmacen.setModeAccess(curAlmacen.Edit);
		curAlmacen.refreshBuffer();
		cantidad = curAlmacen.valueBuffer("cantidad");
		cantidad = cantidad + curLS.valueBuffer("cantidad");
		curAlmacen.setValueBuffer("cantidad", cantidad);
		curAlmacen.setValueBuffer("disponible", cantidad);
		curAlmacen.commitBuffer();
	    }  
	    break;
	}
    case curLS.Insert:{
	debug("interna_afterCommit_lineasservicioscli:  CURSOR EN INSERT");
	     break;
	 }
    case curLS.Edit:{;
	debug("interna_afterCommit_lineasservicioscli:  CURSOR EN EDIT");
	    break;
	}
    }
     return true;
}





//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////



//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
////////////////////////////////////////////////////

