# Sistemas Operativos: Laboratorio 3 (MLFQ)

## Primera Parte: Estudiando el planificador de `xv6`.

### Preguntas:

1. Analizar el código del planificador y responda:
- ¿Qué política utiliza `xv6` para elegir el próximo proceso a correr?

El sistema operativo `xv6` presenta un planificador del tipo Round Robin (RR), la implementación se encuentra en `proc.c` más precisamente en la función `scheduler()`. A simple vista en la función se observan dos *loops*, el primero o principal que se carracteriza por ser infinito esto hace que el  *scheduler* nunca regrese. Antes de entrar al *loop* secundario el *scheduler* obtiene el `ptable.lock`, que puede evitar que otras CPU modifiquen el estado del proceso en la tabla de punteros de proceso y evitar conflictos de datos. Después de ingresar al ciclo, se recorren los procesos en la tabla de procesos en orden.

Cuando encuentra que el estado de un proceso es runnable se cambia el puntero del proceso actualmente en ejecución de esta CPU al puntero del proceso seleccionado, luego cambia al espacio de memoria virtual del usuario del proceso y por último cambia el estado del proceso a en ejecución.

Después de completar las operaciones anteriores, se llama a la función `swtch` para cambiar el contexto. Este es el planificador que comenzará a ejecutarse, después de cambiar al espacio de memoria virtual del kernel y vaciar el proceso en ejecución en la CPU actual, ingresa al siguiente ciclo.

Se puede observar que aunque el algoritmo RR implementado por el sistema `xv6` no organiza la cola de listas según el principio de *First Come First Served* (FCFS). En cambio, se ordenan en un orden fijo, es decir, el orden de los procesos en la tabla de procesos, tal desviación no causa inanición, y la implementación aún puede garantizar que cada proceso en la cola lista pueda obtener el derecho a usar la CPU dentro del tiempo esperado.

2. Analizar el código que interrumpe a un proceso al final de su quantum y responda:

- ¿Cuánto dura un *quantum* en `xv6`?

En *quantum* de `xv6` tiene una duración de 10ms para cada procesador.

- ¿Hay alguna forma de que a un proceso se le asigne menos tiempo?

## Segunda Parte: Cómo el planificador afecta a los procesos.
