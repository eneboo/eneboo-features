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
      function init() {
          return this.ctx.rectificamulti_init();
      }
          function bufferChanged(fN:String) {
                  return this.ctx.rectificamulti_bufferChanged(fN);
          }
          function buscarFactura() {
                  this.ctx.rectificamulti_buscarFactura();
          }
          function buscarFacturaRect() {
                  this.ctx.rectificamulti_buscarFacturaRect();
          }
          function comprobarFacturaAbonoCliMulti(curFactura:FLSqlCursor):Boolean {
                  return this.ctx.rectificamulti_comprobarFacturaAbonoCliMulti(curFactura);
          }
          function validateForm():Boolean {
              return this.ctx.rectificamulti_validateForm();
          }
  }
  //// RECTIFICAMULTI /////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  
  /** @class_definition rectificamulti */
  /////////////////////////////////////////////////////////////////
  //// RECTIFICAMULTI /////////////////////////////////////////////////
  function rectificamulti_init()
  {
      this.iface.__init();
  
      if(this.cursor().valueBuffer("deabono") == true) {
          this.child("toolEliminaFacturaRect").setDisabled(false);
      } else {
          this.child("toolEliminaFacturaRect").setDisabled(true);
      }
  }
  
  function rectificamulti_bufferChanged(fN:String)
  {
      var util:FLUtil = new FLUtil();
      var cursor:FLSqlCursor = this.cursor();
  
      switch (fN) {
          case "deabono": {
              this.iface.__bufferChanged(fN);
              if(this.cursor().valueBuffer("deabono") == true) {
                  this.child("tbnBuscarFactura").setDisabled(false);
                  this.child("toolEliminaFacturaRect").setDisabled(false);
              } else {
                  this.cursor().setValueBuffer("rectificativa", false);
                  this.child("toolEliminaFacturaRect").setDisabled(true);
              }
              break;
          }
          default: {
              this.iface.__bufferChanged(fN);
          }
      }
  }
  
  // OJO. Rompe herencia.
  // Se anula lo que hace la padre para usarla con la asociación de varias facturas rectificadas.
  function rectificamulti_buscarFactura()
  {
      this.iface.buscarFacturaRect();
  }
  
  function rectificamulti_buscarFacturaRect()
  {
          var cursor:FLSqlCursor = this.cursor();
          var ruta:Object = new FLFormSearchDB("buscafacturacli");
          var curFacturasCli:FLSqlCursor = ruta.cursor();
          var curFactRect:FLSqlCursor = this.child("tdbFacturasCliRect").cursor();
          var util:FLUtil = new FLUtil();
          var idFactRect:Number;
          var codFactRect:String;
          var nombreCliFactRect:String;
          var fechaFactRect:Date;
          var totalFactRect:Number;
  
          var codCliente:String = cursor.valueBuffer("codcliente");
          var masFiltro:String = "";
          if (codCliente)
                  masFiltro += " AND codcliente = '" + codCliente + "'";
  
          if (cursor.modeAccess() == cursor.Insert)
                  curFacturasCli.setMainFilter("deabono = false" + masFiltro);
          else
                  curFacturasCli.setMainFilter("deabono = false and idfactura <> " + this.cursor().valueBuffer("idfactura") + masFiltro);
  
          ruta.setMainWidget();
          idFactRect = ruta.exec("idfactura");
          if (!idFactRect) return;
  
      codFactRect = AQUtil.sqlSelect("facturascli","codigo", "idfactura = "+idFactRect);
          nombreCliFactRect = AQUtil.sqlSelect("facturascli","nombrecliente", "idfactura = "+idFactRect);
          fechaFactRect = AQUtil.sqlSelect("facturascli","fecha", "idfactura = "+idFactRect);
          totalFactRect = AQUtil.sqlSelect("facturascli","total", "idfactura = "+idFactRect);
  
          curFactRect.setModeAccess(cursor.Insert);
          curFactRect.refreshBuffer();
            curFactRect.setValueBuffer("idfactura", cursor.valueBuffer("idfactura"));
            curFactRect.setValueBuffer("idfacturarect", idFactRect);
            curFactRect.setValueBuffer("codigorect", codFactRect);
            curFactRect.setValueBuffer("nombrecliente", nombreCliFactRect);
            curFactRect.setValueBuffer("fecha", fechaFactRect);
            curFactRect.setValueBuffer("total", totalFactRect);
          curFactRect.commitBuffer();
          
          // Preguntamos si traemos las líneas de la factura a rectificar.
          this.iface.mostrarDatosFactura(idFactRect);
          this.iface.mostrarOpcionesFacturaRec(idFactRect);
  }
  
  // Esta función es realmente una copia de comprobarFacturaAbonoCli() que está en flfactrac.qs que no se usa como antes en rectifativas multiples.
  function rectificamulti_comprobarFacturaAbonoCliMulti(curFactura:FLSqlCursor):Boolean
  {
      var util:FLUtil = new FLUtil();
      debug("KLO===============> idfacturarect: "+curFactura.valueBuffer("idfacturarect"));

      if (curFactura.valueBuffer("deabono") == true) {
          if (AQUtil.sqlSelect("facturasclirect", "COUNT(idfactura)", "idfactura = "+curFactura.valueBuffer("idfactura")) == 0) {
              var res:Number = MessageBox.warning(util.translate("scripts", "No ha indicado la factura que desea abonar.\n¿Desea continuar?"), MessageBox.No, MessageBox.Yes);
              if (res != MessageBox.Yes) {
                  return false;
              }
          }
      } else {
          if (AQUtil.sqlSelect("facturasclirect", "COUNT(idfactura)", "idfactura = "+curFactura.valueBuffer("idfactura")) > 0) {
              MessageBox.warning(util.translate("scripts", "La factura no es rectificativa pero tiene asignadas.\nDebe eliminarlas de la lista de rectificadas."), MessageBox.Ok, MessageBox.NoButton);
              return false;
          }
      }

      return true;
  }

  function rectificamulti_validateForm()
  {
      if(!this.iface.__validateForm())
          return false;
    
      var cursor:FLSqlCursor = this.cursor();
    
      if (!this.iface.comprobarFacturaAbonoCliMulti(cursor))
          return false;

      return true;
  }
  //// RECTIFICAMULTI /////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  
..

