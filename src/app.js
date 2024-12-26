import express from 'express'
import ProductRoutes from './routes/products.routes.js'
import StatusRoutes from './routes/status.routes.js'
import CategoryRoutes from './routes/categ.routes.js'

const app = express()

app.use(express.json());

app.use('/api', ProductRoutes);
app.use('/api', StatusRoutes);
app.use('api', CustomerRoutes); 
app.use('/api', CategoryRoutes); 


export default app