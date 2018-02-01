var pbnLanzar;

function init()
{
	pbnLanzar = form.child("toolButtonPrint");
	connect (pbnLanzar, "clicked()", this, "lanzar()");
}
function lanzar()
{
	var q = new FLSqlQuery("vld_vehiculos");
	var rptViewer = new FLReportViewer();
	rptViewer.setReportTemplate("vld_vehiculos");
	rptViewer.setReportData(q);
	rptViewer.renderReport();
	rptViewer.exec();
}




