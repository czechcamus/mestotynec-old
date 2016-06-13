<?php
//$path = 'c:/data/html/vlastni_projekty/tynec/web';
$path = '/www/doc/www.mestotynec.cz/home';
set_include_path(get_include_path() . PATH_SEPARATOR . $path);
require_once 'HTML/Template/Flexy.php';

abstract class Controller 
{
	protected $tpl = '', $elements = array();
	public $error = '';
	
	public function __construct()
	{
		$this->start();
		$this->output();
	}
	
	public function start() {}
	
	public function output() 
	{
		$output = new HTML_Template_Flexy(array(   
	        'compileDir'    =>  'comp',
	        'templateDir'   =>  'tpl',));
		$output->compile($this->tpl);
		$output->outputObject($this,$this->elements);
	}
}
?>
