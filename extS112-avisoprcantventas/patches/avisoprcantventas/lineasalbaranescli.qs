
/** @class_declaration avisoPrcAntVentas */
/////////////////////////////////////////////////////////////////
//// AVISO PRECIO ANTERIOR EN VENTAS ////////////////////////////
class avisoPrcAntVentas extends dtosCompletosCli /** %from: oficial */
{
  function avisoPrcAntVentas(context)
  {
    dtosCompletosCli(context);
  }

  function validateForm(): Boolean {
    return this.ctx.avisoPrcAntVentas_validateForm();
  }

}

/** @class_definition avisoPrcAntVentas */
/* Avisa se ao mesmo cliente se lle vendeu anteriormente a outro precio e cando foi */
/////////////////////////////////////////////////////////////////
//// AVISO PRECIO ANTERIOR EN VENTAS ////////////////////////////


function avisoPrcAntVentas_validateForm(): Boolean {
  debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  avisoPrcAntVentas_validateForm   <<<<<<<<<<<<<<<<<<<<<<<<");

    if (!this.iface.__validateForm())
		return false;

	var util: FLUtil = new FLUtil();
	var cursor: FLSqlCursor = this.cursor();

	var codCliente: String = cursor.cursorRelation().valueBuffer("codcliente")

	if (!cursor.valueBuffer("referencia") || !codCliente) {
		debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  LINEASALBARANESCLI.QS avisoPrcAntVentas_validateForm saímmos sen facer nada ao non existir articulo ou cliente");
		return true
	}


	var qryAlbaranes:FLSqlQuery = new FLSqlQuery();
	var pvpAnterior:Number = "0";
	var pvpActual: Number = cursor.valueBuffer("pvpunitario");
	var mensaxe:String;

	qryAlbaranes.setTablesList("lineasalbaranescli,albaranescli");
	qryAlbaranes.setSelect("l.pvpunitario,l.cantidad,l.referencia, a.fecha, a.codigo, a.nombrecliente");
	qryAlbaranes.setFrom("lineasalbaranescli l inner join albaranescli a on a.idalbaran = l.idalbaran ");
	qryAlbaranes.setWhere("l.referencia = '" + cursor.valueBuffer("referencia") + "' AND a.codcliente = '" + codCliente + "'");
	qryAlbaranes.setOrderBy(" a.fecha desc, a.hora desc ");

	if (qryAlbaranes.exec()) {

		if(!qryAlbaranes.next()) {
			//** Por se queremos avisar de que é a primeira venta de este artigo **/
			//debug(">>>>>>>>> LINEASALBARANESCLI.QS avisoPrcAntVentas_validateForm NO HAY ALBARANES con el articulo " + cursor.valueBuffer("referencia")  );
			mensaxe = "Es la primera venta realizada del artículo " + cursor.valueBuffer("referencia") + "\n";
			mensaxe = mensaxe + "para el cliente " + codCliente + " - " + cursor.cursorRelation().valueBuffer("nombrecliente") + " \n";
			mensaxe = mensaxe + "el precio actual es " + pvpActual + "\n\n";
			mensaxe = mensaxe + "¿Deseas continuar con el precio actual o revisar de nuevo esta primera venta?";


			var res = MessageBox.warning(util.translate("scripts", mensaxe), MessageBox.Yes, MessageBox.No);

			if (res == MessageBox.No) {
				return false;
			}


		} else {
			pvpAnterior = qryAlbaranes.value("l.pvpunitario");
			var fechaAnterior:Date = qryAlbaranes.value("a.fecha");

			if (pvpAnterior != pvpActual) {
				mensaxe = "Se econtró una venta anterior del artículo " + cursor.valueBuffer("referencia") + "\n";
				mensaxe = mensaxe + "para el cliente " + codCliente + " - " + qryAlbaranes.value("a.nombrecliente") + " \n";
				mensaxe = mensaxe + "en el albarán " + qryAlbaranes.value("a.codigo") + " con fecha de " + fechaAnterior + "\n";
				mensaxe = mensaxe + "el precio anterior es " + pvpAnterior + " y el precio actual " + pvpActual + "\n\n";
				mensaxe = mensaxe + "¿Deseas continuar con el precio actual?\n(en caso negativo se actualizará por precio anterior)";

				var res = MessageBox.warning(util.translate("scripts", mensaxe), MessageBox.Yes, MessageBox.No);

				if (res == MessageBox.No) {
					cursor.setValueBuffer("pvpunitario",pvpAnterior);
					return false;
				}
			}
		}
	}

	return true;

}


/*
function avisoPrcAntVentas_commonBufferChanged(fN: String, miForm: Object)
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = miForm.cursor();
    var avisaremos: Boolean = false;
	var pvpAnterior: Number = 0;



	debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>> avisoPrcAntVentas  commonBufferChanged <<<<<<<<<<<<<<<<<<<<<<<<");
/*
	switch (fN) {
		case "pvpunitario":{
			debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>> avisoPrcAntVentas CAMBIANDO pvpunitario <<<<<<<<<<<<<<<<<<<<<<<<");

			var qryAlbaranes:FLSqlQuery = new FLSqlQuery();
			var pvpAnterior:Number = "0";
			var pvpActual: Number = cursor.calueBuffer("pvpunitario");

			/*qryAlbaranes.setTablesList("lineasalbaranescli,albaranescli");
			qryAlbaranes.setSelect("l.pvptotal,l.cantidad");
			qryAlbaranes.setFrom("lineasalbaranescli l inner join albaranescli a on a.idalbaran = l.idalbaran ");
			qryAlbaranes.setWhere("l.referencia = '" + cursor.valueBuffer("referencia") + "'");
			qryAlbaranes.setOrderBy(" a.fecha desc, a.hora desc ");

			if (qryAlbaranes.exec()) {

				if(!qryAlbaranes.next()) {
					debug(">>>>>>>>>>>>>> NO HAY ALBARANES con el articulo " + cursor.valueBuffer("referencia")  );
					//MessageBox.warning(util.translate("scripts", "No se encontraron albaranes de compra con el artículo '" + cursor.valueBuffer("referencia") + "'"), MessageBox.Ok, MessageBox.NoButton);
				} else {
					pvpAnterior = qryAlbaranes.value("l.pvpunitario");

					if (pvpAnterior <> pvpActual) {
						MessageBox.warning(util.translate("scripts", "Se encontró una venta anterior '" + cursor.valueBuffer("referencia") + "'"), MessageBox.Ok, MessageBox.NoButton);
					}

					//cursor.setValueBuffer("pvp",pvpUnitarioFinal);
				}
			}
			*/



//// AVISO PRECIO ANTERIOR EN VENTAS ////////////////////////////
/////////////////////////////////////////////////////////////////

