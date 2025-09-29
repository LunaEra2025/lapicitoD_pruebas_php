<?php

header('Content-Type: application/json'); // Esta línea indica al navegador que el contenido es JSON
require_once 'connection.php'; // Incluye el archivo de conexión a la base de datos

try{

    $conn = ConexionDB::setConnection(); // Obtiene la conexión a la base de datos
    // “Toma los datos JSON crudos que llegaron al servidor desde dataManager.js, los decodifíca, y conviértes en un arreglo PHP”.
    $entrada = json_decode(file_get_contents('php://input'), true);

    /*variable entrada muestra algo como esto:
        datosFormulario: {txtCodigoBarra: "546", txtNombre: "sredtr", txtPrecio: "5.6", rngCantidad: "29", cboMarca: "M007",…}
        tabla:"producto"
    */

    $tabla=$entrada['tabla'] ?? null; // si el nombre de la tabla está vacia asigna null
    $datosFormulario=$entrada['datosFormulario'] ?? [];
    $operacion = $entrada['operacion']?? null;

    switch($operacion){
        case 'create':
            insertar($conn,$tabla, $datosFormulario);
            break;
        case 'read':
            leer($conn,$tabla, $datosFormulario);
            break;
        case 'readAll':
            leerTodos($conn,$tabla);
            break;
        case 'update':
            actualizar($conn,$tabla, $datosFormulario);
            break;
        case 'delete':
            eliminar($conn,$tabla, $datosFormulario); break;
        default:
            throw new Exception("Operación no válida");
    }
} catch(Exception $e) {
    echo json_encode(["error" => "Error: " . $e->getMessage()]);
}

// FUNCIONES
function insertar($conn, $tabla, $datosFormulario){
    $campos = ['codigobarra', 'nombre', 'precio', 'existencia', 'idmarca', 'idcategoria'];
    $mapeo = [
        'codigobarra' => 'txtCodigoBarra',
        'nombre'      => 'txtNombre',
        'precio'      => 'txtPrecio',
        'existencia'  => 'rngCantidad',
        'idmarca'     => 'cboMarca',
        'idcategoria' => 'cboCategoria'
    ];

    foreach ($mapeo as $claveBD => $claveForm) {
        if (!isset($datosFormulario[$claveForm])) {
            throw new Exception("Falta el campo del formulario: $claveForm");
        }
    }

    if(trim($datosFormulario['txtCodigoBarra'])===''){
        throw new Exception("El ID no puede estar vacío");
    }
        
    $campos = array_keys($mapeo);
    $valores = array_map(fn($campo) => $datosFormulario[$mapeo[$campo]], $campos);
    $placeholders = implode(', ', array_fill(0, count($campos), '?'));
    $sql = "INSERT INTO `$tabla` (`" . implode('`, `', $campos) . "`) VALUES ($placeholders)";

    $statement = $conn->prepare($sql);
    if (!$statement) {
        throw new Exception("Error al preparar la consulta");
    }
    
    $statement->execute($valores);
    echo json_encode(['estado' => true, 'mensaje' => 'Datos insertados correctamente']);
}

function leer($conn, $tabla, $datosFormulario){
    // Pendiente implementar
}

function leerTodos($conn, $tabla){
    // Pendiente implementar
}

function actualizar($conn, $tabla, $datosFormulario){
    // Pendiente implementar
}

function eliminar($conn, $tabla, $datosFormulario){
    // Pendiente implementar
}





?>

