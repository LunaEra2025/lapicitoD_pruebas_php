<?php

namespace Tests; // es el alias que se usó en el archivo json

require_once __DIR__ . '/../src/database/connection.php';


use PDO;
use PHPUnit\Framework\Attributes\Test; // para usar #[Test]
use PHPUnit\Framework\TestCase;


// En PHPUnit el nombre de la clase debe ser igual al del archivo: ConnectionTest.php → class ConnectionTest.
class ConnectionTest extends TestCase
{
    #[Test] // Marca el método siguiente como una prueba que PHPUnit debe ejecutar.
    

    // se prueba la conexión real de la base de datos, si cambias los datos de env genera error en la prueba
    public function conectar_a_BD():void
    {
        // arrange preparación y ejecusión
        // no se crea un objeto por que le método de la classe connection es estátio


        // La \ inicial significa “búscala en el espacio global”, que es donde está tu clase (porque no le pusiste namespace al archivo connection.php).
        $conexion = \ConexionDB::setConnection();


        // resultado
        $this->assertInstanceOf(PDO::class, $conexion);
    }
    


}

?>