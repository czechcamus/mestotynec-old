<?php
$region_id = (isset($_GET["region_id"]) ? $_GET["region_id"] : 14);
$misto_id = (isset($_GET["misto_id"]) ? $_GET["misto_id"] : 0);
$kategorie = (isset($_GET["kategorie"]) ? $_GET["kategorie"] : 0);
$obdobi = (isset($_GET["obdobi"]) ? $_GET["obdobi"] : 30);

echo "<form action=\"page.php\" method=\"get\" id=\"calendarform\">\n";
echo "<fieldset>\n";
echo "<div>\n";
echo "<label for=\"region_id\" class=\"noblock\">Region:</label>\n";
echo "<select name=\"region_id\" id=\"region_id\" size=\"1\">";
echo "<option value=\"0\"".($region_id=="0" ? " selected=\"selected\"" : "").">všechny regiony</option>\n";
$sq = "SELECT DISTINCT region_id,region_name FROM cities ORDER BY region_name";
$rq = mysql_query($sq);
while ($arr = mysql_fetch_array($rq)):
	echo "<option value=\"".$arr["region_id"]."\"";
	echo ($region_id==$arr["region_id"] ? " selected=\"selected\"" : "");
	echo ">".$arr["region_name"]."</option>\n";
endwhile;
echo "</select>\n";
echo "<label for=\"misto_id\" class=\"noblock\">Místo:</label>\n";
echo "<select name=\"misto_id\" id=\"misto_id\" size=\"1\">";
echo "<option value=\"0\"".($misto_id=="0" ? " selected=\"selected\"" : "").">všechna místa</option>\n";
$sq = "SELECT DISTINCT city_key_id AS misto_id,if(city_use_full_name = 1,city_full_name,city_name) AS misto_name  FROM cities ORDER BY misto_name";
$rq = mysql_query($sq);
while ($arr = mysql_fetch_array($rq)):
	echo "<option value=\"".$arr["misto_id"]."\"";
	echo ($misto_id==$arr["misto_id"] ? " selected=\"selected\"" : "");
	echo ">".$arr["misto_name"]."</option>\n";
endwhile;
echo "</select>\n";
echo "</div><div>\n";
echo "<label for=\"kategorie\" class=\"noblock\">Kategorie:</label>\n"; 
echo "<select name=\"kategorie\" id=\"kategorie\" size=\"1\">\n";
echo "<option value=\"0\"".($kategorie==0 ? " selected=\"selected\"" : "").">bez rozlišení</option>\n";
echo "<option value=\"2\"".($kategorie==2 ? " selected=\"selected\"" : "").">výstava</option>\n";
echo "<option value=\"3\"".($kategorie==3 ? " selected=\"selected\"" : "").">představení</option>\n";
echo "<option value=\"4\"".($kategorie==4 ? " selected=\"selected\"" : "").">kino</option>\n";
echo "<option value=\"5\"".($kategorie==5 ? " selected=\"selected\"" : "").">koncert</option>\n";
echo "<option value=\"6\"".($kategorie==6 ? " selected=\"selected\"" : "").">slavnost</option>\n";
echo "<option value=\"8\"".($kategorie==8 ? " selected=\"selected\"" : "").">trhy - jarmark</option>\n";
echo "<option value=\"10\"".($kategorie==10 ? " selected=\"selected\"" : "").">sport</option>\n";
echo "<option value=\"12\"".($kategorie==12 ? " selected=\"selected\"" : "").">vzdělávání</option>\n";
echo "<option value=\"18\"".($kategorie==18 ? " selected=\"selected\"" : "").">turistika</option>\n";
echo "</select>\n";
echo "<label for=\"obdobi\" class=\"noblock\">Období:</label>\n"; 
echo "<select name=\"obdobi\" id=\"obdobi\" size=\"1\">\n";
echo "<option value=\"1\"".($obdobi==1 ? " selected=\"selected\"" : "").">dnes</option>\n";
echo "<option value=\"7\"".($obdobi==7 ? " selected=\"selected\"" : "").">příštích 7 dnů</option>\n";
echo "<option value=\"30\"".($obdobi==30 ? " selected=\"selected\"" : "").">příštích 30 dnů</option>\n";
echo "<option value=\"365\"".($obdobi==365 ? " selected=\"selected\"" : "").">příštích 365 dnů</option>\n";
echo "</select>\n";
echo "</div>\n";
echo "<input type=\"hidden\" name=\"fp\" value=\"".$kalendarfile."\" />\n";
echo "<input type=\"submit\" name=\"odeslano\" value=\"Vybrat\" class=\"subinput\" />\n";
echo "</fieldset>\n";
echo "</form>\n";

// výběr obcí podle čísla regionu nebo čísla obce
if ($region_id && !$misto_id) {
  $sq = "SELECT DISTINCT city_key_id FROM cities WHERE region_id=$region_id";
  $rq = mysql_query($sq);
  if (!$rq) {
    die("Chyba v dotazu $sq");
  }
  $citystring = "";
  while ($arr = mysql_fetch_array($rq)) {
    if ($citystring) {
      $citystring .= " or cobce_uir='".substr("000000".$arr["city_key_id"],-6)."'";
    } else {
      $citystring = "cobce_uir='".substr("000000".$arr["city_key_id"],-6)."'";
    }
  }
} elseif ($misto_id) {
  $citystring = "cobce_uir='".substr("000000".$misto_id,-6)."'";
} else {
  $citystring = "cobce_uir";
}

// výber akcí podle kategorie
if ($kategorie) {
  $kategoriestring = "events_type='$kategorie'";
} else {
  $kategoriestring = "events_type";
}
$templ = "<xsl:stylesheet xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\" 
      xmlns:php=\"http://php.net/xsl\" extension-element-prefixes=\"php\" version=\"1.0\">
      <xsl:output method=\"xml\" omit-xml-declaration=\"yes\" encoding=\"utf-8\"/>

      <xsl:template match=\"/\">
        <div id=\"mainkalendarbox\">
          <xsl:apply-templates select=\"//event[place[".$citystring."]][".$kategoriestring."][date_time[number(concat(substring(start,1,4),substring(start,6,2),substring(start,9,2)))&lt;=".strval(date('Ymd',time()+($obdobi*86400)))."]]\"/>
        </div>
      </xsl:template>

      <xsl:template match=\"event\">
        <div class=\"item2\" id=\"id_{@source_event_id}\">
          <xsl:apply-templates select=\"events_type\"/>
          <xsl:apply-templates select=\"date_time\"/>
          <xsl:apply-templates select=\"name\"/>
          <xsl:apply-templates select=\"place\"/>
          <hr class=\"masterclear\"/>
        </div>
      </xsl:template>

      <xsl:template match=\"name\">
        <h5><a href=\"kalendar.php?id={../@source_event_id}&amp;p=k&amp;region_id=$region_id&amp;misto_id=$misto_id&amp;kategorie=$kategorie&amp;obdobi=$obdobi\"><xsl:value-of select=\".\"/></a></h5>
      </xsl:template>
      
      <xsl:template match=\"events_type\">
        <div class=\"category\">
          <xsl:value-of select=\"php:function('categorystring',string(text()))\"/>
        </div>
      </xsl:template>

      <xsl:template match=\"date_time\">
        <div class=\"datum\">
          <xsl:apply-templates select=\"start\"/>
          <xsl:if test=\"end[text()] and (substring(start[text()],0,10) != substring(end[text()],0,10))\">
            <xsl:text> - </xsl:text>
            <xsl:apply-templates select=\"end\"/>
          </xsl:if>
        </div>
      </xsl:template>

      <xsl:template match=\"place\">
        <div class=\"city\">
          <xsl:apply-templates select=\"obec\"/>
        </div>
        <xsl:if test=\"name_place[text()]\">
          <div class=\"place\">
            <xsl:apply-templates select=\"name_place\"/>
          </div>
        </xsl:if>
      </xsl:template>
      
      <xsl:template match=\"name_place|obec\">
        <xsl:value-of select=\".\"/>
      </xsl:template>
      
      <xsl:template match=\"start|end\">
        <xsl:value-of select=\"php:function('czdatum',string(text()))\"/>
      </xsl:template>

  </xsl:stylesheet>";
      
// načtení dokumentu XML
$xml = new DomDocument();
$xml->load("http://www.posazavi.com/export/eventswithlocalcharacter.asp");

// načtení stylu XSLT
$xsl = new DomDocument();
$xsl->loadXML($templ);

// vytvoření procesoru XSLT
$proc = new xsltprocessor();
$proc->registerPhpFunctions();
$proc->importStylesheet($xsl);

// provedení transformace a vypsání výsledku
echo $proc->transformToXML($xml);
?>
