
/** @class_declaration sepa19b2b */
/////////////////////////////////////////////////////////////////
//// SEPA192B2 //////////////////////////////////////////////////
class sepa19b2b extends marcaImpresion /** %from: oficial */ {
	function sepa19b2b( context ) { marcaImpresion ( context ); }

	function calcularIdentificadorAcreedor(cifEmpresa, codCuenta, norma) {
		return this.ctx.sepa19b2b_calcularIdentificadorAcreedor(cifEmpresa, codCuenta, norma);
	}
}
//// SEPA192B2 //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition sepa19b2b */
/////////////////////////////////////////////////////////////////
//// SEPA192B2 //////////////////////////////////////////////////

function sepa19b2b_calcularIdentificadorAcreedor(cifEmpresa, codCuenta, tipoNorma)
{
	var _i = this.iface;

	if(!tipoNorma || tipoNorma == undefined || tipoNorma == ""){
		debug("/////////////////////// no hay norma");
		return _i.__calcularIdentificadorAcreedor(cifEmpresa, codCuenta);
	}

	var codPais = AQUtil.sqlSelect("empresa INNER JOIN paises ON empresa.codpais = paises.codpais","paises.codiso","empresa.cifnif = '" + cifEmpresa + "'","empresa,paises");
	if (!codPais) {
		sys.warnMsgBox(sys.translate("No se ha podido obtener el código ISO del país asociado a la empresa"));
		return false;
	}

	var codComercial;

	switch(tipoNorma){
		case 19:{
			codComercial = AQUtil.sqlSelect("cuentasbanco","sufijo","codcuenta = '" + codCuenta + "'");
			break;
		}
		case 58:{
			if(!flfactppal.iface.pub_extension("norma58")){
				sys.infoMsgBox(sys.translate("Debe tener instalada la extensión norma58 para poder utilizar este tipo de norma.\nContacte con YeboYebo"));
				return false;
			}
			codComercial = AQUtil.sqlSelect("cuentasbanco","sufijoi","codcuenta = '" + codCuenta + "'");
			break;
		}
		default:{
			codComercial = "000";
		}

	}

	var numControl = "";

	cifEmpresa = cifEmpresa.toUpperCase();
	var carValido = "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	for(var i = 0; i < cifEmpresa.length; i++) {
		if (carValido.find(cifEmpresa.charAt(i)) >= 0) {
			numControl += cifEmpresa.charAt(i);
		}
	}
	digControl = _i.digitoControlMod97(numControl,codPais);

	var identificador = codPais + digControl + codComercial + cifEmpresa;

	return identificador;
}

//// SEPA192B2 //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

