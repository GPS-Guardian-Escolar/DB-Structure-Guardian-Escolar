# Gestion de cambios

Cada cambio estructural debe tener un changeset nuevo en el directorio que corresponda. No se deben editar changesets ya aplicados ni reutilizar sus identificadores.

## Flujo

1. Crear el SQL y su rollback en `05_rollbacks/`.
2. Registrar ambos en el `changelog.yaml` de la carpeta.
3. Ejecutar `liquibase validate` y luego `liquibase update` contra una base limpia.
4. Probar el rollback en una base descartable cuando el cambio lo permita.
5. Promover el mismo commit por `dev`, `qa` y `main`.

El usuario administrador es una carga exclusiva del contexto `local`. Su correo, UUID, telefono y hash BCrypt llegan por variables del entorno; nunca deben escribirse en SQL ni en el historial.

## Compose

- Base aislada: `docker-compose.yaml` de este repositorio.
- Sistema completo: `../Docker-Infra-Guardian-Escolar/docker-compose.yaml`.

El archivo `.env` es local y no debe versionarse. Para cargas locales, definir `LIQUIBASE_CONTEXTS=local` y `ADMIN_PASSWORD_HASH`.
