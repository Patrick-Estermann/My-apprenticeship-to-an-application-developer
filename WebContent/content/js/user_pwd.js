/**
 * 
 */
function check(){
	var username = document.userform.username.value;
	var usercheck = "admin";

	var password = document.userform.password.value;
	var passcheck = "klapp42stuhl";

	var empty = ("X").fontcolor("red");
	var correct = ("&#x2713").fontcolor("green");

	var check = true;


/**********************************Username*****************************************/

	if (username != usercheck) {
		if (document.getElementById("checkusername").innerHTML == correct || document.getElementById("checkusername").innerHTML == empty){
			document.getElementById("checkusername").innerHTML = empty;
			check = false;
		}
		else{
			document.getElementById("checkusername").innerHTML = empty;
			document.userform.username.focus();
			check = false;
		}
	}
	else{
		document.getElementById("checkusername").innerHTML = correct;
	}

/**********************************Username*****************************************/
/**********************************Password*****************************************/

	if (password != passcheck) {
		if (document.getElementById("checkpassword").innerHTML == correct || document.getElementById("checkpassword").innerHTML == empty){
			document.getElementById("checkpassword").innerHTML = empty;
			check = false;
		}
		else{
			document.getElementById("checkpassword").innerHTML = empty;
			document.userform.password.focus();
			check = false;
		}
	}
	else{
		document.getElementById("checkpassword").innerHTML = correct;
	}

/**********************************Password*****************************************/

	if (!check) {
		alert("Der Benutzername und / oder das Passwort ist falsch!");
		return false;
	}

	return true;
}