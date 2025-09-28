
<?php

/*
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT); // - Hace que mysqli arroje excepciones en lugar de errores fatales


try {
    $host = "localhost";
    $usuario = "root";
    $contrasena = "root";
    $base_de_datos = "papeleria3a";

    $conn = new mysqli($host, $usuario, $contrasena, $base_de_datos);
    $conn->set_charset("utf8mb4"); // Buen hábito para evitar problemas de codificación
    
} catch (mysqli_sql_exception $e) {
    throw new Exception("Error de conexión: " . $e->getMessage());
}
*/

// utilizando php database object (PDO) para la conexión a la base de datos

class ConexionDB {
    public static function setConnection() {
        $host = 'localhost';
        $dbname = 'papeleria3a';
        $user = 'root';
        $pass = 'root';
        $charset = 'utf8mb4';

        // crea una cadena de conexión de MYSQL que le dice a PDO cómo y dónde conectarse a la base de datos.
        $dsn = "mysql:host=$host;dbname=$dbname;charset=$charset"; // DSN data source name
        $options = [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, //- Le dice a PDO que, si ocurre un error con la BD, debe lanzar una excepción en lugar de quedarse callado o devolver un false.
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC, // usa forma de arreglo asociativo (['nombre' => 'Erahin']) y no mezclado con índices numéricos.
            PDO::ATTR_EMULATE_PREPARES => false, // - Desactiva la emulación de sentencias preparadas, lo que mejora la seguridad (contra inyecciones SQL) y el rendimiento.
            // y fuerza a usar las sentencias preparadas reales del servidor MySQL
        ];

        try {
            return new PDO($dsn, $user, $pass, $options); // devuelve un objeto PDO de concexión a la base de datos para que pueda ser usado
        } catch (PDOException $e) {
            // con esta opción 1 no necesitas try catch en validConection.php por que al generar una excepción aquí, se detiene la ejecución con exit;
            //echo json_encode(['errorDB' => 'Error de conexión a la Base de datos: ' . $e->getMessage()]); 
             //exit;

            // si ocupas la opcion 2 entonces debes lanzar una excepción y manejarla en validConection.php
            throw new Exception('Error de conexión a la Base de datos: ' . $e->getMessage());
           
            // para probar se crea validConection.php y se ingresa a la ruta: http://localhost/pryfrmcrud_papeleria/src/database/validConnection.php
        }
    }
}

// Código de prueba (comentar después de probar)

/*

// entra a : http://localhost/pryfrmcrud_papeleria/src/database/connection.php

try {
    $conn = ConexionDB::setConnection();
    echo "✅ Conexión exitosa!";
} catch (Exception $e) {
    echo "❌ Error: " . $e->getMessage();
}
    */

?>

