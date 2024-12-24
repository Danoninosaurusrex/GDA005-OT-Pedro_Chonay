import { getConection, sql } from "../database/conection.js";

export const All_Products = async (req, res) => {
    try {
        const pool = await getConection()
        const result = await pool.request()
            .execute("dbo.All_Products");
        console.log(result);
        res.json(result.recordset);
    } catch (error) {
        console.error(error);
        res.status(500).send('Error al obtener los productos');
    }
};

export const One_Product = async (req, res) => {
    try {
        const { NombreProducto } = req.body;
        const pool = await getConection()
        const result = await pool.request()
            .input('NombreProducto', sql.VarChar, req.body.NombreProducto)
            .execute("dbo.ProductByName");
        console.log(result);
        res.json(result.recordset);
    } catch (error) {
        console.error(error);
        res.status(500).send('Error al obtener el producto');
    }
};

export const Create_Product = async (req, res) => {
    try {
        const { nombre, categoria, marca, codigo, stock, precio, foto } = req.body;
        const pool = await getConection()
        const result = await pool.request()
            .input('Categ_Prod', sql.Int, req.body.categoria)
            .input('name', sql.VarChar, req.body.nombre)
            .input('Brand', sql.VarChar, req.body.marca)
            .input('Codigo', sql.Int, req.body.codigo)
            .input('Stock', sql.Float, req.body.stock)
            .input('Img', sql.Binary, req.body.foto)
            .input('Precio', sql.Float, req.body.precio)
            .execute("dbo.New_Produ");

        console.log(result);

        res.json({
            success: true,
            message: "Producto creado con exito",
            data: result.recordset
        });
    } catch (error) {
        console.error(error);
        res.status(500).send('Error al crear el producto');
    }
};

export const Update_Product = async (req, res) => {
    try {
        const { id, categoria, nombre, marca, codigo, stock, imagen, precio } = req.body;
        const pool = await getConection()
        const result = await pool.request()
            .input('IdProd', sql.Int, req.body.id)
            .input('Categ_Prod', sql.Int, req.body.categoria)
            .input('Name', sql.VarChar, req.body.nombre)
            .input('Brand', sql.VarChar, req.body.marca)
            .input('Codigo', sql.VarChar, req.body.codigo)
            .input('Stock', sql.Float, req.body.stock)
            .input('Img', sql.Binary, req.body.imagen)
            .input('Precio', sql.Float, req.body.precio)
            .execute("dbo.UpdateProduct");
        console.log(result);
        res.send('Actualizando un producto');
    }
    catch (error) {
        console.error(error);
        res.status(500).send('Error al actualizar el producto');
    }
};

export const Delete_Product = async (req, res) => {
    try {
        const { Id } = req.body;
        const pool = await getConection()
        const result = await pool.request()
            .input('IdProducto', sql.Int, req.body.Id)
            .execute("dbo.DeleteProduct");
        console.log(result);

        res.json({
            success: true,
            message: "Producto eliminado con exito",
            data: result.recordset
        });
    } catch (error) {
        console.error(error);
        res.status(500).send('Error al eliminar el producto');
    };
};