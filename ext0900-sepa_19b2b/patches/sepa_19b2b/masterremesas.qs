
/** @class_declaration sepa19b2b */
/////////////////////////////////////////////////////////////////
//// SEPA19B2B //////////////////////////////////////////////////
class sepa19b2b extends oficial /** %from: oficial */ {
    function sepa19b2b( context ) { oficial ( context ); }
		function init() {
				return this.ctx.sepa19b2b_init();
		}
		function volcarADisco_sepa19b2b_clicked() {
				return this.ctx.sepa19b2b_volcarADisco_sepa19b2b_clicked();
		}
}
//// SEPA19B2B //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition sepa19b2b */
/////////////////////////////////////////////////////////////////
//// SEPA19B2B /////////////////////////////////////////////////

function sepa19b2b_init()
{
	var _i = this.iface;

	_i.__init();

	connect(this.child("pbnADisco_sepa19b2b"), "clicked()", _i, "volcarADisco_sepa19b2b_clicked");
}

function sepa19b2b_volcarADisco_sepa19b2b_clicked()
{
		var cursor = this.cursor();
		cursor.setAction("vdisco_sepa19b2b");
		cursor.editRecord();
		cursor.setAction("remesas");
}

//// SEPA19B2B //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

