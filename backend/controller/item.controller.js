//const ToDoService = require('../services/todo.service');
const ItemService = require('../services/item.service');
const ShopService = require('../services/shop.service');

// exports.createItem =  async (req,res,next)=>{
//     try {
//         // show reqest 
//         console.log(req.headers,"req.headers");
//         console.log(req.body,"req.body");
//         const { userId,title, desc } = req.body;
//         let todoData = await ToDoService.createToDo(userId,title, desc);
//         console.log(todoData,"todoData")    ;
//         res.json({status: true,success:todoData});
//     } catch (error) {
//         console.log(error, 'err---->');
//         next(error);
//     }
// }

exports.createItem =  async (req,res,next)=>{
    console.log("this is createItem request receved" );
    try {
        // show reqest 
        
        //console.log(req.headers,"req.headers");
        console.log("\n req.body >" + req.body);
        const { name,description,itemType,price,location,shopName,shopId } = req.body;
        console.log("\n id >" + shopId);
        //const shop = await ShopService.getShopById(shopId);
        //shopName = " shop 1";  //shop.name;
        console.log("\n shopName >" + shopName);
        let itemData = await ItemService.createItem(
            name,
            description,
            itemType,
            price,
            location,
            shopName,
            shopId);
// show dummy data in postman





        console.log("itemData \n >",itemData);
        res.json({status: true,success:itemData});
    } catch (error) {
        console.log(error, 'err---->');
        next(error);
    }
}

exports.getItemListInShop =  async (req,res,next)=>{
    try {
        const { id :shopId } = req.query;
        console.log("\n shopId > \n" + shopId);
        let itemData = await ItemService.getItemListInShop(shopId);
        res.json({status: true,success:itemData});
    } catch (error) {
        console.log(error, 'err---->');
        next(error);
    }
}


// name price description
exports.getSearchedItemList =  async (req,res,next)=>{
    try {
        const { name } = req.query;
        let itemData = await ItemService.getSearchedItemList(name);
        res.json({status: true,success:itemData});
    } catch (error) {
        console.log(error, 'err---->');
        next(error);
    }
}
 exports.getItemsWithName =  async (req,res,next)=>{
    try {
        const { name } = req.query;
        console.log("\n name > \n" + name);
        let itemData = await ItemService.getItemsWithName(name);
        res.json({status: true,success:itemData});
    } catch (error) {
        console.log(error, 'err---->');
        next(error);
    }
}



