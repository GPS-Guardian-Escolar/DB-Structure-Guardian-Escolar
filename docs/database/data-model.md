# Modelo de datos

## Seguridad y usuarios

`users` almacena cuentas y credenciales; `user_roles` relaciona usuarios con `roles`; `roles` y `permissions` definen autorizacion. Las politicas de contrasena viven en `password_policies`. Las sesiones activas se registran en `user_sessions`.

## Estudiantes y dispositivos

`students` pertenece a un acudiente mediante `user_id` y se relaciona con contactos de emergencia, rutas y dispositivos infantiles. Los codigos de vinculacion se almacenan como hash, con expiracion, uso y contador de intentos; el valor original no se persiste.

## Rutas y viajes

`routes` contiene origen, destino y configuracion de la ruta. Las paradas viven en `route_stops`; la asignacion estudiante-ruta se mantiene en la relacion correspondiente. `trips` registra el trayecto y `trip_coordinates` sus posiciones.

## Alertas y zonas

Las zonas seguras, notificaciones y recibos de notificacion se almacenan en sus tablas especificas. Los indices de estas tablas deben acompanarse de la consulta que optimizan y de una politica de retencion cuando guarden coordenadas.
