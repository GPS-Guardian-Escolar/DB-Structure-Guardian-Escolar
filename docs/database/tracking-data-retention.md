# Retención de datos de seguimiento

## Política aplicada

- Las coordenadas se conservan durante 7 días después del cierre del trayecto.
- El historial del trayecto (estudiante, ruta, fechas y estado) se conserva durante 30 días después del cierre.
- Las notificaciones y sus recibos se conservan durante 3 días.
- Las plantillas de rutas y zonas seguras se conservan hasta que el acudiente las elimine; no se purgan con el historial de un trayecto.
- Trayectos activos o sin fecha de cierre no se eliminan por esta tarea.

Estos plazos limitan la exposición de ubicaciones detalladas y acotan el volumen de datos operativos; no constituyen una medición de capacidad ni una certificación legal. Se pueden ajustar si la operación o una revisión de privacidad demuestra que hace falta.

## Ejecución

El backend programa una purga diaria a las 03:15 UTC. `app.retention.enabled` permite desactivarla y `app.retention.cron` permite cambiar el horario. La ejecución elimina primero los recibos/notificaciones y coordenadas dependientes y después los trayectos vencidos. Registra los conteos eliminados en el log del servicio.

La función SQL `fn_purge_completed_trip_coordinates(p_before)` sigue siendo una herramienta manual independiente para operadores de base de datos; el planificador de backend no depende de ella.

## Operación y cuidado

- Antes de desplegar por primera vez, revisar en producción la fecha de cierre de trayectos antiguos y el respaldo recuperable.
- Verificar los conteos del log tras cada ejecución y alertar si la tarea falla.
- La purga es permanente para las filas vencidas; las rutas reutilizables permanecen intactas.
- Una regla de retención no reemplaza el aviso de privacidad, los derechos de titulares ni las obligaciones del responsable.
