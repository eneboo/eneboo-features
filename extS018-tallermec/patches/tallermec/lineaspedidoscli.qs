
/** @class_declaration siagal */
/////////////////////////////////////////////////////////////////
//// SIAGAL  ////////////////////////////////////////////////////
class siagal extends oficial {
	function siagal( context ) { oficial( context ); }

	function datosTablaPadre(cursor:FLSqlCursor):Array {
		return this.ctx.siagal_datosTablaPadre(cursor);
	}
}

//// SIAGAL  ////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition siagal */
/////////////////////////////////////////////////////////////////
//// SIAGAL /////////////////////////////////////////////////////

/* SUSTITUIMOS A LA PRINCIPAL */


/** \D Devuelve la tabla padre de la tabla parámetro, así como la cláusula where necesaria para localizar el registro padre
@param	cursor: Cursor cuyo padre se busca
@return	Array formado por:
	* where: Cláusula where
	* tabla: Nombre de la tabla padre
o false si hay error
\end */
function siagal_datosTablaPadre(cursor:FLSqlCursor):Array
{
	var datos:Array;
	switch (cursor.table()) {
		case "lineaspresupuestoscli": {
			datos.where = "idpresupuesto = "+ cursor.valueBuffer("idpresupuesto");
			datos.tabla = "presupuestoscli";
			break;
		}
		case "lineaspedidoscli": {
			datos.where = "idpedido = "+ cursor.valueBuffer("idpedido");
			datos.tabla = "pedidoscli";
			break;
		}
		case "lineasalbaranescli": {
			datos.where = "idalbaran = "+ cursor.valueBuffer("idalbaran");
			datos.tabla = "albaranescli";
			break;
		}
		case "lineasfacturascli": {
			datos.where = "idfactura = "+ cursor.valueBuffer("idfactura");
			datos.tabla = "facturascli";
			break;
		}
		// SIAGAL SERVICIOS
		case "lineasservicioscli": {
			datos.where = "idservicio = "+ cursor.valueBuffer("idservicio");
			datos.tabla = "servicioscli";
			break;
		}
	}
	var curRel:FLSqlCursor = cursor.cursorRelation();
	if (curRel && curRel.table() == datos.tabla) {
		datos["tasaconv"] = curRel.valueBuffer("tasaconv");
		datos["codcliente"] = curRel.valueBuffer("codcliente");
		datos["fecha"] = curRel.valueBuffer("fecha");
		datos["codserie"] = curRel.valueBuffer("codserie");
		datos["porcomision"] = curRel.valueBuffer("porcomision");
		datos["codagente"] = curRel.valueBuffer("codagente");
	} else {
		var qryDatos:FLSqlQuery = new FLSqlQuery;
		qryDatos.setTablesList(datos.tabla);
		qryDatos.setSelect("tasaconv, codcliente, fecha, codserie, porcomision, codagente");
		qryDatos.setFrom(datos.tabla);
		qryDatos.setWhere(datos.where);
		qryDatos.setForwardOnly(true);
		if (!qryDatos.exec()) {
			return false;
		}
		if (!qryDatos.first()) {
			return false;
		}
		datos["tasaconv"] = qryDatos.value("tasaconv");
		datos["codcliente"] = qryDatos.value("codcliente");
		datos["fecha"] = qryDatos.value("fecha");
		datos["codserie"] = qryDatos.value("codserie");
		datos["porcomision"] = qryDatos.value("porcomision");
		datos["codagente"] = qryDatos.value("codagente");
	}
	return datos;
}

//// SIAGAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

