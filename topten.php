<?php

header("Content-type. text/xml");
header("Pragma: public");
header("Cache-control: private");
header("Expires: -1");

date_default_timezone_set('UTC');

$moment = date("y-m-d h:m:s"); 


$mysqli = new mysqli('localhost', 'root', 'root', 'test');

//Insert Data

if (mysqli_connect_error()) {
    die('Connect Error (' . mysqli_connect_errno() . ') '
            . mysqli_connect_error());
}

$queryString = "SELECT pName, pSurname, pScore FROM soundgame ORDER BY pScore DESC LIMIT 10";

$result = $mysqli->query($queryString);

$xmlFile = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
$xmlFile .= "<topTen>";


while ($row = $result->fetch_row()) {
		
		$xmlFile .= "<player>";
		$xmlFile .= "<name>";
		$xmlFile .= $row[0];
		$xmlFile .= "</name>";
		$xmlFile .= "<surname>";
		$xmlFile .= $row[1];
		$xmlFile .= "</surname>";
		$xmlFile .= "<score>";
		$xmlFile .= $row[2];
		$xmlFile .= "</score>";
		$xmlFile .= "</player>";
    }
	
$xmlFile .= "</topTen>";

/* free result set */
$result->free();

$mysqli->close();

echo $xmlFile;

?> 