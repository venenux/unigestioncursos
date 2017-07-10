El proyecto se perfila como una aplicacion de escritorio cliente y otra de gestion, empleara una 
base de datos central. El modo de trabajo se detalla en la ultima parte de este documento, el criterio 
aplicado para la eleccion de cada artefacto esta explicado en la siguiente seccion.

Este esquema es centralizado, pero por cada sede inces (solo uno por ahora), lo que la hace una 
aplicacion realmente descentralizada si el centro Inces cambia de localidad o la clase se imparte 
en otro centro por motivos de fuerza mayor.

Tecnologias emplear
===================

Se usara base de datos **MariaDB**, equivalente o igual a **MySQL**, no es lo mas acorde en terminos de 
escalabilidad, pero es lo mas idoneo en terminos de desarrollo rapido.

Se usara leguaje de programacion **Gambas**, ya que es muy facil y es 100% grafico. Estopermite crear 
aplicaciones en dias en vez de semanas. Ademas proporciona el IDE y el Runtime, sin consumir mas 
recursos, cosa que Java no permite en el transcurso del tiempo.

Se coordinara el trabajo usando plataforma **GIT** empleando *gitlab* para ello, la plataforma *gitlab* 
provee notificaciones por correo, gestion de cambios de codigo fuente y gestion de proyectos, y soporte 
de documentacion con wiki, ademas de coordinar modularmente el que distintos desarrolladores codifiquen.

Criterios empleados
-------------------

### Lenguaje de programacion

| lenguaje | requerimientos | ?popular?        | escritorio | facil desarrollo? | ?cambia mucho?    | requiere experiencia |
| -------- | -------------- | ---------------- | ---------- | ----------------  |------------------ | -------------------- |
| Gambas   | pequenos       | igual que Visual | facilisimo | facilicimo/grafico | mantiene estandar | ninguna, igual que VB |
| php      | pequenos       | si, muy usado    | facilisimo | casi, no es grafico | si, entre versiones | si |
| Java     | muy grandes    | solo empresarial | complicado | no, y es complicado | si, mucho       | si, muchisima |

### Base de dato

| DBMS     | requerimientos | herramientas     | disenador grafico | facil configurar | ?cambia mucho?    | requiere experiencia |
| -------- | -------------- | ---------------- | ----------------- | ---------------- |------------------ | -------------------- |
| MariDB   | medianos       | mismas que mysql | mismo que mysql   | si, muy facil    | mantiene estandar | poca |
| MySQL    | medianos       | mysqlworkbench,etc| mysqlworkbech    | si, muy facil    | si, entre versiones | poca |
| Postgres | grandes/variable | muy pocas     | no tiene,menos gratis | necesita afinarse | mantiene estandar | mucha |

### Herramienta codigo

| sistema  | requerimientos | herramientas     | interfaz escritorio   | interfaz web     | servicio en internet    |
| -------- | -------------- | ---------------- | --------------------- | ---------------- |------------------------ |
| Subversion | pocos        | muchas           | si, tortoise,rapidsvn | svnview,usvn     | ninguno, todos usan git |
| Git      | medianos       | pocas            | pocas, gitg           | no, pero hay gitlab | si, gitlab, github   |

Porque gitlab?: porque ofrece geston de projectos, github no ofrece un gestor de projecto real sino solo un identificador de proyecto.


Como trabajar este proyecto?
============================

1. Se necesita **tener linux** y el siguiente software:
  + Si tiene bajos recursos o no tiene pc, descargar y grabar este linux: 
     https://sourceforge.net/projects/venenux/files/VenenuX-0.9/venenux-0.9-misa3l-upata_exp_i386.iso/download
  + esto le permitira usarlo sin instalar en un cybercafe, reinicie la pc con el disco insertado
  + arrancar el pc desde el disco, y el entorno estara listo, requerira al menos 1G de ram para trabajar
  + tenga ya o use el disco debe **tener o instalar el siguiente set de software/paquetes**:
     * Gambas : es el entorno de programacion empleado igual a Visual Basic
     * Curl : para que el sistema se comunique con internet
     * Git  : para bajar/trabajar el codigo fuente y el proyecto
     * MariaDB/MySQL : para tener base de datos en donde trabajar
     * MysqlWorkbench : para modelar y manejar la base de datos graficamente
     * Dia  : para modelar el entidad-relacion
  + puede usar el Linux descargado desde usb: http://venenuxmassenkoh.blogspot.com/2012/03/instalador-beta-usb-vnx-basado-en.html 
     el proceso es un poco complicado pero permite usar el USB y al mismo tiempo trabajar con el USB desde una pc sin instalar
2. Clonar el repositorio
`
cd
mkdir Devel & cd Devel
git clone https://gitlab.com/venenux/unigestioncursos.git
cd unigestioncursos
`
3. Ir al menu y arrancar la herramienta correspondiente segun el caso (codificar aplicaion o diseno con la db):
  + Si codifica la aplicacion:
    * ir a menu->desarrollo->Gambas 
    * ejecutar el gambas IDE y 
    * una vez abierto, usar "abrir proyecto"
    * buscar el directorio Devel y 
    * dentro de este el directorio unigestioncursos, 
    * dentro mostrara un icono el directorio de la aplicacion
    * escoger este y abrira el codigo para la aplicacion a codificar
  + Si disena para base de datos:
    * ir a menu->desarrollo->mysqlworkbench 
    * ejecutar el mysqlworkbench y 
    * una vez abierto, del menu arrbia o de la parte "modelos" abrir un modelo"
    * buscar el directorio Devel y 
    * dentro de este el directorio unigestioncursos, 
    * dentro mostrara un directorio modelodb 
    * escoger este y dentro esta el archivo de modelo "unigestiondb"

4. Una vez realizado cambios, cerrar los aplicaciones de desarrollo OJO en caso de gambas ejecutar la opcion "limpira proyecto"

5. Ejecutar una consola en el menu->sistemas->terminal 

6. en la consola abierta hay que acometer los cambios y subirlos a el repositorio git:
  + en la consola ejecutar `cd Devel/unigestioncursos`
  + ejecutar lso comandos de cambios:
    * `git add --all *`
    * `git commit`
    * al ejecutar el commit pedira escribir porque los cambios, sea explicit@
    * `git push`
    * aqui pedira su usuario y clave de gitlab

7. los cambios realizados apareceran en la interfaz web y se podran tener y llevar en cuenta.
