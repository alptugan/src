<?php


$pName = $_POST["pName"];
$pSurname = $_POST["pSurname"];
$pEmail = $_POST["pEmail"];
$pTelephone = $_POST["pTelephone"];
$pScore = $_POST["pScore"];


date_default_timezone_set('UTC');

$moment = date("y-m-d h:m:s"); 


$mysqli = new mysqli('localhost', 'root', 'root', 'test');

//Insert Data

if (mysqli_connect_error()) {
    die('Connect Error (' . mysqli_connect_errno() . ') '
            . mysqli_connect_error());
}

$queryString = "INSERT INTO soundgame (keyID,pName, pSurname, pEmail, pTelephone, pScore, pDate)
VALUES ('','$pName', '$pSurname','$pEmail','$pTelephone','$pScore','$moment')";
//echo $queryString;

mysqli_query($mysqli,$queryString);



$mysqli->close();



?>