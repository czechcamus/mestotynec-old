<?php
  $xml = simplexml_load_file('http://www.meteopress.cz/data/tynec_nad_sazavou/12_data_pocasi_12.xml');

  $den1 = $xml->pp_benesov_123->a_benesov;
  $den1pocasi = $den1->pocasi;
  $den1min = $den1->min_interval;
  $den1max = $den1->max_interval;
  $den1cas = (date('G') >= '23' ? (time()+86400) : (time()));
  $den1dat = date('d.m',$den1cas);
  $den1day = GetCzDay(date('Y-m-d',$den1cas));

  $den2 = $xml->pp_benesov_123->b_benesov;
  $den2pocasi = $den2->pocasi;
  $den2min = $den2->min_interval;
  $den2max = $den2->max_interval;
  $den2cas = $den1cas+86400;
  $den2dat = date('d.m',$den2cas);
  $den2day = GetCzDay(date('Y-m-d',$den2cas));

  $den3 = $xml->pp_benesov_123->c_benesov;
  $den3pocasi = $den3->pocasi;
  $den3min = $den3->min_interval;
  $den3max = $den3->max_interval;
  $den3cas = $den1cas+172800;
  $den3dat = date('d.m',$den3cas);
  $den3day = GetCzDay(date('Y-m-d',$den3cas));

	echo "<div id=\"weatherbox\">\n";
	echo "<h3>počasí</h3>\n";
  	echo "<div title=\"".GetPocasiText($den1pocasi)."\" class=\"weatheritem ".strtolower($den1pocasi)."\">\n";
  	echo "<div class=\"daytitle\">$den1day, $den1dat</div>\n";
  	echo "<div class=\"tempbox\">noc: $den1min <br />den: $den1max</div>\n";
  	echo "</div>\n";
  	echo "<div title=\"".GetPocasiText($den2pocasi)."\" class=\"weatheritem ".strtolower($den2pocasi)."\">\n";
  	echo "<div class=\"daytitle\">$den2day, $den2dat</div>\n";
  	echo "<div class=\"tempbox\">noc: $den2min <br />den: $den2max</div>\n";
  	echo "</div>\n";
  	echo "<div title=\"".GetPocasiText($den3pocasi)."\" class=\"weatheritem ".strtolower($den3pocasi)."\">\n";
  	echo "<div class=\"daytitle\">$den3day, $den3dat</div>\n";
  	echo "<div class=\"tempbox\">noc: $den3min <br />den: $den3max</div>\n";
  	echo "</div>\n";
  echo "<p>Více o počasí na <a href='http://www.meteopress.cz/'>www.meteopress.cz</a></p>";  	
	echo "</div><!-- end pocasibox -->\n";
?>
<script type="text/javascript"><!--
google_ad_client = "pub-0088810933170660";
google_ad_width = 125;
google_ad_height = 125;
google_ad_format = "125x125_as";
google_ad_type = "text";
//2007-09-04: Ing. Krejza Jiří
google_ad_channel = "7885810133";
//-->
</script>
<div id="googleadd">
<script type="text/javascript"
  src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script>
</div>
