import { getConection, sql } from "../database/conection.js";

export const All_Status = async (req, res) => {
    try {
        const pool = await getConection()
        const result = await pool.request()
            .execute("dbo.All_Status");
        console.log(result);
        res.json(result.recordset);
    } catch (error) {
        console.error(error);
        res.status(500).send('Error al obtener los estados');
    }
};

export const One_Status = async (req, res) => { 
    try {
        const { Id } = req.body;
        const pool = await getConection()
        const result = await pool.request()
            .input('IdEstado', sql.Int, req.body.Id)
            .execute("dbo.StatusbyId");
        console.log(result);
        res.json(result.recordset);
    } catch (error) {
        console.error(error);
        res.status(500).send('Error al obtener el Estado');
    }
}


export const Create_Status = async (req, res) => {
    try {
        const { Id , Estado } = req.body;
        const pool = await getConection()
        const result = await 
        pool.request()
            .input('Id_Estado', sql.Int, req.body.Id)
            .input('Estado', sql.VarChar, req.body.Estado)
            .execute("dbo.newEst");
        console.log(result);
        res.json({
            success: true,
            message: "Estado creado con exito",
            data: result.recordset
        });
    } catch (error) {
        console.error(error);
        res.status(500).send('Error al crear el Estado');
    }
}

export const Update_Status = async (req, res) => {
    try {
        const { id, Estado } = req.body;
        const pool = await getConection()
        const result = await pool.request()
            .input('Id_Estado', sql.Int, req.body.id)
            .input('Estado', sql.VarChar, req.body.Estado)
            .execute("dbo.EditEst");
        console.log(result);
        res.json({
            success: true,
            message: "Estado actualizado con exito",
            data: result.recordset
        });
    } catch (error) {
        console.error(error);
        res.status(500).send('Error al actualizar el Estado');
    };
};