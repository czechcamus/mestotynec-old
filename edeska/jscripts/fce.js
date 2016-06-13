// AJAX funkce
var xmlHttp;
var funcSelect = "";

function createXMLHttpRequest()
{
	if (window.XMLHttpRequest)
	{
		// IE7+, Firefox, Chrome, Opera, Safari
		xmlHttp = new XMLHttpRequest();
	}
	else if (window.ActiveXObject)
	{
		// IE6, IE5
		xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	else
	{
		alert("Váš prohlížeč nepodporuje AJAX");
	}
}

function setEndDate()
{
	funcSelect = 1;
	var datum1 = document.getElementById("datum1").value;
	var lhuta = document.getElementById("lhuta").value;
	var url = "scripts/setdate.php?lhuta=" + lhuta + "&datum1=" + datum1;
	
	createXMLHttpRequest();
	xmlHttp.onreadystatechange = processChangeStatus;
	xmlHttp.open("GET", url, true);
	xmlHttp.send(null);
}

function checkValidDate(datum)
{
	funcSelect = 2;
	var datumval = document.getElementById(datum).value;
	if (datum == 'datum1' || datum == 'datum2') {
		var url = "scripts/checkdate.php?datum=" + datumval;	
	} else {
		var url = "scripts/checkdate.php?datum=" + datumval + "&noval=1";
	}
	
	createXMLHttpRequest();
	xmlHttp.onreadystatechange = processChangeStatus;
	xmlHttp.open("GET", url, true);
	xmlHttp.send(null);
}

function processChangeStatus()
{
	if (xmlHttp.readyState == 4) {
		if (xmlHttp.status == 200 ) {
			if (funcSelect == 1) {
				var vysledek = xmlHttp.responseXML;
				actualizeDate(vysledek);
			} else if (funcSelect == 2) {
				document.getElementById("errorbox").innerHTML = xmlHttp.responseText;	
			}
		}
	}
}

function actualizeDate(vysledek)
{
	var datumy = vysledek.getElementsByTagName("datum");
	for (var i = 0; i < datumy.length; i++) {
		datumField1 = document.getElementById("datum" + (i+1));
		datumField2 = document.getElementById("datum" + (i+3));
		datumField1.value = datumField2.value = datumy[i].firstChild.nodeValue;
	}
}