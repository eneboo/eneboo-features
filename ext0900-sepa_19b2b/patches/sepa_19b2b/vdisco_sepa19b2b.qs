/***************************************************************************
                      vdisco_sepa19b2b.qs  -  description
                             -------------------
    begin                : vie nov 22 2013
    copyright            : (C) 2013 by InfoSiAL S.L.
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
class interna {
  var ctx;
  function interna( context ) { this.ctx = context; }
  function init() { this.ctx.interna_init(); }
	function validateForm() { return this.ctx.interna_validateForm(); }
	function acceptedForm() { return this.ctx.interna_acceptedForm(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var xml_;
	var extensionFichero_;
	var tipoPago_;
	var tipoFichero_;
	var linea_;
	var aCuentasMandato_;
	var aMandatoElegido_;
	var fechaVenc_;
	var numEfectos_;	
	var ePmtInf_;
	var incluidos_ = [];
	
    function oficial( context ) { interna( context ); }
  function establecerFichero() {
		return this.ctx.oficial_establecerFichero();
	}
	function ficheroTextoPlano(ruta,cursor,fichero) {
		return this.ctx.oficial_ficheroTextoPlano(ruta,cursor,fichero);
	}
	function incluirPresentadorTP(file,cursor,fichero) {
		return this.ctx.oficial_incluirPresentadorTP(file,cursor,fichero);
	}
	function incluirAcreedorTP(file, cursor) {
		return this.ctx.oficial_incluirAcreedorTP(file,cursor);
	}
	function incluirRegistroAdeudoTP(qryRecibos,file,cursor) {
		return this.ctx.oficial_incluirRegistroAdeudoTP(qryRecibos,file,cursor);
	}
	function incluirTotalFechaCobroTP(fechaPago,file,cursor) {
		return this.ctx.oficial_incluirTotalFechaCobroTP(fechaPago,file,cursor);
	}
	function incluirTotalAcreedorTP(file,cursor) {
		return this.ctx.oficial_incluirTotalAcreedorTP(file,cursor);
	}
	function incluirTotalGeneralTP(file,cursor) {
		return this.ctx.oficial_incluirTotalGeneralTP(file,cursor);
	}
	function addCampo(valor,tipo,longitud,file) {
		return this.ctx.oficial_addCampo(valor,tipo,longitud,file);
	}
	function rellenarVacios(valor,tipo,longitud) {
		return this.ctx.oficial_rellenarVacios(valor,tipo,longitud);
	}
	function devolverIdentificadorAcreedor(cursor) {
		return this.ctx.oficial_devolverIdentificadorAcreedor(cursor);
	}
	function ficheroXML(file) {
		return this.ctx.oficial_ficheroXML(file);
	}
	function crearDocumentoXML() {
		return this.ctx.oficial_crearDocumentoXML();
	}
	function incluirCabeceraXML(nodoPadre) {
		return this.ctx.oficial_incluirCabeceraXML(nodoPadre);
	}
	function incluirIdParteXML(nodoPadre) {
		return this.ctx.oficial_incluirIdParteXML(nodoPadre);
	}
	function incluirPersonaJuridicaXML(nodoPadre) {
		return this.ctx.oficial_incluirPersonaJuridicaXML(nodoPadre);
	}
	function incluirPersonaFisicaXML(nodoPadre) {
		return this.ctx.oficial_incluirPersonaFisicaXML(nodoPadre);
	}
	/// Nuevo
	function incluirInformacionPagoXML(nodoPadre, qryRecibos, tipoPago) {
		return this.ctx.oficial_incluirInformacionPagoXML(nodoPadre, qryRecibos, tipoPago);
	}
	/*
	function incluirInformacionPagoXML(nodoPadre) {
		return this.ctx.oficial_incluirInformacionPagoXML(nodoPadre);
	}
	*/
	///
	function incluirAcreedorXML(nodoPadre) {
		return this.ctx.oficial_incluirAcreedorXML(nodoPadre);
	}
	function incluirDireccionPostalXML(nodoPadre) {
		return this.ctx.oficial_incluirDireccionPostalXML(nodoPadre);
	}
	/// Nuevo
	function incluirInformacionTipoPagoXML(nodoPadre, qryRecibos, tipoPago) {
		return this.ctx.oficial_incluirInformacionTipoPagoXML(nodoPadre, qryRecibos, tipoPago);
	}
	/*
	function incluirInformacionTipoPagoXML(nodoPadre) {
		return this.ctx.oficial_incluirInformacionTipoPagoXML(nodoPadre);
	}
	*/
	/// Fin nuevo
	function incluirOperacionAdeudoXML(nodoPadre,qryRecibos,curRecibos) {
		return this.ctx.oficial_incluirOperacionAdeudoXML(nodoPadre,qryRecibos,curRecibos);
	}
	function incluirDeudorXML(nodoPadre,qryRecibos,curRecibos) {
		return this.ctx.oficial_incluirDeudorXML(nodoPadre,qryRecibos,curRecibos);
	}
	function colgarNodo(nombreHijo, nodoPadre) {
		return this.ctx.oficial_colgarNodo(nombreHijo, nodoPadre);
	}
	function colgarNodoTexto(nodoPadre, valor, tipo, min, max, decimales) {
		return this.ctx.oficial_colgarNodoTexto(nodoPadre, valor, tipo, min, max, decimales);
	}
	function validarTextoNodo(valor, tipo, min, max, decimales) {
		return this.ctx.oficial_validarTextoNodo(valor, tipo, min, max, decimales);
	}
	function formateaFecha(fecha, tipoFecha) {
		return this.ctx.oficial_formateaFecha(fecha, tipoFecha);
	}
	function formateaCadena(c) {
		return this.ctx.oficial_formateaCadena(c);
	}
	function bngFormatoFichero_clicked(opcion) {
		return this.ctx.oficial_bngFormatoFichero_clicked(opcion);
	}
	function bngTipoPago_clicked(opcion) {
		return this.ctx.oficial_bngTipoPago_clicked(opcion);
	}
	function bngTipoFichero_clicked(opcion) {
		return this.ctx.oficial_bngTipoFichero_clicked(opcion);
	}
	function comprobarValidate() {
		return this.ctx.oficial_comprobarValidate();
	}
	function comprobarMandatos() {
		return this.ctx.oficial_comprobarMandatos();
	}
	function tbnExportarErroneos_clicked() {
		return this.ctx.oficial_tbnExportarErroneos_clicked();
	}
	function quitaApostrofes(texto){
		return this.ctx.oficial_quitaApostrofes(texto);
	}
	function dameMandato(oParam) {
		return this.ctx.oficial_dameMandato(oParam);
	}
	function crearMandatoDefecto(oParam) {
		return this.ctx.oficial_crearMandatoDefecto(oParam);
	}
	function dameQueryMandato(idRecibo, fechaRem) {
		return this.ctx.oficial_dameQueryMandato(idRecibo, fechaRem);
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends oficial {
  function head( context ) { oficial ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
  function ifaceCtx( context ) { head( context ); }
}

const iface = new ifaceCtx( this );
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition interna */
////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
/** \D No de muestran los botones est·ndar de un formulario de registro
\end */
function interna_init()
{
	var _i = this.iface;
	
	with(form) {
		child("fdbDivisa").setDisabled(true);
		child("fdbCodCuenta").setDisabled(true);
		child("pushButtonAcceptContinue").close();
		child("pushButtonFirst").close();
		child("pushButtonLast").close();
		child("pushButtonNext").close();
		child("pushButtonPrevious").close();
		connect(child("pbExaminar"), "clicked()", _i, "establecerFichero");
	}
	
	connect(this.child("bngFormatoFichero"), "clicked(int)", _i, "bngFormatoFichero_clicked");
	connect(this.child("bngTipoPago"), "clicked(int)", _i, "bngTipoPago_clicked");
	connect(this.child("bngTipoFichero"), "clicked(int)", _i, "bngTipoFichero_clicked");
	connect(this.child("tbnExportarErroneos"), "clicked()", _i, "tbnExportarErroneos_clicked");
	
	_i.bngFormatoFichero_clicked(1);
	_i.bngTipoPago_clicked(0);
	_i.bngTipoFichero_clicked(0);

	if (this.child("bngTipoPago")) {
		this.child("bngTipoPago").close();
	}
}

/** \C El nombre del fichero de destino debe indicarse
\end */
function interna_validateForm()
{
	var _i = this.iface;
	
	if (this.child("leFichero").text.isEmpty()) {
		sys.warnMsgBox(sys.translate("Debe indicar el fichero."));
		return false;
	}
	
	if (!this.child("leFichero").text.endsWith("." + _i.extensionFichero_)) {
		this.child("leFichero").text = this.child("leFichero").text + "." + _i.extensionFichero_; 
	}
	
	return true;
}

/** \C Se genera el fichero de texto con los datos de la remesa en el fichero especificado
\end */
function interna_acceptedForm()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	if(!_i.comprobarValidate()){
			sys.errorMsgBox(sys.translate("No se ha podido generar el fichero."));
		return false;
	}
	
	//aCuentasMandato_ = [];
	//aMandatoElegido_ = [];
	
	var ruta = this.child("leFichero").text;
	//file.open(File.WriteOnly);
		
	if(_i.extensionFichero_ == "xml"){
		if(!_i.ficheroXML(ruta)){
			//file.remove();
			flfactppal.iface.ponMsgError(sys.translate("No se ha podido generar el fichero."), "error");
			//sys.errorMsgBox(sys.translate("No se ha podido generar el fichero."));
			return false;
		}
	}
	else if(_i.extensionFichero_ == "txt"){
		if(!_i.ficheroTextoPlano(ruta, cursor)){
			//file.remove();
			flfactppal.iface.ponMsgError(sys.translate("No se ha podido generar el fichero."), "error");
			//sys.errorMsgBox(sys.translate("No se ha podido generar el fichero."));
			return false;
		}
	}
	else {
		flfactppal.iface.ponMsgError(sys.translate("Revisa la extensiÛn del archivo."), "error");
		//sys.errorMsgBox(sys.translate("Revisa la extensiÛn del archivo."));
		return false;
	}

	//file.close();

	flfactppal.iface.ponMsgError(sys.translate("Fichero generado en: \n\n%1\n\n").arg(this.child("leFichero").text), "info");
	//sys.infoMsgBox(sys.translate("Fichero generado en: \n\n%1\n\n").arg(this.child("leFichero").text));

	return true;
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_establecerFichero()
{
	var _i = this.iface;
	
	this.child("leFichero").text = FileDialog.getSaveFileName("*." + _i.extensionFichero_);
}

function oficial_ficheroTextoPlano(ruta, cursor,fichero)
{
	var _i = this.iface;
	//var cursor = this.cursor();
	
	aCuentasMandato_ = [];
	aMandatoElegido_ = [];
	
	var file = new File(ruta);
	file.open(File.WriteOnly);
	
	var idRemesa = cursor.valueBuffer("idremesa");

	if(!_i.incluirPresentadorTP(file,cursor,fichero)){
		file.remove();
		return false;
	}

	if(!_i.incluirAcreedorTP(file, cursor)){
		file.remove();
		return false;
	}
	
	var qryRecibos = new FLSqlQuery();
	var groupBy = " GROUP BY r.codcliente, r.nombrecliente, r.codcuenta, r.fechav";
  	qryRecibos.setSelect("r.codcliente, r.nombrecliente, r.codcuenta, r.fechav");
  	qryRecibos.setFrom("reciboscli r INNER JOIN pagosdevolcli pd ON r.idrecibo = pd.idrecibo");
  	qryRecibos.setWhere("pd.idremesa = " + idRemesa + " " + groupBy);
  
  	if (!qryRecibos.exec()) {
	  	flfactppal.iface.ponMsgError(sys.translate("Error query."), "warn");
		//sys.warnMsgBox("Error query.");
		file.remove();
	  	return false;
	}
     
	while(qryRecibos.next()){
		if(!_i.incluirRegistroAdeudoTP(qryRecibos,file, cursor)){
			file.remove();
			return false;
		}
	}
	
	if(!_i.incluirTotalFechaCobroTP(file, cursor)){
		file.remove();
		return false;
	}
	
	if(!_i.incluirTotalAcreedorTP(file, cursor)){
		file.remove();
		return false;
	}
	
	if(!_i.incluirTotalGeneralTP(file, cursor)){
		file.remove();
		return false;
	}
	
	file.close();
	return true;
}

function oficial_incluirPresentadorTP(file, cursor, fichero)
{
	var _i = this.iface;
	//var cursor = this.cursor();
	_i.linea_ = "";
	
	var nombreEmpresa = flfactppal.iface.pub_valorDefectoEmpresa("nombre");
	var fechaActual = _i.formateaFecha(new Date(),"AMDhms");
	var fechaRemesa = _i.formateaFecha(cursor.valueBuffer("fecha"),"AMD");
	var idRemesa = cursor.valueBuffer("idremesa");
	
	var entidad = AQUtil.sqlSelect("cuentasbanco","ctaentidad","codcuenta = '" + cursor.valueBuffer("codcuenta") + "'");
	var oficina = AQUtil.sqlSelect("cuentasbanco","ctaagencia","codcuenta = '" + cursor.valueBuffer("codcuenta") + "'");
	
	if(!_i.tipoFichero_ || _i.tipoFichero_ == "" || _i.tipoFichero_ == "undefined"){

		_i.tipoFichero_ = fichero;

	}
	
	if(!_i.addCampo(1,"num",2, 2)) {return false;}
	
	if(_i.tipoFichero_ == "B2B") {
		if(!_i.addCampo(19445,"num",5,7)) {return false;}
	}
	else if(_i.tipoFichero_ == "CORE") {
		if(!_i.addCampo(19143,"num",5,7)) {return false;}
	}
	else if(_i.tipoFichero_ == "CORE1*") {
		if(!_i.addCampo(19154,"num",5,7)) {return false;}
	}
	else {
		return false;
	}
	
	var id = _i.devolverIdentificadorAcreedor(cursor);
		
	if(!id){
		return false;
	}
	
	if(!_i.addCampo(1,"num",3,10)) {return false;}
	if(!_i.addCampo(id,"String",35,45)) {return false;}
	if(!_i.addCampo(nombreEmpresa,"String",70,115)) {return false;}
	if(!_i.addCampo(fechaRemesa,"String",8,123)) {return false;}
	if(!_i.addCampo("PRE" + fechaActual + _i.rellenarVacios(idRemesa,"num",13),"String",35,158)) {return false;}
	if(!_i.addCampo(entidad,"String",4,162)) {return false;}
	if(!_i.addCampo(oficina,"String",4,166)) {return false;}
	if(!_i.addCampo(_i.rellenarVacios("","String",434),"String",434,600)) {return false;}
	
	file.writeLine(_i.linea_);
	_i.linea_ = "";
	return true;
}

function oficial_incluirAcreedorTP(file, cursor)
{
	var _i = this.iface;
	//var cursor = this.cursor();
	
	var idRemesa = cursor.valueBuffer("idremesa");
	
	var nombreEmpresa = flfactppal.iface.pub_valorDefectoEmpresa("nombre");
	var fechaCargo = _i.formateaFecha(cursor.valueBuffer("fechacargo"),"AMD");
	var IBAN = AQUtil.sqlSelect("cuentasbanco","iban","codcuenta = '" + cursor.valueBuffer("codcuenta") + "'");

	if(!_i.addCampo(2,"num",2, 2)) {return false;}
	if(_i.tipoFichero_ == "B2B") {
		if(!_i.addCampo(19445,"num",5,7)) {return false;}
	}
	else if(_i.tipoFichero_ == "CORE") {
		if(!_i.addCampo(19143,"num",5,7)) {return false;}
	}
	else if(_i.tipoFichero_ == "CORE1*") {
		if(!_i.addCampo(19154,"num",5,7)) {return false;}
	}
	else {
		return false;
	}
	
	var id = _i.devolverIdentificadorAcreedor(cursor);
		
	if(!id){
		return false;
	}
	
	if(!_i.addCampo(2,"num",3,10)) {return false;}
	if(!_i.addCampo(id,"String",35,45)) {return false;}
	if(!_i.addCampo(fechaCargo,"String",8,53)) {return false;}
	if(!_i.addCampo(nombreEmpresa,"String",70,123)) {return false;}
	if(!_i.addCampo(_i.rellenarVacios("","String",50),"String",50,173)) {return false;}
	if(!_i.addCampo(_i.rellenarVacios("","String",50),"String",50,223)) {return false;}
	if(!_i.addCampo(_i.rellenarVacios("","String",40),"String",40,263)) {return false;}
	if(!_i.addCampo(_i.rellenarVacios("","String",2),"String",2,265)) {return false;}
	if(!_i.addCampo(IBAN,"String",34,299)) {return false;}
	if(!_i.addCampo(_i.rellenarVacios("","String",301),"String",301,600)) {return false;}

	file.writeLine(_i.linea_);
	_i.linea_ = "";
	
	return true;
}

function oficial_incluirRegistroAdeudoTP(qryRecibos,file,cursor)
{
	var _i = this.iface;
	//var cursor = this.cursor();
	
	var curRecibos = new FLSqlCursor("reciboscli");
	/*curRecibos.select("codcliente = '" + qryRecibos.value("r.codcliente") + "' AND codcuenta = '" + qryRecibos.value("r.codcuenta") + "' AND idrecibo IN (SELECT idrecibo FROM pagosdevolcli WHERE idremesa = " + cursor.valueBuffer("idremesa") + ")");

	if(!curRecibos.first()) {
		sys.warnMsgBox(sys.translate("No se han encontrado recibos v·lidos para el cliente %1").arg(qryRecibos.value("r.nombrecliente")));
		return false;
	}*/
	curRecibos.select("codcliente = '" + qryRecibos.value("r.codcliente") + "' AND fechav = '" + qryRecibos.value("r.fechav") + "' AND codcuenta = '" + qryRecibos.value("r.codcuenta") + "' AND idrecibo IN (SELECT idrecibo FROM pagosdevolcli WHERE idremesa = " + cursor.valueBuffer("idremesa") + ")");
 
   if(!curRecibos.first()) {
   	sys.warnMsgBox(sys.translate("No se han encontrado recibos v·lidos para el cliente %1").arg(qryRecibos.value("r.nombrecliente")));
   }
	
	do{
		curRecibos.setModeAccess(curRecibos.Browse);
		curRecibos.refreshBuffer();
		
		_i.linea_ = "";
		
		var fechaRem = cursor.valueBuffer("fechacargo");
		
		var codCuenta = curRecibos.valueBuffer("codcuenta");
		var nombre = curRecibos.valueBuffer("nombrecliente");
		var codCliente = curRecibos.valueBuffer("codcliente");
		var fechaRec = curRecibos.valueBuffer("fecha");
		
		var fechaCargo = _i.formateaFecha(fechaRem,"AMD");
		
		var BIC = AQUtil.sqlSelect("cuentasbcocli","bic","codcuenta = '" + codCuenta + "'");
		var IBAN = AQUtil.sqlSelect("cuentasbcocli","iban","codcuenta = '" + codCuenta + "'");

		var idRecibo = curRecibos.valueBuffer("idrecibo");

		var oParam = new Object;
		oParam.idRecibo = idRecibo;
		oParam.codCliente = codCliente;
		oParam.codCuenta = cursor.valueBuffer("codcuenta");
		oParam.nombreCliente = nombre;
		oParam.codCuentaCli = codCuenta; 
		oParam.fechaRem = fechaRem;
		
		var idMandato = _i.dameMandato(oParam);
		if(!idMandato || idMandato == "") {
			flfactppal.iface.ponMsgError(sys.translate("No existe mandato para el cliente %1 y no se ha podido crear uno por defecto. Se cancela el proceso.").arg(codCliente),"warn",this);
			return false;
		
		}
		var curMandato = new FLSqlCursor("mandatoscli");		
		curMandato.select("idmandato = " + idMandato);			
		
		switch (curMandato.size()) {
			case 0: {
				break;
			}
			case 1: {
				break;
			}
			default: {
				var mandatoEncontrado = false;
				
				for(var ind = 0; ind < aCuentasMandato_.length; ind++) {
					if(aCuentasMandato_[ind] == codCuenta) {
						curMandato.select("idmandato = " + aMandatoElegido_[ind]);
						mandatoEncontrado = true;
					}
				}
				
				if(!mandatoEncontrado) {
					var opId = [];
					var opDes = [];
					
					while (curMandato.next()) {
						curMandato.setModeAccess(curMandato.Browse);
						curMandato.refreshBuffer();
						
						opId.push(curMandato.valueBuffer("idmandato"));
						opDes.push(curMandato.valueBuffer("refmandato") + " - " + curMandato.valueBuffer("descripcion"));
					}

					var idOpcion = flfactppal.iface.pub_elegirOpcion(opDes, sys.translate("Escoja mandato para la cuenta %1 del cliente %2 - %3").arg(codCuenta).arg(codCliente).arg(nombre));
			
					if (idOpcion < 0) {
						return false;
					}
			
					curMandato.select("idmandato = " + opId[idOpcion]);
					aCuentasMandato_.push(codCuenta);
					aMandatoElegido_.push(opId[idOpcion]);
				}
				break;
			}
		}
		
		var refMandato;
		var fechaCad;
		var numEfectos;
		var tipoPago;
		var fechaFirma;
		
		var mandatoPorDefecto = false;


		if (!curMandato.first()) {
			flfactppal.iface.ponMsgError(sys.translate("Error al localizar el mandato"),"warn",this);	
		} else {
			curMandato.setModeAccess(curMandato.Edit);
			curMandato.refreshBuffer();		
		
			refMandato = curMandato.valueBuffer("refmandato");
			//fechaCad = curMandato.valueBuffer("fechacaducidad");
			//if(fechaCad && fechaCad != "") {
			//	fechaCad = _i.formateaFecha(fechaCad,"A-M-D");
			//}		
			numEfectos = curMandato.valueBuffer("numefectos");
			tipoPago = curMandato.valueBuffer("tipopago");
			fechaFirma = curMandato.valueBuffer("fechafirma");		
			if(!fechaFirma || fechaFirma == "") {
				fechaFirma = "2016-02-01";
			}	else {
				fechaFirma = _i.formateaFecha(fechaFirma, "AMD");
			}
		}
		
		var tipoAdeudo;
		
		if(numEfectos != 0) {
			tipoAdeudo = "RCUR";
		}
		else {
			if(tipoPago == "Pago Recurrente") {
				tipoAdeudo = "FRST";
			}
			else {
				tipoAdeudo = "OOFF";
			}
		}

		if(!_i.addCampo(3,"num",2, 2)) {return false;}
		if(_i.tipoFichero_ == "B2B") {
			if(!_i.addCampo(19445,"num",5,7)) {return false;}
		}
		else if(_i.tipoFichero_ == "CORE") {
			if(!_i.addCampo(19143,"num",5,7)) {return false;}
		}
		else if(_i.tipoFichero_ == "CORE1*") {
			if(!_i.addCampo(19154,"num",5,7)) {return false;}
		}
		else {
			return false;
		}
		
		if(!IBAN || IBAN == "") {
			sys.warnMsgBox(sys.translate("Falta el cÛdigo IBAN para la cuenta %1 del cliente %2").arg(codCuenta).arg(nombre));
			return false;
		}
		
		/*if(!BIC || BIC == "") {
			sys.warnMsgBox(sys.translate("Falta el cÛdigo BIC para la cuenta con IBAN %1 del cliente %2").arg(IBAN).arg(nombre));
			return false;
		}*/
		
		if(!_i.addCampo(3,"num",3,10)) {return false;}
		if(!_i.addCampo(curRecibos.valueBuffer("codigo"),"String",35,45)) {return false;}
		if(!_i.addCampo(refMandato,"String",35,80)) {return false;}
		if(!_i.addCampo(tipoAdeudo,"String",4,84)) {return false;}
		if(!_i.addCampo(_i.rellenarVacios("","String",4),"String",4,88)) {return false;}
		if(!_i.addCampo(curRecibos.valueBuffer("importe"),"numDec",11,99)) {return false;}
		if(!_i.addCampo(fechaFirma,"String",8,107)) {return false;}
		if(!_i.addCampo(BIC,"String",11,118)) {return false;}
		if(!_i.addCampo(curRecibos.valueBuffer("nombrecliente"),"String",70,188)) {return false;}
		if(!_i.addCampo(_i.rellenarVacios("","String",50),"String",50,238)) {return false;}
		if(!_i.addCampo(_i.rellenarVacios("","String",50),"String",50,288)) {return false;}
		if(!_i.addCampo(_i.rellenarVacios("","String",40),"String",40,328)) {return false;}
		if(!_i.addCampo(_i.rellenarVacios("","String",2),"String",2,330)) {return false;}
		if(!_i.addCampo(_i.rellenarVacios("","String",1),"num",1,331)) {return false;}
		if(!_i.addCampo(_i.rellenarVacios("","String",36),"String",36,367)) {return false;}
		if(!_i.addCampo(_i.rellenarVacios("","String",35),"String",35,402)) {return false;}
		if(!_i.addCampo("A","String",1,403)) {return false;}
		if(!_i.addCampo(IBAN,"String",34,437)) {return false;}
		if(!_i.addCampo(_i.rellenarVacios("","String",4),"String",4,441)) {return false;}
		if(!_i.addCampo(_i.rellenarVacios("","String",140),"String",140,581)) {return false;}
		if(!_i.addCampo(_i.rellenarVacios("","String",19),"String",19,600)) {return false;}
		
		if(!mandatoPorDefecto) {
			var curPagos = new FLSqlCursor("pagosdevolcli");
			curPagos.select("idrecibo = " + curRecibos.valueBuffer("idrecibo") + " AND idremesa = " + cursor.valueBuffer("idremesa"));
		
			while(curPagos.next()) {
				curPagos.setModeAccess(curPagos.Edit);
				curPagos.refreshBuffer();
			
				curPagos.setValueBuffer("idmandato", curMandato.valueBuffer("idmandato"));
			
				if(!curPagos.commitBuffer())
					return false;
			}
			curMandato.setValueBuffer("numefectos", formRecordmandatoscli.iface.pub_commonCalculateField("numefectos", curMandato));
			curMandato.setValueBuffer("fechaultadeudo", cursor.valueBuffer("fechacargo"));
			curMandato.setValueBuffer("fechacaducidad", formRecordmandatoscli.iface.pub_commonCalculateField("fechacaducidad", curMandato));
		
			if (!curMandato.commitBuffer()) {
				return false;
			}
		}
				
		file.writeLine(_i.linea_);
		_i.linea_ = "";
		
	}while(curRecibos.next());
	
	return true;
}


function oficial_incluirTotalFechaCobroTP(file, cursor)
{
	var _i = this.iface;
	//var cursor = this.cursor();
	_i.linea_ = "";
	
	var fechaCargo = _i.formateaFecha(cursor.valueBuffer("fechacargo"),"AMD");
	var idRemesa = cursor.valueBuffer("idremesa");
	var totalImporte = AQUtil.sqlSelect("reciboscli r INNER JOIN pagosdevolcli pd ON r.idrecibo = pd.idrecibo","sum(r.importe)","pd.idremesa = " + idRemesa, "reciboscli");
	var totalRecibos = AQUtil.sqlSelect("reciboscli r INNER JOIN pagosdevolcli pd ON r.idrecibo = pd.idrecibo","count(*)","pd.idremesa = " + idRemesa, "reciboscli");

	var id = _i.devolverIdentificadorAcreedor(cursor);
		
	if(!id){
		return false;
	}
	
	if(!_i.addCampo(4,"num",2, 2)) {return false;}
	if(!_i.addCampo(id,"String",35,37)) {return false;}
	if(!_i.addCampo(fechaCargo,"String",8,45)) {return false;}
	if(!_i.addCampo(totalImporte,"numDec",17,62)) {return false;}
	if(!_i.addCampo(totalRecibos,"num",8,70)) {return false;}
	if(!_i.addCampo(totalRecibos+2,"num",10,80)) {return false;}
	if(!_i.addCampo(_i.rellenarVacios("","String",520),"String",520,600)) {return false;}
	
	file.writeLine(_i.linea_);
	_i.linea_ = "";
	
	return true;
}

function oficial_incluirTotalAcreedorTP(file,cursor)
{
	var _i = this.iface;
	//var cursor = this.cursor();
	_i.linea_ = "";
	
	var idRemesa = cursor.valueBuffer("idremesa");
	var totalImporte = AQUtil.sqlSelect("reciboscli r INNER JOIN pagosdevolcli pd ON r.idrecibo = pd.idrecibo","sum(r.importe)","pd.idremesa = " + idRemesa, "reciboscli");
	var totalRecibos = AQUtil.sqlSelect("reciboscli r INNER JOIN pagosdevolcli pd ON r.idrecibo = pd.idrecibo","count(*)","pd.idremesa = " + idRemesa, "reciboscli");

	var id = _i.devolverIdentificadorAcreedor(cursor);
		
	if(!id){
		return false;
	}
	
	if(!_i.addCampo(5,"num",2, 2)) {return false;}
	if(!_i.addCampo(id,"String",35,37)) {return false;}
	if(!_i.addCampo(totalImporte,"numDec",17,54)) {return false;}
	if(!_i.addCampo(totalRecibos,"num",8,62)) {return false;}
	if(!_i.addCampo(totalRecibos+3,"num",10,72)) {return false;}
	if(!_i.addCampo(_i.rellenarVacios("","String",528),"String",528,600)) {return false;}
	
	file.writeLine(_i.linea_);
	_i.linea_ = "";
	
	return true;
}

function oficial_incluirTotalGeneralTP(file,cursor)
{
	var _i = this.iface;
	//var cursor = this.cursor();
	_i.linea_ = "";
	
	var idRemesa = cursor.valueBuffer("idremesa");
	var totalImporte = AQUtil.sqlSelect("reciboscli r INNER JOIN pagosdevolcli pd ON r.idrecibo = pd.idrecibo","sum(r.importe)","pd.idremesa = " + idRemesa, "reciboscli");
	var totalRecibos = AQUtil.sqlSelect("reciboscli r INNER JOIN pagosdevolcli pd ON r.idrecibo = pd.idrecibo","count(*)","pd.idremesa = " + idRemesa, "reciboscli");

	if(!_i.addCampo(99,"num",2, 2)) {return false;}
	if(!_i.addCampo(totalImporte,"numDec",17,19)) {return false;}
	if(!_i.addCampo(totalRecibos,"num",8,27)) {return false;}
	if(!_i.addCampo(totalRecibos+5,"num",10,37)) {return false;}
	if(!_i.addCampo(_i.rellenarVacios("","String",563),"String",563,600)) {return false;}
	
	file.writeLine(_i.linea_);
	_i.linea_ = "";
	
	return true;
}

function oficial_addCampo(valor,tipo,longitud,longLinea)
{
	var _i = this.iface;
		
	var str = valor.toString();
	str = _i.formateaCadena(str);
	var strFormateada;
	
	if(tipo == "numDec"){
		var pEnt = parseInt(valor);
		var pDec = AQUtil.roundFieldValue(valor - parseInt(valor), "reciboscli", "importe");
		subDec = pDec.substring(2);
		str = pEnt.toString() + subDec.toString();
		valor = str;
	}
	
	if(str.length < longitud){
		strFormateada = _i.rellenarVacios(str,tipo,longitud);
	}
	else if(str.length == longitud){
		strFormateada = str;
	}
	else {
		strFormateada = str.left(longitud);
	}
	
	_i.linea_ += strFormateada.toString();
	
	var l = _i.linea_.length;
	if (l != longLinea) {
		sys.warnMsgBox(sys.translate("Error en el formato de la linea."));
		return false;
	}
	return true;
}

function oficial_rellenarVacios(valor, tipo, longitud)
{
	var _i = this.iface;
	var strFormateada;
	
	switch(tipo){
		case "String": {
			strFormateada = flfactppal.iface.pub_espaciosDerecha(valor,longitud);
			break;
		}
		case "numDec":
		case "num": {
			strFormateada = flfactppal.iface.pub_cerosIzquierda(valor,longitud);
			break;
		}
		default: {
			strFormateada = flfactppal.iface.pub_espaciosDerecha(valor,longitud);
			break;
		}
	}
	return strFormateada;
}

function oficial_devolverIdentificadorAcreedor(cursor)
{
	var _i = this.iface;
	
	if(!cursor || cursor == "" || cursor == "undefined")
		var cursor = this.cursor();
	
	var codCuenta = cursor.valueBuffer("codcuenta");
	var CIFNIF = flfactppal.iface.pub_valorDefectoEmpresa("cifnif");
	
	var tipoNorma = 19;
	if(this.child("cmbNorma") && this.child("cmbNorma").currentText == "Adeudos financiados (58)"){
		tipoNorma = 58;
	}
	
	var identificador = flfactppal.iface.calcularIdentificadorAcreedor(CIFNIF, codCuenta, tipoNorma);
	
	debug("///////////////////////////// " + identificador);
	
	return identificador;
}

function oficial_ficheroXML(ruta)
{
	var _i = this.iface;
	aCuentasMandato_ = [];
	aMandatoElegido_ = [];
	_i.incluidos_ = [];
	
	var file = new File(ruta);
	file.open(File.WriteOnly);
	
	_i.crearDocumentoXML();
	
	var eCstmrDrctDbtInitn = _i.colgarNodo("CstmrDrctDbtInitn","raiz");
	
	if(!_i.incluirCabeceraXML(eCstmrDrctDbtInitn)) {
		file.remove();
		return false;
	}
	
	/// Nuevo
	/* 1 a N veces */
	/* En nuestro caso siempre va a ser 1 */
	/*
	var x = 0;
	while(x < 1) {
		if(!_i.incluirInformacionPagoXML(eCstmrDrctDbtInitn)) {
			file.remove();
			return false;
		}
		
		x++;
	}
	*/
	var cursor = this.cursor();
	var idRemesa = cursor.valueBuffer("idremesa");

	if(!_i.tipoPago_ || _i.tipoPago_ == "") {
		_i.tipoPago_ = "RCUR";
	}

	var qryMandatos = new FLSqlQuery();
	qryMandatos.setSelect("idmandato");
	qryMandatos.setFrom("pagosdevolcli");
	qryMandatos.setWhere("idremesa = " + idRemesa);

	if (!qryMandatos.exec()) {
		sys.warnMsgBox("Error query.");
  		return false;
  	}

	AQUtil.sqlUpdate("pagosdevolcli", "idmandato", "", "idremesa = " + idRemesa);

	while(qryMandatos.next()){
		var curMandato = new FLSqlCursor("mandatoscli");
		curMandato.select("idmandato = '" + qryMandatos.value("idmandato") + "' AND tipo = '" + _i.tipoFichero_ + "'");
		if (curMandato.first()) {
			curMandato.setModeAccess(curMandato.Edit);
			curMandato.refreshBuffer();

			var efectos = formRecordmandatoscli.iface.pub_commonCalculateField("numefectos", curMandato);
			
			curMandato.setValueBuffer("numefectos", efectos);

			if (!curMandato.commitBuffer()) {
				return false;
			}
		}
	}	

	var qryRecibos = new FLSqlQuery();
	var groupBy = " GROUP BY r.codcliente, r.nombrecliente, r.codcuenta, r.fechav, r.idrecibo, mc.idmandato ORDER BY r.fechav";
  	qryRecibos.setSelect("r.codcliente, r.nombrecliente, r.codcuenta, r.fechav, r.idrecibo, mc.idmandato");
  	qryRecibos.setFrom("reciboscli r INNER JOIN pagosdevolcli pd ON r.idrecibo = pd.idrecibo LEFT JOIN mandatoscli mc ON mc.codcuentacliente = r.codcuenta AND mc.tipo = '" + _i.tipoFichero_ + "'");
  	qryRecibos.setWhere("pd.idremesa = " + idRemesa + " " + groupBy);
  
  	if (!qryRecibos.exec()) {
		sys.warnMsgBox("Error query.");
  		return false;
  	}
    debug("////////////////////// qryRecibos: " + qryRecibos.sql());
  
  	_i.fechaVenc_ = "fecha";
  	_i.numEfectos_ = "numefectos";
  	var i = 0;
  	var numEfectos;
  	var encontrado = false;
      
	while(qryRecibos.next()){

		var codCuentaCli = qryRecibos.value("r.codcuenta");
		var fechaRec = qryRecibos.value("r.fechav");		
		var codCliente = qryRecibos.value("r.codcliente"); 
		var nombreCliente = qryRecibos.value("r.nombrecliente"); 

		var oParam = new Object;
		oParam.idRecibo = qryRecibos.value("r.idrecibo");
		oParam.codCliente = codCliente;
		oParam.codCuenta = cursor.valueBuffer("codcuenta");
		oParam.codCuentaCli = codCuentaCli;
		oParam.nombreCliente = nombreCliente; 
		oParam.fechaRem = cursor.valueBuffer("fechacargo");
		var idMandato = _i.dameMandato(oParam);
		

		if(!idMandato || idMandato == "") {
			flfactppal.iface.ponMsgError(sys.translate("No existe mandato para el cliente %1 y no se ha podido crear uno por defecto. Se cancela el proceso."),"warn",this);
			return false;
		}
		
		var curMandato = new FLSqlCursor("mandatoscli");
		curMandato.select("idmandato = "+ idMandato);
		if (curMandato.first()) {
			curMandato.setModeAccess(curMandato.Edit);
			curMandato.refreshBuffer();
			var efectos = formRecordmandatoscli.iface.pub_commonCalculateField("numefectos", curMandato);
			
			curMandato.setValueBuffer("numefectos", efectos);
			if (!curMandato.commitBuffer()) {
				return false;
			}
		}			
		
		
		for(var j = 0; j < _i.incluidos_.length; j++){
			if(qryRecibos.value("r.idrecibo") == _i.incluidos_[j]){
				encontrado = true;
				j = _i.incluidos_.length;
			}
		}
		if(!encontrado){			
			numEfectos = AQUtil.sqlSelect("mandatoscli", "numefectos", "idmandato = " + idMandato);
			if(numEfectos == 0 || !numEfectos){
				
				if(!_i.incluirInformacionPagoXML(eCstmrDrctDbtInitn, qryRecibos, "FRST")){
					return false;
				}
			}
		} else{
			encontrado = false;
		}
	}
	//hacemos otra vez el exec para recargue si hemos creado alg˙n mandato nuevo.
	if (!qryRecibos.exec()) {
		sys.warnMsgBox("Error query.");
  		return false;
  	}
	qryRecibos.first();
	
	do{
		numEfectos = 0;
		
		for(var j = 0; j < _i.incluidos_.length; j++){
			if(qryRecibos.value("r.idrecibo") == _i.incluidos_[j]){
				encontrado = true;
				j = _i.incluidos_.length;
			}
		}
		if(!encontrado){
					

			var oParam = new Object;
			oParam.idRecibo = qryRecibos.value("r.idrecibo");
			oParam.codCliente = qryRecibos.value("r.codcliente");
			oParam.codCuentaCli = qryRecibos.value("r.codcuenta");
			oParam.nombreCliente = qryRecibos.value("r.nombrecliente"); 
			oParam.codCuenta = cursor.valueBuffer("codcuenta");
			oParam.fechaRem = cursor.valueBuffer("fechacargo");
			var idMandato = _i.dameMandato(oParam);
			if(!idMandato || idMandato == "") {
				flfactppal.iface.ponMsgError(sys.translate("No existe mandato para el cliente %1 y no se ha podido crear uno por defecto. Se cancela el proceso.").arg(qryRecibos.value("r.codcliente")),"warn",this);
				return false;
			}
			
			
			numEfectos = AQUtil.sqlSelect("mandatoscli", "numefectos", "idmandato = " + idMandato);
			
			if(numEfectos != 0){
				if(!_i.incluirInformacionPagoXML(eCstmrDrctDbtInitn, qryRecibos, "RCUR")){
					return false;
				}
			}
		}
		else{
			encontrado = false;
		}
	}while(qryRecibos.next());

	/// Fin nuevo
	
	file.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
	file.write(_i.xml_.toString(2));
	file.close();
	return true;
}

function oficial_crearDocumentoXML()
{
	var _i = this.iface;
	
	_i.xml_ = new FLDomDocument;
	_i.xml_.setContent("<Document xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns='urn:iso:std:iso:20022:tech:xsd:pain.008.001.02'/>");
}

function oficial_incluirCabeceraXML(nodoPadre)
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var curEmpresa = new FLSqlCursor("empresa");
	curEmpresa.select("cifnif = '" + flfactppal.iface.pub_valorDefectoEmpresa("cifnif") + "'");
	if(!curEmpresa.first()) {
		sys.warnMsgBox("No hay empresa.");
		return false;
	}
	curEmpresa.setModeAccess(curEmpresa.Browse);
	curEmpresa.refreshBuffer();
	
	var idRemesa = cursor.valueBuffer("idremesa");
	var nRecibos = AQUtil.sqlSelect("reciboscli r INNER JOIN pagosdevolcli pd ON r.idrecibo = pd.idrecibo","count(*)","pd.idremesa = " + idRemesa, "reciboscli")
	var totalImporte = AQUtil.sqlSelect("reciboscli r INNER JOIN pagosdevolcli pd ON r.idrecibo = pd.idrecibo","sum(r.importe)","pd.idremesa = " + idRemesa, "reciboscli");
	totalImporte = AQUtil.roundFieldValue(totalImporte,"facturascli","totaliva");
	
	var eGrpHdr = _i.colgarNodo("GrpHdr",nodoPadre);
	
	var eMsgId = _i.colgarNodo("MsgId",eGrpHdr);

	var idRemesaNodo = idRemesa.toString();
	if(this.child("cmbNorma") && this.child("cmbNorma").currentText == "Adeudos financiados (58)"){
		var prefijo = "FSDD";
		idRemesaNodo = prefijo + idRemesaNodo;
	}  
	if(!_i.colgarNodoTexto(eMsgId,idRemesaNodo,"String",1,35)) {return false;}
	
	var eCreDtTm = _i.colgarNodo("CreDtTm",eGrpHdr);
	if (!_i.colgarNodoTexto(eCreDtTm,cursor.valueBuffer("fecha"),"DateTime")) {return false;}
	
	var eNbOfTxs = _i.colgarNodo("NbOfTxs",eGrpHdr);
	if (!_i.colgarNodoTexto(eNbOfTxs,nRecibos,"int",1,15)) {return false;}
	
	/* 0 o 1 veces */
	if(1==1) {
		var eCtrlSum = _i.colgarNodo("CtrlSum",eGrpHdr);
		if (!_i.colgarNodoTexto(eCtrlSum,totalImporte,"double",3,19,2)) {return false;}
	}
	
	var eInitgPty = _i.colgarNodo("InitgPty",eGrpHdr);
	
	/* 0 o 1 veces */
	if(1==1) {
		var eNm = _i.colgarNodo("Nm",eInitgPty);
		if (!_i.colgarNodoTexto(eNm,curEmpresa.valueBuffer("nombre"),"String",1,70)) {return false;}
	}
	
	/* 0 o 1 veces */
	if(1==1){
		if(!_i.incluirIdParteXML(eInitgPty)){
			return false;
		}
	}
	return true;
}

function oficial_incluirIdParteXML(nodoPadre)
{
	var _i = this.iface;

	eId = _i.colgarNodo("Id",nodoPadre);
	
	/* Condicion OR para OrgId y PrvtId */
	if(1==1) {
		if(!_i.incluirPersonaJuridicaXML(eId)) {
			return false;
		}
	}
	else {
		if(!_i.incluirPersonaFisicaXML(eId)) {
			return false;
		}
	}
	
	return true;
}

function oficial_incluirPersonaJuridicaXML(nodoPadre)
{
	var _i = this.iface;
	
	var eOrgId = _i.colgarNodo("OrgId",nodoPadre);
	
	/* 0 o 1 veces */
	if(1==0) {
		var eBICOrBEI = _i.colgarNodo("BICOrBEI",eOrgId);
		if (!_i.colgarNodoTexto(eBICOrBEI,/* valorBICOrBEI */ "valorBicOrBei","String")) {return false;}
	}

	/* 0 o 1 veces */
	if(1==1) {
		var eOthr = _i.colgarNodo("Othr",eOrgId);
		
		var id = _i.devolverIdentificadorAcreedor();
		
		if(!id){
			return false;
		}
		
		var eId = _i.colgarNodo("Id",eOthr);
		if (!_i.colgarNodoTexto(eId,id,"String",1,35)) {return false;}

		/* 0 o 1 veces */
		if(1==0){
			var eSchmeNm = _i.colgarNodo("SchmeNm",eOthr);
			
			/* Condicion OR para Cd y ePrtry */
			if(1==0) {
				var eCd = _i.colgarNodo("Cd",eSchmeNm);
				if (!_i.colgarNodoTexto(eCd,/* valorCd */ "valorCd","String",1,4)) {return false;}
			}
			else {
				var ePrtry = _i.colgarNodo("Prtry",eSchmeNm);
				if (!_i.colgarNodoTexto(ePrtry,/* valorPrtry */ "valorPrtry","String",1,35)) {return false;}
			}
		}
		/* 0 o 1 veces */
		if(1==0){
			var eIssr = _i.colgarNodo("Issr",eOthr);
			if (!_i.colgarNodoTexto(eIssr,/* valorIssr */ "valorIssr","String",1,35)) {return false;}
		}
	}
	return true;
}

function oficial_incluirPersonaFisicaXML(nodoPadre)
{
	var _i = this.iface;
	
	ePrvtId = _i.colgarNodo("PrvtId",nodoPadre);
	
	/* 0 o 1 veces */
	if(1==0){
		var eDtAndPlcOfBirth = _i.colgarNodo("DtAndPlcOfBirth",ePrvtId);
		
		var eBirthDt = _i.colgarNodo("BirthDt",eDtAndPlcOfBirth);
		if (!_i.colgarNodoTexto(eBirthDt,/* valorBirthDt */ "valorBirthDt","Date")) {return false;}
		
		/* 0 o 1 veces */
		if(1==0){
			var ePrvcOfBirth = _i.colgarNodo("PrvcOfBirth",eDtAndPlcOfBirth);
			if (!_i.colgarNodoTexto(ePrvcOfBirth,/* valorPrvcOfBirth */ "valorPrvcOfBirth","String",1,35)) {return false;}
		}
		
		var eCityOfBirth = _i.colgarNodo("CityOfBirth",eDtAndPlcOfBirth);
		if (!_i.colgarNodoTexto(eCityOfBirth,/* valorCityOfBirth */ "valorCityOfBirth","String",1,35)) {return false;}
		
		var eCtryOfBirth = _i.colgarNodo("CtryOfBirth",eDtAndPlcOfBirth);
		if (!_i.colgarNodoTexto(eCtryOfBirth,/* valorCtryOfBirth */ "valorCtryOfBirth","String")) {return false;}
	}
	
	/* 0 o 1 veces */
	if(1==0){
		var eOthr = _i.colgarNodo("Othr",ePrvtId);
		
		var eId = _i.colgarNodo("Id",eOthr);
		if (!_i.colgarNodoTexto(eId,/* idEmpresa?? */ "valorId","String",1,35)) {return false;}

		/* 0 o 1 veces */
		if(1==0){
			var eSchmeNm = _i.colgarNodo("SchmeNm",eOthr);
			
			/* Condicion OR para Cd y ePrtry */
			if(1==0) {
				var eCd = _i.colgarNodo("Cd",eSchmeNm);
				if (!_i.colgarNodoTexto(eCd,/* valorCd */ "valorCd","String",1,4)) {return false;}
			}
			else {
				var ePrtry = _i.colgarNodo("Prtry",eSchmeNm);
				if (!_i.colgarNodoTexto(ePrtry,/* valorPrtry */ "valorPrtry","String",1,35)) {return false;}
			}
		}
		/* 0 o 1 veces */
		if(1==0){
			var eIssr = _i.colgarNodo("Issr",eOthr);
			if (!_i.colgarNodoTexto(eIssr,/* valorIssr */ "valorIssr","String",1,35)) {return false;}
		}
	}
	return true;
}
/// Nuevo
///function oficial_incluirInformacionPagoXML(nodoPadre)
function oficial_incluirInformacionPagoXML(nodoPadre, qryRecibos, tipoPago)
/// Fin nuevo
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var codCuenta = cursor.valueBuffer("codcuenta");
	var idRemesa = cursor.valueBuffer("idremesa");
	var fechaCargo = cursor.valueBuffer("fechacargo");
	
	debug("///////////////////////////// _i.numEfectos_: " + _i.numEfectos_);
	debug("///////////////////////////// _i.fechaVenc_: " + _i.fechaVenc_);
	debug("///////////////////////////// qryRecibos.value fechav: " + qryRecibos.value("r.fechav"));

	if(_i.fechaVenc_ == "fecha" || _i.numEfectos_ == "numefectos" || _i.fechaVenc_ != qryRecibos.value("r.fechav")){	
		_i.ePmtInf_ = _i.colgarNodo("PmtInf",nodoPadre);
		debug("///////////////////////////////////////////////////////////////////////// cuelgo nodo PmtInf");
	
		var ePmtInfId = _i.colgarNodo("PmtInfId",_i.ePmtInf_);
		if (!_i.colgarNodoTexto(ePmtInfId,idRemesa.toString() + "-" + codCuenta,"String",1,35)) {return false;}
	
		var ePmtMtd = _i.colgarNodo("PmtMtd",_i.ePmtInf_);
		if (!_i.colgarNodoTexto(ePmtMtd,"DD","String",1,2)) {return false;}
	
		/* 0 o 1 veces */
		if(1==0){
			var eBtchBookg = _i.colgarNodo("BtchBookg",_i.ePmtInf_);
			if (!_i.colgarNodoTexto(eBtchBookg,/* valorBtchBookg */true,"boolean")) {return false;}
		}
	
		/* 0 o 1 veces */
		if(1==0){
			var eNbOfTxs = _i.colgarNodo("NbOfTxs",_i.ePmtInf_);
			if (!_i.colgarNodoTexto(eNbOfTxs,/* valorNbOfTxs */6,"int",1,15)) {return false;}
		}
	
		/* 0 o 1 veces */
		if(1==0) {
			var eCtrlSum = _i.colgarNodo("CtrlSum",_i.ePmtInf_);
			if (!_i.colgarNodoTexto(eCtrlSum,/* valorCtrlSum */6.6,"double",3,19,2)) {return false;}
		}
	
		/* 0 o 1 veces */
		if(1==1){
			/// Nuevo
			if(!_i.incluirInformacionTipoPagoXML(_i.ePmtInf_, qryRecibos, tipoPago)) {
				return false;
			}
			/*
			if(!_i.incluirInformacionTipoPagoXML(_i.ePmtInf_)) {
				return false;
			}
			*/
			/// Fin nuevo
		}
	
		var eReqdColltnDt = _i.colgarNodo("ReqdColltnDt",_i.ePmtInf_);
		if(this.child("cmbNorma") && this.child("cmbNorma").currentText == "Adeudos financiados (58)"){
			fechaCargo = qryRecibos.value("r.fechav");
		}
		if (!_i.colgarNodoTexto(eReqdColltnDt,fechaCargo.toString().left(10),"Date")) {return false;}
	
		if(!_i.incluirAcreedorXML(_i.ePmtInf_)) {
			return false;
		}
	
		/* 0 o 1 veces */
		if(1==0){
			var eUltmtCdtr = _i.colgarNodo("UltmtCdtr",_i.ePmtInf_);
		
			var eNm = _i.colgarNodo("Nm",eUltmtCdtr);
			if (!_i.colgarNodoTexto(eNm,/*valorNm*/"valorNm","String",1,70)) {return false;}
		
			/* 0 o 1 veces */
			if(1==0) {
				if(!_i.incluirIdParteXML(eUltmtCdtr)) {
					return false;
				}
			}
		}
	
		/* 0 o 1 veces */
		if(1==1){
			var eChrgBr = _i.colgarNodo("ChrgBr",_i.ePmtInf_);
			if (!_i.colgarNodoTexto(eChrgBr,"SLEV","String",1,4)) {return false;}
		}
	
		/* 0 o 1 veces */
		if(1==1){
			var eCdtrSchmeId = _i.colgarNodo("CdtrSchmeId",_i.ePmtInf_);
		
			var eId = _i.colgarNodo("Id",eCdtrSchmeId);
		
			var ePrvtId = _i.colgarNodo("PrvtId",eId);
		
			var eOthr = _i.colgarNodo("Othr",ePrvtId);
		
			var cdtrId = _i.devolverIdentificadorAcreedor(cursor);
		
			if(!cdtrId){
				return false;
			}
			
			var eId2 = _i.colgarNodo("Id",eOthr);
			if (!_i.colgarNodoTexto(eId2,cdtrId,"String",1,35)) {return false;}
		
			var eSchmeNm = _i.colgarNodo("SchmeNm",eOthr);
		
			var ePrtry = _i.colgarNodo("Prtry",eSchmeNm);
			if (!_i.colgarNodoTexto(ePrtry,"SEPA","String",1,35)) {return false;}
		}
	}
	/// Nuevo
	/*
	var qryRecibos = new FLSqlQuery();
	var groupBy = " GROUP BY r.codcliente, r.nombrecliente, r.codcuenta";
  	qryRecibos.setSelect("r.codcliente, r.nombrecliente, r.codcuenta");
  	qryRecibos.setFrom("reciboscli r INNER JOIN pagosdevolcli pd ON r.idrecibo = pd.idrecibo");
  	qryRecibos.setWhere("pd.idremesa = " + idRemesa + " " + groupBy);
  
  	if (!qryRecibos.exec()) {
		sys.warnMsgBox("Error query.");
  		return false;
  	}
      
	while(qryRecibos.next()){
		if(!_i.incluirOperacionAdeudoXML(_i.ePmtInf_,qryRecibos)){
			return false;
		}
	}
	*/
	_i.fechaVenc_ = qryRecibos.value("r.fechav");
	var numEfectos;
	var encontrado = false;
	var tPago;
	var i = 0;	
	var curRecibos = new FLSqlCursor("reciboscli");
	
	curRecibos.select("fechav = '" + qryRecibos.value("r.fechav") + "' AND idrecibo IN (SELECT idrecibo FROM pagosdevolcli WHERE idremesa = " + cursor.valueBuffer("idremesa") + ")");
	
	while(curRecibos.next()){
		encontrado = false;
		
		numEfectos = 0;
		tPago = "";
		for(var j = 0; j < _i.incluidos_.length; j++){
			if(curRecibos.valueBuffer("idrecibo") == _i.incluidos_[j]){
				
				encontrado = true;
				j = _i.incluidos_.length;
			}
		}

		if(!encontrado){
			var oParam = new Object;
			oParam.idRecibo = curRecibos.valueBuffer("idrecibo");
			oParam.codCliente = curRecibos.valueBuffer("codcliente");
			oParam.codCuenta = codCuenta;
			oParam.codCuentaCli = curRecibos.valueBuffer("codcuenta");
			oParam.nombreCliente = curRecibos.valueBuffer("nombrecliente"); 
			oParam.fechaRem = fechaCargo;
			var idMandato = _i.dameMandato(oParam);
			if(!idMandato || idMandato == "") {
				flfactppal.iface.ponMsgError(sys.translate("No existe mandato para el cliente %1 y no se ha podido crear uno por defecto. Se cancela el proceso.").arg(curRecibos.valueBuffer("codcliente")),"warn",this);
				return false;
			}			
			
		
			numEfectos = AQUtil.sqlSelect("mandatoscli", "numefectos","idmandato = " + idMandato);
			
			if(numEfectos == 0 || !numEfectos){
				tPago = "FRST";
			}
			else if (numEfectos != 0){
				tPago = "RCUR";
			}

			if(tPago == tipoPago){
				
				if(!_i.incluirOperacionAdeudoXML(_i.ePmtInf_, qryRecibos, curRecibos)){
					return false;
				}
				_i.incluidos_.push(curRecibos.valueBuffer("idrecibo"));
				
				i++;
			}
		}
	}
	/// Fin nuevo
	return true;
}

function oficial_incluirAcreedorXML(nodoPadre)
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var curEmpresa = new FLSqlCursor("empresa");
	curEmpresa.select("cifnif = '" + flfactppal.iface.pub_valorDefectoEmpresa("cifnif") + "'");
	if(!curEmpresa.first()) {
		sys.warnMsgBox("No hay empresa.");
		return false;
	}
	curEmpresa.setModeAccess(curEmpresa.Browse);
	curEmpresa.refreshBuffer();
	
	var codCuenta = cursor.valueBuffer("codcuenta");
	
	var IBAN = AQUtil.sqlSelect("cuentasbanco","iban","codcuenta = '" + codCuenta + "'");
	var bic = AQUtil.sqlSelect("cuentasbanco","bic","codcuenta = '" + codCuenta + "'");
	
	var eCdtr = _i.colgarNodo("Cdtr",nodoPadre);
	
	/* 0 o 1 veces */
	if(1==1){
		var eNm = _i.colgarNodo("Nm",eCdtr);
		if (!_i.colgarNodoTexto(eNm,curEmpresa.valueBuffer("nombre"),"String",1,70)) {return false;}
	}
	
	/* 0 o 1 veces */
	if(1==0){
		if(!_i.incluirDireccionPostalXML(eCdtr)){
			return false;
		}
	}
	
	var eCdtrAcct = _i.colgarNodo("CdtrAcct",nodoPadre);
	
	var eId = _i.colgarNodo("Id",eCdtrAcct);
	
	if(!IBAN || IBAN == "") {
		sys.warnMsgBox(sys.translate("Falta el cÛdigo IBAN para la cuenta %1 del acreedor.").arg(codCuenta));
		return false;
	}
	
	var eIBAN = _i.colgarNodo("IBAN",eId);
	if (!_i.colgarNodoTexto(eIBAN,IBAN,"String", 1, 34)) {return false;}
	
	/* 0 o 1 veces */
	/*if(1==1){
		var divisa = flfactppal.iface.pub_valorDefectoEmpresa("coddivisa");
		
		var eCcy = _i.colgarNodo("Ccy",eCdtrAcct);
		if (!_i.colgarNodoTexto(eCcy,divisa,"String")) {return false;}
	}*/
	
	var eCdtrAgt = _i.colgarNodo("CdtrAgt",nodoPadre);
	
	var eFinInstnId = _i.colgarNodo("FinInstnId",eCdtrAgt);
	
	/*if(!bic || bic == "") {
		sys.warnMsgBox(sys.translate("Falta el cÛdigo BIC para la cuenta con IBAN %1 del acreedor.").arg(IBAN));
		return false;
	}*/
	
	if(bic && bic != ""){
		var eBIC = _i.colgarNodo("BIC",eFinInstnId);
		if (!_i.colgarNodoTexto(eBIC,bic,"String", 1, 11)) {return false;}
	}
	/*else{
		bic = "";
		if (!_i.colgarNodoTexto(eBIC,bic,"String")) {return false;}
	}*/
	
	return true;
}

function oficial_incluirDireccionPostalXML(nodoPadre)
{
	var _i = this.iface;
	
	var ePstlAdr = _i.colgarNodo("PstlAdr",nodoPadre);
	
	/* 0 o 1 veces */
	var eCtry = _i.colgarNodo("Ctry",ePstlAdr);
	if (!_i.colgarNodoTexto(eCtry,/* valorCtry */ "valorCtry","String")) {return false;}

	/* 0 a 2 veces */
	var y = 0;
	while(y < 1) {
		var eAdrLine = _i.colgarNodo("AdrLine",ePstlAdr);
		if (!_i.colgarNodoTexto(eAdrLine,/* valorAdrLine */ "valorAdrLine","String",1,70)) {return false;}
	
		y++;
	}
		
	return true;
}

/// Nuevo
///function oficial_incluirInformacionTipoPagoXML(nodoPadre)
function oficial_incluirInformacionTipoPagoXML(nodoPadre, qryRecibos, tipoPago)
/// Fin nuevo
{
	var _i = this.iface;
	
	var ePmtTpInf = _i.colgarNodo("PmtTpInf",nodoPadre);
	
	/* 0 o 1 veces */
	if(1==1){
		var eSvcLvl = _i.colgarNodo("SvcLvl",ePmtTpInf);
	
		var eCd1 = _i.colgarNodo("Cd",eSvcLvl);
		if (!_i.colgarNodoTexto(eCd1,"SEPA","String",1,4)) {return false;}
	}
	
	/* 0 o 1 veces */
	if(1==1){
		var eLclInstrm = _i.colgarNodo("LclInstrm",ePmtTpInf);
	
		var eCd2 = _i.colgarNodo("Cd",eLclInstrm);
		if(_i.tipoFichero_ == "B2B") {
			if (!_i.colgarNodoTexto(eCd2,"B2B","String",1,4)) {return false;}
		}
		else if (_i.tipoFichero_ == "CORE") {
			if (!_i.colgarNodoTexto(eCd2,"CORE","String",1,4)) {return false;}
		}
		else if (_i.tipoFichero_ == "CORE1*") {
			if (!_i.colgarNodoTexto(eCd2,"COR1*","String",1,4)) {return false;}
		}
		else {
			return false;
		}
	}

	/* 0 o 1 veces */
	if(1==1) {
		/// Nuevo
		
		var eSeqTp = _i.colgarNodo("SeqTp",ePmtTpInf);
		if (!_i.colgarNodoTexto(eSeqTp, tipoPago, "String", 1, 4)) {return false;}

		/*
		if(!_i.tipoPago_ || _i.tipoPago_ == "") {
			_i.tipoPago_ = "RCUR";
		}
		var eSeqTp = _i.colgarNodo("SeqTp",ePmtTpInf);
		if (!_i.colgarNodoTexto(eSeqTp,_i.tipoPago_,"String")) {return false;}
		*/
		///Nuevo
	}

	/* 0 o 1 veces */
	if(1==0){
		var eCtgyPurp = _i.colgarNodo("CtgyPurp",ePmtTpInf);
		
		/* Condicion OR para Cd y ePrtry */
		if(1==0) {
			var eCd3 = _i.colgarNodo("Cd",eCtgyPurp);
			if (!_i.colgarNodoTexto(eCd3,/* valorCd */ "valorCd","String",1,4)) {return false;}
		}
		else {
			var ePrtry = _i.colgarNodo("Prtry",eCtgyPurp);
			if (!_i.colgarNodoTexto(ePrtry,/* valorPrtry */ "valorPrtry","String",1,35)) {return false;}
		}
	}
	return true;
}

function oficial_incluirOperacionAdeudoXML(nodoPadre, qryRecibos, curRecibos)
{
	var _i = this.iface;
	var cursor = this.cursor();
		
	/*curRecibos.select("codcliente = '" + qryRecibos.value("r.codcliente") + "' AND codcuenta = '" + qryRecibos.value("r.codcuenta") + "' AND idrecibo IN (SELECT idrecibo FROM pagosdevolcli WHERE idremesa = " + cursor.valueBuffer("idremesa") + ")");

	if(!curRecibos.first()) {
		sys.warnMsgBox(sys.translate("No se han encontrado recibos v·lidos para el cliente %1").arg(qryRecibos.value("r.nombrecliente")));
		return false;
	}*/
		
	
	curRecibos.setModeAccess(curRecibos.Browse);
	curRecibos.refreshBuffer();
	
	var fechaRem = cursor.valueBuffer("fechacargo");
	var codCuenta = curRecibos.valueBuffer("codcuenta");
	
	var codCliente = curRecibos.valueBuffer("codcliente");
	var nombre = curRecibos.valueBuffer("nombrecliente");
	var fechaRec = curRecibos.valueBuffer("fecha");
	var idRecibo = curRecibos.valueBuffer("idrecibo");
	var curMandato = new FLSqlCursor("mandatoscli");


	var oParam = new Object;
	oParam.idRecibo = idRecibo;
	oParam.codCliente = codCliente;
	oParam.codCuenta = cursor.valueBuffer("codcuenta");
	oParam.nombreCliente = nombre;
	oParam.codCuentaCli = codCuenta; 
	oParam.fechaRem = cursor.valueBuffer("fechacargo");
	var idMandato = _i.dameMandato(oParam);
	if(!idMandato || idMandato == "") {
		flfactppal.iface.ponMsgError(sys.translate("No existe mandato para el cliente %1 y no se ha podido crear uno por defecto. Se cancela el proceso.").arg(codCliente),"warn",this);
		return false;
	}

	curMandato.select("idmandato = " + idMandato);	
	
	switch (curMandato.size()) {
		case 0: {
			break;
		}
		case 1: {
			break;
		}
		default: {
			var mandatoEncontrado = false;
			
			for(var ind = 0; ind < aCuentasMandato_.length; ind++) {
				if(aCuentasMandato_[ind] == codCuenta) {
					curMandato.select("idmandato = " + aMandatoElegido_[ind]);
					mandatoEncontrado = true;
				}
			}
			
			if(!mandatoEncontrado) {
				var opId = [];
				var opDes = [];
				
				while (curMandato.next()) {
					curMandato.setModeAccess(curMandato.Browse);
					curMandato.refreshBuffer();
					
					opId.push(curMandato.valueBuffer("idmandato"));
					opDes.push(curMandato.valueBuffer("refmandato") + " - " + curMandato.valueBuffer("descripcion"));
				}

				var idOpcion = flfactppal.iface.pub_elegirOpcion(opDes, sys.translate("Escoja mandato para la cuenta %1 del cliente %2 - %3").arg(codCuenta).arg(codCliente).arg(nombre));
		
				if (idOpcion < 0) {
					return false;
				}
		
				curMandato.select("idmandato = " + opId[idOpcion]);
				aCuentasMandato_.push(codCuenta);
				aMandatoElegido_.push(opId[idOpcion]);
			}
			break;
		}
	}
	
	var refMandato;
	var fechaCad;
	var numEfectos;
	var tipoPago;
	var fechaFirma;
	
	var mandatoPorDefecto = false;
	
	if (!curMandato.first()) {
		flfactppal.iface.ponMsgError(sys.translate("Error al localizar el mandato"),"warn",this);	
	} else {
		curMandato.setModeAccess(curMandato.Edit);
		curMandato.refreshBuffer();		
	
		refMandato = curMandato.valueBuffer("refmandato");
		//fechaCad = curMandato.valueBuffer("fechacaducidad");
		//if(fechaCad && fechaCad != "") {
		//	fechaCad = _i.formateaFecha(fechaCad,"A-M-D");
		//}		
		numEfectos = curMandato.valueBuffer("numefectos");
		tipoPago = curMandato.valueBuffer("tipopago");
		fechaFirma = curMandato.valueBuffer("fechafirma");		
		if(!fechaFirma || fechaFirma == "") {
			fechaFirma = "2016-02-01";
		}	else {
			fechaFirma = _i.formateaFecha(fechaFirma,"A-M-D");
		}
	}
	
	var tipoAdeudo;
	
	if(numEfectos != 0) {
		tipoAdeudo = "RCUR";
	} else {
		if(tipoPago == "Pago Recurrente") {
			tipoAdeudo = "FRST";
		} else {
			tipoAdeudo = "OOFF";
		}
	}
	
	var eDrctDbtTxInf = _i.colgarNodo("DrctDbtTxInf",nodoPadre);

	var bicBanco = AQUtil.sqlSelect("cuentasbcocli","bic","codcuenta = '" + curRecibos.valueBuffer("codcuenta") + "'");
	var IBAN = AQUtil.sqlSelect("cuentasbcocli","iban","codcuenta = '" + curRecibos.valueBuffer("codcuenta") + "'");

	var ePmtId = _i.colgarNodo("PmtId",eDrctDbtTxInf);

	var eEndToEndId = _i.colgarNodo("EndToEndId",ePmtId);
	if (!_i.colgarNodoTexto(eEndToEndId,curRecibos.valueBuffer("codigo"),"String",1,35)) {return false;}

	var eInstdAmt = _i.colgarNodo("InstdAmt",eDrctDbtTxInf);
	eInstdAmt.setAttribute("Ccy",curRecibos.valueBuffer("coddivisa"));
	
	var importeRecibo = curRecibos.valueBuffer("importe");
	importeRecibo = AQUtil.roundFieldValue(importeRecibo,"facturascli","totaliva");
	
	if (!_i.colgarNodoTexto(eInstdAmt,importeRecibo,"double",3,12,2)) {return false;}

	/* 0 o 1 veces */
	if(1==1){
		var eDrctDbtTx = _i.colgarNodo("DrctDbtTx",eDrctDbtTxInf);
		
		var eMndtRltdInf = _i.colgarNodo("MndtRltdInf",eDrctDbtTx);
		
		var eMndtId = _i.colgarNodo("MndtId",eMndtRltdInf);
		if (!_i.colgarNodoTexto(eMndtId,refMandato,"String",1,35)) {return false;}
		
		var eDtOfSgntr = _i.colgarNodo("DtOfSgntr",eMndtRltdInf);
		if (!_i.colgarNodoTexto(eDtOfSgntr,fechaFirma,"Date",8,10)) {return false;}
	}

	var eDbtrAgt = _i.colgarNodo("DbtrAgt",eDrctDbtTxInf);

	var eFinInstnId = _i.colgarNodo("FinInstnId",eDbtrAgt);
	
	if(!IBAN || IBAN == "") {
		sys.warnMsgBox(sys.translate("Falta el cÛdigo IBAN para la cuenta %1 del cliente %2").arg(codCuenta).arg(nombre));
		return false;
	}
	
	/*if(!bicBanco || bicBanco == "") {
		sys.warnMsgBox(sys.translate("Falta el cÛdigo BIC para la cuenta con IBAN %1 del cliente %2").arg(IBAN).arg(nombre));
		return false;
	}*/

	if(bicBanco && bicBanco != ""){
		var eBIC = _i.colgarNodo("BIC",eFinInstnId);
		if (!_i.colgarNodoTexto(eBIC,bicBanco,"String",1,11)) {return false;}
	}
	/*else{
		bicBanco = "";
		if (!_i.colgarNodoTexto(eBIC,bicBanco,"String")) {return false;}
	}*/

	if(!_i.incluirDeudorXML(eDrctDbtTxInf,qryRecibos,curRecibos)){
		return false;
	}

	var eDbtrAcct = _i.colgarNodo("DbtrAcct", eDrctDbtTxInf);

	var eId = _i.colgarNodo("Id",eDbtrAcct);

	var eIBAN = _i.colgarNodo("IBAN",eId);
	if (!_i.colgarNodoTexto(eIBAN,IBAN,"String", 1, 34)) {return false;}
	
	var eRmtInf = _i.colgarNodo("RmtInf", eDrctDbtTxInf);
	var eUstrd = _i.colgarNodo("Ustrd", eRmtInf);
	if (!_i.colgarNodoTexto(eUstrd, sys.translate("Recibo") + " " + curRecibos.valueBuffer("codigo"), "String")) {
		return false;
	}

	//if(!mandatoPorDefecto) {   //Esto se comentÛ porque ahora creamos el mandato cuando genera uno por defecto.
	var curPagos = new FLSqlCursor("pagosdevolcli");
	curPagos.select("idrecibo = " + curRecibos.valueBuffer("idrecibo") + " AND idremesa = " + cursor.valueBuffer("idremesa"));

	while(curPagos.next()) {
		curPagos.setModeAccess(curPagos.Edit);
		curPagos.refreshBuffer();
	
		curPagos.setValueBuffer("idmandato", curMandato.valueBuffer("idmandato"));
	
		if(!curPagos.commitBuffer())
			return false;
	}
	curMandato.setValueBuffer("numefectos", formRecordmandatoscli.iface.pub_commonCalculateField("numefectos", curMandato));
	curMandato.setValueBuffer("fechaultadeudo", cursor.valueBuffer("fechacargo"));
	curMandato.setValueBuffer("fechacaducidad", formRecordmandatoscli.iface.pub_commonCalculateField("fechacaducidad", curMandato));

	if (!curMandato.commitBuffer()) {
		return false;
	}
		//}
	
	return true;
}

function oficial_incluirDeudorXML(nodoPadre,qryRecibos,curRecibos)
{
	var _i = this.iface;
	
	var eDbtr = _i.colgarNodo("Dbtr",nodoPadre);
	
	/* 0 o 1 veces */
	if(1==1){
		var eNm = _i.colgarNodo("Nm",eDbtr);

		debug("////////////////////// NOMBRE CLIENTE: " + curRecibos.valueBuffer("nombrecliente"));

		if (!_i.colgarNodoTexto(eNm,curRecibos.valueBuffer("nombrecliente"),"String",1,70)) {return false;}
	}
	
	/* 0 o 1 veces */
	if(1==0){		
		if(!_i.incluirDireccionPostalXML(eDbtr)){
			return false;
		}
	}
	
	if(1==0){
		if(!_i.incluirIdParteXML(eDbtr)){
			return false;
		}
	}
	
	return true;
}

function oficial_colgarNodo(nombreHijo, nodoPadre)
{
	var _i = this.iface;
	
	var eHijo = _i.xml_.createElement(nombreHijo);
	
	if(nodoPadre == "raiz") {
		nodoPadre = _i.xml_.firstChild.toElement();
	}
	
	nodoPadre.appendChild(eHijo);

	return eHijo;
}

function oficial_colgarNodoTexto(nodoPadre, valor, tipo, min, max, decimales)
{
	var _i = this.iface;

	if(typeof(valor) == "string"){
		valor = _i.formateaCadena(valor);
	}
	
	if(max && max > 0){
		if (tipo == "String") {
			valor = valor.toString().left(max);
		}
	}
	
	if(!_i.validarTextoNodo(valor, tipo, min, max, decimales)) {
		return false;
	}
	
	var eHijo = _i.xml_.createTextNode("nodoTexto");
	nodoPadre.appendChild(eHijo);
	eHijo.setNodeValue(valor);
	
	return true;
}

function oficial_validarTextoNodo(valor, tipo, min, max, decimales)
{
	var _i = this.iface;
	
	var typeOf = typeof(valor);
	var str = valor.toString();
	
	switch(tipo) {
		case "String": {
			if(typeOf != "string") {
				sys.warnMsgBox(sys.translate("El valor debe ser una cadena de texto."));
				return false;
			}
			if(min && valor.length < min) {
				sys.warnMsgBox(sys.translate("Longitud de campo por debajo del mÌnimo."));
				return false;
			}
			if(max && valor.length > max) {
			/**cortar*/
				sys.warnMsgBox(sys.translate("Excedida la longitud m·xima de campo."));
				return false;
			}
			break;
		}
		case "int": {
			if(typeOf != "number") {
				sys.warnMsgBox(sys.translate("El valor debe ser un n˙mero entero."));
				return false;
			}
			for(var i = 0; i < str.length; i++){
				if(str.charAt(i) > '9' || str.charAt(i) < '0'){
					sys.warnMsgBox(sys.translate("El valor no debe contener decimales."));
					return false;
				}
			}
			if(min && str.length < min) {
				sys.warnMsgBox(sys.translate("Longitud de campo por debajo del mÌnimo."));
				return false;
			}
			if(max && str.length > max) {
				sys.warnMsgBox(sys.translate("Excedida la longitud m·xima de campo."));
				return false;
			}
			break;
		}
		case "double": {
			if(min && str.length < min) {
				sys.warnMsgBox(sys.translate("Longitud de campo por debajo del mÌnimo."));
				return false;
			}
			if(max && str.length > max) {
				sys.warnMsgBox(sys.translate("Excedida la longitud m·xima de campo."));
				return false;
			}
			if(decimales > 0) {
				var dec = 0;
				var punto = false;
				for(var i = 0; i < str.length; i++){
					if(punto){
						dec++;
					}
					if(str.charAt(i) > '9' || str.charAt(i) < '0'){
						punto = true;
					}
				}
				if(dec > decimales) {
					sys.warnMsgBox(sys.translate("La parte decimal excede la longitud requerida."));
					return false;
				}
			}
			break;
		}
		case "boolean": {
			if(typeOf != "boolean") {
				sys.warnMsgBox(sys.translate("El valor debe ser verdadero o falso."));
				return false;
			}
			break;
		}
		case "Date": {
			if(str.length != 10) {
				sys.warnMsgBox(sys.translate("El formato de la fecha debe ser 'YYYY-MM-DD'."));
				return false;
			}
			break;
		}
		case "DateTime": {
			if(str.length != 19) {
				sys.warnMsgBox(sys.translate("El formato de la fecha debe ser 'YYYY-MM-DDThh:mm:ss'."));
				return false;
			}
			break;
		}
		default: {
			sys.warnMsgBox(sys.translate("Formato no v·lido."))
			return false;
			break;
		}
	}
	return true;
}

function oficial_formateaFecha(fecha, tipoFecha)
{
	var _i = this.iface;
	
	var anyo, mes, dia, hora, minuto, segundo, milisegundo;
	
	switch(tipoFecha){
		case "AMDhms": {
			hora = fecha.getHours().toString();
			minuto = fecha.getMinutes().toString();
			segundo = fecha.getSeconds().toString();
			milisegundo = fecha.getMilliseconds().toString();
			anyo = fecha.getYear().toString();
			mes = fecha.getMonth().toString();
			dia = fecha.getDate().toString();
			break;
		}
		case "A-M-D":
		case "AMD": {
			hora = "";
			minuto = "";
			segundo = "";
			milisegundo = "";
			anyo = fecha.getYear().toString();
			mes = fecha.getMonth().toString();
			dia = fecha.getDate().toString();
			break;
		}
		default: {
			return "";
		}
	}
	
	if(hora != "" && hora.length < 2) {
		hora = flfactppal.iface.pub_cerosIzquierda(hora,2);
	}
	if(minuto != "" && minuto.length < 2) {
		minuto = flfactppal.iface.pub_cerosIzquierda(minuto,2);
	}
	if(segundo != "" && segundo.length < 2) {
		segundo = flfactppal.iface.pub_cerosIzquierda(segundo,2);
	}
	if(anyo != "" && anyo.length < 4) {
		anyo = flfactppal.iface.pub_cerosIzquierda(anyo,4);
	}
	if(mes != "" && mes.length < 2) {
		mes = flfactppal.iface.pub_cerosIzquierda(mes,2);
	}
	if(dia != "" && dia.length < 2) {
		dia = flfactppal.iface.pub_cerosIzquierda(dia,2);
	}
	if(milisegundo != "" && milisegundo.length < 5) {
		milisegundo = flfactppal.iface.pub_cerosIzquierda(milisegundo,5);
	}
	else if(milisegundo > 5){
		milisegundo = milisegundo.toString().left(5);
	}
	
	var nuevaFecha;
	
	if(tipoFecha == "A-M-D") {
		nuevaFecha = anyo + "-" + mes + "-" + dia;
	}
	else {
		nuevaFecha = anyo + mes + dia + hora + minuto + segundo + milisegundo;
	}
	

	return nuevaFecha;
}

function oficial_formateaCadena(cIn)
{
	var cOut = "";
	var equivA = "—Ò«Á¡·…ÈÕÌ”Û⁄˙¿‡»ËÃÏ“ÚŸ˘¬‚ ÍŒÓ‘Ù€˚ƒ‰ÀÎœÔ÷ˆ‹¸";
	var equivB = "NnCcAaEeIiOoUuAaEeIiOoUuAaEeIiOoUuAaEeIiOoUu";
	var validos = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ /-?+:,.()";
	var iEq;
	for (var i = 0; i < cIn.length; i++) {
		iEq = equivA.find(cIn.charAt(i));
		if (iEq >= 0) {
			cOut += equivB.charAt(iEq);
		} else {
			if (validos.find(cIn.charAt(i)) >= 0) {
				cOut += cIn.charAt(i);
			}
		}
	}
	return cOut;
}

function oficial_bngFormatoFichero_clicked(opcion)
{
	var _i = this.iface;
	
	switch (opcion) {
		case 0: {
			_i.extensionFichero_ = "txt";
			this.child("gbxTipoPago").close();
			break;
		}
		case 1: {
			_i.extensionFichero_ = "xml";
			this.child("gbxTipoPago").show();
			break;
		}
		default: {
			return false;
		}
	}
}

function oficial_bngTipoPago_clicked(opcion)
{
	var _i = this.iface;
	
	switch (opcion) {
		case 0: {
			_i.tipoPago_ = "RCUR";
			break;
		}
		case 1: {
			_i.tipoPago_ = "OOFF";
			break;
		}
		default: {
			return false;
		}
	}
}

function oficial_bngTipoFichero_clicked(opcion)
{
	var _i = this.iface;
	
	switch (opcion) {
		case 0: {
			_i.tipoFichero_ = "CORE";
			break;
		}
		case 1: {
			_i.tipoFichero_ = "B2B";
			break;
		}
		case 2: {
			_i.tipoFichero_ = "CORE1*";
			break;
		}
		default: {
			return false;
		}
	}
		
}

function oficial_comprobarValidate()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var aDatosCuentas = _i.comprobarMandatos();

	if(!aDatosCuentas || aDatosCuentas.length == 0) {
		return false;
	}
	if(!aDatosCuentas[0]) {
		return true;
	}
	
	var mensaje = "";
	
	if(aDatosCuentas[1].length != 0) {
		mensaje += "Hay " + aDatosCuentas[1].length + " recibos que no tienen cuentas v·lidas.\n";
	}
	if(aDatosCuentas[2].length != 0) {
		mensaje += "Hay " + aDatosCuentas[2].length + " cuentas que no tienen IBAN v·lido.\n";
	}
	if(aDatosCuentas[4].length != 0) {
		mensaje += "Hay " + aDatosCuentas[4].length + " cuentas que no tienen BIC v·lido.\n";
	}
	if(aDatosCuentas[3].length != 0) {
		mensaje += "Hay " + aDatosCuentas[3].length + " cuentas que no tienen mandatos v·lidos.\n";
	}
	if(aDatosCuentas[5].length != 0) {
		mensaje += "Falta el cÛdigo BIC para la cuenta del acreedor.\n";
	}
	
	mensaje += "\nPuede exportarlas a un fichero pulsando el botÛn 'Exportar cuentas con mandatos errÛneos', en el formulario actual.\n\n"
				

	//if(aDatosCuentas[1].length != 0 || aDatosCuentas[2].length != 0 || aDatosCuentas[4].length != 0) {
	if(aDatosCuentas[1].length != 0 || aDatosCuentas[2].length != 0) {
		mensaje += "Debe rectificar los recibos/cuentas errÛneos para poder remesar los recibos.";
		sys.infoMsgBox(sys.translate(mensaje));
		return false;
	}
	else if(_i.tipoFichero_ != "B2B") {
		mensaje += "De todas formas, øQuiere continuar? Se asignar·n valores de mandato por defecto.";
		
		var res = MessageBox.information(sys.translate(mensaje), MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
 		if (res != MessageBox.Yes) {
    		return false;
  		}
	}
	else {
		mensaje += "En un adeudo B2B debe incluir sÛlo mandatos v·lidos.";
		sys.infoMsgBox(sys.translate(mensaje));
		return false;
	}

	return true;
}

function oficial_comprobarMandatos()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var recibosError = [];
	var cuentasError = [];
	var bicError = [];
	var mandatosError = [];
	var bicErrorBanco = [];
	
	var error = false;
	
	var idRemesa = cursor.valueBuffer("idremesa");
	var fechaRem = cursor.valueBuffer("fechacargo");
	
	var qryRecibos = new FLSqlQuery();
	var groupBy = " GROUP BY r.codigo, r.codcliente, r.nombrecliente, r.codcuenta";
  	qryRecibos.setSelect("r.codigo, r.codcliente, r.nombrecliente, r.codcuenta");
  	qryRecibos.setFrom("reciboscli r INNER JOIN pagosdevolcli pd ON r.idrecibo = pd.idrecibo");
  	qryRecibos.setWhere("pd.idremesa = " + idRemesa + " " + groupBy);
  
  	if (!qryRecibos.exec()) {
		sys.warnMsgBox("Error query.");
  		return false;
  	}
      
	while(qryRecibos.next()){
		var curRecibos = new FLSqlCursor("reciboscli");				
		curRecibos.select("codcliente = '" + qryRecibos.value("r.codcliente") + "' AND nombrecliente like '" + _i.quitaApostrofes(qryRecibos.value("r.nombrecliente")) + "' AND codcuenta = '" + qryRecibos.value("r.codcuenta") + "' AND idrecibo IN (SELECT idrecibo FROM pagosdevolcli WHERE idremesa = " + cursor.valueBuffer("idremesa") + ")");
			
		if(!qryRecibos.value("r.codcuenta") || qryRecibos.value("r.codcuenta") == "") {
				var nArray = [qryRecibos.value("r.codigo"),qryRecibos.value("r.codcliente"),qryRecibos.value("r.nombrecliente")];
				recibosError.push(nArray);
				error = true;
				continue;
		}
		
		while(curRecibos.next()) {
			curRecibos.setModeAccess(curRecibos.Browse);
			curRecibos.refreshBuffer();
					
			var codCuenta = curRecibos.valueBuffer("codcuenta");
			var codCuentaBanco = curRecibos.valueBuffer("codcuentapagocli");
			var nombre = curRecibos.valueBuffer("nombrecliente");
			var codCliente = curRecibos.valueBuffer("codcliente");
			var fechaRec = curRecibos.valueBuffer("fecha");
			var IBAN = AQUtil.sqlSelect("cuentasbcocli","iban","codcuenta = '" + codCuenta + "'");
			var BIC = AQUtil.sqlSelect("cuentasbcocli","bic","codcuenta = '" + codCuenta + "'");
			var BICCuentaBanco = AQUtil.sqlSelect("cuentasbanco","bic","codcuenta = '" + codCuentaBanco + "'");
			var IBANBanco = AQUtil.sqlSelect("cuentasbanco","iban","codcuenta = '" + codCuentaBanco + "'");
			
			if(!IBAN || IBAN == "") {
				var encontrado = false;
				for(var i = 0; i < cuentasError.length; i++) {
					if(cuentasError[i][0] == codCuenta) {
						encontrado = true;
						break;
					}
				}
				if(!encontrado) {
					var nArray = [codCuenta,codCliente,nombre];
					cuentasError.push(nArray);
					error = true;
				}
			}
			
			if(!BIC || BIC == "") {
				var encontrado = false;
				for(var i = 0; i < bicError.length; i++) {
					if(bicError[i][0] == codCuenta) {
						encontrado = true;
						break;
					}
				}
				if(!encontrado) {
					if(!IBAN || IBAN == "") {
						IBAN = "noIBAN";
					}
					var nArray = [codCuenta,IBAN,codCliente,nombre];
					bicError.push(nArray);
					error = true;
				}
			}

			if(!BICCuentaBanco || BICCuentaBanco == "") {
				var encontrado = false;
				for(var i = 0; i < bicErrorBanco.length; i++) {
					if(bicErrorBanco[i][0] == codCuentaBanco) {
						encontrado = true;
						break;
					}
				}
				if(!encontrado) {
					if(!IBANBanco || IBANBanco == "") {
						IBANBanco = "noIBAN";
					}
					var nArray = [codCuentaBanco,IBANBanco,];
					bicErrorBanco.push(nArray);
					error = true;
				}
			}
		
			var curMandato = new FLSqlCursor("mandatoscli");
			curMandato.select("codcuentacliente = '" + codCuenta + "' AND tipo = '" + _i.tipoFichero_ + "'");
			
			if(curMandato.size() == 0) {
				var encontrado = false;
				for(var i = 0; i < mandatosError.length; i++) {
					if(mandatosError[i][0] == codCuenta) {
						encontrado = true;
						break;
					}
				}
				if(!encontrado) {
					if(!IBAN || IBAN == "") {
						IBAN = "noIBAN";
					}
					var nArray = [codCuenta,IBAN,codCliente,nombre];
					mandatosError.push(nArray);
				}
			}
		} while(curRecibos.next());
	}
	
	var aDatosCuentas = [];
	aDatosCuentas.push(error);
	aDatosCuentas.push(recibosError);
	aDatosCuentas.push(cuentasError);
	aDatosCuentas.push(mandatosError);
	aDatosCuentas.push(bicError);
	aDatosCuentas.push(bicErrorBanco);
	
	return aDatosCuentas;
}
	
function oficial_tbnExportarErroneos_clicked() {
	var _i = this.iface;
	var cursor = this.cursor();
	
	var aDatosCuentas = _i.comprobarMandatos();
	
	if(!aDatosCuentas || aDatosCuentas.length == 0) {
		return false;
	}
	if(!aDatosCuentas[0]) {
		sys.infoMsgBox(sys.translate("Todos los recibos, cuentas y mandatos son v·lidos, no se generar· el fichero."));
		return false;
	}
	
	if(aDatosCuentas[1].length != 0 || aDatosCuentas[2].length != 0 || aDatosCuentas[3].length != 0 || aDatosCuentas[4].length != 0) {
		var archivo = FileDialog.getSaveFileName("*.txt");
		
		if(!archivo || archivo == "") {
			return false;
		}
		
		if(!archivo.endsWith(".txt")) {
			archivo += ".txt";
		}
		
		var file = new File(archivo);
		file.open(File.WriteOnly);
		
		var mensaje = "";
		
		if(aDatosCuentas[1].length != 0) {
			mensaje += "Los siguientes recibos no tienen cuentas v·lidos:\n\n";
			for(var i = 0; i < aDatosCuentas[1].length; i++) {
				mensaje += "     Recibo " + aDatosCuentas[1][i][0] + " del cliente " + aDatosCuentas[1][i][1] + " - " + aDatosCuentas[1][i][2] + "\n";
			}
			mensaje += "\n\n";
		}
		if(aDatosCuentas[2].length != 0) {
			mensaje += "Las siguientes cuentas no tienen IBAN v·lido:\n\n";
			for(var i = 0; i < aDatosCuentas[2].length; i++) {
				mensaje += "     Cuenta " + aDatosCuentas[2][i][0] + " del cliente " + aDatosCuentas[2][i][1] + " - " + aDatosCuentas[2][i][2] + "\n";
			}
			mensaje += "\n\n";
		}
		if(aDatosCuentas[3].length != 0) {
			mensaje += "Las siguientes cuentas no tienen mandatos v·lidos:\n\n";
			for(var i = 0; i < aDatosCuentas[3].length; i++) {
				mensaje += "     Cuenta " + aDatosCuentas[3][i][0] + " - " + aDatosCuentas[3][i][1] + " del cliente " + aDatosCuentas[3][i][2] + " - " + aDatosCuentas[3][i][3] + "\n";
			}
			mensaje += "\n\n";
		}
		if(aDatosCuentas[4].length != 0) {
			mensaje += "Las siguientes cuentas no tienen BIC v·lido:\n\n";
			for(var i = 0; i < aDatosCuentas[4].length; i++) {
				mensaje += "     Cuenta " + aDatosCuentas[4][i][0] + " - " + aDatosCuentas[4][i][1] + " del cliente " + aDatosCuentas[4][i][2] + " - " + aDatosCuentas[4][i][3] + "\n";
			}
			mensaje += "\n\n";
		}
		
		file.write(mensaje);
		file.close();
		
		sys.infoMsgBox(sys.translate("El fichero se ha generado con Èxito en %1").arg(archivo));
	}
	else {
		sys.infoMsgBox(sys.translate("Todos los recibos, cuentas y mandatos son v·lidos, no se generar· el fichero."));
	}
	
	return true;
}

function oficial_quitaApostrofes(texto){

	var cOut = "";
	var apostrofe = "'";
	for (var i = 0; i < texto.length; i++) {
		if(texto.charAt(i) == apostrofe){
			cOut += '%';
		}
		else{
			cOut += texto.charAt(i);
		}
	}
	
	return cOut;
}

function oficial_dameMandato(oParam)
{
	var _i = this.iface;						    
	var idRecibo = oParam.idRecibo;
	var fechaRem = oParam.fechaRem;
	var idMandato = _i.dameQueryMandato(idRecibo, fechaRem);

	if(!idMandato || idMandato == "") {		
		idMandato = _i.crearMandatoDefecto(oParam);		
	}

	return idMandato;
}

function oficial_crearMandatoDefecto(oParam)
{
	var _i = this.iface;

	var codCliente = oParam.codCliente;
	var codCuenta = oParam.codCuenta;
	var nombreCliente = oParam.nombreCliente; 
	var codCuentaCli = oParam.codCuentaCli; 

	debug("\n\n************Creando Mandato por defecto para " + _i.tipoFichero_ + " para el cliente: "+codCliente);
	debug("codCuenta: "+codCuenta);
	debug("nombreCliente: "+nombreCliente);
	debug("codCuentaCli: "+codCuentaCli);

	var curMandato = new FLSqlCursor("mandatoscli");
	curMandato.setModeAccess(curMandato.Insert);
	curMandato.refreshBuffer();
	var refMandato = flfacturac.iface.pub_cerosIzquierda(codCliente,6) + flfacturac.iface.pub_cerosIzquierda("0", 29);	
	var numEfectos = 0;
	var tipoPago = "Pago Recurrente";
	var mandatoPorDefecto = true;
	var fechaFirma = "2016-02-01";
	if(refMandato == "" || !refMandato){
		return false;
	}
	curMandato.setValueBuffer("refmandato", refMandato);
	curMandato.setValueBuffer("codcuenta", codCuenta);
	curMandato.setValueBuffer("descripcion", "Mandato Defecto " + nombreCliente);		
	curMandato.setValueBuffer("numefectos", numEfectos);
	curMandato.setValueBuffer("tipopago", tipoPago);
	curMandato.setValueBuffer("fechafirma", fechaFirma);
	curMandato.setValueBuffer("codcliente", codCliente);
	curMandato.setValueBuffer("codcuentacliente", codCuentaCli);
	curMandato.setValueBuffer("lugarfirma", "");
	if(!curMandato.commitBuffer()){
		return false;
	}
	return curMandato.valueBuffer("idmandato");
}

function oficial_dameQueryMandato(idRecibo, fechaRem)
{
	var _i = this.iface;	
	
	return AQUtil.sqlSelect("reciboscli r INNER JOIN pagosdevolcli pd ON r.idrecibo = pd.idrecibo LEFT JOIN mandatoscli mc ON mc.codcuentacliente = r.codcuenta AND mc.tipo = '" + _i.tipoFichero_ + "' and ('" + fechaRem + "' <= mc.fechacaducidad or mc.fechacaducidad is null) and '" + fechaRem + "' >= mc.fechafirma","mc.idmandato","r.idrecibo = " + idRecibo,"reciboscli,pagosdevolcli");	
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
