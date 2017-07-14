 --- [HOME](README.md) --- [FOTOS](READMEFOTOS.md) --- [DISEÑO](READMEDISENO.md) --- [MODULOS](READMEMENU.md) ---

Diseño arquitectonico
=====================

El proyecto se perfila como una aplicacion de escritorio que segun el perfil de 
usuario, puede actuar como servidor o cliente, lo unico central es la base de datos.

Se descompone en 4 modulos de opeeracion y dos modulos generales, empleara una 
base de datos central. El modo de trabajo se detalla en la ultima parte de este 
documento, el criterio aplicado para la eleccion de cada artefacto esta explicado 
en la siguiente seccion. Este esquema es centralizado, pero el diseño de las bases 
de datos contempla sedes Inces multiples.

Indice de contenido:

* [Elementos estructurales](#elementos-estructurales)
   * [Hardware disponible](#hardware-disponible)
   * [Software de desarrollo](#software-de-desarrollo)
   * [Software Base de datos](#software-base-de-datos)
   * [Software Control de fuentes](#software-control-de-fuentes
   * [Planificacion](#planificacion)
* [Descomposicion modular](#descomposicion-modular)
   * [Casos de uso y modulos](#casos-de-uso-y-modulos)
* [Diseño de modelos](#diseno-de-modelos)
   * [Modelo de datos](#modelo-de-datos)
   * [Diccionario de datos](#diccionario-de-datos)
   * [Modelo de clases](#modelo-de-clases)

Elementos estructurales
-----------------------

Se tiene en cuenta equipos de bajos recursos y presencia de red por VPN en primera fase.
Si se implementan sedes se sincroniza la informacion con JSON y servicios.

### Hardware disponible

| artefacto         | caracteristica                         | recomendacion                              |
| ----------------- | -------------------------------------- | ------------------------------------------ |
| Maquina de aplica | VIT, CPU 2GHz, RAM 2Gb, DD 160Gb       | cualquier pc PII en adelante es suficiente |
| Maquina de server | VIT, CPU 2GHz, RAM 2Gb, DD 160Gb       | minimo CPU 1GHz, RAM 1Gb, DD 80Gb          |
| Red de comunica   | LAN o red WAN/WiFi 10Mb                | con solo 1Mb es suficiente par acomunicarse |

Con las tecnologias empleadas GAMBAS se puede contemplar una aplicacion 
del estilo cleinte/servidor sin problemas de requerimeintos.

### Software de desarrollo

Se empleara GAMBAS, ya que es 100% grafico y es RAD (Desarrollo Rapido Aplicaciones) 
ademas de facil de aprender, su forma es igual a VisualBasic, pero sin consumir recursos.
Se tenia contemplado Java, lo cual es ilogico ya que Java obliga cliente/servidor.
Usar Php, implica desarrollo web, Javascript, y no se tiene el tiempo ni experiencia.

| lenguaje | requerimientos | ?popular?        | escritorio | facil desarrollo? | ?cambia mucho?    | requiere experiencia |
| -------- | -------------- | ---------------- | ---------- | ----------------  |------------------ | -------------------- |
| Gambas   | pequenos       | igual que Visual | facilisimo | facilicimo/grafico | mantiene estandar | ninguna, igual que VB |
| php      | pequenos       | si, muy usado    | facilisimo | casi, no es grafico | si, entre versiones | si |
| Java     | muy grandes    | solo empresarial | complicado | no, y es complicado | si, mucho       | si, muchisima |

### Software Base de datos

El `mysqlworkbench` permite el diseño **graficamente**, facil y sencillo de la base de datos.
El `mysql` permite no complicar los desarrolladores con el funcionamiento del motor de base de datos.
Si se hubiera empleado `postgresql` el desarrollo podria verse complicado ya que es un motor muy profesional, 
ademas no hay herramientas de diseño graficas simples o faciles de usar para este motor, y mucho menos gratis.

| DBMS     | requerimientos | herramientas     | disenador grafico | facil configurar | ?cambia mucho?    | requiere experiencia |
| -------- | -------------- | ---------------- | ----------------- | ---------------- |------------------ | -------------------- |
| MariDB   | medianos       | mismas que mysql | mismo que mysql   | si, muy facil    | mantiene estandar | poca |
| MySQL    | medianos       | mysqlworkbench,etc| mysqlworkbech    | si, muy facil    | si, entre versiones | poca |
| Postgres | grandes/variable | muy pocas     | no tiene,menos gratis | necesita afinarse | mantiene estandar | mucha |

### Software Control de fuentes

Se requiere llevar un control de los cambios a medida se realiza el desarrollo, 
el control de cambios permite ver que cambia a medida que varios trabajan, 
si algo sale mal, y antes funcionaba, se puede retornar a esto, muy importante 
evitando duplicar con los famosos "archivos de respaldo", de la era de picapiedras.

| sistema  | requerimientos | herramientas     | interfaz escritorio   | interfaz web     | servicio en internet    |
| -------- | -------------- | ---------------- | --------------------- | ---------------- |------------------------ |
| Subversion | pocos        | muchas           | si, tortoise,rapidsvn | svnview,usvn     | ninguno, todos usan git |
| Git      | medianos       | pocas            | pocas, gitg           | no, pero hay gitlab | si, gitlab, github   |

Porque gitlab?: porque ofrece gestion de projectos, github no ofrece un gestor de projecto real sino solo un identificador de proyecto.

### Planificacion

La planificacion en : [desarrollo-planificacion](desarrollo-planificacion.md)

Descomposicion modular
-----------------------

El desarrollo se agiliza descomponiendo los procesos y funcionalidades en modulos, 
cada modulo atiende una parte especifica de procesos y funciones relacionados.
Documentacion en el documento de modulos: [READMEMENU](READMEMENU.md)

| modulo    | descripcion                                  | caso de uso                   |
| --------- | -------------------------------------------- | ----------------------------- |
| pricipal  | configuracion,conexcion db,usuario,sesion    | CU-0A                         |
| programa  | usuario,sesion,permisos,accesos              | CU-00                         |
| entidades | alumnos,docentes,sedes,aulas,cursos          | CU-01,CU-02,CU-03,CU-04       |
| procesos  | registro,asistencias,incidencias,certifcados | CU-05,CU-06,CU-07,CU-08,CU-09 |
| archivos  | reportes,estadisticas,certificados           | CU-10,CU-11,CU-12             |

El modulo `principal` no es un modulo accedible sino virtual, es el core del programa, 
Cuadno el programa inicia, parte de esto modulo esta en accion, y este modulo 
esta siemrpe activo, certificando en todo momento que el usuario activo es valido, 
esto permite que los cambios realizados por gerencia apliquen al instante.

### Casos de uso y modulos

Documentado en: [desarrollo-matrix-casos-de-uso](desarrollo-matrix-casos-de-uso.md)

Diseño de modelos
=================

Se empleo los programas **Dia** y **Mysqlworkbench** para modelado, 
el programa **Mysqlworkbench** permite diseñar la base de datos 100% graficamente, 
el programa **Dia** despues de diseñar las clases/relaciones, permite exportar a multiples formatos.

Modelo de datos
---------------

Informacion del diseño del modelo de datos, esta en el documento 
del proyecto en `mysqlworkbench`: [gitlab file]() 
La documentacion: [desarrollo-diseno-base-de-datos](desarrollo-diseno-base-de-datos.md)

Diccionario de datos
--------------------

Es generado a partir del modelo de datos, cada columna y tabla diseñada tiene 
su comentario descriptivo explicando brevemente la funcionalidad relacionada.
La documentacion: [desarrollo-diseno-base-de-datos](desarrollo-diseno-base-de-datos.md)

![screenshot00disenomodelodedatos1.png](screenshot00disenomodelodedatos1.png)

Modelo de clases
----------------

Realizado en `Dia` : [diseno-diagrama-de-clases.dia](diseno-diagrama-de-clases.dia)

![diseno-diagrama-de-clases.png](diseno-diagrama-de-clases.png)
