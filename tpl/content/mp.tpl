<?php
$aid = (isset($_REQUEST['aid']) ? $_REQUEST['aid'] : '');
$username = (isset($_REQUEST['username']) ? $_REQUEST['username'] : '');
$userpswd = (isset($_REQUEST['userpswd']) ? $_REQUEST['userpswd'] : '');

if (!empty($username)) {
  // vytvoří proměnnou aid nebo vrátí chybu
  $aid = GetAid($username, $userpswd);
  if (empty($aid)) {
    $err = 1;
  } 
}

if (empty($aid) || !CheckLogin($aid)) {
  // přihlašovací formulář
 	if ($err):
		echo "<p class=\"error\">Chybné přihlašovací údaje</p>\n";
	endif;
?>	
	<form method="get" class="publicform">
		<fieldset>
			<label for="username" class="required">Uživatelské jméno *</label>
			<input type="text" size="12" name="username" id="username" class="txtinput" value="<?php echo $username; ?>" />
			<label for="userpswd" class="required">Heslo *</label>
			<input type="password" size="12" name="userpswd" id="userpswd" class="txtinput" value="<?php echo $userpswd; ?>" />
			<div>
			<input type="hidden" name="form" value="login" />
			<input type="hidden" name="fp" value="<?php echo $fp; ?>" />
			<input type="submit" value="přihlásit" title="tlačítko přihlásit" class="subinput" />
			</div>
		</fieldset>
	</form>
<?php
} else {
?>
	<form method="get" class="publicform">
		<fieldset>
			<label for="obdobi" class="required">Výběr období</label>
			<select name="obdobi" id="obdobi">
			<?php
			   $q = "SELECT DISTINCT DATE_FORMAT(obdobido_d,'%Y') AS rok FROM mpdoc ORDER BY rok DESC";
			   $sr = mysql_query($q);
			   if (!$sr) {
			     die("Chyba v dotazu - $q");
         }
         while ($rec = mysql_fetch_array($sr)) {
			     echo "<option value=\"".$rec['rok']."\">".$rec['rok']."</option>\n";
			   }
			?>
			</select>
			<div>
			<input type="hidden" name="form" value="obdobi" />
			<input type="hidden" name="aid" value="<?php echo $aid; ?>" />
			<input type="hidden" name="fp" value="<?php echo $fp; ?>" />
			<input type="submit" value="vybrat" title="tlačítko vybrat" class="subinput" />
			</div>
		</fieldset>
	</form>
<?php
}
if (isset($_REQUEST['obdobi'])) {
  // zobrazení seznamu osob a jejich dokumentů
  $q = "SELECT p.prijmeni,p.jmeno,p.titulpred,p.titulza,d.id,DATE_FORMAT(d.obdobiod_d,'%d.%m.%Y') AS obdobi_od,
          DATE_FORMAT(d.obdobido_d,'%d.%m.%Y') AS obdobi_do,d.filetitle,d.filename 
          FROM mpdoc AS d,mpperson AS p WHERE YEAR(d.obdobido_d) = '".$_REQUEST['obdobi']."' AND d.idmpperson = p.id 
          ORDER BY p.prijmeni";
  $sr = mysql_query($q);
  if (!$sr) {
    die("Chyba v dotazu - $q");
  }
  $i = 0;
  if (mysql_num_rows($sr) > 0) {
    echo "<table class=\"table\">\n";
    echo "<tr><th>Jméno</th><th>Období</th><th>Dokument</th></tr>\n";
    while ($rec = mysql_fetch_array($sr)) {
      echo "<tr class=\"bg$i\">";
      echo "<td>".(empty($rec['titulpred']) ? "" : $rec['titulpred']." ").$rec['jmeno']." ".$rec['prijmeni'].(empty($rec['titulza']) ? "" : ", ".$rec['titulza'])."</td>";
      echo "<td>".$rec['obdobi_od']." - ".$rec['obdobi_do']."</td>";
      echo "<td><a href=\"scripts/viewdoc.php?aid=$aid&amp;docid=".$rec['id']."&amp;doc=".$rec['filename']."\">".$rec['filetitle']."</a></td>";
      echo "</tr>\n";
      $i = ($i == 1 ? 0 : 1);
    }
    echo "</table>\n";
  } 
}

function GetAid($u,$p)
// kontroluje správnost přihlašovacích údajů, při úspěchu vrací neprázdný řetězec $a
{
  $a = ''; 
  $q = "SELECT * FROM mpuser WHERE username = '".$u."' AND userpswd = '".$p."'" ;
  $sr = mysql_query($q);
  if (!$sr) {
    die("Chyba v dotazu - $q");
  }
  if (mysql_num_rows($sr) > 0) {
    $rec = mysql_fetch_array($sr);
    $id = $rec['id'];
    if ($rec['platnost'] > 0) {
      $maxtime = mktime(substr($rec['caszapisu'],11,2),substr($rec['caszapisu'],14,2),substr($rec['caszapisu'],17,2),substr($rec['caszapisu'],5,2),substr($rec['caszapisu'],8,2),substr($rec['caszapisu'],0,4))+($rec['platnost']*24*60*60);
      if ($maxtime > time()) {
        $auth = md5($u.$p.microtime());
        $a = $auth.'x'.$id;
      }        
    } else {
      $auth = md5($u.$p.microtime());
      $a = $auth.'x'.$id;
    }
    if (!empty($a)) {
      $q = "UPDATE mpuser SET auth = '".$a."' WHERE id = $id";
      $sr = mysql_query($q);
      if (!$sr) {
        die("Chyba v dotazu - $q");
      }
    }
  }
  return $a;
}

function CheckLogin($a)
// zkontroluje přihlášení podle řetězce $a
{
  $q = "SELECT id FROM mpuser WHERE auth='".$a."'";
  $sr = mysql_query($q);
  if (mysql_num_rows($sr) > 0) {
    return true;
  } else {
    return false;
  }
}
?>
