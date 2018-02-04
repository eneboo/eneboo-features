
/** @class_declaration funServiciosCli */
//////////////////////////////////////////////////////////////////
//// FUN_SERVICIOS_CLI /////////////////////////////////////////////////////
class funServiciosCli extends envioMail {
	function funServiciosCli( context ) { envioMail( context ); }
	function init() {
		return this.ctx.funServiciosCli_init();
	}
	function imprimirServ() {
		return this.ctx.funServiciosCli_imprimirServ();
	}
}
//// FUN_SERVICIOS_CLI /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition funServiciosCli */
/////////////////////////////////////////////////////////////////
//// FUN_SERVICIOS_CLI /////////////////////////////////////////////////

function funServiciosCli_init()
{
	this.iface.__init();
	connect(this.child("toolButtonPrintServ"), "clicked()", this, "iface.imprimirServ");
}

function funServiciosCli_imprimirServ()
{
    var util:FLUtil = new FLUtil();
      var cursor:FLSqlCursor = this.cursor();
      var idAlbaran:Number;
     idAlbaran = util.sqlSelect("albaranescli", "idalbaran", "codigo= '" + this.cursor().valueBuffer("codigo") + "'");
      var curLineaAlbaran:FLSqlCursor = new FLSqlCursor("lineasalbaranescli");
      var curLineaObra:FLSqlCursor = new FLSqlCursor("lineasalbaobra");
      if(!curLineaObra.select("idalbaran = "+ idAlbaran + " OR idalbaran <> "+ idAlbaran))
	  return false;
	while (curLineaObra.next()) {
		curLineaObra.setModeAccess(curLineaObra.Del);
		curLineaObra.refreshBuffer();
		if(!curLineaObra.commitBuffer())
		    return false;

  }
      if(!curLineaAlbaran.select("idalbaran = " + idAlbaran + " AND (codfamilia <> 'MO' OR codfamilia is null)"))
	  return false;
      while (curLineaAlbaran.next()) {
	  curLineaAlbaran.setModeAccess(curLineaAlbaran.Browse);
	  curLineaAlbaran.refreshBuffer();
	  curLineaObra.setModeAccess(curLineaObra.Insert);
	  curLineaObra.refreshBuffer();
	  debug ("Vamos a la lineaobra");
	  with(curLineaObra) {
		setValueBuffer("idlinea", curLineaAlbaran.valueBuffer("idlinea"));
		setValueBuffer("idalbaran", curLineaAlbaran.valueBuffer("idalbaran"));
		setValueBuffer("referencia", curLineaAlbaran.valueBuffer("referencia"));
		setValueBuffer("descripcion", curLineaAlbaran.valueBuffer("descripcion"));
		setValueBuffer("pvpunitario", curLineaAlbaran.valueBuffer("pvpunitario"));
		setValueBuffer("pvpsindto", curLineaAlbaran.valueBuffer("pvpsindto"));
		setValueBuffer("cantidad", curLineaAlbaran.valueBuffer("cantidad"));
		setValueBuffer("pvptotal", curLineaAlbaran.valueBuffer("pvptotal"));
		setValueBuffer("codimpuesto", curLineaAlbaran.valueBuffer("codimpuesto"));
		setValueBuffer("iva", curLineaAlbaran.valueBuffer("iva"));
		setValueBuffer("recargo", curLineaAlbaran.valueBuffer("recargo"));
		setValueBuffer("irpf", curLineaAlbaran.valueBuffer("irpf"));
		setValueBuffer("dtolineal", curLineaAlbaran.valueBuffer("dtolineal"));
		setValueBuffer("dtopor", curLineaAlbaran.valueBuffer("dtopor"));
		setValueBuffer("porcomision", curLineaAlbaran.valueBuffer("porcomision"));
		setValueBuffer("kilometros", curLineaAlbaran.valueBuffer("kilometros"));
		setValueBuffer("proximocambio", curLineaAlbaran.valueBuffer("proximocambio"));
		setValueBuffer("codfamilia", curLineaAlbaran.valueBuffer("codfamilia"));
		curLineaObra.commitBuffer();
		}

	  }

   if (sys.isLoadedModule("flfactinfo")) {
		if (!this.cursor().isValid())
				return;
		var codigo:String = this.cursor().valueBuffer("codigo");
		var curImprimir:FLSqlCursor = new FLSqlCursor("i_albaranescli");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("d_albaranescli_codigo", codigo);
		curImprimir.setValueBuffer("h_albaranescli_codigo", codigo);
		flfactinfo.iface.pub_lanzarInforme(curImprimir, "i_albaranescli_serv");
	} else
		flfactppal.iface.pub_msgNoDisponible("Informes");
}


//// FUN_SERVICIOS_CLI ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////

