<?php
if(filter_input(INPUT_POST, 'adat', FILTER_VALIDATE_BOOLEAN, FILTER_NULL_ON_FAILURE)){
    //-- adatok ellenőrzése
    $name = filter_input(INPUT_POST, 'name', FILTER_SANITIZE_STRING);
    $pass = filter_input(INPUT_POST, 'pass', FILTER_SANITIZE_STRING);

    if($db->user_check($name, $pass)){
        echo 'Sikeres ';
        header("location: index.php");
    } else {
        echo 'sikertelen!!!';
    }
    
}

?>
<form method="POST">
    <label>felhasználónév</label>
    <input type="text" name="name" />
    <label>jelszó</label>
    <input type="password" name="pass" />
    <button type="submit" name="adat" value="true" >Belépés</button>
</form>
