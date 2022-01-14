<?php 
include_once './config/config.access';
include_once './config/config.mask';

function show_flags ($flags, $mask ) {
  if ($flags & $mask) {
    //     "jogosult!<br>\n";
    return true;
  } else {
      //'jelentkezz be!';
    header('Location: '.'index.php?menu=login');
  }

}

?>

<!DOCTYPE html>
<!--

-->
<html>
    <head>
        <meta charset="UTF-8">
        <title></title>
    </head>
    <body>
        <?php
        // put your code here

$flags=ACCESS_GUEST;
show_flags($flags, MASK_BUYING);
        ?>
    </body>
</html>
