/**
 * 
 */
function checkForm(){
	var vorname = document.rechnungAdrForm.vorname.value;
	var vornamecheck = /[a-zA-ZäöüÄÖÜéèàÉÈÀ -]{2,}$/;

	var nachname = document.rechnungAdrForm.nachname.value;
	var nachnamecheck = /[a-zA-ZäöüÄÖÜéèàÉÈÀ -]{2,}$/;

	var strasse = document.rechnungAdrForm.strasse.value;
	var strassecheck = /[a-zA-ZäöüÄÖÜéèàÉÈÀ0-9 -]{4,}$/;

	var ort = document.rechnungAdrForm.ort.value;
	var ortcheck = /[a-zA-ZäöüÄÖÜéèàÉÈÀ -]{2,}$/;

	var plz = document.rechnungAdrForm.plz.value;
	var plzcheck = /^([1-468][0-9]|[57][0-7]|9[0-6])[0-9]{2}$/;
	
	var tel = document.rechnungAdrForm.tel.value;
	var telcheck = /^(0|0041|\+41)?[1-9\s][0-9\s]{1,12}$/;

	var empty = ("X").fontcolor("red");
	var correct = ("&#x2713").fontcolor("green");

	var check = true;


/**********************************Firstname*****************************************/

	if (!vorname || !vornamecheck.test(vorname)) {
		if (document.getElementById("checkvorname").innerHTML == correct || document.getElementById("checkvorname").innerHTML == empty){
			document.getElementById("checkvorname").innerHTML = empty;
			check = false;
		}
		else{
			document.getElementById("checkvorname").innerHTML = empty;
			document.rechnungAdrForm.vorname.focus();
			check = false;
		}
	}
	else{
		document.getElementById("checkvorname").innerHTML = correct;
	}

/**********************************Firstname*****************************************/
/**********************************Lastname*****************************************/

	if (!nachname || !nachnamecheck.test(nachname)) {
		if (document.getElementById("checknachname").innerHTML == correct || document.getElementById("checknachname").innerHTML == empty){
			document.getElementById("checknachname").innerHTML = empty;
			check = false;
		}
		else{
			document.getElementById("checknachname").innerHTML = empty;
			document.rechnungAdrForm.nachname.focus();
			check = false;
		}
	}
	else{
		document.getElementById("checknachname").innerHTML = correct;
	}

/**********************************Lastname*****************************************/
/**********************************Address*****************************************/

	if (!strasse && !strassecheck.test(strasse)) {
		if (document.getElementById("checkstrasse").innerHTML == correct || document.getElementById("checkstrasse").innerHTML == empty){
			document.getElementById("checkstrasse").innerHTML = empty;
			check = false;
		}
		else{
			document.getElementById("checkstrasse").innerHTML = empty;
			document.rechnungAdrForm.strasse.focus();
			check = false;
		}
	}
	else{
		document.getElementById("checkstrasse").innerHTML = correct;
	}

/**********************************Address*****************************************/
/**********************************City*****************************************/

	if (!ort && !ortcheck.test(ort)) {
		if (document.getElementById("checkort").innerHTML == correct || document.getElementById("checkort").innerHTML == empty){
			document.getElementById("checkort").innerHTML = empty;
			check = false;
		}
		else{
			document.getElementById("checkort").innerHTML = empty;
			document.rechnungAdrForm.ort.focus();
			check = false;
		}
	}
	else{
		document.getElementById("checkort").innerHTML = correct;
	}

/**********************************City*****************************************/
/**********************************Zipcode*****************************************/

	if (!plz && !plzcheck.test(plz)) {
		if (document.getElementById("checkplz").innerHTML == correct || document.getElementById("checkplz").innerHTML == empty){
			document.getElementById("checkplz").innerHTML = empty;
			check = false;
		}
		else{
			document.getElementById("checkplz").innerHTML = empty;
			document.rechnungAdrForm.plz.focus();
			check = false;
		}
	}
	else{
		document.getElementById("checkplz").innerHTML = correct;
	}

/**********************************Zipcode*****************************************/
/**********************************Telefonnummer*****************************************/
	if (!tel && !telcheck.test(tel)) {
		if (document.getElementById("checktel").innerHTML == correct || document.getElementById("checktel").innerHTML == empty){
			document.getElementById("checktel").innerHTML = empty;
			check = false;
		}
		else{
			document.getElementById("checktel").innerHTML = empty;
			document.rechnungAdrForm.tel.focus();
			check = false;
		}
	}
	else{
		document.getElementById("checktel").innerHTML = correct;
	}
/**********************************Telefonnummer*****************************************/

	if (!check) {
		alert("Bitte füllen Sie alle Felder aus, welche mit * gekennzeichnet sind und überprüfen Sie Ihre Eingaben!");
		return false;
	}

	return true;
}