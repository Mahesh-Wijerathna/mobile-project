
const ShopModel = require("../models/shop.model");


// class for shop
class ShopService{
    

    static async createShop(name,email,location,coordinates,ownerName , ornaName , categories,description, photos , openingHours ,contactNumber , isVerified){
      console.log("createShop in backend \n\n");
      const createShop = new ShopModel({
        name,
        email,
        location,
        coordinates,
        ownerName,
        ornaName,
        categories,
        description,
        photos,
        openingHours,
        contactNumber,
        isVerified
      });
      // show create shop in console
      console.log("variable to save",createShop + "\n\n");
      return await createShop.save();

      }

      // get shop by id

      static async getShop(){
        console.log("getShop in backend \n\n");
        return await ShopModel.find();
      }

      // get shop by id
      static async getShopById(id){
        return await ShopModel.findById(id);
      }




    }

  
    
module.exports = ShopService;