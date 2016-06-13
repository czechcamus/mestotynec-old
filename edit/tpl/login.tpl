<?
// ověření uživatele
$phpuser = $_SERVER["PHP_AUTH_USER"];
$phppw = $_SERVER["PHP_AUTH_PW"];
if (!isset($phpuser)):
	Header("WWW-authenticate: basic realm=\"Redakce\"");
	Header("HTTP/1.0 401 Unauthorized");
	echo "<h3>Špatné uživatelské jméno!</h3>\n";
	exit;
else:
	$uzivatel = StrToLower($phpuser);
	$sql_dotaz = "SELECT * FROM redakce WHERE user='".$uzivatel."'";
	$result = mysql_query("$sql_dotaz");
	if ($result):
		$poczaz = mysql_num_rows($result);
		if ($poczaz == 0):
			Header("WWW-authenticate: basic realm=\"Redakce\"");
			Header("HTTP/1.0 401 Unauthorized");
			echo "<h3>Žádný takový redaktor neexistuje!</h3>\n";
			exit;
		endif;
		$record = mysql_fetch_array($result);
		$redaktor_id = $record["id"];
		if ($phppw != $record["pwd"]):
			Header("WWW-authenticate: basic realm=\"Redakce\"");
			Header("HTTP/1.0 401 Unauthorized");
			echo "<h3>Špatné heslo!</h3>\n";
			exit;
		endif;
	else:
		Header("WWW-authenticate: basic realm=\"Redakce\"");
		Header("HTTP/1.0 401 Unauthorized");
		echo "<h3>Špatné uživatelské jméno!</h3>\n";
		exit;
	endif;
endif;
?>