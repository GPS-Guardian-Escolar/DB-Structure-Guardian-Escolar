# Gestion de cambios

Cada cambio estructural debe tener un changeset nuevo en el directorio que corresponda. No se deben editar changesets ya aplicados ni reutilizar sus identificadores.

## Flujo

1. Crear el SQL y su rollback en `05_rollbacks/`.
2. Registrar ambos en el `changelog.yaml` de la carpeta.
3. Ejecutar `liquibase validate` y luego `liquibase update` contra una base limpia.
4. Probar el rollback en una base descartable cuando el cambio lo permita.
5. Promover el mismo commit por `dev`, `qa` y `main`.

El usuario administrador es una carga exclusiva del contexto `local`. Su correo, telefono y hash BCrypt llegan por variables del entorno; el UUID estable conserva las relaciones de la carga inicial. No se deben escribir credenciales nuevas en SQL ni en el historial. Compose usa el contexto `prod` si `LIQUIBASE_CONTEXTS` queda vacío; las cargas locales deben definir `LIQUIBASE_CONTEXTS=local` y completar las tres variables de administrador.

## Compose

- Base aislada: `docker-compose.yaml` de este repositorio.
- Sistema completo: `../Docker-Infra-Guardian-Escolar/docker-compose.yaml`.

El archivo `.env` es local y no debe versionarse. Para cargas locales, definir `LIQUIBASE_CONTEXTS=local`, `ADMIN_EMAIL`, `ADMIN_PHONE` y `ADMIN_PASSWORD_HASH`.
