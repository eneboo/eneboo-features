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
      function facturaRectificada(nodo:FLDomNode, campo:String):String {
              return this.ctx.rectificamulti_facturaRectificada(nodo,campo);
      }
  }
  //// RECTIFICAMULTI /////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  
  /** @class_definition rectificamulti */
  /////////////////////////////////////////////////////////////////
  //// RECTIFICAMULTI /////////////////////////////////////////////////
  function rectificamulti_facturaRectificada(nodo:FLDomNode, campo:String):String
  {
      var idFactura:String = nodo.attributeValue("facturascli.idfactura");
      var idFacturaRect:String = nodo.attributeValue("facturascli.idfacturarect");   // Es la factura rectificada en el método antiguo.
      var coFacturaRect:String = AQUtil.sqlSelect("facturascli", "codigo", "idfactura = " + idFacturaRect);
      var codFactRectMulti:String = AQUtil.sqlSelect("facturasclirect", "codigorect", "idfactura = "+idFactura+" AND exportaredi = true");

      if (!codFactRectMulti) {
          if (coFacturaRect) 
              return AQUtil.translate("scripts", "**** Rectifica a la factura %1 ****").arg(coFacturaRect);
      }

      return "";
  }
  //// RECTIFICAMULTI /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  
..

