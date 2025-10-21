# Sistema de Información Radiológica del Instituto Nacional de Rehanlilitación
Proyecto de integración del sistema RIS-INR, con los servicios y aplicaciones trabajados previamente con alumnos de la UAM-Iztapalapa en el Laboratorio de Investigación en Informática Médica (LIIM)
## 🔩 Requisitos y dependencias
- Java 17.0 +
- MariaDB 11.5 +
## ▶️ Uso (CLI)
Restaurar base de datos con las siguientes propiedades:
  - Nombre BD: RISV1
  - Nombre Usuario (Todos los permisos a RISV1): RIS_INR
  - password de usuario: ris2025#$
    
Clonamos el repositorio en el directorio deseado
``` bash
git clone https://github.com/almm62/LIIM-RISINR
```
Accedemos a la carpeta del proyecto
- Linux
``` bash
cd LIIM-RISINR/RISINR
```
- Windows (cmd)
``` bash
cd LIIM-RISINR\RISINR
```
Ejecutamos el proyecto
- Linux
``` bash
./mvnw spring-boot:run
```
- Windows
``` bash
.\mvnw spring-boot:run
```
### Servidor corriendo
<img src="./Images/Captura_CLI.png" width="1000">
   
## 🔍 Notas y consideraciones
- Si se desea trabajar con Visual Studio Code, es recomendable descargar las siguientes extensiones:
  - Extension Pack for Java | incluye:
    - 📦 Language Support for Java™ by Red Hat
    - 📦 Debugger for Java
    - 📦 Test Runner for Java
    - 📦 Maven for Java
    - 📦 Gradle for Java
    - 📦 Project Manager for Java
    - 📦 Visual Studio IntelliCode
  - Spring Boot Extension Pack | incluye:
    - 📦 Spring Boot Tools
    - 📦 Spring Initializr Java Support
    - 📦 Spring Boot Dashboard
### Ejecución desde VSCode
<img src="./Images/Captura_VSCode.png" width="1000">


## Acceda a la Aplicación desde [http://localhost:8080/RISSERVER/login.html](http://localhost:8080/RISSERVER/login.html)
E inicie Sesión
- Actualmente los perfiles que están habilitados para prueba son:
  - Administrador
  - Jefe de Servicio
<img src="./Images/Captura_Login.png" width="1000">

### Perfil de Administrador
<img src="./Images/Captura_Admin.png" width="1000">

### Perfil de Jefe de Servicio
<img src="./Images/Captura_JefeServicio.png" width="1000">
