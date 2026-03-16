# RIS-INR

Sistema de Información Radiológico (RIS) desarrollado para el Instituto Nacional de Rehabilitación (INR), como proyecto de integración de la UAM-Iztapalapa a través del Laboratorio de Investigación en Informática Médica (LIIM).

---

## Prerequisitos

| Herramienta | Versión mínima |
|---|---|
| Java JDK | 17 |
| Maven | 3.9+ (o usar el Maven Wrapper incluido `mvnw`) |
| MariaDB | 11.5+ |

---

## Configuración de la base de datos

### 1. Crear el usuario de la aplicación

Conéctate a MariaDB como administrador y ejecuta:

```sql
CREATE USER 'RIS_INR'@'localhost' IDENTIFIED BY 'ris2025#$';
GRANT ALL PRIVILEGES ON RISV1.* TO 'RIS_INR'@'localhost';
FLUSH PRIVILEGES;
```

### 2. Crear la base de datos y cargar el esquema

```sql
CREATE DATABASE RISV1 CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci;
```

Luego importa el script SQL incluido en la raíz del repositorio:

```bash
mysql -u RIS_INR -p RISV1 < RISV1_20260315.sql
```

> El script incluye tanto la estructura de tablas como los datos de prueba.

---

## Configuración de la aplicación

El archivo de configuración se encuentra en:

```
RISINR/src/main/resources/application.properties
```

Los valores por defecto ya apuntan a la BD local configurada en los pasos anteriores. Si tu entorno es diferente, ajusta:

```properties
spring.datasource.url=jdbc:mariadb://localhost:3306/RISV1
spring.datasource.username=RIS_INR
spring.datasource.password=ris2025#$
```

---

## Cómo correr el proyecto

Clona el repositorio y entra a la carpeta del proyecto:

```bash
git clone https://github.com/almm62/LIIM-RISINR
```

Desde la carpeta `RISINR/`, ejecuta la aplicación:

- **Linux / macOS**
```bash
./mvnw spring-boot:run
```

- **Windows**
```bash
.\mvnw spring-boot:run
```

<img src="./Images/Captura_CLI.png" width="1000">

La aplicación estará disponible en:

```
http://localhost:8080/RISSERVER/login.html
```

---

## Usuario de prueba

Al importar el script SQL ya existe un usuario con todos los roles disponibles:

| Campo | Valor |
|---|---|
| Usuario | `LIIM` |
| Contraseña | `holaMundo` |

Los perfiles habilitados actualmente para prueba son:

- Administrador
- Jefe de Servicio

<img src="./Images/Captura_Login.png" width="1000">

### Perfil de Administrador

<img src="./Images/Captura_Admin.png" width="1000">

### Perfil de Jefe de Servicio

<img src="./Images/Captura_JefeServicio.png" width="1000">

---

## Notas para VSCode

Si se desea trabajar con Visual Studio Code, se recomiendan las siguientes extensiones:

- **Extension Pack for Java** (incluye Language Support, Debugger, Test Runner, Maven, Gradle, Project Manager e IntelliCode)
- **Spring Boot Extension Pack** (incluye Spring Boot Tools, Spring Initializr y Spring Boot Dashboard)

<img src="./Images/Captura_VSCode.png" width="1000">

---

## Documentación Javadoc

Para generar el sitio HTML de documentación del código:

```bash
./mvnw javadoc:javadoc -Ddoclint=none
```

El sitio se genera en:

```
RISINR/target/reports/apidocs/index.html
```

---

## Autores

- **Pedro Misael Rodríguez Jiménez**
- **María de Jesús Rebolledo Bustillo**

**Líder del proyecto:** Alfonso Martínez Martínez
