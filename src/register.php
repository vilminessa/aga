<?php
require_once 'DB.php'; // Подключаем ваш класс DB
use App\DB;
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $db = new DB();

    $lastName = $_GET["lastname"];
    $firstName = $_GET["firstname"];
    $middleName = $_GET["middlename"];
    $phoneNumber = $_GET["phone"];
    $mail = $_GET["mail"];
    $login = $_GET["login"];
    $password = $_GET["password"];

    


    $newUserId = $db->AddUser($lastName, $firstName, $middleName, $phoneNumber, $mail, $login, $password);

    if ($newUserId) {
        echo 1;
    } else {
        echo 1;
    }
} else {
    echo 2;
}
?>