@@add-classes
  interna
  oficial
+ rectificamulti
  head
  ifaceCtx
..
@@added-class rectificamulti
  /** @class_declaration rectificamulti */
  /////////////////////////////////////////////////////////////////
  //// RECTIFICAMULTI /////////////////////////////////////////////////
  class rectificamulti extends PARENT_CLASS {
          function rectificamulti( context ) { PARENT_CLASS ( context ); }
          function comprobarFacturaAbonoCli(curFactura:FLSqlCursor):Boolean {
                  return this.ctx.rectificamulti_comprobarFacturaAbonoCli(curFactura);
          }
  }
  //// RECTIFICAMULTI /////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  
  /** @class_definition rectificamulti */
  /////////////////////////////////////////////////////////////////
  //// RECTIFICAMULTI /////////////////////////////////////////////////
  
  // OJO. ROMPE HERENCIA.
  function rectificamulti_comprobarFacturaAbonoCli(curFactura:FLSqlCursor):Boolean
  {
    // Anulamos esta función porque ahora hacemos la comprobación al validar la factura.
    return true;
  }
  //// RECTIFICAMULTI /////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  
..

