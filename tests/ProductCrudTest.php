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

    // crea un PDO Statement falso (el objeto que devuelve prepare()).
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


    // ── PRUEBAS DE RECHAZO EN LA INSERCIÓN ──────────────────────────────────

    #[Test]
    public function rechaza_insercion_cuando_falta_un_campo_del_formulario(): void
    {
        // ARRANGE

        // No necesitamos PDO real: el modelo debe fallar antes de llegar a la BD.
        // Creamos el mock igual que en el caso exitoso, pero NO esperamos
        // que se llame a prepare() ni a execute().
        $conn = $this->createMock(PDO::class);

        $conn
            ->expects($this->never())   // prepare jamás debe llamarse
            ->method('prepare');

        $model = new ProductModel($conn);

        // Datos incompletos: se omite 'cboCategoria' a propósito.
        $datosFaltantes = [
            'txtCodigoBarra' => 'TEST002',
            'txtNombre'      => 'Lapicera',
            'txtPrecio'      => '12.5',
            'rngCantidad'    => '10',
            'cboMarca'       => 'M001'
            // 'cboCategoria' => intencionalmente ausente
        ];

        // ACT

        $resultado = $model->insertar('producto', $datosFaltantes);

        // ASSERT

        // El modelo debe retornar la clave 'error' (no 'estado') cuando falta un campo.
        $this->assertArrayHasKey('error', $resultado);

        // El mensaje de error debe mencionar el campo faltante.
        $this->assertStringContainsString('cboCategoria', $resultado['error']);
    }

    #[Test]
    public function rechaza_insercion_cuando_codigo_barra_esta_vacio(): void
    {
        // ARRANGE

        // El modelo valida el código de barra antes de preparar el SQL,
        // por eso prepare() tampoco debe llamarse.
        $conn = $this->createMock(PDO::class);

        $conn
            ->expects($this->never())
            ->method('prepare');

        $model = new ProductModel($conn);

        // Todos los campos presentes, pero txtCodigoBarra es solo espacios.
        $datosConCodigoVacio = [
            'txtCodigoBarra' => '   ',   // vacío tras trim()
            'txtNombre'      => 'Lapicera',
            'txtPrecio'      => '12.5',
            'rngCantidad'    => '10',
            'cboMarca'       => 'M001',
            'cboCategoria'   => 'C001'
        ];

        // ACT

        $resultado = $model->insertar('producto', $datosConCodigoVacio);

        // ASSERT

        // Debe retornar 'error' porque el ID está vacío.
        $this->assertArrayHasKey('error', $resultado);

        // El mensaje debe indicar que el ID no puede estar vacío.
        $this->assertStringContainsString('vacío', $resultado['error']);
    }

    #[Test]
    public function rechaza_insercion_cuando_la_bd_lanza_una_excepcion(): void
    {
        // ARRANGE

        $statement = $this->createMock(PDOStatement::class);

        // execute se llama una vez, pero simula un fallo de BD lanzando PDOException.
        $statement
            ->expects($this->once())
            ->method('execute')
            ->willThrowException(new PDOException('Duplicate entry para clave primaria'));

        $conn = $this->createMock(PDO::class);

        // prepare se llama una vez y devuelve el statement falso.
        $conn
            ->expects($this->once())
            ->method('prepare')
            ->willReturn($statement);

        $model = new ProductModel($conn);

        // Datos válidos: el rechazo ocurre en la BD, no en la validación.
        $datosValidos = [
            'txtCodigoBarra' => 'TEST001',   // simula un código ya existente en BD
            'txtNombre'      => 'Lapicera',
            'txtPrecio'      => '12.5',
            'rngCantidad'    => '10',
            'cboMarca'       => 'M001',
            'cboCategoria'   => 'C001'
        ];

        // ACT

        $resultado = $model->insertar('producto', $datosValidos);

        // ASSERT

        // El modelo captura PDOException y retorna 'errorBD' (no 'estado' ni 'error').
        $this->assertArrayHasKey('errorBD', $resultado);

        // El mensaje debe incluir el texto que viene de la excepción.
        $this->assertStringContainsString('Duplicate entry', $resultado['errorBD']);
    }
}


// DESARROLLO CON IA ==================

?>