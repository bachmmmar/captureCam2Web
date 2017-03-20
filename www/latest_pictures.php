<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
       <title>Stylesheet in einem style-Element definieren</title>
    <style>
      img{
	width:100%;
	max-width:600px;
      }
    </style>
  </head>
  <body>



<h1>Letzte Aufnahmen</h1>

<?php 
if ($handle = opendir('img/')) {
    while (false !== ($entry = readdir($handle))) {
        if ($entry != "." && $entry != "..") {
	   echo "<br><img src='img/$entry' alt='$entry'>\n";
	}
    }

    closedir($handle);
}

?>


  </body>
</html>

