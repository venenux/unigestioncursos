 --- [HOME](README.md) --- [FOTOS](READMEFOTOS.md) --- [DISEÑO](READMEDISENO.md) --- [MODULOS](READMEMENU.md) ---

El desarrollo se agiliza descomponiendo los procesos y funcionalidades en modulos, 
cada modulo atiende una parte especifica de procesos y funciones relacionados.

Menu de modulos o menu principal
--------------------------------

Cada modulo es un menu en el programa, a excepcion de uno solo, el `principal`.
El modulo `principal` no es un modulo accedible sino virtual, es el core del programa.

| modulo    | descripcion                                  | caso de uso                   |
| --------- | -------------------------------------------- | ----------------------------- |
| pricipal  | configuracion,conexcion db,usuario,sesion    | CU-0A                         |
| programa  | usuario,sesion,permisos,accesos              | CU-00                         |
| entidades | alumnos,docentes,sedes,aulas,cursos          | CU-01,CU-02,CU-03,CU-04       |
| procesos  | registro,asistencias,incidencias,certifcados | CU-05,CU-06,CU-07,CU-08,CU-09 |
| archivos  | reportes,estadisticas,certificados           | CU-10,CU-11,CU-12             |

Menus de cada modulo
--------------------

Cuadno el programa inicia, parte de esto modulo esta en accion, y este modulo 
esta siemrpe activo, certificando en todo momento que el usuario activo es valido, 
esto permite que los cambios realizados por gerencia apliquen al instante.

### programa

### entidades

### procesos

### archivos

