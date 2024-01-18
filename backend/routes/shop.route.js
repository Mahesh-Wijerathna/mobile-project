const router = require("express").Router();
const ShopController = require('../controller/shop.controller')


router.post("/createShop",ShopController.createShop);


module.exports = router;

