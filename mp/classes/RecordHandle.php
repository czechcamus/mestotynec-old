<?php
final class RecordHandle {
	
	private $form;
	
	public function __construct($form) {
		$this->form = $form;
	}
	
	public function addRecord($records) {
		$query = "INSERT INTO mp$this->form";
		switch ($this->form) {
			case 'fce':
				$query .= " SET nazev = '".$records['nazev']."'";
				break;
			case 'person':
				$narozen_d = dateConvertForDb($records['narozen_d']);
				$query .= " SET titulpred = '".$records['titulpred']."', jmeno = '".$records['jmeno']."', prijmeni = '".$records['prijmeni']."', titulza = '".$records['titulza']."', narozen_d = '".$narozen_d."', idmpfce = ".$records['idmpfce'];
				break;
			case 'user':
				$query .= " SET username = '".$records['username']."', userpswd = '".$records['userpswd']."', titulpred = '".$records['titulpred']."', jmeno = '".$records['jmeno']."', prijmeni = '".$records['prijmeni']."', titulza = '".$records['titulza']."', rc = '".$records['rc']."', ulicecp = '".$records['ulicecp']."', mesto = '".$records['mesto']."', psc = '".$records['psc']."', platnost = ".(empty($records['platnost']) ? 0 : $records['platnost']);
				break;
			case 'doc':
				$obdobiod_d = dateConvertForDb($records['obdobiod_d']);
				$obdobido_d = dateConvertForDb($records['obdobido_d']);
				$query .= " SET idmpperson = ".$records['idmpperson'].", obdobiod_d = '".$obdobiod_d."', obdobido_d = '".$obdobido_d."', filetitle = '".$records['filetitle']."', filename = '".$records['filename']."'";
				break;
		}
		return $query;
	}

	public function editRecord($records) {
		$query = "UPDATE mp$this->form";
		switch ($this->form) {
			case 'fce':
				$query .= " SET nazev = '".$records['nazev']."'";
				break;
			case 'person':
				$narozen_d = dateConvertForDb($records['narozen_d']);
				$query .= " SET titulpred = '".$records['titulpred']."', jmeno = '".$records['jmeno']."', prijmeni = '".$records['prijmeni']."', titulza = '".$records['titulza']."', narozen_d = '".$narozen_d."', idmpfce = ".$records['idmpfce'];
				break;
			case 'user':
				$query .= " SET username = '".$records['username']."', userpswd = '".$records['userpswd']."', titulpred = '".$records['titulpred']."', jmeno = '".$records['jmeno']."', prijmeni = '".$records['prijmeni']."', titulza = '".$records['titulza']."', rc = '".$records['rc']."', ulicecp = '".$records['ulicecp']."', mesto = '".$records['mesto']."', psc = '".$records['psc']."', platnost = ".(empty($records['platnost']) ? 0 : $records['platnost']).", caszapisu = caszapisu";
				break;
			case 'doc':
				$obdobiod_d = dateConvertForDb($records['obdobiod_d']);
				$obdobido_d = dateConvertForDb($records['obdobido_d']);
				$query .= " SET idmpperson = ".$records['idmpperson'].", obdobiod_d = '".$obdobiod_d."', obdobido_d = '".$obdobido_d."', filetitle = '".$records['filetitle']."', filename = '".$records['filename']."'";
				break;
		}
		$query .= " WHERE id = ".$records['id'];
		return $query;
	}
	
	public function deleteRecord($records) {
		$query = "DELETE FROM mp$this->form WHERE id = ".$records['id'];
		return $query;
	}
}

function dateConvertForDb($d)
// prevede datum do z formatu DD.MM.RRRR do formatu RRRR-MM-DD
{
	$p = "(0?[1-9]|[12][0-9]|3[01])\. ?(0?[1-9]|1[0-2])\. ?((18|19|20)[0-9]{2})";
	$r = "\\3-\\2-\\1";
	return ereg_replace($p, $r, $d);
}
?>