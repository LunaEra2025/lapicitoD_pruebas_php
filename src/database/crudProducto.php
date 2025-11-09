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
        case 'update':
            actualizar($conn,$tabla, $datosFormulario);
            break;
        case 'delete':
            eliminar($conn,$tabla, $datosFormulario); break;
        default:
            throw new Exception("Operación no válida");
    }

}

// este se lanza si hay algun error de conexion a la base de datos
catch(Exception $e) {
            echo json_encode(["error" => "Error: " . $e->getMessage()]);
        }
    
    // métodos

function insertar($conn, $tabla, $datosFormulario){
        try {
            // se crea un mapa para asociar cada campo de la tabla con los nombres de los campos del formulario en el atributo name
            $mapeo = [
                'codigobarra' => 'txtCodigoBarra',
                'nombre'      => 'txtNombre',
                'precio'      => 'txtPrecio',
                'existencia'  => 'rngCantidad',
                'idmarca'     => 'cboMarca',
                'idcategoria' => 'cboCategoria'
            ];


            // verifica que cada campo del formulario exista y tenga valor, hace una segunda validación ademàs de la que hace bootstrap
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
            // array_fill(0, count($campos), '?') crea un arreglo iniciando en la posición 0, del tamaño indicado en count, y los llena con ?
            // el resultado de fill es: ['?', '?', '?', '?', '?', '?']
            // implode() convierte un arreglo en una cadena, separando por el delimitador especificado. el resultado es= '?, ?, ?, ?, ?, ?'

            // $placeholders = marcadores de posición
            $placeholders = implode(', ', array_fill(0, count($campos), '?'));
            // en este caso, implode('`, `', $campos) convierte cada valor del arreglo campos en = `codigobarra`, `nombre`, `precio`, `existencia`, `idmarca`, `idcategoria
            $sql = "INSERT INTO `$tabla` (`" . implode('`, `', $campos) . "`) VALUES ($placeholders)";

            $statement = $conn->prepare($sql);// prepara la sentencia SQL para recibir en cada ? los valores que hacen falta
                if (!$statement) { // si hay algun error lanza una excepción
                    throw new Exception("Error al preparar la consulta: " . $conn->error);
                }
                
                // lanza oficialmente la consulta a la base de datos
                /*
                    ? ← '123456'  (s)
                    ? ← 'Lapicera' (s)
                    ? ← 12.5       (d)
                    ? ← 20         (i)
                    ? ← 1          (s)
                    ? ← 3          (i)*/
                $statement->execute($valores); // PDO maneja los tipos de datos automáticamente. - PDO usa bindValue() o directamente un arreglo en execute().
                /**
                 * bindValue() es un método de PDO que asigna valores específicos a los marcadores de posición (?)
                 *  en sentencias preparadas, uno por uno.
                 */

                echo json_encode(['estado' => true, 'mensaje' => 'Datos insertados correctamente']);


        } catch (PDOException $e) { // se lanza si el nombre de la tabla es incorrecto, cuando se manda desde endPoints.js
            // tambien se lanza cuando el nombre del cmapo es incorrecto o cuando el ID se repite
            echo json_encode(["errorBD" => "Error en la inserción: ".$e->getMessage()]);
        }

        catch(Exception $e) { // se lanza cuando entra en cada throw de esta función
            echo json_encode(["error" => "Error: " . $e->getMessage()]);
        }
            

    }


    function eliminar($conn, $tabla, $datosFormulario){
       
        try {
             //echo json_encode(["ID" => $datosFormulario]);           
             $id = $datosFormulario ?? null; 
             
             //echo "el id es: ".$id;

            $sql = "DELETE FROM `$tabla` WHERE `codigoBarra` = ?";
            $statement = $conn->prepare($sql);
            if (!$statement) {
                throw new Exception("Error al preparar la consulta: " . $conn->error);
            }

            $statement->execute([$id]);

            if ($statement->rowCount() > 0) {
                echo json_encode(['estado' => true, 'mensaje' => 'Registro eliminado correctamente']);
            } else {
                echo json_encode(['estado' => false, 'mensaje' => 'No se encontró el registro para eliminar']);
            }
        } catch (Exception $e) {
            echo json_encode(["error" => "Error: " . $e->getMessage()]);
        }
    }


    function actualizar($conn, $tabla, $datosFormulario){

        try {
            // Guarda el ID antes de crear el mapeo
            $id = $datosFormulario['codigoBarra'];

            // Mapeo solo de los campos que se pueden actualizar (sin el ID)
            $mapeo = [
                'nombre'      => 'nombre',
                'precio'      => 'precio',
                'existencia'  => 'existencia',
                'idmarca'     => 'IDmarca',
                'idcategoria' => 'IDcategoria'
            ];

            // Obtiene solo las claves del mapeo (nombres de columnas de la BD)
            $campos = array_keys($mapeo);

            // Crea un arreglo con los valores del formulario en el orden de los campos de la BD
            // Ejemplo: ['Lapicera', '12.5', '20', 'M001', 'C001']
            $valores = array_map(fn($campo) => $datosFormulario[$mapeo[$campo]], $campos);

            // Crea la cláusula SET para la consulta UPDATE (sin incluir codigobarra)
            // Resultado: "`nombre` = ?, `precio` = ?, `existencia` = ?, `idmarca` = ?, `idcategoria` = ?"
            $setClause = implode(', ', array_map(fn($campo) => "`$campo` = ?", $campos));

            // Construye la consulta SQL completa con la cláusula WHERE para actualizar solo el registro con el ID indicado
            $sql = "UPDATE `$tabla` SET $setClause WHERE `codigoBarra` = ?";

            // Prepara la sentencia SQL
            $statement = $conn->prepare($sql);
            if (!$statement) {
                throw new Exception("Error al preparar la consulta: " . $conn->error);
            }

            // Agrega el ID al final del arreglo de valores para usarlo en la cláusula WHERE
            // Ahora $valores tiene: ['Lapicera', '12.5', '20', 'M001', 'C001', '123456']
            $valores[] = $id; // es como array.push

            // Ejecuta la consulta con todos los valores, aqui asigna acada espacio con ? los valores del array en orden
            $statement->execute($valores);

            // Verifica si se actualizó algún registro
            if ($statement->rowCount() > 0) {
                echo json_encode(['estado' => true, 'mensaje' => 'Registro actualizado correctamente']);
            } else {
                echo json_encode(['estado' => false, 'mensaje' => 'No se encontró el registro para actualizar o no se realizó ningún cambio']);
            }
        } catch (Exception $e) { // este es el error con el servidor o el sql lanza un error
            echo json_encode(["error" => "Error: " . $e->getMessage()]);
        }
    }   

?>

