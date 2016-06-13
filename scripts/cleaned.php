<?php
/*
 * Maže nepotřebné přílohy úřední desky
 */
// prochází tabulku udeska s neplatnými přílohami a maže je z disku na serveru
$pref = "../";
require "usrfce.php";

// procházení tabulky udeska a mazání dočasných souborů
$thisdate = date('Y-m-d H:i:s');
$sql = "SELECT id, docfile FROM udeska WHERE istempfile=1 AND datume<'".$thisdate."'";
try {
    $res = mysql_query($sql);
    while ($row = mysql_fetch_array($res)) {
        $file = $pref.$row[1];
        if (file_exists($file)) {
            try {
                unlink($file);
            } catch (Exception $e) {
                echo $e->getTraceAsString('Neco se pokazilo pri mazani souboru... :-(');
            }
        }
    }
} catch (Exception $e) {
    echo $e->getTraceAsString('Neco se pokazilo pri cteni z tabulky udeska... :-(');
}

// mazání souborů nepřipojených v úřední desce
// procházení adresáře download/edeska
$filedir = $pref.'download/edeska';
if ($d = dir($filedir)) {
    while (false !== ($entry = $d->read())) {
        if (file_exists($filedir.'/'.$entry)) {
            if (($entry != '.') && ($entry != '..') && !SearchForFile($entry)) {
                try {
                    unlink($filedir.'/'.$entry);
                } catch (Exception $e) {
                    echo $e->getTraceAsString('Neco se pokazilo pri mazani souboru... :-(');
                }
            }
        }
    }
}

// hledání souboru v tabulkách
function SearchForFile($file) {
    $found = false;
    // hledání souboru z download/edeska v tabulce udeska (docfile)
    $sql = CreateSelect($file,'udeska','docfile');
    $res = mysql_query($sql);
    if (mysql_num_rows($res) > 0) {
        $found = true;
    }
    return $found;
}

// tvorba selectu
function CreateSelect($file, $table, $field) {
    return "SELECT * FROM $table WHERE $field LIKE '%$file%'";
}
?>
