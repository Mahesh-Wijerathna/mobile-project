const express = require('express');
const router = express.Router();
const customerController = require('../controllers/customers.controller');

// POST register a new customer
router.post('/register', customerController.registerCustomer);

// POST login a customer
router.post('/login', customerController.loginCustomer);

// GET get a customer's profile
router.get('/profile', auth, customerController.getCustomerProfile);

// GET get a customer's favorite shops
router.get('/favorites/shops', auth, customerController.getFavoriteShops);

// GET get a customer's favorite items
router.get('/favorites/items', auth, customerController.getFavoriteItems);

// PUT add a shop to favorites
router.put('/favorites/shops/:shopId', auth, customerController.addFavoriteShop);

// PUT add an item to favorites
router.put('/favorites/items/:itemId', auth, customerController.addFavoriteItem);

// DELETE remove a shop from favorites
router.delete('/favorites/shops/:shopId', auth, customerController.removeFavoriteShop);

// DELETE remove an item from favorites
router.delete('/favorites/items/:itemId', auth, customerController.removeFavoriteItem);

module.exports = router;
