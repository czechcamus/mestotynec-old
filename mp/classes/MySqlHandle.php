<?php
class MySqlException extends Exception {

   protected $message;

   function __construct($message) {
	  $this->message = $message;
   }
}

final class MySqlHandle {

	private $dbuser, $dbpswd, $dbname, $dbserver, $dbconn, $dbsel, $queryresult;

	public function openConnection($dbuser,$dbpswd,$dbname,$dbserver) {
		try {
			$this->dbserver = $dbserver;
			$this->dbuser = $dbuser;
			$this->dbpswd = $dbpswd;
			$this->dbname = $dbname;
			$this->dbconn = mysql_connect($this->dbserver,$this->dbuser,$this->dbpswd);
			if (!$this->dbconn) throw new MySqlException("Selhal pokus o spojeni s MySQL serverem!");
			$this->dbsel = mysql_select_db($this->dbname);
			if (!$this->dbsel) throw new MySqlException("Selhal vyber databaze!");
			// nastaveni cestiny pomoci dotazu
			$this->makeQuery("SET NAMES 'utf8' COLLATE 'utf8_czech_ci'");
		} catch (MySqlException $e) {
			die("Chyba: ".$e->getMessage());
		}
	}
	
	public function closeConnection() {
		try {
			if (!mysql_close($this->dbconn)) throw new MySqlException("Selhal pokus o ukonceni spojeni s MySQL serverem!");
		} catch (MySqlException $e) {
			die("Chyba: ".$e->getMessage());
		}
	}
	
	public function makeQuery($query) {
		try {
			$this->queryresult = mysql_query($query);
			if (!$this->queryresult) throw new MySqlException("$query");
			return $this->queryresult;
		} catch (MySqlException $e) {
			die ("Chyba v dotazu: ".$e->getMessage());			
		}
	}
	
	public function getResult($query, $line = 0, $col = 0) {
		$sr = $this->makeQuery($query);
		if ($sr) {
			if (mysql_num_rows($sr) > 0) {
				if (!$col) {
					$res = mysql_result($sr, $line);
				} else {
					$res = mysql_result($sr, $line, $col);
				}
				return $res;
			} else {
				mysql_free_result($sr);
				return (null);
			}
		} else {
			return (null);
		}
	}
}
?>
