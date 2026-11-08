<?php

/**
 * Prueba de integración que verifica que la aplicación
 * puede establecer una conexión válida con la base de datos
 * mediante PDO.
 */


require_once __DIR__ . '/../src/database/connection.php';



use PHPUnit\Framework\Attributes\Test; // para usar #[Test]
use PHPUnit\Framework\TestCase;


// En PHPUnit el nombre de la clase debe ser igual al del archivo: ConnectionTest.php → class ConnectionTest.
class ConnectionIntegrationTest  extends TestCase
{
    #[Test] // Marca el método siguiente como una prueba que PHPUnit debe ejecutar.
    

    // se prueba la conexión real de la base de datos, si cambias los datos de env genera error en la prueba
    public function conectar_a_BD():void
    {
        // arrange no hay
        

        //preparación y ejecusión
        // no se crea un objeto por que le método de la classe connection es estático

        $conexion = ConexionDB::setConnection();


        // assert - resultado
        $this->assertInstanceOf(PDO::class, $conexion);
    }
    


}

?>