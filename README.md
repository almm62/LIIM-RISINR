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

Desde la carpeta `RISINR/`:

```bash
./mvnw spring-boot:run
```

La aplicación estará disponible en:

```
http://localhost:8080/RISSERVER
```

---

## Usuario de prueba

Al importar el script SQL ya existe un usuario con todos los roles disponibles:

| Campo | Valor |
|---|---|
| Usuario | `LIIM` |
| Contraseña | `holaMundo` |

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
