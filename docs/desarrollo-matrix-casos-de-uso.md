 --- [HOME](README.md) --- [FOTOS](READMEFOTOS.md) --- [DISEÑO](READMEDISENO.md) ---


Matrix Casos de uso Generales
=============================

Documento original: [documentos/desarrollo-matrix-casos-de-uso.ods](documentos/desarrollo-matrix-casos-de-uso.ods)

| CASO DE USO General         | Actor                            | Modulo    | Descripcion del C.U         | 
| --------------------------- | -------------------------------- | --------- | --------------------------- | 
| CU-0A. Inicio y parametros  | Secretaria, Docente, Coordinador | programa  | Lanzar la aplicación, esta emitira un mensage en la parte inferior si inicio correctamente, configuro los parametros y se conecto a la base de datos. | 
| CU-00. Validar Usuario      | Secretaria, Docente, Coordinador | programa  | Permitirá ingresar al sistema con usuario y clave de acuerdo al cargo especificado (administrador, coordinador y docente) | 
| CU-01. Permisos/accesos     | Secretaria, Docente, Coordinador | programa  | Mostrara la pantalla principal y los menus/modulos según elperfil/acceso de cada actor/usuario | 
| CU-02. Gestionar Usuarios   | Secretaria, Coordinador          | entidades | Alterar las caracteristicas de los usuarios,s ya inscritos, asociacion con el curso respectivo según la inscripcion. | 
| CU-03. Gestionar Cursos     | Secretaria, Coordinador          | entidades | Definir los cursos, publicar los nuevos, cerrar los culminados etc. | 
| CU-04. Gestionar Docentes   | Secretaria, Coordinador          | entidades | Alterar las caracteristicas de los usuarios, asociar docente con su curso que impartira/respectivo. | 
| CU-05. Nuevo Participante   | Secretaria, Coordinador          | procesos  | Registra un futuro alumno en el sistema para despues se le asocie un curso y se le registre asistencias al el mismo | 
| CU-06. Registrar asistencia | Docente                          | procesos  | Registra una asistencia por dia de cada uno de los participantes | 
| CU-07. Registrar incidencia | Docente                          | procesos  | Permitira que el coordinador consulte el listado de alumnos aprobados y reprobados. | 
| CU-08. Retirar participante | Secretaria, Coordinador          | procesos  | Retira y marca como no participante un usuario sin eliminarlo del sistema, dejando historico. | 
| CU-09. Emitir Certificado   | Secretaria                       | procesos  | Permite marcar al participante como certificado del curso que se le impartio, se define los datos y se guarda el documento, mas no se imprime aun. | 
| CU-10. Imprimir Certificado | Coordinador                      | procesos  | Permitirá validar y generar el certificado de oficio de alumnos aprobados. | 
| CU-11. Generar reportes     | Secretaria, Coordinador          | reportes  | Ver reportes de las acciones y procesos según el perfil | 
| CU-12. Estadisticas         | Secretaria, Docente, Coordinador | reportes  | Ver mini reportes y numeros estadisticos según el perfil | 


Matrix Casos de uso Especificos
-------------------------------

En el Documento: [documentos/desarrollo-matrix-casos-de-uso.ods](documentos/desarrollo-matrix-casos-de-uso.ods)


## Vea tambien:

 --- [HOME](README.md) --- [FOTOS](READMEFOTOS.md) --- [DISEÑO](READMEDISENO.md) ---
