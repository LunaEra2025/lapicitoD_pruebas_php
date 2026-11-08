<?php


require_once __DIR__ . '/../src/models/ProductModel.php';


// librerias que Importan el atributo #[Test] y la clase base de PHPUnit.
use PHPUnit\Framework\Attributes\Test;
use PHPUnit\Framework\TestCase;

class ProductCrudTest extends TestCase{

   #[Test] // Marca el método como prueba
public function inserta_un_producto(): void
{

// ARRANGE 

    // crea un PDOStatement falso (el objeto que devuelve prepare()).
    //statement, sentencia sql preparada, se puede llamar como uno quiera
    $statement = $this->createMock(PDOStatement::class);


    // Le dice al falso: “execute debe llamarse exactamente una vez, y cuando se llame devuelve true”. Si no se llama, la prueba falla.
    $statement
        ->expects($this->once())
        ->method('execute')
        ->willReturn(true);

        // PDO CLASE NATIVA DE PHP PARA ACCEDER A LA BD
    // Crea un OBJETO PDO falso: reemplaza la conexión real a la BD.
    $conn = $this->createMock(PDO::class);

    // prepare debe llamarse una vez, y devuelve el statement falso”. Así tu modelo cree que habla con una BD real.
    $conn
        ->expects($this->once())
        ->method('prepare')
        ->willReturn($statement);

        // SE CREA UN OBJETO DE LA CLASE A PROBAR Y SE LE PASA LA FALSA CONEXION
    $model = new ProductModel($conn);


    // Los datos del formulario que simulan lo que enviaría el usuario.
    // DEBE COINCIDIR LOS CAMPOS DE LA IZQUIERDA CON EL MAPEO de la derecha de PRODUCTMODEL LINEA: 15
    $datos = [
    'txtCodigoBarra' => 'TEST001',
    'txtNombre'      => 'Lapicera',
    'txtPrecio'      => '12.5',
    'rngCantidad'    => '10',
    'cboMarca'       => 'M001',
    'cboCategoria'   => 'C001'
];

// ACT ejecusion

// ejecuta el método que quieres probar.
    $resultado = $model->insertar('producto', $datos);

// ASSERT verificación

    //verifica que estado sea true. Si no, la prueba falla. es lo uque devuelve la linea 47
    $this->assertTrue($resultado['estado']);
}

}

?>