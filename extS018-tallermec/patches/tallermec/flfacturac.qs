
/** @class_declaration siagal */
/////////////////////////////////////////////////////////////////
//// SIAGAL  ////////////////////////////////////////////////////
class siagal extends cambioIva {
	function siagal( context ) { cambioIva( context ); }

	function afterCommit_albaranescli(curAlbaran:FLSqlCursor):Boolean {
		return this.ctx.siagal_afterCommit_albaranescli(curAlbaran);
	    }

}

//// SIAGAL  ////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition siagal */
/////////////////////////////////////////////////////////////////
//// SIAGAL /////////////////////////////////////////////////


/** \C Si el albarán se borra se actualizan los pedidos asociados
\end */
/* Si el albarán procede de un servicio, lac antidad del Stock al borrar el albarán no se volverá a sumar*/
/* Modificado de una función de ISOLIX */
function siagal_afterCommit_albaranescli(curAlbaran:FLSqlCursor):Boolean
{

	if (!this.iface.__afterCommit_albaranescli(curAlbaran)) {
		return false;
	}



    var util:FLUtil = new FLUtil();
    var cantidad:Number;
    var curServicio:FLSqlCursor = new FLSqlCursor("servicioscli");
    var curLineas:FLSqlCursor = new FLSqlCursor("lineasservicioscli");
    var curAlmacen:FLSqlCursor = new FLSqlCursor("stocks");
    var idAlbaran:Number;
	//MessageBox.warning(util.translate("scripts", "iso_afterCommit_albaranescli. \n"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
    if (!this.iface.__afterCommit_albaranescli(curAlbaran)) {
		MessageBox.warning(util.translate("scripts", "after comit FALSE"));
		return false;
	}
     switch (curAlbaran.modeAccess()){
	    case curAlbaran.Del:{
			// MessageBox.warning(util.translate("scripts", "iso_afterCommit_albaranescli. \n Borrando albarán."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);

			 idAlbaran = curAlbaran.valueBuffer("idalbaran");
			 //var idservicio:Number = util.sqlSelect("servicioscli", "idservicio", "idalbaran = " + idAlbaran);
			 curServicio.select("idalbaran = " + idAlbaran);
			 if(curServicio.first()){
			 var idservicio:Number = curServicio.valueBuffer("idservicio");
			 curServicio.setUnLock("editable", true);
			 debug ("Borrar albaran del servicio: " + idservicio);



			 if(curLineas.select("idservicio = " +idservicio)){
				 while (curLineas.next()){
				 curLineas.setModeAccess(curLineas.Browse);
				 curLineas.refreshBuffer();
				 var referencia:String = curLineas.valueBuffer("referencia");
				   curAlmacen.select("referencia = '" + referencia + "'");
				   if(curAlmacen.first()){
					   curAlmacen.setModeAccess(curAlmacen.Edit);
					   curAlmacen.refreshBuffer();
					   cantidad = curAlmacen.valueBuffer("cantidad") - curLineas.valueBuffer("cantidad");
					   curAlmacen.setValueBuffer("cantidad", cantidad);
					   curAlmacen.setValueBuffer("disponible", cantidad);
					   curAlmacen.commitBuffer();
				   }

				 }

			 }

			 }
			 break;
		}




     }

	return true;

}

//// SIAGAL /////////////////////////////////////////////////
//////////////////////////////////////////////////////////////

