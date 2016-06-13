<h3>menu</h3>
<?php include "tpl/mainmenu.tpl" ?>
<?php include "tpl/toppages.tpl" ?>
<h3>formáty</h3>
<ul>
	<li><div><a href="<?php echo (strstr($fp,".php") ? "../" : "../page.php?fp=").$fp.(strstr($fp,".php") ? "?" : "&amp;").($_SESSION["userid"] ? SID : ""); ?>">grafická verze</a></div></li>
	<li><div><a href="../rss.xml">rss verze</a></div></li>
	<li><div><a href="../atom.xml">atom verze</a></div></li>
</ul>
<hr />
<h3>kontakt</h3>
<address>
	Město Dačice<br />
	Krajířova 27<br />
	380 13 Dačice I.
</address>
<address>
	 telefon: 384&nbsp;401&nbsp;211<br />
	 e-mail: <a href="mailto:meu@dacice.cz" title="e-mail městského úřadu">meu@dacice.cz</a>
</address>
<address>
	IČO: 00246476<br />
	Bankovní spojení: 0603143369/0800
</address>
<!-- TOPlist2 -->
<script type="text/javascript">
<!--
document.write ('<img src="http://toplist.cz/dot.asp?id=114993&amp;http='+escape(document.referrer)+'&amp;wi='+escape(window.screen.width)+'&he='+escape(window.screen.height)+'&amp;cd='+escape(window.screen.colorDepth)+'&amp;t='+escape(document.title)+'" width="1" height="1" alt="TOPlist" />');
//-->
</script>
<noscript>
<div>
<a href="http://www.toplist.cz/"><img src="http://toplist.cz/dot.asp?id=114993" alt="TOPlist" width="1" height="1" /></a>
</div>
</noscript>
