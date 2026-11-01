<?php

header('Content-Type: application/json'); // Esta línea indica al navegador que el contenido es JSON
require_once 'connection.php'; // Incluye el archivo de conexión a la base de datos

try {
    $conn=ConexionDB::setConnection();
    // “Toma los datos JSON crudos que llegaron al servidor, decodifícalos, y conviértelos en un arreglo PHP”.
    $entrada = json_decode(file_get_contents('php://input'), true);
    $tabla=$entrada['tabla'] ?? null; // si no existe la tabla o no se envió al invocarlo, le asigna null

    $tablasValidas = ['producto', 'categoria', 'cliente', 'usuario2', 'marca'];
    if (!in_array($tabla, $tablasValidas)) {
        echo json_encode(["errorDB" => "Tabla no permitida."]);
        exit;
    }

    $sql = "SELECT * FROM `$tabla`"; 
    $resultado = $conn->query($sql);
    $datos = $resultado->fetchAll(PDO::FETCH_ASSOC);
    

    echo json_encode($datos ?:[]); // si no hay datos, devuelve un arreglo vacío

} catch (PDOException $e) {
    echo json_encode(["errorDB" => "Error en la consulta: " . $e->getMessage()]);
}

//http://localhost/pryFrmCRUD_papeleria/src/database/readAllData.php?tabla=producto


/*

- ¿Tu archivo PHP se ejecuta directamente desde JS con fetch()? → Usa echo json_encode(...)
- ¿Tu archivo PHP solo es una parte modular usada por otro archivo? → Usa return json_encode(...) y que el otro archivo lo echo.
*/

?>




