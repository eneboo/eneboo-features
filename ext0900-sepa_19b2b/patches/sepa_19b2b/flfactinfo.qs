
/** @class_declaration sepa19b2b */
/////////////////////////////////////////////////////////////////
//// SEPA19B2B /////////////////////////////////////////////////
class sepa19b2b extends marcaImpresion /** %from: oficial */
{
  function sepa19b2b(context)
  {
    marcaImpresion(context);
  }
  function codpostalCiudadProvinciaCliente(nodo, campo)
  {
  	return this.ctx.sepa19b2b_codpostalCiudadProvinciaCliente(nodo, campo);
  }
  function dameIdentificadorAcreedor(nodo, campo)
  {
  	return this.ctx.sepa19b2b_dameIdentificadorAcreedor(nodo, campo);
  }
  function formateaIban(nodo, campo)
  {
  	return this.ctx.sepa19b2b_formateaIban(nodo, campo);
  }
  function traducir(campo)
  {
    return this.ctx.sepa19b2b_traducir(campo);
  }
  function tipoPago(nodo, campo)
  {
    return this.ctx.sepa19b2b_tipoPago(nodo, campo);
  }
}
//// SEPA19B2B /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition sepa19b2b */
/////////////////////////////////////////////////////////////////
//// SEPA19B2B /////////////////////////////////////////////////

function sepa19b2b_codpostalCiudadProvinciaCliente(nodo, campo)
{
  var _i = this.iface;

  var valor = "";
  var codPostal = nodo.attributeValue("dirclientes.codpostal");
  var ciudad = nodo.attributeValue("dirclientes.ciudad");
  var provincia = nodo.attributeValue("dirclientes.provincia");

  if (codPostal) {
    if (ciudad) {
      if (provincia) {
        debug("Existe código postal: " + codPostal + " ciudad: " + ciudad + " y provincia: " + provincia);
        valor = codPostal + " - " + ciudad + " (" + provincia + ")";

      } else {
        debug("Existe código postal: " + codPostal + " y ciudad: " + ciudad);
        valor = codPostal + " - " + ciudad;
      }
    } else if (provincia) {
      debug("Existe código postal: " + codPostal + " y provincia: " + provincia);
      valor = codPostal + " (" + provincia + ")";
    } else {
      debug("Existe código postal: " + codPostal);
      valor = codPostal
    }
  } else {
    if (ciudad) {
      if (provincia) {
        debug("Existe provincia");
        debug("Existe ciudad: " + ciudad + " y provincia: " + provincia);
        valor = ciudad + " (" + provincia + ")";
      } else {
        debug("Existe ciudad pero no provincia");
        valor = ciudad;
        debug("Existe Ciudad: " + ciudad);
      }
    } else if (provincia) {
      debug("No existe ciudad pero Existe Provincia: " + provincia);
      valor = "(" + provincia + ")";
    }
  }
  debug(valor);
  return valor;

}

function sepa19b2b_dameIdentificadorAcreedor(nodo, campo)
{
  var cifEmpresa = nodo.attributeValue("empresa.cifnif");
  var codCuenta = nodo.attributeValue("mandatoscli.codcuenta");

  var identificador = flfactppal.iface.calcularIdentificadorAcreedor(cifEmpresa, codCuenta);

  return identificador;
}

function sepa19b2b_formateaIban(nodo, campo)
{
  var iban = nodo.attributeValue(campo);

  if (!iban || iban == "") {
    return "";
  }

  var nIban = "";
  var pais = iban.substring(0, 2);

  var paisControl = iban.substring(0, 4);
  var resto = iban.substring(4);

  if (pais == "ES") {
    var entidad = resto.substring(0, 4);
    var oficina = resto.substring(4, 8);
    var cuenta = resto.substring(8);

    resto = entidad + " " + oficina + " " + cuenta;
  }

  nIban += paisControl + " " + resto;

  return nIban;
}

function sepa19b2b_traducir(campo)
{
  var _i = this.iface;
  var traduccion;
  var idiomaCampo;
  var noEncontrado = false;
  if (!flfactppal.iface.pub_extension("inf_multiidioma")) {
    idiomaCampo =  campo.right(2);
    var idiomaTrad = idiomaCampo;
    if (idiomaCampo == "TR") {
      idiomaTrad = "EN";
    }
    campo = campo.left(campo.length - 3);
    traduccion = formmandatoscli.iface.pub_dameValorArray(campo, idiomaTrad);
  } else {
    var codIdioma = formmandatoscli.iface.pub_dameIdiomaMandato();
    idiomaCampo = campo.right(3);
    // si el idioma es español y la etiquieta es la español, cogemos el campo descripción de la tabla tradmandatoscli
    if (codIdioma == "ES" && idiomaCampo == "_ES") {
      campo = campo.left(campo.length - 3);
      traduccion = AQUtil.sqlSelect("tradmandatoscli", "descripcion", "idcampo = '" + campo + "' ");

    } else if (codIdioma == "ES" && idiomaCampo == "_TR") {
      //Buscamos la traducción en la tabla con idioma en inglés
      var campoTrad = campo.left(campo.length - 3);
      traduccion = AQUtil.sqlSelect("traducciones", "traduccion", "idcampo = '" + campoTrad + "' and codidioma='EN'");
      if (!traduccion || traduccion == "") {
        noEncontrado = true;
      }

    } else if (idiomaCampo == "_TR") {
      //el idioma es distinto de español y es la etiqueta traducida, tenemos que coger del campo descripcion
      campo = campo.left(campo.length - 3);
      traduccion = AQUtil.sqlSelect("tradmandatoscli", "descripcion", "idcampo = '" + campo + "' ");
    } else {
      //Buscamos la traducción en la tabla del idioma
      campo = campo.left(campo.length - 3);
      traduccion = AQUtil.sqlSelect("traducciones", "traduccion", "idcampo = '" + campo + "' and codidioma='" + codIdioma + "'");

      if (!traduccion || traduccion == "") {
        noEncontrado = true;
      }
    }
    if (noEncontrado) {
      traduccion = formmandatoscli.iface.pub_dameValorArray(campo, codIdioma);
      noEncontrado = false;
    }

  }
  if (idiomaCampo == "_TR" && traduccion.right(1) == ":") {
    traduccion = traduccion.left(traduccion.length - 1);
  }
  return traduccion;
}

function sepa19b2b_tipoPago(nodo, campo)
{
  var tipoPago = nodo.attributeValue(campo);
  var campoTrad = "";
  var traduccion = "";
  switch (tipoPago) {
    case "Pago Único": {
      campoTrad = "14_fldtipopagounico";
      break;
    }
    case "Pago Recurrente": {
      campoTrad = "14_fldtipopagorecurrente";
      break;
    }

  }
  if (!flfactppal.iface.pub_extension("inf_multiidioma")) {
    traduccion = formmandatoscli.iface.pub_dameValorArray(campoTrad, "ES") + " / " + formmandatoscli.iface.pub_dameValorArray(campoTrad, "EN");
  } else {
    var codIdioma = formmandatoscli.iface.pub_dameIdiomaMandato();
    if (codIdioma == "ES") {
      traduccion = AQUtil.sqlSelect("tradmandatoscli", "descripcion", "idcampo = '" + campoTrad + "' ") + " / " + AQUtil.sqlSelect("traducciones", "traduccion", "idcampo = '" + campoTrad + "' and codidioma='EN'");
    } else {
      traduccion = AQUtil.sqlSelect("traducciones", "traduccion", "idcampo = '" + campoTrad + "' and codidioma='" + codIdioma + "'") + " / " + AQUtil.sqlSelect("tradmandatoscli", "descripcion", "idcampo = '" + campoTrad + "' ");
    }
  }
  return traduccion;
}

//// SEPA_19B2B /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

