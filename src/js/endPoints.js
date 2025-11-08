

/*
    endPoints.js es donde defines todas las funciones específicas que tu aplicación necesita. 
*/

import CrudManager from "./crudManager.js";

const apiService = new CrudManager('./src/database/'); // crea un objeto de CrudManager y le manda la ruta generica

/*
    Aquí no necesitamos usar async/await porque no estamos esperando el resultado en ese punto
    simplemente dejamos que el formulario que llama a esa función decida qué hacer con la promesa.
*/


// dataForm son los datos que recibes del formulario
// CREATE (nombre tabla,datos del formulario,nombre del archivo PHP)
const createProduct = (dataForm) => apiService.createData('producto', dataForm, 'crudProducto');


// READ ALL

// no es necesario : const selectAllProducts = () => apiService.readAllData('producto', 'readAllData');
// por que readAllData lee todos los datos de cada tabla
const selectAllProducts = () => apiService.readAllData('producto');
const selectAllCategoria = () => apiService.readAllData('categoria');


// UPDATE

// DELETE

const deleteProduct = (id) => apiService.deleteData('producto', id);

export default {
    createProduct,
    selectAllProducts,
    selectAllCategoria,
    deleteProduct
}
