import { Router } from "express";

//Import de Func
import { All_Status  , One_Status, Create_Status, Update_Status} from "../controllers/status.controllers.js";

const router = Router();

//Routes    
router.get('/Estados', All_Status);

router.get('/Estados/:id', One_Status);

router.post('/Estados', Create_Status);

router.put('/Estados/:id', Update_Status);

export default router;