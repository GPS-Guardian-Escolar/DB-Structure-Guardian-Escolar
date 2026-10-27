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
