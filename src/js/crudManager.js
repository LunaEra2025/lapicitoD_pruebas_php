export default class CrudManager {
    constructor(urlBase) {
        this.apiUrl = urlBase;
    }

    async createData(nombreTabla, dataForm, nombreArchivo) {
        try {
            const response = await fetch(this.apiUrl + nombreArchivo + '.php',
                {
                    method: 'POST', // método de la petición
                    headers: { 'Content-Type': 'application/json' }, // tipo de contenido que se envía al servidor
                    body: JSON.stringify({ datosFormulario: dataForm, tabla: nombreTabla, operacion: 'create' }) // convierte el objeto a un string formato JSON

                }
            );
            if (!response.ok) {
                throw new Error('Error del servidor HTTP: ' + response.status); // lanza un error si el archivo o ruta es incorrecto
            }
            return await response.json(); // devuelve la respuesta JSON del servidor con los datos
        } catch (error) {
            // aqui no se necesita el await porque no es una promesa, es un objeto direto
            return { errorServer: 'Error al insertar los datos: ' + error.message }; // manejo de error con el servidor
        }
    }



    // no es neceario indicar el archivo php porque readAllData.php ya lee todos los datos de la tabla indicada
    async readAllData(nombreTabla) { // se usa async por que fetch devuleve una promesa
        try {

            // fetch devuelve una promesa del servidor por eso se usa await y la funcion debe ser async
            const response = await fetch(this.apiUrl + 'readAllData.php',
                {
                    method: 'POST', // método de la petición
                    headers: { 'Content-Type': 'application/json' }, // tipo de contenido que se envía al servidor
                    // Si deseas enviar datos, los pones aquí
                    body: JSON.stringify({ tabla: nombreTabla, operacion: 'readAll' }) // convierte un objeto en cadena JSON

                }
            );
            if (!response.ok) {
                throw new Error('Error del servidor HTTP: ' + response.status); // lanza un error si el archivo o ruta es incorrecto
            }

            // tambien debe ser await por que espera los datos sean parseados
            return await response.json(); // devuelve la respuesta JSON del servidor con los datos
        } catch (error) {

            // aqui no se necesita el await porque no es una promesa, es un objeto direto
            return { errorServer: 'Error al obtener los datos: ' + error.message }; // manejo de error con el servidor
        }
    }

    async updateData(nombreTabla, datosFila, nombreArchivo) {
        try {
            const response = await fetch(this.apiUrl + nombreArchivo + '.php',
                {
                    method: 'POST', // método de la petición
                    headers: { 'Content-Type': 'application/json' }, // tipo de contenido que se envía al servidor
                    body: JSON.stringify({ datosFormulario: datosFila, tabla: nombreTabla, operacion: 'update' }) // convierte el objeto a un string formato JSON

                }
            );
            if (!response.ok) {
                throw new Error('Error del servidor HTTP: ' + response.status); // lanza un error si el archivo o ruta es incorrecto
            }
            return await response.json(); // devuelve la respuesta JSON del servidor con los datos
        } catch (error) {
            // aqui no se necesita el await porque no es una promesa, es un objeto direto
            return { errorServer: 'Error al insertar los datos: ' + error.message }; // manejo de error con el servidor
        }
    }
    // DELETE 

    async deleteData(nombreTabla, datos, nombreArchivo) {
        try {
            //console.log(JSON.stringify({ datosFormulario: datos }))

            const response = await fetch(this.apiUrl + nombreArchivo + '.php',
                {
                    method: 'POST', // método de la petición
                    headers: { 'Content-Type': 'application/json' }, // tipo de contenido que se envía al servidor
                    body: JSON.stringify({ datosFormulario: datos, tabla: nombreTabla, operacion: 'delete' }) // convierte el objeto a un string formato JSON

                }
            );
            if (!response.ok) {
                throw new Error('Error del servidor HTTP: ' + response.status); // lanza un error si el archivo o ruta es incorrecto
            }
            return await response.json(); // devuelve la respuesta JSON del servidor con los datos
        } catch (error) {
            // aqui no se necesita el await porque no es una promesa, es un objeto direto
            return { errorServer: 'Error al insertar los datos: ' + error.message }; // manejo de error con el servidor
        }
    }

} 