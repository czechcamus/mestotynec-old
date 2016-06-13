<?php
$pref = "../";
require "usrfce.php";

// procházení tabulky udeska a úpravy
$sql = "SELECT id, docfile FROM udeska";
try {
    $res = mysql_query($sql);
    while ($row = mysql_fetch_array($res)) {
        $trans = array('download/' => 'download/edeska/', 'download/edeska/' => 'download/edeska/');
        $oldfile = $pref.$row[1];
        $newfile = strtr($oldfile, $trans);
        if (file_exists($oldfile)) {
            if ($oldfile != $newfile) {
                if (rename($oldfile, $newfile)) {
                    $updatesql = "UPDATE udeska SET docfile='".strtr($row[1],$trans)."' WHERE id=".$row[0];
                    try {
                        $updateres = mysql_query($updatesql);
                    } catch (Exception $e) {
                        echo $e->getTraceAsString('Něco se pokazilo při úpravě tabulky udeska... :-(');
                    }
                } else {
                    echo "Něco se pokazilo při přesunu souboru... :-(<br />\n";
                }
            }
        } else {
            echo "Nenalezen soubor: <strong>".$row[1]."</strong> - zápis č. <strong>".$row[0]."</strong><br />\n";
        }
    }
} catch (Exception $e) {
    echo $e->getTraceAsString('Něco se pokazilo při čtení z tabulky udeska... :-(');
}
echo "<p><strong>Přesun souborů úřední desky byl ukončen.</strong></p>\n";

/*
// mazání souborů nepřipojených v CMS
// procházení adresáře download
$filedir = $pref.'download';
if ($d = dir($filedir)) {
    while (false !== ($entry = $d->read())) {
        if (file_exists($filedir.'/'.$entry)) {
            if (!SearchForFile($entry)) {
                try {
                    unlink($filedir.'/'.$entry);
                } catch (Exception $e) {
                    echo $e->getTraceAsString('Něco se pokazilo při mazání souboru... :-(');
                }
            }
        }
    }
}
echo "<p><strong>Mazání nepoužitých souborů bylo ukončeno.</strong></p>\n";

// hledání souboru v tabulkách
function SearchForFile($file) {
    $found = false;
    // hledání souboru z download v tabulce mpdoc (filename)
    $sql = CreateSelect($file,'mpdoc','filename');
    $res = mysql_query($sql);
    if (mysql_num_rows($res) > 0) {
        $found = true;
    }
    // hledání souboru z download v tabulce soubor (addrlnk)
    if (!$found) {
        $sql = CreateSelect($file,'soubor','addrlnk');
        $res = mysql_query($sql);
        if (mysql_num_rows($res) > 0) {
            $found = true;
        }
    }
    // hledání souboru z download v tabulce text (txt)    
    if (!$found) {
        $sql = CreateSelect($file,'text','txt');
        $res = mysql_query($sql);
        if (mysql_num_rows($res) > 0) {
            $found = true;
        }
    }
    return $found;
}

// tvorba selectu
function CreateSelect($file, $table, $field) {
    return "SELECT * FROM $table WHERE $field LIKE '%$file%'";
}
 * 
 */
?>
