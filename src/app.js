import express from 'express'
import ProductRoutes from './routes/products.routes.js'
import StatusRoutes from './routes/status.routes.js'
import CustomerRoutes from './routes/customer.routes.js'

const app = express()

app.use(express.json());

app.use('/api', ProductRoutes);
app.use('/api', StatusRoutes);
app.use('api', CustomerRoutes); 


export default app