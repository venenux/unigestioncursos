-- 2017 07 14
-- Model: unigestiondb    Version: 1.1.3

-- -----------------------------------------------------
-- DB unigestiondb
-- -----------------------------------------------------
-- base de datos central que ejecuta la aplicacion cliente

-- -----------------------------------------------------
-- DB unidbcliente
-- -----------------------------------------------------
-- base de datos del lado de cada maquina que ejecuta la aplicacion cliente
-- el cliente puede tener desconectado una db local en ram/sqlite
-- solo copiar las tablas usuario, localidad y relacion usuario_localidad/usuario_acc
-- las tablas que altera solo son las app_xxxx y despues inserta todos los registros 
-- al terminar insertar en db central borra su db local para reconectar/salir

-- NOTA: para usar en SQLITE remover "COMMENT" ya que no lo soporta, solo pasar el DB
CREATE SCHEMA IF NOT EXISTS `unigestiondb` DEFAULT CHARACTER SET utf8;
USE `unigestiondb`;
-- para trabajo local/desconectado la db unidbgestioncurso se copia una parte a cada 


BEGIN;



-- -----------------------------------------------------
-- Table `adm_juridico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `adm_juridico` ;

CREATE TABLE IF NOT EXISTS `adm_juridico` (
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
-- Table `adm_entidad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `adm_entidad` ;

CREATE TABLE IF NOT EXISTS `adm_entidad` (
  `cod_entidad` VARCHAR(40) NOT NULL COMMENT 'YYYYMMDDhhmmss',
  `cod_juridico` VARCHAR(40) NULL COMMENT 'codigo razon social que la representa',
  `cod_reservado1` VARCHAR(40) NULL,
  `cod_reservado2` VARCHAR(40) NULL DEFAULT NULL,
  `cod_reservado3` VARCHAR(40) NULL,
  `cod_reservado4` VARCHAR(40) NULL,
  `cod_localidad` VARCHAR(40) NULL COMMENT 'siglas de la zona del pais de esta entidad',
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
COMMENT = 'cada instituto, departamento o aula es una entidad, diferenciada por el tipo y la clase'
;


-- -----------------------------------------------------
-- Table `adm_entidad_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `adm_entidad_usuario` ;

CREATE TABLE IF NOT EXISTS `adm_entidad_usuario` (
  `cod_entidad` VARCHAR(40) NOT NULL COMMENT 'entidad asociado',
  `cod_usuario` VARCHAR(40) NOT NULL COMMENT 'usuario que operara en dicha entidad',
  `sessionflag` VARCHAR(40) NULL DEFAULT NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien altero este registro',
  `sessionficha` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien creo este registro',
  PRIMARY KEY (`cod_entidad`, `cod_usuario`))
COMMENT = 'relacion usuario y EN QUE ENTIDAD cumple funciones';


-- -----------------------------------------------------
-- Table `adm_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `adm_usuario` ;

CREATE TABLE IF NOT EXISTS `adm_usuario` (
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
COMMENT = 'tabla principal usuarios, sean alumnos o docentes u administrativos'
;


-- -----------------------------------------------------
-- Table `adm_perfil`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `adm_perfil` ;

CREATE TABLE IF NOT EXISTS `adm_perfil` (
  `cod_perfil` VARCHAR(40) NOT NULL COMMENT 'nombre codigo de este perfil',
  `cod_controlador` VARCHAR(40) NOT NULL COMMENT 'archivo o codigo que accede',
  `cod_aplicacion` VARCHAR(40) NOT NULL COMMENT 'nombre del sistema que accede',
  `des_perfil` VARCHAR(40) NULL DEFAULT NULL COMMENT 'descripcion del perfil',
  `sessionflag` VARCHAR(40) NULL DEFAULT NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien altero este registro',
  `sesionficha` VARCHAR(40) NULL DEFAULT NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien creo este registro',
  PRIMARY KEY (`cod_perfil`, `cod_controlador`, `cod_aplicacion`))
COMMENT = 'perfiles y que sistema accede, para futuro uso';


-- -----------------------------------------------------
-- Table `adm_localidad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `adm_localidad` ;

CREATE TABLE IF NOT EXISTS `adm_localidad` (
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
-- Table `adm_entidad_localidad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `adm_entidad_localidad` ;

CREATE TABLE IF NOT EXISTS `adm_entidad_localidad` (
  `cod_entidad` VARCHAR(40) NOT NULL COMMENT 'entidad que contiene la localidad (su sitio)',
  `cod_localidad` VARCHAR(40) NOT NULL COMMENT 'localidad de la entidad (el sitio)',
  `sessionflag` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien altero este registro',
  `sessionficha` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien creo este registro',
  PRIMARY KEY (`cod_entidad`, `cod_localidad`))
COMMENT = 'relacion localidad entidad EN DONDE OPERA FISICAMENTE';


-- -----------------------------------------------------
-- Table `adm_entidad_juridico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `adm_entidad_juridico` ;

CREATE TABLE IF NOT EXISTS `adm_entidad_juridico` (
  `cod_entidad` VARCHAR(40) NOT NULL COMMENT 'codigo de la entidad cliente',
  `cod_juridico` VARCHAR(40) NOT NULL COMMENT 'codigo del rif juridico',
  `sessionflag` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien altero este registro',
  `sessionficha` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien creo este registro',
  PRIMARY KEY (`cod_juridico`, `cod_entidad`))
COMMENT = 'otros rif relacionados con la entidad o instituto';


-- -----------------------------------------------------
-- Table `adm_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `adm_log` ;

CREATE TABLE IF NOT EXISTS `adm_log` (
  `cod_log` VARCHAR(40) NOT NULL COMMENT 'YYYYMMDDhhmmss . sello . intranet',
  `des_log` TEXT NULL COMMENT 'accion realizada o registro desde app',
  `ref_ip` VARCHAR(40) NULL COMMENT 'ip cliente',
  `ref_url` VARCHAR(40) NULL COMMENT 'url controlador o app que invoco',
  PRIMARY KEY (`cod_log`))
COMMENT = 'chismoso log para administrativo';


-- -----------------------------------------------------
-- Table `inv_patrimonio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inv_patrimonio` ;

CREATE TABLE IF NOT EXISTS `inv_patrimonio` (
  `cod_patrimonio` VARCHAR(40) NOT NULL COMMENT 'YYYYMMDDhhmmss id en el sistema del patrimonio',
  `cod_reservado1` VARCHAR(40) NULL DEFAULT NULL,
  `cod_identificacion` VARCHAR(40) NULL DEFAULT NULL COMMENT 'placa o ayundamiento o serial o identificacion del patrimonio propio',
  `cod_tipo` VARCHAR(40) NULL DEFAULT 'INMUEBLE' COMMENT 'INMUEBLE|AUTOMOVIL|AVION|BARCO|TERRENO|HERRAMIENTA|INSUMO',
  `cod_poliza` VARCHAR(40) NULL DEFAULT '99999998' COMMENT 'id codigo de la poliza que le cubre si aplica',
  `des_patrimonio` VARCHAR(400) NOT NULL COMMENT 'a:u m:i nombre nativo del patrimonio o descripcion',
  `cod_reponsable` VARCHAR(40) NULL DEFAULT NULL COMMENT 'usuario responsable si aplica',
  `cod_titulo` VARCHAR(40) NULL DEFAULT NULL COMMENT 'a:u identificador del dodumento de titularidad',
  `cod_juridico` VARCHAR(40) NULL DEFAULT NULL COMMENT 'razon social asociada a este patrimonio',
  `estado` VARCHAR(40) NOT NULL DEFAULT 'ACTIVO' COMMENT 'ACTIVO|INACTIVO',
  `cod_sencamer` VARCHAR(40) NULL DEFAULT NULL COMMENT 'si es un objeto importado, sencamer',
  `foto1` TEXT NULL DEFAULT NULL COMMENT 'foto principal del patrimonio o bien',
  `foto2` TEXT NULL DEFAULT NULL COMMENT 'foto secundaria',
  `fecha_patrimonio` VARCHAR(40) NULL DEFAULT NULL COMMENT 'anio del patrimonio o cuando se construyo',
  `fecha_acquirido` VARCHAR(40) NULL DEFAULT NULL COMMENT 'propiedad relacionada con entrada a puerto o en camion no a los almacenes',
  `fecha_inactivo` VARCHAR(40) NULL DEFAULT NULL COMMENT 'fecha que dejo de estar en la empresa',
  `sessionficha` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien altero este registro',
  `sessionflag` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien creo este registro',
  PRIMARY KEY (`cod_patrimonio`))
COMMENT = 'catalogo bienes FIJOS y sus caracteristicas actuales las caracteristicas acumulativas estan en las tablas relacionales'
;


-- -----------------------------------------------------
-- Table `inv_patrimonio_entidad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inv_patrimonio_entidad` ;

CREATE TABLE IF NOT EXISTS `inv_patrimonio_entidad` (
  `cod_relacion` VARCHAR(40) NOT NULL COMMENT 'usado como llave unicamente',
  `cod_patrimonio` VARCHAR(40) NULL COMMENT 'codigo patrimonio a relacionar',
  `cod_entidad` VARCHAR(40) NULL COMMENT 'codigo entidad relacionado',
  `sessionflag` VARCHAR(40) NOT NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien altero este registro',
  `sessionficha` VARCHAR(40) NOT NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien creo este registro',
  PRIMARY KEY (`cod_relacion`))
COMMENT = 'a que entidad/oficina/sucursal esta o se adjudica este patrimonio'
;


-- -----------------------------------------------------
-- Table `adm_poliza`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `adm_poliza` ;

CREATE TABLE IF NOT EXISTS `adm_poliza` (
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
COMMENT = 'polizas de los patrimonios o usuarios como los seguros DATO SENSIBLE'
;


-- -----------------------------------------------------
-- Table `adm_documento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `adm_documento` ;

CREATE TABLE IF NOT EXISTS `adm_documento` (
  `cod_documento` VARCHAR(40) NOT NULL COMMENT 'YYYYMMDDhhmmss',
  `cod_juridico` VARCHAR(40) NULL COMMENT 'ente juridico que avala el documento, no el que esta en el',
  `serial_titulo` VARCHAR(40) NULL COMMENT 'numero unico del titulo en el documento',
  `des_titulo` VARCHAR(4000) NULL COMMENT 'extracto minimo del texto del titulo si es necesario',
  `pic_titulo` VARCHAR(400) NULL COMMENT 'escaneo del documento original URL en disco',
  `hex_titulo` TEXT NULL COMMENT 'hex del escaneo o base64 del escaneo del titulo',
  `fecha_activado` VARCHAR(40) NULL COMMENT 'fecha desde la cual es efectiva',
  `fecha_inactivo` VARCHAR(40) NULL COMMENT 'fecha hasta donde es efectiva',
  `fecha_reactivo` VARCHAR(40) NULL COMMENT 'ultima fecha de renovacion',
  `sessionflag` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien altero este registro',
  `sessionficha` VARCHAR(40) NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien creo este registro',
  PRIMARY KEY (`cod_documento`))
COMMENT = 'titulos, certificados, documentos legales, usados sea como final de curso o como titulo de patrimonio'
;


-- -----------------------------------------------------
-- Table `adm_anuncios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `adm_anuncios` ;

CREATE TABLE IF NOT EXISTS `adm_anuncios` (
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
COMMENT = 'datos de anuncios, se avisa como principal pivote de informacion, lado servidor central'
;


-- -----------------------------------------------------
-- Table `app_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `app_log` ;

CREATE TABLE IF NOT EXISTS `app_log` (
  `cod_log` CHAR(40) NOT NULL COMMENT 'YYYYMMDDhhmmss . entidad . usuario',
  `cod_entidad` VARCHAR(40) NOT NULL COMMENT 'id del centro ince o lugar en donde ejecuta el app',
  `cod_maquina` VARCHAR(40) NOT NULL COMMENT 'ip o id de la maquina cliente que ejecuta la app',
  `operacion` CHAR(40) NULL DEFAULT NULL COMMENT 'en que modulo controlador y que realizo... y que artefactos afecto o que fue lo que paso',
  `sessionficha` CHAR(40) NULL DEFAULT NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien creo este registro por primera vez',
  PRIMARY KEY (`cod_log`, `cod_entidad`, `cod_maquina`))
COMMENT = 'chismoso, log de aplicacion cada operacion se graba aqui';


-- -----------------------------------------------------
-- Table `app_data_curso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `app_data_curso` ;

CREATE TABLE IF NOT EXISTS `app_data_curso` (
  `cod_curso` VARCHAR(40) NOT NULL COMMENT 'CATYYYYMMDDhhmmss id del curso',
  `des_curso` VARCHAR(400) NOT NULL COMMENT 'descripcion o nombre curso',
  `tipo_curso` VARCHAR(40) NULL DEFAULT 'NORMAL' COMMENT 'ADMINISTRATIVO|NORMAL',
  `sessionficha` VARCHAR(40) NULL DEFAULT NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien creo este curso',
  `sessionflag` VARCHAR(40) NULL DEFAULT NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien creo este registro',
  PRIMARY KEY (`cod_curso`))
COMMENT = 'calsificacion de los cursos si alguna';


-- -----------------------------------------------------
-- Table `app_registro_asistecia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `app_registro_asistecia` ;

CREATE TABLE IF NOT EXISTS `app_registro_asistecia` (
  `cod_registro` VARCHAR(40) NOT NULL COMMENT 'YYYYMMDDhhmmss marca de tiempo del registro',
  `cod_entidad` VARCHAR(40) NOT NULL COMMENT 'id del centro ince o lugar en donde ejecuta el app',
  `cod_maquina` VARCHAR(40) NOT NULL COMMENT 'ip o id de la maquina cliente que ejecuta la app',
  `cod_usuario` VARCHAR(800) NOT NULL COMMENT 'id o cedula del usuario que coloca su asistencia',
  `sessionflag` VARCHAR(40) NULL DEFAULT NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien altero este registro',
  `sessionficha` VARCHAR(40) NULL DEFAULT NULL COMMENT 'YYYYMMDDhhmmss + entidad + . + usuario : quien creo este registro por primera vez',
  PRIMARY KEY (`cod_registro`, `cod_entidad`, `cod_maquina`))
COMMENT = 'registros de marcas/movimiento asistencia de usuarios sea personal o alumno'
;


-- -----------------------------------------------------
-- Table `app_registro_curso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `app_registro_curso` ;

CREATE TABLE IF NOT EXISTS `app_registro_curso` (
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
COMMENT = 'bitacora de cursos, en las horas, por descripcion, fecha y putuaciones'
;


-- -----------------------------------------------------
-- Table `ent_anuncios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ent_anuncios` ;

CREATE TABLE IF NOT EXISTS `ent_anuncios` (
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
COMMENT = 'datos de anuncios, se avisa como principal pivote de informacion, lado del aplicativo'
;

COMMIT;

-- -----------------------------------------------------
-- Data for table `adm_entidad`
-- -----------------------------------------------------
BEGIN;

INSERT INTO `adm_entidad` (`cod_entidad`, `cod_juridico`, `cod_reservado1`, `cod_reservado2`, `cod_reservado3`, `cod_reservado4`, `cod_localidad`, `abr_entidad`, `des_entidad`, `estado`, `tipo_entidad`, `clase_entidad`, `num_telefonofijo`, `num_extension`, `num_celularfijo`, `usr_encargado1`, `usr_encargado2`, `usr_encargado3`, `fecha_encargado1`, `fecha_encargado2`, `fecha_encargado3`, `fecha_inventario`, `cod_patrimonio`, `sessionflag`, `sessionficha`) VALUES ('000', '', NULL, NULL, NULL, NULL, '20170000000001', 'SYS', 'Desarrolldores sede virtual', 'ACTIVO', 'AULA', 'EXTERNO', 'NULL', 'NULL', 'NULL', 'NULL', 'NULL', NULL, NULL, NULL, NULL, NULL, NULL, '20170212182001usuariocodentidad.usuarioi', '20170101000000inicial.admin');
INSERT INTO `adm_entidad` (`cod_entidad`, `cod_juridico`, `cod_reservado1`, `cod_reservado2`, `cod_reservado3`, `cod_reservado4`, `cod_localidad`, `abr_entidad`, `des_entidad`, `estado`, `tipo_entidad`, `clase_entidad`, `num_telefonofijo`, `num_extension`, `num_celularfijo`, `usr_encargado1`, `usr_encargado2`, `usr_encargado3`, `fecha_encargado1`, `fecha_encargado2`, `fecha_encargado3`, `fecha_inventario`, `cod_patrimonio`, `sessionflag`, `sessionficha`) VALUES ('001', '', NULL, NULL, NULL, NULL, '20170000000001', 'RUI', 'Inces Los ruices', 'ACTIVO', 'OFICINA', 'NORMAL', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, '20170212182101usuariocodentidad.usuarioi', '20170101000000inicial.admin');
INSERT INTO `adm_entidad` (`cod_entidad`, `cod_juridico`, `cod_reservado1`, `cod_reservado2`, `cod_reservado3`, `cod_reservado4`, `cod_localidad`, `abr_entidad`, `des_entidad`, `estado`, `tipo_entidad`, `clase_entidad`, `num_telefonofijo`, `num_extension`, `num_celularfijo`, `usr_encargado1`, `usr_encargado2`, `usr_encargado3`, `fecha_encargado1`, `fecha_encargado2`, `fecha_encargado3`, `fecha_inventario`, `cod_patrimonio`, `sessionflag`, `sessionficha`) VALUES ('002', '', NULL, NULL, NULL, NULL, '20170000000002', 'TEQ', 'Ince Los teques', 'ACTIVO', 'OFICINA', 'NORMAL', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, '20170212192001usuariocodentidad.usuarioi', '20170101000000inicial.admin');

COMMIT;


-- -----------------------------------------------------
-- Data for table `adm_entidad_usuario`
-- -----------------------------------------------------
BEGIN;
INSERT INTO `adm_entidad_usuario` (`cod_entidad`, `cod_usuario`, `sessionflag`, `sessionficha`) VALUES ('000', '99999990', NULL, NULL);
INSERT INTO `adm_entidad_usuario` (`cod_entidad`, `cod_usuario`, `sessionflag`, `sessionficha`) VALUES ('001', '99999990', NULL, NULL);
INSERT INTO `adm_entidad_usuario` (`cod_entidad`, `cod_usuario`, `sessionflag`, `sessionficha`) VALUES ('001', '99999980', NULL, NULL);
INSERT INTO `adm_entidad_usuario` (`cod_entidad`, `cod_usuario`, `sessionflag`, `sessionficha`) VALUES ('002', '99999980', NULL, NULL);
INSERT INTO `adm_entidad_usuario` (`cod_entidad`, `cod_usuario`, `sessionflag`, `sessionficha`) VALUES ('001', '99999910', NULL, NULL);
INSERT INTO `adm_entidad_usuario` (`cod_entidad`, `cod_usuario`, `sessionflag`, `sessionficha`) VALUES ('001', '99999920', NULL, NULL);
INSERT INTO `adm_entidad_usuario` (`cod_entidad`, `cod_usuario`, `sessionflag`, `sessionficha`) VALUES ('002', '99999990', NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `adm_usuario`
-- -----------------------------------------------------
BEGIN;
INSERT INTO `adm_usuario` (`cod_usuario`, `intranet`, `clave`, `realm`, `nombre`, `origen`, `condicion`, `estado`, `tipo_usuario`, `foto_binario`, `foto_usuario`, `fecha_ingreso`, `fecha_ultimavez`, `fecha_egreso`, `sessionflag`, `sessionficha`) VALUES ('99999990', 'admin', 'c4ca4238a0b923820dcc509a6f75849b', 'NULL', 'Administrador sistema', NULL, 'clave md5 (1)', 'ACTIVO', 'ADMINISTRATIVO', 'NULL', NULL, '20170101000000inicial.admin', 'NULL', NULL, 'NULL', '20170101000000inicial.admin');
INSERT INTO `adm_usuario` (`cod_usuario`, `intranet`, `clave`, `realm`, `nombre`, `origen`, `condicion`, `estado`, `tipo_usuario`, `foto_binario`, `foto_usuario`, `fecha_ingreso`, `fecha_ultimavez`, `fecha_egreso`, `sessionflag`, `sessionficha`) VALUES ('99999980', 'direccion', 'c4ca4238a0b923820dcc509a6f75849b', NULL, 'Gerencia direccion', NULL, 'BASE', 'ACTIVO', 'ADMINISTRATIVO', NULL, NULL, '20170101000000inicial.admin', NULL, NULL, '20170101000000inicial.admin', '20170101000000inicial.admin');
INSERT INTO `adm_usuario` (`cod_usuario`, `intranet`, `clave`, `realm`, `nombre`, `origen`, `condicion`, `estado`, `tipo_usuario`, `foto_binario`, `foto_usuario`, `fecha_ingreso`, `fecha_ultimavez`, `fecha_egreso`, `sessionflag`, `sessionficha`) VALUES ('99999910', 'alumno1', 'c4ca4238a0b923820dcc509a6f75849b', NULL, 'Direnzano julio', 'CARAPITA', 'BASE', 'ACTIVO', 'ADMINISTRATIVO', NULL, NULL, '20170101010000inicial.admin', NULL, NULL, NULL, '20170101000000inicial.admin');
INSERT INTO `adm_usuario` (`cod_usuario`, `intranet`, `clave`, `realm`, `nombre`, `origen`, `condicion`, `estado`, `tipo_usuario`, `foto_binario`, `foto_usuario`, `fecha_ingreso`, `fecha_ultimavez`, `fecha_egreso`, `sessionflag`, `sessionficha`) VALUES ('99999920', 'alumno2', 'c4ca4238a0b923820dcc509a6f75849b', NULL, 'Perenzano angel', 'CARICUAO', 'BASE', 'ACTIVO', 'ADMINISTRATIVO', NULL, NULL, '20170101020000inicial.admin', NULL, NULL, '20170101000000inicial.admin', '20170101000000inicial.admin');

COMMIT;


-- -----------------------------------------------------
-- Data for table `adm_localidad`
-- -----------------------------------------------------
BEGIN;
INSERT INTO `adm_localidad` (`cod_localidad`, `des_localidad`, `des_direccion`, `tipo_localidad`, `estado`, `sessionflag`, `sessionficha`) VALUES ('20170000000001', 'OP CAP', 'Oficina Principal Caracas av xxx cruze calle', 'ADMINISTRATIVA', 'ACTIVO', 'NULL', 'NULL');
INSERT INTO `adm_localidad` (`cod_localidad`, `des_localidad`, `des_direccion`, `tipo_localidad`, `estado`, `sessionflag`, `sessionficha`) VALUES ('20170000000002', 'OP TEQ', 'Los teques centro', 'ADMINISTRATIVA', 'ACTIVA', 'NULL', 'NULL');
INSERT INTO `adm_localidad` (`cod_localidad`, `des_localidad`, `des_direccion`, `tipo_localidad`, `estado`, `sessionflag`, `sessionficha`) VALUES ('20170000000003', 'OP Ruices', 'Zona Industrial al lado metro', 'ADMINISTRATIVA', 'ACTIVO', 'NULL', 'NULL');

COMMIT;


-- -----------------------------------------------------
-- Data for table `adm_entidad_localidad`
-- -----------------------------------------------------
BEGIN;
INSERT INTO `adm_entidad_localidad` (`cod_entidad`, `cod_localidad`, `sessionflag`, `sessionficha`) VALUES ('000', '20170000000001', NULL, NULL);
INSERT INTO `adm_entidad_localidad` (`cod_entidad`, `cod_localidad`, `sessionflag`, `sessionficha`) VALUES ('002', '20170000000002', NULL, NULL);
INSERT INTO `adm_entidad_localidad` (`cod_entidad`, `cod_localidad`, `sessionflag`, `sessionficha`) VALUES ('001', '20170000000003', NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `ent_anuncios`
-- -----------------------------------------------------
BEGIN;
INSERT INTO `ent_anuncios` (`cod_anuncio`, `cod_entidad`, `cod_maquina`, `des_anuncio`, `det_anuncio`, `estado`, `tipo_anuncio`, `clase_anuncio`, `sessionflag`, `sessionficha`) VALUES ('20000000000000', NULL, NULL, 'Bienvenido', 'Buenas, este es el programa de gestion de cursos', 'PUBLICADO', 'INTERNO', 'NORMAL', '20170101000000inicial.admin', '20170101000000inicial.admin');

COMMIT;

