- usa snake_case para el archivo pruebasUnitarias.js
- usa snake_case para nombre de funciones y variables
- para todo el proyecto, agrega comentarios en español
- Usa nombres de variables en español

<!-- 
    se creo la carpeta .Amazonq en la carpeta raiz, y dentro se cololó el archivo agents.md con las especificaciones que requieres para tu proyexto

    así cada vez que escribas un nuevo código lo va a hacer con esas especificaciones

    Para GitHub Copilot, la estructura es diferente:

        Carpeta: .github/
        Archivo: copilot-instructions.md

        .github/agents.md          # Para GitHub Copilot
        .claude/agents.md          # Para Claude Code
        .amazonq/agents.md         # Para Amazon Q
        docs/agents.md             # Documentación general

    ejemplos:

    - Usa snake_case para nombres de archivos JavaScript
- Agrega comentarios explicativos en español
- Usa nombres de variables en español
- Implementa manejo de errores con try-catch
- Usa PDO para crear la conexión y operaciones de base de datos
->

<!-- 
    ejemplo prompt

    crea un nuevo archivo que realice la conexion a la base de datos
->



<!-- 

    ¿Qué contienen?
# Agentes de IA - Contexto del Proyecto

## Descripción
Sistema CRUD de papelería con PHP y JavaScript

## Estructura
- `/src/database/` - Archivos PHP backend
- `/src/js/` - Archivos JavaScript frontend

## Convenciones
- Usar PDO para base de datos
- Validación en cliente y servidor
- Respuestas JSON consistentes

## Reglas
- No usar mysqli, solo PDO
- Siempre usar sentencias preparadas
- Manejo de errores con try-catch
->