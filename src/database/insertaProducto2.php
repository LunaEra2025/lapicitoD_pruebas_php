<?php

header('Content-Type: application/json'); // Esta línea indica al navegador que el contenido es JSON
require_once 'connection.php'; // Incluye el archivo de conexión a la base de datos

try {

    $conn = ConexionDB::setConnection(); // Obtiene la conexión a la base de datos
    // “Toma los datos JSON crudos que llegaron al servidor, decodifícalos, y conviértelos en un arreglo PHP”.
    $entrada = json_decode(file_get_contents('php://input'), true);

    /*entrada mueestra algo como esto:
        datosFormulario: {txtCodigoBarra: "546", txtNombre: "sredtr", txtPrecio: "5.6", rngCantidad: "29", cboMarca: "M007",…}
        tabla:"producto"
    */

    $tabla=$entrada['tabla'];
    $datosFormulario=$entrada['datosFormulario'];

    // nombre de los campos de la tabla
    $campos = ['codigobarra', 'nombre', 'precio', 'existencia', 'idmarca', 'idcategoria'];
    // se crea un mapa para asociar cada campo de la tabla con los nombres de los campos del formulario
    $mapeo = [
    'codigobarra' => 'txtCodigoBarra',
    'nombre'      => 'txtNombre',
    'precio'      => 'txtPrecio',
    'existencia'  => 'rngCantidad',
    'idmarca'     => 'cboMarca',
    'idcategoria' => 'cboCategoria'
];


// verifica que cada campo del formulario exista y tenga valor
foreach ($mapeo as $claveBD => $claveForm) {
    if (!isset($datosFormulario[$claveForm])) {
        throw new Exception("Falta el campo del formulario: $claveForm");
    }
}

if(trim($datosFormulario['txtCodigoBarra'])===''){
    throw new Exception("El ID no puede estar vacío");
}
    
$campos = array_keys($mapeo); // crea un arreglo como los datos de las claves del mapa campos=['codigobarra', 'nombre', 'precio', 'existencia', 'idmarca', 'idcategoria']

// valores es un arreglo que contiene los valores del formulario, mapeados a los campos de la tabla
// $datosFormulario[$mapeo[$campo]] es como si fuera: $datosFormulario['txtCodigobarra']
$valores = array_map(fn($campo) => $datosFormulario[$mapeo[$campo]], $campos); 

// prepar la consulta SQL sin poner valores en cada campo
// count($campos) Cuenta cuántos campos tienes en tu tabla.
// array_fill(0, count($campos), '?') crea un arreglo iniciando en la posición 0, del tamñao indicado en count, y los llena con ?
// el resultado de fill es: ['?', '?', '?', '?', '?', '?']
// implode() convierte un arreglo en una cadena, separando por el delimitador especificado. el resultado es= '?, ?, ?, ?, ?, ?'
$placeholders = implode(', ', array_fill(0, count($campos), '?'));
// en este caso, implode('`, `', $campos) combierte cada valor del arreglo campos en = `codigobarra`, `nombre`, `precio`, `existencia`, `idmarca`, `idcategoria
$sql = "INSERT INTO `$tabla` (`" . implode('`, `', $campos) . "`) VALUES ($placeholders)";


    /*
        Crear los tipos para bind_param para cada campo de la tabla. Donde cada letra representa el tipo de dato de un valor:
    - 's' → string (texto)
    - 'i' → integer (entero)
    - 'd' → double (decimal o número flotante)
    - 'b' → blob (datos binarios)
*/

    $tipos='ssdisi';// se indica el tipo de dato de cada campo en el orden que aparecen en la consulta SQL
    $statement = $conn->prepare($sql);// prepara la sentencia SQL para recibir en cada ? los valores que hacen falta
    if (!$statement) { // si hay algun error lanza una excepción
        throw new Exception("Error al preparar la consulta: " . $conn->error);
    }

    // le dice a MySQL qué tipo de dato estás pasando para cada signo de ? (valor faltante).
    // el operador de propagación (...) permite pasar un arreglo como si fueran argumentos individuales a la función bind_param.
    /*
        ? ← '123456'  (s)
        ? ← 'Lapicera' (s)
        ? ← 12.5       (d)
        ? ← 20         (i)
        ? ← 1          (s)
        ? ← 3          (i)*/
    $statement->bind_param($tipos, ...$valores); // evita las inyecciones SQL y asegura que los valores sean del tipo correcto
    $statement->execute(); // lanza oficialmente la consulta a la base de datos

    echo json_encode(['estado' => true, 'mensaje' => 'Datos insertados correctamente']);


} catch (mysqli_sql_exception $e) {
    echo json_encode(["errorBD" => "Error en la inserción: ".$e->getMessage()]);
}
catch(Exception $e) {
    echo json_encode(["error" => "Error: " . $e->getMessage()]);
} 
finally {
    if (isset($conn) && $conn instanceof mysqli) { // isset verifica si la variable está definida
        $conn->close();
    }
}

?>

