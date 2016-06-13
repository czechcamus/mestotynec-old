<?php
	if ($fp != "index.php"):
		include "tpl/navbar.tpl";
	else:
		include "tpl/content/maininfo.tpl";
	endif;
	if (!$photodetail):
		include "tpl/content/maininfoperex.tpl";
		if ($fp == "index.php"):
			include "tpl/content/maininfoperex.tpl";
			include "tpl/rightpannel.tpl";
		else:
			include "tpl/content/maininfo.tpl";
			include "tpl/content/maininfoperex.tpl";
		endif;
		if (IsSubmenu($fp)):
			include "tpl/content/maininfolist.tpl";
		endif;
	endif;
?>