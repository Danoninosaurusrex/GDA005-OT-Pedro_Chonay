import { getConection, sql } from "../database/conection.js";

export const All_Categories = async (req, res) => {
    try {
        const pool = await getConection()
        const result = await pool.request()
            .execute("dbo.AllCateg");
        console.log(result);
        res.json(result.recordset);
    } catch (error) {
        console.error(error);
        res.status(500).send('Error al obtener los Categorias');
    }
};

export const One_Category = async (req, res) => {
    try {
        const { IdCategoria } = req.body;
        const pool = await getConection()
        const result = await pool.request()
            .input('Id', sql.Int, req.body.IdCategoria)
            .execute("dbo.OneCateg");
        console.log(result);
        res.json(result.recordset);
    } catch (error) {
        console.error(error);
        res.status(500).send('Error al obtener Categoria');
    }
};

export const Create_Category = async (req, res) => {
    try {
        const { Nombre } = req.body;
        const pool = await getConection()
        const result = await pool.request()
            .input('NombreCateg' , sql.VarChar, req.body.nombre)
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
        const { IdCateg, Nombre} = req.body;
        const pool = await getConection()
        const result = await pool.request()
            .input('IdCateg', sql.Int, req.body.IdCateg)
            .input('Nombre', sql.VarChar, req.body.Nombre)
            .execute("dbo.EditCateg");
        console.log(result);
        res.send('Actualizando una categoria');
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
            .input('IdCateg', sql.Int, req.body.Id)
            .execute("dbo.DeleteCateg");
        console.log(result);

        res.json({
            success: true,
            message: "Categoria eliminado con exito",
            data: result.recordset
        });
    } catch (error) {
        console.error(error);
        res.status(500).send('Error al eliminar la categoria');
    };
};