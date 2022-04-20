CREATE SCHEMA IF NOT EXISTS residencia_academia;

CREATE  TABLE residencia_academia.atividade ( 
	id_atividade         serial  NOT NULL  ,
	nome                 varchar(255)    ,
	CONSTRAINT pk_atividade PRIMARY KEY ( id_atividade )
 );

CREATE  TABLE residencia_academia.tel_instrutor ( 
	id_tel_instrutor     serial  NOT NULL  ,
	numero               integer    ,
	tipo                 varchar(45)    ,
	fk_id_instrutor      integer    ,
	CONSTRAINT pk_tel_instrutor PRIMARY KEY ( id_tel_instrutor )
 );

CREATE  TABLE residencia_academia.turma ( 
	id_turma             serial  NOT NULL  ,
	horario              timestamp    ,
	duracao              integer    ,
	data_inicio          timestamp    ,
	data_fim             timestamp    ,
	fk_id_atividade      integer    ,
	fk_id_instrutor      integer    ,
	CONSTRAINT pk_turma PRIMARY KEY ( id_turma ),
	CONSTRAINT turma_rel_atividade FOREIGN KEY ( fk_id_atividade ) REFERENCES residencia_academia.atividade( id_atividade ) ON DELETE RESTRICT ON UPDATE RESTRICT 
 );

CREATE  TABLE residencia_academia.aluno ( 
	id_aluno             serial  NOT NULL  ,
	nome                 varchar(255)    ,
	data_matricula       timestamp    ,
	endereco             varchar(255)    ,
	telefone             varchar(25)    ,
	data_nascimento      timestamp    ,
	altura               numeric(1,2)    ,
	peso                 numeric(3,2)    ,
	fk_id_turma          integer    ,
	CONSTRAINT unq_aluno_id_aluno UNIQUE ( id_aluno ) ,
	CONSTRAINT pk_aluno PRIMARY KEY ( id_aluno ),
	CONSTRAINT aluno_monitora_turma FOREIGN KEY ( fk_id_turma ) REFERENCES residencia_academia.turma( id_turma ) ON DELETE RESTRICT ON UPDATE RESTRICT 
 );

CREATE  TABLE residencia_academia.instrutor ( 
	id_instrutor         serial  NOT NULL  ,
	rg                   integer    ,
	nome                 varchar(255)    ,
	nascimento           timestamp    ,
	CONSTRAINT pk_instrutor PRIMARY KEY ( id_instrutor ),
	CONSTRAINT instrutor_rel_tel_instrutor FOREIGN KEY ( id_instrutor ) REFERENCES residencia_academia.tel_instrutor( fk_id_instrutor ) ON DELETE RESTRICT ON UPDATE RESTRICT ,
	CONSTRAINT instrutor_rel_turma FOREIGN KEY ( id_instrutor ) REFERENCES residencia_academia.turma( fk_id_instrutor ) ON DELETE RESTRICT ON UPDATE RESTRICT 
 );

CREATE  TABLE residencia_academia.matricula ( 
	id_matricula         serial  NOT NULL  ,
	fk_id_turma          integer    ,
	fk_id_aluno          integer    ,
	CONSTRAINT pk_matricula PRIMARY KEY ( id_matricula ),
	CONSTRAINT matricula_rel_aluno FOREIGN KEY ( fk_id_aluno ) REFERENCES residencia_academia.aluno( id_aluno ) ON DELETE RESTRICT ON UPDATE RESTRICT ,
	CONSTRAINT matricula_rel_turma FOREIGN KEY ( fk_id_turma ) REFERENCES residencia_academia.turma( id_turma ) ON DELETE RESTRICT ON UPDATE RESTRICT 
 );

CREATE  TABLE residencia_academia.controle_presenca ( 
	id_controle_presenca serial  NOT NULL  ,
	data_aula            timestamp    ,
	presenca             boolean    ,
	fk_id_matricula      integer    ,
	CONSTRAINT pk_controle_presenca PRIMARY KEY ( id_controle_presenca ),
	CONSTRAINT controle_presenca_rel_matricula FOREIGN KEY ( fk_id_matricula ) REFERENCES residencia_academia.matricula( id_matricula ) ON DELETE RESTRICT ON UPDATE RESTRICT 
 );
