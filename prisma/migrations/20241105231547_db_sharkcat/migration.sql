-- CreateTable
CREATE TABLE "admin" (
    "idAdmin" SERIAL NOT NULL,
    "correo" VARCHAR(100) NOT NULL,
    "contrasenia" VARCHAR(255) NOT NULL,
    "idNombre" INTEGER NOT NULL,

    CONSTRAINT "admin_pkey" PRIMARY KEY ("idAdmin")
);

-- CreateTable
CREATE TABLE "categoria" (
    "idCategoria" SERIAL NOT NULL,
    "categoria" VARCHAR(150) NOT NULL,
    "imgCategoria" VARCHAR(255),

    CONSTRAINT "categoria_pkey" PRIMARY KEY ("idCategoria")
);

-- CreateTable
CREATE TABLE "comentario" (
    "idComentario" SERIAL NOT NULL,
    "idUsuarioComenta" INTEGER NOT NULL,
    "idUsuarioRecibeComentario" INTEGER NOT NULL,
    "comentario" TEXT NOT NULL,

    CONSTRAINT "comentario_pkey" PRIMARY KEY ("idComentario")
);

-- CreateTable
CREATE TABLE "conocimiento" (
    "idConocimiento" SERIAL NOT NULL,
    "idUsuario" INTEGER NOT NULL,
    "idInstitucion" INTEGER NOT NULL,
    "tituloAcademico" VARCHAR(255) NOT NULL,
    "fechaEgreso" DATE NOT NULL,

    CONSTRAINT "conocimiento_pkey" PRIMARY KEY ("idConocimiento")
);

-- CreateTable
CREATE TABLE "estadoOfertaSolucion" (
    "idEstadoOferta" SERIAL NOT NULL,
    "estadoOferta" VARCHAR(100),

    CONSTRAINT "estadoOfertaSolucion_pkey" PRIMARY KEY ("idEstadoOferta")
);

-- CreateTable
CREATE TABLE "estadoPregunta" (
    "idEstadoPregunta" SERIAL NOT NULL,
    "estadoPregunta" VARCHAR(100) NOT NULL,

    CONSTRAINT "estadoPregunta_pkey" PRIMARY KEY ("idEstadoPregunta")
);

-- CreateTable
CREATE TABLE "experiencia" (
    "idExperiencia" SERIAL NOT NULL,
    "idUsuario" INTEGER NOT NULL,
    "idPuesto" INTEGER NOT NULL,
    "empresa" VARCHAR(150) NOT NULL,
    "fechaInicio" DATE NOT NULL,
    "fechaFin" DATE NOT NULL,
    "descripcion" VARCHAR(255) NOT NULL,

    CONSTRAINT "experiencia_pkey" PRIMARY KEY ("idExperiencia")
);

-- CreateTable
CREATE TABLE "imgpregunta" (
    "idImg" SERIAL NOT NULL,
    "idPregunta" INTEGER NOT NULL,
    "img" VARCHAR(255) NOT NULL,

    CONSTRAINT "imgpregunta_pkey" PRIMARY KEY ("idImg")
);

-- CreateTable
CREATE TABLE "institucion" (
    "idInstitucion" SERIAL NOT NULL,
    "institucion" VARCHAR(255) NOT NULL,

    CONSTRAINT "institucion_pkey" PRIMARY KEY ("idInstitucion")
);

-- CreateTable
CREATE TABLE "interes_pupilo" (
    "idInteres" SERIAL NOT NULL,
    "idUsuario" INTEGER NOT NULL,
    "idMateria" INTEGER NOT NULL,

    CONSTRAINT "interes_pupilo_pkey" PRIMARY KEY ("idInteres")
);

-- CreateTable
CREATE TABLE "materia" (
    "idMateria" SERIAL NOT NULL,
    "idCategoria" INTEGER NOT NULL,
    "materia" VARCHAR(150) NOT NULL,
    "imgMateria" VARCHAR(255),

    CONSTRAINT "materia_pkey" PRIMARY KEY ("idMateria")
);

-- CreateTable
CREATE TABLE "materia_tutor" (
    "idInteresTutor" SERIAL NOT NULL,
    "idUsuario" INTEGER NOT NULL,
    "idMateria" INTEGER NOT NULL,

    CONSTRAINT "materia_tutor_pkey" PRIMARY KEY ("idInteresTutor")
);

-- CreateTable
CREATE TABLE "nombre" (
    "idNombre" SERIAL NOT NULL,
    "primerNombre" VARCHAR(255) NOT NULL,
    "segundoNombre" VARCHAR(150),
    "primerApellido" VARCHAR(150) NOT NULL,
    "segundoApellido" VARCHAR(150),

    CONSTRAINT "nombre_pkey" PRIMARY KEY ("idNombre")
);

-- CreateTable
CREATE TABLE "ofertaresolucion" (
    "idOferta" SERIAL NOT NULL,
    "idUsuarioTutor" INTEGER NOT NULL,
    "idPregunta" INTEGER NOT NULL,
    "idEstadoOferta" INTEGER NOT NULL,
    "descripcion" TEXT NOT NULL,
    "fechaOferta" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "ofertaresolucion_pkey" PRIMARY KEY ("idOferta")
);

-- CreateTable
CREATE TABLE "pregunta" (
    "idPregunta" SERIAL NOT NULL,
    "idMateria" INTEGER NOT NULL,
    "idUsuarioPupilo" INTEGER NOT NULL,
    "titulo" VARCHAR(150) NOT NULL,
    "descripcion" TEXT NOT NULL,
    "idEstadoPregunta" INTEGER NOT NULL,
    "fechaPublicacion" TIMESTAMPTZ(6),

    CONSTRAINT "pregunta_pkey" PRIMARY KEY ("idPregunta")
);

-- CreateTable
CREATE TABLE "puesto" (
    "idPuesto" SERIAL NOT NULL,
    "puesto" VARCHAR(100) NOT NULL,

    CONSTRAINT "puesto_pkey" PRIMARY KEY ("idPuesto")
);

-- CreateTable
CREATE TABLE "rol" (
    "idRol" SERIAL NOT NULL,
    "rol" VARCHAR(150) NOT NULL,

    CONSTRAINT "rol_pkey" PRIMARY KEY ("idRol")
);

-- CreateTable
CREATE TABLE "usuario" (
    "idUsuario" SERIAL NOT NULL,
    "idRol" INTEGER NOT NULL,
    "idNombre" INTEGER NOT NULL,
    "edad" INTEGER NOT NULL,
    "correo" VARCHAR(150) NOT NULL,
    "contrasenia" VARCHAR(255) NOT NULL,
    "dni" VARCHAR(60) NOT NULL,
    "telefono" VARCHAR(50) NOT NULL,
    "valoracion" DOUBLE PRECISION NOT NULL,
    "fotoPerfil" VARCHAR(255),
    "horarioDisponibleInicio" TIME(6) NOT NULL,
    "horarioDisponibleFin" TIME(6) NOT NULL,
    "isverified" BOOLEAN NOT NULL,
    "verificationcode" VARCHAR(30),
    "verificationexpiry" TIMESTAMPTZ(6),

    CONSTRAINT "usuario_pkey" PRIMARY KEY ("idUsuario")
);

-- CreateIndex
CREATE UNIQUE INDEX "unique_usuario_materia" ON "interes_pupilo"("idUsuario", "idMateria");

-- CreateIndex
CREATE UNIQUE INDEX "usuario_correo_key" ON "usuario"("correo");

-- AddForeignKey
ALTER TABLE "admin" ADD CONSTRAINT "admin_idnombre_foreign" FOREIGN KEY ("idNombre") REFERENCES "nombre"("idNombre") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "comentario" ADD CONSTRAINT "comentario_idusuariocomenta_foreign" FOREIGN KEY ("idUsuarioComenta") REFERENCES "usuario"("idUsuario") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "comentario" ADD CONSTRAINT "comentario_idusuariorecibecomentario_foreign" FOREIGN KEY ("idUsuarioRecibeComentario") REFERENCES "usuario"("idUsuario") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "conocimiento" ADD CONSTRAINT "conocimiento_idinstitucion_foreign" FOREIGN KEY ("idInstitucion") REFERENCES "institucion"("idInstitucion") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "conocimiento" ADD CONSTRAINT "conocimiento_idusuario_foreign" FOREIGN KEY ("idUsuario") REFERENCES "usuario"("idUsuario") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "experiencia" ADD CONSTRAINT "experiencia_idpuesto_foreign" FOREIGN KEY ("idPuesto") REFERENCES "puesto"("idPuesto") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "experiencia" ADD CONSTRAINT "experiencia_idusuario_foreign" FOREIGN KEY ("idUsuario") REFERENCES "usuario"("idUsuario") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "imgpregunta" ADD CONSTRAINT "imgpregunta_idpregunta_foreign" FOREIGN KEY ("idPregunta") REFERENCES "pregunta"("idPregunta") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "interes_pupilo" ADD CONSTRAINT "interes_pupilo_idmateria_foreign" FOREIGN KEY ("idMateria") REFERENCES "materia"("idMateria") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "interes_pupilo" ADD CONSTRAINT "interes_pupilo_idusuario_foreign" FOREIGN KEY ("idUsuario") REFERENCES "usuario"("idUsuario") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "materia" ADD CONSTRAINT "materia_idcategoria_foreign" FOREIGN KEY ("idCategoria") REFERENCES "categoria"("idCategoria") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "materia_tutor" ADD CONSTRAINT "materia_tutor_idmateria_foreign" FOREIGN KEY ("idMateria") REFERENCES "materia"("idMateria") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "materia_tutor" ADD CONSTRAINT "materia_tutor_idusuario_foreign" FOREIGN KEY ("idUsuario") REFERENCES "usuario"("idUsuario") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "ofertaresolucion" ADD CONSTRAINT "ofertaresolucion_idestadooferta_foreign" FOREIGN KEY ("idEstadoOferta") REFERENCES "estadoOfertaSolucion"("idEstadoOferta") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "ofertaresolucion" ADD CONSTRAINT "ofertaresolucion_idpregunta_foreign" FOREIGN KEY ("idPregunta") REFERENCES "pregunta"("idPregunta") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "ofertaresolucion" ADD CONSTRAINT "ofertaresolucion_idusuariotutor_foreign" FOREIGN KEY ("idUsuarioTutor") REFERENCES "usuario"("idUsuario") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "pregunta" ADD CONSTRAINT "pregunta_idestadopregunta_foreign" FOREIGN KEY ("idEstadoPregunta") REFERENCES "estadoPregunta"("idEstadoPregunta") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "pregunta" ADD CONSTRAINT "pregunta_idmateria_foreign" FOREIGN KEY ("idMateria") REFERENCES "materia"("idMateria") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "pregunta" ADD CONSTRAINT "pregunta_idusuariopupilo_foreign" FOREIGN KEY ("idUsuarioPupilo") REFERENCES "usuario"("idUsuario") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "usuario" ADD CONSTRAINT "usuario_idnombre_foreign" FOREIGN KEY ("idNombre") REFERENCES "nombre"("idNombre") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "usuario" ADD CONSTRAINT "usuario_idrol_foreign" FOREIGN KEY ("idRol") REFERENCES "rol"("idRol") ON DELETE NO ACTION ON UPDATE NO ACTION;
