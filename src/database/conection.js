import sql from "mssql"

const dbSettings = {
    user: "Ssa",
    password : "newSecurepassword",
    server : "localHost",
    database : "GDA005-OT-Pedro_Chonay",
    options : {
        encrypt : true,
        trustServerCertificate : true ,
    }
}

export const getConection = async () => {
    try {
        const pool =  await sql.connect(dbSettings);
        return pool;
    }   catch (error) {
        console.error(error)
    }
}

export {sql} ;