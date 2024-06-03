# To-Do App

Este proyecto es una aplicación de lista de tareas básica desarrollada en Flutter.

## Estructura del Proyecto

El proyecto está compuesto por dos archivos principales ademas del main:

### model.dart

Este archivo define la clase `Task`, que representa una tarea individual dentro de la aplicación. Cada instancia de `Task` tiene un título (`title`) y un estado que indica si la tarea ha sido completada (`isCompleted`). La clase se inicializa con un título requerido y opcionalmente con un estado de completado.

### home_page.dart

Este archivo contiene la definición de la página principal de la aplicación (`HomePage`). Es un widget de estado que utiliza un `StreamController` para manejar las tareas. Permite agregar nuevas tareas, marcarlas como completadas o eliminarlas. La interfaz de usuario muestra una lista de tareas con casillas de verificación para marcarlas como completadas y botones para eliminarlas. También proporciona un campo de texto para ingresar nuevas tareas y un botón para agregarlas a la lista.