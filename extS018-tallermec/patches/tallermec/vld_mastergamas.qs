var pbnLanzar;

function init()
{
	pbnLanzar = form.child("toolButtonPrint");
	connect (pbnLanzar, "clicked()", this, "lanzar()");
}
function lanzar()
{
	var q = new FLSqlQuery("vld_gama");
	var rptViewer = new FLReportViewer();
	rptViewer.setReportTemplate("vld_gama");
	rptViewer.setReportData(q);
	rptViewer.renderReport();
	rptViewer.exec();
}

