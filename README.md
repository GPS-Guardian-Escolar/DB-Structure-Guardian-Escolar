# Base de Datos

Estructura SQL independiente del backend para PostgreSQL.

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

Define `APP_DB_PASSWORD` con al menos 32 caracteres alfanuméricos, guion o guion bajo para
`gps_guardian_app`; Liquibase valida ese formato antes de habilitar el login de la aplicación.
No reutilices la contraseña del usuario administrador de PostgreSQL.

Levantar solo PostgreSQL:

```bash
docker-compose up -d
```

La base queda publicada en:

```text
localhost:5432
```

Para levantar backend y base de datos juntos, usar el `docker-compose.yaml` de la raiz del proyecto.
