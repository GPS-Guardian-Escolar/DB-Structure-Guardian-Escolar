# Base de Datos

Estructura SQL independiente del backend para PostgreSQL.

La documentacion versionada de base de datos esta en `docs/database/`:

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

El administrador solo se carga con el contexto `local`; Compose usa `prod` como valor seguro
cuando no se configura un contexto. Completa `ADMIN_EMAIL`, `ADMIN_PHONE` y `ADMIN_PASSWORD_HASH`
con valores locales y un hash BCrypt generado fuera del repositorio. Para rotar esos valores,
actualiza los secretos y vuelve a ejecutar Liquibase con `LIQUIBASE_CONTEXTS=local`.

Levantar solo PostgreSQL:

```bash
docker compose up -d
```

La base queda publicada en:

```text
localhost:5432
```

Para levantar backend y base de datos juntos, usar [`../Docker-Infra-Guardian-Escolar/docker-compose.yaml`](../Docker-Infra-Guardian-Escolar/docker-compose.yaml).
