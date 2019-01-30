
/** @class_declaration navegador */
/////////////////////////////////////////////////////////////////
//// CONF NAVEGADOR /////////////////////////////////////////////
class navegador extends eFactura /** %from: oficial */
{
  function navegador(context)
  {
    eFactura(context);
  }
  function init()
  {
    return this.ctx.navegador_init();
  }
  function cambiarNavegador()
  {
    return this.ctx.navegador_cambiarNavegador();
  }
}
//// CONF NAVEGADOR /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration envioMail */
/////////////////////////////////////////////////////////////////
//// ENVIO MAIL /////////////////////////////////////////////////
class envioMail extends navegador /** %from: navegador */
{
  function envioMail(context)
  {
    navegador(context);
  }
  function init()
  {
    return this.ctx.envioMail_init();
  }
  function cambiarClienteCorreo()
  {
    return this.ctx.envioMail_cambiarClienteCorreo();
  }
  function cambiarNombreCorreo()
  {
    return this.ctx.envioMail_cambiarNombreCorreo();
  }
  function cambiarDirIntermedia()
  {
    return this.ctx.envioMail_cambiarDirIntermedia();
  }
  function guardarDefinicionesEmail()
  {
	return this.ctx.envioMail_guardarDefinicionesEmail();
  }
}
//// ENVIO MAIL /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition navegador */
/////////////////////////////////////////////////////////////////
//// CONF NAVEGADOR /////////////////////////////////////////////
function navegador_init()
{
  this.iface.__init();

  var util: FLUtil = new FLUtil();
  this.child("lblNombreNavegador").text = util.readSettingEntry("scripts/flfactinfo/nombrenavegador");
  connect(this.child("pbnCambiarNavegador"), "clicked()", this, "iface.cambiarNavegador");
}

function navegador_cambiarNavegador()
{
  var util: FLUtil = new FLUtil();
  var nombreNavegador: String = Input.getText(util.translate("scripts", "Nombre del navegador o ruta de acceso:"));
  if (!nombreNavegador) {
    return;
  }

  this.child("lblNombreNavegador").text = nombreNavegador;
  util.writeSettingEntry("scripts/flfactinfo/nombrenavegador", nombreNavegador);
}

//// CONF NAVEGADOR /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition envioMail */
/////////////////////////////////////////////////////////////////
//// ENVIO MAIL /////////////////////////////////////////////////
function envioMail_init()
{
  this.iface.__init();

  var util: FLUtil = new FLUtil();
  this.child("lblClienteCorreo").text = util.readSettingEntry("scripts/flfactinfo/clientecorreo");
  this.child("lblNombreCorreo").text = util.readSettingEntry("scripts/flfactinfo/nombrecorreo");
  this.child("lblDirIntermedia").text = util.readSettingEntry("scripts/flfactinfo/dirCorreo");
  connect(this.child("pbnCambiarClienteCorreo"), "clicked()", this, "iface.cambiarClienteCorreo");
  connect(this.child("pbnCambiarNombreCorreo"), "clicked()", this, "iface.cambiarNombreCorreo");
  connect(this.child("pbnCambiarDirIntermedia"), "clicked()", this, "iface.cambiarDirIntermedia");
  connect(this.child("pbnGuardarDefinicionesEmail"), "clicked()", this, "iface.guardarDefinicionesEmail");

  this.child("lineEditPCAsunto").text = util.readSettingEntry("scripts/flfactinfo/emailPCAsunto");
  this.child("textEditPCCuerpo").text = util.readSettingEntry("scripts/flfactinfo/emailPCCuerpo");
  this.child("lineEditPRVAsunto").text = util.readSettingEntry("scripts/flfactinfo/emailPRVAsunto");
  this.child("textEditPRVCuerpo").text = util.readSettingEntry("scripts/flfactinfo/emailPRVCuerpo");
  this.child("lineEditPVAsunto").text = util.readSettingEntry("scripts/flfactinfo/emailPVAsunto");
  this.child("textEditPVCuerpo").text = util.readSettingEntry("scripts/flfactinfo/emailPVCuerpo");
  this.child("lineEditAVAsunto").text = util.readSettingEntry("scripts/flfactinfo/emailAVAsunto");
  this.child("textEditAVCuerpo").text = util.readSettingEntry("scripts/flfactinfo/emailAVCuerpo");
  this.child("lineEditFVAsunto").text = util.readSettingEntry("scripts/flfactinfo/emailFVAsunto");
  this.child("textEditFVCuerpo").text = util.readSettingEntry("scripts/flfactinfo/emailFVCuerpo");



}

function envioMail_cambiarClienteCorreo()
{
  var util: FLUtil = new FLUtil();
  var opciones: Array = ["KMail", "Thunderbird", "Outlook"];
  var codClienteCorreo: String = Input.getItem(util.translate("scripts", "Cliente de correo:"), opciones, "KMail", false);

  if (!codClienteCorreo) {
    return;
  }

  this.child("lblClienteCorreo").text = codClienteCorreo;
  util.writeSettingEntry("scripts/flfactinfo/clientecorreo", codClienteCorreo);

  var nombreCorreo = "";
  switch (codClienteCorreo) {
    case "KMail": {
      nombreCorreo = "kmail";
      break;
    }
    case "Thunderbird": {
      nombreCorreo = "thunderbird";
      break;
    }
    case "Outlook": {
      nombreCorreo = "outlook.exe";
      break;
    }
  }
  if (nombreCorreo != "") {
    this.child("lblNombreCorreo").text = nombreCorreo;
    util.writeSettingEntry("scripts/flfactinfo/nombrecorreo", nombreCorreo);
  }
}

function envioMail_cambiarNombreCorreo()
{
  var util: FLUtil = new FLUtil();
  var nombreCorreo: String = Input.getText(util.translate("scripts", "Ejecutable para correo:"));

  if (!nombreCorreo) {
    return;
  }

  this.child("lblNombreCorreo").text = nombreCorreo;
  util.writeSettingEntry("scripts/flfactinfo/nombrecorreo", nombreCorreo);
}


function envioMail_cambiarDirIntermedia()
{
  var util: FLUtil = new FLUtil();
  var ruta: String = FileDialog.getExistingDirectory(util.translate("scripts", ""), util.translate("scripts", "RUTA INTERMEDIA"));

  if (!File.isDir(ruta)) {
    MessageBox.information(util.translate("scripts", "Ruta errónea"), MessageBox.Ok, MessageBox.NoButton);
    return;
  }
  this.child("lblDirIntermedia").text = ruta;
  util.writeSettingEntry("scripts/flfactinfo/dirCorreo", ruta);
}


function envioMail_guardarDefinicionesEmail() {
  var util: FLUtil = new FLUtil();

    MessageBox.information(util.translate("scripts", "Guardadas localmente las definiciones de emails."), MessageBox.Ok, MessageBox.NoButton);



  util.writeSettingEntry("scripts/flfactinfo/emailPCAsunto", this.child("lineEditPCAsunto").text);
  util.writeSettingEntry("scripts/flfactinfo/emailPCCuerpo", this.child("textEditPCCuerpo").text);
  util.writeSettingEntry("scripts/flfactinfo/emailPRVAsunto", this.child("lineEditPRVAsunto").text);
  util.writeSettingEntry("scripts/flfactinfo/emailPRVCuerpo", this.child("textEditPRVCuerpo").text);
  util.writeSettingEntry("scripts/flfactinfo/emailPVAsunto", this.child("lineEditPVAsunto").text);
  util.writeSettingEntry("scripts/flfactinfo/emailPVCuerpo", this.child("textEditPVCuerpo").text);
  util.writeSettingEntry("scripts/flfactinfo/emailAVAsunto", this.child("lineEditAVAsunto").text);
  util.writeSettingEntry("scripts/flfactinfo/emailAVCuerpo", this.child("textEditAVCuerpo").text);
  util.writeSettingEntry("scripts/flfactinfo/emailFVAsunto", this.child("lineEditFVAsunto").text);
  util.writeSettingEntry("scripts/flfactinfo/emailFVCuerpo", this.child("textEditFVCuerpo").text);


}
//// ENVIO MAIL /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

