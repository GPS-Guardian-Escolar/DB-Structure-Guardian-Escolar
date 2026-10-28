# Rotacion de credenciales

## Resultado de la verificacion H-69

El historial antiguo contiene `username=postgres` y `password=postgres` en `liquibase.properties`.
La credencial solo aparece en commits historicos de configuracion local; el archivo actual no contiene
credenciales y los dos Compose reciben `POSTGRES_PASSWORD` desde el entorno.

No se puede confirmar desde Git si esa contraseña fue usada en QA, produccion o una base compartida.
La confirmacion requiere revisar los secretos configurados, los logs de conexion y las bases reales.

## Procedimiento

1. Buscar `postgres` y la contraseña antigua en los secretos de CI/CD, Render, Docker y gestores de secretos.
2. Revisar usuarios y logs de PostgreSQL en cada ambiente no local.
3. Si existe cualquier coincidencia fuera de local, cambiar inmediatamente la contraseña del usuario afectado,
   actualizar `POSTGRES_PASSWORD`/`LIQUIBASE_COMMAND_PASSWORD` y reiniciar los servicios.
4. Validar que el backend y Liquibase conecten con el nuevo secreto y revocar el secreto anterior.
5. Solo si la credencial fue expuesta o usada fuera de local, limpiar el historial con una herramienta aprobada,
   coordinar el force-push y notificar a todos los clones; la limpieza no sustituye la rotacion.

La rama actual no reescribe el historial porque no contiene evidencia de uso fuera de local y esa operacion
requiere coordinacion con el repositorio remoto y todos sus consumidores.
