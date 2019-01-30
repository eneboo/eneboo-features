
/** @class_declaration serieLocalCli */
/////////////////////////////////////////////////////////////////
//// Serie Local Cli ////////////////////////////////////////////
class serieLocalCli extends bloqDocImpr /** %from: oficial */
{
  function serieLocalCli(context)
  {
    bloqDocImpr(context);
  }
  function init()
  {
    return this.ctx.serieLocalCli_init();
  }
  function cambiarSerieLocalCli()
  {
    return this.ctx.serieLocalCli_cambiarSerieLocalCli();
  }

}
//// Serie Local Cli//////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition serieLocalCli */
/////////////////////////////////////////////////////////////////
//// SERIE LOCAL CLI ////////////////////////////////////////////
function serieLocalCli_init()
{
  this.iface.__init();

  var util: FLUtil = new FLUtil();
  this.child("lblSerieLocalCli").text = util.readSettingEntry("scripts/flfactinfo/serielocalcli");
  connect(this.child("pbnCambiarSerieLocalCli"), "clicked()", this, "iface.cambiarSerieLocalCli");

  var nombreSerieLocalCli: String = "No usar serie local, usar la de empresa";

  if (this.child("lblSerieLocalCli").text != ".")
	nombreSerieLocalCli = util.sqlSelect("series", "descripcion", "codserie = '" + this.child("lblSerieLocalCli").text + "'");

  if (nombreSerieLocalCli != "")
    this.child("lblNombreSerieLocalCli").text = nombreSerieLocalCli;

}

function serieLocalCli_cambiarSerieLocalCli()
{
  var util: FLUtil = new FLUtil();
  var qry: FLSqlQuery = new FLSqlQuery();
  var opciones = [];
  var primeiraOpcion: String = "."
  var codSerieLocalCli: String = "";
  var nombreSerieLocalCli: String = "";



  qry.setTablesList("series");
  qry.setSelect("codserie,descripcion");
  qry.setFrom("series");
  qry.setWhere("1=1");
  if (!qry.exec())
    return false;


  var i: Number = 0;

  opciones[i] = ".";


  while (qry.next())
  {
    //debug(qry.value("codserie") + " - " + qry.value("descripcion"));

    i = i + 1
    opciones[i] = qry.value("codserie");

  }



  codSerieLocalCli = Input.getItem(util.translate("scripts", "Serie Local Clientes:"), opciones, primeiraOpcion, false);



  if (!codSerieLocalCli) {
    return;
  }

  this.child("lblSerieLocalCli").text = codSerieLocalCli;
  util.writeSettingEntry("scripts/flfactinfo/serielocalcli", codSerieLocalCli);



  var nombreSerieLocalCli: String = "";

  if (codSerieLocalCli == ".") {
		nombreSerieLocalCli = "No usar serie local, usar la de empresa";
	} else {
  		nombreSerieLocalCli = util.sqlSelect("series", "descripcion", "codserie = '" + codSerieLocalCli + "'");
  	}

  if (nombreSerieLocalCli != "")
	 this.child("lblNombreSerieLocalCli").text = nombreSerieLocalCli;



}

//// SERIE LOCAL CLI ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

