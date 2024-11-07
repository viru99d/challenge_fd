# challenge_fd

## Estructura del Proyecto
La aplicación sigue la arquitectura Clean Architecture, organizada en módulos con responsabilidades bien definidas:

1. Core: Contiene funcionalidades, excepciones y configuraciones comunes y reutilizables que son utilizados en toda la aplicación.
2. Data: Contiene implementaciones de los repositorios y acceso a datos.
3. Domain: Contiene entidades y casos de uso.
4. Presentation: Contiene la lógica de presentación usando Bloc para gestionar estados y eventos.

## Notas Técnicas
- Persistencia de Sesión: Utiliza SharedPreferences para mantener la autenticación del usuario.
- Persistencia de Datos: Utiliza Bloc para mantener los datos aunque se pierda la conexión.
- Inyección de dependencia: Utiliza Modular para manejar la inyección de dependencias y el manejo de rutas.
- Manejo de Errores: La aplicación incluye clases específicas de error y estados para manejar distintos tipos de fallos.

## Instrucciones para correr la aplicación
1. Clona este repositorio.
   git clone https://github.com/viru99d/challenge_fd.git

2. Busca la rama feature/challenge_fd

3. Instala las dependencias del proyecto.
    Flutter pub get

4. Conecta un dispositivo o abre un emulador, y luego ejecuta:
    Flutter run

## APK de la aplicación

Puedes descargar el APK directamente desde [este enlace](https://drive.google.com/file/d/18aanbgvAa1d1A4mxEEFV4u7tJFpld9T6/view?usp=drive_link).


