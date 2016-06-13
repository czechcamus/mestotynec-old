<?php
$id = (isset($_GET["id"]) ? $_GET["id"] : 0);
$p = (isset($_GET["p"]) ? $_GET["p"] : "i");
if ($p == "k") {
  $region_id = (isset($_GET["region_id"]) ? $_GET["region_id"] : 14);
  $misto_id = (isset($_GET["misto_id"]) ? $_GET["misto_id"] : 0);
  $kategorie = (isset($_GET["kategorie"]) ? $_GET["kategorie"] : 0);
  $obdobi = (isset($_GET["obdobi"]) ? $_GET["obdobi"] : 30);
  $backlink = "page.php?fp=kalendar&amp;region_id=$region_id&amp;misto_id=$misto_id&amp;kategorie=$kategorie&amp;obdobi=$obdobi";
} else {
  $backlink = "index.php";
}

$templ = "<xsl:stylesheet xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\"
          version=\"1.0\">
      <xsl:output method=\"xml\" omit-xml-declaration=\"yes\" encoding=\"utf-8\"/>

      <xsl:template match=\"/\">
        <div id=\"contentbar\">
	        <div class=\"articlebox\">
            <xsl:apply-templates select=\"//event[@source_event_id='".$id."']\"/>
          </div>            
        </div>
      </xsl:template>

      <xsl:template match=\"event\">
        <h2><xsl:value-of select=\"name\"/></h2>
        <div class=\"dateplace\">
          <xsl:apply-templates select=\"date_time\"/>
          <xsl:apply-templates select=\"place\"/>
          <xsl:if test=\"cena[text()]\">
            <xsl:apply-templates select=\"cena\"/>
          </xsl:if>
        </div>
        <div class=\"eventdescr\">
          <xsl:apply-templates select=\"description\"/>
        </div>
        <xsl:if test=\"organizer[text()]\">
          <div class=\"organizer\">
            Pořadatel: <xsl:apply-templates select=\"organizer\"/>
          </div>
        </xsl:if>
        <div class=\"backlink\"><a href=\"$backlink\">zpět</a></div>
      </xsl:template>
      
      <xsl:template match=\"date_time\">
        <div class=\"datum\">
          <xsl:apply-templates select=\"start\"/>
          <xsl:if test=\"end[text()]\">
            -
            <xsl:apply-templates select=\"end\"/>
          </xsl:if>
        </div>
      </xsl:template>

      <xsl:template match=\"place\">
        <div class=\"place\">
          <xsl:apply-templates select=\"name_place\"/><br />
          <xsl:if test=\"ulice[text()]\">
            <xsl:apply-templates select=\"ulice\"/>
            <xsl:apply-templates select=\"cp\"/>
            <br />
          </xsl:if>
          <xsl:apply-templates select=\"obec\"/> 
        </div>
      </xsl:template>

      <xsl:template match=\"cena\">
        <div class=\"place\">Cena: 
          <xsl:value-of select=\"text()\"/>
        </div>
      </xsl:template>
      
      <xsl:template match=\"description\">
        <xsl:value-of disable-output-escaping=\"yes\" select=\".\"/>
      </xsl:template>
      
      <xsl:template match=\"start|end\">
        <xsl:value-of select=\"concat(substring(text(),9,2),'.',substring(text(),6,2),'.',substring(text(),1,4))\"/>
        <xsl:if test=\"substring(text(),12,5)!='00:00' and substring(text(),12,5)!='23:59'\">
          <xsl:value-of select=\"concat(' ',substring(text(),12,5),' h.')\"/>
        </xsl:if>
      </xsl:template>

      <xsl:template match=\"cp\">
        <xsl:value-of select=\"concat(' ',text())\"/>
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
$proc->importStylesheet($xsl);

// provedení transformace a vypsání výsledku
echo $proc->transformToXML($xml);
?>
