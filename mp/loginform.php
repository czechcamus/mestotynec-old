<?php
include_once 'classes/Controller.php';

class ControllerLogin extends Controller 
{
	public $tpl = 'loginform.tpl.html', $title = 'Formulář pro přihlášení', $user = '', $pwd = '';
	
	public function start()
	{
		// data
		$this->error = (isset($_REQUEST['err']) ? $_REQUEST['err'] : '');
		$arr = $_REQUEST;	
		// plneni promennych
		foreach ($arr as $key => $var) {
			$this->$key = $var;
		}
		include_once 'HTML/Template/Flexy/Element.php';
		$this->elements['user'] = new HTML_Template_Flexy_Element;
		$this->elements['user']->setValue($this->user);
		$this->elements['pwd'] = new HTML_Template_Flexy_Element;
		$this->elements['pwd']->setValue($this->pwd);
	}
}

new ControllerLogin();
?>
