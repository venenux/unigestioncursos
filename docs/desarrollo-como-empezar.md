 --- [HOME](README.md) --- [FOTOS](READMEFOTOS.md) --- [DISEÑO](READMEDISENO.md) --- [MODULOS](READMEMENU.md) ---

Como trabajar este proyecto?
============================

*OJO* estas instrucciones son para desarrollar!

Para instalar solo instale el paquete.


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
`cd; mkdir Devel & cd Devel; git clone https://gitlab.com/venenux/unigestioncursos.git; cd unigestioncursos`
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
