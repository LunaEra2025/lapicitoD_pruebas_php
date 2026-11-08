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

        // Carga las variables de entorno desde el archivo .env ubicado en la raíz del proyecto.
        // __DIR__ apunta a src/database/, por eso se sube dos niveles con ../../
        $envPath = __DIR__ . '/../../.env';

        if (!file_exists($envPath)) {
            throw new Exception('Archivo .env no encontrado. Copia .env.example a .env y configura tus credenciales.');
        }

        // parse_ini_file() lee el archivo .env y devuelve un arreglo asociativo con las variables
        $env = parse_ini_file($envPath);

        $host    = $env['DB_HOST']    ?? 'localhost';
        $dbname  = $env['DB_NAME']    ?? '';
        $user    = $env['DB_USER']    ?? '';
        $pass    = $env['DB_PASS']    ?? '';
        $charset = $env['DB_CHARSET'] ?? 'utf8mb4';

        // crea una cadena de conexión de MYSQL que le dice a PDO cómo y dónde conectarse a la base de datos.
        $dsn = "mysql:host=$host;dbname=$dbname;charset=$charset"; // DSN data source name

        $options = [
            PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,       // lanza excepciones en vez de errores silenciosos
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,             // arreglo asociativo (['nombre' => 'Erahin'])
            PDO::ATTR_EMULATE_PREPARES   => false,                        // sentencias preparadas reales (más seguro contra SQL injection)
        ];

        try {
            return new PDO($dsn, $user, $pass, $options); // devuelve un objeto PDO de conexión a la base de datos
        } catch (PDOException $e) {
            // lanza la excepción para que sea manejada en validConnection.php o en el archivo que invoque setConnection()
            throw new Exception('Error de conexión a la Base de datos: ' . $e->getMessage());

            // para probar se crea validConection.php y se ingresa a la ruta: http://localhost/lapicitoD2026/src/database/validConnection.php
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


