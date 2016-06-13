<?php
	$dotaz = "SELECT me.filename,mt.id,mt.titulek,mt.perex,au.nick,mt.caszapisu FROM mastertxt AS mt, articlejoin AS aj, menu AS me, autor AS au WHERE mt.perex>'' AND mt.publish=1 AND mt.id=aj.mtid AND aj.menuid=me.id AND mt.idautor=au.id ORDER BY caszapisu DESC LIMIT 0,20";
	$result = mysql_query("$dotaz");
	if (!$result):
		die("Nezdařil se výběr z tabulky mastertext - createxml.php!");
	else:
		// odstřižení tagů v textu
		$search = array (
		"'<head>.*?</head>'si",					// hlavička 
		"'<script[^>]*?>.*?</script>'si",		// javascript
		"'<[\/\!]*?[^<>]*?>'si",          		// html tagy
		"'\{.*?\}'si",							// {} tagy
		"'\[.*?\]'si",							// [] tagy
		"'\[.*?\]'si",							// [] tagy
		"'<.*?>'si",							// <> tagy
		"'\(.*?\)'si",							// () tagy
		"'(<!--).*?(-->)'si",					// komentáře
		"'([\r\n])[\s]+'",						// mezery
		"'&(quot|#34);'i",						// html entity
		"'&(amp|#38);'i",
		"'&(lt|#60);'i",
		"'&(gt|#62);'i",
		"'&(nbsp|#160);'i",
		"'&(iexcl|#161);'i",
		"'&(cent|#162);'i",
		"'&(pound|#163);'i",
		"'&(copy|#169);'i",
		"'&#(\d+);'e"							// zpracování php
		);
		
		// nahrazující znaky
		$replace = array(
		" ", 
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		"",
		" ",
		"\\1",
		"\"",
		"&",
		"<",
		">",
		" ",
		chr(161),
		chr(162),
		chr(163),
		chr(169),
		"chr(\\1)"
		);
		
		$text = preg_replace($search, $replace, $fulldoc);
		$text = str_replace("&nbsp;", " ", $text);
	
		$path = substr($script, 0, strrpos($script, "/"));
		$path = ereg_replace("/edit","/",$path);
		$rssname = "../rss.xml";
		$atomname = "../atom.xml";
		$rsstext1 = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n";
		$atomtext1 = $rsstext1;
		$rsstext1 .= "<rdf:RDF\n";
		$rsstext1 .= "xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\"\n";
		$rsstext1 .= "xmlns:dc=\"http://purl.org/dc/elements/1.1/\"\n";
		$rsstext1 .= "xmlns:sy=\"http://purl.org/rss/1.0/modules/syndication/\"\n";
		$rsstext1 .= "xmlns:admin=\"http://webns.net/mvcb/\"\n";
		$rsstext1 .= "xmlns:cc=\"http://web.resource.org/cc/\"\n";
		$rsstext1 .= "xmlns=\"http://purl.org/rss/1.0/\">\n";
		$rsstext1 .= "<channel rdf:about=\"http://".$server.$path."\">\n";
		$rsstext1 .= "<title>Týnec nad Sázavou</title>\n";
		$rsstext1 .= "<link>http://".$server.$path."</link>\n";
		$rsstext1 .= "<description>Oficiální web města Týnce nad Sázavou</description>\n";
		$rsstext1 .= "<copyright>Město Týnec nad Sázavou, (c) 2005</copyright>\n";
		$rsstext1 .= "<dc:language>cs</dc:language>\n";
		$rsstext1 .= "<dc:creator>C@mus</dc:creator>\n";
		$gmdatum = gmdate("Y-m-d H:m:s", time());
		$datum = substr($gmdatum,0,10)."T".substr($gmdatum,11,8)."+01:00";
		$rsstext1 .= "<dc:date>".$datum."</dc:date>\n";
		$rsstext1 .= "<admin:generatorAgent rdf:resource=\"http://".$server.$path."\" />\n";
		$rsstext1 .= "<items>\n";
		$rsstext1 .= "<rdf:Seq>\n";
		$atomtext1 .= "<?xml-stylesheet type=\"text/css\" href=\"css/atom.css\"?>\n";
		$atomtext1 .= "<feed version=\"0.3\" xmlns=\"http://purl.org/atom/ns#\">\n";
		$atomtext1 .= "<title>Týnec nad Sázavou</title>\n";
		$atomtext1 .= "<link rel=\"alternate\" type=\"text/html\" href=\"http://".$server.$path."\" />\n";
		$atomtext1 .= "<info mode=\"xml\" type=\"text/html\">\n";
		$atomtext1 .= "<div xmlns=\"http://www.w3.org/1999/xhtml\">\n";
		$atomtext1 .= "This is an Atom formatted XML site feed.\n";
		$atomtext1 .= "It is intended to be viewed in a Newsreader\n";
		$atomtext1 .= "or syndicated to another site.\n";
		$atomtext1 .= "</div>\n";
		$atomtext1 .= "</info>\n";
		$atomtext1 .= "<modified>".$datum."</modified>\n";
		$atomtext1 .= "<issued>".$datum."</issued>\n";
		$rsstext2 = "";
		$atomtext2 = "";
		while ($record = mysql_fetch_array($result)):
			$rsstext1 .= "<rdf:li rdf:resource=\"http://".$server.$path."page.php?fp=".$record["filename"]."&amp;artid=".$record["id"]."\" />\n";
			$rsstext2 .= "<item rdf:about=\"http://".$server.$path."page.php?fp=".$record["filename"]."&amp;artid=".$record["id"]."\">\n";
			$rsstext2 .= "<title>".$record["titulek"]."</title>\n";
			$text = preg_replace($search, $replace, $record["perex"]);
			$text = utf8_substr(str_replace("&nbsp;", " ", $text),0,250);
			$rsstext2 .= "<description>".$text."</description>\n";
			$rsstext2 .= "<link>http://".$server.$path."page.php?fp=".$record["filename"]."&amp;artid=".$record["id"]."</link>\n";
			$rsstext2 .= "<dc:creator>".$record["nick"]."</dc:creator>\n";
			$gmdatum = gmdate("Y-m-d H:m:s", GetIntTime($record["caszapisu"]));
			$datum = substr($gmdatum,0,10)."T".substr($gmdatum,11,8)."+01:00";
			$rsstext2 .= "<dc:date>".$datum."</dc:date>\n";
			$rsstext2 .= "</item>\n";
			$atomtext2 .= "<entry>\n";
			$atomtext2 .= "<title type=\"text/html\" mode=\"escaped\">".$record["titulek"]."</title>\n";
			$atomtext2 .= "<link rel=\"alternate\" type=\"text/html\" href=\"http://".$server.$path."page.php?fp=".$record["filename"]."&amp;artid=".$record["id"]."\" />\n";
			$atomtext2 .= "<author>\n";
			$atomtext2 .= "<name>".$record["nick"]."</name>\n";
			$atomtext2 .= "</author>\n";
			$atomtext2 .= "<modified>".$datum."</modified>\n";
			$atomtext2 .= "<issued>".$datum."</issued>\n";
			$atomtext2 .= "<content type=\"application/xhtml+xml\" xml:base=\"http://".$server.$path."\" xml:lang=\"cs-CZ\" xml:space=\"preserve\">\n";
			$atomtext2 .= "<div xmlns=\"http://www.w3.org/1999/xhtml\">\n";
			$atomtext2 .= "<p>".$text."</p>\n";
			$atomtext2 .= "</div>\n";
			$atomtext2 .= "</content>\n";
			$atomtext2 .= "</entry>\n";
		endwhile;
		$rsstext1 .= "</rdf:Seq>\n";
		$rsstext1 .= "</items>\n";
		$rsstext1 .= "</channel>\n";
		$rsstext2 .= "</rdf:RDF>\n";
		$atomtext2 .= "</feed>\n";
		$rsstext = $rsstext1.$rsstext2;
		$atomtext = $atomtext1.$atomtext2;
		$rssfp = fopen($rssname,"w");
		fputs($rssfp,$rsstext);
		fclose($rssfp);
		$atomfp = fopen($atomname,"w");
		fputs($atomfp,$atomtext);
		fclose($atomfp);
	endif;
	
?>
