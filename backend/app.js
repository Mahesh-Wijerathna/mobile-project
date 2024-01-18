const express = require("express");
const bodyParser = require("body-parser")

// const UserRoute = require("./routes/user.routes");
// const ToDoRoute = require('./routes/todo.router');
// const ItemRoute = require('./routes/item.router');
const ShopRoute = require('./routes/shop.route');
// const CustomerRoute = require('./routes/customer.router');
const app = express();

app.use(bodyParser.json())

//  app.use("/",UserRoute);
//  app.use("/",ToDoRoute);
//  app.use("/",ItemRoute);
  app.use("/",ShopRoute);
//  app.use("/",CustomerRoute);

module.exports = app;