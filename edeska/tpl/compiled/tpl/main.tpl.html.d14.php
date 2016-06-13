<?php
ob_start(); /* template body */ ?><?php echo '<?xml'; ?> version="1.0" encoding="utf-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="cs">
<head>
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />
	<meta name="author" content="All: Pavel Kamir [C@mus]; mailto:ja@camus.cz" />
	<meta name="author" content="Supported by C@mus; http://www.camus.cz" />
	<meta name="copyright" content="<?php echo $this->scope["copyright"];?>" />
	<meta name="keywords" content="<?php echo $this->scope["keywords"];?>" />
	<meta name="description" content="<?php echo $this->scope["description"];?>" />
	<title><?php echo $this->scope["title"];?></title>
	<link rel='stylesheet' type='text/css' media='all' href='css/editstyles.css' />
	<link rel='stylesheet' type='text/css' media='print' href='css/printer.css' />
	<script type="text/javascript" src="jscripts/fce.js"></script>
</head>
<body>
  <div id="container"><div class="margin">
    <div id="header">
      <h1>Aldesk 1 <span>správa úřední desky</span></h1>
      <div id="today"><?php echo $this->scope["czday"];?></div>
      <div id="webredactor">
        <div>Redaktor: <strong><a href="redactorform.php?<?php echo $this->scope["curl_aid"];?>&amp;act=edit&amp;idrec=<?php echo $this->scope["idred"];?>" title="upravit údaje redaktora"><?php echo $this->scope["userinfo"];?></a></strong> <a href="index.php" title="odhlásit redaktora">odhlásit</a> &raquo;</div>
      </div>
    </div>
    <div id="body">
      <div id="content"><div class="margin">
		<?php echo $this->scope["data"];?>

      </div></div>
      <div id="menu">
      	<?php echo $this->scope["menudata"];?>

      </div>
      <hr class="masterclear" />
    </div>
    <div id="footer">
      <p id="copyright"><a href="http://www.camus.cz">Camus</a>, (c) 2010</p>
    </div>
  </div></div>
</body>
</html><?php  /* end template body */
return $this->buffer . ob_get_clean();
?>