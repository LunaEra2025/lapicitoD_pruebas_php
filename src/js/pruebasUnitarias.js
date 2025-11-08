

const objMock = {
    query: () => ({ id: 1, name: 'pedro' })
};

console.log(objMock.query())



const miApiMock = () => Promise.resolve({ datos: "True", color: "red" })


async function probarApi() {
    const resultado = await miApiMock();
    console.log(resultado);
}
probarApi();



// Función para sumar dos números
const sumar = (a, b) => a + b;

// Prueba unitaria de suma
function probar_suma() {
    const resultado = sumar(5, 3);
    const esperado = 8;
    
    if (resultado === esperado) {
        console.log('✅ Prueba suma: PASÓ');
    } else {
        console.log(`❌ Prueba suma: FALLÓ - Esperado: ${esperado}, Obtenido: ${resultado}`);
    }
}

probar_suma();
