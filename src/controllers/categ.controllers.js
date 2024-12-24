import { getConection, sql } from "../database/conection.js";

export const All_Categories = async (req, res) => {
    try {
        const pool = await getConection()
        const result = await pool.request()
            .execute("dbo.All_Categoriess");
        console.log(result);
        res.json(result.recordset);
    } catch (error) {
        console.error(error);
        res.status(500).send('Error al obtener los Categorias');
    }
};

export const One_Category = async (req, res) => {
    try {
        const { nombreCategoria } = req.body;
        const pool = await getConection()
        const result = await pool.request()
            .input('NombreCategoria', sql.VarChar, req.body.nombreCategoria)
            .execute("dbo.CategoryByName");
        console.log(result);
        res.json(result.recordset);
    } catch (error) {
        console.error(error);
        res.status(500).send('Error al obtener Categoria');
    }
};

export const Create_Category = async (req, res) => {
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
            .execute("dbo.New_Categ");

        console.log(result);

        res.json({
            success: true,
            message: "Categoria creado con exito",
            data: result.recordset
        });
    } catch (error) {
        console.error(error);
        res.status(500).send('Error al crear la category');
    }
};

export const Update_Category = async (req, res) => {
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
            .execute("dbo.UpdateCategory");
        console.log(result);
        res.send('Actualizando una category');
    }
    catch (error) {
        console.error(error);
        res.status(500).send('Error al actualizar el category');
    }
};

export const Delete_Category = async (req, res) => {
    try {
        const { Id } = req.body;
        const pool = await getConection()
        const result = await pool.request()
            .input('IdCategory', sql.Int, req.body.Id)
            .execute("dbo.DeleteCategory");
        console.log(result);

        res.json({
            success: true,
            message: "Categoria eliminado con exito",
            data: result.recordset
        });
    } catch (error) {
        console.error(error);
        res.status(500).send('Error al eliminar el producto');
    };
};