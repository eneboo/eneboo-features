
/** @class_declaration jpluginLanza */
//////////////////////////////////////////////////////////////
//// JPLUGINLANZA ////////////////////////////////////////////
class jpluginLanza extends jasperPlugin /** %from: jasperPlugin */
{
  function jpluginLanza(context)
  {
    jasperPlugin(context);
  }

  function lanzaInforme(cursor, oParam)
  {
    return this.ctx.jpluginLanza_lanzaInforme(cursor, oParam);
  }

}
//// JPLUGINLANZA ////////////////////////////////////////////
//////////////////////////////////////////////////////////////

/** @class_definition jpluginLanza */
/////////////////////////////////////////////////////////////////
//// JPLUGINLANZA ///////////////////////////////////////////////



function jpluginLanza_lanzaInforme(cursor, oParam)
{


	////debug("SIAGAL >>>>>>>> flfactinfo.qs jpluginLanza_lanzaInforme");

    var nombreInforme = oParam.nombreInforme;
    var orderBy = oParam.orderBy;
    var groupBy = oParam.groupBy;
    var etiquetas = oParam.etiquetas;
    var impDirecta = oParam.impDirecta;
    var whereFijo = oParam.whereFijo;
    var nombreReport = oParam.nombreReport;
    var numCopias = oParam.numCopias;
    var datosPdf = oParam.datosPdf;
    var limit = oParam.limit;
    var nombreCx = oParam.nombreCx;

	//debug("SIAGAL >>>>>>>> flfactinfo.qs jpluginLanza_lanzaInforme  nombreInforme: " + nombreInforme);
	//debug("SIAGAL >>>>>>>> flfactinfo.qs jpluginLanza_lanzaInforme  orderBy: " + orderBy);
	//debug("SIAGAL >>>>>>>> flfactinfo.qs jpluginLanza_lanzaInforme  groupBy: " + groupBy);
	//debug("SIAGAL >>>>>>>> flfactinfo.qs jpluginLanza_lanzaInforme  etiquetas: " + etiquetas);
	//debug("SIAGAL >>>>>>>> flfactinfo.qs jpluginLanza_lanzaInforme  impDirecta: " + impDirecta);
	//debug("SIAGAL >>>>>>>> flfactinfo.qs jpluginLanza_lanzaInforme  whereFijo: " + whereFijo);
	//debug("SIAGAL >>>>>>>> flfactinfo.qs jpluginLanza_lanzaInforme  nombreReport: " + nombreReport);
	//debug("SIAGAL >>>>>>>> flfactinfo.qs jpluginLanza_lanzaInforme  numCopias: " + numCopias);
	//debug("SIAGAL >>>>>>>> flfactinfo.qs jpluginLanza_lanzaInforme  limit: " + limit);
	//debug("SIAGAL >>>>>>>> flfactinfo.qs jpluginLanza_lanzaInforme  nombreCx: " + nombreCx);

	var impresora;
	var pdf;

	if (datosPdf) {
		impresora = datosPdf.ruta;
		pdf = datosPdf.pdf;
	}
		
	//debug("SIAGAL >>>>>>>> flfactinfo.qs jpluginLanza_lanzaInforme  pdf: " + pdf);
	//debug("SIAGAL >>>>>>>> flfactinfo.qs jpluginLanza_lanzaInforme  impresora: " + impresora);

	this.iface.__lanzarInforme(cursor, nombreInforme, orderBy, groupBy, etiquetas, impDirecta, whereFijo, nombreReport, numCopias, impresora, pdf);

	return
}


//// JPLUGINLANZA////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

