<?php
header('Content-Type: application/json'); // Esta línea indica al navegador que el contenido es JSON

require_once 'connection.php'; // Incluye el archivo de conexión a la base de datos

// prueba de conexion a la base de datos
try {    
    $conn=ConexionDB::setConnection();
    echo json_encode(["estadoDB" => "Conexión exitosa!!"]); // array asociativo, es el formato de php para json clave:valor

} catch (Exception $e) {
    echo json_encode(["errorDB" => $e->getMessage()]); // se genera un array asociativo para visualizar: {clave:valor}
}
