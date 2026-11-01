function esCorreoValido(correo) {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(correo);
    // .test se usa en funciones regulares y devuelve true o false
}




// primer ejemplo

function tablaMultiplicar(numero) {
    let tabla = "";

    for (let i = 1; i <= 10; i++) {
        tabla += `${numero} x ${i} = ${numero * i}\n`;
    }
    return tabla;
}

// probarlo ctrl +  fn + f5
// ejecutar con node.js

console.log(tablaMultiplicar(5));


function ruta(archivo) {
    return "../php/" + archivo + ".php";
}


export default { esCorreoValido, tablaMultiplicar, ruta };