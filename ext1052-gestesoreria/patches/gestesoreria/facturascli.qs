
/** @class_declaration recibosmanuales */
//////////////////////////////////////////////////////////////////
//// RECIBOSMANUALES /////////////////////////////////////////////
class recibosmanuales extends oficial {
   function recibosmanuales( context ) { oficial( context ); }
   function init() { this.ctx.recibosmanuales_init(); }
}
//// RECIBOSMANUALES //////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition recibosmanuales */
/////////////////////////////////////////////////////////////////
//// RECIBOSMANUALES ///////////////////////////////////////////
function recibosmanuales_init()
{
        this.iface.__init();

        //this.child("tdbRecibosCli").setReadOnly(true);
}
//// RECIBOSMANUALES /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

