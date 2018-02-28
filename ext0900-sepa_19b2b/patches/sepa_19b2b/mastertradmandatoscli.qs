var form = this;
/***************************************************************************
                 mastertradmandatoscli.qs  -  description
                             -------------------
    begin                : mie may 14 2014
    copyright            : (C) 2014 by InfoSiAL S.L.
    email                : mail@infosial.com
 ***************************************************************************/
/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

/** @file */

/** @class_declaration interna */
////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
class interna
{
  var ctx;

  function interna(context)
  {
    this.ctx = context;
  }
  function init()
  {
    this.ctx.interna_init();
  }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna
{  
  function oficial(context)
  {
    interna(context);
  }
  function cargaDatosInicial()
  {
    this.ctx.oficial_cargaDatosInicial();
  }
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends oficial
{
  function head(context)
  {
    oficial(context);
  }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head
{
  function ifaceCtx(context)
  {
    head(context);
  }
}

const iface = new ifaceCtx(this);
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition interna */
////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////

function interna_init()
{
  var _i = this.iface;
  if (!flfactppal.iface.pub_extension("inf_multiidioma")) {
    sys.warnMsgBox(sys.translate("Para utilizar las traducciones tiene que tener el módulo de multiidoma instalado"));
    this.close();
    return false;
  } 
  _i.cargaDatosInicial();
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_cargaDatosInicial()
{
  var arrayTextos = [];
  formmandatoscli.iface.pub_dameArrayTextos(arrayTextos);
  var idCampo;
  for (idCampo in arrayTextos) {		
	var codIdioma;
    for (codIdioma in arrayTextos[idCampo]) {
      if (codIdioma == "ES") {
        var curTradMandatoscli = new FLSqlCursor("tradmandatoscli");
        curTradMandatoscli.select("idcampo = '" +  idCampo + "' ");
        if (!curTradMandatoscli.first()) {
          curTradMandatoscli.setModeAccess(curTradMandatoscli.Insert);
          curTradMandatoscli.refreshBuffer();
          curTradMandatoscli.setValueBuffer("idcampo", idCampo);
          curTradMandatoscli.setValueBuffer("descripcion", arrayTextos[idCampo][codIdioma]);
          if (!curTradMandatoscli.commitBuffer()) {
            return false;
          }
        }
      } else {
        var curTraducciones = new FLSqlCursor("traducciones");
        curTraducciones.select("idcampo = '" +  idCampo + "' and codidioma = '" + codIdioma + "'");
        if (curTraducciones.first()) {
          continue;
        }
        curTraducciones.setModeAccess(curTraducciones.Insert);
        curTraducciones.refreshBuffer();
        curTraducciones.setValueBuffer("idcampo", idCampo);
        curTraducciones.setValueBuffer("traduccion", arrayTextos[idCampo][codIdioma]);
		 curTraducciones.setValueBuffer("tabla", "mandatoscli");
        curTraducciones.setValueBuffer("campo","descripcion");
		 curTraducciones.setValueBuffer("codidioma",codIdioma);
        if (!curTraducciones.commitBuffer()) {
          return false;
        }
      }
    }
  }
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
