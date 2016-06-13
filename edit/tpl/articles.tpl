<div id="articles">
	<h3>Články ke schválení:</h3>
	<?php
		// výběr dosud neschválených článků
		$dotaz = "SELECT * FROM mastertxt WHERE publish=0";
		$result = mysql_query("$dotaz");
		if (!$result):
			die("Nepodařilo se vybrat data!");
		else:
			while ($record = mysql_fetch_array($result)):
				$itemid = $record["id"];
				echo "<a href=\"./contentmng.php?menuid=$menuid&amp;itemid=$itemid\">".$record["titulek"]."</a><br />\n";
			endwhile;
		endif;
	?>
</div>