<?php // Albert3 
$img = imagecreate(35,14);

//barvy
$bg = imagecolorallocate($img, 222, 222, 222);
$cerna = imagecolorallocate($img, 0, 0, 0);

//vypis textu
imagestring($img,5,0,0,$_GET['n'],$cerna);

//odeslani a ukonceni
header("Content-type: image/PNG");
imagepng($img);
imagedestroy($img);
?>
