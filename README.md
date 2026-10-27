# Base de Datos

Estructura SQL independiente del backend para PostgreSQL.

## Migraciones

Las migraciones aplicadas son forward-only: no se editan ni se eliminan changesets que ya
puedan existir en `DATABASECHANGELOG`. Los ajustes posteriores deben agregarse como un
changeset nuevo con rollback revisado. Consulta [`docs/MIGRATION_GUIDE.md`](docs/MIGRATION_GUIDE.md)
antes de promover cambios entre entornos.

La documentacion completa de base de datos esta centralizada en:

- `../docs/database/README.md`
- `../docs/database/estructura-bd.md`
- `../docs/database/data-model.md`
- `../docs/database/change-management.md`
- `../docs/database/sql-inventory.md`

## Ejecucion rapida

Crear el archivo local de variables de entorno y completar `POSTGRES_PASSWORD`:

```bash
cp .env.example .env
```

Levantar solo PostgreSQL:

```bash
docker-compose up -d
```

La base queda publicada en:

```text
localhost:5432
```

Para levantar backend y base de datos juntos, usar el `docker-compose.yaml` de la raiz del proyecto.

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
