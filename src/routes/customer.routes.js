import { Router} from "express";

//Import de Func
import { All_Customers, One_Customer, Create_Customer, Update_Customer} from "../controllers/customer.controllers.js";

const router = Router();

//Routes
router.get('/Clientes', All_Customers);

router.get('/Clientes/:id', One_Customer);

router.post('/Clientes', Create_Customer);

router.put('/Clientes/:id', Update_Customer);

router.patch('/Clientes/:id', Delete_Customer);

export default router;

