<?php
if(filter_input(INPUT_POST, 'adat', FILTER_VALIDATE_BOOLEAN, FILTER_NULL_ON_FAILURE)){
    //-- adatok ellenőrzése
    $name = filter_input(INPUT_POST, 'name', FILTER_SANITIZE_STRING);
    $pass = filter_input(INPUT_POST, 'pass', FILTER_SANITIZE_STRING);
    $cim = filter_input(INPUT_POST, 'cim', FILTER_SANITIZE_STRING);
    $db->vevo_regisztracio($name, $pass, $cim);
//    if()
}

?>
<h1>Regisztráció</h1>
<form method="POST">
    <label>nev</label>
    <input type="text" name="name"><br>
    <label>jelszo</label>
    <input type="password" name="pass"><br>
    <label>cim</label>
    <input type="text" name="cim"><br>
    <button type="submit" name="adat" value="true">Regisztráció</button>
</form>
    

