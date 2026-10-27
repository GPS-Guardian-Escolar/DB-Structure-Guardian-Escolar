# Migration Guide

## Rules

- Add a new numbered changeset for every schema or data change.
- Keep the SQL file, changelog entry and rollback file in the same pull request.
- Never edit the SQL, id, author or logical path of a changeset that may already be applied.
- Use `IF EXISTS` and `IF NOT EXISTS` only when they preserve the intended safety semantics; do not use them to hide an invalid migration.
- Test `update` and the reviewed rollback against a disposable PostgreSQL database before promotion.

## Existing duplicate definitions

Some early schema files define columns that later patches also check with `IF NOT EXISTS`.
This is intentionally kept for compatibility with databases initialized from either history.
Do not delete the later patch or rewrite the original DDL: Liquibase identifies applied
changesets by id, author and logical path, and changing them can cause checksum failures or
make environments disagree about their migration state.

## Validation

From `Docker-Infra-Guardian-Escolar`, validate the rendered stack first:

```powershell
$env:POSTGRES_PASSWORD = 'ci-password'
$env:JWT_SECRET = '01234567890123456789012345678901'
docker compose config --quiet
```

Then run Liquibase `validate` and `update` only against a disposable database or an approved
environment. Keep the output and the resulting `DATABASECHANGELOG` entries as deployment
evidence. Never use `docker compose down -v` as a rollback for a database containing user data.
