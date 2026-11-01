'use strict';

document.addEventListener('DOMContentLoaded', function () {

    // ── Si ya está autenticado, ir directo al sistema ────────────────────────
    if (sessionStorage.getItem('isLoggedIn') === 'true') {
        window.location.href = 'index.html';
        return;
    }

    // ── Referencias al DOM ───────────────────────────────────────────────────
    const form = document.querySelector('.needs-validation');
    const inputEmail = document.getElementById('txtEmail');
    const inputPwd = document.getElementById('idPassword');
    const btnToggle = document.getElementById('btnTogglePwd');
    const iconEye = document.getElementById('iconEye');
    const alertError = document.getElementById('alertError');

    // Foco inicial
    inputEmail.focus();

    // ── Mostrar / ocultar contraseña ─────────────────────────────────────────
    const eyeOpenSVG = `
        <path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z"/>
        <path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0"/>`;

    const eyeClosedSVG = `
        <path d="M13.359 11.238C15.06 9.72 16 8 16 8s-3-5.5-8-5.5a7 7 0 0 0-2.79.588l.77.771A6 6 0 0 1 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755-.165.165-.337.328-.517.486z"/>
        <path d="M11.297 9.176a3.5 3.5 0 0 0-4.474-4.474l.823.823a2.5 2.5 0 0 1 2.829 2.829zm-2.943 1.299.822.822a3.5 3.5 0 0 1-4.474-4.474l.823.823a2.5 2.5 0 0 0 2.829 2.829z"/>
        <path d="M3.35 5.47q-.27.24-.518.487A13 13 0 0 0 1.172 8l.195.288c.335.48.83 1.12 1.465 1.755C4.121 11.332 5.881 12.5 8 12.5c.716 0 1.39-.133 2.02-.36l.77.772A7 7 0 0 1 8 13.5C3 13.5 0 8 0 8s.939-1.721 2.641-3.238z"/>
        <path d="m13.646 14.354-12-12 .708-.708 12 12z"/>`;

    btnToggle.addEventListener('click', function () {
        const isPassword = inputPwd.type === 'password';
        inputPwd.type = isPassword ? 'text' : 'password';
        iconEye.innerHTML = isPassword ? eyeClosedSVG : eyeOpenSVG;
        btnToggle.setAttribute('aria-label', isPassword ? 'Ocultar contraseña' : 'Mostrar contraseña');
    });

    // ── Ocultar alerta de error cuando el usuario empiece a corregir ─────────
    [inputEmail, inputPwd].forEach(function (input) {
        input.addEventListener('input', function () {
            alertError.style.display = 'none';
        });
    });

    // ── Envío del formulario ─────────────────────────────────────────────────
    form.addEventListener('submit', function (event) {
        event.preventDefault();
        event.stopPropagation();

        // Validación de Bootstrap
        if (!form.checkValidity()) {
            form.classList.add('was-validated');
            inputEmail.focus();
            return;
        }

        // Credenciales válidas (autenticación client-side)
        const USER = 'luna@gmail.com';
        const PWD = 'luna';

        const emailIngresado = inputEmail.value.trim();
        const pwdIngresada = inputPwd.value;

        if (emailIngresado === USER && pwdIngresada === PWD) {
            sessionStorage.setItem('isLoggedIn', 'true');
            window.location.href = 'index.html';
        } else {
            alertError.style.display = 'flex';
            inputPwd.value = '';      // limpiar contraseña por seguridad
            inputPwd.focus();
            form.classList.remove('was-validated'); // resetear validación visual
        }
    });

});
