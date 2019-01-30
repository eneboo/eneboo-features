
/** @class_declaration avisoObs */
/////////////////////////////////////////////////////////////////
//// AVISO DE OBSERVACIONES /////////////////////////////////////
class avisoObs extends serieLocalCli /** %from: oficial */
{
  function avisoObs(context)
  {
    serieLocalCli(context);
  }
  function init()
  {
    return this.ctx.avisoObs_init();
  }
  function bufferChanged(fN: String)
  {
    return this.ctx.avisoObs_bufferChanged(fN);
  }

}
//// AVISO DE OBSERVACIONES /////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition avisoObs */
/////////////////////////////////////////////////////////////////
//// AVISO DE OBSERVACIONES /////////////////////////////////////

function avisoObs_init()
{

	this.iface.__init();

	var util:FLUtil = new FLUtil();
	var cursor: FLSqlCursor = this.cursor();



	if (this.child("txtLblObservaciones")) {
		this.child("txtLblObservaciones").setShown((cursor.valueBuffer("observaciones") != ""));
	}

/*
	if (cursor.valueBuffer("observaciones") != "") {

		this.child("txtLblObservaciones").setShown(true);

	} else {
		this.child("txtLblObservaciones").setShown(false);
	}
*/

}


function avisoObs_bufferChanged(fN: String)
{

	this.iface.__bufferChanged(fN);


	var cursor: FLSqlCursor = this.cursor();

	var resultado: Boolean = false;


	switch (fN) {

		case "observaciones": {

			if (cursor.valueBuffer("observaciones") && cursor.valueBuffer("observaciones") != "")  {
				resultado = true
			}


			//debug ("OBSERVACONES: " + cursor.valueBuffer("observaciones"));

		}
	}

	if (this.child("txtLblObservaciones")) {
		this.child("txtLblObservaciones").setShown(resultado);
	}


}


//// AVISO DE OBSERVACIONES /////////////////////////////////////
/////////////////////////////////////////////////////////////////

