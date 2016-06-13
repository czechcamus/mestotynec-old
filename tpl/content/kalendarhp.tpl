<?php
$obdobi = 14;
$templ = "<xsl:stylesheet xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\" 
      xmlns:php=\"http://php.net/xsl\" extension-element-prefixes=\"php\" version=\"1.0\">
      <xsl:output method=\"xml\" omit-xml-declaration=\"yes\" encoding=\"utf-8\"/>

      <xsl:template match=\"/\">
        <div id=\"calendarbox\">
          <h3>pozvánky</h3>
          <xsl:apply-templates select=\"//event[place[obec_uir='530841']][date_time[number(concat(substring(start,1,4),substring(start,6,2),substring(start,9,2)))&lt;=".strval(date('Ymd',time()+($obdobi*86400)))."]]\"/>
        </div>
      </xsl:template>

      <xsl:template match=\"event\">
        <div class=\"calendaritem\">
          <xsl:apply-templates select=\"events_type\"/>
          <xsl:apply-templates select=\"date_time\"/>
          <xsl:apply-templates select=\"name\"/>
          <xsl:apply-templates select=\"place\"/>
          <hr class=\"masterclear\"/>
        </div>
      </xsl:template>

      <xsl:template match=\"name\">
        <h4><a href=\"kalendar.php?id={../@source_event_id}&amp;p=i\"><xsl:value-of select=\".\"/></a></h4>
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

      <xsl:template match=\"events_type\">
        <div class=\"category\">
          <xsl:value-of select=\"php:function('categorystring',string(text()))\"/>
        </div>
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
