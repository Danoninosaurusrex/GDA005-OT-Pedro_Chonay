import {getConection, sql }    from "../database/conection.js";

export const All_Costumer = async (req, res) => {
    try {
        const pool = await getConection()
        const result = await pool.request()
            .execute("dbo.All_Costumer");
        console.log(result);
        res.json(result.recordset);
    } catch (error) { 
    console.error(error);
    res.status(500).send('Error al obtener los clientes');
 } };