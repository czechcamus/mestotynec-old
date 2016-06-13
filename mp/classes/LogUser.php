<?php
final class LogUser {
	public  $id,                    // id uživatele
  			$aid,                   // identifikační řetězec
  			$sql,                   // objekt MySqlHandle pro komunikaci s databází
  			$tb_user = 'redaktor',	// název tabulky s uživateli
  			$field_login = 'user',	// název pole s loginem
  			$field_password = 'pwd',// název pole s heslem
  			$field_auth = 'auth',	// název pole identifikačním řetězcem
  			$field_id = 'id',		// název pole id uľivatele
  			$url_aid,				// obsahuje identifikační řetězec pokud není předáván v cookie
			$curl_aid,				// obsahuje název url proměnné, = a identifikační řetězec pokud není předáván v cookie
			$use_cookie = false,	// pokud je nastaveno na TRUE pokusí se předávat identifikační řetězec v cookie
			$cookie_name = 'aid',	// název cookie s identifikačním řetězcem
			$url_name = 'aid';		// název proměnné v url s identifikačním řetězcem

  
	function login($login, $password)
	// Tato funkce přihlásí uživatele 
  	{
    	// pokusí se najít uživatele podle loginu a hesla
  		$this->id = $this->sql->getResult(
     		'SELECT '.$this->field_id.' FROM '.$this->tb_user.'
      		WHERE '.$this->field_login.'="'.addslashes($login).'"
      		AND '.$this->field_password.'="'.addslashes($password).'"');
    	if($this->id) {
	    	// pokud je heslo a login správně vytvoří identifikační řetězec
    		$auth = md5($login.$password.microtime());
      		$this->sql->makeQuery('UPDATE '.$this->tb_user.'
				SET '.$this->field_auth.'="'.addslashes($auth).'"
				WHERE '.$this->field_id.'='.$this->id);
			$this->aid = $auth.'x'.$this->id;
			$this->url_aid = $this->aid;
			$this->curl_aid = $this->url_name.'='.$this->url_aid;
			return true;
	    } else {
	    	return false;
	    }
	}
  
	function logout()
	// odhlásí uživatele tak že smaže identifikační řetězec v db
	{
		$this->sql->makeQuery('UPDATE '.$this->tb_user.'
			SET '.$this->field_auth.'=""
			WHERE '.$this->field_id.'='.$this->id);
		// aby se nepředával neplatný identifikační řetězec odstraní jej
		$this->id = 0;
		$this->aid = '';
		$this->url_aid = '';
		$this->curl_aid = '';
	}
  
	function check($aid = '')
	// pokud nebyl identifikační řetězec zadán pokusí se jej získat z $_REQUEST nebo $_COOKIE
	{
		if (empty($aid)) {
			$aid = $_REQUEST[$this->url_name];
		}
		// oddělí id uživatele a hash
		list($auth, $id) = explode('x', $aid);
		$id = (int)$id;
		// pokud není id nebo hash prázdný ověří přihlášení uživatele v db
		if (isset($auth) && isset($id)) {
			$this->id = $this->sql->getResult(
				'SELECT id FROM '.$this->tb_user.'
				WHERE '.$this->field_id.'='.$id.'
				AND '.$this->field_auth.'="'.addslashes($auth).'"');
			if($this->id) {
				// pokud ověření proběhlo úspěšně nastaví identifikační řetězec
				$this->aid = $auth.'x'.$this->id;
				$this->url_aid = $this->aid;
				$this->curl_aid = $this->url_name.'='.$this->url_aid;
				return(true);
			} else {
				return(false);
			}
		} else { 
			return(false);
		}
	}
	
	function getinfo()
	// vrátí pole s údaji uživatele 
	{
		return mysql_fetch_array($this->sql->makeQuery('SELECT * FROM '.$this->tb_user.'
			WHERE '.$this->field_id.'='.$this->id));
	}
	
}
?>