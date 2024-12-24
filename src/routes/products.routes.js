import { Router } from "express";

//Import de Func
import { All_Products  , One_Product, Create_Product, Update_Product, Delete_Product} 
from "../controllers/products.controllers.js";

const router = Router();

//Routes
router.get('/Productos', All_Products);

router.get('/Productos/:id', One_Product);

router.post('/Productos', Create_Product);

router.put('/Productos/:id', Update_Product);

router.patch('/Productos/:id', Delete_Product);



export default router;