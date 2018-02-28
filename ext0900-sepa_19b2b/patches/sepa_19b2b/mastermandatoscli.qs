var form = this;
/***************************************************************************
                      mastermandatoscli.qs  -  description
                             -------------------
    begin                : vie ene 10 2014
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
  var textos_;
  var codCliente_;
  function oficial(context)
  {
    interna(context);
  }
  function imprimir()
  {
    return this.ctx.oficial_imprimir();
  }
  function inicializaArray(aTextos)
  {
    return this.ctx.oficial_inicializaArray(aTextos);
  }
  function dameValorArray(campo, idioma)
  {
    return this.ctx.oficial_dameValorArray(campo, idioma);
  }
  function dameIdiomaMandato()
  {
    return this.ctx.oficial_dameIdiomaMandato();
  }
  function dameArrayTextos(aTextos)
  {
    return this.ctx.oficial_dameArrayTextos(aTextos);
  }
  function setValorCliente(codCliente)
	{
		return this.ctx.oficial_setValorCliente(codCliente);
	}
	function inicializarArrayTextos()
	{
		return this.ctx.oficial_inicializarArrayTextos();
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
  function pub_dameValorArray(campo, idioma)
  {
    return this.dameValorArray(campo, idioma);
  }
  function pub_dameIdiomaMandato()
  {
    return this.dameIdiomaMandato();
  }
	function pub_dameArrayTextos(aTextos)
	{
		return this.dameArrayTextos(aTextos);
	}
	function pub_setValorCliente(codCliente)
	{
		return this.setValorCliente(codCliente);
	}
	function pub_inicializarArrayTextos()
	{
		return this.inicializarArrayTextos();
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

  connect(this.child("toolButtonPrint"), "clicked()", _i, "imprimir");
  _i.textos_ = [];
  _i.inicializaArray(_i.textos_);
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_imprimir()
{
  var _i = this.iface;
  var cursor = this.cursor();
  _i.setValorCliente(cursor.valueBuffer("codcliente")); 
  var tipoInforme = cursor.valueBuffer("tipo");

  if (!tipoInforme || tipoInforme == "") {
    return false;
  }

  var idMandato = cursor.valueBuffer("idmandato");
  var curImprimir = new FLSqlCursor("i_mandatoscli");
  curImprimir.setModeAccess(curImprimir.Insert);
  curImprimir.refreshBuffer();
  curImprimir.setValueBuffer("descripcion", "temp");
  curImprimir.setValueBuffer("i_mandatoscli_idmandato", idMandato);

  var nombreInforme;

  switch (tipoInforme) {
    case "B2B": {
      nombreInforme = "i_mandatoscli_sepab2b";
      break;
    }
    case "CORE1*":
    case "CORE": {
      nombreInforme = "i_mandatoscli_sepa";
      break;
    }
    default: {
      return false;
    }
  }

  var idEmpresa = flfactppal.iface.pub_valorDefectoEmpresa("id");

  flfactinfo.iface.pub_lanzarInforme(curImprimir, nombreInforme, "", "", false, false, "empresa.id = " + idEmpresa);

  return true;
}
function oficial_inicializaArray(aTextos)
{
  var _i = this.iface;
  
	//00_lblorden	
	aTextos["00_lblorden"] = new Array(2);
	aTextos["00_lblorden"]["ES"] = sys.translate("Orden de domiciliación de adeudo directo SEPA");
	aTextos["00_lblorden"]["EN"] = sys.translate("SEPA Direct Debit Mandate");
	aTextos["00_lblorden"]["FR"] = sys.translate("Mandat de prelevement SEPA");
	aTextos["00_lblorden"]["IT"] = sys.translate("Mandato di addebito diretto SEPA");
	aTextos["00_lblorden"]["PT"] = sys.translate("Autorização de Débito Direto SEPA");
	
	//00_lblorden_BTB
	aTextos["00_lblorden_BTB"] = new Array(2);
	aTextos["00_lblorden_BTB"]["ES"] = sys.translate("Orden de domiciliación de adeudo directo SEPA B2B");
	aTextos["00_lblorden_BTB"]["EN"] = sys.translate("SEPA Business-to-Business Direct Debit Mandate");
	aTextos["00_lblorden_BTB"]["FR"] = sys.translate("Mandat de prelevement SEPA B2B");
	aTextos["00_lblorden_BTB"]["IT"] = sys.translate("Mandato di addebito diretto SEPA B2B");
	aTextos["00_lblorden_BTB"]["PT"] = sys.translate("Autorização de Débito Direto SEPA B2B");
	
	//01_lblrefmandato
	aTextos["01_lblrefmandato"] = new Array(2);
	aTextos["01_lblrefmandato"]["ES"] = sys.translate("Referencia de la orden de domiciliación:");
	aTextos["01_lblrefmandato"]["EN"] = sys.translate("Mandate Reference:");
	aTextos["01_lblrefmandato"]["FR"] = sys.translate("Réference unique du mandat:");
	aTextos["01_lblrefmandato"]["IT"] = sys.translate("Riferimento univoco al mandato:");
	aTextos["01_lblrefmandato"]["PT"] = sys.translate("Referência da autorização:");

	//02_lblidentacreedor
	aTextos["02_lblidentacreedor"] = new Array(2);
	aTextos["02_lblidentacreedor"]["ES"] = sys.translate("Identificador del acreedor:");
	aTextos["02_lblidentacreedor"]["EN"] = sys.translate("Creditor Identifier:");
	aTextos["02_lblidentacreedor"]["FR"] = sys.translate("Identifiant créancier:");
	aTextos["02_lblidentacreedor"]["IT"] = sys.translate("Codice identificativo del beneficiario:");
	aTextos["02_lblidentacreedor"]["PT"] = sys.translate("Código de Identificação do Credor:");
	
	//03_lblnombreacreedor
	aTextos["03_lblnombreacreedor"] = new Array(2);	
	aTextos["03_lblnombreacreedor"]["ES"] = sys.translate("Nombre del acreedor:");
	aTextos["03_lblnombreacreedor"]["EN"] = sys.translate("Creditor Identifier:");
	aTextos["03_lblnombreacreedor"]["FR"] = sys.translate("Nom du créancier:");
	aTextos["03_lblnombreacreedor"]["IT"] = sys.translate("Nome del beneficiario:");
	aTextos["03_lblnombreacreedor"]["PT"] = sys.translate("Nome do Credor:");
	
	//04_lbldireccionacreedor
	aTextos["04_lbldireccionacreedor"] = new Array(2);
	aTextos["04_lbldireccionacreedor"]["ES"] = sys.translate("Dirección:");
	aTextos["04_lbldireccionacreedor"]["EN"] = sys.translate("Address:");
	aTextos["04_lbldireccionacreedor"]["FR"] = sys.translate("Adresse:");
	aTextos["04_lbldireccionacreedor"]["IT"] = sys.translate("Indirizzo:");
	aTextos["04_lbldireccionacreedor"]["PT"] = sys.translate("Nome da rua e número:");
	
	//05_lblcpciudadprovinciaacreedor
	aTextos["05_lblcpciudadprovinciaacreedor"] = new Array(2);
	aTextos["05_lblcpciudadprovinciaacreedor"]["ES"] = sys.translate("Código Postal - Población - Provincia:");
	aTextos["05_lblcpciudadprovinciaacreedor"]["EN"] = sys.translate("Postal Code - City - Town:");
	aTextos["05_lblcpciudadprovinciaacreedor"]["FR"] = sys.translate("Code postal - Ville:");
	aTextos["05_lblcpciudadprovinciaacreedor"]["IT"] = sys.translate("Codice di avviamento postale - Città:");
	aTextos["05_lblcpciudadprovinciaacreedor"]["PT"] = sys.translate("Código Postal:");
	
	//06_lblpaisacreedor
	aTextos["06_lblpaisacreedor"] = new Array(2);
	aTextos["06_lblpaisacreedor"]["ES"] = sys.translate("País:");
	aTextos["06_lblpaisacreedor"]["EN"] = sys.translate("Country:");
	aTextos["06_lblpaisacreedor"]["FR"] = sys.translate("Pays:");
	aTextos["06_lblpaisacreedor"]["IT"] = sys.translate("Paese:");
	aTextos["06_lblpaisacreedor"]["PT"] = sys.translate("País:");
	
	//07_lblautoriza
	aTextos["07_lblautoriza"] = new Array(2);
	aTextos["07_lblautoriza"]["ES"] = sys.translate("Mediante la firma de esta orden de domiciliación, el deudor autoriza (A) al acreedor a enviar instrucciones a la entidad del deudor para adeudar su cuenta y (B) a la entidad para efectuar los adeudos en su cuenta siguiendo las instrucciones del acreedor. Como parte de sus derechos, el deudor está legitimado al reembolso por su entidad en los términos y condiciones del contrato suscrito con la misma. La solicitud de reembolso deberá efectuarse dentro de las ocho semanas que siguen a la fecha de adeudo en cuenta. Puede obtener información adicional sobre sus derechos en su entidad financiera.");
	aTextos["07_lblautoriza"]["EN"] = sys.translate("By signing this mandate form, you au thorise (A) the Creditor to send instructions to your bank to debit your account and (B) your bank to debit your account in accordance with the instructio ns from the Creditor. As part of your rights, you are entitled to a refund from your bank under the terms and conditions of your agreement with your bank. A refund must be claimed within eigth weeks starting from the date on which your account was debited. Your rights are explained in a statement that you can obtain from your bank.");
	aTextos["07_lblautoriza"]["FR"] = sys.translate("En signant ce formulaire de mandat, vous autorisez (a) nom du creancier á envoyer des instructions à votre banque pour débiter votre compte, et (b) votre banque à débiter votre compte conformément aux instructions de nom du creancier. Vous béneficiez du droit d'étre remboursé par votre banque selon les conditions décrites dans la convention que vous avez passée avec elle. Une demande de remboursement doit étre présentée:\n-Dans les 8 semaines suivant la date de débit de votre compte pour un prélèvement non autorisé.Vos droits concernant le présent mandat sont expliqués dans un document que vous pouvez obtenir auprès de votre banque.");
	aTextos["07_lblautoriza"]["IT"] = sys.translate("Mediante la firma di questo mandato, il pagatore autorizza (A) al beneficiario ad inviare disposizioni al ente del pagatore di addebitare nel suo conto e (B) al ente per realizzare gli addebiti al suo conto sotto le istruzioni del beneficiario. Como parte dei loro diritti, il pagatore ha diritto al rimborso da parte dell'ente nei termini e condizioni del contratto con essa. La richiesta di rimborso debe essere presentata entro otto settimane a decorrere dalla data di entrata del addebito. È possibile ottenere ulteriori informazioni sui vostri diritti nel suo ente bancario.");
	aTextos["07_lblautoriza"]["PT"] = sys.translate("Ao subscrever esta autorização, está a autorizar o {NOME DO CREDOR} a enviar instruções ao seu Banco para debitar a sua conta e o seu Banco a debitar a sua conta, de acordo com as instruções do {NOME DO CREDOR}.\nOs seus direitos incluem a possibilidade de exigir do seu Banco o reembolso do montante debitado, nos termos e condições acordados com o seu Banco. O reembolso deve ser solicitado até um prazo de oito semanas, a contar da data do débito na sua conta. Os seus direitos são explicados em declaração que pode obter no seu Banco. Preencha por favor todos os campos assinalados com *. O preenchimento dos campos assinalados com ** é da responsabilidade do Credor.");
	
		//07_lblautoriza_BTB
	aTextos["07_lblautoriza_BTB"] = new Array(2);
	aTextos["07_lblautoriza_BTB"]["ES"] = sys.translate("Mediante la firma de esta orden de domiciliación, el deudor autoriza (A) al acreedor a enviar instrucciones a la entidad del deudor para adeudar su cuenta y (B) a la entidad para efectuar los adeudos en su cuenta siguiendo las instrucciones del acreedor. Esta orden de domiciliación está prevista para operaciones exclusivamente entre empresas y/o autónomos. El deudor no tiene derecho a que su entidad le reembolse una vez que se haya realizado el cargo en cuenta, pero puede solicitar a su entidad que no efectúe el adeudo en la cuenta hasta la fecha debida. Podrá obtener información detallada del procedimiento en su entidad financiera.");
	aTextos["07_lblautoriza_BTB"]["EN"] = sys.translate("By signing this mandate form, you authorize (A) creditor to send instructions to your bank to debit your account and (B) your bank to debit your account in accordance with the instructions from creditor. This mandate is only intended for business-to-business transactions. You are not entitled to a refund from your bank after your account has been debited, but you are entitled to request your bank not to debit your account up until the day on which the payment is due. Please contact your bank for detailed procedures in such a case.");
	aTextos["07_lblautoriza_BTB"]["FR"] = sys.translate("");
	aTextos["07_lblautoriza_BTB"]["IT"] = sys.translate("");
	aTextos["07_lblautoriza_BTB"]["PT"] = sys.translate("");	
	
	//08_lblnombredeudor
	aTextos["08_lblnombredeudor"] = new Array(2);
	aTextos["08_lblnombredeudor"]["ES"] = sys.translate("Nombre del deudor/es:");
	aTextos["08_lblnombredeudor"]["EN"] = sys.translate("Debtor's name:");
	aTextos["08_lblnombredeudor"]["FR"] = sys.translate("Nom/Prénoms du débiteur:");
	aTextos["08_lblnombredeudor"]["IT"] = sys.translate("Nome del pagatore:");
	aTextos["08_lblnombredeudor"]["PT"] = sys.translate("Nome do(s) devedor(es):");
	
	//09_lbldirecciondeudor
	aTextos["09_lbldirecciondeudor"] = new Array(2);
	aTextos["09_lbldirecciondeudor"]["ES"] = sys.translate("Dirección del deudor:");
	aTextos["09_lbldirecciondeudor"]["EN"] = sys.translate("Address of the debtor:");
	aTextos["09_lbldirecciondeudor"]["FR"] = sys.translate("Votre Adresse:");
	aTextos["09_lbldirecciondeudor"]["IT"] = sys.translate("Indirizzo del pagatore:");
	aTextos["09_lbldirecciondeudor"]["PT"] = sys.translate("Nome da rua e número do devedor:");
	
	//10_lblcpciudadprovinciadeudor
	aTextos["10_lblcpciudadprovinciadeudor"] = new Array(2);
	aTextos["10_lblcpciudadprovinciadeudor"]["ES"] = sys.translate("Código Postal - Población - Provincia:");
	aTextos["10_lblcpciudadprovinciadeudor"]["EN"] = sys.translate("Postal Code - City - Town:");
	aTextos["10_lblcpciudadprovinciadeudor"]["FR"] = sys.translate("Code postal - Ville:");
	aTextos["10_lblcpciudadprovinciadeudor"]["IT"] = sys.translate("Codice di avviamento postale - Città:");
	aTextos["10_lblcpciudadprovinciadeudor"]["PT"] = sys.translate("Código Postal:");
	
	//11_lblpaisdeudor
	aTextos["11_lblpaisdeudor"] = new Array(2);
	aTextos["11_lblpaisdeudor"]["ES"] = sys.translate("País del deudor:");
	aTextos["11_lblpaisdeudor"]["EN"] = sys.translate("Country of the debtor:");
	aTextos["11_lblpaisdeudor"]["FR"] = sys.translate("Pays:");
	aTextos["11_lblpaisdeudor"]["IT"] = sys.translate("Paese del pagatore:");
	aTextos["11_lblpaisdeudor"]["PT"] = sys.translate("País do Devedor:");
	
	//12_lblbic
	aTextos["12_lblbic"] = new Array(2);
	aTextos["12_lblbic"]["ES"] = sys.translate("Swift - BIC:");
	aTextos["12_lblbic"]["EN"] = sys.translate("Swift - BIC:");
	aTextos["12_lblbic"]["FR"] = sys.translate("Swift - BIC:");
	aTextos["12_lblbic"]["IT"] = sys.translate("Swift - BIC:");
	aTextos["12_lblbic"]["PT"] = sys.translate("Swift - BIC:");
	
	//13_lbliban
	aTextos["13_lbliban"] = new Array(2);
	aTextos["13_lbliban"]["ES"] = sys.translate("Número de cuenta - IBAN:");
	aTextos["13_lbliban"]["EN"] = sys.translate("Account number - IBAN:");
	aTextos["13_lbliban"]["FR"] = sys.translate("Compte bancaire - IBAN:");
	aTextos["13_lbliban"]["IT"] = sys.translate("Contro di addebito - IBAN:");
	aTextos["13_lbliban"]["PT"] = sys.translate("Número de conta - IBAN:");
	
	//14_lbltipopago
	aTextos["14_lbltipopago"] = new Array(2);
	aTextos["14_lbltipopago"]["ES"] = sys.translate("Tipo de Pago:");
	aTextos["14_lbltipopago"]["EN"] = sys.translate("Type of payment:");
	aTextos["14_lbltipopago"]["FR"] = sys.translate("Type de paiement:");
	aTextos["14_lbltipopago"]["IT"] = sys.translate("Tipo de pagamento:");
	aTextos["14_lbltipopago"]["PT"] = sys.translate("Tipo de pagamento:");
	
	//14_fldtipopagorecurrente
	aTextos["14_fldtipopagorecurrente"] = new Array(2);
	aTextos["14_fldtipopagorecurrente"]["ES"] = sys.translate("Pago recurrente");
	aTextos["14_fldtipopagorecurrente"]["EN"] = sys.translate("Recurrent payment");
	aTextos["14_fldtipopagorecurrente"]["FR"] = sys.translate("Paiement récurrent (répetilif)");
	aTextos["14_fldtipopagorecurrente"]["IT"] = sys.translate("Pagamento gio male");
	aTextos["14_fldtipopagorecurrente"]["PT"] = sys.translate("Pagamento recorrente");
	
	//14_fldtipopagounico
	aTextos["14_fldtipopagounico"] = new Array(2);
	aTextos["14_fldtipopagounico"]["ES"] = sys.translate("Pago único");
	aTextos["14_fldtipopagounico"]["EN"] = sys.translate("One-off payment");
	aTextos["14_fldtipopagounico"]["FR"] = sys.translate("Paiement ponctuel");
	aTextos["14_fldtipopagounico"]["IT"] = sys.translate("Pagamento unico");
	aTextos["14_fldtipopagounico"]["PT"] = sys.translate("Pagamento pontual");
	
	//15_lblfechafirma
	aTextos["15_lblfechafirma"] = new Array(2);
	aTextos["15_lblfechafirma"]["ES"] = sys.translate("Fecha - Localidad de firma:");
	aTextos["15_lblfechafirma"]["EN"] = sys.translate("Date - Location in which you are signing:");
	aTextos["15_lblfechafirma"]["FR"] = sys.translate("Signé à -Lieu:");
	aTextos["15_lblfechafirma"]["IT"] = sys.translate("Data - Città:");
	aTextos["15_lblfechafirma"]["PT"] = sys.translate("Localidade:");
	
	//16_lblfirmadeudor
	aTextos["16_lblfirmadeudor"] = new Array(2);
	aTextos["16_lblfirmadeudor"]["ES"] = sys.translate("Firma del deudor:");
	aTextos["16_lblfirmadeudor"]["EN"] = sys.translate("Signature of the debtor:");
	aTextos["16_lblfirmadeudor"]["FR"] = sys.translate("Signature (s):");
	aTextos["16_lblfirmadeudor"]["IT"] = sys.translate("Firma del pagatore:");
	aTextos["16_lblfirmadeudor"]["PT"] = sys.translate("Assinatura(s):");
	
	//17_lblcamposobli
	aTextos["17_lblcamposobli"] = new Array(2);
	aTextos["17_lblcamposobli"]["ES"] = sys.translate("TODOS LOS CAMPOS HAN DE SER CUMPLIMENTADOS OBLIGATORIAMENTE.\nUNA VEZ FIRMADA ESTA ORDEN DE DOMICILIACIÓN DEBE SER ENVIADA AL ACREEDOR PARA SU CUSTODIA.\n");
	aTextos["17_lblcamposobli"]["EN"] = sys.translate("ALL GAPS ARE MANDATORY. ONCE THIS MANDATE HAS BEEN SIGNED MUST BE SENT TO CREDITOR FOR STORAGE.\n");
	aTextos["17_lblcamposobli"]["FR"] = sys.translate("VEUILLEZ COMPLÉTER OBLIGATOIREMENT  TOUS LES CHAMPS.\nUNE FOIS CETTE ORDRE DE MANDAT SIGNER, MERCI D'ENVOYER  L'ORIGINAL PAR RETOUR  AU CRÉANCIER.\n");
	aTextos["17_lblcamposobli"]["IT"] = sys.translate("TUTTI GLI SPAZI DEVONO ESSERE COMPILATE OBBLIGATORIAMENTE.\nUNA VOLTA FIRMATO QUESTO MANDATO DEVE ESSERE INVIATO IL ORIGINALE AL BENEFICIARIO PER CUSTODIRLO.\n");
	aTextos["17_lblcamposobli"]["PT"] = sys.translate("TODOS OS CAMPOS DEVEM SER PREENCHIDOS OBRIGATORIAMENTE.\nAPÓS ASSINAR ESTA AUTORIZAÇÃO DE DÉBITO, DEVE ENVIÁ-LA AO CREDOR PARA SUA CUSTÓDIA.\n");
	
		//17_lblcamposobli_BTB
	aTextos["17_lblcamposobli_BTB"] = new Array(2);
	aTextos["17_lblcamposobli_BTB"]["ES"] = sys.translate("TODOS LOS CAMPOS HAN DE SER CUMPLIMENTADOS OBLIGATORIAMENTE. UNA VEZ FIRMADA ESTA ORDEN DE DOMICILIACIÓN DEBE SER ENVIADA AL ACREEDOR PARA SU CUSTODIA . LA ENTIDAD DE DEUDOR REQUIERE AUTORIZACIÓN DE ÉSTE PREVIA AL CARGO EN CUENTA DE LOS ADEUDOS DIRECTOS B2B. EL DEUDOR PODRÁ GESTIONAR DICHA AUTORIZACIÓN CON LOS MEDIOS QUE SU ENTIDAD PONGA A SU DISPOSICIÓN.");
	aTextos["17_lblcamposobli_BTB"]["EN"] = sys.translate("ALL GAPS ARE MANDATORY. ONCE THIS MANDATE HAS BEEN SIGNED MUST BE SENT TO CREDITOR FOR STORAGE. NEVERTHELESS, THE BANK OF DEBTOR REQUIRES DEBTOR'S AUTHORIZATION.\nBEFORE DEBITING B2B DIRECT DEBITS IN THE ACCOUNT. THE DEBTOR WILL BE ABLE TO MANAGE THE MENTIONED AUTHORIZATION THROUGH THE MEANS PROVIDED BY HIS BANK .");
	aTextos["17_lblcamposobli_BTB"]["FR"] = sys.translate(" ");
	aTextos["17_lblcamposobli_BTB"]["IT"] = sys.translate(" ");
	aTextos["17_lblcamposobli_BTB"]["PT"] = sys.translate(" ");	
	
	//18_lblnotapie
	aTextos["18_lblnotapie"] = new Array(2);
	aTextos["18_lblnotapie"]["ES"] = sys.translate(" ");
	aTextos["18_lblnotapie"]["EN"] = sys.translate(" ");
	aTextos["18_lblnotapie"]["FR"] = sys.translate(" ");
	aTextos["18_lblnotapie"]["IT"] = sys.translate(" ");
	aTextos["18_lblnotapie"]["PT"] = sys.translate(" ");
	
		//18_lblnotapie_BTB
	aTextos["18_lblnotapie_BTB"] = new Array(2);
	aTextos["18_lblnotapie_BTB"]["ES"] = sys.translate(" ");
	aTextos["18_lblnotapie_BTB"]["EN"] = sys.translate(" ");
	aTextos["18_lblnotapie_BTB"]["FR"] = sys.translate(" ");
	aTextos["18_lblnotapie_BTB"]["IT"] = sys.translate(" ");
	aTextos["18_lblnotapie_BTB"]["PT"] = sys.translate(" "); 
	debug("saliendo de inicializar");
}

function oficial_dameValorArray(campo,idioma)
{
  var _i = this.iface;
  var valor = "";
  if (campo in _i.textos_) {
    valor = _i.textos_[campo][idioma];
  }
  return valor;
}
function oficial_dameIdiomaMandato()
{
	var _i = this.iface;
  var cursor = this.cursor();
  var codIdioma; 
	var  codCliente = _i.codCliente_;
  var codPais = AQUtil.sqlSelect("dirclientes", "codpais", "codcliente='" + codCliente + "' and domfacturacion");
  if (!codPais)  {
    return AQUtil.sqlSelect("paises", "codidioma", "codiso='ES'");
  }

  return AQUtil.sqlSelect("paises", "codidioma", "codpais='" + codPais + "'");
}
function oficial_dameArrayTextos(aTextos)
{
  var _i = this.iface;
  _i.inicializaArray(aTextos);
}
function oficial_setValorCliente(codCliente)
{
	var _i = this.iface;
	_i.codCliente_ = codCliente;	
}
function oficial_inicializarArrayTextos()
{
	var _i = this.iface;
   _i.textos_ = [];
  _i.inicializaArray(_i.textos_);
	
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////
