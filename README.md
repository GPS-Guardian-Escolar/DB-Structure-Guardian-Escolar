# Base de Datos

Estructura SQL independiente del backend para PostgreSQL.

## Migraciones

Las migraciones aplicadas son forward-only: no se editan ni se eliminan changesets que ya
puedan existir en `DATABASECHANGELOG`. Los ajustes posteriores deben agregarse como un
changeset nuevo con rollback revisado. Consulta [`docs/MIGRATION_GUIDE.md`](docs/MIGRATION_GUIDE.md)
antes de promover cambios entre entornos.

La documentacion completa de base de datos esta centralizada en:

- [`docs/database/README.md`](docs/database/README.md)
- [`docs/database/estructura-bd.md`](docs/database/estructura-bd.md)
- [`docs/database/data-model.md`](docs/database/data-model.md)
- [`docs/database/change-management.md`](docs/database/change-management.md)
- [`docs/database/sql-inventory.md`](docs/database/sql-inventory.md)

## Ejecucion rapida

Crear el archivo local de variables de entorno y completar `POSTGRES_PASSWORD`:

```bash
cp .env.example .env
```

Define `APP_DB_PASSWORD` con al menos 32 caracteres alfanuméricos, guion o guion bajo para
`gps_guardian_app`; Liquibase valida ese formato antes de habilitar el login de la aplicación.
No reutilices la contraseña del usuario administrador de PostgreSQL.

El administrador solo se carga con el contexto `local`; Compose usa `prod` como valor seguro
cuando no se configura un contexto. Completa `ADMIN_EMAIL`, `ADMIN_PHONE` y `ADMIN_PASSWORD_HASH`
con valores locales y un hash BCrypt generado fuera del repositorio. Para rotar esos valores,
actualiza los secretos y vuelve a ejecutar Liquibase con `LIQUIBASE_CONTEXTS=local`.

Para un entorno desplegado, no uses la cuenta fija de demostracion. Ejecuta una sola vez
Liquibase con `LIQUIBASE_CONTEXTS=prod,bootstrap` y proporciona `ADMIN_EMAIL`, `ADMIN_PHONE`
y `ADMIN_PASSWORD_HASH` mediante el gestor de secretos del entorno. El changeset `005d`
crea o actualiza esa cuenta y le asigna el rol `ADMIN`. Los despliegues posteriores deben
usar solamente `LIQUIBASE_CONTEXTS=prod` y no conservar esas variables en el entorno del
servicio. La contrasena original y el hash no deben entrar al repositorio.

Levantar solo PostgreSQL:

```bash
docker compose up -d
```

La base queda publicada en:

```text
localhost:5432
```

Para levantar backend y base de datos juntos, usar [`../Docker-Infra-Guardian-Escolar/docker-compose.yaml`](../Docker-Infra-Guardian-Escolar/docker-compose.yaml).

## Retencion de coordenadas

La base incluye `fn_purge_completed_trip_coordinates(p_before)`, que elimina coordenadas
solo de trayectos completados o cancelados cuya fecha de cierre sea anterior al corte indicado.
Los trayectos pendientes o activos se conservan. El proceso no se ejecuta automáticamente;
un operador de base de datos puede programarlo después de definir la política de retención:

```sql
SELECT fn_purge_completed_trip_coordinates(NOW() - INTERVAL '365 days');
```

El resultado indica cuántas coordenadas se eliminaron. La función está restringida al
administrador de la base de datos y no se expone al usuario de aplicación.
