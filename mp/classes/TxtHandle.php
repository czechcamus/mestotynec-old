<?php
final class TxtHandle {

	private $fname;

	public function readFile($fname) {
		$this->fname = $fname;
		$txt = '';
		if (@$fp = fopen($this->fname, "r")) {
	        $txt = fread($fp,filesize($this->fname));
	        fclose($fp);
		}
		return $txt;
	}
	
	public function writeFile($fname,$txt) {
		$this->fname = $fname;
		if (@$fp = fopen($this->fname, "w")) {
	        fwrite($fp,$txt);
	        fclose($fp);
		} 
	}
}
?>