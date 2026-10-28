# Estructura de la base de datos

La base usa PostgreSQL 15 y el esquema `public`. Liquibase aplica el arbol desde `changelog/changelog-master.yaml` con el orden DDL, DML y DCL.

## Orden de aplicacion

- `01_ddl/`: extensiones, schemas, tipos, tablas, alteraciones, vistas, funciones, procedimientos, triggers e indices.
- `02_dml/`: catalogos, inserts y parches de datos.
- `03_dcl/`: roles, grants y politicas de acceso.
- `04_tcl/`: bloques manuales y recuperaciones transaccionales.
- `05_rollbacks/`: reversas asociadas a los cambiosets.

El repositorio DB se puede levantar de forma aislada con `docker compose up -d` desde su raiz. Para el sistema completo, el Compose soportado esta en `../Docker-Infra-Guardian-Escolar/docker-compose.yaml`.
