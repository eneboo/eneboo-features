
/** @class_declaration serieLocalCli */
/////////////////////////////////////////////////////////////////
//// SERIE LOCAL Cli/////////////////////////////////////////////
class serieLocalCli extends bloqDocImpr /** %from: bloqDocImpr */
{
  function serieLocalCli(context)
  {
    bloqDocImpr(context);
  }
  function init()
  {
    return this.ctx.serieLocalCli_init();
  }

  function bufferChanged(fN: String)
  {
    return this.ctx.serieLocalCli_bufferChanged(fN);
  }
}
//// SERIE LOCAL Cli/////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition serieLocalCli */
/////////////////////////////////////////////////////////////////
//// SERIE LOCAL Cli ////////////////////////////////////////////

function serieLocalCli_init()
{

	this.iface.__init();

	var util:FLUtil = new FLUtil();
	var cursor: FLSqlCursor = this.cursor();

	var codSerieLocalCli: String = util.readSettingEntry("scripts/flfactinfo/serielocalcli");
	//debug("codSERIELocalCli: " + codSerieLocalCli);

	if (this.child("fdbCodSerie") && codSerieLocalCli != ".") {
		if (cursor.modeAccess() == cursor.Insert)
			this.child("fdbCodSerie").setValue(codSerieLocalCli);

		if (cursor.modeAccess() == cursor.Edit)
			this.child("fdbCodSerie").setDisabled(true);
	}

}


function serieLocalCli_bufferChanged(fN: String)
{

	//Esta función faise necesaria porque cando fai co cambio de cliente vai relacionado co campo no formulario e cambia o código
	this.iface.__bufferChanged(fN);

	var util:FLUtil = new FLUtil();
	var cursor: FLSqlCursor = this.cursor();
	var codSerieLocalCli: String = util.readSettingEntry("scripts/flfactinfo/serielocalcli");


	switch (fN) {

		case "codcliente": {
			this.child("fdbCodDir").setValue("0");
			this.child("fdbCodDir").setValue(this.iface.calculateField("coddir"));
			flfacturac.iface.pub_avisarObservacionesCliente(cursor.valueBuffer("codcliente"));


			if (codSerieLocalCli != ".") {
				if (codSerieLocalCli !=  this.child("fdbCodSerie").value())
						MessageBox.information(util.translate("scripts", "Hay definida una serie local para clientes, la serie actual será cambiada."), MessageBox.Ok, MessageBox.NoButton);

				if (cursor.modeAccess() == cursor.Insert)
					this.child("fdbCodSerie").setValue(codSerieLocalCli);

				//debug(">>>> Serie Local");
				break;

			} else {
				//Se ten o . quere dicir que a define os parámetros de empresa e manda o do cliente se o ten
				var nuevaSerie:String = util.sqlSelect("clientes", "codserie", "codcliente = '" + this.child("fdbCodCliente").value() + "'");

				if (codSerieLocalCli !=  nuevaSerie)
						MessageBox.information(util.translate("scripts", "Hay definida una serie diferente en el cliente, la serie actual será cambiada."), MessageBox.Ok, MessageBox.NoButton);

				this.child("fdbCodSerie").setValue(nuevaSerie);
				//debug(">>>> Serie do Cliente");



			}
		}
	}

}


//// SERIE LOCAL Cli/////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

