<?php
namespace Tests; // es el alias que se usó en el archivo json

use App\Pages\Calculadora; // importa la clase a probar
use PHPUnit\Framework\Attributes\Test; // para usar #[Test]
use PHPUnit\Framework\TestCase;

class CalculadoraTest extends TestCase
{
    #[Test] // Marca el método siguiente como una prueba que PHPUnit debe ejecutar.

    public function suma_dos_numeros(): void
    {
        // Arrange /preparación
        $calc = new Calculadora();

        // Act / ejecutar la acción
        $resultado = $calc->sumar(2, 3);

        // Assert // verificación
        $this->assertSame(5, $resultado);
    }
}