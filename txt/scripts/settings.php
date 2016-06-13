<?php

// nastavení databáze
$DATABASE		= "dacicem";				// jméno databáze
$DB_ADRESS		= "localhost";				// nazev serveru
$DB_USER		= "dacicem";				// username ""
$DB_PASSWORD	= "fjFUDv55";				// password ""


// připojení k databázi
@$connection = MySQL_Connect("$DB_ADRESS","$DB_USER","$DB_PASSWORD");
if (!$connection) die("nepodařilo se připojit k serveru");
@$selection = MySQL_Select_DB("$DATABASE");
if (!$selection) die("nepodařilo se vybrat databázi");

// nastavení konstant
$perexhpcnt		= 3;								// počet perexů na homepagi
$perexcnt		= 5;								// počet perexů na stránce
$cssthumbimg	= "thumbimg";						// CSS styl pro obrázky úvodníku
$aktualcnt		= 5;								// počet zobrazovaných aktualit na hlavní stránce
$mistoakcihp	= 4;								// místní určení akcí v kalendáři na HP - dačicko má číslo 4
$dnyakcihp		= 7;								// na HP se budou zobrazovat akce na příštích 7 dní
$dnyakcikal		= 30;								// v hlavním kalednáři se budou zobrazovat akce na příštích 30 dnů
$kalendarfile	= "kalendar";						// jméno souboru s hlavním kalendářem
$poczazstr		= 15;								// počet vybraných záznamů na jedné stránce
?>
