# Inventario SQL

| Carpeta | Responsabilidad |
| --- | --- |
| `01_ddl/00_extensions` | Extensiones de PostgreSQL |
| `01_ddl/01_schemas` | Schemas |
| `01_ddl/02_types` | Enums y tipos |
| `01_ddl/03_tables` | Tablas base |
| `01_ddl/04_alter` | Cambios posteriores de tablas |
| `01_ddl/05_views` | Vistas |
| `01_ddl/07_functions` | Funciones |
| `01_ddl/08_procedures` | Procedimientos |
| `01_ddl/09_triggers` | Triggers |
| `01_ddl/10_indexes` | Indices |
| `02_dml/00_inserts` | Catalogos y datos iniciales |
| `02_dml/04_patches` | Correcciones de datos |
| `03_dcl/00_roles` | Roles de base de datos |
| `03_dcl/01_grants` | Privilegios |
| `05_rollbacks` | Reversiones por categoria |

El inventario exacto y el orden de ejecucion se obtienen de `changelog/changelog-master.yaml` y de los changelogs hijos. Un archivo SQL no registrado en un changelog no forma parte de la instalacion automatica.
