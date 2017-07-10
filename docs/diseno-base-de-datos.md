# Dise?o de datos

* [Modelo de Base de Datos] (#modelo-de-base-de-datos)
  * [Modelo de datos] (#modelo-de-datos)
    * [Modelo DB central] (#modelo-db-central)
    * [Modelo DB Aplicacion] (#modelo-db-aplicacion)
  * [Diccionario de Datos] (#diccionario-de-datos)

Modelo de Base de Datos
==========================

El desarrollo sera implementando **MysqlWorkbench**, usando la interfaz de dise?o en modo IDEFIX, es 100% grafico y permite ver cada tabla como una relacion entre una entidad y un proceso.

Modelo de datos
------------------

Se analizo el hardware disponible y se soporta un modelo de servidor liviano en elmismo, con una DB central, y las aplicaciones se conectan y se desarrollan en esta, sin embargo, se puede alterar para que cada aplicacion pueda tener una db local y los datos simplemente se inserten en una db central despues.

La base de datos esta dividida en dos (que se puede hacer una sola), una central y una de cliente, cada tabla que tenga que ver con algun proceso del lado de los clientes/aplicativos tiene al menos 3 campos en la db cliente, el codigo entidad (inces) al que aplica, el codigo maquina (pc o ip) que ejecuta y el codigo id propio de cada tabla.
En la base de datos central estan los usuarios, que son tanto alumnos, como docentes/administrativos (diferenciados por el tipo), las entidades (o inces, por ahora uno solo) en los que aplica cada proceso o usuario, y tablas de 

### Modelo DB central

![unigestiondb-unidbcentral](/uploads/e8bfea6620e545270becc804308d03dc/unigestiondb-unidbcentral.png)

### Modelo DB aplicacion

![unigestiondb-unidbcliente](/uploads/96c38b60209bacc793a2e1047aae31c2/unigestiondb-unidbcliente.png)

Diccionario de Datos
----------------------

``` sql
-- Domingo Jul  9 18:27:04 2017
-- Model: modelo    Version: 1.0

-- -----------------------------------------------------
-- DB unidbcentral
-- -----------------------------------------------------
-- base de datos central que ejecuta la aplicacion cliente

-- -----------------------------------------------------
-- DB unidbcliente
-- -----------------------------------------------------
-- base de datos del lado de cada maquina que ejecuta la aplicacion cliente

-- NOTA: para usar en SQLITE remover "COMMENT" ya que no lo soporta, solo pasar el DB unidbgestioncurso
CREATE SCHEMA IF NOT EXISTS `unidbgestioncurso` DEFAULT CHARACTER SET utf8 
-- para trabajo local/desconectado la db unidbgestioncurso se copia una parte a cada maquina, de manera opcional (para futuro)

-- -----------------------------------------------------
-- Table `unidbgestioncurso`.`adm_juridico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unidbgestioncurso`.`adm_juridico` ;

CREATE TABLE IF NOT EXISTS `unidbgestioncurso`.`adm_juridico` (
  `cod_juridico` VARCHAR(40) NOT NULL COMMENT 'YYYYMMDDhhmmss id del ente juridico',
  `cod_rif` VARCHAR(40) NULL COMMENT 'rif de esta razon social',
  `des_razonsocial` VARCHAR(400) NULL COMMENT 'razon social o nombre de la empresa',
  `tipo_juridico` VARCHAR(40) NULL COMMENT 'NORMAL|ALIAS',
  `estado` VARCHAR(40) NULL COMMENT 'ACTIVO|CERRADO si cerrado debe tener fecha cerrado',
  `fecha_creado` VARCHAR(40) NULL COMMENT 'YYYYMMDD cuando abrio o empezo ser legal',
  `fecha_cerrado` VARCHAR(40) NULL COMMENT 'YYYYMMDD cuando cerro o dejo de funcionar',
  `sessionflag` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien altero este registro',
  `sessionficha` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien creo este registro',
  PRIMARY KEY (`cod_juridico`))
COMMENT = 'un ente juridico o personal de cada rif DATO SENSIBLE';


-- -----------------------------------------------------
-- Table `unidbgestioncurso`.`adm_entidad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unidbgestioncurso`.`adm_entidad` ;

CREATE TABLE IF NOT EXISTS `unidbgestioncurso`.`adm_entidad` (
  `cod_entidad` VARCHAR(40) NOT NULL COMMENT 'YYYYMMDDhhmmss',
  `cod_juridico` VARCHAR(40) NULL COMMENT 'codigo razon social que la representa',
  `cod_reservado1` VARCHAR(40) NULL,
  `cod_reservado2` VARCHAR(40) NULL DEFAULT NULL,
  `cod_reservado3` VARCHAR(40) NULL,
  `cod_reservado4` VARCHAR(40) NULL,
  `abr_zona` VARCHAR(40) NULL COMMENT 'siglas de la zona del pais de esta entidad',
  `abr_entidad` VARCHAR(40) NULL COMMENT 'abrebiacion de esta entidad',
  `des_entidad` VARCHAR(400) NOT NULL COMMENT 'descripcion s sucursal inces',
  `estado` VARCHAR(40) NOT NULL DEFAULT 'SUSPENDIDA' COMMENT 'ACTIVA|INACTIVA|CERRADA|SUSPENDIDA',
  `tipo_entidad` VARCHAR(40) NOT NULL DEFAULT 'OFICINA' COMMENT 'OFICINA|DEPARTAMENTO|AULA',
  `clase_entidad` VARCHAR(40) NOT NULL DEFAULT 'NORMAL' COMMENT 'INTERNA|NORMAL|EXTERNA',
  `num_telefonofijo` VARCHAR(40) NULL COMMENT 'Numero telefono fijo',
  `num_extension` VARCHAR(40) NULL,
  `num_celularfijo` VARCHAR(40) NULL COMMENT 'Numero telefono celular asignado por la empresa si aplica',
  `usr_encargado1` VARCHAR(40) NULL COMMENT 'usuario encargado o gerente de esta entidad',
  `usr_encargado2` VARCHAR(40) NULL COMMENT 'usuario subgerente o segundo encargado',
  `usr_encargado3` VARCHAR(40) NULL COMMENT 'usuario codigo tercer encargado',
  `fecha_encargado1` VARCHAR(40) NULL COMMENT 'YYYYMMDD fecha llegada actual gerente encargado 1',
  `fecha_encargado2` VARCHAR(40) NULL COMMENT 'YYYYMMDD fecha llegada asignacion actual subgerente o encargado 2',
  `fecha_encargado3` VARCHAR(40) NULL COMMENT 'YYYYMMDD fecha llegada asignacion actual jefe personal',
  `fecha_inventario` VARCHAR(40) NULL COMMENT 'YYYYMMDD fecha ultimo inventario',
  `cod_patrimonio` VARCHAR(40) NULL COMMENT 'id de patrimonio edificio o estructura que la representa si aplica',
  `sessionflag` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien altero este registro',
  `sessionficha` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien creo este registro por primera vez',
  PRIMARY KEY (`cod_entidad`))
COMMENT = 'cada instituto, departamento o aula es una entidad, diferenciada por el tipo y la clase';


-- -----------------------------------------------------
-- Table `unidbgestioncurso`.`adm_entidad_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unidbgestioncurso`.`adm_entidad_usuario` ;

CREATE TABLE IF NOT EXISTS `unidbgestioncurso`.`adm_entidad_usuario` (
  `cod_entidad` VARCHAR(40) NOT NULL COMMENT 'entidad asociado',
  `cod_usuario` VARCHAR(40) NOT NULL COMMENT 'usuario que operara en dicha entidad',
  `sessionflag` VARCHAR(40) NULL DEFAULT NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien altero este registro',
  `sessionficha` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien creo este registro',
  PRIMARY KEY (`cod_entidad`, `cod_usuario`))
COMMENT = 'relacion usuario y EN QUE ENTIDAD cumple funciones';


-- -----------------------------------------------------
-- Table `unidbgestioncurso`.`adm_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unidbgestioncurso`.`adm_usuario` ;

CREATE TABLE IF NOT EXISTS `unidbgestioncurso`.`adm_usuario` (
  `cod_usuario` VARCHAR(40) NOT NULL COMMENT 'id usuario, cedula en vnzla',
  `intranet` VARCHAR(40) NULL COMMENT 'login del usuario, id del correo sin el dominio',
  `clave` VARCHAR(40) NULL DEFAULT NULL COMMENT 'clave de intranet',
  `realm` VARCHAR(400) NULL DEFAULT NULL COMMENT 'campo usado para lighty mod_auth_mysql',
  `nombre` VARCHAR(400) NULL DEFAULT NULL COMMENT 'nombre y apellido',
  `origen` VARCHAR(40) NULL,
  `condicion` VARCHAR(400) NULL DEFAULT 'BASE' COMMENT 'CASA|BASE|EXTER',
  `estado` VARCHAR(40) NOT NULL DEFAULT 'INACTIVO' COMMENT 'ACTIVO|INACTIVO|SUSPENDIDO',
  `tipo_usuario` VARCHAR(40) NULL DEFAULT 'ALUMNO' COMMENT 'ALUMNO|ADMINISTRATIVO',
  `foto_binario` TEXT NULL DEFAULT NULL COMMENT 'encode64 de la foto para no tener en filesystem',
  `foto_usuario` VARCHAR(40) NULL COMMENT 'ruta de la foto en el filesystem',
  `fecha_ingreso` VARCHAR(40) NULL DEFAULT NULL COMMENT 'YYYYMMDD fecha que ingreso a operar/trabajar/asistir',
  `fecha_ultimavez` VARCHAR(40) NULL DEFAULT NULL COMMENT 'YYYYMMDD ultimo registro de sesion',
  `fecha_egreso` VARCHAR(40) NULL DEFAULT NULL COMMENT 'YYYYMMDD fecha que dejo de operar para siempre',
  `sessionflag` VARCHAR(40) NULL DEFAULT NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien altero este registro',
  `sessionficha` VARCHAR(40) NULL DEFAULT NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien creo este registro',
  PRIMARY KEY (`cod_usuario`))
COMMENT = 'tabla principal usuarios, sean alumnos o docentes u administrativos';


-- -----------------------------------------------------
-- Table `unidbgestioncurso`.`adm_perfil`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unidbgestioncurso`.`adm_perfil` ;

CREATE TABLE IF NOT EXISTS `unidbgestioncurso`.`adm_perfil` (
  `cod_perfil` VARCHAR(40) NOT NULL COMMENT 'nombre codigo de este perfil',
  `cod_controlador` VARCHAR(40) NOT NULL COMMENT 'archivo o codigo que accede',
  `cod_aplicacion` VARCHAR(40) NOT NULL COMMENT 'nombre del sistema que accede',
  `des_perfil` VARCHAR(40) NULL DEFAULT NULL COMMENT 'descripcion del perfil',
  `sessionflag` VARCHAR(40) NULL DEFAULT NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien altero este registro',
  `sesionficha` VARCHAR(40) NULL DEFAULT NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien creo este registro',
  PRIMARY KEY (`cod_perfil`, `cod_controlador`, `cod_aplicacion`))
COMMENT = 'perfiles y que sistema accede, para futuro uso';


-- -----------------------------------------------------
-- Table `unidbgestioncurso`.`adm_localidad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unidbgestioncurso`.`adm_localidad` ;

CREATE TABLE IF NOT EXISTS `unidbgestioncurso`.`adm_localidad` (
  `cod_localidad` VARCHAR(40) NOT NULL COMMENT 'codigo de esta ubicacion',
  `des_localidad` VARCHAR(200) NULL COMMENT 'nobre de la ciudad, campo, casa o ubicacion',
  `des_direccion` VARCHAR(400) NULL COMMENT 'detalles de este sitio, direccion completa',
  `tipo_localidad` VARCHAR(40) NULL COMMENT 'NORMAL|ESPECIAL',
  `estado` VARCHAR(40) NULL COMMENT 'ACTIVA|PERDIDA',
  `sessionflag` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien altero este registro',
  `sessionficha` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien creo este registro',
  PRIMARY KEY (`cod_localidad`))
COMMENT = 'codigo de la ubicacion o sitio o localidad';


-- -----------------------------------------------------
-- Table `unidbgestioncurso`.`adm_entidad_localidad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unidbgestioncurso`.`adm_entidad_localidad` ;

CREATE TABLE IF NOT EXISTS `unidbgestioncurso`.`adm_entidad_localidad` (
  `cod_entidad` VARCHAR(40) NOT NULL COMMENT 'entidad que contiene la localidad (su sitio)',
  `cod_localidad` VARCHAR(40) NOT NULL COMMENT 'localidad de la entidad (el sitio)',
  `sessionflag` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien altero este registro',
  `sessionficha` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien creo este registro',
  PRIMARY KEY (`cod_entidad`, `cod_localidad`))
COMMENT = 'relacion localidad entidad EN DONDE OPERA FISICAMENTE';


-- -----------------------------------------------------
-- Table `unidbgestioncurso`.`adm_entidad_juridico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unidbgestioncurso`.`adm_entidad_juridico` ;

CREATE TABLE IF NOT EXISTS `unidbgestioncurso`.`adm_entidad_juridico` (
  `cod_entidad` VARCHAR(40) NOT NULL COMMENT 'codigo de la entidad cliente',
  `cod_juridico` VARCHAR(40) NOT NULL COMMENT 'codigo del rif juridico',
  `sessionflag` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien altero este registro',
  `sessionficha` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien creo este registro',
  PRIMARY KEY (`cod_juridico`, `cod_entidad`))
COMMENT = 'otros rif relacionados con la entidad o instituto';


-- -----------------------------------------------------
-- Table `unidbgestioncurso`.`adm_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unidbgestioncurso`.`adm_log` ;

CREATE TABLE IF NOT EXISTS `unidbgestioncurso`.`adm_log` (
  `cod_log` VARCHAR(40) NOT NULL COMMENT 'YYYYMMDDhhmmss . sello . intranet',
  `des_log` TEXT NULL COMMENT 'accion realizada o registro desde app',
  `ref_ip` VARCHAR(40) NULL COMMENT 'ip cliente',
  `ref_url` VARCHAR(40) NULL COMMENT 'url controlador o app que invoco',
  PRIMARY KEY (`cod_log`))
COMMENT = 'chismoso log para administrativo';


-- -----------------------------------------------------
-- Table `unidbgestioncurso`.`adm_patrimonio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unidbgestioncurso`.`adm_patrimonio` ;

CREATE TABLE IF NOT EXISTS `unidbgestioncurso`.`adm_patrimonio` (
  `cod_patrimonio` VARCHAR(40) NOT NULL COMMENT 'YYYYMMDDhhmmss id en el sistema del patrimonio',
  `cod_identificacion` VARCHAR(40) NULL DEFAULT NULL COMMENT 'placa o ayundamiento o serial o identificacion del patrimonio propio',
  `cod_reservado1` VARCHAR(40) NULL DEFAULT NULL,
  `cod_tipo` VARCHAR(40) NULL DEFAULT 'INMUEBLE' COMMENT 'INMUEBLE|AUTOMOVIL|AVION|BARCO|TERRENO|HERRAMIENTA|INSUMO',
  `cod_poliza` VARCHAR(40) NULL DEFAULT '99999998' COMMENT 'id codigo de la poliza que le cubre si aplica',
  `des_patrimonio` VARCHAR(400) NOT NULL COMMENT 'a:u m:i nombre nativo del patrimonio o descripcion',
  `cod_reponsable` VARCHAR(40) NULL DEFAULT NULL COMMENT 'usuario responsable si aplica',
  `cod_titulo` VARCHAR(40) NULL DEFAULT NULL COMMENT 'a:u identificador del dodumento de titularidad',
  `cod_juridico` VARCHAR(40) NULL DEFAULT NULL COMMENT 'razon social asociada a este patrimonio',
  `estado` VARCHAR(40) NOT NULL DEFAULT 'ACTIVO' COMMENT 'ACTIVO|INACTIVO',
  `cod_sencamer` VARCHAR(40) NULL DEFAULT NULL COMMENT 'si es un objeto importado, sencamer',
  `reservado1` VARCHAR(40) NULL DEFAULT NULL COMMENT 'a:m unidad de medida que mas se vente apare de las demas ver tabla talla',
  `reservado2` VARCHAR(40) NULL DEFAULT NULL,
  `fecha_patrimonio` VARCHAR(40) NULL DEFAULT NULL COMMENT 'anio del patrimonio o cuando se construyo',
  `fecha_acquirido` VARCHAR(40) NULL DEFAULT NULL COMMENT 'propiedad relacionada con entrada a puerto o en camion no a los almacenes',
  `fecha_inactivo` VARCHAR(40) NULL DEFAULT NULL COMMENT 'fecha que dejo de estar en la empresa',
  `sessionficha` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien altero este registro',
  `sessionflag` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien creo este registro',
  PRIMARY KEY (`cod_patrimonio`))
COMMENT = 'catalogo bienes FIJOS y sus caracteristicas actuales las caracteristicas acumulativas estan en las tablas relacionales';


-- -----------------------------------------------------
-- Table `unidbgestioncurso`.`adm_patrimonio_entidad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unidbgestioncurso`.`adm_patrimonio_entidad` ;

CREATE TABLE IF NOT EXISTS `unidbgestioncurso`.`adm_patrimonio_entidad` (
  `cod_relacion` VARCHAR(40) NOT NULL COMMENT 'usado como llave unicamente',
  `cod_patrimonio` VARCHAR(40) NULL COMMENT 'codigo patrimonio a relacionar',
  `cod_entidad` VARCHAR(40) NULL COMMENT 'codigo entidad relacionado',
  `sessionflag` VARCHAR(40) NOT NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien altero este registro',
  `sessionficha` VARCHAR(40) NOT NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien creo este registro',
  PRIMARY KEY (`cod_relacion`))
COMMENT = 'a que entidad/oficina/sucursal esta o se adjudica este patrimonio';


-- -----------------------------------------------------
-- Table `unidbgestioncurso`.`adm_poliza`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unidbgestioncurso`.`adm_poliza` ;

CREATE TABLE IF NOT EXISTS `unidbgestioncurso`.`adm_poliza` (
  `cod_poliza` VARCHAR(40) NOT NULL,
  `cod_patrimonio` VARCHAR(40) NULL COMMENT 'si aplica, el patrimonio/inventario al cual pertenece la poliza, es decir a una herramienta o un docente',
  `cod_usuario` VARCHAR(4000) NULL COMMENT 'extracto minimo del texto de la poliza si es necesario',
  `serial_poliza` VARCHAR(40) NULL COMMENT 'si aplica, el usuario/docente al cual pertenece la poliza, es decir a el personal inces',
  `pic_poliza` VARCHAR(40) NULL COMMENT 'escaneo del documento original URL en disco',
  `hex_poliza` VARCHAR(40) NULL COMMENT 'hex del escaneo o base64 del escaneo de la poliza',
  `fecha_activado` VARCHAR(40) NULL COMMENT 'fecha desde la cual es efectiva',
  `fecha_inactivo` VARCHAR(40) NULL COMMENT 'fecha hasta donde es efectiva',
  `fecha_reactivo` VARCHAR(40) NULL COMMENT 'ultima fecha de renovacion',
  `sessionflag` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien altero este registro',
  `sessionficha` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien creo este registro',
  PRIMARY KEY (`cod_poliza`))
COMMENT = 'polizas de los patrimonios o usuarios como los seguros DATO SENSIBLE';


-- -----------------------------------------------------
-- Table `unidbgestioncurso`.`adm_titulo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unidbgestioncurso`.`adm_titulo` ;

CREATE TABLE IF NOT EXISTS `unidbgestioncurso`.`adm_titulo` (
  `cod_titulo` VARCHAR(40) NOT NULL COMMENT 'YYYYMMDDhhmmss',
  `cod_patrimonio` VARCHAR(40) NULL COMMENT 'patrimonio al cual pertenece la poliza, tambien peude ser un producto como muebles',
  `serial_titulo` VARCHAR(40) NULL COMMENT 'numero unico del titulo en el documento',
  `des_titulo` VARCHAR(4000) NULL COMMENT 'extracto minimo del texto del titulo si es necesario',
  `pic_titulo` VARCHAR(40) NULL COMMENT 'escaneo del documento original URL en disco',
  `hex_titulo` VARCHAR(40) NULL COMMENT 'hex del escaneo o base64 del escaneo del titulo',
  `fecha_activado` VARCHAR(40) NULL COMMENT 'fecha desde la cual es efectiva',
  `fecha_inactivo` VARCHAR(40) NULL COMMENT 'fecha hasta donde es efectiva',
  `fecha_reactivo` VARCHAR(40) NULL COMMENT 'ultima fecha de renovacion',
  `sessionflag` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien altero este registro',
  `sessionficha` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien creo este registro',
  PRIMARY KEY (`cod_titulo`))
COMMENT = 'titulos de los patrimonios como los documentos';


-- -----------------------------------------------------
-- Table `unidbgestioncurso`.`adm_documento_donde`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unidbgestioncurso`.`adm_documento_donde` ;

CREATE TABLE IF NOT EXISTS `unidbgestioncurso`.`adm_documento_donde` (
  `cod_donde` VARCHAR(40) NOT NULL,
  `cod_documento` VARCHAR(40) NULL COMMENT 'codigo de titulo o poliza a ubicar',
  `cual_documento` VARCHAR(40) NOT NULL DEFAULT 'COPIA' COMMENT 'ORIGINAL|COPIA',
  `cod_entidad` VARCHAR(40) NULL COMMENT 'si esta en cual entidad',
  `cod_localidad` VARCHAR(40) NULL COMMENT 'si esta en cual localidad',
  `sessionficha` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien altero este registro',
  `sessionflag` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien creo este registro',
  PRIMARY KEY (`cod_donde`))
COMMENT = 'en que entidad o localidad esta el documento fisico no el escaneado';


-- -----------------------------------------------------
-- Table `unidbgestioncurso`.`adm_patrimonio_foto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unidbgestioncurso`.`adm_patrimonio_foto` ;

CREATE TABLE IF NOT EXISTS `unidbgestioncurso`.`adm_patrimonio_foto` (
  `cod_patrimoniofotos` VARCHAR(40) NOT NULL COMMENT 'usado como llave primaria',
  `cod_foto` VARCHAR(40) NOT NULL COMMENT 'YYYYMMDD',
  `cod_patrimonio` VARCHAR(40) NULL COMMENT 'patrimonio al cual se sube foto',
  `tipo_foto` VARCHAR(40) NULL DEFAULT 'SECUNDARIA' COMMENT 'PRINCIPAL|SECUNDARIA',
  `pic_foto` VARCHAR(40) NULL COMMENT 'url en disco de la foto',
  `hex_foto` VARCHAR(4000) NULL COMMENT 'base64 de la foto para cargar en db',
  `sessionficha` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien altero este registro',
  `sessionflag` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien creo este registro',
  PRIMARY KEY (`cod_patrimoniofotos`))
COMMENT = 'fotos a travez de los anios de los patrimonio';


-- -----------------------------------------------------
-- Table `unidbgestioncurso`.`adm_anuncios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unidbgestioncurso`.`adm_anuncios` ;

CREATE TABLE IF NOT EXISTS `unidbgestioncurso`.`adm_anuncios` (
  `cod_anuncio` VARCHAR(40) NOT NULL COMMENT 'YYYYMMDDHHMMSS id del anuncio, aqui es unico el codigo ya que es para las entidades',
  `cod_entidad` VARCHAR(40) NULL COMMENT 'id del centro ince o lugar en donde ejecuta el app',
  `des_anuncio` VARCHAR(400) NULL COMMENT 'titulo del anuncio',
  `det_anuncio` VARCHAR(1000) NULL COMMENT 'contenido completo del anuncio',
  `estado` VARCHAR(40) NULL DEFAULT 'PENDIENTE' COMMENT 'PUBLICADO|PENDIENTE|INVALIDO',
  `tipo_anuncio` VARCHAR(40) NOT NULL DEFAULT 'INTERNO' COMMENT 'PUBLICO|INTERNO|PRIVADO',
  `clase_anuncio` VARCHAR(40) NOT NULL DEFAULT 'NORMAL' COMMENT 'NORMAL|ADMINISTRATIVO',
  `sessionflag` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien altero este registro',
  `sessionficha` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien creo este registro',
  PRIMARY KEY (`cod_anuncio`))
COMMENT = 'datos de anuncios, se avisa como principal pivote de informacion, lado servidor central';


-- -----------------------------------------------------
-- Table `unidbgestioncurso`.`app_data_curso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unidbgestioncurso`.`app_data_curso` ;

CREATE TABLE IF NOT EXISTS `unidbgestioncurso`.`app_data_curso` (
  `cod_curso` VARCHAR(40) NOT NULL COMMENT 'CATYYYYMMDDhhmmss id del curso',
  `des_curso` VARCHAR(400) NOT NULL COMMENT 'descripcion o nombre curso',
  `tipo_curso` VARCHAR(40) NULL DEFAULT 'NORMAL' COMMENT 'ADMINISTRATIVO|NORMAL',
  `sessionficha` VARCHAR(40) NULL DEFAULT NULL COMMENT 'fecha creacion del curso',
  `sessionflag` VARCHAR(40) NULL DEFAULT NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien creo este registro',
  PRIMARY KEY (`cod_curso`))
COMMENT = 'calsificacion de los cursos si alguna';


-- -----------------------------------------------------
-- Table `unidbgestioncurso`.`app_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unidbgestioncurso`.`app_log` ;

CREATE TABLE IF NOT EXISTS `unidbgestioncurso`.`app_log` (
  `cod_log` CHAR(40) NOT NULL COMMENT 'YYYYMMDDhhmmss . entidad . usuario',
  `cod_entidad` VARCHAR(40) NOT NULL COMMENT 'id del centro ince o lugar en donde ejecuta el app',
  `cod_maquina` VARCHAR(40) NOT NULL COMMENT 'ip o id de la maquina cliente que ejecuta la app',
  `operacion` CHAR(40) NULL DEFAULT NULL COMMENT 'en que modulo controlador y que realizo... y que artefactos afecto o que fue lo que paso',
  `sessionficha` CHAR(40) NULL DEFAULT NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien creo este registro por primera vez',
  PRIMARY KEY (`cod_log`, `cod_entidad`, `cod_maquina`))
COMMENT = 'chismoso, log de aplicacion cada operacion se graba aqui';


-- -----------------------------------------------------
-- Table `unidbgestioncurso`.`app_registro_asistecia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unidbgestioncurso`.`app_registro_asistecia` ;

CREATE TABLE IF NOT EXISTS `unidbgestioncurso`.`app_registro_asistecia` (
  `cod_registro` VARCHAR(40) NOT NULL COMMENT 'YYYYMMDDhhmmss marca de tiempo del registro',
  `cod_entidad` VARCHAR(40) NOT NULL COMMENT 'id del centro ince o lugar en donde ejecuta el app',
  `cod_maquina` VARCHAR(40) NOT NULL COMMENT 'ip o id de la maquina cliente que ejecuta la app',
  `cod_usuario` VARCHAR(800) NOT NULL COMMENT 'id o cedula del usuario que coloca su asistencia',
  `sessionflag` VARCHAR(40) NULL DEFAULT NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien altero este registro',
  `sessionficha` VARCHAR(40) NULL DEFAULT NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien creo este registro por primera vez',
  PRIMARY KEY (`cod_registro`, `cod_entidad`, `cod_maquina`))
COMMENT = 'registros de marcas/movimiento asistencia de usuarios sea personal o alumno';


-- -----------------------------------------------------
-- Table `unidbgestioncurso`.`app_registro_curso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unidbgestioncurso`.`app_registro_curso` ;

CREATE TABLE IF NOT EXISTS `unidbgestioncurso`.`app_registro_curso` (
  `cod_registro` VARCHAR(40) NOT NULL COMMENT 'YYYYMMDDhhmmss usa fecha y hora',
  `cod_entidad` VARCHAR(40) NOT NULL COMMENT 'id del centro ince o lugar en donde ejecuta el app',
  `cod_maquina` VARCHAR(40) NOT NULL COMMENT 'ip o id de la maquina cliente que ejecuta la app',
  `cod_curso` VARCHAR(40) NULL DEFAULT NULL COMMENT 'sobre que curso aplica este registro si fuese',
  `cod_usuario` VARCHAR(40) NOT NULL COMMENT 'codigo id usuario que se califica',
  `mon_registro` DECIMAL(20,2) NOT NULL COMMENT 'anotacion si el usuario la amerida dicho dia negativa es hizo algo malo, positiva bueno',
  `des_registro` VARCHAR(800) NULL COMMENT 'observacion adicional',
  `tipo_registro` VARCHAR(40) NULL DEFAULT 'ALUMNADO' COMMENT 'ADMINISTRATIVO|NORMAL',
  `des_estado` VARCHAR(800) NULL DEFAULT NULL COMMENT 'porque cambio de estado amerita escribir porque',
  `estado` VARCHAR(40) NULL DEFAULT 'PENDIENTE' COMMENT 'REVISADO|PENDIENTE|INVALIDO',
  `documento` TEXT NULL DEFAULT NULL COMMENT 'documento anexar si este registro es un examen, etc',
  `fecha_usuario` VARCHAR(40) NULL DEFAULT NULL COMMENT 'YYYYMMDD de cuadno es esta anotacion',
  `fecha_registro` VARCHAR(40) NULL DEFAULT NULL COMMENT 'YYYYMMDD real de cuando se creo esta entrada',
  `sessionflag` VARCHAR(40) NULL DEFAULT NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien modifico este registro ultima vez',
  `sessionficha` VARCHAR(40) NULL DEFAULT NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien creo este registro por primera vez',
  PRIMARY KEY (`cod_registro`, `cod_entidad`, `cod_maquina`))
COMMENT = 'bitacora de cursos, en las horas, por descripcion, fecha y putuaciones';


-- -----------------------------------------------------
-- Table `unidbgestioncurso`.`app_anuncios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unidbgestioncurso`.`app_anuncios` ;

CREATE TABLE IF NOT EXISTS `unidbgestioncurso`.`app_anuncios` (
  `cod_anuncio` VARCHAR(40) NOT NULL COMMENT 'YYYYMMDDHHMMSS id del anuncio, aqui es unico el codigo ya que es para las entidades',
  `cod_entidad` VARCHAR(40) NULL COMMENT 'id del centro ince o lugar en donde ejecuta el app',
  `cod_maquina` VARCHAR(40) NULL,
  `des_anuncio` VARCHAR(400) NULL COMMENT 'titulo del anuncio',
  `det_anuncio` VARCHAR(1000) NULL COMMENT 'contenido completo del anuncio',
  `estado` VARCHAR(40) NULL DEFAULT 'PENDIENTE' COMMENT 'PUBLICADO|PENDIENTE|INVALIDO',
  `tipo_anuncio` VARCHAR(40) NOT NULL DEFAULT 'INTERNO' COMMENT 'PUBLICO|INTERNO|PRIVADO',
  `clase_anuncio` VARCHAR(40) NOT NULL DEFAULT 'NORMAL' COMMENT 'NORMAL|ADMINISTRATIVO',
  `sessionflag` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien altero este registro',
  `sessionficha` VARCHAR(40) NULL COMMENT 'si es un anuncio especifico quien lo podra ver',
  PRIMARY KEY (`cod_anuncio`))
COMMENT = 'datos de anuncios, se avisa como principal pivote de informacion,lado de aplicacion cliente';
```

