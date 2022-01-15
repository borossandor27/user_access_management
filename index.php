<?php 
header('Content-Type: text/html; charset=utf-8');
session_start();
include_once './config/config.access';
include_once './config/config.mask';
include_once './classes/Adatbazis.php';
$db = new Adatbazis();
//$db->reset();
$userlogin = $_SESSION['login']?? false;

$menus = array(
    array('item' => 'home', 'szoveg' => 'Home', 'mask' => MASK_ITEMS_VIEW, 'target' => 'page_home.php'),
    array('item' => 'list', 'szoveg' => 'Termékek', 'mask' => MASK_ITEMS_VIEW, 'target' => 'page_list.php'),
    array('item' => 'vasarlas', 'szoveg' => 'Vásárlás', 'mask' => MASK_BUYING, 'target' => 'page_buying.php'),
    array('item' => 'vasarlasok', 'szoveg' => 'Vásárlások', 'mask' => MASK_PURCHASES, 'target' => 'page_purchases.php'),
    array('item' => 'users', 'szoveg' => 'Felhasználók', 'mask' => MASK_USERS_MANAGEMENT, 'target' => 'page_users.php'),
    array('item' => 'upload', 'szoveg' => 'Termékek karbantartása', 'mask' => MASK_ITEMS_MANAGEMENT, 'target' => 'index.php')
);
if($userlogin){
    $menus[] = array('item' => 'logout', 'szoveg' => 'Kilépés', 'mask' => MASK_LOGIN, 'target' => 'page_exit.php');
} else {
    $menus[] = array('item' => 'regist', 'szoveg' => 'Regisztráció', 'mask' => MASK_REGISTRATION, 'target' => 'page_registration.php');
    $menus[] = array('item' => 'login', 'szoveg' => 'Belépés', 'mask' => MASK_LOGIN, 'target' => 'page_login.php');
}

$menuselected = filter_input(INPUT_GET, 'menu', FILTER_SANITIZE_STRING)?:'home';
$content = "index.php";

function show_flags ($flags, $mask ) {
  if ($flags & $mask) {
    //     "jogosult!<br>\n";
    return true;
  } else {
      //'jelentkezz be!';
//    header('Location: '.'index.php?menu=login');
  }
}
$user_flag = $userlogin?$_SESSION['user']['role_mask']:ACCESS_GUEST;
//echo '<pre>';
//var_dump($_SESSION);
//echo '</pre>';
?>

<!DOCTYPE html>
<!--

-->
<html>
    <head>
        <meta charset="UTF-8">
        <title>Hozzáférés kontrol</title>
        <link rel="icon" type="image/x-icon" href="favicon.ico">
        <link rel="stylesheet" href="access_management.css" />
    </head>
    <body>
        <div id="sheet">
            <nav>
                <ul>
                    <?php 

                    foreach ($menus as $value) {
                        if(show_flags($user_flag, $value['mask'])){
                            echo '<li><a'.($value['item']==$menuselected?' class="active"':'').' href="index.php?menu='.$value['item'].'">'.$value['szoveg'].'</a></li>';
                        }
                        if($value['item']==$menuselected){
                            $content=$value['target'];
                        }
                    }
                    echo $userlogin?'<li style="float:right"><a href="#">'.$_SESSION['user']['username'].'</a></li>':'';
                    ?>
                </ul>
            </nav>
            <div id="content">
                <?php
                    require_once $content;
                ?>
            </div>
        </div>
    </body>
</html>
