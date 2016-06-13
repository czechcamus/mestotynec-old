<?php

// nastavení databáze
$DATABASE		= "mestotynec";   // mestotynec
$DB_ADRESS		= "localhost";		//"uvdb4.globe.cz"; nazev serveru
$DB_USER		= "mestotynec";
$DB_PASSWORD	= "bwpnNqdd";

// pripojení k databázi
@$connection = mysql_connect("$DB_ADRESS","$DB_USER","$DB_PASSWORD");
if (!$connection) die("nepodarilo se pripojit k serveru");
@$selection = mysql_select_db("$DATABASE");
if (!$selection) die("nepodarilo se vybrat databázi");

// nastaveni češtiny
$q = "SET NAMES 'utf8' COLLATE 'utf8_czech_ci'";
$r = mysql_query("$q");
if (!$r):
	die("Nastavení kódové stránky selhalo");
endif;

// nastavení konstant
$cssthumbimg	= "thumbimg";						// CSS styl pro obrázky úvodníku
$aktualcnt		= 5;								// počet zobrazovaných aktualit na hlavní stránce
$mistoakcihp	= 1;								// místní určení akcí v kalendáři na HP - dačicko má číslo 4
$dnyakcihp		= 14;								// na HP se budou zobrazovat akce na příštích 7 dní
$dnyakcikal		= 30;								// v hlavním kalednáři se budou zobrazovat akce na příštích 30 dnů
$kalendarfile	= "kalendar";						// jméno souboru s hlavním kalendářem
$poczazstr		= 20;								// počet vybraných záznamů na jedné stránce
$newsletterdays = 7;								// periodicita posílání newsletteru
$webcammenu   = 230;                // id menu webkamery
?>
