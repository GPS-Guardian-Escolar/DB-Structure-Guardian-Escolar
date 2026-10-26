# Documentacion de la base de datos

Este directorio describe el modelo PostgreSQL versionado por Liquibase.

## Lectura recomendada

1. [Estructura](estructura-bd.md): schemas, tipos y orden general de aplicacion.
2. [Modelo de datos](data-model.md): tablas principales y relaciones del dominio.
3. [Gestion de cambios](change-management.md): cambiosets, rollbacks y ambientes.
4. [Inventario SQL](sql-inventory.md): ubicacion de DDL, DML, DCL y rollbacks.
5. [Rotacion de credenciales](credential-rotation.md): procedimiento para validar y cambiar secretos.

La fuente ejecutable siempre es el SQL y los changelogs del repositorio; esta documentacion debe actualizarse junto con cada cambio estructural.
