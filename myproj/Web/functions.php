<?php

//use Database\DBController;

use Database\DBController;
use Database\product;

require('./Database/DBController.php');
require('./Database/Product.php');

$db = new DBController();

$product = new Product($db);
$product_shuffle = $product->getData();

$prodcat_shuffle = $product->getData('prodcat');

//print_r($product->getData());
