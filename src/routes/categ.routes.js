


import { Router } from "express";

//Import de Func
import { All_Categories  , One_Category, Create_Category, Update_Category, Delete_Category} 
from "../controllers/categ.controllers.js";

const router = Router();

//Routes
router.get('/Category', All_Categories);

router.get('/Category/:id', One_Category);

router.post('/Category', Create_Category);

router.put('/Category/:id', Update_Category);

router.patch('/Category/:id', Delete_Category);



export default router;