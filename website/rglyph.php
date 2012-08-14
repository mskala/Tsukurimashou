<?php

header('Content-type: image/png');
readfile('rg'.sprintf('%02d',mt_rand(0,99)).'.png');

?>