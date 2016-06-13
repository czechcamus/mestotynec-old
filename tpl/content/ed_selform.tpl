<?php
	// naplnění proměnných
	$nazev = (isset($_GET["nazev"]) ? $_GET["nazev"] : "");
  $znacka = (isset($_GET["znacka"]) ? $_GET["znacka"] : "");
  $id_typ = (isset($_GET["id_typ"]) ? $_GET["id_typ"] : 0);
  $status = (isset($_GET["status"]) ? $_GET["status"] : 0);
	$id_puvodce = (isset($_GET["id_puvodce"]) ? $_GET["id_puvodce"] : 0);
	$datum1 = (isset($_GET["datum1"]) ? $_GET["datum1"] : "");
	$datum2 = (isset($_GET["datum2"]) ? $_GET["datum2"] : "");
	if ($datum1 || $datum2):
    $errorstring = CheckValidDate(array(($datum1 ? $datum1.($datum2 ? ",$datum2" : "") : $datum2)));
    if ($errorstring):
      unset($_GET['sel']);
      echo "<p class=\"error\">$errorstring</p>\n";  
    endif;	   
	endif;
?>	
		<form method="get" class="publicform">
			<fieldset>
			  <div>
  				<label for="nazev" class="noblock">Název</label>
  				<input type="text" size="40" maxlength="255" name="nazev" id="nazev" value="<?php echo $nazev; ?>" class="txtinput noblock" />
  				<label for="znacka" class="noblock">Značka</label>
  				<input type="text" size="20" maxlength="50" name="znacka" id="znacka" value="<?php echo $znacka; ?>" class="txtinput noblock" />
  			</div>
  			<div>
          <label for="id_typ" class="noblock">Kategorie</label>
          <select name="id_typ" id="id_typ">
            <option value="0">libovolná</option>
            <?php
              $query = "SELECT id,nazev FROM udtyp ORDER BY nazev";
              $qr = mysql_query($query);
              if (!$qr):
                die("Chyba v dotazu: $query");
              endif;
              while ($arr = mysql_fetch_array($qr)) :
                  echo "<option value=\"".$arr['id']."\"".($id_typ == $arr['id'] ? " selected=\"selected\"" : "").">".$arr['nazev']."</option>\n";
              endwhile;
            ?>
          </select>
          <label for="status" class="noblock">Stav</label>
          <select name="status" id="status">
            <option value="0"<?php echo ($status == 0 ? " selected=\"selected\"" : ""); ?>>libovolný</option>
            <option value="1"<?php echo ($status == 1 ? " selected=\"selected\"" : ""); ?>>aktuální</option>
            <option value="2"<?php echo ($status == 2 ? " selected=\"selected\"" : ""); ?>>neaktuální</option>
            <option value="3"<?php echo ($status == 3 ? " selected=\"selected\"" : ""); ?>>archivní</option>
          </select>
        </div>
        <div>
          <label for="id_puvodce" class="noblock">Původce</label>
          <select name="id_puvodce" id="id_puvodce">
            <option value="0">libovolný</option>
            <?php
              $query = "SELECT id,nazev,ulice,misto FROM udpuvodce ORDER BY nazev+ulice+misto";
              $qr = mysql_query($query);
              if (!$qr):
                die("Chyba v dotazu: $query");
              endif;
              while ($arr = mysql_fetch_array($qr)) :
                  echo "<option value=\"".$arr['id']."\"".($id_puvodce == $arr['id'] ? " selected=\"selected\"" : "").">".$arr['nazev'].($arr['ulice'] ? ", ".$arr['ulice'] : "").($arr['misto'] ? ", ".$arr['misto'] : "")."</option>\n";
              endwhile;
            ?>
          </select>
        </div>
        <div>
  				<label for="datum1" class="noblock">Vyvěšeno od</label>
	   			<input type="text" size="10" maxlength="10" name="datum1" id="datum1" value="<?php echo $datum1; ?>" class="txtinput noblock" />
  				<label for="datum2" class="noblock">vyvěšeno do</label>
	   			<input type="text" size="10" maxlength="10" name="datum2" id="datum2" value="<?php echo $datum2; ?>" class="txtinput noblock" />  (DD.MM.RRRR)
				</div>
				<div>
				<input type="hidden" name="sel" value="1" />
				<input type="hidden" name="idform" value="sel" />
				<input type="submit" value="provést výběr" title="tlačítko provést výběr" class="subinput" />
				</div>
			</fieldset>
		</form>
