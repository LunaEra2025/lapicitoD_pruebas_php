<?php

// es como una “carpeta virtual” para nombrar clases
// Tu clase Calculadora pasa a llamarse App\Calculadora

namespace App\pages;

class Calculadora {
    public function sumar(int $a, int $b): int {
        return $a + $b;
    }
}