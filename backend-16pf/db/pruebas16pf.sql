--
-- PostgreSQL database dump
--

\restrict 8XyGHpfbsd6eGxgSYM6Ufwu0GHpHYuXs4asmQU4rX1gYm9nw2r4H0912kvT53Qk

-- Dumped from database version 15.14 (Debian 15.14-1.pgdg13+1)
-- Dumped by pg_dump version 16.10 (Ubuntu 16.10-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pruebas16pf; Type: SCHEMA; Schema: -; Owner: ats_n8n
--

CREATE SCHEMA pruebas16pf;


ALTER SCHEMA pruebas16pf OWNER TO ats_n8n;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: aspirantes; Type: TABLE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE TABLE pruebas16pf.aspirantes (
    id integer NOT NULL,
    cedula character varying(20) NOT NULL,
    nombre character varying(150) NOT NULL,
    correo character varying(150) NOT NULL,
    edad integer,
    sexo character varying(10),
    escolaridad character varying(100),
    cargo_aplicado integer NOT NULL,
    creado_en timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    contrasena text NOT NULL,
    actualizado_en timestamp without time zone,
    estado_prueba character varying(20) DEFAULT 'en_progreso'::character varying,
    reporte_pdf text,
    CONSTRAINT aspirantes_edad_check CHECK ((edad >= 0)),
    CONSTRAINT aspirantes_sexo_check CHECK (((sexo)::text = ANY (ARRAY[('M'::character varying)::text, ('F'::character varying)::text])))
);


ALTER TABLE pruebas16pf.aspirantes OWNER TO ats_n8n;

--
-- Name: aspirantes_id_seq; Type: SEQUENCE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE SEQUENCE pruebas16pf.aspirantes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pruebas16pf.aspirantes_id_seq OWNER TO ats_n8n;

--
-- Name: aspirantes_id_seq; Type: SEQUENCE OWNED BY; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER SEQUENCE pruebas16pf.aspirantes_id_seq OWNED BY pruebas16pf.aspirantes.id;


--
-- Name: baremos_16pf; Type: TABLE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE TABLE pruebas16pf.baremos_16pf (
    id integer NOT NULL,
    factor_id character varying(5) NOT NULL,
    sexo character(1) NOT NULL,
    puntaje_bruto integer NOT NULL,
    decatipo integer NOT NULL,
    CONSTRAINT baremos_16pf_sexo_check CHECK ((sexo = ANY (ARRAY['M'::bpchar, 'F'::bpchar])))
);


ALTER TABLE pruebas16pf.baremos_16pf OWNER TO ats_n8n;

--
-- Name: baremos_16pf_id_seq; Type: SEQUENCE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE SEQUENCE pruebas16pf.baremos_16pf_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pruebas16pf.baremos_16pf_id_seq OWNER TO ats_n8n;

--
-- Name: baremos_16pf_id_seq; Type: SEQUENCE OWNED BY; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER SEQUENCE pruebas16pf.baremos_16pf_id_seq OWNED BY pruebas16pf.baremos_16pf.id;


--
-- Name: cargo_requisitos; Type: TABLE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE TABLE pruebas16pf.cargo_requisitos (
    id integer NOT NULL,
    cargo_id integer NOT NULL,
    requisito_id integer NOT NULL,
    date timestamp without time zone
);


ALTER TABLE pruebas16pf.cargo_requisitos OWNER TO ats_n8n;

--
-- Name: cargo_requisitos_id_seq; Type: SEQUENCE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE SEQUENCE pruebas16pf.cargo_requisitos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pruebas16pf.cargo_requisitos_id_seq OWNER TO ats_n8n;

--
-- Name: cargo_requisitos_id_seq; Type: SEQUENCE OWNED BY; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER SEQUENCE pruebas16pf.cargo_requisitos_id_seq OWNED BY pruebas16pf.cargo_requisitos.id;


--
-- Name: cargos; Type: TABLE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE TABLE pruebas16pf.cargos (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text,
    activo boolean DEFAULT true,
    creado_en timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE pruebas16pf.cargos OWNER TO ats_n8n;

--
-- Name: cargos_id_seq; Type: SEQUENCE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE SEQUENCE pruebas16pf.cargos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pruebas16pf.cargos_id_seq OWNER TO ats_n8n;

--
-- Name: cargos_id_seq; Type: SEQUENCE OWNED BY; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER SEQUENCE pruebas16pf.cargos_id_seq OWNED BY pruebas16pf.cargos.id;


--
-- Name: citas_agendadas; Type: TABLE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE TABLE pruebas16pf.citas_agendadas (
    id integer NOT NULL,
    horario_id integer NOT NULL,
    nombre_candidato character varying(150) NOT NULL,
    telefono_candidato character varying(50) NOT NULL,
    estado character varying(50) DEFAULT 'Confirmada'::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE pruebas16pf.citas_agendadas OWNER TO ats_n8n;

--
-- Name: citas_agendadas_id_seq; Type: SEQUENCE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE SEQUENCE pruebas16pf.citas_agendadas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pruebas16pf.citas_agendadas_id_seq OWNER TO ats_n8n;

--
-- Name: citas_agendadas_id_seq; Type: SEQUENCE OWNED BY; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER SEQUENCE pruebas16pf.citas_agendadas_id_seq OWNED BY pruebas16pf.citas_agendadas.id;


--
-- Name: clave_detalle_16pf; Type: TABLE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE TABLE pruebas16pf.clave_detalle_16pf (
    id integer NOT NULL,
    numero_pregunta integer NOT NULL,
    factor character varying(5) NOT NULL,
    opcion character(1) NOT NULL,
    puntaje integer DEFAULT 0 NOT NULL
);


ALTER TABLE pruebas16pf.clave_detalle_16pf OWNER TO ats_n8n;

--
-- Name: clave_detalle_16pf_id_seq; Type: SEQUENCE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE SEQUENCE pruebas16pf.clave_detalle_16pf_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pruebas16pf.clave_detalle_16pf_id_seq OWNER TO ats_n8n;

--
-- Name: clave_detalle_16pf_id_seq; Type: SEQUENCE OWNED BY; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER SEQUENCE pruebas16pf.clave_detalle_16pf_id_seq OWNED BY pruebas16pf.clave_detalle_16pf.id;


--
-- Name: consumos_ia; Type: TABLE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE TABLE pruebas16pf.consumos_ia (
    id integer NOT NULL,
    interpretacion_id integer,
    tokens_entrada integer NOT NULL,
    tokens_salida integer NOT NULL,
    generado_en timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE pruebas16pf.consumos_ia OWNER TO ats_n8n;

--
-- Name: consumos_ia_id_seq; Type: SEQUENCE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE SEQUENCE pruebas16pf.consumos_ia_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pruebas16pf.consumos_ia_id_seq OWNER TO ats_n8n;

--
-- Name: consumos_ia_id_seq; Type: SEQUENCE OWNED BY; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER SEQUENCE pruebas16pf.consumos_ia_id_seq OWNED BY pruebas16pf.consumos_ia.id;


--
-- Name: factores_16pf; Type: TABLE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE TABLE pruebas16pf.factores_16pf (
    codigo character varying(2) NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text
);


ALTER TABLE pruebas16pf.factores_16pf OWNER TO ats_n8n;

--
-- Name: horarios_disponibles; Type: TABLE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE TABLE pruebas16pf.horarios_disponibles (
    id integer NOT NULL,
    fecha date NOT NULL,
    hora time without time zone NOT NULL,
    cupos_maximos integer DEFAULT 3 NOT NULL,
    cupos_ocupados integer DEFAULT 0 NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE pruebas16pf.horarios_disponibles OWNER TO ats_n8n;

--
-- Name: horarios_disponibles_id_seq; Type: SEQUENCE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE SEQUENCE pruebas16pf.horarios_disponibles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pruebas16pf.horarios_disponibles_id_seq OWNER TO ats_n8n;

--
-- Name: horarios_disponibles_id_seq; Type: SEQUENCE OWNED BY; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER SEQUENCE pruebas16pf.horarios_disponibles_id_seq OWNED BY pruebas16pf.horarios_disponibles.id;


--
-- Name: interpretaciones_16pf; Type: TABLE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE TABLE pruebas16pf.interpretaciones_16pf (
    id integer NOT NULL,
    factor character varying(5) NOT NULL,
    nivel character varying(10) NOT NULL,
    descripcion text NOT NULL
);


ALTER TABLE pruebas16pf.interpretaciones_16pf OWNER TO ats_n8n;

--
-- Name: interpretaciones_16pf_id_seq; Type: SEQUENCE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE SEQUENCE pruebas16pf.interpretaciones_16pf_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pruebas16pf.interpretaciones_16pf_id_seq OWNER TO ats_n8n;

--
-- Name: interpretaciones_16pf_id_seq; Type: SEQUENCE OWNED BY; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER SEQUENCE pruebas16pf.interpretaciones_16pf_id_seq OWNED BY pruebas16pf.interpretaciones_16pf.id;


--
-- Name: interpretaciones_ia; Type: TABLE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE TABLE pruebas16pf.interpretaciones_ia (
    id integer NOT NULL,
    aspirante_id integer NOT NULL,
    texto_generado text NOT NULL,
    generado_en timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fuente_modelo character varying(50) NOT NULL
);


ALTER TABLE pruebas16pf.interpretaciones_ia OWNER TO ats_n8n;

--
-- Name: interpretacions_ia_id_seq; Type: SEQUENCE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE SEQUENCE pruebas16pf.interpretacions_ia_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pruebas16pf.interpretacions_ia_id_seq OWNER TO ats_n8n;

--
-- Name: interpretacions_ia_id_seq; Type: SEQUENCE OWNED BY; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER SEQUENCE pruebas16pf.interpretacions_ia_id_seq OWNED BY pruebas16pf.interpretaciones_ia.id;


--
-- Name: invitaciones_pendientes; Type: TABLE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE TABLE pruebas16pf.invitaciones_pendientes (
    telefono_whatsapp character varying(50) NOT NULL,
    nombre_candidato character varying(150) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    selected_horario_id integer
);


ALTER TABLE pruebas16pf.invitaciones_pendientes OWNER TO ats_n8n;

--
-- Name: preguntas_16pf; Type: TABLE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE TABLE pruebas16pf.preguntas_16pf (
    numero integer NOT NULL,
    texto character varying(500) NOT NULL,
    opcion_a character varying(255) NOT NULL,
    opcion_b character varying(255) NOT NULL,
    opcion_c character varying(255)
);


ALTER TABLE pruebas16pf.preguntas_16pf OWNER TO ats_n8n;

--
-- Name: reglas_decatipo_16pf; Type: TABLE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE TABLE pruebas16pf.reglas_decatipo_16pf (
    factor_codigo character varying(5) NOT NULL,
    regla character varying(50) NOT NULL
);


ALTER TABLE pruebas16pf.reglas_decatipo_16pf OWNER TO ats_n8n;

--
-- Name: requisitos; Type: TABLE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE TABLE pruebas16pf.requisitos (
    id integer NOT NULL,
    nombre character varying(255) NOT NULL,
    date timestamp without time zone
);


ALTER TABLE pruebas16pf.requisitos OWNER TO ats_n8n;

--
-- Name: requisitos_id_seq; Type: SEQUENCE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE SEQUENCE pruebas16pf.requisitos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pruebas16pf.requisitos_id_seq OWNER TO ats_n8n;

--
-- Name: requisitos_id_seq; Type: SEQUENCE OWNED BY; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER SEQUENCE pruebas16pf.requisitos_id_seq OWNED BY pruebas16pf.requisitos.id;


--
-- Name: respuestas_16pf; Type: TABLE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE TABLE pruebas16pf.respuestas_16pf (
    id integer NOT NULL,
    aspirante_id integer NOT NULL,
    numero_pregunta integer NOT NULL,
    respuesta character varying(1) NOT NULL,
    CONSTRAINT respuestas_16pf_numero_pregunta_check CHECK (((numero_pregunta >= 1) AND (numero_pregunta <= 187))),
    CONSTRAINT respuestas_16pf_respuesta_check CHECK (((respuesta)::text = ANY (ARRAY[('A'::character varying)::text, ('B'::character varying)::text, ('C'::character varying)::text])))
);


ALTER TABLE pruebas16pf.respuestas_16pf OWNER TO ats_n8n;

--
-- Name: respuestas_16pf_id_seq; Type: SEQUENCE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE SEQUENCE pruebas16pf.respuestas_16pf_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pruebas16pf.respuestas_16pf_id_seq OWNER TO ats_n8n;

--
-- Name: respuestas_16pf_id_seq; Type: SEQUENCE OWNED BY; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER SEQUENCE pruebas16pf.respuestas_16pf_id_seq OWNED BY pruebas16pf.respuestas_16pf.id;


--
-- Name: resultados_16pf; Type: TABLE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE TABLE pruebas16pf.resultados_16pf (
    id integer NOT NULL,
    aspirante_id integer NOT NULL,
    factor character varying(5) NOT NULL,
    puntaje_total integer NOT NULL,
    decatipo integer NOT NULL,
    porcentaje numeric(5,2),
    nivel character varying(10),
    interpretacion text,
    descripcion_factor character varying(255)
);


ALTER TABLE pruebas16pf.resultados_16pf OWNER TO ats_n8n;

--
-- Name: resultados_16pf_id_seq; Type: SEQUENCE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE SEQUENCE pruebas16pf.resultados_16pf_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pruebas16pf.resultados_16pf_id_seq OWNER TO ats_n8n;

--
-- Name: resultados_16pf_id_seq; Type: SEQUENCE OWNED BY; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER SEQUENCE pruebas16pf.resultados_16pf_id_seq OWNED BY pruebas16pf.resultados_16pf.id;


--
-- Name: usuarios; Type: TABLE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE TABLE pruebas16pf.usuarios (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    correo character varying(150) NOT NULL,
    contrasena character varying(255) NOT NULL,
    rol character varying(50) NOT NULL,
    creado_en timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    activo boolean DEFAULT true
);


ALTER TABLE pruebas16pf.usuarios OWNER TO ats_n8n;

--
-- Name: usuarios_aspirantes; Type: TABLE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE TABLE pruebas16pf.usuarios_aspirantes (
    id integer NOT NULL,
    usuario_id integer NOT NULL,
    aspirante_id integer NOT NULL,
    creado_en timestamp without time zone DEFAULT now()
);


ALTER TABLE pruebas16pf.usuarios_aspirantes OWNER TO ats_n8n;

--
-- Name: usuarios_aspirantes_id_seq; Type: SEQUENCE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE SEQUENCE pruebas16pf.usuarios_aspirantes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pruebas16pf.usuarios_aspirantes_id_seq OWNER TO ats_n8n;

--
-- Name: usuarios_aspirantes_id_seq; Type: SEQUENCE OWNED BY; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER SEQUENCE pruebas16pf.usuarios_aspirantes_id_seq OWNED BY pruebas16pf.usuarios_aspirantes.id;


--
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE SEQUENCE pruebas16pf.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pruebas16pf.usuarios_id_seq OWNER TO ats_n8n;

--
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER SEQUENCE pruebas16pf.usuarios_id_seq OWNED BY pruebas16pf.usuarios.id;


--
-- Name: aspirantes id; Type: DEFAULT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.aspirantes ALTER COLUMN id SET DEFAULT nextval('pruebas16pf.aspirantes_id_seq'::regclass);


--
-- Name: baremos_16pf id; Type: DEFAULT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.baremos_16pf ALTER COLUMN id SET DEFAULT nextval('pruebas16pf.baremos_16pf_id_seq'::regclass);


--
-- Name: cargo_requisitos id; Type: DEFAULT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.cargo_requisitos ALTER COLUMN id SET DEFAULT nextval('pruebas16pf.cargo_requisitos_id_seq'::regclass);


--
-- Name: cargos id; Type: DEFAULT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.cargos ALTER COLUMN id SET DEFAULT nextval('pruebas16pf.cargos_id_seq'::regclass);


--
-- Name: citas_agendadas id; Type: DEFAULT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.citas_agendadas ALTER COLUMN id SET DEFAULT nextval('pruebas16pf.citas_agendadas_id_seq'::regclass);


--
-- Name: clave_detalle_16pf id; Type: DEFAULT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.clave_detalle_16pf ALTER COLUMN id SET DEFAULT nextval('pruebas16pf.clave_detalle_16pf_id_seq'::regclass);


--
-- Name: consumos_ia id; Type: DEFAULT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.consumos_ia ALTER COLUMN id SET DEFAULT nextval('pruebas16pf.consumos_ia_id_seq'::regclass);


--
-- Name: horarios_disponibles id; Type: DEFAULT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.horarios_disponibles ALTER COLUMN id SET DEFAULT nextval('pruebas16pf.horarios_disponibles_id_seq'::regclass);


--
-- Name: interpretaciones_16pf id; Type: DEFAULT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.interpretaciones_16pf ALTER COLUMN id SET DEFAULT nextval('pruebas16pf.interpretaciones_16pf_id_seq'::regclass);


--
-- Name: interpretaciones_ia id; Type: DEFAULT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.interpretaciones_ia ALTER COLUMN id SET DEFAULT nextval('pruebas16pf.interpretacions_ia_id_seq'::regclass);


--
-- Name: requisitos id; Type: DEFAULT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.requisitos ALTER COLUMN id SET DEFAULT nextval('pruebas16pf.requisitos_id_seq'::regclass);


--
-- Name: respuestas_16pf id; Type: DEFAULT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.respuestas_16pf ALTER COLUMN id SET DEFAULT nextval('pruebas16pf.respuestas_16pf_id_seq'::regclass);


--
-- Name: resultados_16pf id; Type: DEFAULT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.resultados_16pf ALTER COLUMN id SET DEFAULT nextval('pruebas16pf.resultados_16pf_id_seq'::regclass);


--
-- Name: usuarios id; Type: DEFAULT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.usuarios ALTER COLUMN id SET DEFAULT nextval('pruebas16pf.usuarios_id_seq'::regclass);


--
-- Name: usuarios_aspirantes id; Type: DEFAULT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.usuarios_aspirantes ALTER COLUMN id SET DEFAULT nextval('pruebas16pf.usuarios_aspirantes_id_seq'::regclass);


--
-- Data for Name: aspirantes; Type: TABLE DATA; Schema: pruebas16pf; Owner: ats_n8n
--

COPY pruebas16pf.aspirantes (id, cedula, nombre, correo, edad, sexo, escolaridad, cargo_aplicado, creado_en, contrasena, actualizado_en, estado_prueba, reporte_pdf) FROM stdin;
15	1054998489	Andrés Felipe Gil García 	andresfelipegilgarcia@gmail.com	\N	\N	\N	8	2025-09-26 15:39:26.450538	$2b$10$xPkhrCeF7L6jYUZqwEpBpu7YYiMhlzC1a4R0rTz1ERX08B/G5BiHy	\N	en_progreso	\N
16	1053859011	Álvaro Andrés Tabares Guevara	andrestbrz@hotmail.com	\N	\N	\N	8	2025-09-26 15:39:52.444888	$2b$10$/tvAG2rasO8G59AdMLv.TO7jDhxSkpkIr6KqWF7fixodic/Ncgo3m	\N	en_progreso	\N
17	1045047984	Alejandra Ospina	michelle19pinedaospina@gmail.com	\N	\N	\N	8	2025-09-26 15:40:11.858295	$2b$10$RB15l7ncYtNBujEYpJc4Ked5XCetnuT6m99FV6RH./5yg55EE8uRS	\N	en_progreso	\N
18	1002955149	Yeny Marcela Flórez Restrepo	yenimarcelaflorezrestrepo@gmail.com	\N	\N	\N	8	2025-09-26 15:40:33.359418	$2b$10$Io9ZwIdO6zjKUUUl.bk9u.4Nf3h8SvgKvivrgPl9YkvPnj6ejxj.a	\N	en_progreso	\N
21	1002634053	Laura Sofía López	cuervolopezlaurasofia@gmail.com	\N	\N	\N	8	2025-09-29 14:48:24.033473	$2b$10$IR7bgehvjjIoJdPELa.cZ.3hQYWL72JpAKY6G57Gi2/ohsFmXK7IO	\N	en_progreso	\N
20	1014193713	Sandra Lorena Mora Peralta	Morasandris35@gmail.com	37	F	Bachiller	8	2025-09-26 15:41:31.005089	$2b$10$Yb0O1P.69XtBjF3DEDOzs.rqetdmd68wSFrG8tD2MUEOX1JjMihAu	2025-09-30 21:35:21.778058	finalizado	/reportes/reporte_16pf_Sandra_Lorena_Mora_Peralta_2025-09-30_16-36-19.pdf
22	1053812787	Angie Bohórquez Aguirre	angie-9-07@hotmail.com	\N	\N	\N	8	2025-09-29 14:48:48.558618	$2b$10$g85ca/hxYp5/6KhzNTNTxeuerlcVlWtVWBd2ZUR1IPMYAVL49eb5q	\N	en_progreso	\N
27	1053800345	Lorena Serna	leidylorenaserna@gmail.com	\N	\N	\N	8	2025-09-30 12:56:28.366542	$2b$10$NqzIRbZr.2sLlxh6mBROreTH2hjqwsN56KIOa8vhGkEx31i/0GKZO	\N	en_progreso	\N
25	1053810216	Juan David Arenas Galvis	juandavidarenas127@gmail.com	\N	\N	\N	8	2025-09-29 15:39:31.37905	$2b$10$pK167qhQTxV5ADSTe1i9/uyspdeADSJhbWSiC8zTHPU744wnhlefq	\N	en_progreso	\N
28	1000695207	Zara Elizabeth 	shiginio19@gmail.com	\N	\N	\N	8	2025-09-30 12:57:48.699435	$2b$10$z/M2AWg.7kMWwf44YWrNR.hEmuRdUS2dbPEYfr1iKuDn5CVwh5iu2	\N	en_progreso	\N
29	1002656312	Evelin Villegas Márquez	evelinvillegas737@gmail.com	\N	\N	\N	8	2025-09-30 12:58:09.522981	$2b$10$4q4jXsw0xDPdn561Fpydj.93TMS8AoEbEgYz6plBXrLxSgMLbc3XO	\N	en_progreso	\N
34	1005089896	Jenifer Cárdenas Grajales	cardenasjenifer51@gmail.com	23	F	Técnico	8	2025-09-30 16:40:42.125934	$2b$10$KF7VNQzQi/aXy1qo2iE0L.rKMZUtGPNZHE3M3t4vhsSRXxYXXzirW	2025-09-30 19:36:03.100657	finalizado	/reportes/reporte_16pf_Jenifer_Crdenas_Grajales_2025-09-30_15-31-21.pdf
14	1054859169	Valeria Saraza Pineda 	sarazapinedavaleria@gmail.com	20	F	Bachiller	8	2025-09-26 15:39:04.857605	$2b$10$C12EC8FKjXJOSPOOCHNMs.GC0amXckdzTjLmScVXsjxco2/5pWI9i	2025-09-26 19:23:58.323512	finalizado	/reportes/reporte_16pf_Valeria_Saraza_Pineda__2025-09-26_15-06-49.pdf
24	1007143976	Hernán Bermúdez	hbermudez645@gmail.com	25	M	Bachiller	8	2025-09-29 15:04:54.117535	$2b$10$OBkmrlvJBNM/9dQgu6zMcuRk3Zyp1Ijs0fGarduq.4fXrYPlPy.qK	2025-09-29 19:27:03.750888	finalizado	/reportes/reporte_16pf_Hernn_Bermdez_2025-09-29_14-59-37.pdf
11	1007233115	Maria Camila Gonzalez Franco	camilagf20608@gmail.com	\N	\N	\N	8	2025-09-26 15:36:55.223752	$2b$10$q1NtVrF5ZqRjZdOERvEtAeZSF7v7RsixVlv0ci54dKN9BQFEmwsEW	\N	en_progreso	\N
12	1060652984	Maribel Muñoz García	mar3818mun@gmail.com	31	F	Tecnólogo	8	2025-09-26 15:38:07.665631	$2b$10$9qMEtBfba6WCwYCYcMTsde7x/WjthO81XuGENj2/mQV6j7k4caaTS	2025-09-26 19:24:53.613869	finalizado	/reportes/reporte_16pf_Maribel_Muoz_Garca_2025-09-26_15-25-31.pdf
32	5857943	Anaelvys Prada	anaprada977@gmail.com	\N	\N	\N	8	2025-09-30 16:39:45.022536	$2b$10$yV359w2eLANCY9kLBkf6den8zOHAeA02xoE.0sW3aF8S59DHTcqwq	\N	en_progreso	\N
13	16072510	Luis Eduardo Holguín	luiseduardoarnedo@gmail.com	43	M	Técnico	8	2025-09-26 15:38:42.460999	$2b$10$HiAwPhTQFWRlwQS0tFneQueG0vIURuMdkUzlqpbm2la8ZLIky66Mm	2025-09-26 19:27:21.752742	finalizado	/reportes/reporte_16pf_Luis_Eduardo_Holgun_2025-09-26_15-28-59.pdf
33	1002592164	Juan José Ocampo Millán	juan.ocampo1104@gmail.com	\N	\N	\N	8	2025-09-30 16:40:22.089178	$2b$10$byBw.0jjZAyHV1OBj.ZdiOfYraqjR3DxwdqCv8whxBALdhcZIb4ay	\N	en_progreso	\N
26	1121929082	Erika Daniela Ruíz Reyes	melanynikol0419@gmail.com	29	F	Bachiller	8	2025-09-29 15:50:28.818283	$2b$10$9oW//xx2D4OF/iLAMPQh0.wF9UdlG4zpfJn/Isbx0ICMBNOgi9xV.	2025-09-29 19:26:15.873502	finalizado	/reportes/reporte_16pf_Erika_Daniela_Ruz_Reyes_2025-09-29_15-20-05.pdf
31	1053833109	Jenifer Serna Giraldo	yennifersernagiraldo@gmail.com	31	F	Técnico	8	2025-09-30 16:39:01.425558	$2b$10$x7pDTAyCDWXiMEpvmFHkY.FioJvhWivhEYxMiNYcjz5HdgYRXnTOe	2025-09-30 19:35:07.240013	finalizado	/reportes/reporte_16pf_Jenifer_Serna_Giraldo_2025-09-30_15-35-47.pdf
23	1006533266	Maria Alejandra Chitiva Rodríguez	alejandrachitiva15@gmail.com	25	F	Bachiller	8	2025-09-29 14:49:11.142579	$2b$10$dyU1uECHxBaZRwlvP3Fml.b/yYMInwM8eCGvmIYfIiGv4wuji.ZFS	2025-09-29 20:51:43.377097	finalizado	/reportes/reporte_16pf_Maria_Alejandra_Chitiva_Rodrguez_2025-09-29_15-52-00.pdf
35	1058820161	Maria Verónica Castaño Grisales	mariaveronicacastano245@gmail.com	\N	\N	\N	23	2025-09-30 19:14:30.60862	$2b$10$pgC.CIDFJwGW1xcTLSVXp.svh67qL/kuPiRJtPA0eIICW2JgF0a.G	2025-09-30 19:16:06.234619	en_progreso	\N
38	1004754234	Ángela Patricia Valencia Ramirez	1104ange@gmail.com	25	F	Técnico	8	2025-10-01 13:21:21.452515	$2b$10$ZaNj4uKdvz86e671C6n6AOoRQWNFMhz/O7U3x8PfoqDnU9cnzzqGC	2025-10-01 15:54:20.492288	finalizado	/reportes/reporte_16pf_ngela_Patricia_Valencia_Ramirez_2025-10-01_09-03-53.pdf
40	1053823745	Maria Alejandra Gonzalez Cuervo	cugonzalez2020@gmail.com	32	F	Bachiller	23	2025-10-01 13:39:35.192089	$2b$10$oesoR90zU5cg4qFJCSZ52ewTudMFMPqcRYlZlbgcR4oEsajUhz.Qa	2025-10-01 18:06:20.551753	finalizado	/reportes/reporte_16pf_Maria_Alejandra_Gonzalez_Cuervo_2025-10-01_13-05-42.pdf
41	1108206300	Jonathan Felipe Jiménez Casas	jonitexjimenez@gmail.com	\N	\N	\N	8	2025-10-01 17:33:10.407075	$2b$10$YKY.D4wM9ZYDOt7eX7ImN.QW8kH/rJ1Dm10rvi.BDGPWsp21mOuae	\N	en_progreso	\N
36	1004753389	Maria Valentina García Orozco	mvgarcia.or@gmail.com	24	F	Profesional	23	2025-09-30 22:22:55.729205	$2b$10$a34fR48WmlvRmypTLp.YyuSuGbOnI0uJ8nFYPJtdOlFnvqOY2XRvW	2025-09-30 22:32:17.254085	finalizado	/reportes/reporte_16pf_Maria_Valentina_Garca_Orozco_2025-09-30_18-02-06.pdf
37	1056122353	Laura Ximena Zuluaga Caicedo	zuluagacaicedolauraximena674@gmail.com	20	F	Técnico	8	2025-10-01 13:20:06.899978	$2b$10$u2FfCG576PuIAuNQY992vuXIYc1mJITDC/gnAZJs/7VvkYUnrOSdW	2025-10-01 13:22:53.652891	finalizado	/reportes/reporte_16pf_Laura_Ximena_Zuluaga_Caicedo_2025-10-01_09-10-25.pdf
42	30374631	LUZ ESTELA MORENO ARIAS	luzestelamorenoarias7@gmail.com	40	F	Bachiller	8	2025-10-01 17:33:18.372051	$2b$10$I62bq/TNauWReRcQ2IE8.eCajxvgGaMrEHefKvnWOVJnLyT7jWanW	2025-10-01 18:17:40.139543	finalizado	/reportes/reporte_16pf_LUZ_ESTELA_MORENO_ARIAS_2025-10-01_13-18-18.pdf
44	1053808766	Sandra Milena Morales Castaño	sanmorales50@gmail.com	34	F	Técnico	8	2025-10-01 17:34:08.507831	$2b$10$yU5rYpyC6c3Bj8zqM6MfsuaExI6VPH4B.INBZcuTHXoiekYXWX.c6	2025-10-01 21:13:24.520481	finalizado	/reportes/reporte_16pf_Sandra_Milena_Morales_Castao_2025-10-01_17-20-12.pdf
43	1104934318	Maria Paula Pérez Lozano	perezlozanopaula2346@gmail.com	\N	\N	\N	8	2025-10-01 17:33:36.785123	$2b$10$NrKI/oTiQv2SD.uvkcfMiOTaeKYesNnLAwEDxGh5bdNJ.BERElI/y	\N	enviado	\N
45	1007475493	Karen Eliane Bonza Fernandez 	ferca2612@gmail.com	23	F	Bachiller	8	2025-10-02 13:19:54.199161	$2b$10$KfYwEIWGXqGdB92wKqmR.ODnY5RHIQ1nS03rtGVu99sVedh6nIqE6	2025-10-03 14:11:39.053211	finalizado	/reportes/reporte_16pf_Karen_Eliane_Bonza_Fernandez__2025-10-03_10-06-07.pdf
51	1002656355	Juanita Arango García	arangojuanita25@gmail.com	\N	\N	\N	8	2025-10-02 13:48:03.016076	$2b$10$7hJIETGv22uGp2lPEAP.8uQ4LakL.YwTapJBS2ZWSSJxigNQpnnWq	\N	en_progreso	\N
39	22002067	MARLLORY RAMIREZ GARCIA	Marllory2502@gmail.com	43	F	Bachiller	24	2025-10-01 13:34:12.937808	$2b$10$wIy.u3vuJ4PbuQt1AnzCwe3/THv.NpC5kSXZOq1flssGw/G9i.nfO	2025-10-02 14:44:26.883315	finalizado	/reportes/reporte_16pf_MARLLORY_RAMIREZ_GARCIA_2025-10-01_18-32-31.pdf
63	24341168	Sandra Paola Londoño Serna	londonosernasandrapaola@gmail.com	\N	\N	\N	8	2025-10-03 15:55:07.591921	$2b$10$4lqIQVGi2.YT.ik6GRzpuO0POSC2AG6eRwcm/.DTgGPmo3QoVo4Cm	\N	en_progreso	\N
64	1053774683	Juan Manuel Peña Calderón	juancalde89@hotmail.com	\N	\N	\N	8	2025-10-03 15:55:31.040214	$2b$10$JuvC589cbsO768KVtuwR/u9v0l2UfIKBgOvVmW0macIVoyRy9CxYa	\N	en_progreso	\N
55	1002635286	Maria Antonia Rivera Castrillón	xnfk2xwhpg@privaterelay.appleid.com	\N	\N	\N	8	2025-10-02 21:07:57.018965	$2b$10$Iy91VP/Ws27i3mpdi/gLP.pnCC.wOw3cQEsvFEBkzFn1XylGtvCAS	\N	en_progreso	\N
57	1002811741	DANA PAOLA ACEVEDO QUICENO	acevedoquiceno09@gmail.com	\N	\N	\N	8	2025-10-02 21:59:11.568412	$2b$10$DeHJHb61G.Je3E4fJPlT2Ow6euK9YxpftqrD.Vs0qXIeVfh19i5Ue	\N	enviado	\N
47	1054571839	ANGIE PAOLA MESA GOMEZ	angiegomez2505@gmail.com	\N	\N	\N	8	2025-10-02 13:24:09.346026	$2b$10$7UrsD45N6c2j1396TADSruINCCmWDjtpihRSO86i.iMlpf9jLvPhu	\N	enviado	\N
48	1105784083	NANCY GUTIÉRREZ AGUIRRE	gutierreznancy816@gmail.com	\N	\N	\N	8	2025-10-02 13:25:04.009284	$2b$10$AlRqh46ASOroOMEmYmTl2.OBn51f62dFYcq2IaoDXmm4SHOtnl.K6	\N	enviado	\N
53	1004684667	Gabriel David Mejía López	gmejial@unal.edu.co	22	M	Bachiller	25	2025-10-02 20:41:15.619995	$2b$10$jlgLzMQWyfL9jYUfbqeb.Oq1SfwJAbnNmA38Hi13Jq4naYf1QFnVu	2025-10-02 21:00:47.327693	finalizado	/reportes/reporte_16pf_Gabriel_David_Meja_Lpez_2025-10-02_17-05-57.pdf
52	10017232250	Ángelica María Tapias Morales	Antonellamorales2807@gmail.com	25	F	Bachiller	8	2025-10-02 16:12:54.386521	$2b$10$0I9EId1YaKdR3JVbeR3fu.qvFSyqPWWhGPVLpl/8jPS/xw6f9/gW2	2025-10-02 22:04:35.973745	finalizado	/reportes/reporte_16pf_ngelica_Mara_Tapias_Morales_2025-10-02_17-54-18.pdf
59	1060655842	Paula Andrea Loaiza Vallejo	paulavallejo.1998@gmail.com	\N	\N	\N	8	2025-10-03 14:37:32.444287	$2b$10$Gl1pN0LNgo.2BDeCJHk.Y.b7RHGhVc/.9FlWGn5TW2YzoKwdCDIBO	\N	enviado	\N
46	1054571795	Geraldine Andrea Jiménez Ceballos	geraldine99jc@gmail.com	25	F	Tecnólogo	8	2025-10-02 13:22:59.67659	$2b$10$wMZF8d7GvNpruRnGKl/4keOlYvqe9cRBjpFkI56N5aDTnAcVMIE86	2025-10-03 13:42:27.467861	finalizado	/reportes/reporte_16pf_Geraldine_Andrea_Jimnez_Ceballos_2025-10-03_09-43-21.pdf
54	1053861122	Luis Diego Osorio Gonzalez	diegoosoriogonzalez@gmail.com	27	M	Profesional	25	2025-10-02 21:05:06.431353	$2b$10$/2gINOID61OL5Ty673/p3Oq.svfiIzGW6THv7TH1NWjXe1ib1p/Pi	2025-10-03 02:03:03.554307	finalizado	/reportes/reporte_16pf_Luis_Diego_Osorio_Gonzalez_2025-10-02_21-03-13.pdf
50	1055917590	MARTA ISABEL PALACIO PALACIOS	martapalacio043021@gmail.com	34	F	Bachiller	8	2025-10-02 13:28:03.617377	$2b$10$mP.WCKzqr0EBTzg74/jGfOnAbImtT56VsLEK6EJb9M5B/kZdfosbe	2025-10-03 14:11:50.841168	finalizado	/reportes/reporte_16pf_MARTA_ISABEL_PALACIO_PALACIOS_2025-10-03_10-29-36.pdf
49	1018415447	KAROL YULIANA AGUIRRE VALENCIA	karolvalencia2006ca@gmail.com	19	F	Bachiller	8	2025-10-02 13:26:28.846792	$2b$10$5eGB5qD4wyXd5lT3QO0Oi.rd79hg3x8qRNevuMWemBcvnIL4IHfm.	2025-10-03 15:46:42.652113	enviado	\N
60	30310984	Lucero Hernández Arias	luceroh.a@hotmail.com	\N	\N	\N	8	2025-10-03 15:53:59.696374	$2b$10$86Wnl4xT.F4FfeY/AaNrS.x59GsjTPC7PZMmW6GU2kLrYH2sGJQk6	\N	en_progreso	\N
61	1053869483	Sofía Franco	sofiafq11@gmail.com	\N	\N	\N	8	2025-10-03 15:54:23.639651	$2b$10$NWiR7FIJOiClAk7s6SAdtONT0xy5zPXqS97R89S/h86rnKkvv0eve	\N	en_progreso	\N
62	1002655819	Jessica Lorena Soto Carmona	sotojessicalorena@gmail.com	\N	\N	\N	8	2025-10-03 15:54:45.017253	$2b$10$RV34P7E4acjvjOSEV6kvYuRcEu0BCna1jeDLFerdzZdEXLEvLP4VO	\N	en_progreso	\N
\.


--
-- Data for Name: baremos_16pf; Type: TABLE DATA; Schema: pruebas16pf; Owner: ats_n8n
--

COPY pruebas16pf.baremos_16pf (id, factor_id, sexo, puntaje_bruto, decatipo) FROM stdin;
1	A	M	0	1
2	A	M	1	1
3	A	M	2	1
4	A	M	3	1
5	A	M	4	2
6	A	M	5	2
7	A	M	6	2
8	A	M	7	3
9	A	M	8	3
10	A	M	9	4
11	A	M	10	4
12	A	M	11	5
13	A	M	12	6
14	A	M	13	6
15	A	M	14	7
16	A	M	15	8
17	A	M	16	8
18	A	M	17	9
19	A	M	18	9
20	A	M	19	10
21	A	M	20	10
22	A	M	21	10
23	A	M	22	10
24	A	M	23	10
25	A	M	24	10
26	A	M	25	10
27	A	M	26	10
28	A	M	27	10
29	A	M	28	10
30	A	F	0	1
31	A	F	1	1
32	A	F	2	1
33	A	F	3	1
34	A	F	4	1
35	A	F	5	2
36	A	F	6	2
37	A	F	7	3
38	A	F	8	4
39	A	F	9	4
40	A	F	10	5
41	A	F	11	6
42	A	F	12	6
43	A	F	13	7
44	A	F	14	8
45	A	F	15	8
46	A	F	16	9
47	A	F	17	9
48	A	F	18	10
49	A	F	19	10
50	A	F	20	10
51	A	F	21	10
52	A	F	22	10
53	A	F	23	10
54	A	F	24	10
55	A	F	25	10
56	A	F	26	10
57	A	F	27	10
58	A	F	28	10
59	B	M	0	1
60	B	M	1	1
61	B	M	2	1
62	B	M	3	1
63	B	M	4	2
64	B	M	5	3
65	B	M	6	4
66	B	M	7	5
67	B	M	8	6
68	B	M	9	7
69	B	M	10	7
70	B	M	11	8
71	B	M	12	9
72	B	M	13	10
73	B	M	14	10
74	B	F	0	1
75	B	F	1	1
76	B	F	2	1
77	B	F	3	1
78	B	F	4	1
79	B	F	5	2
80	B	F	6	3
81	B	F	7	4
82	B	F	8	5
83	B	F	9	6
84	B	F	10	7
85	B	F	11	8
86	B	F	12	9
87	B	F	13	10
88	B	F	14	10
89	C	M	0	1
90	C	M	1	1
91	C	M	2	1
92	C	M	3	1
93	C	M	4	1
94	C	M	5	1
95	C	M	6	1
96	C	M	7	2
97	C	M	8	2
98	C	M	9	3
99	C	M	10	3
100	C	M	11	3
101	C	M	12	4
102	C	M	13	4
103	C	M	14	5
104	C	M	15	5
105	C	M	16	6
106	C	M	17	6
107	C	M	18	7
108	C	M	19	7
109	C	M	20	8
110	C	M	21	8
111	C	M	22	8
112	C	M	23	9
113	C	M	24	9
114	C	M	25	10
115	C	M	26	10
116	C	M	27	10
117	C	F	0	1
118	C	F	1	1
119	C	F	2	1
120	C	F	3	1
121	C	F	4	1
122	C	F	5	1
123	C	F	6	2
124	C	F	7	3
125	C	F	8	3
126	C	F	9	4
127	C	F	10	4
128	C	F	11	4
129	C	F	12	5
130	C	F	13	5
131	C	F	14	5
132	C	F	15	6
133	C	F	16	6
134	C	F	17	7
135	C	F	18	7
136	C	F	19	8
137	C	F	20	8
138	C	F	21	9
139	C	F	22	9
140	C	F	23	10
141	C	F	24	10
142	C	F	25	10
143	C	F	26	10
144	C	F	27	10
145	E	M	0	1
146	E	M	1	1
147	E	M	2	1
148	E	M	3	1
149	E	M	4	1
150	E	M	5	2
151	E	M	6	2
152	E	M	7	3
153	E	M	8	3
154	E	M	9	4
155	E	M	10	4
156	E	M	11	5
157	E	M	12	5
158	E	M	13	6
159	E	M	14	6
160	E	M	15	7
161	E	M	16	7
162	E	M	17	8
163	E	M	18	8
164	E	M	19	9
165	E	M	20	9
166	E	M	21	10
167	E	M	22	10
168	E	M	23	10
169	E	M	24	10
170	E	M	25	10
171	E	M	26	10
172	E	M	27	10
173	E	F	0	1
174	E	F	1	1
175	E	F	2	1
176	E	F	3	1
177	E	F	4	1
178	E	F	5	2
179	E	F	6	2
180	E	F	7	3
181	E	F	8	3
182	E	F	9	4
183	E	F	10	5
184	E	F	11	5
185	E	F	12	6
186	E	F	13	6
187	E	F	14	7
188	E	F	15	7
189	E	F	16	7
190	E	F	17	8
191	E	F	18	8
192	E	F	19	9
193	E	F	20	9
194	E	F	21	10
195	E	F	22	10
196	E	F	23	10
197	E	F	24	10
198	E	F	25	10
199	E	F	26	10
200	E	F	27	10
201	F	M	0	1
202	F	M	1	1
203	F	M	2	1
204	F	M	3	1
205	F	M	4	1
206	F	M	5	2
207	F	M	6	2
208	F	M	7	3
209	F	M	8	3
210	F	M	9	4
211	F	M	10	4
212	F	M	11	5
213	F	M	12	5
214	F	M	13	5
215	F	M	14	6
216	F	M	15	6
217	F	M	16	7
218	F	M	17	7
219	F	M	18	8
220	F	M	19	8
221	F	M	20	9
222	F	M	21	9
223	F	M	22	10
224	F	M	23	10
225	F	M	24	10
226	F	M	25	10
227	F	M	26	10
228	F	M	27	10
229	F	F	0	1
230	F	F	1	1
231	F	F	2	1
232	F	F	3	1
233	F	F	4	1
234	F	F	5	1
235	F	F	6	2
236	F	F	7	3
237	F	F	8	3
238	F	F	9	4
239	F	F	10	4
240	F	F	11	4
241	F	F	12	5
242	F	F	13	5
243	F	F	14	6
244	F	F	15	6
245	F	F	16	6
246	F	F	17	7
247	F	F	18	7
248	F	F	19	8
249	F	F	20	9
250	F	F	21	9
251	F	F	22	10
252	F	F	23	10
253	F	F	24	10
254	F	F	25	10
255	F	F	26	10
256	F	F	27	10
257	G	M	0	1
258	G	M	1	1
259	G	M	2	1
260	G	M	3	1
261	G	M	4	1
262	G	M	5	1
263	G	M	6	1
264	G	M	7	1
265	G	M	8	2
266	G	M	9	2
267	G	M	10	3
268	G	M	11	3
269	G	M	12	4
270	G	M	13	4
271	G	M	14	5
272	G	M	15	5
273	G	M	16	6
274	G	M	17	7
275	G	M	18	8
276	G	M	19	9
277	G	M	20	10
278	G	M	21	10
279	G	F	0	1
280	G	F	1	1
281	G	F	2	1
282	G	F	3	1
283	G	F	4	1
284	G	F	5	2
285	G	F	6	2
286	G	F	7	3
287	G	F	8	3
288	G	F	9	4
289	G	F	10	4
290	G	F	11	4
291	G	F	12	5
292	G	F	13	5
293	G	F	14	6
294	G	F	15	6
295	G	F	16	7
296	G	F	17	7
297	G	F	18	8
298	G	F	19	9
299	G	F	20	10
300	G	F	21	10
301	H	M	0	1
302	H	M	1	1
303	H	M	2	1
304	H	M	3	1
305	H	M	4	2
306	H	M	5	2
307	H	M	6	3
308	H	M	7	3
309	H	M	8	3
310	H	M	9	3
311	H	M	10	4
312	H	M	11	4
313	H	M	12	4
314	H	M	13	5
315	H	M	14	5
316	H	M	15	5
317	H	M	16	6
318	H	M	17	6
319	H	M	18	7
320	H	M	19	7
321	H	M	20	7
322	H	M	21	8
323	H	M	22	8
324	H	M	23	9
325	H	M	24	9
326	H	M	25	10
327	H	M	26	10
328	H	M	27	10
329	H	F	0	1
330	H	F	1	1
331	H	F	2	1
332	H	F	3	2
333	H	F	4	3
334	H	F	5	3
335	H	F	6	3
336	H	F	7	3
337	H	F	8	4
338	H	F	9	4
339	H	F	10	4
340	H	F	11	5
341	H	F	12	5
342	H	F	13	6
343	H	F	14	6
344	H	F	15	6
345	H	F	16	7
346	H	F	17	7
347	H	F	18	7
348	H	F	19	8
349	H	F	20	8
350	H	F	21	9
351	H	F	22	9
352	H	F	23	10
353	H	F	24	10
354	H	F	25	10
355	H	F	26	10
356	H	F	27	10
357	I	M	0	1
358	I	M	1	1
359	I	M	2	1
360	I	M	3	1
361	I	M	4	2
362	I	M	5	3
363	I	M	6	3
364	I	M	7	4
365	I	M	8	4
366	I	M	9	5
367	I	M	10	5
368	I	M	11	6
369	I	M	12	6
370	I	M	13	7
371	I	M	14	8
372	I	M	15	8
373	I	M	16	9
374	I	M	17	9
375	I	M	18	10
376	I	M	19	10
377	I	M	20	10
378	I	M	21	10
379	I	F	0	1
380	I	F	1	1
381	I	F	2	1
382	I	F	3	1
383	I	F	4	1
384	I	F	5	1
385	I	F	6	1
386	I	F	7	2
387	I	F	8	2
388	I	F	9	3
389	I	F	10	3
390	I	F	11	4
391	I	F	12	4
392	I	F	13	5
393	I	F	14	5
394	I	F	15	6
395	I	F	16	6
396	I	F	17	7
397	I	F	18	8
398	I	F	19	9
399	I	F	20	10
400	I	F	21	10
401	L	M	0	1
402	L	M	1	1
403	L	M	2	1
404	L	M	3	1
405	L	M	4	2
406	L	M	5	3
407	L	M	6	3
408	L	M	7	4
409	L	M	8	4
410	L	M	9	5
411	L	M	10	6
412	L	M	11	6
413	L	M	12	7
414	L	M	13	7
415	L	M	14	8
416	L	M	15	9
417	L	M	16	9
418	L	M	17	10
419	L	M	18	10
420	L	M	19	10
421	L	M	20	10
422	L	M	21	10
423	L	F	0	1
424	L	F	1	1
425	L	F	2	1
426	L	F	3	1
427	L	F	4	2
428	L	F	5	2
429	L	F	6	3
430	L	F	7	3
431	L	F	8	4
432	L	F	9	5
433	L	F	10	5
434	L	F	11	6
435	L	F	12	6
436	L	F	13	7
437	L	F	14	7
438	L	F	15	8
439	L	F	16	9
440	L	F	17	10
441	L	F	18	10
442	L	F	19	10
443	L	F	20	10
444	L	F	21	10
445	M	M	0	1
446	M	M	1	1
447	M	M	2	1
448	M	M	3	1
449	M	M	4	1
450	M	M	5	1
451	M	M	6	2
452	M	M	7	3
453	M	M	8	3
454	M	M	9	4
455	M	M	10	4
456	M	M	11	5
457	M	M	12	5
458	M	M	13	6
459	M	M	14	7
460	M	M	15	7
461	M	M	16	8
462	M	M	17	9
463	M	M	18	9
464	M	M	19	10
465	M	M	20	10
466	M	M	21	10
467	M	M	22	10
468	M	M	23	10
469	M	M	24	10
470	M	M	25	10
471	M	M	26	10
472	M	M	27	10
473	M	F	0	1
474	M	F	1	1
475	M	F	2	1
476	M	F	3	1
477	M	F	4	1
478	M	F	5	1
479	M	F	6	1
480	M	F	7	2
481	M	F	8	2
482	M	F	9	3
483	M	F	10	4
484	M	F	11	4
485	M	F	12	5
486	M	F	13	5
487	M	F	14	6
488	M	F	15	6
489	M	F	16	7
490	M	F	17	8
491	M	F	18	8
492	M	F	19	9
493	M	F	20	9
494	M	F	21	10
495	M	F	22	10
496	M	F	23	10
497	M	F	24	10
498	M	F	25	10
499	M	F	26	10
500	M	F	27	10
501	N	M	0	1
502	N	M	1	1
503	N	M	2	1
504	N	M	3	1
505	N	M	4	1
506	N	M	5	1
507	N	M	6	2
508	N	M	7	3
509	N	M	8	3
510	N	M	9	4
511	N	M	10	5
512	N	M	11	5
513	N	M	12	6
514	N	M	13	7
515	N	M	14	8
516	N	M	15	8
517	N	M	16	9
518	N	M	17	10
519	N	M	18	10
520	N	M	19	10
521	N	M	20	10
522	N	M	21	10
523	N	F	0	1
524	N	F	1	1
525	N	F	2	1
526	N	F	3	1
527	N	F	4	1
528	N	F	5	1
529	N	F	6	2
530	N	F	7	3
531	N	F	8	3
532	N	F	9	4
533	N	F	10	5
534	N	F	11	5
535	N	F	12	6
536	N	F	13	7
537	N	F	14	7
538	N	F	15	8
539	N	F	16	9
540	N	F	17	9
541	N	F	18	10
542	N	F	19	10
543	N	F	20	10
544	N	F	21	10
545	O	M	0	1
546	O	M	1	1
547	O	M	2	2
548	O	M	3	2
549	O	M	4	3
550	O	M	5	3
551	O	M	6	4
552	O	M	7	4
553	O	M	8	5
554	O	M	9	5
555	O	M	10	6
556	O	M	11	6
557	O	M	12	7
558	O	M	13	7
559	O	M	14	8
560	O	M	15	8
561	O	M	16	8
562	O	M	17	9
563	O	M	18	9
564	O	M	19	10
565	O	M	20	10
566	O	M	21	10
567	O	M	22	10
568	O	M	23	10
569	O	M	24	10
570	O	M	25	10
571	O	M	26	10
572	O	M	27	10
573	O	F	0	1
574	O	F	1	1
575	O	F	2	1
576	O	F	3	1
577	O	F	4	2
578	O	F	5	2
579	O	F	6	3
580	O	F	7	4
581	O	F	8	4
582	O	F	9	5
583	O	F	10	5
584	O	F	11	5
585	O	F	12	6
586	O	F	13	6
587	O	F	14	7
588	O	F	15	7
589	O	F	16	8
590	O	F	17	8
591	O	F	18	9
592	O	F	19	10
593	O	F	20	10
594	O	F	21	10
595	O	F	22	10
596	O	F	23	10
597	O	F	24	10
598	O	F	25	10
599	O	F	26	10
600	O	F	27	10
601	Q1	M	0	1
602	Q1	M	1	1
603	Q1	M	2	1
604	Q1	M	3	1
605	Q1	M	4	1
606	Q1	M	5	2
607	Q1	M	6	2
608	Q1	M	7	3
609	Q1	M	8	4
610	Q1	M	9	5
611	Q1	M	10	5
612	Q1	M	11	6
613	Q1	M	12	6
614	Q1	M	13	7
615	Q1	M	14	8
616	Q1	M	15	8
617	Q1	M	16	9
618	Q1	M	17	10
619	Q1	M	18	10
620	Q1	M	19	10
621	Q1	M	20	10
622	Q1	M	21	10
623	Q1	F	0	1
624	Q1	F	1	1
625	Q1	F	2	1
626	Q1	F	3	1
627	Q1	F	4	1
628	Q1	F	5	2
629	Q1	F	6	2
630	Q1	F	7	3
631	Q1	F	8	4
632	Q1	F	9	4
633	Q1	F	10	5
634	Q1	F	11	6
635	Q1	F	12	7
636	Q1	F	13	7
637	Q1	F	14	8
638	Q1	F	15	8
639	Q1	F	16	9
640	Q1	F	17	10
641	Q1	F	18	10
642	Q1	F	19	10
643	Q1	F	20	10
644	Q1	F	21	10
645	Q2	M	0	1
646	Q2	M	1	1
647	Q2	M	2	1
648	Q2	M	3	2
649	Q2	M	4	2
650	Q2	M	5	3
651	Q2	M	6	3
652	Q2	M	7	4
653	Q2	M	8	5
654	Q2	M	9	5
655	Q2	M	10	6
656	Q2	M	11	6
657	Q2	M	12	7
658	Q2	M	13	7
659	Q2	M	14	8
660	Q2	M	15	9
661	Q2	M	16	9
662	Q2	M	17	10
663	Q2	M	18	10
664	Q2	M	19	10
665	Q2	M	20	10
666	Q2	M	21	10
667	Q2	F	0	1
668	Q2	F	1	1
669	Q2	F	2	1
670	Q2	F	3	1
671	Q2	F	4	1
672	Q2	F	5	2
673	Q2	F	6	3
674	Q2	F	7	3
675	Q2	F	8	4
676	Q2	F	9	4
677	Q2	F	10	5
678	Q2	F	11	6
679	Q2	F	12	6
680	Q2	F	13	7
681	Q2	F	14	7
682	Q2	F	15	8
683	Q2	F	16	8
684	Q2	F	17	9
685	Q2	F	18	10
686	Q2	F	19	10
687	Q2	F	20	10
688	Q2	F	21	10
689	Q3	M	0	1
690	Q3	M	1	1
691	Q3	M	2	1
692	Q3	M	3	1
693	Q3	M	4	1
694	Q3	M	5	1
695	Q3	M	6	2
696	Q3	M	7	2
697	Q3	M	8	3
698	Q3	M	9	3
699	Q3	M	10	4
700	Q3	M	11	4
701	Q3	M	12	5
702	Q3	M	13	5
703	Q3	M	14	6
704	Q3	M	15	7
705	Q3	M	16	7
706	Q3	M	17	8
707	Q3	M	18	9
708	Q3	M	19	10
709	Q3	M	20	10
710	Q3	M	21	10
711	Q3	F	0	1
712	Q3	F	1	1
713	Q3	F	2	1
714	Q3	F	3	1
715	Q3	F	4	2
716	Q3	F	5	2
717	Q3	F	6	3
718	Q3	F	7	3
719	Q3	F	8	4
720	Q3	F	9	5
721	Q3	F	10	5
722	Q3	F	11	6
723	Q3	F	12	6
724	Q3	F	13	7
725	Q3	F	14	7
726	Q3	F	15	8
727	Q3	F	16	8
728	Q3	F	17	9
729	Q3	F	18	10
730	Q3	F	19	10
731	Q3	F	20	10
732	Q3	F	21	10
733	Q4	M	0	1
734	Q4	M	1	2
735	Q4	M	2	2
736	Q4	M	3	3
737	Q4	M	4	3
738	Q4	M	5	4
739	Q4	M	6	4
740	Q4	M	7	5
741	Q4	M	8	5
742	Q4	M	9	5
743	Q4	M	10	6
744	Q4	M	11	6
745	Q4	M	12	7
746	Q4	M	13	7
747	Q4	M	14	7
748	Q4	M	15	8
749	Q4	M	16	8
750	Q4	M	17	8
751	Q4	M	18	9
752	Q4	M	19	9
753	Q4	M	20	9
754	Q4	M	21	10
755	Q4	M	22	10
756	Q4	M	23	10
757	Q4	M	24	10
758	Q4	M	25	10
759	Q4	M	26	10
760	Q4	M	27	10
761	Q4	F	0	1
762	Q4	F	1	1
763	Q4	F	2	1
764	Q4	F	3	1
765	Q4	F	4	2
766	Q4	F	5	2
767	Q4	F	6	3
768	Q4	F	7	3
769	Q4	F	8	4
770	Q4	F	9	4
771	Q4	F	10	5
772	Q4	F	11	5
773	Q4	F	12	5
774	Q4	F	13	6
775	Q4	F	14	6
776	Q4	F	15	6
777	Q4	F	16	7
778	Q4	F	17	7
779	Q4	F	18	7
780	Q4	F	19	8
781	Q4	F	20	8
782	Q4	F	21	9
783	Q4	F	22	9
784	Q4	F	23	10
785	Q4	F	24	10
786	Q4	F	25	10
787	Q4	F	26	10
788	Q4	F	27	10
\.


--
-- Data for Name: cargo_requisitos; Type: TABLE DATA; Schema: pruebas16pf; Owner: ats_n8n
--

COPY pruebas16pf.cargo_requisitos (id, cargo_id, requisito_id, date) FROM stdin;
1	2	1	2025-09-08 12:25:43.928948
2	2	2	2025-09-08 12:25:43.928948
3	2	3	2025-09-08 12:25:43.928948
4	2	4	2025-09-08 12:25:43.928948
8	4	1	2025-09-08 12:25:43.928948
9	4	2	2025-09-08 12:25:43.928948
14	7	1	2025-09-08 12:25:43.928948
15	7	6	2025-09-08 12:25:43.928948
17	4	6	2025-09-08 12:25:43.928948
18	8	7	\N
19	8	8	\N
43	19	3	\N
44	19	4	\N
45	19	2	\N
46	19	6	\N
47	19	19	\N
51	19	28	\N
56	22	1	\N
57	22	3	\N
58	23	8	\N
59	23	31	\N
\.


--
-- Data for Name: cargos; Type: TABLE DATA; Schema: pruebas16pf; Owner: ats_n8n
--

COPY pruebas16pf.cargos (id, nombre, descripcion, activo, creado_en) FROM stdin;
8	Vendedor punto de venta	Vendedor de punto de venta fisico	t	2025-09-10 16:51:40.14303
7	Gerente General	Encargado de toda la gestión administrativa	f	2025-09-08 12:31:13.905757
23	Promotor de Casino 	desempeñarse como promotor de casino, sus funciones están orientadas a brindar un servicio oportuno y de calidad al cliente, realizar transacciones de caja, pago de premios y asesoría en uso de máquinas.	t	2025-09-26 14:57:24.298559
22	Corresponsal	Corresponsal	f	2025-09-25 16:03:35.729391
19	Desarrollador RPA	Crear automatizaciones para diferentes areas	f	2025-09-15 10:09:40.056732
4	Desarrollador Backend	Responsable de crear y mantener APIs	f	2025-09-08 12:31:13.905757
2	Analista de Datos	Encargado de análisis y reportes	f	2025-09-08 12:31:13.905757
24	Auxiliar de Oficina		t	2025-10-01 00:41:58.033149
25	Aprendiz 		t	2025-10-02 20:40:45.474968
\.


--
-- Data for Name: citas_agendadas; Type: TABLE DATA; Schema: pruebas16pf; Owner: ats_n8n
--

COPY pruebas16pf.citas_agendadas (id, horario_id, nombre_candidato, telefono_candidato, estado, created_at) FROM stdin;
\.


--
-- Data for Name: clave_detalle_16pf; Type: TABLE DATA; Schema: pruebas16pf; Owner: ats_n8n
--

COPY pruebas16pf.clave_detalle_16pf (id, numero_pregunta, factor, opcion, puntaje) FROM stdin;
1	1	NF	A	0
2	1	NF	B	0
3	1	NF	C	0
4	2	NF	A	0
5	2	NF	B	0
6	2	NF	C	0
7	3	B	A	0
8	3	B	B	1
9	3	B	C	0
10	4	C	A	2
11	4	C	B	1
12	4	C	C	0
13	4	DM	A	1
14	4	DM	B	0
15	4	DM	C	0
16	5	E	A	0
17	5	E	B	1
18	5	E	C	2
19	6	E	A	2
20	6	E	B	1
21	6	E	C	0
22	7	F	A	0
23	7	F	B	1
24	7	F	C	2
25	8	G	A	0
26	8	G	B	1
27	8	G	C	2
28	9	H	A	2
29	9	H	B	1
30	9	H	C	0
31	9	DM	A	1
32	9	DM	B	0
33	9	DM	C	0
34	10	I	A	0
35	10	I	B	1
36	10	I	C	2
37	11	L	A	0
38	11	L	B	1
39	11	L	C	2
40	12	M	A	0
41	12	M	B	1
42	12	M	C	2
43	13	N	A	0
44	13	N	B	1
45	13	N	C	2
46	14	O	A	2
47	14	O	B	1
48	14	O	C	0
49	15	O	A	0
50	15	O	B	1
51	15	O	C	2
52	16	Q1	A	2
53	16	Q1	B	1
54	16	Q1	C	0
55	17	Q2	A	0
56	17	Q2	B	1
57	17	Q2	C	2
58	18	Q3	A	0
59	18	Q3	B	1
60	18	Q3	C	2
61	19	Q4	A	0
62	19	Q4	B	1
63	19	Q4	C	2
64	20	A	A	2
65	20	A	B	1
66	20	A	C	0
67	21	A	A	0
68	21	A	B	1
69	21	A	C	2
70	22	B	A	0
71	22	B	B	1
72	22	B	C	0
73	23	C	A	0
74	23	C	B	1
75	23	C	C	2
76	24	E	A	0
77	24	E	B	1
78	24	E	C	2
79	25	F	A	2
80	25	F	B	1
81	25	F	C	0
82	25	DM	A	1
83	25	DM	B	0
84	25	DM	C	0
85	26	F	A	2
86	26	F	B	1
87	26	F	C	0
88	27	G	A	0
89	27	G	B	1
90	27	G	C	2
91	28	H	A	0
92	28	H	B	1
93	28	H	C	2
94	28	DM	A	0
95	28	DM	B	0
96	28	DM	C	1
97	29	I	A	2
98	29	I	B	1
99	29	I	C	0
100	30	L	A	2
101	30	L	B	1
102	30	L	C	0
103	31	M	A	0
104	31	M	B	1
105	31	M	C	2
106	32	N	A	2
107	32	N	B	1
108	32	N	C	0
109	33	O	A	2
110	33	O	B	1
111	33	O	C	0
112	34	O	A	0
113	34	O	B	1
114	34	O	C	2
115	35	Q1	A	0
116	35	Q1	B	1
117	35	Q1	C	2
118	36	Q2	A	2
119	36	Q2	B	1
120	36	Q2	C	0
121	37	Q3	A	0
122	37	Q3	B	1
123	37	Q3	C	2
124	37	DM	A	0
125	37	DM	B	0
126	37	DM	C	1
127	38	Q4	A	2
128	38	Q4	B	1
129	38	Q4	C	0
130	39	A	A	0
131	39	A	B	1
132	39	A	C	2
133	40	B	A	0
134	40	B	B	1
135	40	B	C	0
136	41	B	A	0
137	41	B	B	0
138	41	B	C	1
139	42	C	A	0
140	42	C	B	1
141	42	C	C	2
142	43	E	A	0
143	43	E	B	1
144	43	E	C	2
145	44	F	A	0
146	44	F	B	1
147	44	F	C	2
148	45	F	A	2
149	45	F	B	1
150	45	F	C	0
151	46	G	A	0
152	46	G	B	1
153	46	G	C	2
154	47	H	A	2
155	47	H	B	1
156	47	H	C	0
157	48	I	A	2
158	48	I	B	1
159	48	I	C	0
160	49	L	A	0
161	49	L	B	1
162	49	L	C	2
163	50	M	A	2
164	50	M	B	1
165	50	M	C	0
166	51	N	A	0
167	51	N	B	1
168	51	N	C	2
169	52	O	A	0
170	52	O	B	1
171	52	O	C	2
172	53	O	A	2
173	53	O	B	1
174	53	O	C	0
175	54	Q1	A	0
176	54	Q1	B	1
177	54	Q1	C	2
178	55	NF	A	2
179	55	NF	B	1
180	55	NF	C	0
181	56	Q3	A	2
182	56	Q3	B	1
183	56	Q3	C	0
184	57	Q4	A	2
185	57	Q4	B	1
186	57	Q4	C	0
187	58	A	A	0
188	58	A	B	1
189	58	A	C	2
190	59	B	A	0
191	59	B	B	1
192	59	B	C	0
193	60	B	A	0
194	60	B	B	0
195	60	B	C	1
196	61	C	A	2
197	61	C	B	1
198	61	C	C	0
199	62	E	A	2
200	62	E	B	1
201	62	E	C	0
202	63	F	A	0
203	63	F	B	1
204	63	F	C	2
205	64	F	A	0
206	64	F	B	1
207	64	F	C	2
208	65	G	A	0
209	65	G	B	1
210	65	G	C	2
211	66	H	A	0
212	66	H	B	1
213	66	H	C	2
214	67	I	A	0
215	67	I	B	1
216	67	I	C	2
217	67	DM	A	1
218	67	DM	B	0
219	67	DM	C	0
220	68	L	A	0
221	68	L	B	1
222	68	L	C	2
223	69	M	A	2
224	69	M	B	1
225	69	M	C	0
226	70	N	A	2
227	70	N	B	1
228	70	N	C	0
229	71	O	A	0
230	71	O	B	1
231	71	O	C	2
232	72	Q1	A	2
233	72	Q1	B	1
234	72	Q1	C	0
235	73	Q2	A	2
236	73	Q2	B	1
237	73	Q2	C	0
238	74	Q2	A	0
239	74	Q2	B	1
240	74	Q2	C	2
241	75	Q3	A	2
242	75	Q3	B	1
243	75	Q3	C	0
244	75	DM	A	1
245	75	DM	B	0
246	75	DM	C	0
247	76	Q4	A	2
248	76	Q4	B	1
249	76	Q4	C	0
250	77	A	A	2
251	77	A	B	1
252	77	A	C	0
253	78	B	A	0
254	78	B	B	1
255	78	B	C	0
256	79	B	A	0
257	79	B	B	0
258	79	B	C	1
259	80	C	A	2
260	80	C	B	1
261	80	C	C	0
262	81	E	A	0
263	81	E	B	1
264	81	E	C	2
265	82	F	A	2
266	82	F	B	1
267	82	F	C	0
268	83	G	A	2
269	83	G	B	1
270	83	G	C	0
271	84	H	A	0
272	84	H	B	1
273	84	H	C	2
274	84	DM	A	0
275	84	DM	B	0
276	84	DM	C	1
277	85	H	A	0
278	85	H	B	1
279	85	H	C	2
280	86	I	A	0
281	86	I	B	1
282	86	I	C	2
283	87	L	A	2
284	87	L	B	1
285	87	L	C	0
286	88	M	A	2
287	88	M	B	1
288	88	M	C	0
289	89	N	A	0
290	89	N	B	1
291	89	N	C	2
292	90	O	A	2
293	90	O	B	1
294	90	O	C	0
295	91	Q1	A	2
296	91	Q1	B	1
297	91	Q1	C	0
298	92	Q2	A	0
299	92	Q2	B	1
300	92	Q2	C	2
301	92	DM	A	1
302	92	DM	B	0
303	92	DM	C	0
304	93	Q3	A	2
305	93	Q3	B	1
306	93	Q3	C	0
307	94	Q3	A	0
308	94	Q3	B	1
309	94	Q3	C	2
310	95	Q4	A	0
311	95	Q4	B	1
312	95	Q4	C	2
313	95	DM	A	1
314	95	DM	B	0
315	95	DM	C	0
316	96	A	A	0
317	96	A	B	1
318	96	A	C	2
319	97	B	A	0
320	97	B	B	1
321	97	B	C	0
322	98	C	A	0
323	98	C	B	1
324	98	C	C	2
325	99	C	A	0
326	99	C	B	1
327	99	C	C	2
328	100	E	A	0
329	100	E	B	1
330	100	E	C	2
331	101	F	A	2
332	101	F	B	1
333	101	F	C	0
334	102	G	A	2
335	102	G	B	1
336	102	G	C	0
337	103	H	A	0
338	103	H	B	1
339	103	H	C	2
340	104	H	A	2
341	104	H	B	1
342	104	H	C	0
343	105	I	A	2
344	105	I	B	1
345	105	I	C	0
346	106	L	A	0
347	106	L	B	1
348	106	L	C	2
349	107	M	A	0
350	107	M	B	1
351	107	M	C	2
352	108	N	A	0
353	108	N	B	1
354	108	N	C	2
355	109	O	A	2
356	109	O	B	1
357	109	O	C	0
358	110	Q1	A	0
359	110	Q1	B	1
360	110	Q1	C	2
361	111	Q2	A	0
362	111	Q2	B	1
363	111	Q2	C	2
364	112	Q3	A	0
365	112	Q3	B	1
366	112	Q3	C	2
367	112	DM	A	0
368	112	DM	B	0
369	112	DM	C	1
370	113	Q4	A	2
371	113	Q4	B	1
372	113	Q4	C	0
373	113	DM	A	0
374	113	DM	B	0
375	113	DM	C	1
376	114	Q4	A	0
377	114	Q4	B	1
378	114	Q4	C	2
379	115	A	A	2
380	115	A	B	1
381	115	A	C	0
382	116	B	A	1
383	116	B	B	0
384	116	B	C	0
385	117	C	A	2
386	117	C	B	1
387	117	C	C	0
388	118	C	A	2
389	118	C	B	1
390	118	C	C	0
391	119	E	A	0
392	119	E	B	1
393	119	E	C	2
394	120	F	A	0
395	120	F	B	1
396	120	F	C	2
397	121	G	A	0
398	121	G	B	1
399	121	G	C	2
400	122	H	A	2
401	122	H	B	1
402	122	H	C	0
403	123	H	A	2
404	123	H	B	1
405	123	H	C	0
406	124	I	A	0
407	124	I	B	1
408	124	I	C	2
409	125	L	A	2
410	125	L	B	1
411	125	L	C	0
412	126	M	A	2
413	126	M	B	1
414	126	M	C	0
415	127	N	A	0
416	127	N	B	1
417	127	N	C	2
418	128	O	A	2
419	128	O	B	1
420	128	O	C	0
421	129	Q1	A	0
422	129	Q1	B	1
423	129	Q1	C	2
424	130	Q2	A	0
425	130	Q2	B	1
426	130	Q2	C	2
427	131	Q3	A	2
428	131	Q3	B	1
429	131	Q3	C	0
430	132	Q4	A	2
431	132	Q4	B	1
432	132	Q4	C	0
433	133	Q4	A	0
434	133	Q4	B	1
435	133	Q4	C	2
436	134	A	A	2
437	134	A	B	1
438	134	A	C	0
439	135	B	A	0
440	135	B	B	0
441	135	B	C	1
442	136	C	A	0
443	136	C	B	1
444	136	C	C	2
445	137	C	A	2
446	137	C	B	1
447	137	C	C	0
448	138	E	A	2
449	138	E	B	1
450	138	E	C	0
451	139	F	A	0
452	139	F	B	1
453	139	F	C	2
454	140	G	A	2
455	140	G	B	1
456	140	G	C	0
457	141	H	A	2
458	141	H	B	1
459	141	H	C	0
460	142	I	A	2
461	142	I	B	1
462	142	I	C	0
463	143	L	A	2
464	143	L	B	1
465	143	L	C	0
466	144	M	A	2
467	144	M	B	1
468	144	M	C	0
469	145	M	A	2
470	145	M	B	1
471	145	M	C	0
472	146	N	A	2
473	146	N	B	1
474	146	N	C	0
475	147	O	A	2
476	147	O	B	1
477	147	O	C	0
478	148	Q1	A	2
479	148	Q1	B	1
480	148	Q1	C	0
481	149	Q2	A	2
482	149	Q2	B	1
483	149	Q2	C	0
484	150	Q3	A	0
485	150	Q3	B	1
486	150	Q3	C	2
487	151	Q4	A	2
488	151	Q4	B	1
489	151	Q4	C	0
490	151	DM	A	0
491	151	DM	B	0
492	151	DM	C	1
493	152	Q4	A	0
494	152	Q4	B	1
495	152	Q4	C	2
496	153	A	A	0
497	153	A	B	1
498	153	A	C	2
499	154	B	A	2
500	154	B	B	1
501	154	B	C	0
502	155	C	A	0
503	155	C	B	1
504	155	C	C	2
505	156	E	A	2
506	156	E	B	1
507	156	E	C	0
508	157	E	A	2
509	157	E	B	1
510	157	E	C	0
511	158	F	A	2
512	158	F	B	1
513	158	F	C	0
514	159	G	A	2
515	159	G	B	1
516	159	G	C	0
517	160	H	A	0
518	160	H	B	1
519	160	H	C	2
520	161	I	A	0
521	161	I	B	1
522	161	I	C	2
523	162	L	A	0
524	162	L	B	1
525	162	L	C	2
526	163	M	A	2
527	163	M	B	1
528	163	M	C	0
529	164	M	A	2
530	164	M	B	1
531	164	M	C	0
532	165	N	A	2
533	165	N	B	1
534	165	N	C	0
535	166	O	A	2
536	166	O	B	1
537	166	O	C	0
538	167	Q1	A	2
539	167	Q1	B	1
540	167	Q1	C	0
541	168	Q2	A	2
542	168	Q2	B	1
543	168	Q2	C	0
544	169	Q3	A	2
545	169	Q3	B	1
546	169	Q3	C	0
547	170	Q4	A	2
548	170	Q4	B	1
549	170	Q4	C	0
550	170	DM	A	0
551	170	DM	B	0
552	170	DM	C	1
553	171	Q4	A	0
554	171	Q4	B	1
555	171	Q4	C	2
556	172	A	A	2
557	172	A	B	1
558	172	A	C	0
559	173	B	A	1
560	173	B	B	0
561	173	B	C	0
562	174	C	A	2
563	174	C	B	1
564	174	C	C	0
565	175	E	A	2
566	175	E	B	1
567	175	E	C	0
568	175	DM	A	1
569	175	DM	B	0
570	175	DM	C	0
571	176	E	A	2
572	176	E	B	1
573	176	E	C	0
574	177	F	A	2
575	177	F	B	1
576	177	F	C	0
577	178	G	A	2
578	178	G	B	1
579	178	G	C	0
580	179	H	A	2
581	179	H	B	1
582	179	H	C	0
583	180	I	A	2
584	180	I	B	1
585	180	I	C	0
586	181	L	A	2
587	181	L	B	1
588	181	L	C	0
589	182	M	A	0
590	182	M	B	1
591	182	M	C	2
592	183	M	A	0
593	183	M	B	1
594	183	M	C	2
595	184	N	A	2
596	184	N	B	1
597	184	N	C	0
598	185	O	A	0
599	185	O	B	1
600	185	O	C	2
601	186	Q1	A	0
602	186	Q1	B	1
603	186	Q1	C	2
604	187	NF	A	0
605	187	NF	B	0
606	187	NF	C	0
\.


--
-- Data for Name: consumos_ia; Type: TABLE DATA; Schema: pruebas16pf; Owner: ats_n8n
--

COPY pruebas16pf.consumos_ia (id, interpretacion_id, tokens_entrada, tokens_salida, generado_en) FROM stdin;
37	91	738	418	2025-09-26 20:06:40.228502
38	92	802	431	2025-09-26 20:25:21.010458
39	93	700	365	2025-09-26 20:28:53.374857
40	94	784	409	2025-09-29 16:42:07.139769
41	95	784	444	2025-09-29 16:48:21.478758
42	96	784	394	2025-09-29 16:52:19.534789
44	98	769	317	2025-09-29 19:59:35.001813
45	99	106	301	2025-09-29 20:16:26.706368
46	100	740	375	2025-09-29 20:19:58.101028
47	101	743	395	2025-09-29 20:51:54.618213
48	102	752	398	2025-09-30 20:31:16.274708
49	103	757	340	2025-09-30 20:35:42.564169
50	104	784	401	2025-09-30 21:36:12.695109
51	105	815	368	2025-09-30 23:02:00.073099
52	106	732	346	2025-10-01 14:03:49.281864
53	107	792	434	2025-10-01 14:10:20.743444
54	108	799	419	2025-10-01 18:05:36.950973
55	109	760	409	2025-10-01 18:16:57.717971
56	110	760	376	2025-10-01 18:18:10.422469
57	111	769	380	2025-10-01 22:20:07.11341
58	112	768	442	2025-10-01 23:32:26.366211
59	113	770	409	2025-10-02 22:05:52.260435
60	114	744	424	2025-10-02 22:54:14.412361
61	115	744	386	2025-10-03 02:02:37.366332
62	116	744	378	2025-10-03 02:03:09.569274
63	117	766	399	2025-10-03 14:43:15.544346
64	118	761	338	2025-10-03 15:05:59.918486
65	119	772	397	2025-10-03 15:29:32.468672
\.


--
-- Data for Name: factores_16pf; Type: TABLE DATA; Schema: pruebas16pf; Owner: ats_n8n
--

COPY pruebas16pf.factores_16pf (codigo, nombre, descripcion) FROM stdin;
A	Afectividad	Reservado / Abierto
B	Razonamiento	Concreto / Abstracto
C	Estabilidad Emocional	Inestabilidad Emocional / Estabilidad emocional
E	Dominancia	Sumiso / Dominante
F	Impulsividad	Prudente / Impulsivo
G	Normas	Despreocupado / Escrupuloso
H	Atrevimiento Social	Tímido / Espontáneo
I	Sensibilidad	Racional / Emocional
L	Confianza	Confiado / Suspicaz
M	Imaginación	Práctico / Soñador
N	Astucia	Sencillo / Astuto
O	Seguridad	Seguro / Inseguro
Q1	Apertura al cambio	Tradicionalista / Innovador
Q2	Autosuficiencia	Dependencia del grupo / Autosuficiencia
Q3	Autocontrol	Desinhibido / Controlado
Q4	Tensión	Tranquilo / Tensionado
NF	Sin factor	Esta pregunta no se asocia a un factor
DM	Distorsion	Distorsionador para aplicarlo en la conversion de decatipos
\.


--
-- Data for Name: horarios_disponibles; Type: TABLE DATA; Schema: pruebas16pf; Owner: ats_n8n
--

COPY pruebas16pf.horarios_disponibles (id, fecha, hora, cupos_maximos, cupos_ocupados, activo) FROM stdin;
\.


--
-- Data for Name: interpretaciones_16pf; Type: TABLE DATA; Schema: pruebas16pf; Owner: ats_n8n
--

COPY pruebas16pf.interpretaciones_16pf (id, factor, nivel, descripcion) FROM stdin;
1	A	Bajo	Persona que da pocas demostraciones de afecto, generalmente es retraída, fría. Le gusta más trabajar sola.
2	A	Medio	Es una persona que no tiene preferencias entre permanecer y trabajar sola, o ser participativa socialmente.
3	A	Alto	Persona afectuosa, participativa y colaboradora . Prefiere trabajar en grupos.
4	B	Bajo	Dificultad en el manejo de problemas a nivel abstracto, se inclina en hacerlo a nivel concreto. De juicio intelectual pobre.
6	B	Alto	Presenta alto nivel de razonamiento abstracto. Demuestra ser de rápida comprensión y aprendizaje de ideas.
8	C	Medio	Es una persona que esta medianamente estable. El algunas ocasiones se puede mostrar inestable emocionalmente.
9	C	Alto	Es una persona emocionalmente estable, madura y realista.  No deja que sus necesidades emocionales afecten la realidad de las situaciones.
10	E	Bajo	La persona es sumisa, cede fácilmente ante los demás, es dócil y conformista. Es modesta, humilde y obediente.
11	E	Medio	Persona que presenta niveles equilibrados entre ser sumisa y dominante.
12	E	Alto	Es una persona dominante, le gusta controlar las situaciones y las personas.
13	F	Bajo	Es prudente e instrospectiva. Reflexiva, presenta temor a cometer errores y tiene indecisión acerca de tomar riesgos.
14	F	Medio	Es una persona con un nivel intermedio entre ser prudente y ser impulsiva.
15	F	Alto	Es una persona impulsiva. Demasiado franca.  Responde con rapidez a los eventos que sean de su interés.
16	G	Bajo	La persona suele ser inestable en sus propósitos. Demuestra alta despreocupación y muy poca consideración por las normas de la sociedad.
17	G	Medio	Presenta un nivel intermedio en su nivel de responsabilidad y en aceptar las normas sociales.
18	G	Alto	Esta dominada por el sentido del deber, perseverante, responsable y organizada. Es escrupulosa y moralista.
19	H	Bajo	Es una persona sociable y espontánea. Dispuesta a intentar nuevas cosas, de numerosas respuestas emocionales.
20	H	Medio	Es una persona con disposición a ser sociable y espontánea. Dispuesta en algunas ocasiones a ser atrevida e intentar nuevas cosas.
21	H	Alto	Suele ser tímida, muy retraída. Se muestra cohibida y con falta de confianza en si misma. Puede presentar sentimientos de inferioridad. Se retrae fácilmente ante el sexo apuesto.
22	I	Bajo	Es dura sentimentalmente. Actúa más basada en evidencias prácticas y lógicas. Es confiada de sí misma, acepta resopnsabilidades.  Espera poco de las personas.
23	I	Medio	La persona actúa como igual facilidad entre las respuestas de pensamiento y sentimiento.
24	I	Alto	Es afectada por los sentimientos,  bastante sensible. Se muestra inquieta, espera afecto y atención.  Es indulgente consigo y con los demás.
25	L	Bajo	Es una persona confiada, comprensiva, permisiva y tolerante. Cede ante los cambios, no parece preocupada por corregir a los demás. Se sobrepone con facilidad a las dificultades.
26	L	Medio	Presenta un nivel intermedio de confianza en las persona y en las situaciones.
27	L	Alto	Es una persona celosa, desconfiada de las situaciones y de la gente. Insiste en hacer comprender su opinión, busca y exige  que los demás reconozcan los errores que han cometido.
28	M	Bajo	Es una persona preocupada por intereses y hechos inmediatos. Se muestra ansiosa por hacer cosas correctamente. Antenta los problemas prácticos y cercanos.
29	M	Medio	Persona que esta guiada por realidades objetivas o en ocasiones puede ser imaginativa y abstraerse en su pensamientos.
30	M	Alto	Persona muy imaginativa, se abstrae mucho en sus pensamientos. Se entusiasma rápidamente, cambia y abandona las ideas bruscamente.
31	N	Bajo	Es sencilla, natrual y poco sofisticada. Se le satisface y se muestra contenta con lo que acontece, es sincera e ingenua.
32	N	Medio	Puede ser sencilla e ingenua socialmente o calculadora en ocasiones.
33	N	Alto	Es sumamente astuta, exacta y calculadora. Diplomática , calculadora,  se desenvuelve bien en grupo. Ambisiosa y perspicaz.
34	O	Bajo	Persona segura, tranquila, flexible y serana. Nio le preocupa la aprobación de los demás. No se culpa por acciones erradas, actúa libremente sin temores.
35	O	Medio	Es una persona que puede mostrarse segura, tranquila, flexible y serena. Tiende a no culparse por sus acciones erradas, trata de actuar libremente sin temores, aunque en algunas ocasiones puede mostrar lo contrario.
36	O	Alto	Es una persona insegura, intranquila, preocupada y deprimida. Se culpa por sus acciones erradas. Se afecta con facilidad, es muy sensible a la aprobación de los demás.
37	Q1	Bajo	Es conservadora, respetuosa de las ideas establecidas, tolerante de los defectos tradicionales. Es precavida y resistente a las nuevas ideas, postone los cambios, sigue la línea tradicional es convencionalista.
38	Q1	Medio	Tiende a presentar interés por las nuevas ideas. Por lo general tiene actitudes de innovación y reacción ante lo establecido. Es poco convencionalista.
39	Q1	Alto	Persona con interés por las nuevas ideas. Presenta actitudes de innovación y reacción ante lo establecido, prefiere sus propias decisiones. Analítico y autónomo en su forma de pensar.
40	Q2	Bajo	Dependiente del grupo. Prefiere estar en compañia y decide sobre lo correcto de su desempeño al compararse con otros más que confiar en su propio juicio. Se une fácil al grupo.
41	Q2	Medio	Tiende a ser autosuficiente e ingeniosa, llena de recursos, prefiere sus propias decisiones. Usualmente busca resolver los problemas por sí misma.
42	Q2	Alto	Es autosuficiente, ingeniosa y llena de recursos, prefiere las propias decisiones. Busca resolver problemas por sí misma.
43	Q3	Bajo	Da poca importancia a como la perciben los demás y suele hacer lo que desea. Tiene poco autocontrol. Mantiente poca congruencia entre su autoconcepto percibido y deseado.
44	Q3	Medio	Tiene un nivel intermedio entre el autocontrol y la congruencia entre su autoconcepto percibido y deseados, de acuerdo con su cultura.
45	Q3	Alto	Tiene signos de perfeccionista, con alta congruencia en el autoconcepto percibido y el deseado. Alto nivel de autocontrol.
7	C	Bajo	Demasiado afectada por los sentimientos cuando se frustra, inestable emocionalmente. Tiende a evadir responsabilidades.
46	Q4	Bajo	Es una persona callada, relajada, tranquila. Es algunas situaciones su estado de mucha satisfacción le puede llevar a la pereza y al bajo rendimiento.
47	Q4	Medio	Presenta intermedio entre el estado de tensión y de tranquilidad ante sí mismo y ante la situaciones.
48	Q4	Alto	Es una persona con características de estar tensa, excitable e intranquila. Puede presentar bloqueos de ansiedad.
5	B	Medio	Es una persona de juicio intelectual intermedio, no tiene niveles altos en manejar relaciones en termino de como se sitúan las cosas,  sin embargo tampoco es bajo.
\.


--
-- Data for Name: interpretaciones_ia; Type: TABLE DATA; Schema: pruebas16pf; Owner: ats_n8n
--

COPY pruebas16pf.interpretaciones_ia (id, aspirante_id, texto_generado, generado_en, fuente_modelo) FROM stdin;
94	20	El perfil de Sandra Lorena Mora Peralta, para el cargo de Vendedor en punto de venta, presenta varias características que pueden ser favorables o desafiantes en dicho rol. Su nivel alto de estabilidad emocional (80%) indica que es una persona equilibrada, madura y capaz de manejar situaciones de estrés con serenidad, lo cual es crucial en ambientes comerciales donde la presión y la necesidad de mantener la calma son constantes. Además, su tendencia a ser reservada y participativa (80%) puede facilitar su trabajo en equipo, mostrando disposición para colaborar con colegas y clientes sin ser excesivamente tímida, aunque también puede requerir estrategias para potenciar sus habilidades de comunicación y apertura en el trato directo con clientes.\n\nSin embargo, algunos aspectos podrían presentar obstáculos. Su puntuación en timidez y retraimiento (70%) junto con la tendencia a sentirse insegura y con sentimientos de inferioridad podrían limitar su eficacia en ventas, especialmente en contextos donde la proactividad, la confianza y la interacción social son esenciales para persuadir y captar clientes. La dificultad para expresarse espontáneamente y la tendencia a retraerse en situaciones sociales puede reducir su capacidad para establecer relaciones rápidas y de confianza con los clientes, aspectos cruciales en un vendedor de punto de venta. Por otro lado, su alto nivel en control, astucia y autocontrol (70-80%) sugiere que puede usar su habilidad para planificar y calcular estrategias de venta, lo cual puede ser una fortaleza si logra superar sus aspectos más inhibidos.\n\nEn conclusión, el nivel de ajuste de Sandra para el cargo de Vendedor en punto de venta es **MEDIO**. Sus cualidades de estabilidad emocional y autocontrol le aportan una base sólida para desempeñarse, pero su tendencia a la timidez y la inseguridad pueden requerir acompañamiento en habilidades sociales y técnicas de ventas. Con entrenamiento en habilidades de comunicación y estrategias para potenciar su confianza, puede transformar estos aspectos en ventajas, haciendo que su perfil se adapte adecuadamente a las exigencias del rol.	2025-09-29 16:42:07.139769	gpt-4.1-nano-2025-04-14
91	14	El perfil de Valeria Saraza Pineda, para el cargo de Vendedora en punto de venta, presenta aspectos tanto positivos como preocupantes respecto a su ajuste al puesto. Por un lado, su alta puntuación en "Sencillo / Astuto" (70%) y en "Seguro / Inseguro" (70%) indica que es una persona astuta, diplomática, con capacidad de desenvolverse en grupo, y con cierta confianza en sí misma, cualidades importantes para interactuar con clientes y gestionar situaciones en el punto de venta. Además, su tendencia a ser reservada, participativa y colaboradora la hace apta para trabajar en equipo, facilitando la adaptación a ambientes grupales de trabajo.\n\nPor otro lado, su puntuación extremadamente elevada en "Tensionado / Tranquilo" (90%) y en "Inestabilidad Emocional" (30%) revela una vulnerabilidad significativa frente a la presión y la frustración, posiblmente perjudicando su desempeño en un entorno de ventas que requiere estabilidad emocional y resistencia al estrés. La tendencia a ser insegura, preocupada y sensible a la aprobación también representa un riesgo en contextos donde la autoconfianza, la seguridad y la autonomía son fundamentales. La baja puntuación en "Tradicionalista / Innovador" (10%) puede ser positiva, ya que puede favorecer una mayor apertura a nuevas estrategias o enfoques si se trabaja en esto, pero también puede dificultar la adaptación a cambios o innovación en el proceso de ventas.\n\nEn conclusión, el perfil de Valeria muestra fortalezas en habilidades sociales, colaboración y astucia, que son valiosas para un vendedor en punto de venta. Sin embargo, su alta tensión emocional y tendencia a la inseguridad sugieren que podría experimentar dificultades para mantener un desempeño consistente en situaciones de alta presión o rechazo, aspectos críticos en ventas. Por ello, el nivel de ajuste es MEDIO, recomendándose estrategias de acompañamiento y desarrollo emocional para potenciar sus habilidades y reducir las posibles limitantes emocionales que puedan afectar su rendimiento laboral.	2025-09-26 20:06:40.228502	gpt-4.1-nano-2025-04-14
92	12	El perfil de Maribel Muñoz García para el cargo de Vendedora punto de venta presenta varias fortalezas que indican un ajuste medio a alto para esta posición. Su estabilidad emocional (100%) y su tendencia a ser confiada (30%) indican que es una persona equilibrada emocionalmente, capaz de manejar situaciones de presión y mantener la calma en el entorno laboral. Estas características son valiosas en ventas, donde la tranquilidad y la confianza transmitida al cliente son esenciales para construir relaciones y cerrar negocios.\n\nAdemás, su alto nivel de autocontrol y perfeccionismo (100% en desinhibido/controlado) sugiere que puede mantener un comportamiento profesional, seguir procedimientos y ser persistente en sus actividades, lo cual es importante en la atención al cliente y en la gestión de metas de venta. Su perfil social, que muestra tendencia a la apertura y sociabilidad (80%) junto con una habilidad astuta y diplomática (70%), facilita la interacción con los clientes, permitiéndole desenvolverse de manera adecuada en el punto de venta. Sin embargo, su tendencia a ceder fácilmente y su bajo nivel de dominancia (30%) podrían limitar su capacidad de influir en situaciones en las que es necesario tener un liderazgo o tomar decisiones firmes frente a clientes difíciles o en negociaciones complejas.\n\nPor otro lado, aspectos como su tendencia a la autosuficiencia (60%) y su actitud moderadamente innovadora (50%) muestran que puede resolver problemas de manera autónoma y adaptarse a nuevas estrategias o productos, pero podría beneficiarse de mayor iniciativa para destacar en el rol. La tendencia a ser astuta y calculadora, junto con su prudencia intermedia, le permitirá planificar y actuar con estrategia, aunque en ocasiones puede carecer de la eficiencia en la acción impulsiva que puede ser necesaria en ventas dinámicas o en situaciones de alta presión. En conclusión, su perfil sugiere un candidato con buenas capacidades emocionales, socialización y autocontrol, que si recibe un entrenamiento adecuado, puede ajustarse bien al cargo, aunque sería recomendable potenciar su liderazgo y proactividad en contextos que lo requieran.\n\n	2025-09-26 20:25:21.010458	gpt-4.1-nano-2025-04-14
93	13	El perfil de Luis Eduardo Holguín para el cargo de Vendedor en punto de venta muestra un nivel de ajuste **ALTO**. Su alta sociabilidad, reflejada en un 80% en la dimensión reservado / abierto, indica que es una persona afectuosa, participativa, colaboradora y con predisposición a trabajar en grupo, cualidades esenciales para un rol que requiere interacción constante con clientes y colegas. Además, su tendencia hacia la independencia (60% autosuficiente) y su interés en innovar (60% en tradicionalista / innovador) sugieren que puede adaptarse bien a un entorno dinámico y orientado a resultados, manejando sus propias decisiones con relativamente poca dependencia del grupo.\n\nPor otro lado, su perfil muestra una significativa tendencia hacia la creatividad e imaginación (90% en práctico / soñador), lo cual puede ser una ventaja en la generación de ideas y en brindar un enfoque diferente en la atención al cliente. Sin embargo, esta tendencia también puede implicar cierta dispersión o dificultad para mantener un enfoque constante en tareas repetitivas, por lo que sería importante que se acompañe de una orientación a la planificación y organización. La elevada autocontrol (80% en desinhibido / controlado) reafirma su capacidad de mantener la calma y actuar de manera planificada, valor que favorece el manejo de una situación comercial en puntos de venta.\n\nEn síntesis, el perfil de Luis Eduardo presenta características compatibles con las exigencias del puesto de vendedor, especialmente en cuanto a sociabilidad, autonomía, creatividad y autocontrol. La combinación de estos aspectos indica un ajuste **ALTO**, siempre que se apoye en una formación que potencie la estabilidad emocional y la gestión del ánimo para maximizar su desempeño en un rol que requiere interacción constante, flexibilidad y autonomía.	2025-09-26 20:28:53.374857	gpt-4.1-nano-2025-04-14
95	20	El perfil de Sandra Lorena Mora Peralta presenta varias características que facilitan su ajuste positivo para el cargo de vendedor en punto de venta, aunque con ciertas consideraciones. Su alto nivel en estabilidad emocional (80%) indica que es una persona madura, equilibrada y capaz de manejar con serenidad las situaciones cotidianas que pueda enfrentar en el puesto. Este rasgo es fundamental en el rol de ventas, donde es importante mantener la calma y proyectar confianza ante los clientes. Además, su tendencia a ser reservada y tímida (70%) puede considerarse una dificultad, ya que en ventas es importante tener habilidades sociales y de comunicación abiertas; sin embargo, su disposición a trabajar en grupos y su alta astucia (80%) sugieren que puede desarrollar estrategias efectivas para compensar esta reserva.\n\nOtra fortaleza notable es su alta tendencia a ser organizada, responsable y con fuerte sentido del deber (70%), lo cual es esencial para cumplir con metas de ventas y mantener un buen manejo del tiempo y seguimiento en sus tareas. Asimismo, su nivel intermedio de confianza (50%) y autosuficiencia (60%) le permiten tomar decisiones y resolver problemas de manera independiente, aunque su tendencia a la inseguridad ocasional podría requerir acompañamiento o capacitación en técnicas de venta y autoconfianza para potenciar su rendimiento. La tendencia a ser controlada y perfeccionista (70%) puede traducirse en una actitud meticulosa en la atención al cliente y en la gestión de sus tareas, lo cual es valioso siempre que no lleve a excesivos niveles de autocontrol que puedan limitar su espontaneidad.\n\nEn conclusión, Sandra presenta un perfil bastante favorable para el rol de vendedor en punto de venta, debido a su estabilidad emocional, responsabilidad y su capacidad para actuar con autocontrol. Sin embargo, su timidez y tendencia a la inseguridad requerirán estrategias de desarrollo en habilidades sociales y comunicación, para que pueda interactuar de manera más efectiva con los clientes. Su perfil sugiere un nivel de ajuste **ALTO**, siempre que se brinden apoyos adecuados en áreas de comunicación y desarrollo de confianza en sí misma, y se le facilite un entorno que valore su responsabilidad y organización.	2025-09-29 16:48:21.478758	gpt-4.1-nano-2025-04-14
96	20	El perfil de Sandra Lorena Mora Peralta, para el cargo de vendedor en punto de venta, presenta varias características que en general sugieren un alto nivel de ajuste. Su estabilidad emocional (80%) indica que es una persona madura, equilibrada y capaz de mantener la calma en diferentes situaciones, lo cual es esencial para gestionar el contacto con clientes y manejar posibles conflictos o rechazos en ventas. Además, su tendencia a ser reservada, colaborativa y participativa (80%) junto con su buena orientación hacia el grupo facilita su integración en el entorno de trabajo y su capacidad para desarrollar relaciones interpersonales efectivas, contribuyendo a un buen desempeño en roles de atención presencial.\n\nPor otro lado, aspectos como su tendencia a ser tímida y retraída (70%) pueden representar un reto en un cargo que requiere incluir procesos activos de persuasión y generación de confianza en el cliente. Sin embargo, su nivel de autonomía (60%) y su autocontrol elevado (70%) indican que puede compensar esta tendencia inicial, logrando establecer relaciones cuando se le brinda la oportunidad y el apoyo adecuado. Además, sus cualidades de ser astuta, calculadora, y organizada (80% en satisfacción con control), le permiten planificar y actuar con estrategia y prudencia, elementos valiosos en la atención al cliente y cierre de ventas.\n\nFinalmente, si bien tiene una orientación conservadora y un perfil tradicionalista (30%), su carácter práctico, reflexivo y su nivel medio en confianza (50%) permiten que pueda adaptarse de manera efectiva a las normativas y procedimientos del puesto, siempre que reciba el apoyo y entrenamiento necesario. En conjunto, el perfil de Sandra presenta un ajuste **ALTO** para el cargo de vendedor en punto de venta, destacando su estabilidad emocional, habilidades sociales moderadas, y su carácter calculador y organizado, que le facilitara desarrollar tareas relacionadas con la atención y fidelización del cliente, en línea con las demandas del puesto.	2025-09-29 16:52:19.534789	gpt-4.1-nano-2025-04-14
98	24	El perfil del aspirante Hernán Bermúdez, en relación con el cargo de vendedor en punto de venta, muestra varias características que indican un nivel de ajuste MEDIO. Hernández presenta una tendencia a ser un individuo afectuoso, participativo y colaborador (80% en reservado/open), lo cual es positivo para roles que requieren interacción constante con clientes y trabajo en equipo. Sin embargo, su alta timidez (70%) y tendencia a la inseguridad (60%) pueden afectar la confianza y la asertividad necesarias en la venta directa, especialmente en situaciones donde requiere persuadir o negociar con mayor espontaneidad.\n\nPor otro lado, su estabilidad emocional (70%) y autosuficiencia (70%) aportan a su capacidad para manejar situaciones de presión o rechazo común en ventas, facilitando una respuesta más adaptativa frente a las dificultades. La tendencia hacia la creatividad y la imaginación (70%) en contraste con sus niveles intermedios en control (60%) y tranquilidad (50%) sugiere que puede mostrar flexibilidad y adaptabilidad, aunque quizás necesite apoyo en la autoconfianza para proyectar mayor seguridad en su interacción con clientes.\n\nEn conclusión, Hernán tiene potencial para desempeñarse en el rol de vendedor en punto de venta, pero su ajuste sería MEDIO, requiriendo desarrollo en áreas relacionadas con la autoconfianza y habilidades de comunicación asertiva para potenciar su desempeño. La orientación en entrenamiento en técnicas de comunicación, manejo del rechazo y fortalecimiento de la autoestima sería recomendable para mejorar su efectividad y seguridad en el cargo.	2025-09-29 19:59:35.001813	gpt-4.1-nano-2025-04-14
99	23	Lamentablemente, no se han proporcionado los resultados específicos del test 16PF para María Alejandra Chitiva Rodríguez, lo que limita una evaluación precisa. Sin embargo, puedo ofrecer una explicación general de cómo ciertos perfiles en el 16PF podrían relacionarse con el cargo de vendedor en punto de venta.\n\nPara un puesto de vendedor en punto de venta, generalmente se busca un perfil con alto nivel en fatores como Sociabilidad (F), que refleja facilidad para relacionarse y generar confianza con los clientes, y Ambición (A), que indica motivación y orientación a resultados. La estabilidad emocional y la capacidad de manejar la presión también son importantes, lo que correlaciona con niveles adecuados en Ansiedad (O). Si María muestra estos rasgos, su perfil sería compatible con las demandas del rol, permitiendo destacar en atención al cliente, persuasión y trabajo en ambientes dinámicos.\n\nPor otro lado, aspectos como la Dotación de energía (E) y la Dominancia (H) también son relevantes, pues un vendedor efectivo necesita ser proactivo, con iniciativa y capacidad de liderazgo en interacciones con los clientes y colegas. Si su perfil refleja estos atributos en niveles adecuados o altos, el ajuste sería positivo. En definitiva, sin los resultados específicos, la recomendación general sería esperar perfiles con altos o moderados niveles en Sociabilidad, Ambición y Energía, lo que indicaría un ajuste **ALTO**, siempre que otros factores como estabilidad emocional y apertura sean también favorables.	2025-09-29 20:16:26.706368	gpt-4.1-nano-2025-04-14
100	26	El perfil de Erika Daniela Ruíz Reyes presenta un nivel de ajuste ALTO para el puesto de Vendedor en punto de venta, debido a varias características personales que favorecen su desempeño en esta función. La elevada estabilidad emocional (90%) indica que es una persona capaz de mantener la calma en situaciones de presión, manejar el estrés y actuar con madurez, cualidades esenciales en un entorno comercial donde la resiliencia y el control emocional son fundamentales. Además, su alta capacidad de autocontrol (80%) y tendencia a ser perfeccionista y organizado contribuyen a que pueda mantener una actitud profesional y confiable ante los clientes y en sus tareas diarias, asegurando una presentación adecuada y comportamientos consistentes.\n\nPor otro lado, su perfil revela ciertas características que, si bien pueden presentar desafíos, no comprometen el desempeño en la función de ventas en punto de venta. La tendencia a ser reservada y tímida (70%) puede afectar su capacidad para establecer relaciones cercanas y proyectar confianza rápidamente, aspectos importantes en ventas. Sin embargo, su nivel moderado en confianza (40%) y su autoconocimiento permiten que, con entrenamiento y apoyo, pueda desarrollar habilidades sociales y técnicas de persuasión. Además, su tendencia a ser imaginativa y a cambiar de ideas rápidamente (70%) puede facilitar la creatividad en la estrategia de abordaje y cierre de ventas si logra canalizar esa energía de manera productiva.\n\nEn conclusión, el perfil de Erika indica un nivel alto de ajuste para el cargo de Vendedor en punto de venta, dado su control emocional, disciplina, y estabilidad, que favorecen el logro de objetivos y la relación con clientes en un ambiente dinámico. Sin embargo, sería recomendable acompañar su proceso de integración con intervención en habilidades sociales y técnicas de venta para potenciar su confianza y habilidades comunicativas, maximizando así su potencial en el rol.	2025-09-29 20:19:58.101028	gpt-4.1-nano-2025-04-14
101	23	El perfil de Maria Alejandra Chitiva Rodríguez muestra un nivel de ajuste ALTO para el cargo de Vendedora en punto de venta. Su alta estabilidad emocional (100%) indica que puede mantener la calma y responder de manera racional ante las presiones y situaciones dinámicas del entorno comercial, facilitando un buen manejo del estrés y una actitud confiada que es favorable en ventas. Además, su tendencia a ser una persona reservada y participativa en grupos (80%), junto con su autosuficiencia y preferencia por decisiones independientes (60%), la habilitan para establecer relaciones con clientes sin parecer demasiado dependiente o insegura, lo que favorece la confianza y la credibilidad en su rol.\n\nSus niveles de control y autocontrol (80%) sugieren que posee una fuerte disciplina y atención a los detalles, atributos esenciales en un vendedor que necesita ser perseverante, organizado y cumplir con metas. La tendencia a ser una persona confiada, con tendencia a ser práctica y realista (confiada 20%, práctica 50%), combina bien con la dinámica de identificar necesidades del cliente y ofrecer soluciones efectivas. Sin embargo, su perfil también muestra cierta apertura a nuevas ideas (40% en innovador), lo cual puede facilitar la adaptación a nuevos productos, técnicas de venta y cambios en el mercado.\n\nPor otro lado, algunos aspectos deben tenerse en cuenta para asegurar un ajuste óptimo: aunque su perfil de espontaneidad (50%) y sencillez (60%) favorece relaciones naturales y genuinas, su bajo nivel en tensión (30%) podría limitar su motivación en escenarios que requieren mayor perseverancia y resistencia ante la competencia o posibles rechazos. Sin embargo, en general, sus características de autocontrol, estabilidad emocional y apertura moderada sugieren que es una candidata con potencial para desempeñarse eficazmente en ventas en puntos de venta, siempre y cuando se le brinde ambiente que promueva su motivación y esfuerzo sostenido.	2025-09-29 20:51:54.618213	gpt-4.1-nano-2025-04-14
102	34	El perfil de Jenifer Cárdenas Grajales, en relación con el cargo de Vendedora en punto de venta, presenta un nivel de ajuste **MEDIO**. Su alta estabilidad emocional (80%) y tendencia a ser reservada (80%) sugieren que es una persona madura, tranquila y capaz de mantener la compostura en situaciones de presión o rechazo, característica valiosa para un entorno de ventas donde la paciencia y la serenidad son fundamentales. Sin embargo, su elevada timidez (90%) y sentimientos de inseguridad (70%) podrían limitar su proactividad y la confianza en sí misma, aspectos que son esenciales para conectar efectivamente con los clientes, persuadir y abrirse a la interacción con el público.\n\nPor otro lado, aspectos como su tendencia a ser dominante (70%) y autosuficiente (70%) pueden ser ventajas si se canalizan adecuadamente, ya que reflejan determinación y autonomía en la gestión de tareas y en la toma de decisiones. La moderada impulsividad (60%) y el equilibrio entre prudencia e impulsividad sugieren que puede adaptarse a diferentes situaciones de venta, actuando con cierta flexibilidad. El hecho de que sea sencilla, sincera y tradicionalista (30% en innovación) puede favorecer la creación de relaciones de confianza con clientes que valoran la honestidad y la experiencia comprobada, aunque requiere trabajo en potenciar su confianza y autonomía en el contexto de ventas para maximizar su potencial.\n\nEn general, sin embargo, la combinación de su timidez significativa y sensibilidad a la evaluación social hace que su ajuste para este rol sea **medio**. Sería recomendable fortalecer habilidades sociales, autoconfianza y técnicas de venta para que Jenifer pueda convertir sus fortalezas, como su estabilidad emocional y su perseverancia, en ventajas que le permitan desempeñarse con mayor efectividad en un entorno competitivo y dinámico. Capacitación y acompañamiento en estas áreas podrían elevar su desempeño y adaptación al puesto.	2025-09-30 20:31:16.274708	gpt-4.1-nano-2025-04-14
103	31	El perfil de Jenifer Serna Giraldo presenta un ajuste alto para el cargo de Vendedora en punto de venta. Su tendencia a ser abierta (80%), sociable y colaborativa, favorece el trabajo en equipo y la creación de relaciones cercanas con clientes, lo cual es fundamental en ventas. Además, sus niveles de estabilidad emocional (70%) y control (80%) indican que puede mantener la calma y una actitud confiada en situaciones de presión, características deseables para afrontar las demandas del rol de ventas en un entorno dinámico.\n\nNo obstante, ciertos aspectos requieren atención. La alta tendencia a la timidez (80%) y la falta de confianza en sí misma, también señalada por sus bajos niveles en confiabilidad (20%), sugieren que podría experimentar dificultades iniciales para establecer relaciones con clientes o para afrontar retos que exijan una postura más asertiva y persuasiva. La capacidad de desenvolverse efectivamente en ventas suele requerir cierta seguridad y dominio del diálogo, por lo que estas características podrían limitar su desempeño si no se trabaja en el desarrollo de habilidades sociales más activas.\n\nFinalmente, aunque su perfil muestra resiliencia emocional y autocontrol, el carácter retraído y tímido impone una limitación media en su ajuste global para este cargo específico. Sin embargo, si recibe formación en técnicas de ventas, desarrollo de habilidades sociales y aumento de la confianza en sí misma, puede potenciar estas fortalezas y disminuir las barreras naturales a su desempeño, logrando un ajuste observablemente alto a las demandas del rol. Por ello, se recomienda apoyar su integración mediante capacitación especializada, para que su perfil pueda adaptarse de manera efectiva y maximizar su potencial en ventas.	2025-09-30 20:35:42.564169	gpt-4.1-nano-2025-04-14
104	20	El perfil de Sandra Lorena Mora Peralta muestra un nivel de ajuste ALTO para el cargo de Vendedora en punto de venta. Su alta estabilidad emocional (80%) indica que es una persona madura, equilibrada y capaz de manejar la presión inherente a un entorno de ventas, lo cual es fundamental para mantener una actitud positiva y profesional ante posibles rechazos o situaciones estresantes. Además, su perfil de confianza moderada (50%) sugiere que puede desenvolverse con cierta seguridad, aunque también es probable que experimente momentos de inseguridad que, si bien no son predominantes, deben tenerse en cuenta en su proceso de integración y formación.\n\nSu tendencia a ser reservada y tímida (70%) puede representar un reto en un rol que requiere interacción constante con clientes y dinamismo en la atención al público. Sin embargo, su alta puntuación en ser astuta, diplomática y perspicaz (80%) indica que posee habilidades sociales y de percepción suficientemente desarrolladas para aprender estrategias de comunicación efectivas. Además, su autocontrol alto (70%) y tendencia a ser prudente y reflexiva (20%) sugieren que, con entrenamiento en habilidades de ventas y socialización, puede adquirir mayor confianza y desenvolverse con éxito en el puesto, siendo consciente de sus procesos, lo que favorece una actuación consistente y ética.\n\nFinalmente, otros aspectos como su resistencia a los cambios (30%) y tendencia a ser conservadora (30%) indican que podría mostrar resistencia a cambios dinámicos o innovaciones frecuentes en el proceso de ventas. Sin embargo, su autonomía (60%) y capacidad para resolver problemas por sí misma son ventajas importantes para adaptarse y avanzar en entornos que requieren iniciativa personal y perseverancia. En conjunto, el perfil de Sandra muestra un nivel de ajuste ALTO, considerando sus potencialidades para desarrollar habilidades sociales y de gestión emocional que le permitan superar obstáculos propios de la labor de ventas, siempre que se ofrezca capacitación adecuada y un apoyo emocional estratégico.	2025-09-30 21:36:12.695109	gpt-4.1-nano-2025-04-14
109	42	El perfil de Luz Estela Moreno Arias, para el cargo de Vendedor en punto de venta, muestra una combinación de características que, en general, sugieren un ajuste MEDIO a BAJO. Por un lado, su alta estabilidad emocional (70%) y su tendencia a ser prudente (70%) indican que puede mantener la calma en situaciones de presión, aspecto valioso en un entorno donde la atención al cliente y la gestión de conflictos son frecuentes. Sin embargo, su tendencia a ser insegura (90%) y tímida (70%) puede limitar su capacidad para establecer relaciones de confianza con los clientes, lo cual es crucial en ventas directas en punto de venta.\n\nAdemás, la personalidad imaginativa y soñadora (80%) puede dificultar que se centre en tareas cotidianas y en metas prácticas, una cualidad importante en un vendedor que requiere persistencia y orientación a resultados. Su bajo nivel de sofisticación (10%) y tendencia a ser ingenua, en combinación con sus niveles moderados de dependencia del grupo (50%) y autoconfianza bajísima, sugieren que podría experimentar dificultades para afrontar rechazos o situaciones de competencia, que son frecuentes en el proceso de ventas. La tendencia a responder impulsivamente (70%) y la disconformidad con ideas nuevas (10%) también pueden obstaculizar su capacidad de adaptarse rápidamente y de innovar en su enfoque de venta.\n\nPor otro lado, ciertos aspectos positivos que podrían potenciar su desempeño incluyen su carácter amable y colaborador debido a su alto nivel de apertura y su preferencia por trabajar en grupo. Sin embargo, estos beneficios pueden verse limitados por su tendencia a mostrarse retraída y su inseguridad, que puede afectar su iniciativa y proactividad. En conclusión, el perfil indica que Luz Estela requiere desarrollo en confianza, asertividad y habilidades de afrontamiento a rechazos, por lo que su ajuste al cargo sería MEDIO, siempre y cuando se le proporcione capacitación específica en estas áreas y acompañamiento en su proceso de adaptación.	2025-10-01 18:16:57.717971	gpt-4.1-nano-2025-04-14
105	36	El perfil de Maria Valentina García Orozco presenta un nivel de ajuste ALTO para el cargo de Promotor de Casino, debido a varias características que favorecen su desempeño en este rol. Su alta estabilidad emocional (80%) y su tendencia a ser confiada (20%) indican que puede manejar situaciones de alta presión y mantener una actitud positiva frente a la interacción constante con clientes y colegas, característica fundamental para el trabajo en entorno de casino. Además, su autocontrol elevado (80%) refleja una capacidad para mantener disciplina, ser perfeccionista y gestionar sus emociones en entornos dinámicos.\n\nPor otro lado, su perfil muestra ciertas áreas que, si bien no representan impedimentos mayores, pueden requerir atención durante el proceso de integración y capacitación. La tendencia a ser tímida (90%) y retraída puede afectar en un inicio su confianza y asertividad en la atención al cliente. Sin embargo, sus habilidades para ser participativa en grupos (80%) y su inteligencia práctica (50%) sugieren que puede desarrollarse rápidamente en habilidades sociales y de comunicación necesarias en su rol. La tendencia a respuestas impulsivas y franca (70%) puede, en ciertos contextos, ser un activo para la atención rápida, siempre y cuando se canalice adecuadamente.\n\nEn conclusión, el perfil de Maria Valentina es compatible con las demandas del cargo de Promotor de Casino, que requiere estabilidad emocional, autocontrol y habilidades sociales para relacionarse con clientes de manera efectiva. Aunque presenta rasgos de timidez y cierta impulsividad, estas características pueden ser gestionadas con capacitación adecuada y apoyo en el proceso de socialización laboral. Su perfil indica un nivel de ajuste alto, con potencial de crecimiento y adaptación en el puesto, siempre y cuando se tenga en cuenta la acompañamiento para fortalecer sus habilidades sociales y su confianza en la atención al cliente.	2025-09-30 23:02:00.073099	gpt-4.1-nano-2025-04-14
106	38	El perfil de Ángela Patricia Valencia Ramirez para el cargo de Vendedora en punto de venta presenta un nivel de ajuste Medio. Esto se debe a que, aunque demuestra habilidades en áreas clave para ventas en puntos de atención, también exhibe ciertos aspectos que podrían afectar su desempeño y adaptabilidad en el rol.\n\nEn el aspecto positivo, Ángela destaca por su apertura y sociabilidad (80%), lo cual es fundamental para establecer relaciones con clientes en un entorno de ventas. Además, su disposición a ser espontánea y sociable (60%) junto con su tendencia a la innovación y la búsqueda de nuevas ideas (40%) indican que puede enfrentarse a nuevas situaciones y atraer la atención de los clientes. Sus niveles intermedios de responsabilidad, racionalidad y autoconfianza sugieren que puede manejar tareas de manera equilibrada, manteniendo cierta flexibilidad y adaptabilidad en el trabajo.\n\nPor otro lado, presentan áreas de riesgo que merecen atención. Su alta inseguridad y tendencia a la suspicacia (70%) podrían traducirse en dificultades para cerrar ventas o en una mayor sensibilización al rechazo, comunes en roles de ventas directas. La tendencia a ser sumisa (20%) y su inseguridad también pueden afectar su iniciativa y asertividad, cualidades importantes en la interacción comercial. La tendencia a la desconfianza y la inseguridad puede obstaculizar su confianza frente a los clientes y en la autogestión en situaciones de alta demanda o rechazo. En conjunto, estos aspectos indican la necesidad de acompañar su proceso de formación con estrategias que fortalezcan su autoconfianza, autonomía y manejo emocional para mejorar su rendimiento en ventas y potenciar un ajuste más alto en el futuro.	2025-10-01 14:03:49.281864	gpt-4.1-nano-2025-04-14
107	37	El perfil de Laura Ximena Zuluaga muestra un nivel de ajuste *ALTO* para el cargo de Vendedor en punto de venta, en gran medida debido a su estabilidad emocional, control y participación en grupo. Su alta estabilidad emocional (90%) indica que es una persona madura, tranquilizadora y capaz de mantener la serenidad en situaciones de presión, característica esencial en un entorno de venta donde la resilience emocional favorece la atención al cliente y la gestión del estrés. Además, su baja tensión (10%) y su perfil controlado sugieren que puede mantener la calma en situaciones adversas y manejar el ritmo de ventas con serenidad, lo cual es vital para mantener un ambiente positivo en el punto de venta.\n\nPor otra parte, sus rasgos relacionados con la sociabilidad, como su tendencia a ser reservado (80%) y tímido (70%), podrían presentar un desafío en un entorno donde la interacción con clientes requiere cierto nivel de apertura y espontaneidad. Sin embargo, su capacidad para ceder y confiar (bajo sospecha del 30%) le permite mostrar una actitud tolerante y comprensiva, lo que puede facilitar el establecimiento de relaciones con clientes cuando la situación requiera una aproximación más suave. Su autoconfianza moderada y autosuficiencia (60%) también le permiten abordar tareas de manera independiente, pero sería conveniente acompañarla de capacitaciones en técnicas de ventas y habilidades sociales para potenciar su efectividad en el contacto directo con clientes.\n\nFinalmente, su perfil impulsivo y responsable (ambos en torno al 70%) indica que tiene la capacidad de responder rápidamente y actuar con iniciativa, a la vez que mantiene un sentido del deber y organización. Sin embargo, la impulsividad podría requerir atención para asegurarse de que sus respuestas sean siempre apropiadas y controladas en el contexto de atención al cliente. En conjunto, estos rasgos sugieren que, con las capacitaciones adecuadas y supervisión, Laura tiene el potencial de desempeñarse bien en un rol de ventas en punto de venta, especialmente si se fomenta el desarrollo de habilidades sociales y manejo emocional, logrando un ajuste *ALTO*.	2025-10-01 14:10:20.743444	gpt-4.1-nano-2025-04-14
108	40	El perfil de María Alejandra González Cuervo presenta un ajuste MEDIO para el cargo de Promotor de Casino, considerando las características relevantes para esta posición. Su alta estabilidad emocional (80%) indica que es una persona emocionalmente madura, capaz de mantener la calma en situaciones potencialmente estresantes, lo cual es imprescindible en ambientes dinámicos y con alta interacción social como los casinos. Además, su tendencia a ser reservada y tímida (80%) puede favorecer la atención personalizada y la empatía con los clientes, aunque también podría requerir desarrollo en habilidades de comunicación y confianza en sí misma para destacar en roles que demandan interacción constante y persuasión.\n\nPor otro lado, sus niveles elevados en prudencia (30%) y tendencia a ser controlada (80%) sugieren que es una persona reflexiva, perfeccionista y con tendencia a seguir normas, lo que puede ser positivo para mantener la integridad y el cumplimiento de las políticas del establecimiento. Sin embargo, su tendencia a ser tradicionalista (10%) y reservada puede limitar su adaptabilidad a cambios o innovaciones en técnicas de promoción o en el ambiente de trabajo, lo cual puede requerir acompañamiento para facilitar procesos de adaptación y flexibilidad. Su perfil demuestra una persona confiada en algunas áreas (30%) y autosuficiente (40%), lo que es favorable para desempeñar tareas autónomas y tomar decisiones con criterio propio.\n\nFinalmente, los aspectos relacionados con su autocontrol y disciplina (80%) son ventajas importantes en un promotor en un casino, donde la apariencia, la conducta y la atención al cliente deben ser impecables en todo momento. Sin embargo, aspectos como su timidez, falta de confianza (80%) y tendencia a retraerse ante el sexo opuesto pueden representar desafíos en tareas que requieran proactividad y habilidades sociales más abiertas. En promedio, su perfil requiere cierto desarrollo en áreas de comunicación, asertividad y flexibilidad para incrementar su ajuste al cargo, pero en general sus características son compatibles con un rol que exige estabilidad, organización y atención al cliente en el sector de casinos.	2025-10-01 18:05:36.950973	gpt-4.1-nano-2025-04-14
110	42	El perfil del aspirante Luz Estela Moreno Arias para el cargo de Vendedor en punto de venta presenta un nivel de ajuste MEDIO. Su alta tendencia a la introversión (80%) indica que es una persona reservada, tímida y retraída, lo cual podría limitar su facilidad para establecer rápidamente relaciones cercanas con clientes en un entorno de ventas directo, donde la simpatía y la apertura suelen ser cualidades valoradas. Sin embargo, su estabilidad emocional (70%) y su autoconfianza moderada (60%) sugieren que, aunque puede experimentar inseguridades y cierta inquietud, mantiene una base emocional razonablemente equilibrada que puede ser gestionada con apoyo y entrenamiento adecuados.\n\nPor otro lado, varias características de su perfil son favorables en el contexto de ventas. Su alta impulsividad (70%) y pensamiento imaginativo (80%) pueden traducirse en entusiasmo, creatividad y entusiasmo en la presentación de productos, siempre que se canalicen adecuadamente. Además, su autocontrol alto (80%) y tendencia a ser convencional (10%) indican que es una persona organizada y respetuosa de las normas, lo que puede facilitar el cumplimiento de procedimientos y políticas de la empresa. Sin embargo, sus signos de inseguridad y tendencia a la tensión (40%) requieren que reciba formación en habilidades sociales y técnicas de ventas para potenciar su desempeño.\n\nEn conclusión, Luz Estela Moreno Arias muestra un perfil que, con el apoyo adecuado en aspectos socioemocionales, puede desempeñarse de manera efectiva en un rol de ventas en punto de venta. La combinación de inseguridad moderada, timidez y alta autocontrol puede ser equilibrada con capacitaciones en comunicación y manejo de clientes, mientras que sus fortalezas en creatividad y entusiasmo aportarán positivamente a su rendimiento. Por tanto, el nivel de ajuste para este cargo es MEDIO.	2025-10-01 18:18:10.422469	gpt-4.1-nano-2025-04-14
111	44	El perfil de Sandra Milena Morales Castaño para el cargo de Vendedor punto de venta muestra un ajuste **ALTO** en diversos aspectos clave para el desempeño en esta posición. Su alto nivel de cooperación y tendencia a trabajar en grupos (80%) favorece la interacción con clientes y colegas, facilitando la comunicación y el trabajo en equipo. Además, su estabilidad emocional (70%) indica una capacidad para manejar el estrés y las presiones del entorno de ventas sin afectar su desempeño, lo cual es fundamental en un rol que requiere persistencia y resiliencia.\n\nPor otro lado, su gran autosuficiencia (80%) y control emocional (70%) sugieren que Sandra puede actuar de manera independiente, tomar decisiones rápidas y mantener el autocontrol frente a las variables del ventas, como objeciones o rechazos. Sin embargo, se observa una marcada timidez (70%) que podría afectar su confianza en la interacción directa con clientes, pudiendo dificultar la creación de vínculos cercanos y persuasivos, aspectos necesarios en ventas. Aunque no presenta un perfil sumamente inseguro, la tendencia a la retraibilidad puede requerir intervenciones en habilidades sociales y de autoestima.\n\nEn cuanto a las áreas que podrían presentar un menor ajuste, su bajo interés en innovación y cambio (20%) y su tendencia a ser sencilla e ingenua (30%) podrían limitar su adaptabilidad a nuevas estrategias o productos en un mercado en constante evolución. La baja tendencia a la impulsividad (50%) y su carácter controlado pueden ser ventajas en cuanto a la planificación, pero también podrían hacerla menos espontánea en la interacción con clientes que valoren la autenticidad y dinamismo. En resumen, Sandra tiene un perfil adecuado, especialmente en términos de estabilidad emocional, autonomía y autocontrol, pero su tendencia a la timidez y resistencia al cambio podrían ser áreas a fortalecer para potenciar su rendimiento en ventas.	2025-10-01 22:20:07.11341	gpt-4.1-nano-2025-04-14
112	39	El perfil de Marllory Ramírez García para el cargo de Auxiliar de Oficina muestra un nivel de ajuste ALTO. Esto se debe a que sus resultados reflejan una serie de rasgos positivos para este puesto, como su estabilidad emocional (70%), que le permitirá mantener la calma en ambientes laborales potencialmente rutinarios o demandantes; su carácter responsable y organizado (70% en escrupulosidad), que facilitará cumplir con sus funciones de forma eficiente; y su autocontrol alto (80%), que la ayuda a mantenerse centrada y a gestionar el estrés adecuadamente. Estos aspectos son fundamentales para un desempeño consistente y confiable en tareas administrativas y de apoyo en oficina.\n\nAsimismo, características como su preferencia por trabajar en grupo (reservado/abierto en 80%) y su tendencia a ser autosuficiente (50%) indican que puede integrarse bien en ambientes colaborativos y, al mismo tiempo, actuar de forma independiente cuando sea necesario. Aunque muestra cierta timidez y falta de confianza en sí misma (70% tímido/espontáneo), estas cualidades pueden ser gestionadas con buena orientación y apoyo, sin afectar gravemente su desempeño. Su perfil refleja a una persona que, si bien puede requerir acompañamiento en su proceso de integración, tiene la base necesaria para adaptarse y funcionar eficientemente en un contexto de oficina.\n\nPor otro lado, aspectos como su tendencia a ser prudente (30%) y su orientación práctica (20%) sugieren que es una persona cautelosa, que reflexiona antes de actuar y que prioriza lo concreto y lo inmediato, lo cual es positivo en tareas de apoyo administrativo. Sin embargo, su tendencia a ser analítica y perfeccionista (desinhibido/controlado 80%) puede hacer que parta con una ligera tendencia a la rigidez o a la sobreorganización, por lo que sería importante fortalecer habilidades de flexibilidad y adaptación ante cambios. En conclusión, el perfil de Marllory es compatible y presenta un alto grado de ajuste, siempre que se considere la necesidad de apoyarla en su confianza y en la gestión de su timidez para maximizar su desempeño en el cargo de Auxiliar de Oficina.	2025-10-01 23:32:26.366211	gpt-4.1-nano-2025-04-14
113	53	El perfil de Gabriel David Mejía López en relación con el cargo de aprendiz muestra un nivel de ajuste **ALTO**. Su tendencia a ser una persona afectuosa, participativa y colaboradora ( Reservado / Abierto 80%) sugiere que puede integrarse bien en entornos grupales, favoreciendo el trabajo en equipo, una competencia valiosa para un perfil de aprendizaje. Además, su responsabilidad y sentido del deber, evidenciado por su nivel alto en Despreocupado / Escrupuloso (90%), indican que es una persona comprometida, organizada y competente para seguir instrucciones y cumplir con las tareas asignadas en un programa de aprendizaje.\n\nAsimismo, Gabriel presenta una combinación equilibrada en aspectos como la confianza (bajo sospecha, 30%), estabilidad emocional (60%), y un pensamiento racional/emocional equilibrado (50%), lo que refleja una estabilidad emocional moderada y una actitud confiada que favorece la adaptación a un entorno de entrenamiento. Su tendencia a ser astuto, diplomático y con interés en la innovación (Sencillo / Astuto 70%, Tradicionalista / Innovador 60%) representa una actitud adaptativa y flexible, cualidades importantes para un proceso de aprendizaje en el que la apertura a nuevas ideas y la capacidad de adaptación son esenciales.\n\nNo obstante, algunas características que merecen atención en su perfil, como su tendencia a ser tímido y retraído (Tímido / Espontáneo 70%) y su poca tendencia al control ([Desinhibido / Controlado 30%]), podrían señalizar cierta dificultad en expresar sus ideas o controlar impulsos en situaciones que requieren mayor autocontrol y seguridad. Sin embargo, estas conductas no parecen ser obstáculos insalvables en el contexto del cargo de aprendiz, siempre que se acompañen con un plan de formación que apoye el desarrollo de la confianza y habilidades sociales. En definitiva, su perfil indica un potencial alto para desempeñarse en esta posición dado su compromiso, responsabilidad y apertura al aprendizaje.	2025-10-02 22:05:52.260435	gpt-4.1-nano-2025-04-14
114	52	El perfil de Ángelica María Tapias Morales, para el cargo de Vendedora en punto de venta, presenta diferentes aspectos que merecen ser considerados en su posible ajuste. En primer lugar, su nivel alto en Reservado/Abierto y en Tímido/Espontáneo indica que es una persona más bien reservada, tímida y retraída, lo que puede representar un reto en un contexto de ventas donde la asertividad, la interacción social y la confianza en sí misma son fundamentales. Sin embargo, su estabilidad emocional elevada (70%) sugiere que es capaz de manejar bien las emociones y mantener la calma en situaciones de alta presión o rechazo, lo cual es positivo para la relación con clientes y manejo de situaciones estresantes en el punto de venta.\n\nPor otro lado, sus rasgos sumisos (30%) y poca tendencia a controlar sus impulsos (10%) indican que puede mostrar cierta falta de asertividad o tendencia a ceder ante las demandas del cliente o del entorno, lo que podría limitar su efectividad en la negociación y persuasión, habilidades clave en ventas. Sin embargo, su perfil general de confiabilidad, independencia y un nivel de neutralidad emocional sugiere que, con la formación y el acompañamiento adecuados, puede desarrollar estrategias para mejorar su efecto comunicativo y confianza en el contacto con clientes. Además, su actitud más bien práctica y con interés en nuevas ideas aporta una base para adaptarse y aprender habilidades específicas del área de ventas.\n\nEn conclusión, el perfil de Ángelica muestra ciertos desafíos relacionados con su timidez, baja autoconfianza y tendencia sumisa, que podrían reducir su efectividad en el cargo de vendedora en punto de venta. Sin embargo, su estabilidad emocional, apertura moderada y disposición a nuevas ideas aportan un potencial de ajuste y desarrollo. En función de estas características, el nivel de ajuste sería **MEDIO**, siempre que exista un plan de capacitación en habilidades sociales, técnicas de venta y trabajo con la autoestima que le permita potenciar las competencias necesarias para el cargo y superar los aspectos que pueden limitar su desempeño.	2025-10-02 22:54:14.412361	gpt-4.1-nano-2025-04-14
115	54	El perfil de Luis Diego Osorio González como aspirante para el cargo de Aprendiz muestra un nivel de ajuste MEDIO con base en sus resultados del test 16PF. En primer lugar, destaca su alta dimensión de sociabilidad (80%) y tendencia a trabajar en grupo, lo que es favorable para un rol en el que la colaboración y participación son clave. Sin embargo, su tendencia a ser tímido (70%), retraído y con falta de confianza en sí mismo podría dificultar su integración en entornos donde la interacción y la comunicación activa sean esenciales. Además, su carácter dominante (70%) y autosuficiente (70%) puede facilitar su autonomía, pero también requerirá gestionar estas características para evitar conflictos o una posible resistencia a instrucciones.\n\nAsimismo, su tendencia a ser imaginativo y propenso a cambios rápidos (70%) sugiere creatividad y flexibilidad, elementos positivos en ambientes dinámicos, aunque también puede indicar una posible dificultad para mantener la constancia en tareas prolongadas. Su nivel intermedio de estabilidad emocional (60%) y tendencia a estar tenso o intranquilo (70%) son aspectos que demandarán estrategias de acompañamiento y apoyo emocional para potenciar su bienestar en el entorno laboral. En general, sus rasgos muestran potencial para roles que requieran iniciativa, autonomía y habilidades sociales, aunque es crucial fortalecer su confianza y manejo emocional.\n\nEn conclusión, el perfil de Luis Diego presenta un ajuste MEDIO para un cargo de Aprendiz en tanto posea habilidades de autogestión y comunicación, pero requerirá apoyo en aspectos relacionados con la autoconfianza, manejo de la tensión y desarrollo de habilidades sociales. Un plan de inducción que contemple coaching para fortalecer su autoestima y estrategias para manejar su ansiedad puede favorecer su integración y desempeño. Con un acompañamiento adecuado, sus cualidades autosuficientes, creativas y colaborativas pueden ser un valor agregado para el equipo y la organización.	2025-10-03 02:02:37.366332	gpt-4.1-nano-2025-04-14
116	54	El perfil de Luis Diego Osorio González para el cargo de aprendiz presenta un nivel de ajuste MEDIO, considerando la compatibilidad de sus rasgos con las demandas típicas de este puesto. En primer lugar, su tendencia a ser reservado (80%) y tímido (70%) puede dificultar la interacción social y la adaptación a entornos que requieran mayor sociabilidad o trabajo en equipo, aunque favorece un perfil reflexivo y cuidado en sus acciones. La alta autosuficiencia (70%) y dominante (70%) también indican que prefiere resolver problemas de manera independiente y ejercer control, lo cual puede ser positivo en tareas que requieran iniciativa, pero puede limitar la colaboración en actividades grupales.\n\nPor otro lado, algunos aspectos del perfil, como su tendencia a la inseguridad (40%), niveles moderados de estabilidad emocional (60%) y su tendencia a estar tensionado y ansioso (70%), sugieren que puede experimentar dificultades para manejar situaciones de alta presión o incertidumbre, comunes en entornos laborales de aprendizaje y crecimiento. Sin embargo, su capacidad para actuar de forma práctica y racional (30%) complementada con un interés por la innovación (40%) le otorga recursos para adaptarse a nuevas ideas, siempre que reciba un acompañamiento adecuado. La baja consideración por normas (30%) indica que podría requerir orientación adicional en cuanto a los procesos organizacionales y sus responsabilidades.\n\nEn resumen, Luis Diego posee características que, en un entorno controlado y con apoyo, pueden ser canalizadas para su desarrollo, aunque podrían requerir acompañamiento en habilidades sociales y en la gestión emocional. Su perfil muestra potencial para desempeñarse en un rol en donde su autonomía y capacidad de resolver problemas sean valoradas, pero será importante facilitar espacios que fomenten la confianza en sí mismo y la integración con el equipo, logrando así un ajuste más alto a largo plazo.	2025-10-03 02:03:09.569274	gpt-4.1-nano-2025-04-14
117	46	El perfil de Geraldine Andrea Jiménez Ceballos presenta varios aspectos relevantes para el cargo de vendedora en un punto de venta. Su nivel alto en extraversión social, específicamente en la dimensión de reservada / abierta (80%), indica que le gusta trabajar en grupo, participar activamente y colaborar con otros, lo cual es fundamental en atención al cliente. Además, su estabilidad emocional elevada (80%) sugiere que puede mantener la calma y ser resiliente en situaciones de presión o rechazo, características esenciales en ventas directas. Sin embargo, su tendencia a ser tímida y retraída (80%) puede representar un desafío al momento de abordar clientes desconocidos, requiriendo de estrategias para potenciar su confianza y habilidades sociales.\n\nPor otro lado, su alta dominancia (70%) y tendencia a ser impulsiva (70%) sugieren que puede ejercer liderazgo y tomar decisiones rápidas, cualidades valiosas para afrontar diferentes tipos de clientes y situaciones de venta. Sin embargo, estas mismas características podrían derivar en una tendencia a actuar sin suficiente reflexión, por lo cual se recomienda acompañarlas con entrenamiento en control emocional y planificación. Su nivel moderado en confiabilidad y apertura a ideas nuevas (ambos en torno a 30%) indica un perfil algo conservador y sencillo, con posible resistencia a cambios o a adoptar enfoques innovadores en su labor, por lo que sería importante fortalecer su flexibilidad y adaptabilidad.\n\nEn conclusión, el perfil de Geraldine muestra un nivel de ajuste **MEDIO** para el cargo de vendedor en punto de venta. Su fortaleza en estabilidad emocional y extroversión social la favorece en roles que requieren interacción constante con clientes, pero sus rasgos de timidez, impulsividad y tendencia a preferir la autonomía sugieren que necesitará apoyo en el desarrollo de habilidades sociales, manejo del estrés y técnicas de persuasión. Con capacitación adecuada en estas áreas, su potencial puede potenciarse para cumplir eficazmente con las expectativas del cargo.	2025-10-03 14:43:15.544346	gpt-4.1-nano-2025-04-14
118	45	El perfil de Karen Eliane Bonza Fernandez muestra un nivel de ajuste Alto para el cargo de Vendedor en punto de venta. Su tendencia a ser una persona afectuosa, participativa y colaboradora (80%) favorece significativamente el trabajo en equipo y la interacción con clientes, características esenciales en roles de venta directa. Además, su estabilidad emocional (70%) y tendencia a la autosuficiencia (60%) indican que puede mantener la calma bajo presión y gestionar de manera autónoma sus responsabilidades, lo que es beneficioso en ambientes de trabajo dinámicos y con alta interacción social.\n\nPor otro lado, aspectos como su alta capacidad de autocontrol (80%) y su orientación a la responsabilidad y organización (70%) se alinean con las demandas de un vendedor que debe mantener una presencia confiable y eficiente. Aunque su tendencia a ser práctica y concreta (40%) sugiere una orientación hacia soluciones objetivas en la atención al cliente y resolución de problemas, esto no limita su capacidad de adaptación y apertura a nuevas ideas, ya que mantiene un equilibrio en su interés por la innovación (50%). La confianza elevada (10%) es un factor que favorece su relación con clientes y colegas, transmitiendo seguridad y credibilidad.\n\nEn conclusión, el perfil de Karen indica que cuenta con diversas características que favorecen su desempeño en un cargo de vendedor en punto de venta. Su equilibrio emocional, confianza, autonomía y capacidad de autocontrol son aspectos que contribuyen a su alto ajuste para la posición. Además, su orientación hacia las relaciones sociales y el trabajo en equipo fortalecen su potencial para alcanzar metas comerciales, desenvolviéndose eficazmente en un entorno que requiere tanto habilidades sociales como responsabilidad individual.	2025-10-03 15:05:59.918486	gpt-4.1-nano-2025-04-14
119	50	El perfil del aspirante Marta Isabel Palacio Palacios, evaluado con base en los resultados del test 16PF, indica un nivel de ajuste MEDIO para el cargo de Vendedor en punto de venta. Su orientación hacia la colaboración, como lo refleja su alto porcentaje en reservado / abierto (80%), sugiere que disfruta trabajar en equipo, lo cual puede ser beneficioso en un entorno de ventas que requiere interacción constante con clientes y colegas. Sin embargo, aspectos como su marcada tendencia a la timidez (80%) y su retraimiento social pueden limitar su eficacia en roles que demanden proactividad y alta expresión verbal, características típicas en vendedores que necesitan captar la atención y confianza de los clientes rápidamente.\n\nPor otro lado, Marta muestra una estabilidad emocional notable (70%), lo cual es positivo para manejar cargas de trabajo y mantener una actitud equilibrada en situaciones de presión comunes en ventas. Su tendencia a ser sumisa (30%) y confiada (30%) puede facilitar relaciones amigables y tolerantes con los clientes, aunque también podría representar un desafío en la negociación, donde a veces se requiere asertividad y firmeza. Además, su autocontrol alto (70%) y su sentido del deber (70%) indican que puede mantenerse focalizada y ordenada en sus tareas, lo que favorece el cumplimiento de metas y procedimientos establecidos. Sin embargo, su tendencia a la introversión y cierta inseguridad podrían requerir acompañamiento en el desarrollo de habilidades sociales y técnicas de ventas más asertivas.\n\nEn conclusión, Marta presenta características que, en conjunto, justifican un ajuste MEDIO para el puesto de Vendedor en punto de venta. Con su perfil, podría desempeñarse con éxito si se apoya en estrategias de capacitación en comunicación, trabajo en equipo y desarrollo de confianza en sí misma, potenciando sus fortalezas en estabilidad emocional y responsabilidad, mientras trabaja en superar sus aspectos más introvertidos y tímidos para potenciar su efectividad en el rol.	2025-10-03 15:29:32.468672	gpt-4.1-nano-2025-04-14
\.


--
-- Data for Name: invitaciones_pendientes; Type: TABLE DATA; Schema: pruebas16pf; Owner: ats_n8n
--

COPY pruebas16pf.invitaciones_pendientes (telefono_whatsapp, nombre_candidato, created_at, selected_horario_id) FROM stdin;
\.


--
-- Data for Name: preguntas_16pf; Type: TABLE DATA; Schema: pruebas16pf; Owner: ats_n8n
--

COPY pruebas16pf.preguntas_16pf (numero, texto, opcion_a, opcion_b, opcion_c) FROM stdin;
1	He comprendido bien las instrucciones para contestar el Cuestionario:	Sí	No estoy seguro.	No
2	Estoy dispuesto a contestar todas las cuestiones con sinceridad:	Sí	No estoy seguro	No.
3	¿Cuál de las siguientes palabras es diferente de las otras dos? :	Algo	Nada	Mucho.
4	Poseo suficiente energía para enfrentarme a todos mis problemas:	Siempre	Frecuentemente	Raras veces.
5	Evito criticar a la gente y sus ideas:	Sí	Algunas veces	Nunca.
6	Hago agudas y sarcásticas observaciones a la gente si creo que las merece:	Verdadero	No estoy seguro	Nunca
7	Me gusta más la música semiclásica que las canciones populares:	Verdadero	No estoy seguro	Falso.
8	Si veo peleándose a los niños de mis vecinos:	Les dejo solucionar sus problemas	No estoy seguro	Razono con ellos la solución
9	En situaciones sociales: 	Fácilmente soy de los que toman iniciativas	Intervengo algunas veces	Prefiero quedarme tranquilamente a distancia
10	Sería mas interesante ser:	Ingeniero de la construcción	No estoy seguro entre los dos	Escritor de teatro
11	Generalmente puedo tolerar a la gente presuntuosa, aunque fanfarronee o piense demasiado bien de ella misma:	Sí	Término medio	No.
12	Cuando una persona no es honrada, casi siempre se le puede notar en la cara:	Verdadero	Término medio	Falso.
13	Aceptaría mejor el riesgo de un trabajo donde pudiera tener ganancias mayores, aunque eventuales, que otro con sueldo pequeño, pero seguro:	Sí	No estoy seguro.	No.
14	De vez en cuando siento un vago temor o un repentino miedo, sin poder comprender las razones:	Sí	No estoy seguro	No
16	Casi todo se puede comprar con dinero:	Sí	No estoy seguro	No.
17	La mayoría de las personas serían más felices si convivieran más con la gente de su nivel e hicieran las cosas como los demás.	Sí	Término medio	No.
18	En ocasiones, mirándome en un espejo, me entran dudas sobre lo que es mi derecha o izquierda:	Sí	Término medio	No.
19	Cuando algo realmente me pone furioso, suelo calmarme muy pronto:	Sí	Término medio	No.
20	Preferiría tener una casa:	En un barrio con vida social	Término medio	Aislada en el bosque.
21	Con el mismo horario y sueldo, sería más interesante ser:	El cosinero de un buen restaurante	No estoy seguro entre ambos	El que sirve las mesas en el restaurante
22	"Cansado" es a "trabajar" como "orgulloso" es a:	Sonreir	Tener éxito	Ser feliz.
23	Me pongo algo nervioso ante animales salvajes, incluso cuando están encerrados en fuertes jaulas:	Sí	No estoy seguro	No.
24	Una ley anticuada debería cambiarse:	Sólo después de muchas discusiones	Término medio	Inmediatamente.
25	La mayor parte de las personas me consideran un interlocutor agradable:	Sí	No estoy seguro	No.
26	Me gusta salir a divertirme o ir a un espectáculo:	Más de una vez por semana(más de lo corriente)	Alrededor de una vez por semana (lo corriente)	Menos de una vez por semana (menos de lo corriente).
27	Cuando veo gente desaliñada y sucia:	Lo acepto simplemente	Término medio	Me disgusta y me fastidia.
28	Estando en un grupo social me siento un poco turbado si de pronto paso a ser el foco de atención:	Sí	Término medio	No.
29	Cuando voy por la calle prefiero detenerme antes a ver a un artista pintando que a escuchar a la gente discutir:	Verdadero	No estoy seguro	Falso
30	Cuando me ponen al frente de algo, insisto en que se sigan mis instrucciones; en caso contrario, renuncio:	Sí	Algunas veces	No
31	Sería mejor que las vacaciones fueran más largas y obligatorias para todas las personas:	De acuerdo	No estoy seguro	No
32	Hablo acerca de mis sentimientos:	Sólo si es necesario	Término medio	Fácilmente, siempre que tengo ocasión.
33	Me siento muy abatido cuando la gente me critica en un grupo:	Verdadero	Término medio	Falso.
34	Si mi jefe (profesor) me llama a su despacho:	Aprovecho la ocasión para pedirle algo que deseo	Término medio	Temo haber hecho algo malo
35	Mis decisiones se apoyan más en:	El corazón	Los sentimientos y la razón por igual	La cabeza
36	En mi adolescencia pertenecía a equipos deportivos:	Algunas veces	A menudo	La mayoría de las veces.
37	Cuando hablo con alguien, me gusta:	Decir las cosas tal como se me ocurran	Término medio	Organizar antes mis ideas.
38	A veces me pongo en estado de tensión y agitación cuando pienso en los sucesos del día:	Sí	Término medio	No
39	He sido elegido para hacer algo:	Sólo en pocas ocasiones	Varias veces	Muchas veces.
40	¿Cuál de las siguientes cosas es diferente de las otras dos?:	Vela	Luna	Luz eléctrica.
41	"Sorpresa" es a "extraño" como "miedo" es a:	Valeroso	Ansioso	Terrible.
42	A veces no puedo dormirme porque tengo una idea que me da vueltas en la cabeza:	Verdadero	Término medio	No
43	Me siento desasosegado cuando trabajo en un proyecto que requiere una acción rápida que afecta a los demás:	Verdadero	Término medio	No
44	Indudablemente tengo menos amigos que la mayoría de las personas:	Sí	Término medio	Falso
45	Aborrecería tener que estar en un lugar donde hubiera poca gente con quien hablar:	Verdadero	No estoy seguro	Falso
46	Creo que es más importante mucha libertad que buena educación y respeto a la ley:	Verdadero	Término medio	Falso
47	siempre me alegra formar parte de un grupo grande, como una reunión, un baile o una asamblea:	Sí	Término medio	No
48	en mi época de estudiante me gustaba (me gusta):	La música	No estoy seguro	La actividad de tipo manual
49	Si alguien se enfada conmigo:	Intento calmarle	No estoy seguro	Me irrito con él.
50	Para los padres es más importante:	Ayudar a sus hijos a desarrollarse afectivamente	Término medio	Enseñarles a controlar sus emociones
51	Siento de vez en cuando la necesidad de ocuparme en una actividad física enérgica:	Sí	Término medio	Muy a menudo
52	Hay veces en que no me siento con humor para ver a alguien:	Muy raramente	Término medio	Muy a menudo.
53	A veces los demás me advierten que yo muestro mi excitación demasiado claramente en la voz y en los modales:	Sí	Término medio	No
54	Lo que el mundo necesita es:	Ciudadanos más sensatos y constantes	No estoy seguro	Más "idealistas" con proyectos para un mundo mejor.
55	Preferiría tener un negocio propio, no compartido con otra persona:	Sí	No estoy seguro	No
162	Si se pasa por alto una buena observación mía:	La dejo pasar	Término medio	Doy a la gente la oportunidad de volver a escucharla
56	Tengo mi habitación organizada de uno modo inteligente y estético, con las cosas colocadas casi siempre en lugares conocidos:	Sí	Término medio	No
57	En ocasiones dudo si la gente con quien estoy hablando se interesa realmente por lo que digo:	Sí	Término medio	No
58	Si tuviera que escoger, preferiría ser:	Guardia Forestal	No estoy seguro	Profesor de Enseñanza media.
59	¿Cuál de las siguientes fracciones es diferente de las otras dos?.	3/7	3/9	3/11
60	"Tamaño" es a "longitud" como "delito" es a:	Prisión	Castigo	Robo
61	En mi vida personal consigo casi siempre todos mis propósitos:	Verdadero	No estoy seguro	Falso
62	Tengo algunas características en las que me siento claramente superior a la mayor parte de la gente:	Sí	No estoy seguro	No
63	Sólo asisto a actos sociales cuando estoy obligado, y me mantengo aparte en las demás ocasiones:	Sí	No estoy seguro	No
64	Es mejor ser cauto y esperar poco que optimista y esperar siempre el éxito:	Verdadero	No estoy seguro	Falso
65	Algunas veces la gente dice que soy descuidado, aunque me consideran una persona agradable:	Sí	Término medio	No
66	Suelo permanecer callado delante de personas mayores (con mucha más experiencia, edad o jerarquía):	Sí	Término medio	No
67	Tengo un buen sentido de la orientación (sitúo fácilmente los puntos cardinales), cuando me encuentro en un lugar desconocido:	Sí	Término medio	No
68	Cuando leo en una revista un artículo tendencioso o injusto, me inclino más a olvidarlo que a replicar o "devolver el golpe":	Verdadero	No estoy seguro	Falso
69	En tareas de grupo, preferiría:	Intentar mejorar los preparativos	Término medio	Llevar las actas o registros y procurar que se cumplan las Normas.
70	Me gustaría más andar con personas corteses que con individuos rebeldes y toscos:	Sí	Término medio	No
71	Si mis conocidos me tratan mal o muestran que yo les disgusto:	No me importa nada	Término medio	Me siento abatido.
72	Siempre estoy alerta ante los intentos de propaganda en las cosas que leo:	Sí	No estoy seguro	No
73	Me gustaría más gozar de la vida tranquilamente y a mi modo que ser admirado por mis resultados:	Verdadero	No estoy seguro	Falso
74	Para estar informado, prefiero:	discutir los acontecimientos con la gente 	Término medio	Apoyarme en las informaciones periodísticas de actualidad.
75	Me encuentro formado (maduro) para la mayor parte de las cosas:	Verdadero	No estoy seguro	Falso
76	Me encuentro más abatido que ayudado por el tipo de crítica que la gente suele hacer:	A menudo	Ocasionalmente	Nunca
77	En las fiestas de cumpleaños:	Me gustaría hacer regalos personales	No estoy seguro	Pienso que comprar regalos es un poco latoso
78	"AB" es a "dc" como "SR" es a:	qp	Pq	Tú
79	"Mejor" es a "pésimo" como "menor" es a:	Mayor	Optimo	Máximo
80	Mis amigos me han fallado:	Muy rara vez	Ocasionalmente	Muchas veces.
81	Cuando me siento abatido hago grandes esfuerzos por ocultar mis sentimientos a los demás:	Verdadero	Término medio	Falso
82	Gasto gran parte de mi tiempo libre hablando con los amigos sobre actuaciones sociales agradables vividas en el pasado:	Sí	Término medio	No
83	Pensando en las dificultades de mi trabajo:	Intento organizarme antes de que aparezcan	Término medio	Doy por supuesto que puedo dominarlas cuando vengan.
84	Me cuesta bastante hablar o dirigir la palabra a un grupo numeroso:	Sí	Término medio	No
85	He experimentado en varias situaciones sociales el llamado "nerviosismo del orador":	Muy frecuentemente	Ocasionalmente	Casi nunca
86	Prefiero leer: militares o políticas y delicada.	una narración realista de contiendas	No estoy seguro	Una novela imaginativa
87	Cuando la gente autoritaria trata de dominarme, hago justamente lo contrario de lo que quiere:	Sí	Término medio	No
88	Suelo olvidar muchas cosas triviales y sin importancia, tales como los nombres de las calles y tiendas de la ciudad	Sí	Término medio	No
89	Me gustaría la profesión de veterinario, ocupado con las enfermedades y curación de los animales:	Sí	Término medio	No
90	Me resulta embarazoso que me dediquen elogios o cumplidos:	Sí	Término medio	No
91	Siendo adolescente, cuando mi opinión era distinta de la de mis padres, normalmente:	Mantenía mi opinión	Término medio	Aceptaba su autoridad.
92	Me gusta tomar parte activa en las tareas sociales, trabajos de comité, etc.	Sí	Término medio	No
93	Al llevar a cabo una tarea, no estoy satisfecho hasta que se ha considerado con toda atención el menor detalle:	Verdadero	Término medio	Falso
94	Tengo ocasiones en que me es difícil alejar un sentimiento de compasión hacia mí mismo:	A menudo	Algunas veces	Nunca
95	Siempre soy capaz de controlar perfectamente la expresión de mis sentimientos:	Sí	Término medio	No
96	Ante un nuevo invento utilitario, me gustaría:	Trabajar sobre él en el laboratorio	No estoy seguro	Venderlo a la gente
97	La siguiente serie de letras XOOOOXXOOOXXX continúa con el grupo:	OXXX	OOXX	XOOO
98	Algunas personas parecen ignorarme o evitarme, aunque no sé por qué:	Verdadero	No estoy seguro	Falso
99	La gente me trata menos razonablemente de lo que merecen mis buenas intenciones:	A menudo	Ocasionalmente	Nunca
100	Aunque no sea en un grupo mixto de mujeres y hombres, me disgusta que se use un lenguaje obsceno:	Sí	Término medio	No
101	Me gusta hacer cosas atrevidas y temerarias sólo por el placer de divertirme:	Sí	Término medio	No
102	Me resulta molesta la vista de una habitación muy sucia:	Sí	Término medio	No
103	Cuando estoy en un grupo pequeño, me agrada quedarme en un segundo término y dejar que otros lleven el peso de la conversación:	Sí	Termino medio	No
104	Me resulta fácil mezclarme con la gente en una reunión social:	Verdadero	No estoy seguro	Falso
105	Sería más interesante ser:	Orientador vocacional para ayudar a los jóvenes en la búsqueda de su profesión.	No estoy seguro	Directivo de una empresa industrial.
106	Por regla general, mis jefes y mi familia me encuentran defectos sólo cuando realmente existen:	Verdadero	Término medio	Falso
107	Me disgusta el modo con que algunas personas se fijan en otras en la calle o en las tiendas:	Sí	Término medio	No
108	Como los alimentos con gusto y placer, aunque no siempre tan cuidadosa y educadamente como otras personas:	Verdadero	No estoy seguro	Falso
109	Temo algún castigo incluso cuando no he hecho nada malo:	A menudo	Ocasionalmente	Nunca
110	Me gustaría más tener un trabajo con:	Un determinado sueldo fijo	Término medio	Un sueldo más alto pero siempre que demuestre a los demás que lo merezco.
111	Me molesta que la gente piense que mi comportamiento es demasiado raro o fuera de lo corriente:	Mucho	Algo	Nada en absoluto
112	A veces dejo que sentimientos de envidia o celos influyan en mis acciones:	Sí	Término medio	No
113	En ocasiones, contrariedades muy pequeñas me irritan mucho:	Sí	Término medio	No
114	Siempre no duermo bien, nunca hablo en sueños ni me levanto sonámbulo:	Sí	Término medio	No
115	Me gustaría más interesante trabajar en una empresa:	Atendiendo a los clientes	Término medio	Llevando las cuentas o los Archivos.
116	"Azada" es a "cavar" como "cuchillo" es a:	Cortar	Afilar	Picar
118	Sí los demás hablan en voz alta cuando estoy escuchando música:	Puedo concentrarme en ella sin que me molesten	Término medio	Eso me impide disfrutar de ella y me incomoda.
119	Creo que se me describe mejor como:	Comedido y reposado	Término medio	Enérgico
120	Preferiría vestirme con sencillez y corrección que con un estilo personal y llamativo:	Verdadero	No estoy seguro	Falso
121	Me niego a admitir sugerencias bien intencionadas de los demás, aunque sé que no debería hacerlo:	Algunas veces.	Casi nunca	Nunca
122	Cuando es necesario que alguien emplee un poco de diplomacia y persuasión para conseguir que la gente actúe, generalmente sólo me lo encarga a mí:	Sí	Término medio	No
123	Me considero a mí mismo como una persona muy abierta y sociable:	Sí	Término medio	No
124	Me gusta la música:	Ligera, movida y animada	Término medio	Emotiva y sentimental
125	Si estoy completamente seguro de que una persona es injusta o se comporta egoístamente, se lo digo, incluso si esto me causa problemas:	Sí	Término medio	No
126	En un viaje largo, preferiría:	Leer algo profundo pero interesante	No estoy seguro	Pasar el tiempo charlando sobre cualquier cosa con un compañero de viaje.
127	En una situación que puede llegar a ser peligrosa, creo que es mejor alborotar o hablar alto, aún cuando se pierda la calma y la cortesía:	Sí	Término medio	No
128	Es muy exagerada la idea de que la enfermedad proviene tanto de causas mentales como físicas:	Sí	Término medio	No
129	En cualquier gran ceremonia oficial debería mantenerse la pompa y el esplendor:	Sí	Término medio	No
130	Cuando hay que hacer algo, me gustaría más trabajar:	En equipo	No estoy seguro	Yo solo
131	Creo firmemente que "tal vez el jefe no tenga siempre la razón, pero siempre tiene la razón por ser el jefe":	Sí	No estoy seguro	No
132	Suelo enfadarme con las personas demasiado pronto:	Sí	Término medio	No
133	Siempre puedo cambiar viejos hábitos sin dificultad y sin volver a ellos:	Sí	Término medio	No
134	Si el sueldo fuera el mismo, preferiría ser:	Abogado	No estoy seguro entre ambos	Navegante o piloto
135	"Llama" es a "calor" como "rosa" es a:	Espina	Pétalo	Aroma
136	Cuando se acerca el momento de algo que he planteado y he esperado, en ocasiones pierdo la ilusión por ello:	Verdadero	Término medio	Falso
137	Puedo trabajar cuidadosamente en la mayor parte de las cosas sin que me molesten las personas que hacen mucho ruido a mí alrededor:	Sí	Término medio	No
138	En ocasiones hablo a desconocidos sobre cosas que considero importantes, aunque no me pregunten sobre ellas:	Sí	Término medio	No
139	Me atrae más pasar una tarde ocupado en una tarea tranquila a la que tenga afición que estar en una reunión animada:	Verdadero	No estoy seguro	Falso
140	Cuando debo decidir algo, tengo siempre presentes las reglas básicas de lo justo y lo injusto:	Sí	Término medio	No
141	En el trato social:	Muestro mis emociones tal como las siento	Término medio	Guardo mis emociones para mis adentros.
142	Admiro más la belleza de un poema que la de un arma de fuego bien construida:	Sí	No estoy seguro	No
143	A veces digo en broma disparates, sólo para sorprender a la gente y ver qué responden:	Sí	Término medio	No
144	Me agradaría ser un periodista que escribiera sobre teatro, conciertos, ópera, etc.	Sí	No estoy seguro	No
145	Nunca siento la necesidad de garabatear, dibujar o moverme cuando estoy sentado en una reunión:	Verdadero	No estoy seguro	Falso
146	Si alguien me dice algo que yo sé que no es cierto, suelo pensar:	Es un mentiroso	Término medio	Evidentemente no está bien informado
147	La gente me considera con justicia una persona activa pero con éxito sólo mediano:	Sí	Término medio	No
148	Si me suscitara una controversia violenta entre otros miembros de un grupo de discusión.	Me gustaría ver quién es el ganador	Término medio	Desearía que se suavizara de nuevo la situación.
149	Me gustaría planear mis cosas solo, sin interrupciones y sugerencias de otros:	Sí	Término medio	No
150	Me gusta seguir mis propios caminos, en vez de actuar según normas establecidas:	Verdadero	No estoy seguro	Falso
151	Me pongo nervioso (tenso) cuando pienso en todas las cosas que tengo que hacer:	Sí	Algunas veces	No
152	No me perturba que la gente me haga alguna sugerencia cuando estoy jugando:	Verdadero	No estoy seguro	Falso
153	Me parece más interesante ser:	Artista	No estoy seguro	Secretario de un club social.
154	¿Cuál de las siguientes palabras es diferente de las otras dos?.	Ancho	Zigzag	Prácticamente nunca
155	He tenido sueños tan intensos que no me han dejado dormir bien:	A menudo	Ocasionalmente	Prácticamente nunca.
156	Aunque tenga pocas posibilidades de éxito, creo que todavía me merece la pena correr el riesgo:	Sí	Término medio	No
157	Cuando yo sé muy bien lo que el grupo tiene que hacer, me gusta ser el único en dar las órdenes:	Sí	Término medio	No
158	Me consideran una persona muy entusiasta:	Sí	Término medio	No
159	Soy una persona bastante estricta, e insisto siempre en hacer las cosas tan correctamente como sea posible:	Verdadero	Término medio	Falso
160	Me disgusta un poco que la gente me esté mirando cuando trabajo:	Sí	Término medio	No
161	Como no siempre es posible conseguir las cosas utilizando gradualmente métodos razonables, a veces es necesario emplear la fuerza:	Verdadero	Término medio	No
163	Me gustaría hacer el trabajo de un oficial encargado de los casos de delincuentes bajo fianza:	Sí	Término medio	No
164	Hay que ser prudente antes de mezclarse con cualquier desconocido, puesto que hay peligros de infección y de otro tipo:	Sí	Término medio	No
165	En un viaje al extranjero, preferiría ir en un grupo organizado, con un experto, que planear yo mismo los lugares que deseo visitar:	Sí	No estoy seguro	No
166	Si la gente se aprovecha de mi amistad, no me quedo resentido y lo olvido pronto:	Verdadero	Término medio	No
167	Creo que la sociedad debería aceptar nuevas costumbres, de acuerdo con la razón, y olvidar los viejos usos y tradiciones:	Sí	Término medio	No
168	Aprendo mejor:	Leyendo un libro bien escrito	Término medio	Participando en un grupo de discusión.
169	Me gusta esperar a estar seguro de que lo que voy a decir es correcto, antes de exponer mis ideas:	Siempre	Generalmente	Sólo si es posible
170	Algunas veces me "sacan de quicio" de un modo insoportable pequeñas cosas, aunque reconozca que son triviales:	Sí	Término medio	No
171	No suelo decir, sin pensarlas, cosas que luego lamento mucho:	Verdadero	No estoy seguro	Falso.
172	Si me pidiera colaborar en una campaña caritativa	Aceptaría	No estoy seguro	Diría cortésmente que estoy muy ocupado
173	"Pronto" es a "nunca" como "cerca" es a:	En ningún sitio	Lejos	En otro sitio
174	Si cometo una falta social desagradable, puedo olvidarla pronto:	Sí	No estoy seguro	No
175	Se me considera un "hombre de ideas" que casi siempre puede apuntar alguna solución a un problema:	Sí	Término medio	No
176	Creo que se me da mejor mostrar:	Aplomo en las pugnas y discusiones de una reunión	No estoy seguro	Tolerancia con los deseos de los demás.
177	Me gusta un trabajo que presente cambios, variedad y viajes, aunque implique algún peligro:	Sí	Término medio	No
178	Me gusta un trabajo que requiera dores de atención y exactitud:	Sí	Término medio	No
179	Soy de ese tipo de personas con tanta energía que siempre están ocupadas:	Sí	No estoy seguro	No
180	En mi época de estudiante prefería (prefiero):	Lengua o literatura	No estoy seguro	Matemáticas o Aritmética
181	Algunas veces me ha turbado el que la gente diga a mi espalda cosas desagradables de mí sin fundamento:	Sí	No estoy seguro	No
182	Hablar con personas corrientes, convencionales y rutinarias:	Es a menudo muy interesante e instructivo	Término medio	Me fastidia porque no hay profundidad o se trata de chismes y cosas sin importancia.
183	Algunas cosas me irritan tanto que creo que entonces lo mejor es no hablar:	Sí	Término medio	No
184	En la formación del niño, es más importante:	Darle bastante afecto	Término medio	Procurar que aprenda hábitos y actitudes deseables
185	Los demás me consideran una persona firme e imperturbable, impasible ante los vaivenes de las circunstancias:	Sí	Término medio	No
187	Creo que no me he saltado ninguna cuestión y he contestado a todas de modo apropiado:	Sí	No estoy seguro	No
15	Cuando me critican duramente por algo que NO he hecho:	No me siento culpable	Término medio.	Todavía me siento un poco culpable.
117	Cuando la gente no es razonable, yo normalmente: 	Me quedo tan tranquilo	Término medio	Eso me impide disfrutar de ella y me incomoda.
186	Creo que en el mundo actual es más importante resolver:	El problema de la intención moral	No estoy seguro	Los problemas políticos
\.


--
-- Data for Name: reglas_decatipo_16pf; Type: TABLE DATA; Schema: pruebas16pf; Owner: ats_n8n
--

COPY pruebas16pf.reglas_decatipo_16pf (factor_codigo, regla) FROM stdin;
A	FIJO_8
B	FIJO_4
C	CORRIGE_SI_DM_GT9_-2
E	SIN_CORRECCION
F	SIN_CORRECCION
G	CORRIGE_SI_DM_GT9_-1
H	CORRIGE_SI_DM_GT9_-1
I	SIN_CORRECCION
L	CORRIGE_SI_DM_GT9_+1
M	SIN_CORRECCION
N	SIN_CORRECCION
O	CORRIGE_SI_DM_GT9_+2
Q1	SIN_CORRECCION
Q2	CORRIGE_SI_DM_GT9_+1
Q3	CORRIGE_SI_DM_GT9_-2
Q4	CORRIGE_SI_DM_GT9_+2
\.


--
-- Data for Name: requisitos; Type: TABLE DATA; Schema: pruebas16pf; Owner: ats_n8n
--

COPY pruebas16pf.requisitos (id, nombre, date) FROM stdin;
3	Título universitario en áreas afines	2025-09-08 11:56:31.551614
4	Experiencia mínima de 2 años en análisis de datos	2025-09-08 11:56:31.551614
1	Manejo de Excel avanzado	2025-09-08 11:56:31.551614
2	Conocimientos en SQL	2025-09-07 00:00:00
6	Título universitario	2025-09-07 00:00:00
7	Experiencia en ventas	2025-09-08 14:14:33.677
8	Experiencia en atención al cliente	2025-09-08 14:14:33.677
19	Que tenga moto 200cc	2025-09-15 10:16:46.566733
28	Power Apps	2025-09-17 09:59:45.161637
31	Manejo de dinero	2025-09-26 14:56:13.264616
\.


--
-- Data for Name: respuestas_16pf; Type: TABLE DATA; Schema: pruebas16pf; Owner: ats_n8n
--

COPY pruebas16pf.respuestas_16pf (id, aspirante_id, numero_pregunta, respuesta) FROM stdin;
3273	38	170	C
3274	37	133	A
3276	38	171	A
3278	37	134	A
3279	38	172	A
3281	37	135	B
3490	40	115	B
3280	38	173	B
3284	37	136	C
3285	38	174	C
3286	38	175	A
3287	38	176	C
3289	37	137	A
3290	37	138	C
3291	38	177	A
3292	38	178	B
3293	38	179	A
3294	38	180	A
3492	40	116	B
3493	40	117	A
3494	40	118	B
3295	37	139	A
3300	38	181	A
3301	37	140	A
3495	40	119	B
3304	37	141	A
3302	38	182	C
3306	38	183	A
3307	37	142	A
3308	38	184	A
3309	37	143	C
3310	37	144	A
3312	37	145	C
3313	38	185	A
3496	40	120	B
3316	38	186	A
3497	40	121	C
3314	37	146	B
3319	38	187	A
3339	37	162	C
3354	37	172	A
3356	37	174	C
3358	37	175	B
3360	37	176	C
3361	37	177	A
3362	37	178	A
3363	37	179	A
3364	37	180	A
3365	37	181	B
3367	37	182	B
3368	37	183	C
3369	37	184	B
3370	37	185	A
3371	37	186	A
3372	37	187	A
3373	40	1	A
3374	40	2	A
3375	40	3	B
3376	40	4	B
3377	40	5	A
3378	40	6	B
3379	40	7	A
3380	40	8	C
3381	40	9	B
3382	40	10	B
3383	40	11	A
3384	40	12	B
3385	40	13	C
3386	40	14	A
3387	40	15	A
3388	40	16	C
3389	40	17	C
3390	40	18	C
3391	40	19	B
3392	40	20	A
3393	40	21	B
3394	40	22	B
3395	40	23	B
3396	40	24	B
3398	40	25	A
3399	40	26	B
3400	40	27	A
3401	40	28	C
3402	40	29	A
3403	40	30	A
3404	40	31	A
3405	40	32	A
3406	40	33	B
3407	40	34	B
3408	40	35	B
3409	40	36	A
3410	40	37	B
3411	40	38	B
3412	40	39	B
3413	40	40	B
3414	40	41	B
3415	40	42	B
3416	40	43	B
3417	40	44	A
3418	40	45	C
3419	40	46	C
3420	40	47	B
3421	40	48	A
3422	40	49	A
3423	40	50	A
3424	40	51	B
3425	40	52	A
3426	40	53	C
3427	40	54	A
3428	40	55	B
3429	40	56	A
3430	40	57	A
3431	40	58	B
3432	40	59	B
3433	40	60	A
3435	40	61	A
3436	40	62	B
3437	40	63	B
3438	40	64	C
3439	40	65	C
3440	40	66	A
3441	40	67	B
3442	40	68	A
3443	40	69	C
3444	40	70	A
3445	40	71	B
3446	40	72	C
3448	40	73	C
3449	40	74	C
3450	40	75	B
3451	40	76	C
3452	40	77	A
3453	40	78	B
3454	40	79	A
3455	40	80	A
3456	40	81	A
3457	40	82	C
3458	40	83	A
3459	40	84	C
3460	40	85	B
3461	40	86	B
3462	40	87	C
3463	40	88	C
3464	40	89	C
3465	40	90	B
3466	40	91	C
3467	40	92	A
3468	40	93	A
3469	40	94	B
3470	40	95	B
3471	40	96	C
3472	40	97	B
3473	40	98	C
3474	40	99	C
3475	40	100	A
3476	40	101	C
3477	40	102	A
3478	40	103	C
3479	40	104	A
3480	40	105	A
3481	40	106	A
3482	40	107	A
3483	40	108	B
3484	40	109	C
3485	40	110	A
3486	40	111	B
3487	40	112	C
3488	40	113	C
3489	40	114	C
3498	40	122	B
3499	40	123	A
3500	40	124	C
3501	40	125	B
3502	40	126	A
3503	40	127	C
3504	40	128	B
3505	40	129	B
3506	40	130	A
3507	40	131	B
3508	40	132	C
3509	42	1	A
3510	42	2	A
3511	40	133	A
1573	12	168	A
1681	20	62	B
1708	24	13	C
1709	26	13	C
1710	24	14	C
1711	24	15	A
1712	24	16	C
1713	26	14	B
1714	24	17	C
1715	24	18	C
1716	26	15	A
1717	24	19	A
1718	26	16	C
1719	24	20	A
1720	24	21	C
1721	26	17	B
1722	26	18	B
1723	26	19	A
1724	24	22	A
1725	26	20	B
1726	24	23	C
1727	26	21	B
1728	24	24	A
1729	24	25	A
1730	26	22	B
1731	24	26	C
1732	26	23	B
1733	24	27	A
1784	26	48	B
1785	24	52	A
1786	26	49	A
1787	24	53	C
1788	26	50	A
1789	24	54	A
1790	26	51	C
1791	24	55	C
1792	24	56	A
1793	26	52	B
1794	24	57	A
1795	26	53	C
1796	24	58	C
1797	26	54	A
1798	26	55	B
1799	26	56	A
1800	24	59	B
1801	26	57	C
1802	24	60	C
1803	24	61	A
1804	26	58	C
1805	24	62	C
1806	24	63	C
1807	26	59	B
1808	26	60	A
1809	24	64	C
1810	26	61	A
1852	24	86	A
1854	24	87	C
1853	26	78	C
1856	24	88	C
1863	24	94	C
1864	24	95	A
1882	24	105	A
1883	23	6	C
1884	23	7	C
1886	23	8	A
1910	24	116	C
1911	23	22	B
1954	24	135	A
1955	23	45	C
1956	24	136	C
1957	23	46	C
2000	23	62	C
2018	24	171	A
2019	24	172	A
2020	24	173	B
2021	23	70	A
2022	24	174	C
2023	23	71	C
2024	23	72	C
2025	24	175	A
2026	23	73	A
2027	24	176	C
2028	23	74	B
2030	23	75	A
2031	24	177	C
2032	23	76	C
2033	24	178	A
2034	23	77	A
2035	24	179	A
2036	24	180	A
2054	23	88	C
2055	23	89	C
2056	23	90	B
2057	23	91	B
2058	23	92	A
2059	23	93	A
2060	23	94	B
2061	23	95	B
2062	23	96	C
2081	26	85	B
2082	23	109	C
2098	23	117	A
2099	26	93	A
2100	26	94	B
2101	26	95	A
2102	23	118	A
2103	26	96	A
2104	23	119	B
2141	26	111	C
2143	23	136	C
2144	23	137	A
2145	26	112	C
2147	23	138	C
2148	26	113	B
2149	23	139	B
2150	23	140	A
2151	26	114	C
2152	23	141	C
2153	26	115	A
2154	23	142	A
2155	26	116	A
3320	37	147	B
2156	23	143	C
2159	26	117	A
2160	26	118	A
2161	23	144	A
2162	26	119	C
2163	23	145	A
2164	26	120	A
2257	26	164	A
2264	26	170	C
2265	26	171	C
2266	26	172	A
2267	26	173	B
2273	26	179	C
2274	26	180	C
2275	26	181	B
2277	26	182	A
2278	26	183	C
2279	26	184	C
2285	31	1	A
2286	31	2	A
2299	31	14	C
2300	31	15	B
2301	31	16	C
2302	31	17	C
2313	31	26	B
2314	31	27	A
2318	31	31	B
2319	31	32	B
2321	31	33	B
2339	31	51	C
2340	31	52	A
2341	31	53	B
2342	31	54	C
2343	31	55	C
2344	31	56	C
2345	31	57	C
2346	31	58	A
2347	31	59	C
2356	31	68	A
2360	31	72	B
2361	31	73	B
2362	31	74	C
2363	31	75	A
2372	31	83	A
2378	31	89	A
2379	31	90	C
2380	31	91	C
2386	31	97	B
2387	31	98	C
2394	31	104	A
2395	31	105	A
2401	31	111	C
3322	37	148	C
3323	37	149	A
3325	37	150	C
3327	37	151	B
3328	37	152	A
3329	37	153	A
3330	37	154	C
3331	37	155	B
3332	37	156	A
1682	20	49	A
1734	26	24	B
1735	24	28	C
1736	26	25	B
1811	24	65	C
1813	24	66	A
1812	26	62	C
1815	24	67	A
1816	26	63	B
1857	26	79	A
1858	24	89	A
1859	24	90	C
1865	24	96	C
1887	24	106	C
1888	23	9	B
1889	23	10	C
1890	24	107	A
1891	23	11	A
1892	23	12	B
1893	24	108	A
1894	23	13	C
1895	24	109	B
1896	23	14	C
1912	23	23	C
1913	24	117	A
1914	23	24	A
1915	23	25	C
1916	24	118	A
1918	24	119	A
1917	23	26	A
1920	24	120	A
1921	23	27	A
1922	23	28	B
1923	24	121	B
1924	23	29	A
1925	23	30	C
1958	23	47	B
1959	23	48	C
1960	23	49	A
1961	24	137	A
1962	24	138	A
1963	23	50	A
1964	23	51	A
1965	23	52	A
1966	24	139	A
1967	23	53	C
1968	24	140	A
1969	23	54	A
1970	24	141	A
1971	24	142	A
1972	23	55	C
1574	20	142	A
2412	34	5	B
1973	23	56	A
1974	24	143	C
1975	24	144	A
1976	23	57	B
1977	23	58	A
1978	24	145	A
2001	24	162	C
2003	24	163	C
2004	23	63	C
2005	23	64	C
2006	24	164	A
2007	23	65	C
2037	24	181	C
2038	24	182	A
2039	23	78	A
2040	24	183	C
2041	23	79	A
2042	23	80	A
2043	24	184	C
2044	23	81	B
2045	24	185	A
2046	24	186	C
2047	24	187	A
2049	23	83	A
2050	23	84	B
2051	23	85	B
2064	23	97	B
2065	23	98	C
2066	23	99	C
2067	23	100	A
2068	23	101	B
2069	23	102	A
2083	23	110	C
2084	26	86	B
2105	23	120	C
2106	26	97	A
2107	26	98	C
2109	23	121	C
2110	26	99	C
2165	23	146	A
2166	26	121	C
2259	26	166	A
2268	26	174	C
2269	26	175	B
2280	26	185	B
2282	26	186	C
2283	26	187	A
2287	31	3	B
2289	31	4	B
2290	31	5	B
2291	31	6	C
2292	31	7	B
2293	31	8	C
2294	31	9	B
2295	31	10	A
2296	31	11	A
2297	31	12	B
2303	31	18	C
2304	31	19	B
2306	31	20	B
2315	31	28	B
2322	31	34	A
2323	31	35	B
2324	31	36	C
2325	31	37	C
2326	31	38	C
2327	31	39	B
2328	31	40	C
2348	31	60	B
2349	31	61	A
2350	31	62	C
2357	31	69	C
2358	31	70	A
2364	31	76	B
2366	31	77	A
2373	31	84	B
2374	31	85	B
2381	31	92	A
2382	31	93	A
2383	31	94	B
2384	31	95	B
2388	31	99	C
2389	31	100	B
2390	31	101	C
2392	31	102	A
2396	31	106	A
2397	31	107	B
2398	31	108	C
2399	31	109	C
2400	31	110	C
2402	31	112	C
2403	31	113	C
2404	31	114	A
2406	31	115	B
2407	31	116	C
2408	34	1	A
2409	34	2	A
2410	34	3	A
2411	34	4	A
2414	34	6	C
2415	34	7	C
2416	34	8	C
2417	34	9	A
2418	34	10	A
2420	34	11	A
2421	34	12	B
2422	34	13	C
2423	34	14	A
2424	34	15	A
2425	34	16	C
2426	34	17	C
2427	34	18	C
2428	34	19	A
2429	34	20	A
2430	34	21	C
2432	34	22	B
2433	34	23	C
2434	34	24	A
1576	12	169	A
1577	20	143	A
1578	12	170	C
1579	20	144	B
1575	13	160	B
1581	20	145	C
2435	34	25	A
2441	34	29	A
2436	34	26	B
2439	34	27	A
2440	34	28	C
2443	34	30	C
1683	26	1	A
1684	26	2	A
1737	26	26	C
1738	26	27	A
1739	24	29	A
1740	26	28	B
1741	24	30	C
1742	24	31	C
1743	26	29	A
1744	24	32	A
1745	26	30	C
1746	24	33	C
1747	26	31	C
1748	24	34	C
1749	26	32	A
1750	24	35	B
1751	26	33	B
1752	24	36	A
1753	26	34	B
1754	24	37	C
1755	24	38	C
1756	26	35	B
1757	24	39	C
1758	26	36	A
1759	24	40	C
1760	26	37	C
1817	26	64	C
1818	24	68	A
1819	26	65	B
1820	24	69	A
1821	26	66	C
1822	24	70	B
1823	26	67	A
1824	24	71	C
1860	24	91	C
1867	24	97	B
1868	24	98	C
1869	24	99	C
855	14	1	A
856	14	2	A
857	14	3	B
858	14	4	A
859	14	5	C
860	14	6	C
861	12	1	A
862	12	2	A
863	14	7	C
864	14	8	C
865	14	9	A
866	14	10	C
867	14	11	B
869	14	12	B
870	14	13	B
871	14	14	A
872	12	3	B
873	14	15	B
874	14	16	C
875	12	4	A
876	12	5	A
877	14	17	C
878	20	1	A
879	14	18	A
880	14	19	C
881	20	2	A
882	14	20	B
883	12	6	C
884	20	3	A
885	12	7	C
886	14	21	C
887	12	8	C
888	20	4	B
889	12	9	B
890	20	5	A
891	14	22	B
892	13	1	A
893	12	10	B
894	14	23	A
895	13	2	A
896	20	6	B
897	12	11	A
898	20	7	C
899	12	12	C
900	14	24	B
901	14	25	A
902	13	3	B
903	20	8	C
904	13	4	A
905	14	26	C
906	13	5	A
907	12	13	C
909	13	6	C
910	14	27	C
911	13	7	C
912	14	28	A
913	14	29	A
914	13	8	C
915	14	30	C
916	14	31	C
917	13	9	A
918	12	14	A
919	14	32	A
920	13	10	A
921	14	33	C
923	12	15	B
922	14	34	C
925	13	11	B
926	12	16	C
927	14	35	B
928	14	36	C
929	12	17	C
930	14	37	C
931	13	12	C
932	14	38	A
933	12	18	C
934	14	39	C
935	12	19	B
936	13	13	C
937	14	40	C
938	13	14	C
939	14	41	B
940	14	42	A
941	13	15	A
942	13	16	C
943	14	43	C
944	14	44	A
945	14	45	C
946	13	17	C
947	14	46	C
948	13	18	C
949	14	47	C
950	14	48	C
951	14	49	A
952	14	50	A
953	13	19	A
954	14	51	A
956	13	20	A
955	14	52	A
958	14	53	C
959	14	54	A
960	14	55	C
961	13	21	A
962	14	56	A
963	14	57	A
964	14	58	B
966	14	59	C
967	14	60	B
965	13	22	A
969	14	61	A
971	14	62	C
972	14	63	C
973	13	23	C
974	14	64	C
975	14	65	C
976	13	24	C
977	14	66	A
978	13	25	A
979	14	67	A
980	14	68	C
981	13	26	C
982	14	69	A
983	14	70	A
984	14	71	A
985	13	27	C
986	14	72	C
987	13	28	B
988	14	73	C
989	14	74	C
990	14	75	A
991	14	76	B
993	13	29	C
994	14	77	A
995	13	30	C
996	13	31	C
997	14	78	A
998	13	32	A
999	14	79	A
1000	13	33	B
1001	14	80	C
1002	14	81	B
1004	14	82	C
1005	14	83	A
1006	14	84	C
1007	14	85	B
1582	12	171	A
1186	20	36	A
1009	14	86	B
1012	14	87	C
1013	14	88	C
1014	13	34	A
1015	14	89	A
1016	13	35	C
1017	14	90	C
1019	13	36	A
1018	14	91	C
1021	14	92	A
1022	13	37	C
1023	14	93	B
1024	13	38	C
1188	20	37	A
1025	14	94	B
1028	13	39	B
1029	14	95	A
1030	13	40	B
1031	14	96	C
1032	13	41	C
1034	14	97	A
1035	14	98	C
1036	13	42	C
1037	14	99	A
1038	14	100	A
1039	14	101	A
1040	13	43	C
1041	14	102	A
1042	14	103	C
1189	12	29	A
1044	14	104	A
1047	13	44	B
1048	14	105	C
1049	14	106	B
1050	14	107	A
1051	13	45	C
1052	14	108	C
1053	14	109	B
1055	13	46	C
1056	14	110	A
1057	14	111	C
1059	14	112	C
1060	14	113	B
1058	13	47	C
1062	14	114	C
1063	13	48	C
1064	13	49	A
1065	14	115	A
1190	20	38	C
1066	14	116	A
1069	13	50	A
1070	14	117	A
1071	13	51	A
1072	14	118	A
1073	14	119	C
1075	13	52	B
1076	14	120	A
1077	13	53	C
1078	14	121	B
1080	14	122	B
1081	13	54	C
1082	14	123	C
1083	14	124	A
1084	13	55	A
1085	14	125	A
1086	14	126	C
1087	13	56	A
1088	14	127	C
1089	13	57	C
1090	13	58	C
1091	14	128	C
1092	14	129	A
1093	14	130	A
1094	13	59	C
1095	14	131	C
1096	14	132	B
1097	14	133	A
1098	14	134	A
1099	14	135	C
1101	14	136	A
1102	13	60	A
1103	14	137	A
1104	14	138	C
1105	13	61	A
1107	13	62	C
1106	14	139	B
1109	14	140	A
1110	14	141	B
1112	13	63	B
1113	14	142	A
1114	14	143	C
1115	14	144	C
1116	14	145	A
1117	13	64	C
1118	14	146	A
1119	13	65	C
1120	14	147	A
1121	13	66	A
1122	14	148	C
1123	13	67	A
1124	14	149	C
1125	13	68	A
1126	13	69	A
1127	20	9	B
1128	20	10	B
1129	13	70	A
1130	20	11	A
1131	13	71	A
1132	20	12	B
1133	13	72	A
1134	13	73	C
1135	20	13	C
1136	13	74	C
1137	13	75	A
1138	20	14	B
1139	13	76	C
1140	20	15	A
1141	13	77	B
1143	20	16	C
1144	13	78	B
1145	20	17	B
1146	13	79	A
1147	20	18	C
1148	13	80	C
1149	20	19	A
1150	13	81	B
1151	20	20	A
1152	13	82	C
1153	13	83	C
1154	20	21	B
1155	13	84	B
1156	13	85	B
1158	20	22	B
1159	20	23	A
1160	13	86	B
1162	20	24	B
1163	13	87	B
1164	20	25	B
1165	13	88	C
1166	20	26	C
1167	13	89	C
1168	20	27	A
1169	12	20	B
1170	20	28	B
1171	12	21	B
1172	20	29	A
1173	20	30	B
1174	12	22	C
1175	12	23	C
1176	20	31	C
1177	20	32	A
1178	12	24	A
1179	12	25	A
1180	20	33	B
1181	12	26	B
1182	12	27	A
1183	20	34	B
1184	20	35	B
1185	12	28	A
1191	20	39	A
1192	12	30	C
1193	20	40	B
1194	12	31	C
1195	12	32	A
1196	20	41	B
1197	12	33	C
1198	12	34	A
1199	20	42	C
1200	12	35	B
1201	12	36	A
1202	12	37	B
1203	20	43	B
1204	12	38	B
1205	20	44	A
1206	12	39	B
1207	20	45	C
1208	12	40	B
1209	20	46	C
1210	12	41	A
1211	20	47	B
1212	12	42	C
1213	20	48	A
1214	12	43	C
1215	12	44	B
1216	12	45	A
1217	12	46	B
1218	20	50	C
1219	12	47	B
1220	12	48	C
1221	12	49	A
1222	20	51	B
1223	12	50	C
1224	20	52	A
1225	12	51	B
1226	20	53	B
1227	12	52	A
1228	20	54	C
1229	12	53	C
1230	12	54	C
1231	20	55	B
1232	12	55	C
1233	20	56	A
1234	20	57	B
1235	12	56	B
1236	20	58	B
1237	12	57	C
1238	12	58	C
1239	20	59	C
1240	12	59	A
1241	20	60	B
1242	12	60	B
1243	20	61	A
1244	12	61	A
1245	12	62	C
1246	12	63	C
1247	12	64	B
1248	20	63	A
1249	14	150	C
1250	12	65	A
1252	14	151	A
1253	20	64	A
1254	12	66	A
1385	13	114	B
1255	14	152	A
1258	14	153	A
1259	12	67	A
1260	20	65	C
1262	14	154	B
1264	14	155	C
1266	12	68	A
1267	20	66	B
1268	14	156	A
1269	14	157	C
1270	14	158	A
1271	20	67	C
1272	12	69	C
1273	14	159	A
1274	14	160	C
1275	20	68	A
1276	13	90	C
1277	12	70	A
1278	14	161	C
1279	14	162	C
1280	12	71	A
1281	20	69	A
1282	14	163	A
1283	13	91	C
1285	20	70	A
1286	14	164	A
1287	12	72	B
1289	13	92	A
1290	14	165	A
1291	12	73	A
1292	14	166	B
1293	20	71	B
1294	12	74	A
1295	14	167	A
1296	13	93	A
1297	14	168	A
1298	12	75	A
1299	20	72	C
1300	14	169	A
1301	12	76	C
1302	13	94	C
1303	14	170	A
1304	13	95	A
1305	14	171	B
1306	14	172	A
1307	20	73	B
1308	14	173	B
1309	13	96	A
1310	12	77	A
1311	20	74	C
1312	14	174	C
1313	13	97	B
1314	20	75	A
1315	14	175	A
1316	13	98	C
1317	14	176	C
1318	13	99	C
1319	14	177	C
1320	20	76	B
1321	14	178	C
1322	13	100	A
1323	12	78	A
1324	20	77	A
1325	14	179	A
1326	13	101	C
1327	14	180	A
1328	13	102	A
1329	12	79	C
1330	14	181	C
1331	13	103	C
1332	12	80	B
1333	14	182	A
1335	14	183	A
1336	12	81	A
1337	14	184	C
1338	12	82	C
1339	20	78	A
1340	14	185	B
1341	14	186	A
1342	12	83	A
1334	13	104	A
1344	14	187	A
1345	12	84	C
1346	20	79	A
1347	20	80	A
1348	12	85	B
1349	20	81	A
1350	13	105	A
1351	20	82	C
1352	12	86	A
1353	12	87	C
1354	20	83	A
1355	20	84	B
1356	13	106	B
1357	12	88	C
1358	20	85	B
1359	12	89	B
1361	12	90	C
1362	13	107	B
1363	12	91	C
1364	20	86	B
1365	12	92	B
1366	13	108	B
1367	20	87	B
1368	13	109	C
1369	13	110	A
1370	12	93	A
1371	20	88	B
1372	12	94	C
1373	20	89	B
1374	12	95	B
1375	13	111	B
1376	20	90	B
1377	13	112	C
1378	12	96	C
1379	13	113	B
1380	20	91	C
1381	20	92	B
1382	12	97	B
1383	20	93	A
1384	12	98	C
1387	12	99	C
1388	20	94	B
1389	13	115	A
1390	12	100	B
1392	20	95	B
1393	12	101	C
1394	13	116	A
1395	12	102	A
1396	20	96	B
1397	12	103	B
1398	12	104	A
1399	13	117	B
1401	12	105	A
1402	12	106	B
1403	13	118	A
1404	12	107	C
1405	13	119	C
1406	12	108	C
1407	12	109	B
1408	13	120	A
1409	20	97	B
1583	13	161	C
1410	12	110	A
1411	20	98	C
1412	12	111	C
1413	12	112	C
1414	12	113	C
1415	20	99	C
1416	13	121	A
1417	12	114	C
1418	20	100	B
1420	20	101	B
1419	12	115	B
1422	20	102	A
1423	13	122	B
1424	12	116	A
1425	13	123	B
1426	12	117	A
1427	20	103	B
1428	13	124	B
1430	20	104	A
1431	12	118	A
1433	13	125	C
1432	12	119	A
1435	12	120	A
1436	20	105	C
1437	13	126	A
1438	12	121	C
1439	20	106	A
1440	13	127	A
1441	20	107	C
1442	13	128	C
1443	12	122	B
1444	12	123	A
1445	13	129	B
1446	12	124	B
1584	12	172	A
1447	13	130	A
1450	20	108	B
1451	12	125	A
1452	20	109	C
1453	12	126	B
1454	13	131	A
1455	13	132	C
1456	20	110	A
1457	13	133	A
1458	12	127	C
1459	13	134	C
1461	12	128	A
1462	20	111	C
1463	12	129	B
1464	20	112	C
1460	13	135	B
1466	20	113	C
1467	12	130	A
1468	12	131	A
1469	20	114	C
1470	13	136	C
1471	12	132	C
1472	12	133	A
1473	13	137	C
1474	12	134	B
1475	13	138	C
1476	20	115	A
1477	20	116	A
1478	12	135	B
1479	13	139	B
1480	12	136	C
1481	13	140	A
1482	20	117	A
1483	12	137	A
1484	13	141	B
1485	20	118	A
1486	12	138	C
1487	13	142	A
1488	13	143	C
1489	20	119	B
1490	12	139	B
1491	12	140	A
1492	20	120	A
1493	12	141	A
1494	13	144	C
1496	12	142	B
1497	20	121	A
1498	13	145	A
1499	12	143	C
1500	12	144	C
1501	13	146	C
1502	20	122	B
1503	12	145	A
1505	20	123	A
1506	20	124	A
1507	12	146	C
1508	13	147	C
1509	20	125	A
1510	12	147	C
1511	20	126	C
1585	12	173	B
1514	20	127	C
1512	12	148	B
1516	13	148	C
1517	12	149	C
1518	20	128	B
1519	13	149	B
1520	12	150	C
1521	20	129	B
1586	20	146	C
1524	12	151	B
1525	20	130	A
1587	20	147	B
1588	12	174	C
1522	13	150	C
1530	20	131	C
1589	13	162	C
1528	12	152	A
1533	13	151	C
1534	12	153	B
1535	20	132	C
1536	20	133	A
1537	13	152	A
1538	12	154	C
1539	20	134	B
1540	12	155	C
1541	13	153	B
1543	12	156	A
1545	12	157	C
1546	13	154	C
1547	12	158	A
1548	13	155	C
1549	12	159	A
1544	20	135	A
1551	12	160	C
1552	12	161	C
1553	20	136	B
1554	13	156	C
1555	12	162	C
1556	20	137	A
1558	20	138	C
1590	12	175	A
1560	12	163	C
1561	12	164	C
1591	20	148	C
1562	20	139	A
1557	13	157	B
1566	12	165	A
1567	20	140	A
1568	12	166	A
1569	13	158	B
1570	20	141	A
1571	12	167	A
1572	13	159	A
1592	13	163	C
1593	12	176	C
1594	20	149	B
1595	13	164	A
1596	12	177	C
1597	20	150	B
1598	12	178	A
1599	20	151	B
1600	13	165	A
1601	12	179	C
1602	13	166	C
1603	20	152	A
1604	12	180	B
1606	20	153	C
1607	12	181	B
1608	13	167	A
1609	20	154	C
1610	12	182	B
1612	20	155	C
1613	12	183	C
1614	13	168	B
1616	20	156	A
1617	12	184	C
1618	20	157	C
1619	13	169	A
1620	12	185	A
1621	20	158	B
1622	13	170	C
1623	20	159	A
1625	20	160	C
1626	13	171	A
1624	12	186	C
1629	12	187	A
1630	20	161	C
1631	13	172	B
1685	26	3	A
1686	26	4	A
1687	26	5	A
1688	24	1	A
1689	24	2	A
1690	26	6	B
1691	24	3	C
1692	24	4	A
1693	26	7	B
1694	24	5	A
1695	26	8	C
1696	24	6	C
1697	26	9	B
1699	24	7	C
1700	24	8	A
1701	26	10	B
1702	24	9	B
1761	24	41	B
1762	26	38	C
1763	26	39	B
1764	24	42	C
1765	26	40	C
1766	24	43	A
1767	26	41	B
1768	24	44	A
1769	26	42	A
1771	24	45	A
1826	26	68	B
1825	24	72	A
1828	26	69	C
1829	24	73	A
1831	26	70	C
1832	24	74	C
1833	24	75	A
1834	26	71	B
1835	24	76	C
1861	24	92	A
1870	23	1	A
1871	24	100	A
1872	23	2	A
2310	31	24	C
1873	24	101	C
1897	24	110	A
1898	23	15	C
1899	23	16	A
1900	24	111	C
1901	23	17	C
1902	23	18	C
1903	24	112	C
1904	23	19	B
1905	24	113	C
1906	23	20	B
1907	24	114	C
1926	23	31	B
1927	23	32	A
1928	23	33	A
1929	24	122	C
1930	24	123	A
1931	23	34	C
1932	24	124	A
1933	23	35	B
1934	24	125	C
1935	23	36	A
1936	24	126	C
1937	23	37	C
1938	23	38	B
1940	24	127	C
1941	23	39	B
1942	24	128	C
1943	23	40	B
1944	24	129	C
1945	24	130	A
1979	24	146	C
1980	23	59	B
1981	24	147	C
1982	23	60	C
1983	23	61	A
1984	24	148	C
1985	24	149	C
1986	24	150	C
1987	24	151	C
1988	24	152	A
2312	31	25	B
1989	24	153	A
1992	24	154	C
1993	24	155	C
1994	24	156	A
1995	24	157	C
1996	24	158	A
2008	23	66	C
2009	23	67	B
2010	24	165	A
2011	24	166	A
2012	24	167	A
2013	23	68	A
2014	24	168	C
2048	23	82	C
2070	23	103	B
2085	23	111	C
2086	26	87	C
2087	23	112	B
2088	26	88	C
2089	23	113	C
2090	26	89	C
2092	26	90	C
2093	23	114	C
2111	23	122	C
2112	26	100	A
2113	23	123	B
2114	26	101	C
2115	23	124	A
2116	23	125	C
2117	26	102	A
2118	23	126	C
2119	26	103	B
2120	23	127	C
2121	26	104	A
2122	23	128	C
2123	26	105	A
2124	23	129	B
2316	31	29	A
2125	26	106	A
2128	23	130	C
2130	26	107	A
2167	23	147	C
2168	26	122	B
2169	26	123	A
2170	23	148	C
2171	26	124	C
2172	23	149	B
2173	23	150	C
2174	23	151	C
2175	26	125	A
2176	26	126	C
2177	23	152	A
2178	23	153	A
2179	23	154	C
2180	26	127	A
2181	23	155	C
2183	23	156	A
2182	26	128	C
2185	26	129	B
2186	23	157	B
2188	23	158	A
2187	26	130	B
2260	26	167	B
2261	26	168	A
2270	26	176	C
2271	26	177	A
2272	26	178	A
2298	31	13	C
2307	31	21	B
2308	31	22	B
2309	31	23	A
2317	31	30	C
2329	31	41	A
2330	31	42	B
2331	31	43	C
2332	31	44	A
2333	31	45	B
2334	31	46	C
2335	31	47	A
2336	31	48	C
2337	31	49	A
2338	31	50	A
2351	31	63	C
2352	31	64	C
2353	31	65	C
2354	31	66	B
2355	31	67	A
2359	31	71	A
2367	31	78	A
2368	31	79	A
2369	31	80	B
2370	31	81	B
2371	31	82	B
2375	31	86	C
2376	31	87	C
2377	31	88	C
2385	31	96	C
2393	31	103	C
3333	37	157	B
1632	20	162	B
1633	13	173	B
1634	13	174	C
1635	20	163	C
1636	20	164	B
1637	13	175	A
1638	20	165	A
1639	20	166	A
1640	13	176	C
1641	20	167	B
1642	13	177	C
1644	20	168	B
1646	13	178	A
1647	20	169	B
1648	13	179	A
1649	20	170	C
1651	13	180	C
1652	13	181	A
1653	20	171	A
1654	13	182	C
1655	20	172	A
1656	20	173	B
1657	20	174	C
1658	13	183	B
1659	13	184	B
1660	20	175	B
1662	13	185	A
1663	20	176	C
1664	20	177	B
1665	13	186	C
1666	20	178	A
1667	13	187	A
1668	20	179	C
1669	20	180	C
1670	20	181	A
1672	20	183	B
1673	20	184	A
1674	20	185	A
1675	20	186	C
1703	26	11	B
1676	20	187	A
1704	24	10	A
1671	20	182	A
1705	26	12	C
1706	24	11	A
1707	24	12	A
1772	24	46	C
1773	26	43	B
1774	24	47	A
1775	26	44	B
1777	24	48	A
1778	24	49	A
1779	26	45	C
1780	26	46	C
1781	24	50	A
1782	24	51	A
1783	26	47	B
1836	24	77	A
1837	26	72	A
1838	24	78	A
1839	26	73	C
1840	24	79	B
1841	24	80	A
1842	26	74	B
1843	24	81	A
1844	26	75	A
1846	24	82	C
1847	24	83	A
1848	24	84	C
1849	26	76	B
1850	24	85	C
1851	26	77	B
1862	24	93	A
1876	24	102	C
1877	23	3	C
1878	23	4	A
1879	24	103	C
1880	23	5	A
1881	24	104	A
1908	24	115	A
1909	23	21	C
1946	24	131	C
1947	23	41	C
1948	24	132	C
1949	23	42	B
1950	24	133	A
1951	23	43	C
1952	24	134	A
1953	23	44	C
1997	24	159	B
1998	24	160	C
1999	24	161	C
2015	23	69	C
2016	24	169	B
2017	24	170	C
2052	23	86	C
2053	23	87	C
2071	23	104	A
2072	26	80	A
2073	23	105	C
2074	26	81	A
2075	23	106	C
2076	26	82	B
2077	23	107	B
2078	26	83	A
2079	23	108	A
2080	26	84	C
2094	23	115	C
2095	26	91	C
2096	23	116	A
2097	26	92	B
2131	26	108	A
2132	23	131	C
2133	26	109	B
2134	23	132	C
2135	23	133	B
2136	23	134	A
2139	23	135	C
2138	26	110	C
2190	26	131	C
2191	26	132	C
2192	26	133	A
2193	23	159	A
2194	26	134	B
2195	23	160	B
2196	26	135	B
2197	23	161	C
2198	26	136	C
2199	23	162	C
2200	23	163	C
2201	26	137	A
2202	26	138	A
2203	23	164	B
2204	26	139	A
2205	26	140	A
2206	26	141	A
2207	26	142	A
2208	23	165	C
2209	26	143	B
2210	26	144	A
2211	23	166	A
2212	23	167	B
2213	26	145	A
2214	23	168	C
2215	26	146	C
2216	23	169	B
2217	26	147	B
2218	23	170	C
2219	23	171	A
2220	26	148	C
2221	26	149	C
2222	23	172	A
2223	26	150	C
2224	23	173	B
2226	23	174	B
2225	26	151	B
2228	26	152	A
2230	23	175	A
2232	26	153	A
2233	23	176	C
2234	26	154	C
2235	23	177	C
2236	26	155	C
2237	23	178	B
2238	23	179	C
2240	23	180	C
2239	26	156	A
2242	26	157	C
2243	23	181	C
2244	26	158	A
2245	26	159	A
2246	26	160	C
2247	23	182	B
2248	26	161	C
2249	23	183	C
2250	23	184	C
2251	23	185	B
2252	26	162	C
2253	23	186	B
2255	23	187	A
2256	26	163	A
2258	26	165	B
2262	26	169	B
2444	34	31	A
2445	34	32	A
2446	34	33	C
2447	34	34	C
2448	34	35	B
2449	34	36	B
2618	34	163	C
2450	34	37	A
2453	34	38	C
2454	34	39	B
2455	34	40	B
2456	34	41	B
2457	34	42	C
2458	34	43	C
2620	34	164	A
2459	34	44	B
2462	34	45	C
2463	34	46	C
2464	34	47	A
2465	34	48	A
2466	34	49	A
2467	34	50	C
2468	34	51	A
2469	34	52	A
2471	34	53	C
2621	31	133	A
2473	34	54	C
2622	34	165	C
2476	34	55	A
2479	34	56	A
2480	34	57	C
2481	34	58	C
2482	34	59	C
2483	34	60	A
2484	34	61	A
2485	34	62	A
2486	34	63	C
2487	34	64	C
2488	34	65	C
2489	34	66	B
2490	34	67	A
2491	34	68	C
2492	34	69	C
2493	34	70	A
2494	34	71	B
2495	34	72	A
2496	34	73	C
2497	34	74	C
2498	34	75	A
2499	34	76	C
2500	34	77	A
2501	34	78	A
2502	34	79	C
2503	34	80	A
2504	34	81	B
2623	31	134	C
2506	34	82	B
2509	34	83	C
2510	34	84	C
2511	34	85	C
2512	34	86	C
2513	34	87	C
2514	34	88	C
2515	34	89	A
2516	34	90	C
2517	34	91	C
2518	34	92	A
2519	34	93	A
2520	34	94	C
2522	34	95	A
2523	34	96	A
2525	34	97	B
2526	34	98	C
2527	34	99	B
2529	34	100	C
2530	34	101	C
2531	34	102	A
2532	34	103	C
2533	34	104	A
2534	34	105	A
2535	34	106	A
2536	34	107	A
2537	34	108	A
2538	34	109	B
2539	34	110	A
2540	34	111	C
2541	34	112	C
2542	34	113	C
2543	34	114	C
2544	34	115	A
2545	34	116	B
2546	34	117	A
2547	34	118	A
2548	34	119	C
2549	34	120	A
2624	34	166	A
2550	34	121	B
2553	34	122	B
2555	34	123	A
2556	34	124	A
2557	34	125	A
2558	34	126	A
2559	34	127	A
2560	34	128	C
2562	34	129	C
2563	34	130	A
2564	34	131	C
2566	34	132	C
2567	34	133	A
2568	34	134	A
2569	34	135	B
2570	34	136	C
2571	34	137	A
2572	34	138	A
2573	34	139	A
2574	34	140	A
2575	34	141	A
2576	34	142	A
2577	34	143	B
2579	34	144	A
2580	31	117	B
2581	31	118	A
2582	34	145	C
2583	34	146	C
2584	31	119	C
2585	34	147	C
2586	31	120	C
2587	34	148	C
2589	31	121	A
2590	34	149	A
2592	34	150	A
2593	34	151	C
2594	34	152	A
2595	31	122	B
2596	31	123	A
2597	31	124	A
2598	34	153	C
2600	31	125	B
2601	34	154	C
2602	34	155	C
2603	31	126	C
2604	34	156	A
2605	34	157	C
2606	31	127	A
2607	34	158	A
2609	31	128	A
2610	34	159	A
2611	34	160	B
2612	31	129	B
2613	34	161	C
2614	34	162	C
2615	31	130	A
2616	31	131	A
2617	31	132	C
2625	31	135	B
2626	34	167	C
2627	34	168	A
2628	31	136	C
2629	34	169	A
2630	34	170	C
2631	31	137	A
2632	31	138	A
2633	34	171	C
2634	34	172	A
2635	34	173	B
2636	31	139	C
2638	34	174	C
2639	31	140	A
2640	34	175	A
2641	31	141	A
2642	34	176	C
2643	34	177	A
2644	34	178	A
2645	34	179	A
2646	34	180	A
2647	31	142	A
2648	31	143	B
2649	31	144	A
2650	31	145	B
2651	34	181	C
2652	31	146	C
2653	34	182	A
3335	37	158	A
2655	31	147	C
2656	34	183	C
2657	34	184	A
2658	31	148	C
2659	31	149	B
2660	31	150	C
2662	31	151	C
2661	34	185	C
2664	31	152	A
2665	31	153	A
2666	34	186	A
2667	31	154	C
2668	31	155	C
2669	34	187	A
2670	31	156	A
2671	31	157	B
2672	31	158	A
2673	31	159	B
2674	31	160	C
2675	31	161	C
2676	31	162	C
2677	31	163	A
2679	31	164	B
2680	31	165	A
2681	31	166	A
2682	31	167	A
2683	31	168	C
2684	31	169	B
2685	31	170	C
2686	31	171	C
2687	31	172	A
2688	31	173	B
2689	31	174	C
2690	31	175	A
2691	31	176	C
2692	31	177	B
2693	31	178	B
2694	31	179	A
2695	31	180	A
2696	31	181	C
2697	31	182	B
2698	31	183	C
2699	31	184	B
2700	31	185	B
2701	31	186	C
2702	31	187	A
2703	36	1	A
2704	36	2	A
2705	36	3	B
2706	36	4	B
2707	36	5	A
2823	36	108	B
2708	36	6	B
2711	36	7	C
2712	36	8	C
2713	36	9	C
2714	36	10	A
2715	36	11	A
2716	36	12	A
2717	36	13	C
2718	36	14	C
2719	36	15	C
2720	36	16	C
2721	36	17	C
2722	36	18	C
2723	36	19	A
2724	36	20	B
2725	36	21	A
2726	36	22	C
2727	36	23	C
2728	36	24	A
2729	36	25	B
2730	36	26	B
2731	36	27	C
2732	36	28	C
2733	36	29	B
2734	36	30	C
2735	36	31	A
2736	36	32	A
2825	36	109	B
2826	36	110	C
2740	36	34	C
2737	36	33	B
2742	36	35	B
2743	36	36	C
2744	36	37	C
2745	36	38	C
2746	36	39	B
2747	36	40	C
2748	36	41	B
2749	36	42	A
2750	36	43	B
2751	36	44	C
2752	36	45	C
2753	36	46	C
2754	36	47	A
2755	36	48	A
2756	36	49	A
2757	36	50	A
2758	36	51	C
2760	36	52	A
2761	36	53	C
2762	36	54	C
2764	36	55	C
2765	36	56	A
2766	36	57	A
2767	36	58	C
2769	36	59	B
2770	36	60	A
2771	36	61	A
2772	36	62	A
2773	36	63	B
2774	36	64	C
2775	36	65	C
2776	36	66	B
2777	36	67	B
2778	36	68	A
2779	36	69	C
2780	36	70	A
2781	36	71	C
2782	36	72	A
2783	36	73	A
2784	36	74	C
2785	36	75	A
2786	36	76	B
2788	36	77	A
2789	36	78	B
2790	36	79	A
2791	36	80	A
2792	36	81	A
2793	36	82	A
2794	36	83	A
2795	36	84	B
2796	36	85	B
2797	36	86	C
2798	36	87	B
2800	36	88	C
2801	36	89	A
2827	36	111	C
2802	36	90	B
2805	36	91	B
2807	36	92	C
2808	36	93	A
2809	36	94	B
2810	36	95	A
2811	36	96	C
2812	36	97	B
2813	36	98	C
2814	36	99	C
2815	36	100	A
2816	36	101	B
2817	36	102	A
2818	36	103	C
2819	36	104	A
2820	36	105	C
2821	36	106	A
2822	36	107	C
2828	36	112	C
2829	36	113	C
2830	36	114	A
2831	36	115	B
2833	36	116	C
2835	36	117	A
2836	36	118	A
2837	36	119	C
2838	36	120	A
2845	36	125	B
2839	36	121	C
2842	36	122	A
2843	36	123	A
2844	36	124	A
2847	36	126	C
2848	36	127	A
2850	36	128	C
2851	36	129	A
2852	36	130	A
2853	36	131	C
2854	36	132	C
2855	36	133	A
2856	36	134	A
2857	36	135	C
2858	36	136	B
2860	36	137	A
2861	36	138	A
2862	36	139	C
2863	36	140	A
2864	36	141	A
2865	36	142	C
2866	36	143	C
2867	36	144	A
2868	36	145	B
2869	36	146	A
2870	36	147	A
2871	36	148	B
2872	36	149	C
2873	36	150	B
2874	36	151	B
2876	36	152	A
2877	36	153	A
2878	36	154	C
2879	36	155	C
2880	36	156	A
2881	36	157	C
2882	36	158	A
2883	36	159	A
2884	36	160	C
2885	36	161	C
2886	36	162	B
2887	36	163	C
2888	36	164	A
2889	36	165	C
2890	36	166	A
2891	36	167	B
2892	36	168	C
2893	36	169	B
2894	36	170	C
2895	36	171	A
2896	36	172	A
2897	36	173	B
2898	36	174	C
2899	36	175	A
2900	36	176	C
2901	36	177	B
2902	36	178	A
2903	36	179	A
2904	36	180	A
2905	36	181	A
2906	36	182	B
2907	36	183	C
2908	36	184	A
2909	36	185	A
2910	36	186	A
2911	36	187	A
2912	37	1	A
2913	37	2	A
2914	37	3	A
2915	37	4	A
2916	37	5	A
2917	37	6	C
2918	37	7	C
2919	37	8	C
2920	37	9	B
2921	37	10	C
2922	37	11	A
2923	37	12	A
3030	38	43	B
2924	37	13	B
2927	37	14	C
2928	37	15	A
2929	37	16	A
2931	37	17	C
2932	37	18	B
2933	37	19	A
2934	37	20	B
2935	37	21	B
2936	37	22	B
2937	37	23	C
2938	37	24	A
2939	37	25	A
2940	37	26	B
2941	37	27	A
2942	37	28	B
2943	37	29	A
2944	37	30	C
2945	37	31	B
2946	37	32	A
2947	37	33	B
2948	37	34	B
2949	37	35	B
2950	37	36	B
2951	37	37	B
2952	37	38	C
2953	37	39	A
2954	37	40	B
2955	37	41	A
2956	37	42	B
2957	37	43	B
2958	37	44	A
2959	37	45	C
2960	37	46	C
2961	37	47	B
2962	37	48	A
2963	37	49	A
2964	37	50	B
2965	37	51	A
2966	37	52	B
2967	37	53	B
2968	37	54	A
2969	37	55	B
2970	37	56	A
2971	37	57	C
2972	37	58	C
2974	37	59	C
2975	37	60	A
2976	37	61	A
2977	37	62	B
2978	37	63	C
2979	37	64	C
2980	37	65	C
2981	37	66	B
2982	37	67	B
2983	38	1	A
2984	38	2	A
2985	38	3	B
2986	38	4	A
2987	38	5	A
2988	38	6	C
2989	38	7	B
2990	38	8	A
2991	38	9	B
2992	38	10	A
2993	38	11	B
2994	38	12	B
2995	38	13	C
2996	38	14	A
2997	38	15	A
2999	38	16	A
3000	38	17	B
3001	38	18	C
3002	38	19	A
3003	38	20	C
3004	38	21	C
3006	38	22	B
3007	38	23	A
3008	38	24	A
3009	38	25	A
3010	38	26	C
3011	38	27	B
3012	38	28	A
3013	38	29	A
3014	38	30	C
3015	38	31	C
3016	38	32	A
3017	38	33	C
3018	38	34	C
3020	38	35	B
3021	38	36	B
3022	38	37	C
3023	38	38	A
3024	38	39	B
3032	38	44	A
3025	38	40	B
3028	38	41	A
3029	38	42	C
3033	38	45	C
3034	38	46	C
3035	38	47	B
3036	38	48	A
3037	38	49	A
3038	38	50	A
3039	38	51	A
3051	38	59	C
3040	38	52	A
3043	38	53	C
3044	38	54	A
3045	38	55	C
3046	38	56	A
3047	38	57	C
3050	38	58	A
3053	38	60	A
3055	38	61	A
3056	38	62	C
3057	38	63	C
3058	38	64	C
3060	38	65	C
3061	38	66	A
3062	38	67	B
3063	38	68	C
3064	38	69	C
3065	38	70	A
3066	38	71	B
3067	38	72	A
3068	38	73	A
3069	38	74	A
3070	38	75	A
3071	37	68	A
3072	38	76	C
3074	37	69	B
3075	38	77	A
3076	37	70	A
3077	37	71	C
3078	38	78	C
3079	37	72	A
3080	37	73	A
3083	37	74	B
3082	38	79	C
3085	37	75	A
3086	38	80	B
3087	38	81	A
3231	38	150	C
3090	38	82	A
3233	37	123	B
3088	37	76	B
3093	38	83	A
3094	38	84	B
3095	37	77	A
3096	38	85	B
3097	38	86	C
3098	38	87	C
3099	37	78	A
3100	38	88	A
3101	38	89	A
3102	38	90	B
3104	37	79	B
3105	37	80	B
3106	38	91	C
3107	38	92	A
3108	37	81	B
3109	38	93	B
3110	37	82	A
3234	38	151	A
3111	38	94	B
3115	38	95	A
3116	38	96	A
3117	37	83	B
3118	37	84	B
3119	37	85	C
3120	38	97	B
3121	37	86	C
3123	38	98	C
3236	38	152	A
3124	38	99	C
3127	37	87	C
3128	38	100	A
3129	37	88	B
3130	38	101	C
3131	37	89	A
3132	38	102	A
3133	38	103	C
3134	37	90	B
3135	38	104	A
3136	38	105	A
3137	37	91	B
3138	38	106	C
3139	37	92	A
3140	38	107	A
3141	37	93	A
3142	38	108	A
3143	37	94	C
3144	38	109	B
3146	38	110	A
3147	37	95	A
3148	38	111	C
3149	38	112	C
3150	37	96	A
3151	38	113	C
3152	38	114	A
3154	38	115	A
3155	38	116	A
3156	37	97	A
3235	37	124	A
3238	38	153	C
3158	38	117	C
3162	38	118	A
3164	38	119	A
3239	38	154	C
3262	38	167	B
3168	38	120	A
3163	37	98	C
3170	38	121	C
3171	37	99	C
3172	37	100	C
3173	38	122	B
3174	37	101	B
3175	38	123	A
3176	37	102	A
3177	38	124	A
3178	38	125	A
3179	37	103	B
3180	38	126	C
3181	37	104	A
3182	38	127	C
3183	38	128	C
3184	37	105	A
3185	37	106	C
3186	37	107	A
3187	38	129	C
3189	38	130	A
3188	37	108	B
3191	38	131	A
3193	38	132	B
3192	37	109	B
3196	37	110	C
3197	38	133	A
3198	37	111	B
3199	38	134	A
3200	37	112	C
3201	38	135	C
3202	37	113	C
3203	37	114	B
3205	38	136	C
3242	38	155	B
3204	37	115	A
3208	38	137	A
3209	37	116	A
3210	38	138	C
3211	38	139	C
3212	37	117	A
3213	38	140	A
3214	37	118	A
3215	38	141	B
3216	37	119	B
3217	38	142	A
3219	38	143	C
3218	37	120	B
3221	38	144	A
3222	38	145	C
3224	38	146	C
3223	37	121	B
3227	38	147	A
3228	38	148	C
3229	38	149	C
3230	37	122	B
3240	37	125	A
3245	38	156	A
3246	38	157	C
3247	38	158	A
3248	37	126	C
3250	38	159	A
3251	38	160	C
3252	37	127	C
3253	38	161	C
3254	38	162	C
3255	38	163	A
3256	38	164	A
3257	37	128	C
3259	38	165	A
3260	38	166	A
3261	37	129	B
3264	37	130	A
3270	38	169	C
3268	38	168	C
3269	37	131	B
3272	37	132	C
3336	37	159	A
3337	37	160	C
3338	37	161	C
3341	37	163	C
3342	37	164	A
3343	37	165	A
3344	37	166	B
3346	37	167	B
3347	37	168	A
3349	37	169	A
3350	37	170	C
5288	45	119	C
3351	37	171	A
3355	37	173	B
3512	40	134	A
3515	40	135	B
3516	40	136	C
3517	42	3	A
3518	40	137	A
3519	40	138	B
3520	42	4	A
3521	40	139	A
3522	42	5	B
3523	40	140	A
3524	40	141	A
3525	42	6	A
3526	40	142	A
3527	42	7	C
3528	40	143	C
3529	40	144	C
3530	42	8	A
3531	42	9	B
3532	42	10	A
3533	42	11	B
3534	42	12	B
3535	40	145	A
3536	42	13	A
3537	42	14	A
3538	42	15	A
3539	42	16	C
3540	42	17	C
3541	42	18	C
3542	42	19	A
3543	42	20	B
3544	42	21	A
3545	42	22	B
3546	42	23	B
3547	42	24	B
3548	42	25	A
3549	42	26	B
3550	42	27	A
3551	42	28	A
3552	42	29	A
3553	40	146	C
3554	42	30	C
3555	42	31	C
3556	42	32	A
3557	42	33	A
3558	42	34	C
3559	42	35	C
3560	42	36	A
3561	42	37	A
3562	42	38	B
3563	42	39	B
3564	42	40	B
3565	42	41	A
3566	42	42	A
3567	42	43	A
3568	42	44	B
3569	42	45	C
3570	42	46	C
3571	42	47	A
3572	42	48	A
3573	42	49	A
3574	42	50	A
3575	42	51	A
3576	42	52	B
3577	42	53	A
3578	42	54	A
3579	42	55	A
3580	42	56	A
3581	42	57	B
3582	42	58	C
3583	42	59	C
3584	42	60	B
3585	40	147	B
3586	42	61	A
3587	40	148	C
3588	42	62	B
3589	40	149	C
3590	42	63	C
3591	40	150	C
3592	40	151	B
3593	42	64	A
3594	42	65	C
3595	42	66	C
3596	42	67	A
3597	42	68	C
3598	42	69	A
3599	42	70	B
3600	42	71	B
3602	42	72	B
3603	42	73	A
3604	42	74	A
3605	42	75	A
3606	42	76	B
3607	42	77	A
3608	42	78	A
3609	42	79	A
3610	42	80	A
3611	42	81	A
3612	42	82	A
3613	42	83	C
3614	42	84	B
3615	42	85	B
3616	42	86	A
3617	42	87	B
3618	42	88	B
3619	42	89	A
3620	42	90	A
3621	42	91	C
3622	42	92	A
3623	42	93	A
3624	42	94	B
3625	42	95	A
3626	42	96	A
3627	42	97	B
3628	42	98	B
3629	42	99	A
3630	42	100	B
3631	42	101	A
3632	42	102	A
3633	40	152	A
3634	42	103	B
3635	42	104	A
3636	40	153	A
3637	42	105	A
3638	40	154	C
3639	40	155	B
3640	42	106	A
3641	42	107	C
3642	40	156	B
3643	42	108	A
3644	40	157	C
3645	40	158	B
3646	42	109	B
3648	40	159	B
3649	42	110	A
3650	40	160	C
3651	42	111	B
3652	40	161	C
3653	42	112	A
3654	42	113	B
3655	40	162	C
3656	42	114	A
3657	40	163	C
3658	42	115	B
3659	40	164	A
3661	40	165	B
3660	42	116	C
3663	42	117	A
3664	40	166	B
3665	42	118	A
3666	40	167	C
3667	42	119	A
3668	40	168	B
3669	42	120	A
3670	40	169	B
3671	42	121	A
3672	40	170	C
3673	42	122	B
3674	40	171	A
3675	40	172	B
3677	40	173	B
3678	42	123	A
3679	40	174	C
3680	42	124	B
3681	40	175	A
3682	42	125	A
3683	40	176	C
3684	42	126	C
3685	42	127	B
3686	40	177	C
3687	42	128	B
3688	40	178	A
3689	42	129	A
3690	40	179	A
3691	42	130	C
3692	40	180	B
3693	40	181	B
3694	40	182	A
3696	40	183	B
3697	40	184	C
3698	40	185	B
3699	40	186	A
3700	40	187	A
3701	42	131	A
3702	42	132	C
3703	42	133	A
3704	42	134	A
3705	42	135	B
3706	42	136	B
3708	42	137	A
3709	42	138	B
3710	42	139	C
3711	42	140	A
3712	42	141	C
3713	42	142	A
3714	42	143	A
3715	42	144	A
3716	42	145	A
3717	42	146	C
3718	42	147	B
3719	42	148	C
3720	42	149	C
3722	42	150	C
3723	42	151	B
3724	42	152	A
3725	42	153	C
3726	42	154	C
3727	42	155	B
3728	42	156	A
3729	42	157	C
3730	42	158	A
3731	42	159	A
3732	42	160	C
3733	42	161	C
3734	42	162	C
3735	42	163	A
3736	42	164	B
3737	42	165	B
3738	42	166	A
3739	42	167	B
3740	42	168	B
3741	42	169	A
3742	42	170	B
3743	42	171	C
3744	42	172	A
3745	42	173	B
3746	42	174	B
3747	42	175	A
3748	42	176	C
3749	42	177	B
3750	42	178	A
3751	42	179	A
3752	42	180	C
3753	42	181	A
3754	42	182	A
3755	42	183	B
3756	42	184	C
3757	42	185	B
3758	42	186	A
3759	42	187	A
3760	44	1	A
3761	44	2	A
3762	44	3	B
3763	44	4	B
3764	44	5	A
3765	44	6	C
3766	44	7	A
3767	44	8	C
3768	44	9	B
3769	44	10	C
3770	44	11	B
3771	44	12	B
3898	44	108	A
3772	44	13	A
3775	44	14	C
3776	44	15	A
3777	44	16	A
3778	44	17	C
3779	44	18	C
3780	44	19	A
3781	44	20	A
3872	44	88	C
3875	44	89	A
3782	44	21	A
3786	44	22	B
3787	44	23	C
3876	44	90	B
3789	44	24	B
3792	44	25	A
3793	44	26	C
3795	44	27	A
3796	44	28	C
3797	44	29	A
3798	44	30	C
3799	44	31	B
3800	44	32	A
3801	44	33	C
3802	44	34	A
3803	44	35	B
3804	44	36	A
3805	44	37	C
3806	44	38	C
3807	44	39	B
3808	44	40	C
3809	44	41	B
3877	44	91	C
3810	44	42	B
3813	44	43	C
3814	44	44	B
3815	44	45	C
3816	44	46	C
3817	44	47	B
3818	44	48	C
3819	44	49	A
3820	44	50	B
3822	44	51	B
3823	44	52	A
3824	44	53	B
3878	44	92	B
3879	44	93	A
3826	44	54	A
3830	44	55	B
3832	44	56	A
3833	44	57	B
3834	44	58	C
3835	44	59	B
3836	44	60	B
3837	44	61	A
3839	44	62	B
3840	44	63	C
3841	44	64	C
3843	44	65	B
3844	44	66	B
3845	44	67	A
3880	44	94	B
3846	44	68	A
3849	44	69	C
3850	44	70	A
3851	44	71	B
3852	44	72	C
3853	44	73	A
3854	44	74	C
3855	44	75	A
3856	44	76	C
3857	44	77	A
3858	44	78	A
3860	44	79	A
3861	44	80	A
3863	44	81	A
3865	44	82	C
3866	44	83	C
3868	44	84	C
3869	44	85	C
3870	44	86	C
3871	44	87	A
3881	44	95	A
3882	44	96	C
3884	44	97	B
3885	44	98	C
3887	44	99	C
3889	44	100	B
3890	44	101	A
3891	44	102	C
3892	44	103	B
3893	44	104	A
3895	44	105	A
3896	44	106	A
3897	44	107	C
3900	44	109	C
3901	44	110	A
3902	44	111	B
3903	44	112	C
3904	44	113	C
3905	44	114	C
3906	44	115	B
3907	44	116	A
3908	44	117	A
3910	44	118	A
3911	44	119	B
3913	44	120	A
3914	44	121	B
3915	44	122	A
3917	44	123	A
3918	44	124	A
3919	44	125	A
3920	44	126	C
3921	44	127	C
3922	44	128	C
3923	44	129	B
3925	44	130	A
3926	44	131	B
3927	44	132	C
3928	44	133	A
3929	44	134	A
3930	44	135	C
3932	44	136	C
3933	44	137	A
3934	44	138	B
3935	44	139	A
3936	44	140	A
3937	44	141	B
3938	44	142	A
3939	44	143	A
3940	44	144	A
3941	44	145	B
3942	44	146	C
3943	44	147	B
3944	44	148	B
3946	44	149	B
3947	44	150	C
3948	44	151	C
3949	44	152	A
3951	44	153	C
3952	44	154	C
3953	44	155	B
3954	44	156	A
4095	39	98	C
3955	44	157	A
3958	44	158	A
3959	44	159	B
3960	44	160	C
3961	44	161	B
3962	44	162	C
3963	44	163	A
3964	44	164	A
3966	44	165	C
3967	44	166	A
3968	44	167	B
3969	44	168	A
3970	44	169	B
3971	44	170	C
3973	44	171	A
3974	44	172	A
3975	44	173	B
3976	44	174	C
3977	44	175	B
3978	44	176	C
3979	44	177	A
3980	44	178	A
3981	44	179	B
3983	44	180	A
3984	44	181	C
3986	44	182	A
3987	44	183	B
3989	44	184	C
3990	44	185	A
3992	44	186	A
3993	44	187	A
3994	39	1	A
3995	39	2	A
3996	39	3	A
3997	39	4	A
3998	39	5	A
3999	39	6	C
4000	39	7	A
4002	39	8	C
4003	39	9	A
4004	39	10	A
4005	39	11	A
4006	39	12	C
4007	39	13	C
4008	39	14	C
4009	39	15	A
4010	39	16	C
4011	39	17	C
4012	39	18	C
4013	39	19	A
4014	39	20	A
4015	39	21	A
4016	39	22	B
4017	39	23	C
4018	39	24	C
4020	39	25	A
4021	39	26	C
4022	39	27	A
4023	39	28	C
4024	39	29	A
4025	39	30	C
4026	39	31	A
4027	39	32	A
4028	39	33	C
4029	39	34	A
4030	39	35	B
4031	39	36	C
4032	39	37	C
4033	39	38	C
4035	39	39	C
4036	39	40	C
4037	39	41	B
4038	39	42	A
4039	39	43	A
4040	39	44	A
4041	39	45	C
4042	39	46	C
4043	39	47	A
4044	39	48	A
4045	39	49	A
4046	39	50	C
4047	39	51	C
4049	39	52	A
4050	39	53	C
4051	39	54	A
4052	39	55	A
4053	39	56	A
4054	39	57	A
4055	39	58	C
4056	39	59	B
4057	39	60	B
4058	39	61	A
4059	39	62	A
4060	39	63	C
4061	39	64	C
4062	39	65	C
4063	39	66	A
4064	39	67	A
4065	39	68	C
4066	39	69	C
4067	39	70	A
4068	39	71	A
4069	39	72	C
4070	39	73	C
4071	39	74	C
4072	39	75	A
4073	39	76	C
4074	39	77	A
4075	39	78	B
4076	39	79	A
4077	39	80	A
4078	39	81	A
4079	39	82	C
4080	39	83	A
4081	39	84	C
4082	39	85	C
4083	39	86	A
4084	39	87	A
4085	39	88	A
4086	39	89	A
4087	39	90	C
4088	39	91	C
4089	39	92	A
4090	39	93	A
4091	39	94	C
4092	39	95	A
4093	39	96	A
4094	39	97	C
4097	39	99	C
4098	39	100	A
4099	39	101	C
4100	39	102	A
4101	39	103	A
4102	39	104	A
4103	39	105	C
4104	39	106	A
4105	39	107	A
4106	39	108	A
4107	39	109	C
4110	39	110	C
4111	39	111	C
4112	39	112	C
4113	39	113	C
4114	39	114	C
4115	39	115	C
4116	39	116	A
4117	39	117	A
4118	39	118	A
4119	39	119	C
4120	39	120	A
4121	39	121	C
4122	39	122	C
4123	39	123	A
4124	39	124	A
4125	39	125	A
4126	39	126	C
4127	39	127	A
4128	39	128	C
4129	39	129	C
4130	39	130	A
4131	39	131	C
4132	39	132	C
4133	39	133	A
4134	39	134	A
4135	39	135	B
4136	39	136	C
4137	39	137	A
4138	39	138	C
4139	39	139	A
4140	39	140	A
4141	39	141	A
4142	39	142	A
4143	39	143	C
4144	39	144	C
4145	39	145	A
4146	39	146	C
4147	39	147	C
4148	39	148	C
4149	39	149	A
4151	39	150	C
4152	39	151	C
4153	39	152	A
4154	39	153	C
4155	39	154	C
4156	39	155	C
4157	39	156	A
4158	39	157	C
4159	39	158	A
4160	39	159	A
4161	39	160	C
4162	39	161	C
4163	39	162	C
4164	39	163	C
4165	39	164	A
4166	39	165	A
4167	39	166	A
4168	39	167	A
4169	39	168	C
4170	39	169	A
4171	39	170	C
4172	39	171	C
4173	39	172	A
4174	39	173	B
4175	39	174	C
4176	39	175	A
4177	39	176	C
4178	39	177	C
4179	39	178	A
4180	39	179	A
4181	39	180	A
4182	39	181	A
4183	39	182	A
4184	39	183	A
4185	39	184	A
4186	39	185	C
4187	39	186	C
4189	39	187	A
4190	53	1	A
4191	53	2	A
4192	53	3	B
4194	53	4	A
4195	53	5	A
4196	53	6	C
4198	53	7	A
4199	53	8	C
4200	53	9	A
4291	53	65	C
4293	53	66	A
4201	53	10	B
4205	53	11	A
4206	53	12	B
4207	53	13	C
4208	53	14	C
4209	53	15	A
4210	53	16	A
4294	53	67	A
4211	53	17	B
4214	53	18	C
4215	53	19	A
4216	53	20	A
4295	53	68	A
4296	53	69	A
4217	53	21	A
4221	53	22	C
4222	53	23	C
4223	53	24	A
4225	53	25	A
4226	53	26	C
4227	53	27	C
4229	53	28	B
4230	53	29	A
4231	53	30	C
4232	53	31	A
4233	53	32	A
4234	53	33	B
4235	53	34	C
4297	53	70	A
4236	53	35	C
4239	53	36	C
4240	53	37	C
4298	53	71	A
4299	53	72	A
4300	53	73	C
4301	53	74	C
4241	53	38	C
4247	53	39	C
4248	53	40	B
4249	53	41	B
4302	53	75	B
4250	53	42	B
4253	53	43	A
4303	53	76	C
4304	53	77	A
4305	53	78	A
4255	53	44	A
4260	53	45	C
4261	53	46	C
4262	53	47	A
4263	53	48	C
4264	53	49	A
4265	53	50	C
4266	53	51	A
4267	53	52	A
4268	53	53	C
4306	53	79	C
4308	53	80	A
4309	53	81	C
4310	53	82	A
4311	53	83	A
4312	53	84	C
4270	53	54	A
4279	53	55	C
4280	53	56	A
4281	53	57	A
4282	53	58	C
4283	53	59	B
4284	53	60	C
4285	53	61	A
4286	53	62	A
4287	53	63	C
4289	53	64	A
4313	53	85	C
4314	53	86	A
4315	53	87	C
4316	53	88	C
4317	53	89	A
4318	53	90	C
4319	53	91	A
4320	53	92	A
4321	53	93	A
4322	53	94	A
4324	53	95	A
4325	53	96	A
4327	53	97	B
4328	53	98	C
4342	53	110	C
4329	53	99	B
4332	53	100	A
4333	53	101	A
4334	53	102	A
4335	53	103	C
4336	53	104	A
4337	53	105	A
4338	53	106	A
4339	53	107	A
4340	53	108	C
4341	53	109	C
4344	53	111	B
4345	53	112	C
4346	53	113	C
4347	53	114	A
4348	53	115	C
4349	53	116	A
4350	53	117	C
4351	53	118	A
4352	53	119	C
4356	53	120	A
4357	53	121	C
4358	53	122	A
4359	53	123	A
4360	53	124	A
4362	53	125	A
4363	53	126	C
4364	53	127	C
4365	53	128	C
4366	53	129	A
4367	53	130	A
4369	53	131	C
4370	53	132	C
4371	53	133	A
4372	53	134	C
4374	53	135	C
4375	53	136	C
4376	53	137	A
4523	52	65	C
4377	53	138	C
4380	53	139	A
4382	53	140	A
4525	52	66	C
4526	52	67	A
4383	53	141	B
4387	53	142	A
4388	53	143	C
4389	53	144	A
4390	53	145	A
4392	53	146	C
4527	52	68	A
4528	52	69	C
4529	52	70	A
4530	52	71	A
4393	53	147	B
4399	53	148	C
4400	53	149	C
4401	53	150	C
4402	53	151	C
4403	53	152	A
4404	53	153	A
4405	53	154	C
4406	53	155	C
4407	53	156	A
4408	53	157	C
4409	53	158	A
4410	53	159	A
4411	53	160	C
4412	53	161	C
4531	52	72	A
4413	53	162	C
4416	53	163	A
4532	52	73	C
4417	53	164	A
4420	53	165	A
4533	52	74	A
4422	53	166	A
4425	53	167	A
4426	53	168	A
4427	53	169	C
4429	53	170	C
4430	53	171	A
4431	53	172	A
4432	53	173	A
4434	53	174	C
4435	53	175	A
4436	53	176	A
4438	53	177	B
4440	53	178	A
4441	53	179	A
4442	53	180	C
4443	53	181	C
4444	53	182	A
4445	53	183	C
4446	53	184	B
4448	53	185	A
4449	53	186	A
4450	53	187	A
4451	52	1	A
4452	52	2	A
4453	52	3	B
4455	52	4	A
4456	52	5	A
4457	52	6	C
4458	52	7	A
4459	52	8	C
4460	52	9	A
4461	52	10	C
4462	52	11	A
4463	52	12	A
4464	52	13	C
4465	52	14	A
4466	52	15	C
4467	52	16	A
4468	52	17	C
4469	52	18	C
4470	52	19	A
4471	52	20	A
4472	52	21	A
4474	52	22	C
4475	52	23	C
4476	52	24	C
4477	52	25	A
4478	52	26	C
4479	52	27	A
4480	52	28	C
4482	52	29	A
4484	52	30	C
4485	52	31	C
4486	52	32	A
4487	52	33	C
4488	52	34	A
4489	52	35	B
4490	52	36	A
4491	52	37	A
4493	52	38	C
4494	52	39	B
4495	52	40	C
4496	52	41	B
4497	52	42	C
4499	52	43	A
4500	52	44	A
4501	52	45	C
4502	52	46	C
4503	52	47	A
4504	52	48	A
4505	52	49	A
4506	52	50	B
4507	52	51	A
4508	52	52	A
4509	52	53	C
4510	52	54	C
4511	52	55	C
4512	52	56	C
4513	52	57	C
4515	52	58	C
4516	52	59	B
4517	52	60	C
4519	52	61	A
4520	52	62	C
4521	52	63	C
4522	52	64	A
4534	52	75	C
4535	52	76	B
4536	52	77	A
4560	52	97	B
4537	52	78	A
4541	52	79	B
4542	52	80	C
4543	52	81	A
4544	52	82	A
4545	52	83	C
4546	52	84	C
4547	52	85	C
4549	52	86	A
4550	52	87	C
4551	52	88	C
4552	52	89	A
4553	52	90	C
4554	52	91	C
4555	52	92	A
4556	52	93	C
4557	52	94	B
4558	52	95	C
4559	52	96	A
4562	52	98	C
4564	52	99	B
4565	52	100	A
4566	52	101	A
4567	52	102	A
4568	52	103	C
4569	52	104	A
4570	52	105	A
4572	52	106	A
4573	52	107	A
4574	52	108	A
4575	52	109	C
4576	52	110	B
4577	52	111	C
4578	52	112	C
4579	52	113	C
5289	50	64	C
4580	52	114	C
4581	52	115	A
4746	54	80	B
4582	52	116	C
4585	52	117	A
4586	52	118	A
4587	52	119	C
4588	52	120	A
4589	52	121	A
4590	52	122	C
4591	52	123	A
4592	52	124	A
4593	52	125	A
4594	52	126	C
4595	52	127	C
4596	52	128	C
4598	52	129	A
4599	52	130	A
4600	52	131	C
4601	52	132	C
4602	52	133	A
4603	52	134	C
4604	52	135	B
4605	52	136	C
4606	52	137	A
4607	52	138	C
4748	54	81	C
4608	52	139	C
4611	52	140	A
4613	52	141	C
4614	52	142	A
4615	52	143	A
4616	52	144	C
4617	52	145	A
4619	52	146	C
4620	52	147	C
4621	52	148	C
4622	52	149	C
4623	52	150	C
4624	52	151	C
4625	52	152	A
4626	52	153	A
4627	52	154	C
4628	52	155	C
4629	52	156	A
4630	52	157	C
4631	52	158	A
4632	52	159	A
4633	52	160	C
4634	52	161	C
4635	52	162	C
4636	52	163	A
4637	52	164	A
4638	52	165	A
4639	52	166	A
4640	52	167	A
4641	52	168	A
4642	52	169	C
4643	52	170	C
4644	52	171	C
4646	52	172	A
4647	52	173	B
4648	52	174	C
4649	52	175	A
4650	52	176	C
4651	52	177	A
4652	52	178	A
4653	52	179	C
4654	52	180	A
4656	52	181	C
4657	52	182	C
4658	52	183	A
4659	52	184	C
4660	52	185	A
4661	52	186	A
4662	52	187	A
4663	54	1	A
4664	54	2	A
4665	54	3	C
4666	54	4	A
4667	54	5	B
4668	54	6	A
4669	54	7	B
4670	54	8	A
4671	54	9	A
4672	54	10	A
4673	54	11	A
4674	54	12	C
4675	54	13	A
4676	54	14	C
4677	54	15	A
4678	54	16	C
4679	54	17	C
4680	54	18	C
4681	54	19	A
4682	54	20	C
4683	54	21	A
4684	54	22	B
4685	54	23	C
4686	54	24	C
4687	54	25	B
4688	54	26	C
4689	54	27	A
4690	54	28	C
4691	54	29	A
4692	54	30	C
4693	54	31	B
4694	54	32	A
4695	54	33	C
4697	54	34	A
4698	54	36	C
4699	54	35	B
4700	54	37	C
4702	54	38	C
4703	54	39	B
4749	54	82	C
4750	54	83	C
4704	54	40	C
4708	54	41	C
4710	54	42	C
4711	54	43	B
4712	54	44	C
4713	54	45	C
4714	54	46	C
4715	54	47	A
4716	54	48	C
4717	54	49	A
4718	54	50	C
4720	54	51	A
4721	54	52	A
4723	54	53	C
4725	54	63	C
4726	54	64	C
4727	54	65	C
4730	54	68	A
4731	54	69	A
4732	54	70	A
4734	54	72	A
4735	54	73	A
4737	54	74	C
4738	54	75	A
4739	54	76	C
4740	54	77	A
4741	54	78	A
4751	54	84	C
4742	54	79	A
4753	54	85	B
4754	54	86	A
4755	54	87	C
4756	54	88	C
4757	54	89	A
4758	54	90	C
4759	54	91	B
4761	54	92	B
4762	54	93	A
4763	54	94	B
4765	54	95	B
4767	54	96	A
4768	54	97	B
4769	54	98	C
4770	54	99	C
4771	54	100	C
4772	54	101	B
4773	54	102	A
4775	54	103	C
4776	54	104	A
4777	54	105	C
4778	54	106	A
4779	54	107	C
4780	54	108	C
4781	54	109	C
4782	54	110	B
4784	54	111	C
4785	54	112	C
4786	54	113	C
4787	54	114	C
4788	54	115	A
4789	54	116	A
4790	54	117	B
4728	54	66	C
4729	54	67	A
4733	54	71	A
4792	54	118	A
4793	54	119	C
4794	54	120	A
4795	54	121	C
4796	54	122	C
4797	54	123	A
4798	54	124	A
4799	54	125	B
4800	54	126	C
4801	54	127	C
4802	54	128	C
4803	54	129	B
4804	54	130	A
4805	54	131	C
4806	54	132	C
4807	54	133	A
4808	54	134	C
4809	54	135	C
4810	54	136	C
4811	54	137	A
4812	54	138	C
4813	54	139	B
4814	54	140	A
4815	54	141	A
4816	54	142	A
4817	54	143	C
4819	54	144	C
4820	54	145	A
4822	54	146	C
4824	54	147	C
4825	54	148	C
4826	54	149	C
4827	54	150	C
4828	54	151	C
4829	54	152	C
4830	54	153	A
4831	54	154	C
4832	54	155	C
4833	54	156	A
4834	54	157	C
4835	54	158	A
4836	54	159	C
4837	54	160	C
4838	54	161	C
4839	54	162	C
4840	54	163	A
4841	54	164	A
4842	54	165	A
4844	54	166	A
4845	54	167	A
4846	54	168	A
4848	54	169	A
4849	54	170	C
4850	54	171	C
4851	54	172	A
4852	54	173	B
4853	54	174	C
4855	54	175	A
4856	54	176	C
4857	54	177	A
4858	54	178	A
4859	54	179	C
4860	54	180	C
4861	54	181	A
4862	54	182	A
4863	54	183	C
4864	54	184	A
4865	54	185	A
4866	54	186	A
4867	54	187	C
4869	54	54	A
4870	54	55	C
4871	54	56	A
4872	54	57	C
4873	54	58	A
4874	54	59	B
4876	54	60	C
4877	54	61	A
4878	54	62	C
4882	46	1	A
4883	46	2	A
4884	46	3	B
4885	46	4	A
4886	46	5	A
4887	46	6	C
4888	46	7	C
4889	46	8	C
4890	46	9	A
4891	46	10	C
4892	46	11	A
4893	46	12	C
4894	46	13	C
4895	46	14	C
4896	46	15	A
4897	46	16	A
4898	46	17	C
4899	46	18	C
4900	46	19	A
4901	46	20	A
4902	46	21	C
4903	46	22	B
4904	46	23	C
4905	46	24	A
4906	46	25	A
4907	46	26	B
4909	46	27	A
4910	46	28	C
4911	46	29	A
4912	46	30	C
4913	46	31	A
4914	46	32	A
4915	46	33	C
4916	46	34	A
4917	46	35	B
4918	46	36	A
4919	46	37	A
4920	46	38	C
4921	46	39	C
4922	46	40	C
4923	46	41	C
4924	46	42	C
4925	46	43	C
4926	46	44	C
4927	46	45	C
4928	46	46	C
4929	46	47	A
4930	46	48	C
4931	46	49	A
4932	46	50	A
4933	46	51	A
4935	46	52	A
4936	46	53	C
4937	46	54	C
4938	46	55	C
4940	46	56	A
4941	46	57	C
4942	46	58	C
4943	46	59	B
4944	46	60	A
4945	46	61	A
4946	46	62	C
4947	46	63	C
4948	46	64	C
4949	46	65	C
4950	46	66	C
4951	46	67	C
4952	46	68	A
4953	46	69	A
4954	46	70	A
4955	46	71	A
4956	46	72	C
4958	46	73	A
4959	46	74	A
4960	46	75	A
4961	46	76	C
4962	46	77	A
4963	46	78	B
4964	46	79	A
4965	46	80	A
4966	46	81	A
4968	46	82	C
4969	46	83	C
4970	46	84	C
4971	46	85	C
4972	46	86	C
4973	46	87	C
4974	46	88	C
4975	46	89	A
4976	46	90	C
4977	46	91	C
4978	46	92	A
4979	46	93	A
4980	45	1	A
4981	45	2	A
4982	46	94	C
4983	45	3	B
4984	45	4	B
4985	46	95	A
4986	45	5	A
4987	45	6	C
4988	45	7	C
4989	50	1	A
4990	50	2	A
4991	45	8	B
4992	50	3	B
4993	45	9	B
4994	45	10	B
4996	46	96	C
4997	45	11	B
5159	50	44	C
4995	50	4	A
5000	45	12	C
5001	50	5	A
5002	45	13	A
5003	46	97	B
5004	50	6	B
5005	45	14	A
5006	46	98	C
5007	50	7	A
5008	45	15	A
5009	45	16	B
5011	50	8	C
5012	45	17	C
5013	50	9	A
5014	45	18	C
5015	45	19	B
5016	45	20	B
5017	50	10	A
5018	45	21	B
5019	46	99	C
5020	50	11	A
5021	45	22	C
5022	46	100	C
5023	50	12	A
5024	45	23	B
5025	46	101	A
5026	46	102	A
5027	50	13	C
5028	45	24	B
5029	46	103	C
5030	45	25	B
5032	46	104	A
5033	45	26	B
5034	50	14	C
5035	46	105	A
5036	45	27	A
5037	50	15	A
5039	46	106	C
5038	45	28	B
5042	46	107	A
5043	45	29	C
5041	50	16	C
5045	46	108	A
5046	46	109	C
5047	50	17	C
5048	45	30	C
5049	45	31	B
5050	50	18	C
5051	45	32	A
5053	45	33	C
5054	50	19	A
5052	46	110	A
5056	50	20	A
5057	45	34	B
5058	45	35	C
5059	46	111	C
5060	50	21	A
5061	45	36	C
5062	46	112	C
5063	46	113	C
5064	45	37	B
5066	45	38	C
5067	45	39	B
5065	46	114	A
5070	46	115	A
5069	50	22	B
5072	50	23	C
5073	46	116	A
5074	50	24	A
5075	46	117	A
5076	50	25	A
5077	45	40	B
5078	46	118	A
5079	45	41	B
5080	46	119	C
5081	45	42	A
5082	50	26	C
5083	50	27	A
5084	46	120	A
5085	50	28	C
5086	46	121	C
5087	50	29	A
5088	46	122	C
5089	46	123	A
5090	50	30	C
5091	45	43	B
5093	46	124	C
5092	45	44	B
5095	50	31	C
5096	45	45	C
5097	46	125	A
5098	45	46	C
5099	50	32	C
5100	46	126	C
5101	45	47	C
5102	50	33	C
5103	45	48	B
5162	45	65	C
5106	50	34	A
5104	45	49	A
5108	45	50	B
5109	46	127	C
5110	45	51	A
5112	45	52	A
5111	50	35	C
5114	45	53	C
5115	50	36	C
5116	46	128	C
5117	50	37	C
5118	45	54	B
5119	45	55	A
5120	45	56	C
5122	50	38	B
5123	46	129	A
5124	45	57	A
5126	45	58	B
5127	46	130	A
5125	50	39	C
5129	46	131	A
5130	46	132	C
5131	46	133	A
5132	46	134	C
5133	46	135	C
5135	50	40	B
5136	46	136	C
5137	46	137	A
5138	46	138	A
5140	45	59	B
5163	45	66	B
5142	46	139	A
5143	46	140	C
5144	46	141	C
5145	45	60	A
5146	46	142	A
5147	46	143	C
5148	45	61	A
5149	46	144	A
5151	46	145	C
5152	45	62	B
5153	46	146	C
5139	50	41	B
5155	50	42	C
5156	45	63	B
5157	50	43	A
5158	45	64	C
5160	46	147	C
5164	50	45	C
5165	46	148	C
5166	46	149	A
5167	45	67	C
5191	45	78	A
5168	45	68	A
5171	45	69	B
5173	45	70	A
5174	45	71	A
5175	45	72	B
5176	46	150	A
5177	46	151	C
5178	45	73	A
5179	46	152	A
5180	45	74	B
5181	46	153	A
5182	46	154	C
5183	45	75	B
5184	46	155	C
5185	45	76	C
5186	46	156	A
5187	45	77	B
5188	46	157	C
5189	46	158	A
5190	46	159	A
5193	46	160	C
5194	45	79	B
5195	50	46	C
5196	45	80	C
5290	45	120	A
5197	46	161	A
5198	45	81	A
5199	45	82	C
5200	50	47	B
5201	46	162	C
5202	45	83	A
5203	50	48	C
5204	45	84	B
5205	46	163	A
5206	50	49	A
5207	45	85	B
5208	50	50	C
5209	46	164	A
5210	45	86	B
5211	45	87	C
5212	45	88	B
5214	45	89	B
5216	45	90	B
5218	45	91	C
5219	46	165	C
5220	50	51	A
5221	45	92	A
5222	46	166	A
5223	50	52	A
5224	45	93	A
5291	45	121	C
5225	45	94	C
5228	46	167	A
5229	45	95	B
5230	46	168	C
5231	45	96	B
5232	46	169	B
5233	46	170	C
5235	50	53	C
5234	45	97	B
5237	46	171	A
5238	46	172	A
5239	45	98	B
5240	45	99	C
5241	46	173	B
5242	46	174	C
5243	46	175	A
5245	50	54	C
5246	46	176	A
5244	45	100	A
5248	50	55	A
5249	45	101	C
5251	45	102	A
5250	46	177	A
5253	45	103	B
5254	50	56	A
5255	46	178	A
5256	45	104	B
5257	45	105	B
5258	50	57	B
5259	50	58	C
5260	45	106	A
5261	46	179	A
5262	45	107	A
5263	45	108	A
5264	46	180	A
5265	45	109	C
5266	46	181	C
5267	46	182	A
5268	46	183	C
5269	45	110	B
5270	45	111	C
5271	45	112	C
5272	46	184	C
5273	45	113	C
5274	50	59	B
5275	45	114	C
5276	46	185	A
5277	45	115	A
5278	45	116	A
5279	50	60	C
5280	50	61	A
5281	46	186	A
5283	45	117	A
5284	46	187	A
5282	50	62	C
5286	45	118	A
5287	50	63	C
5292	50	65	C
5293	50	66	C
5294	50	67	C
5295	45	122	C
5297	45	123	B
5298	50	68	A
5299	45	124	B
5300	45	125	A
5301	45	126	B
5302	45	127	C
5303	45	128	C
5304	50	69	C
5305	45	129	C
5306	45	130	B
5307	45	131	B
5309	50	70	A
5310	45	132	C
5311	45	133	A
5312	45	134	B
5313	50	71	C
5314	45	135	C
5316	50	72	A
5317	45	136	C
5318	50	73	A
5319	50	74	C
5320	45	137	A
5321	50	75	A
5322	45	138	C
5324	45	139	A
5325	45	140	A
5323	50	76	C
5327	45	141	C
5328	50	77	A
5375	45	166	A
5329	45	142	C
5333	45	143	C
5334	45	144	C
5335	45	145	B
5336	45	146	B
5338	45	147	C
5339	45	148	C
5377	50	89	C
5341	45	149	B
5342	45	150	C
5343	45	151	C
5332	50	78	C
5345	45	152	C
5347	45	153	B
5348	50	79	A
5349	50	80	A
5350	45	154	C
5351	50	81	A
5352	45	155	C
5353	50	82	C
5354	45	156	A
5355	50	83	A
5356	45	157	C
5357	45	158	A
5358	50	84	C
5359	50	85	C
5360	45	159	A
5361	45	160	C
5378	45	167	A
5364	45	161	C
5362	50	86	C
5379	50	90	C
5366	45	162	A
5369	50	87	C
5370	45	163	C
5371	45	164	B
5373	50	88	A
5374	45	165	B
5380	50	91	C
5381	50	92	A
5382	45	168	A
5383	50	93	A
5385	45	169	A
5384	50	94	B
5387	50	95	A
5388	45	170	C
5389	50	96	C
5390	50	97	B
5391	45	171	A
5393	50	98	C
5392	45	172	B
5395	45	173	B
5396	45	174	C
5397	50	99	B
5398	50	100	A
5399	50	101	C
5400	45	175	A
5401	50	102	A
5402	45	176	B
5403	45	177	C
5404	50	103	C
5405	45	178	A
5406	50	104	A
5407	50	105	A
5408	45	179	A
5409	45	180	C
5410	45	181	C
5412	50	106	A
5413	45	182	C
5415	45	183	C
5414	50	107	A
5417	45	184	B
5419	50	108	A
5420	50	109	C
5421	45	185	B
5423	45	186	A
5424	50	110	A
5425	45	187	A
5426	50	111	C
5427	50	112	C
5428	50	113	C
5429	50	114	C
5431	50	115	A
5432	50	116	A
5433	50	117	C
5434	50	118	A
5435	50	119	C
5436	50	120	A
5437	50	121	C
5438	50	122	C
5439	50	123	A
5440	50	124	C
5441	50	125	A
5442	50	126	C
5443	50	127	C
5444	50	128	C
5445	50	129	A
5446	50	130	A
5447	50	131	C
5448	50	132	C
5449	50	133	B
5451	50	134	A
5452	50	135	C
5454	50	136	C
5455	50	137	A
5456	50	138	C
5457	50	139	C
5458	50	140	A
5459	50	141	C
5460	50	142	A
5461	50	143	C
5462	50	144	C
5463	50	145	A
5465	50	146	C
5466	50	147	C
5467	50	148	C
5468	50	149	A
5469	50	150	C
5470	50	151	B
5471	50	152	A
5472	50	153	C
5473	50	154	B
5474	50	155	C
5476	50	156	A
5477	50	157	C
5478	50	158	A
5479	50	159	A
5480	50	160	C
5481	50	161	C
5482	50	162	C
5483	50	163	C
5484	50	164	A
5485	50	165	A
5486	50	166	A
5487	50	167	C
5488	50	168	C
5490	50	169	A
5491	50	170	C
5492	50	171	A
5493	50	172	A
5494	50	173	B
5495	50	174	C
5496	50	175	A
5497	50	176	C
5499	50	177	C
5500	50	178	A
5501	50	179	A
5502	50	180	A
5503	50	181	C
5504	50	182	B
5505	50	183	C
5506	50	184	A
5507	50	185	B
5508	50	186	C
5509	50	187	A
5510	49	1	A
5511	49	2	A
5512	49	3	B
5513	49	4	B
5515	49	5	C
5516	49	6	C
5517	49	7	C
5518	49	8	C
5519	49	9	A
5520	49	10	A
5521	49	11	A
5522	49	12	A
5608	49	79	A
5523	49	13	A
5526	49	14	A
5527	49	15	A
5528	49	16	C
5529	49	17	C
5530	49	18	C
5532	49	19	C
5533	49	20	C
5534	49	21	C
5575	49	53	C
5578	49	54	A
5579	49	55	A
5535	49	22	B
5540	49	23	C
5541	49	24	A
5542	49	25	A
5543	49	26	B
5580	49	56	A
5544	49	27	A
5547	49	28	A
5548	49	29	A
5549	49	30	C
5550	49	31	B
5551	49	32	A
5552	49	33	A
5553	49	34	C
5554	49	35	C
5555	49	36	A
5556	49	37	C
5557	49	38	A
5558	49	39	B
5560	49	40	C
5561	49	41	C
5562	49	42	A
5563	49	43	A
5564	49	44	B
5565	49	45	C
5566	49	46	C
5567	49	47	A
5569	49	48	A
5570	49	49	A
5571	49	50	C
5572	49	51	C
5574	49	52	A
5581	49	57	A
5582	49	58	A
5583	49	59	B
5584	49	60	B
5585	49	61	A
5587	49	62	B
5588	49	63	C
5590	49	64	C
5612	49	80	A
5591	49	65	C
5595	49	66	C
5596	49	67	C
5597	49	68	C
5598	49	69	C
5599	49	70	A
5600	49	71	C
5601	49	72	A
5602	49	73	A
5603	49	74	C
5604	49	75	A
5605	49	76	B
5606	49	77	A
5607	49	78	B
5614	49	81	A
5622	49	85	C
5615	49	82	A
5620	49	83	A
5621	49	84	C
5624	49	86	A
5625	49	87	A
5626	49	88	C
5627	49	89	C
5628	49	90	C
5629	49	91	C
5630	49	92	A
5631	49	93	A
5632	49	94	B
5634	49	95	C
5639	49	96	C
5640	49	97	B
5641	49	98	C
5642	49	99	B
5643	49	100	A
5644	49	101	A
5645	49	102	A
\.


--
-- Data for Name: resultados_16pf; Type: TABLE DATA; Schema: pruebas16pf; Owner: ats_n8n
--

COPY pruebas16pf.resultados_16pf (id, aspirante_id, factor, puntaje_total, decatipo, porcentaje, nivel, interpretacion, descripcion_factor) FROM stdin;
1553	14	A	16	8	0.80	Alto	Persona afectuosa, participativa y colaboradora . Prefiere trabajar en grupos.	Reservado / Abierto
1554	14	B	5	4	0.40	Medio	Es una persona de juicio intelectual intermedio, no tiene niveles altos en manejar relaciones en termino de como se sitúan las cosas,  sin embargo tampoco es bajo.	Concreto / Abstracto
1555	14	C	14	3	0.30	Bajo	Demasiado afectada por los sentimientos cuando se frustra, inestable emocionalmente. Tiende a evadir responsabilidades.	Inestabilidad Emocional / Estabilidad emocional
1556	14	E	12	6	0.60	Medio	Persona que presenta niveles equilibrados entre ser sumisa y dominante.	Sumiso / Dominante
1557	14	F	13	5	0.50	Medio	Es una persona con un nivel intermedio entre ser prudente y ser impulsiva.	Prudente / Impulsivo
1558	14	G	17	6	0.60	Medio	Presenta un nivel intermedio en su nivel de responsabilidad y en aceptar las normas sociales.	Despreocupado / Escrupuloso
1559	14	H	15	5	0.50	Medio	Es una persona con disposición a ser sociable y espontánea. Dispuesta en algunas ocasiones a ser atrevida e intentar nuevas cosas.	Tímido / Espontáneo
1560	14	I	11	4	0.40	Medio	La persona actúa como igual facilidad entre las respuestas de pensamiento y sentimiento.	Racional / Emocional
1561	14	L	8	5	0.50	Medio	Presenta un nivel intermedio de confianza en las persona y en las situaciones.	Confiado / Suspicaz
1562	14	M	13	5	0.50	Medio	Persona que esta guiada por realidades objetivas o en ocasiones puede ser imaginativa y abstraerse en su pensamientos.	Práctico / Soñador
1563	14	N	13	7	0.70	Alto	Es sumamente astuta, exacta y calculadora. Diplomática , calculadora,  se desenvuelve bien en grupo. Ambisiosa y perspicaz.	Sencillo / Astuto
1564	14	O	10	7	0.70	Alto	Es una persona insegura, intranquila, preocupada y deprimida. Se culpa por sus acciones erradas. Se afecta con facilidad, es muy sensible a la aprobación de los demás.	Seguro / Inseguro
1565	14	Q1	3	1	0.10	Bajo	Es conservadora, respetuosa de las ideas establecidas, tolerante de los defectos tradicionales. Es precavida y resistente a las nuevas ideas, postone los cambios, sigue la línea tradicional es convencionalista.	Tradicionalista / Innovador
1566	14	Q2	8	5	0.50	Medio	Tiende a ser autosuficiente e ingeniosa, llena de recursos, prefiere sus propias decisiones. Usualmente busca resolver los problemas por sí misma.	Dependencia del grupo / Autosuficiencia
1567	14	Q3	14	5	0.50	Medio	Tiene un nivel intermedio entre el autocontrol y la congruencia entre su autoconcepto percibido y deseados, de acuerdo con su cultura.	Desinhibido / Controlado
1568	14	Q4	16	9	0.90	Alto	Es una persona con características de estar tensa, excitable e intranquila. Puede presentar bloqueos de ansiedad.	Tranquilo / Tensionado
1665	24	A	18	8	0.80	Alto	Persona afectuosa, participativa y colaboradora . Prefiere trabajar en grupos.	Reservado / Abierto
1666	24	B	3	4	0.40	Medio	Es una persona de juicio intelectual intermedio, no tiene niveles altos en manejar relaciones en termino de como se sitúan las cosas,  sin embargo tampoco es bajo.	Concreto / Abstracto
1667	24	C	24	7	0.70	Alto	Es una persona emocionalmente estable, madura y realista.  No deja que sus necesidades emocionales afecten la realidad de las situaciones.	Inestabilidad Emocional / Estabilidad emocional
1668	24	E	6	2	0.20	Bajo	La persona es sumisa, cede fácilmente ante los demás, es dócil y conformista. Es modesta, humilde y obediente.	Sumiso / Dominante
1669	24	F	12	5	0.50	Medio	Es una persona con un nivel intermedio entre ser prudente y ser impulsiva.	Prudente / Impulsivo
1670	24	G	12	3	0.30	Bajo	La persona suele ser inestable en sus propósitos. Demuestra alta despreocupación y muy poca consideración por las normas de la sociedad.	Despreocupado / Escrupuloso
1671	24	H	21	7	0.70	Alto	Suele ser tímida, muy retraída. Se muestra cohibida y con falta de confianza en si misma. Puede presentar sentimientos de inferioridad. Se retrae fácilmente ante el sexo apuesto.	Tímido / Espontáneo
1672	24	I	12	6	0.60	Medio	La persona actúa como igual facilidad entre las respuestas de pensamiento y sentimiento.	Racional / Emocional
1673	24	L	4	3	0.30	Bajo	Es una persona confiada, comprensiva, permisiva y tolerante. Cede ante los cambios, no parece preocupada por corregir a los demás. Se sobrepone con facilidad a las dificultades.	Confiado / Suspicaz
1674	24	M	14	7	0.70	Alto	Persona muy imaginativa, se abstrae mucho en sus pensamientos. Se entusiasma rápidamente, cambia y abandona las ideas bruscamente.	Práctico / Soñador
1675	24	N	9	4	0.40	Medio	Puede ser sencilla e ingenua socialmente o calculadora en ocasiones.	Sencillo / Astuto
1676	24	O	7	6	0.60	Medio	Es una persona que puede mostrarse segura, tranquila, flexible y serena. Tiende a no culparse por sus acciones erradas, trata de actuar libremente sin temores, aunque en algunas ocasiones puede mostrar lo contrario.	Seguro / Inseguro
1677	24	Q1	9	5	0.50	Medio	Tiende a presentar interés por las nuevas ideas. Por lo general tiene actitudes de innovación y reacción ante lo establecido. Es poco convencionalista.	Tradicionalista / Innovador
1678	24	Q2	10	7	0.70	Alto	Es autosuficiente, ingeniosa y llena de recursos, prefiere las propias decisiones. Busca resolver problemas por sí misma.	Dependencia del grupo / Autosuficiencia
1679	24	Q3	17	6	0.60	Medio	Tiene un nivel intermedio entre el autocontrol y la congruencia entre su autoconcepto percibido y deseados, de acuerdo con su cultura.	Desinhibido / Controlado
1680	24	Q4	4	5	0.50	Medio	Presenta intermedio entre el estado de tensión y de tranquilidad ante sí mismo y ante la situaciones.	Tranquilo / Tensionado
1697	23	A	12	8	0.80	Alto	Persona afectuosa, participativa y colaboradora . Prefiere trabajar en grupos.	Reservado / Abierto
1698	23	B	8	4	0.40	Medio	Es una persona de juicio intelectual intermedio, no tiene niveles altos en manejar relaciones en termino de como se sitúan las cosas,  sin embargo tampoco es bajo.	Concreto / Abstracto
1699	23	C	24	10	1.00	Alto	Es una persona emocionalmente estable, madura y realista.  No deja que sus necesidades emocionales afecten la realidad de las situaciones.	Inestabilidad Emocional / Estabilidad emocional
1700	23	E	9	4	0.40	Medio	Persona que presenta niveles equilibrados entre ser sumisa y dominante.	Sumiso / Dominante
1701	23	F	16	6	0.60	Medio	Es una persona con un nivel intermedio entre ser prudente y ser impulsiva.	Prudente / Impulsivo
1702	23	G	15	6	0.60	Medio	Presenta un nivel intermedio en su nivel de responsabilidad y en aceptar las normas sociales.	Despreocupado / Escrupuloso
1569	12	A	14	8	0.80	Alto	Persona afectuosa, participativa y colaboradora . Prefiere trabajar en grupos.	Reservado / Abierto
1570	12	B	5	4	0.40	Medio	Es una persona de juicio intelectual intermedio, no tiene niveles altos en manejar relaciones en termino de como se sitúan las cosas,  sin embargo tampoco es bajo.	Concreto / Abstracto
1571	12	C	23	10	1.00	Alto	Es una persona emocionalmente estable, madura y realista.  No deja que sus necesidades emocionales afecten la realidad de las situaciones.	Inestabilidad Emocional / Estabilidad emocional
1572	12	E	7	3	0.30	Bajo	La persona es sumisa, cede fácilmente ante los demás, es dócil y conformista. Es modesta, humilde y obediente.	Sumiso / Dominante
1573	12	F	14	6	0.60	Medio	Es una persona con un nivel intermedio entre ser prudente y ser impulsiva.	Prudente / Impulsivo
1574	12	G	15	6	0.60	Medio	Presenta un nivel intermedio en su nivel de responsabilidad y en aceptar las normas sociales.	Despreocupado / Escrupuloso
1575	12	H	15	6	0.60	Medio	Es una persona con disposición a ser sociable y espontánea. Dispuesta en algunas ocasiones a ser atrevida e intentar nuevas cosas.	Tímido / Espontáneo
1576	12	I	10	3	0.30	Bajo	Es dura sentimentalmente. Actúa más basada en evidencias prácticas y lógicas. Es confiada de sí misma, acepta resopnsabilidades.  Espera poco de las personas.	Racional / Emocional
1577	12	L	6	3	0.30	Bajo	Es una persona confiada, comprensiva, permisiva y tolerante. Cede ante los cambios, no parece preocupada por corregir a los demás. Se sobrepone con facilidad a las dificultades.	Confiado / Suspicaz
1578	12	M	12	5	0.50	Medio	Persona que esta guiada por realidades objetivas o en ocasiones puede ser imaginativa y abstraerse en su pensamientos.	Práctico / Soñador
1579	12	N	14	7	0.70	Alto	Es sumamente astuta, exacta y calculadora. Diplomática , calculadora,  se desenvuelve bien en grupo. Ambisiosa y perspicaz.	Sencillo / Astuto
1580	12	O	8	4	0.40	Medio	Es una persona que puede mostrarse segura, tranquila, flexible y serena. Tiende a no culparse por sus acciones erradas, trata de actuar libremente sin temores, aunque en algunas ocasiones puede mostrar lo contrario.	Seguro / Inseguro
1581	12	Q1	10	5	0.50	Medio	Tiende a presentar interés por las nuevas ideas. Por lo general tiene actitudes de innovación y reacción ante lo establecido. Es poco convencionalista.	Tradicionalista / Innovador
1582	12	Q2	11	6	0.60	Medio	Tiende a ser autosuficiente e ingeniosa, llena de recursos, prefiere sus propias decisiones. Usualmente busca resolver los problemas por sí misma.	Dependencia del grupo / Autosuficiencia
1583	12	Q3	18	10	1.00	Alto	Tiene signos de perfeccionista, con alta congruencia en el autoconcepto percibido y el deseado. Alto nivel de autocontrol.	Desinhibido / Controlado
1584	12	Q4	6	3	0.30	Bajo	Es una persona callada, relajada, tranquila. Es algunas situaciones su estado de mucha satisfacción le puede llevar a la pereza y al bajo rendimiento.	Tranquilo / Tensionado
1681	26	A	11	8	0.80	Alto	Persona afectuosa, participativa y colaboradora . Prefiere trabajar en grupos.	Reservado / Abierto
1682	26	B	3	4	0.40	Medio	Es una persona de juicio intelectual intermedio, no tiene niveles altos en manejar relaciones en termino de como se sitúan las cosas,  sin embargo tampoco es bajo.	Concreto / Abstracto
1683	26	C	21	9	0.90	Alto	Es una persona emocionalmente estable, madura y realista.  No deja que sus necesidades emocionales afecten la realidad de las situaciones.	Inestabilidad Emocional / Estabilidad emocional
1684	26	E	10	5	0.50	Medio	Persona que presenta niveles equilibrados entre ser sumisa y dominante.	Sumiso / Dominante
1685	26	F	11	4	0.40	Medio	Es una persona con un nivel intermedio entre ser prudente y ser impulsiva.	Prudente / Impulsivo
1686	26	G	17	7	0.70	Alto	Esta dominada por el sentido del deber, perseverante, responsable y organizada. Es escrupulosa y moralista.	Despreocupado / Escrupuloso
1687	26	H	18	7	0.70	Alto	Suele ser tímida, muy retraída. Se muestra cohibida y con falta de confianza en si misma. Puede presentar sentimientos de inferioridad. Se retrae fácilmente ante el sexo apuesto.	Tímido / Espontáneo
1688	26	I	13	5	0.50	Medio	La persona actúa como igual facilidad entre las respuestas de pensamiento y sentimiento.	Racional / Emocional
1689	26	L	8	4	0.40	Medio	Presenta un nivel intermedio de confianza en las persona y en las situaciones.	Confiado / Suspicaz
1690	26	M	16	7	0.70	Alto	Persona muy imaginativa, se abstrae mucho en sus pensamientos. Se entusiasma rápidamente, cambia y abandona las ideas bruscamente.	Práctico / Soñador
1585	13	A	10	8	0.80	Alto	Persona afectuosa, participativa y colaboradora . Prefiere trabajar en grupos.	Reservado / Abierto
1586	13	B	6	4	0.40	Medio	Es una persona de juicio intelectual intermedio, no tiene niveles altos en manejar relaciones en termino de como se sitúan las cosas,  sin embargo tampoco es bajo.	Concreto / Abstracto
1587	13	C	19	5	0.50	Medio	Es una persona que esta medianamente estable. El algunas ocasiones se puede mostrar inestable emocionalmente.	Inestabilidad Emocional / Estabilidad emocional
1588	13	E	10	4	0.40	Medio	Persona que presenta niveles equilibrados entre ser sumisa y dominante.	Sumiso / Dominante
1589	13	F	10	4	0.40	Medio	Es una persona con un nivel intermedio entre ser prudente y ser impulsiva.	Prudente / Impulsivo
1590	13	G	16	5	0.50	Medio	Presenta un nivel intermedio en su nivel de responsabilidad y en aceptar las normas sociales.	Despreocupado / Escrupuloso
1591	13	H	15	4	0.40	Medio	Es una persona con disposición a ser sociable y espontánea. Dispuesta en algunas ocasiones a ser atrevida e intentar nuevas cosas.	Tímido / Espontáneo
1592	13	I	8	4	0.40	Medio	La persona actúa como igual facilidad entre las respuestas de pensamiento y sentimiento.	Racional / Emocional
1593	13	L	7	5	0.50	Medio	Presenta un nivel intermedio de confianza en las persona y en las situaciones.	Confiado / Suspicaz
1594	13	M	18	9	0.90	Alto	Persona muy imaginativa, se abstrae mucho en sus pensamientos. Se entusiasma rápidamente, cambia y abandona las ideas bruscamente.	Práctico / Soñador
1595	13	N	12	6	0.60	Medio	Puede ser sencilla e ingenua socialmente o calculadora en ocasiones.	Sencillo / Astuto
1596	13	O	2	4	0.40	Medio	Es una persona que puede mostrarse segura, tranquila, flexible y serena. Tiende a no culparse por sus acciones erradas, trata de actuar libremente sin temores, aunque en algunas ocasiones puede mostrar lo contrario.	Seguro / Inseguro
1691	26	N	9	4	0.40	Medio	Puede ser sencilla e ingenua socialmente o calculadora en ocasiones.	Sencillo / Astuto
1597	13	Q1	11	6	0.60	Medio	Tiende a presentar interés por las nuevas ideas. Por lo general tiene actitudes de innovación y reacción ante lo establecido. Es poco convencionalista.	Tradicionalista / Innovador
1598	13	Q2	9	6	0.60	Medio	Tiende a ser autosuficiente e ingeniosa, llena de recursos, prefiere sus propias decisiones. Usualmente busca resolver los problemas por sí misma.	Dependencia del grupo / Autosuficiencia
1599	13	Q3	20	8	0.80	Alto	Tiene signos de perfeccionista, con alta congruencia en el autoconcepto percibido y el deseado. Alto nivel de autocontrol.	Desinhibido / Controlado
1600	13	Q4	2	4	0.40	Medio	Presenta intermedio entre el estado de tensión y de tranquilidad ante sí mismo y ante la situaciones.	Tranquilo / Tensionado
1692	26	O	10	5	0.50	Medio	Es una persona que puede mostrarse segura, tranquila, flexible y serena. Tiende a no culparse por sus acciones erradas, trata de actuar libremente sin temores, aunque en algunas ocasiones puede mostrar lo contrario.	Seguro / Inseguro
1693	26	Q1	9	4	0.40	Medio	Tiende a presentar interés por las nuevas ideas. Por lo general tiene actitudes de innovación y reacción ante lo establecido. Es poco convencionalista.	Tradicionalista / Innovador
1694	26	Q2	10	5	0.50	Medio	Tiende a ser autosuficiente e ingeniosa, llena de recursos, prefiere sus propias decisiones. Usualmente busca resolver los problemas por sí misma.	Dependencia del grupo / Autosuficiencia
1695	26	Q3	15	8	0.80	Alto	Tiene signos de perfeccionista, con alta congruencia en el autoconcepto percibido y el deseado. Alto nivel de autocontrol.	Desinhibido / Controlado
1696	26	Q4	7	3	0.30	Bajo	Es una persona callada, relajada, tranquila. Es algunas situaciones su estado de mucha satisfacción le puede llevar a la pereza y al bajo rendimiento.	Tranquilo / Tensionado
1703	23	H	12	5	0.50	Medio	Es una persona con disposición a ser sociable y espontánea. Dispuesta en algunas ocasiones a ser atrevida e intentar nuevas cosas.	Tímido / Espontáneo
1704	23	I	11	4	0.40	Medio	La persona actúa como igual facilidad entre las respuestas de pensamiento y sentimiento.	Racional / Emocional
1705	23	L	4	2	0.20	Bajo	Es una persona confiada, comprensiva, permisiva y tolerante. Cede ante los cambios, no parece preocupada por corregir a los demás. Se sobrepone con facilidad a las dificultades.	Confiado / Suspicaz
1706	23	M	13	5	0.50	Medio	Persona que esta guiada por realidades objetivas o en ocasiones puede ser imaginativa y abstraerse en su pensamientos.	Práctico / Soñador
1707	23	N	12	6	0.60	Medio	Puede ser sencilla e ingenua socialmente o calculadora en ocasiones.	Sencillo / Astuto
1708	23	O	12	6	0.60	Medio	Es una persona que puede mostrarse segura, tranquila, flexible y serena. Tiende a no culparse por sus acciones erradas, trata de actuar libremente sin temores, aunque en algunas ocasiones puede mostrar lo contrario.	Seguro / Inseguro
1709	23	Q1	9	4	0.40	Medio	Tiende a presentar interés por las nuevas ideas. Por lo general tiene actitudes de innovación y reacción ante lo establecido. Es poco convencionalista.	Tradicionalista / Innovador
1710	23	Q2	12	6	0.60	Medio	Tiende a ser autosuficiente e ingeniosa, llena de recursos, prefiere sus propias decisiones. Usualmente busca resolver los problemas por sí misma.	Dependencia del grupo / Autosuficiencia
1711	23	Q3	15	8	0.80	Alto	Tiene signos de perfeccionista, con alta congruencia en el autoconcepto percibido y el deseado. Alto nivel de autocontrol.	Desinhibido / Controlado
1712	23	Q4	7	3	0.30	Bajo	Es una persona callada, relajada, tranquila. Es algunas situaciones su estado de mucha satisfacción le puede llevar a la pereza y al bajo rendimiento.	Tranquilo / Tensionado
1713	34	A	17	8	0.80	Alto	Persona afectuosa, participativa y colaboradora . Prefiere trabajar en grupos.	Reservado / Abierto
1714	34	B	4	4	0.40	Medio	Es una persona de juicio intelectual intermedio, no tiene niveles altos en manejar relaciones en termino de como se sitúan las cosas,  sin embargo tampoco es bajo.	Concreto / Abstracto
1715	34	C	23	8	0.80	Alto	Es una persona emocionalmente estable, madura y realista.  No deja que sus necesidades emocionales afecten la realidad de las situaciones.	Inestabilidad Emocional / Estabilidad emocional
1716	34	E	16	7	0.70	Alto	Es una persona dominante, le gusta controlar las situaciones y las personas.	Sumiso / Dominante
1717	34	F	15	6	0.60	Medio	Es una persona con un nivel intermedio entre ser prudente y ser impulsiva.	Prudente / Impulsivo
1718	34	G	15	5	0.50	Medio	Presenta un nivel intermedio en su nivel de responsabilidad y en aceptar las normas sociales.	Despreocupado / Escrupuloso
1719	34	H	23	9	0.90	Alto	Suele ser tímida, muy retraída. Se muestra cohibida y con falta de confianza en si misma. Puede presentar sentimientos de inferioridad. Se retrae fácilmente ante el sexo apuesto.	Tímido / Espontáneo
1720	34	I	14	5	0.50	Medio	La persona actúa como igual facilidad entre las respuestas de pensamiento y sentimiento.	Racional / Emocional
1721	34	L	7	4	0.40	Medio	Presenta un nivel intermedio de confianza en las persona y en las situaciones.	Confiado / Suspicaz
1722	34	M	9	3	0.30	Bajo	Es una persona preocupada por intereses y hechos inmediatos. Se muestra ansiosa por hacer cosas correctamente. Antenta los problemas prácticos y cercanos.	Práctico / Soñador
1723	34	N	8	3	0.30	Bajo	Es sencilla, natrual y poco sofisticada. Se le satisface y se muestra contenta con lo que acontece, es sincera e ingenua.	Sencillo / Astuto
1724	34	O	10	7	0.70	Alto	Es una persona insegura, intranquila, preocupada y deprimida. Se culpa por sus acciones erradas. Se afecta con facilidad, es muy sensible a la aprobación de los demás.	Seguro / Inseguro
1725	34	Q1	7	3	0.30	Bajo	Es conservadora, respetuosa de las ideas establecidas, tolerante de los defectos tradicionales. Es precavida y resistente a las nuevas ideas, postone los cambios, sigue la línea tradicional es convencionalista.	Tradicionalista / Innovador
1726	34	Q2	11	7	0.70	Alto	Es autosuficiente, ingeniosa y llena de recursos, prefiere las propias decisiones. Busca resolver problemas por sí misma.	Dependencia del grupo / Autosuficiencia
1727	34	Q3	14	5	0.50	Medio	Tiene un nivel intermedio entre el autocontrol y la congruencia entre su autoconcepto percibido y deseados, de acuerdo con su cultura.	Desinhibido / Controlado
1728	34	Q4	4	4	0.40	Medio	Presenta intermedio entre el estado de tensión y de tranquilidad ante sí mismo y ante la situaciones.	Tranquilo / Tensionado
1729	31	A	10	8	0.80	Alto	Persona afectuosa, participativa y colaboradora . Prefiere trabajar en grupos.	Reservado / Abierto
1730	31	B	3	4	0.40	Medio	Es una persona de juicio intelectual intermedio, no tiene niveles altos en manejar relaciones en termino de como se sitúan las cosas,  sin embargo tampoco es bajo.	Concreto / Abstracto
1731	31	C	18	7	0.70	Alto	Es una persona emocionalmente estable, madura y realista.  No deja que sus necesidades emocionales afecten la realidad de las situaciones.	Inestabilidad Emocional / Estabilidad emocional
1732	31	E	16	7	0.70	Alto	Es una persona dominante, le gusta controlar las situaciones y las personas.	Sumiso / Dominante
1733	31	F	16	6	0.60	Medio	Es una persona con un nivel intermedio entre ser prudente y ser impulsiva.	Prudente / Impulsivo
1734	31	G	14	6	0.60	Medio	Presenta un nivel intermedio en su nivel de responsabilidad y en aceptar las normas sociales.	Despreocupado / Escrupuloso
1735	31	H	20	8	0.80	Alto	Suele ser tímida, muy retraída. Se muestra cohibida y con falta de confianza en si misma. Puede presentar sentimientos de inferioridad. Se retrae fácilmente ante el sexo apuesto.	Tímido / Espontáneo
1736	31	I	12	4	0.40	Medio	La persona actúa como igual facilidad entre las respuestas de pensamiento y sentimiento.	Racional / Emocional
1737	31	L	4	2	0.20	Bajo	Es una persona confiada, comprensiva, permisiva y tolerante. Cede ante los cambios, no parece preocupada por corregir a los demás. Se sobrepone con facilidad a las dificultades.	Confiado / Suspicaz
1738	31	M	14	6	0.60	Medio	Persona que esta guiada por realidades objetivas o en ocasiones puede ser imaginativa y abstraerse en su pensamientos.	Práctico / Soñador
1739	31	N	12	6	0.60	Medio	Puede ser sencilla e ingenua socialmente o calculadora en ocasiones.	Sencillo / Astuto
1740	31	O	8	4	0.40	Medio	Es una persona que puede mostrarse segura, tranquila, flexible y serena. Tiende a no culparse por sus acciones erradas, trata de actuar libremente sin temores, aunque en algunas ocasiones puede mostrar lo contrario.	Seguro / Inseguro
1741	31	Q1	11	6	0.60	Medio	Tiende a presentar interés por las nuevas ideas. Por lo general tiene actitudes de innovación y reacción ante lo establecido. Es poco convencionalista.	Tradicionalista / Innovador
1742	31	Q2	8	4	0.40	Medio	Tiende a ser autosuficiente e ingeniosa, llena de recursos, prefiere sus propias decisiones. Usualmente busca resolver los problemas por sí misma.	Dependencia del grupo / Autosuficiencia
1743	31	Q3	16	8	0.80	Alto	Tiene signos de perfeccionista, con alta congruencia en el autoconcepto percibido y el deseado. Alto nivel de autocontrol.	Desinhibido / Controlado
1744	31	Q4	5	2	0.20	Bajo	Es una persona callada, relajada, tranquila. Es algunas situaciones su estado de mucha satisfacción le puede llevar a la pereza y al bajo rendimiento.	Tranquilo / Tensionado
1745	20	A	14	8	0.80	Alto	Persona afectuosa, participativa y colaboradora . Prefiere trabajar en grupos.	Reservado / Abierto
1746	20	B	4	4	0.40	Medio	Es una persona de juicio intelectual intermedio, no tiene niveles altos en manejar relaciones en termino de como se sitúan las cosas,  sin embargo tampoco es bajo.	Concreto / Abstracto
1747	20	C	20	8	0.80	Alto	Es una persona emocionalmente estable, madura y realista.  No deja que sus necesidades emocionales afecten la realidad de las situaciones.	Inestabilidad Emocional / Estabilidad emocional
1748	20	E	9	4	0.40	Medio	Persona que presenta niveles equilibrados entre ser sumisa y dominante.	Sumiso / Dominante
1749	20	F	6	2	0.20	Bajo	Es prudente e instrospectiva. Reflexiva, presenta temor a cometer errores y tiene indecisión acerca de tomar riesgos.	Prudente / Impulsivo
1750	20	G	16	7	0.70	Alto	Esta dominada por el sentido del deber, perseverante, responsable y organizada. Es escrupulosa y moralista.	Despreocupado / Escrupuloso
1751	20	H	16	7	0.70	Alto	Suele ser tímida, muy retraída. Se muestra cohibida y con falta de confianza en si misma. Puede presentar sentimientos de inferioridad. Se retrae fácilmente ante el sexo apuesto.	Tímido / Espontáneo
1752	20	I	12	4	0.40	Medio	La persona actúa como igual facilidad entre las respuestas de pensamiento y sentimiento.	Racional / Emocional
1753	20	L	9	5	0.50	Medio	Presenta un nivel intermedio de confianza en las persona y en las situaciones.	Confiado / Suspicaz
1754	20	M	11	4	0.40	Medio	Persona que esta guiada por realidades objetivas o en ocasiones puede ser imaginativa y abstraerse en su pensamientos.	Práctico / Soñador
1755	20	N	15	8	0.80	Alto	Es sumamente astuta, exacta y calculadora. Diplomática , calculadora,  se desenvuelve bien en grupo. Ambisiosa y perspicaz.	Sencillo / Astuto
1756	20	O	10	5	0.50	Medio	Es una persona que puede mostrarse segura, tranquila, flexible y serena. Tiende a no culparse por sus acciones erradas, trata de actuar libremente sin temores, aunque en algunas ocasiones puede mostrar lo contrario.	Seguro / Inseguro
1757	20	Q1	7	3	0.30	Bajo	Es conservadora, respetuosa de las ideas establecidas, tolerante de los defectos tradicionales. Es precavida y resistente a las nuevas ideas, postone los cambios, sigue la línea tradicional es convencionalista.	Tradicionalista / Innovador
1758	20	Q2	11	6	0.60	Medio	Tiende a ser autosuficiente e ingeniosa, llena de recursos, prefiere sus propias decisiones. Usualmente busca resolver los problemas por sí misma.	Dependencia del grupo / Autosuficiencia
1759	20	Q3	13	7	0.70	Alto	Tiene signos de perfeccionista, con alta congruencia en el autoconcepto percibido y el deseado. Alto nivel de autocontrol.	Desinhibido / Controlado
1760	20	Q4	6	3	0.30	Bajo	Es una persona callada, relajada, tranquila. Es algunas situaciones su estado de mucha satisfacción le puede llevar a la pereza y al bajo rendimiento.	Tranquilo / Tensionado
1761	36	A	13	8	0.80	Alto	Persona afectuosa, participativa y colaboradora . Prefiere trabajar en grupos.	Reservado / Abierto
1762	36	B	5	4	0.40	Medio	Es una persona de juicio intelectual intermedio, no tiene niveles altos en manejar relaciones en termino de como se sitúan las cosas,  sin embargo tampoco es bajo.	Concreto / Abstracto
1763	36	C	20	8	0.80	Alto	Es una persona emocionalmente estable, madura y realista.  No deja que sus necesidades emocionales afecten la realidad de las situaciones.	Inestabilidad Emocional / Estabilidad emocional
1764	36	E	12	6	0.60	Medio	Persona que presenta niveles equilibrados entre ser sumisa y dominante.	Sumiso / Dominante
1765	36	F	17	7	0.70	Alto	Es una persona impulsiva. Demasiado franca.  Responde con rapidez a los eventos que sean de su interés.	Prudente / Impulsivo
1766	36	G	20	10	1.00	Alto	Esta dominada por el sentido del deber, perseverante, responsable y organizada. Es escrupulosa y moralista.	Despreocupado / Escrupuloso
1767	36	H	21	9	0.90	Alto	Suele ser tímida, muy retraída. Se muestra cohibida y con falta de confianza en si misma. Puede presentar sentimientos de inferioridad. Se retrae fácilmente ante el sexo apuesto.	Tímido / Espontáneo
1768	36	I	10	3	0.30	Bajo	Es dura sentimentalmente. Actúa más basada en evidencias prácticas y lógicas. Es confiada de sí misma, acepta resopnsabilidades.  Espera poco de las personas.	Racional / Emocional
1769	36	L	5	2	0.20	Bajo	Es una persona confiada, comprensiva, permisiva y tolerante. Cede ante los cambios, no parece preocupada por corregir a los demás. Se sobrepone con facilidad a las dificultades.	Confiado / Suspicaz
1770	36	M	12	5	0.50	Medio	Persona que esta guiada por realidades objetivas o en ocasiones puede ser imaginativa y abstraerse en su pensamientos.	Práctico / Soñador
1771	36	N	13	7	0.70	Alto	Es sumamente astuta, exacta y calculadora. Diplomática , calculadora,  se desenvuelve bien en grupo. Ambisiosa y perspicaz.	Sencillo / Astuto
1772	36	O	13	6	0.60	Medio	Es una persona que puede mostrarse segura, tranquila, flexible y serena. Tiende a no culparse por sus acciones erradas, trata de actuar libremente sin temores, aunque en algunas ocasiones puede mostrar lo contrario.	Seguro / Inseguro
1773	36	Q1	10	5	0.50	Medio	Tiende a presentar interés por las nuevas ideas. Por lo general tiene actitudes de innovación y reacción ante lo establecido. Es poco convencionalista.	Tradicionalista / Innovador
1774	36	Q2	10	5	0.50	Medio	Tiende a ser autosuficiente e ingeniosa, llena de recursos, prefiere sus propias decisiones. Usualmente busca resolver los problemas por sí misma.	Dependencia del grupo / Autosuficiencia
1775	36	Q3	15	8	0.80	Alto	Tiene signos de perfeccionista, con alta congruencia en el autoconcepto percibido y el deseado. Alto nivel de autocontrol.	Desinhibido / Controlado
1776	36	Q4	4	2	0.20	Bajo	Es una persona callada, relajada, tranquila. Es algunas situaciones su estado de mucha satisfacción le puede llevar a la pereza y al bajo rendimiento.	Tranquilo / Tensionado
1777	38	A	13	8	0.80	Alto	Persona afectuosa, participativa y colaboradora . Prefiere trabajar en grupos.	Reservado / Abierto
1778	38	B	7	4	0.40	Medio	Es una persona de juicio intelectual intermedio, no tiene niveles altos en manejar relaciones en termino de como se sitúan las cosas,  sin embargo tampoco es bajo.	Concreto / Abstracto
1779	38	C	18	5	0.50	Medio	Es una persona que esta medianamente estable. El algunas ocasiones se puede mostrar inestable emocionalmente.	Inestabilidad Emocional / Estabilidad emocional
1780	38	E	5	2	0.20	Bajo	La persona es sumisa, cede fácilmente ante los demás, es dócil y conformista. Es modesta, humilde y obediente.	Sumiso / Dominante
1781	38	F	15	6	0.60	Medio	Es una persona con un nivel intermedio entre ser prudente y ser impulsiva.	Prudente / Impulsivo
1782	38	G	16	6	0.60	Medio	Presenta un nivel intermedio en su nivel de responsabilidad y en aceptar las normas sociales.	Despreocupado / Escrupuloso
1783	38	H	16	6	0.60	Medio	Es una persona con disposición a ser sociable y espontánea. Dispuesta en algunas ocasiones a ser atrevida e intentar nuevas cosas.	Tímido / Espontáneo
1784	38	I	15	6	0.60	Medio	La persona actúa como igual facilidad entre las respuestas de pensamiento y sentimiento.	Racional / Emocional
1785	38	L	11	7	0.70	Alto	Es una persona celosa, desconfiada de las situaciones y de la gente. Insiste en hacer comprender su opinión, busca y exige  que los demás reconozcan los errores que han cometido.	Confiado / Suspicaz
1786	38	M	15	6	0.60	Medio	Persona que esta guiada por realidades objetivas o en ocasiones puede ser imaginativa y abstraerse en su pensamientos.	Práctico / Soñador
1787	38	N	12	6	0.60	Medio	Puede ser sencilla e ingenua socialmente o calculadora en ocasiones.	Sencillo / Astuto
1788	38	O	11	7	0.70	Alto	Es una persona insegura, intranquila, preocupada y deprimida. Se culpa por sus acciones erradas. Se afecta con facilidad, es muy sensible a la aprobación de los demás.	Seguro / Inseguro
1789	38	Q1	8	4	0.40	Medio	Tiende a presentar interés por las nuevas ideas. Por lo general tiene actitudes de innovación y reacción ante lo establecido. Es poco convencionalista.	Tradicionalista / Innovador
1790	38	Q2	6	4	0.40	Medio	Tiende a ser autosuficiente e ingeniosa, llena de recursos, prefiere sus propias decisiones. Usualmente busca resolver los problemas por sí misma.	Dependencia del grupo / Autosuficiencia
1791	38	Q3	16	6	0.60	Medio	Tiene un nivel intermedio entre el autocontrol y la congruencia entre su autoconcepto percibido y deseados, de acuerdo con su cultura.	Desinhibido / Controlado
1792	38	Q4	5	4	0.40	Medio	Presenta intermedio entre el estado de tensión y de tranquilidad ante sí mismo y ante la situaciones.	Tranquilo / Tensionado
1793	37	A	12	8	0.80	Alto	Persona afectuosa, participativa y colaboradora . Prefiere trabajar en grupos.	Reservado / Abierto
1794	37	B	3	4	0.40	Medio	Es una persona de juicio intelectual intermedio, no tiene niveles altos en manejar relaciones en termino de como se sitúan las cosas,  sin embargo tampoco es bajo.	Concreto / Abstracto
1795	37	C	21	9	0.90	Alto	Es una persona emocionalmente estable, madura y realista.  No deja que sus necesidades emocionales afecten la realidad de las situaciones.	Inestabilidad Emocional / Estabilidad emocional
1796	37	E	10	5	0.50	Medio	Persona que presenta niveles equilibrados entre ser sumisa y dominante.	Sumiso / Dominante
1797	37	F	17	7	0.70	Alto	Es una persona impulsiva. Demasiado franca.  Responde con rapidez a los eventos que sean de su interés.	Prudente / Impulsivo
1798	37	G	16	7	0.70	Alto	Esta dominada por el sentido del deber, perseverante, responsable y organizada. Es escrupulosa y moralista.	Despreocupado / Escrupuloso
1799	37	H	18	7	0.70	Alto	Suele ser tímida, muy retraída. Se muestra cohibida y con falta de confianza en si misma. Puede presentar sentimientos de inferioridad. Se retrae fácilmente ante el sexo apuesto.	Tímido / Espontáneo
1800	37	I	17	7	0.70	Alto	Es afectada por los sentimientos,  bastante sensible. Se muestra inquieta, espera afecto y atención.  Es indulgente consigo y con los demás.	Racional / Emocional
1801	37	L	7	3	0.30	Bajo	Es una persona confiada, comprensiva, permisiva y tolerante. Cede ante los cambios, no parece preocupada por corregir a los demás. Se sobrepone con facilidad a las dificultades.	Confiado / Suspicaz
1802	37	M	11	4	0.40	Medio	Persona que esta guiada por realidades objetivas o en ocasiones puede ser imaginativa y abstraerse en su pensamientos.	Práctico / Soñador
1803	37	N	12	6	0.60	Medio	Puede ser sencilla e ingenua socialmente o calculadora en ocasiones.	Sencillo / Astuto
1804	37	O	10	5	0.50	Medio	Es una persona que puede mostrarse segura, tranquila, flexible y serena. Tiende a no culparse por sus acciones erradas, trata de actuar libremente sin temores, aunque en algunas ocasiones puede mostrar lo contrario.	Seguro / Inseguro
1805	37	Q1	10	5	0.50	Medio	Tiende a presentar interés por las nuevas ideas. Por lo general tiene actitudes de innovación y reacción ante lo establecido. Es poco convencionalista.	Tradicionalista / Innovador
1806	37	Q2	11	6	0.60	Medio	Tiende a ser autosuficiente e ingeniosa, llena de recursos, prefiere sus propias decisiones. Usualmente busca resolver los problemas por sí misma.	Dependencia del grupo / Autosuficiencia
1807	37	Q3	17	9	0.90	Alto	Tiene signos de perfeccionista, con alta congruencia en el autoconcepto percibido y el deseado. Alto nivel de autocontrol.	Desinhibido / Controlado
1808	37	Q4	3	1	0.10	Bajo	Es una persona callada, relajada, tranquila. Es algunas situaciones su estado de mucha satisfacción le puede llevar a la pereza y al bajo rendimiento.	Tranquilo / Tensionado
1809	40	A	13	8	0.80	Alto	Persona afectuosa, participativa y colaboradora . Prefiere trabajar en grupos.	Reservado / Abierto
1810	40	B	6	4	0.40	Medio	Es una persona de juicio intelectual intermedio, no tiene niveles altos en manejar relaciones en termino de como se sitúan las cosas,  sin embargo tampoco es bajo.	Concreto / Abstracto
1811	40	C	19	8	0.80	Alto	Es una persona emocionalmente estable, madura y realista.  No deja que sus necesidades emocionales afecten la realidad de las situaciones.	Inestabilidad Emocional / Estabilidad emocional
1812	40	E	9	4	0.40	Medio	Persona que presenta niveles equilibrados entre ser sumisa y dominante.	Sumiso / Dominante
1813	40	F	8	3	0.30	Bajo	Es prudente e instrospectiva. Reflexiva, presenta temor a cometer errores y tiene indecisión acerca de tomar riesgos.	Prudente / Impulsivo
1814	40	G	17	7	0.70	Alto	Esta dominada por el sentido del deber, perseverante, responsable y organizada. Es escrupulosa y moralista.	Despreocupado / Escrupuloso
1815	40	H	20	8	0.80	Alto	Suele ser tímida, muy retraída. Se muestra cohibida y con falta de confianza en si misma. Puede presentar sentimientos de inferioridad. Se retrae fácilmente ante el sexo apuesto.	Tímido / Espontáneo
1816	40	I	16	6	0.60	Medio	La persona actúa como igual facilidad entre las respuestas de pensamiento y sentimiento.	Racional / Emocional
1817	40	L	6	3	0.30	Bajo	Es una persona confiada, comprensiva, permisiva y tolerante. Cede ante los cambios, no parece preocupada por corregir a los demás. Se sobrepone con facilidad a las dificultades.	Confiado / Suspicaz
1818	40	M	10	4	0.40	Medio	Persona que esta guiada por realidades objetivas o en ocasiones puede ser imaginativa y abstraerse en su pensamientos.	Práctico / Soñador
1819	40	N	13	7	0.70	Alto	Es sumamente astuta, exacta y calculadora. Diplomática , calculadora,  se desenvuelve bien en grupo. Ambisiosa y perspicaz.	Sencillo / Astuto
1820	40	O	10	5	0.50	Medio	Es una persona que puede mostrarse segura, tranquila, flexible y serena. Tiende a no culparse por sus acciones erradas, trata de actuar libremente sin temores, aunque en algunas ocasiones puede mostrar lo contrario.	Seguro / Inseguro
1821	40	Q1	2	1	0.10	Bajo	Es conservadora, respetuosa de las ideas establecidas, tolerante de los defectos tradicionales. Es precavida y resistente a las nuevas ideas, postone los cambios, sigue la línea tradicional es convencionalista.	Tradicionalista / Innovador
1822	40	Q2	8	4	0.40	Medio	Tiende a ser autosuficiente e ingeniosa, llena de recursos, prefiere sus propias decisiones. Usualmente busca resolver los problemas por sí misma.	Dependencia del grupo / Autosuficiencia
1823	40	Q3	15	8	0.80	Alto	Tiene signos de perfeccionista, con alta congruencia en el autoconcepto percibido y el deseado. Alto nivel de autocontrol.	Desinhibido / Controlado
1824	40	Q4	8	4	0.40	Medio	Presenta intermedio entre el estado de tensión y de tranquilidad ante sí mismo y ante la situaciones.	Tranquilo / Tensionado
1841	42	A	13	8	0.80	Alto	Persona afectuosa, participativa y colaboradora . Prefiere trabajar en grupos.	Reservado / Abierto
1842	42	B	3	4	0.40	Medio	Es una persona de juicio intelectual intermedio, no tiene niveles altos en manejar relaciones en termino de como se sitúan las cosas,  sin embargo tampoco es bajo.	Concreto / Abstracto
1843	42	C	17	7	0.70	Alto	Es una persona emocionalmente estable, madura y realista.  No deja que sus necesidades emocionales afecten la realidad de las situaciones.	Inestabilidad Emocional / Estabilidad emocional
1844	42	E	11	5	0.50	Medio	Persona que presenta niveles equilibrados entre ser sumisa y dominante.	Sumiso / Dominante
1845	42	F	17	7	0.70	Alto	Es una persona impulsiva. Demasiado franca.  Responde con rapidez a los eventos que sean de su interés.	Prudente / Impulsivo
1846	42	G	12	5	0.50	Medio	Presenta un nivel intermedio en su nivel de responsabilidad y en aceptar las normas sociales.	Despreocupado / Escrupuloso
1847	42	H	17	7	0.70	Alto	Suele ser tímida, muy retraída. Se muestra cohibida y con falta de confianza en si misma. Puede presentar sentimientos de inferioridad. Se retrae fácilmente ante el sexo apuesto.	Tímido / Espontáneo
1848	42	I	11	4	0.40	Medio	La persona actúa como igual facilidad entre las respuestas de pensamiento y sentimiento.	Racional / Emocional
1849	42	L	12	6	0.60	Medio	Presenta un nivel intermedio de confianza en las persona y en las situaciones.	Confiado / Suspicaz
1850	42	M	18	8	0.80	Alto	Persona muy imaginativa, se abstrae mucho en sus pensamientos. Se entusiasma rápidamente, cambia y abandona las ideas bruscamente.	Práctico / Soñador
1851	42	N	5	1	0.10	Bajo	Es sencilla, natrual y poco sofisticada. Se le satisface y se muestra contenta con lo que acontece, es sincera e ingenua.	Sencillo / Astuto
1852	42	O	18	9	0.90	Alto	Es una persona insegura, intranquila, preocupada y deprimida. Se culpa por sus acciones erradas. Se afecta con facilidad, es muy sensible a la aprobación de los demás.	Seguro / Inseguro
1853	42	Q1	4	1	0.10	Bajo	Es conservadora, respetuosa de las ideas establecidas, tolerante de los defectos tradicionales. Es precavida y resistente a las nuevas ideas, postone los cambios, sigue la línea tradicional es convencionalista.	Tradicionalista / Innovador
1854	42	Q2	10	5	0.50	Medio	Tiende a ser autosuficiente e ingeniosa, llena de recursos, prefiere sus propias decisiones. Usualmente busca resolver los problemas por sí misma.	Dependencia del grupo / Autosuficiencia
1855	42	Q3	15	8	0.80	Alto	Tiene signos de perfeccionista, con alta congruencia en el autoconcepto percibido y el deseado. Alto nivel de autocontrol.	Desinhibido / Controlado
1856	42	Q4	8	4	0.40	Medio	Presenta intermedio entre el estado de tensión y de tranquilidad ante sí mismo y ante la situaciones.	Tranquilo / Tensionado
1857	44	A	16	8	0.80	Alto	Persona afectuosa, participativa y colaboradora . Prefiere trabajar en grupos.	Reservado / Abierto
1858	44	B	6	4	0.40	Medio	Es una persona de juicio intelectual intermedio, no tiene niveles altos en manejar relaciones en termino de como se sitúan las cosas,  sin embargo tampoco es bajo.	Concreto / Abstracto
1859	44	C	21	7	0.70	Alto	Es una persona emocionalmente estable, madura y realista.  No deja que sus necesidades emocionales afecten la realidad de las situaciones.	Inestabilidad Emocional / Estabilidad emocional
1860	44	E	12	6	0.60	Medio	Persona que presenta niveles equilibrados entre ser sumisa y dominante.	Sumiso / Dominante
1861	44	F	13	5	0.50	Medio	Es una persona con un nivel intermedio entre ser prudente y ser impulsiva.	Prudente / Impulsivo
1862	44	G	11	3	0.30	Bajo	La persona suele ser inestable en sus propósitos. Demuestra alta despreocupación y muy poca consideración por las normas de la sociedad.	Despreocupado / Escrupuloso
1863	44	H	20	7	0.70	Alto	Suele ser tímida, muy retraída. Se muestra cohibida y con falta de confianza en si misma. Puede presentar sentimientos de inferioridad. Se retrae fácilmente ante el sexo apuesto.	Tímido / Espontáneo
1864	44	I	13	5	0.50	Medio	La persona actúa como igual facilidad entre las respuestas de pensamiento y sentimiento.	Racional / Emocional
1865	44	L	9	6	0.60	Medio	Presenta un nivel intermedio de confianza en las persona y en las situaciones.	Confiado / Suspicaz
1866	44	M	13	5	0.50	Medio	Persona que esta guiada por realidades objetivas o en ocasiones puede ser imaginativa y abstraerse en su pensamientos.	Práctico / Soñador
1867	44	N	7	3	0.30	Bajo	Es sencilla, natrual y poco sofisticada. Se le satisface y se muestra contenta con lo que acontece, es sincera e ingenua.	Sencillo / Astuto
1868	44	O	6	5	0.50	Medio	Es una persona que puede mostrarse segura, tranquila, flexible y serena. Tiende a no culparse por sus acciones erradas, trata de actuar libremente sin temores, aunque en algunas ocasiones puede mostrar lo contrario.	Seguro / Inseguro
1869	44	Q1	6	2	0.20	Bajo	Es conservadora, respetuosa de las ideas establecidas, tolerante de los defectos tradicionales. Es precavida y resistente a las nuevas ideas, postone los cambios, sigue la línea tradicional es convencionalista.	Tradicionalista / Innovador
1870	44	Q2	13	8	0.80	Alto	Es autosuficiente, ingeniosa y llena de recursos, prefiere las propias decisiones. Busca resolver problemas por sí misma.	Dependencia del grupo / Autosuficiencia
1871	44	Q3	17	7	0.70	Alto	Tiene signos de perfeccionista, con alta congruencia en el autoconcepto percibido y el deseado. Alto nivel de autocontrol.	Desinhibido / Controlado
1872	44	Q4	3	3	0.30	Bajo	Es una persona callada, relajada, tranquila. Es algunas situaciones su estado de mucha satisfacción le puede llevar a la pereza y al bajo rendimiento.	Tranquilo / Tensionado
1873	39	A	14	8	0.80	Alto	Persona afectuosa, participativa y colaboradora . Prefiere trabajar en grupos.	Reservado / Abierto
1874	39	B	4	4	0.40	Medio	Es una persona de juicio intelectual intermedio, no tiene niveles altos en manejar relaciones en termino de como se sitúan las cosas,  sin embargo tampoco es bajo.	Concreto / Abstracto
1875	39	C	22	7	0.70	Alto	Es una persona emocionalmente estable, madura y realista.  No deja que sus necesidades emocionales afecten la realidad de las situaciones.	Inestabilidad Emocional / Estabilidad emocional
1876	39	E	10	5	0.50	Medio	Persona que presenta niveles equilibrados entre ser sumisa y dominante.	Sumiso / Dominante
1877	39	F	8	3	0.30	Bajo	Es prudente e instrospectiva. Reflexiva, presenta temor a cometer errores y tiene indecisión acerca de tomar riesgos.	Prudente / Impulsivo
1878	39	G	18	7	0.70	Alto	Esta dominada por el sentido del deber, perseverante, responsable y organizada. Es escrupulosa y moralista.	Despreocupado / Escrupuloso
1879	39	H	20	7	0.70	Alto	Suele ser tímida, muy retraída. Se muestra cohibida y con falta de confianza en si misma. Puede presentar sentimientos de inferioridad. Se retrae fácilmente ante el sexo apuesto.	Tímido / Espontáneo
1880	39	I	10	3	0.30	Bajo	Es dura sentimentalmente. Actúa más basada en evidencias prácticas y lógicas. Es confiada de sí misma, acepta resopnsabilidades.  Espera poco de las personas.	Racional / Emocional
1881	39	L	10	6	0.60	Medio	Presenta un nivel intermedio de confianza en las persona y en las situaciones.	Confiado / Suspicaz
1882	39	M	8	2	0.20	Bajo	Es una persona preocupada por intereses y hechos inmediatos. Se muestra ansiosa por hacer cosas correctamente. Antenta los problemas prácticos y cercanos.	Práctico / Soñador
1883	39	N	12	6	0.60	Medio	Puede ser sencilla e ingenua socialmente o calculadora en ocasiones.	Sencillo / Astuto
1884	39	O	4	4	0.40	Medio	Es una persona que puede mostrarse segura, tranquila, flexible y serena. Tiende a no culparse por sus acciones erradas, trata de actuar libremente sin temores, aunque en algunas ocasiones puede mostrar lo contrario.	Seguro / Inseguro
1885	39	Q1	9	4	0.40	Medio	Tiende a presentar interés por las nuevas ideas. Por lo general tiene actitudes de innovación y reacción ante lo establecido. Es poco convencionalista.	Tradicionalista / Innovador
1886	39	Q2	8	5	0.50	Medio	Tiende a ser autosuficiente e ingeniosa, llena de recursos, prefiere sus propias decisiones. Usualmente busca resolver los problemas por sí misma.	Dependencia del grupo / Autosuficiencia
1887	39	Q3	18	8	0.80	Alto	Tiene signos de perfeccionista, con alta congruencia en el autoconcepto percibido y el deseado. Alto nivel de autocontrol.	Desinhibido / Controlado
1888	39	Q4	6	5	0.50	Medio	Presenta intermedio entre el estado de tensión y de tranquilidad ante sí mismo y ante la situaciones.	Tranquilo / Tensionado
1889	53	A	10	8	0.80	Alto	Persona afectuosa, participativa y colaboradora . Prefiere trabajar en grupos.	Reservado / Abierto
1890	53	B	9	4	0.40	Medio	Es una persona de juicio intelectual intermedio, no tiene niveles altos en manejar relaciones en termino de como se sitúan las cosas,  sin embargo tampoco es bajo.	Concreto / Abstracto
1891	53	C	20	6	0.60	Medio	Es una persona que esta medianamente estable. El algunas ocasiones se puede mostrar inestable emocionalmente.	Inestabilidad Emocional / Estabilidad emocional
1892	53	E	12	5	0.50	Medio	Persona que presenta niveles equilibrados entre ser sumisa y dominante.	Sumiso / Dominante
1893	53	F	11	5	0.50	Medio	Es una persona con un nivel intermedio entre ser prudente y ser impulsiva.	Prudente / Impulsivo
1894	53	G	20	9	0.90	Alto	Esta dominada por el sentido del deber, perseverante, responsable y organizada. Es escrupulosa y moralista.	Despreocupado / Escrupuloso
1895	53	H	22	7	0.70	Alto	Suele ser tímida, muy retraída. Se muestra cohibida y con falta de confianza en si misma. Puede presentar sentimientos de inferioridad. Se retrae fácilmente ante el sexo apuesto.	Tímido / Espontáneo
1896	53	I	9	5	0.50	Medio	La persona actúa como igual facilidad entre las respuestas de pensamiento y sentimiento.	Racional / Emocional
1897	53	L	4	3	0.30	Bajo	Es una persona confiada, comprensiva, permisiva y tolerante. Cede ante los cambios, no parece preocupada por corregir a los demás. Se sobrepone con facilidad a las dificultades.	Confiado / Suspicaz
1898	53	M	13	6	0.60	Medio	Persona que esta guiada por realidades objetivas o en ocasiones puede ser imaginativa y abstraerse en su pensamientos.	Práctico / Soñador
1899	53	N	13	7	0.70	Alto	Es sumamente astuta, exacta y calculadora. Diplomática , calculadora,  se desenvuelve bien en grupo. Ambisiosa y perspicaz.	Sencillo / Astuto
1900	53	O	6	6	0.60	Medio	Es una persona que puede mostrarse segura, tranquila, flexible y serena. Tiende a no culparse por sus acciones erradas, trata de actuar libremente sin temores, aunque en algunas ocasiones puede mostrar lo contrario.	Seguro / Inseguro
1901	53	Q1	12	6	0.60	Medio	Tiende a presentar interés por las nuevas ideas. Por lo general tiene actitudes de innovación y reacción ante lo establecido. Es poco convencionalista.	Tradicionalista / Innovador
1902	53	Q2	6	4	0.40	Medio	Tiende a ser autosuficiente e ingeniosa, llena de recursos, prefiere sus propias decisiones. Usualmente busca resolver los problemas por sí misma.	Dependencia del grupo / Autosuficiencia
1903	53	Q3	13	3	0.30	Bajo	Da poca importancia a como la perciben los demás y suele hacer lo que desea. Tiene poco autocontrol. Mantiente poca congruencia entre su autoconcepto percibido y deseado.	Desinhibido / Controlado
1904	53	Q4	2	4	0.40	Medio	Presenta intermedio entre el estado de tensión y de tranquilidad ante sí mismo y ante la situaciones.	Tranquilo / Tensionado
1905	52	A	11	8	0.80	Alto	Persona afectuosa, participativa y colaboradora . Prefiere trabajar en grupos.	Reservado / Abierto
1906	52	B	4	4	0.40	Medio	Es una persona de juicio intelectual intermedio, no tiene niveles altos en manejar relaciones en termino de como se sitúan las cosas,  sin embargo tampoco es bajo.	Concreto / Abstracto
1907	52	C	21	7	0.70	Alto	Es una persona emocionalmente estable, madura y realista.  No deja que sus necesidades emocionales afecten la realidad de las situaciones.	Inestabilidad Emocional / Estabilidad emocional
1908	52	E	8	3	0.30	Bajo	La persona es sumisa, cede fácilmente ante los demás, es dócil y conformista. Es modesta, humilde y obediente.	Sumiso / Dominante
1909	52	F	14	6	0.60	Medio	Es una persona con un nivel intermedio entre ser prudente y ser impulsiva.	Prudente / Impulsivo
1910	52	G	14	5	0.50	Medio	Presenta un nivel intermedio en su nivel de responsabilidad y en aceptar las normas sociales.	Despreocupado / Escrupuloso
1911	52	H	20	7	0.70	Alto	Suele ser tímida, muy retraída. Se muestra cohibida y con falta de confianza en si misma. Puede presentar sentimientos de inferioridad. Se retrae fácilmente ante el sexo apuesto.	Tímido / Espontáneo
1912	52	I	14	5	0.50	Medio	La persona actúa como igual facilidad entre las respuestas de pensamiento y sentimiento.	Racional / Emocional
1913	52	L	6	4	0.40	Medio	Presenta un nivel intermedio de confianza en las persona y en las situaciones.	Confiado / Suspicaz
1914	52	M	11	4	0.40	Medio	Persona que esta guiada por realidades objetivas o en ocasiones puede ser imaginativa y abstraerse en su pensamientos.	Práctico / Soñador
1915	52	N	10	5	0.50	Medio	Puede ser sencilla e ingenua socialmente o calculadora en ocasiones.	Sencillo / Astuto
1916	52	O	6	5	0.50	Medio	Es una persona que puede mostrarse segura, tranquila, flexible y serena. Tiende a no culparse por sus acciones erradas, trata de actuar libremente sin temores, aunque en algunas ocasiones puede mostrar lo contrario.	Seguro / Inseguro
1917	52	Q1	10	5	0.50	Medio	Tiende a presentar interés por las nuevas ideas. Por lo general tiene actitudes de innovación y reacción ante lo establecido. Es poco convencionalista.	Tradicionalista / Innovador
1918	52	Q2	8	5	0.50	Medio	Tiende a ser autosuficiente e ingeniosa, llena de recursos, prefiere sus propias decisiones. Usualmente busca resolver los problemas por sí misma.	Dependencia del grupo / Autosuficiencia
1919	52	Q3	7	1	0.10	Bajo	Da poca importancia a como la perciben los demás y suele hacer lo que desea. Tiene poco autocontrol. Mantiente poca congruencia entre su autoconcepto percibido y deseado.	Desinhibido / Controlado
1920	52	Q4	7	5	0.50	Medio	Presenta intermedio entre el estado de tensión y de tranquilidad ante sí mismo y ante la situaciones.	Tranquilo / Tensionado
1937	54	A	7	8	0.80	Alto	Persona afectuosa, participativa y colaboradora . Prefiere trabajar en grupos.	Reservado / Abierto
1938	54	B	7	4	0.40	Medio	Es una persona de juicio intelectual intermedio, no tiene niveles altos en manejar relaciones en termino de como se sitúan las cosas,  sin embargo tampoco es bajo.	Concreto / Abstracto
1939	54	C	22	6	0.60	Medio	Es una persona que esta medianamente estable. El algunas ocasiones se puede mostrar inestable emocionalmente.	Inestabilidad Emocional / Estabilidad emocional
1940	54	E	16	7	0.70	Alto	Es una persona dominante, le gusta controlar las situaciones y las personas.	Sumiso / Dominante
1941	54	F	14	6	0.60	Medio	Es una persona con un nivel intermedio entre ser prudente y ser impulsiva.	Prudente / Impulsivo
1942	54	G	12	3	0.30	Bajo	La persona suele ser inestable en sus propósitos. Demuestra alta despreocupación y muy poca consideración por las normas de la sociedad.	Despreocupado / Escrupuloso
1943	54	H	21	7	0.70	Alto	Suele ser tímida, muy retraída. Se muestra cohibida y con falta de confianza en si misma. Puede presentar sentimientos de inferioridad. Se retrae fácilmente ante el sexo apuesto.	Tímido / Espontáneo
1944	54	I	6	3	0.30	Bajo	Es dura sentimentalmente. Actúa más basada en evidencias prácticas y lógicas. Es confiada de sí misma, acepta resopnsabilidades.  Espera poco de las personas.	Racional / Emocional
1945	54	L	5	4	0.40	Medio	Presenta un nivel intermedio de confianza en las persona y en las situaciones.	Confiado / Suspicaz
1946	54	M	15	7	0.70	Alto	Persona muy imaginativa, se abstrae mucho en sus pensamientos. Se entusiasma rápidamente, cambia y abandona las ideas bruscamente.	Práctico / Soñador
1947	54	N	12	6	0.60	Medio	Puede ser sencilla e ingenua socialmente o calculadora en ocasiones.	Sencillo / Astuto
1948	54	O	2	4	0.40	Medio	Es una persona que puede mostrarse segura, tranquila, flexible y serena. Tiende a no culparse por sus acciones erradas, trata de actuar libremente sin temores, aunque en algunas ocasiones puede mostrar lo contrario.	Seguro / Inseguro
1949	54	Q1	8	4	0.40	Medio	Tiende a presentar interés por las nuevas ideas. Por lo general tiene actitudes de innovación y reacción ante lo establecido. Es poco convencionalista.	Tradicionalista / Innovador
1950	54	Q2	11	7	0.70	Alto	Es autosuficiente, ingeniosa y llena de recursos, prefiere las propias decisiones. Busca resolver problemas por sí misma.	Dependencia del grupo / Autosuficiencia
1951	54	Q3	17	6	0.60	Medio	Tiene un nivel intermedio entre el autocontrol y la congruencia entre su autoconcepto percibido y deseados, de acuerdo con su cultura.	Desinhibido / Controlado
1952	54	Q4	7	7	0.70	Alto	Es una persona con características de estar tensa, excitable e intranquila. Puede presentar bloqueos de ansiedad.	Tranquilo / Tensionado
1953	46	A	16	8	0.80	Alto	Persona afectuosa, participativa y colaboradora . Prefiere trabajar en grupos.	Reservado / Abierto
1954	46	B	8	4	0.40	Medio	Es una persona de juicio intelectual intermedio, no tiene niveles altos en manejar relaciones en termino de como se sitúan las cosas,  sin embargo tampoco es bajo.	Concreto / Abstracto
1955	46	C	24	8	0.80	Alto	Es una persona emocionalmente estable, madura y realista.  No deja que sus necesidades emocionales afecten la realidad de las situaciones.	Inestabilidad Emocional / Estabilidad emocional
1956	46	E	14	7	0.70	Alto	Es una persona dominante, le gusta controlar las situaciones y las personas.	Sumiso / Dominante
1957	46	F	17	7	0.70	Alto	Es una persona impulsiva. Demasiado franca.  Responde con rapidez a los eventos que sean de su interés.	Prudente / Impulsivo
1958	46	G	14	5	0.50	Medio	Presenta un nivel intermedio en su nivel de responsabilidad y en aceptar las normas sociales.	Despreocupado / Escrupuloso
1959	46	H	22	8	0.80	Alto	Suele ser tímida, muy retraída. Se muestra cohibida y con falta de confianza en si misma. Puede presentar sentimientos de inferioridad. Se retrae fácilmente ante el sexo apuesto.	Tímido / Espontáneo
1960	46	I	16	6	0.60	Medio	La persona actúa como igual facilidad entre las respuestas de pensamiento y sentimiento.	Racional / Emocional
1961	46	L	6	4	0.40	Medio	Presenta un nivel intermedio de confianza en las persona y en las situaciones.	Confiado / Suspicaz
1962	46	M	14	6	0.60	Medio	Persona que esta guiada por realidades objetivas o en ocasiones puede ser imaginativa y abstraerse en su pensamientos.	Práctico / Soñador
1963	46	N	8	3	0.30	Bajo	Es sencilla, natrual y poco sofisticada. Se le satisface y se muestra contenta con lo que acontece, es sincera e ingenua.	Sencillo / Astuto
1964	46	O	2	3	0.30	Bajo	Persona segura, tranquila, flexible y serana. Nio le preocupa la aprobación de los demás. No se culpa por acciones erradas, actúa libremente sin temores.	Seguro / Inseguro
1965	46	Q1	7	3	0.30	Bajo	Es conservadora, respetuosa de las ideas establecidas, tolerante de los defectos tradicionales. Es precavida y resistente a las nuevas ideas, postone los cambios, sigue la línea tradicional es convencionalista.	Tradicionalista / Innovador
1966	46	Q2	10	6	0.60	Medio	Tiende a ser autosuficiente e ingeniosa, llena de recursos, prefiere sus propias decisiones. Usualmente busca resolver los problemas por sí misma.	Dependencia del grupo / Autosuficiencia
1967	46	Q3	15	6	0.60	Medio	Tiene un nivel intermedio entre el autocontrol y la congruencia entre su autoconcepto percibido y deseados, de acuerdo con su cultura.	Desinhibido / Controlado
1968	46	Q4	0	3	0.30	Bajo	Es una persona callada, relajada, tranquila. Es algunas situaciones su estado de mucha satisfacción le puede llevar a la pereza y al bajo rendimiento.	Tranquilo / Tensionado
1969	45	A	11	8	0.80	Alto	Persona afectuosa, participativa y colaboradora . Prefiere trabajar en grupos.	Reservado / Abierto
1970	45	B	6	4	0.40	Medio	Es una persona de juicio intelectual intermedio, no tiene niveles altos en manejar relaciones en termino de como se sitúan las cosas,  sin embargo tampoco es bajo.	Concreto / Abstracto
1971	45	C	17	7	0.70	Alto	Es una persona emocionalmente estable, madura y realista.  No deja que sus necesidades emocionales afecten la realidad de las situaciones.	Inestabilidad Emocional / Estabilidad emocional
1972	45	E	10	5	0.50	Medio	Persona que presenta niveles equilibrados entre ser sumisa y dominante.	Sumiso / Dominante
1973	45	F	10	4	0.40	Medio	Es una persona con un nivel intermedio entre ser prudente y ser impulsiva.	Prudente / Impulsivo
1974	45	G	17	7	0.70	Alto	Esta dominada por el sentido del deber, perseverante, responsable y organizada. Es escrupulosa y moralista.	Despreocupado / Escrupuloso
1975	45	H	12	5	0.50	Medio	Es una persona con disposición a ser sociable y espontánea. Dispuesta en algunas ocasiones a ser atrevida e intentar nuevas cosas.	Tímido / Espontáneo
1976	45	I	9	3	0.30	Bajo	Es dura sentimentalmente. Actúa más basada en evidencias prácticas y lógicas. Es confiada de sí misma, acepta resopnsabilidades.  Espera poco de las personas.	Racional / Emocional
1977	45	L	3	1	0.10	Bajo	Es una persona confiada, comprensiva, permisiva y tolerante. Cede ante los cambios, no parece preocupada por corregir a los demás. Se sobrepone con facilidad a las dificultades.	Confiado / Suspicaz
1978	45	M	13	5	0.50	Medio	Persona que esta guiada por realidades objetivas o en ocasiones puede ser imaginativa y abstraerse en su pensamientos.	Práctico / Soñador
1979	45	N	10	5	0.50	Medio	Puede ser sencilla e ingenua socialmente o calculadora en ocasiones.	Sencillo / Astuto
1980	45	O	7	4	0.40	Medio	Es una persona que puede mostrarse segura, tranquila, flexible y serena. Tiende a no culparse por sus acciones erradas, trata de actuar libremente sin temores, aunque en algunas ocasiones puede mostrar lo contrario.	Seguro / Inseguro
1981	45	Q1	10	5	0.50	Medio	Tiende a presentar interés por las nuevas ideas. Por lo general tiene actitudes de innovación y reacción ante lo establecido. Es poco convencionalista.	Tradicionalista / Innovador
1982	45	Q2	11	6	0.60	Medio	Tiende a ser autosuficiente e ingeniosa, llena de recursos, prefiere sus propias decisiones. Usualmente busca resolver los problemas por sí misma.	Dependencia del grupo / Autosuficiencia
1983	45	Q3	15	8	0.80	Alto	Tiene signos de perfeccionista, con alta congruencia en el autoconcepto percibido y el deseado. Alto nivel de autocontrol.	Desinhibido / Controlado
1984	45	Q4	8	4	0.40	Medio	Presenta intermedio entre el estado de tensión y de tranquilidad ante sí mismo y ante la situaciones.	Tranquilo / Tensionado
1985	50	A	18	8	0.80	Alto	Persona afectuosa, participativa y colaboradora . Prefiere trabajar en grupos.	Reservado / Abierto
1986	50	B	9	4	0.40	Medio	Es una persona de juicio intelectual intermedio, no tiene niveles altos en manejar relaciones en termino de como se sitúan las cosas,  sin embargo tampoco es bajo.	Concreto / Abstracto
1987	50	C	21	7	0.70	Alto	Es una persona emocionalmente estable, madura y realista.  No deja que sus necesidades emocionales afecten la realidad de las situaciones.	Inestabilidad Emocional / Estabilidad emocional
1988	50	E	7	3	0.30	Bajo	La persona es sumisa, cede fácilmente ante los demás, es dócil y conformista. Es modesta, humilde y obediente.	Sumiso / Dominante
1989	50	F	12	5	0.50	Medio	Es una persona con un nivel intermedio entre ser prudente y ser impulsiva.	Prudente / Impulsivo
1990	50	G	18	7	0.70	Alto	Esta dominada por el sentido del deber, perseverante, responsable y organizada. Es escrupulosa y moralista.	Despreocupado / Escrupuloso
1991	50	H	21	8	0.80	Alto	Suele ser tímida, muy retraída. Se muestra cohibida y con falta de confianza en si misma. Puede presentar sentimientos de inferioridad. Se retrae fácilmente ante el sexo apuesto.	Tímido / Espontáneo
1992	50	I	16	6	0.60	Medio	La persona actúa como igual facilidad entre las respuestas de pensamiento y sentimiento.	Racional / Emocional
1993	50	L	4	3	0.30	Bajo	Es una persona confiada, comprensiva, permisiva y tolerante. Cede ante los cambios, no parece preocupada por corregir a los demás. Se sobrepone con facilidad a las dificultades.	Confiado / Suspicaz
1994	50	M	11	4	0.40	Medio	Persona que esta guiada por realidades objetivas o en ocasiones puede ser imaginativa y abstraerse en su pensamientos.	Práctico / Soñador
1995	50	N	12	6	0.60	Medio	Puede ser sencilla e ingenua socialmente o calculadora en ocasiones.	Sencillo / Astuto
1996	50	O	5	4	0.40	Medio	Es una persona que puede mostrarse segura, tranquila, flexible y serena. Tiende a no culparse por sus acciones erradas, trata de actuar libremente sin temores, aunque en algunas ocasiones puede mostrar lo contrario.	Seguro / Inseguro
1997	50	Q1	8	4	0.40	Medio	Tiende a presentar interés por las nuevas ideas. Por lo general tiene actitudes de innovación y reacción ante lo establecido. Es poco convencionalista.	Tradicionalista / Innovador
1998	50	Q2	10	6	0.60	Medio	Tiende a ser autosuficiente e ingeniosa, llena de recursos, prefiere sus propias decisiones. Usualmente busca resolver los problemas por sí misma.	Dependencia del grupo / Autosuficiencia
1999	50	Q3	17	7	0.70	Alto	Tiene signos de perfeccionista, con alta congruencia en el autoconcepto percibido y el deseado. Alto nivel de autocontrol.	Desinhibido / Controlado
2000	50	Q4	6	5	0.50	Medio	Presenta intermedio entre el estado de tensión y de tranquilidad ante sí mismo y ante la situaciones.	Tranquilo / Tensionado
\.


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: pruebas16pf; Owner: ats_n8n
--

COPY pruebas16pf.usuarios (id, nombre, correo, contrasena, rol, creado_en, activo) FROM stdin;
3	Maria Alejandra González Arias 	atracciondetalentos@susuerte.com	$2b$10$Lu3gm27MyFr1fSUGF7jM2eOMswRzkQkMbha8wK/mS/qztICsAWlDS	admin	2025-09-26 14:45:01.813058	t
2	Natalia Toro	natalia.toro@susuerte.com	$2b$10$K0t0V6jJQRcQW7nNdywcKeEGloz2wGYX0IXcCDgV1htY8MpJAUNIK	admin	2025-09-01 13:58:50.543732	t
4	Lina María Gutiérrez Muñoz 	lina.gutierrez@susuerte.com	$2b$10$1nkmvgBsBJR0Q7mFSJB8pe1UViHXZ3/2fwmfcjPgcWcPvIeXD2O6W	admin	2025-09-29 20:54:51.252505	t
5	Estefanía Muñoz Puentes	practicante.gestionhumana@susuerte.com	$2b$10$dC4S0EZDBn9ZWP/c5hlSyuxOWR.Joa.JkZWzb4TfAFS4nLQKL4HE.	admin	2025-09-30 15:22:40.746549	t
1	Adrian Camilo Ledezma	adrian.ledezma@susuerte.com	$2b$10$YMhViD14ieyfhTPhoZwFpeT1Yh1xQTwPQ4vPSKBlYG6IHNOVdk13u	admin	2025-08-28 15:41:49.904599	t
\.


--
-- Data for Name: usuarios_aspirantes; Type: TABLE DATA; Schema: pruebas16pf; Owner: ats_n8n
--

COPY pruebas16pf.usuarios_aspirantes (id, usuario_id, aspirante_id, creado_en) FROM stdin;
1	2	35	2025-09-30 19:14:30.60862
2	3	35	2025-09-30 19:15:16.098853
3	2	20	2025-09-30 16:00:49.378604
4	3	20	2025-09-30 16:01:05.505075
5	2	18	2025-09-30 16:01:25.982175
6	3	18	2025-09-30 16:01:31.596641
7	2	17	2025-09-30 16:01:54.231301
8	3	17	2025-09-30 16:01:58.319812
9	2	16	2025-09-30 16:02:09.869747
10	3	16	2025-09-30 16:02:16.314538
11	2	15	2025-09-30 16:06:04.762191
12	3	15	2025-09-30 16:06:08.630048
14	2	34	2025-09-30 16:08:32.280151
15	3	34	2025-09-30 16:08:36.025451
16	2	33	2025-09-30 16:08:53.388928
17	3	33	2025-09-30 16:08:57.119071
18	2	32	2025-09-30 16:09:09.308535
19	3	32	2025-09-30 16:09:13.426597
20	2	31	2025-09-30 16:09:27.322675
21	3	31	2025-09-30 16:09:31.298047
22	2	29	2025-09-30 16:09:43.87316
23	3	29	2025-09-30 16:09:47.410979
24	2	28	2025-09-30 16:09:55.545777
25	3	28	2025-09-30 16:10:00.279636
26	2	27	2025-09-30 16:10:12.924374
27	3	27	2025-09-30 16:10:16.383673
28	2	25	2025-09-30 16:10:28.052014
29	3	25	2025-09-30 16:10:32.164639
30	2	22	2025-09-30 16:10:43.7845
31	3	22	2025-09-30 16:10:47.515549
32	2	21	2025-09-30 16:11:00.310434
33	3	21	2025-09-30 16:11:03.623066
34	2	11	2025-09-30 16:11:19.311066
35	3	11	2025-09-30 16:11:22.845872
36	3	36	2025-09-30 22:22:55.729205
37	2	36	2025-09-30 22:22:55.729205
38	3	37	2025-10-01 13:20:06.899978
39	2	37	2025-10-01 13:20:06.899978
40	3	38	2025-10-01 13:21:21.452515
41	2	38	2025-10-01 13:21:21.452515
42	4	39	2025-10-01 13:34:12.937808
43	5	39	2025-10-01 13:34:12.937808
44	2	40	2025-10-01 13:39:35.192089
45	3	41	2025-10-01 17:33:10.407075
46	2	41	2025-10-01 17:33:10.407075
47	4	42	2025-10-01 17:33:18.372051
48	5	42	2025-10-01 17:33:18.372051
49	3	43	2025-10-01 17:33:36.785123
50	2	43	2025-10-01 17:33:36.785123
51	3	44	2025-10-01 17:34:08.507831
52	2	44	2025-10-01 17:34:08.507831
53	5	45	2025-10-02 13:19:54.199161
54	4	45	2025-10-02 13:19:54.199161
55	5	46	2025-10-02 13:22:59.67659
56	4	46	2025-10-02 13:22:59.67659
57	5	47	2025-10-02 13:24:09.346026
58	4	47	2025-10-02 13:24:09.346026
59	5	48	2025-10-02 13:25:04.009284
60	4	48	2025-10-02 13:25:04.009284
61	5	49	2025-10-02 13:26:28.846792
62	5	50	2025-10-02 13:28:03.617377
63	4	50	2025-10-02 13:28:03.617377
64	3	51	2025-10-02 13:48:03.016076
65	2	51	2025-10-02 13:48:03.016076
66	3	52	2025-10-02 16:12:54.386521
67	2	52	2025-10-02 16:12:54.386521
68	2	53	2025-10-02 20:41:15.619995
69	3	53	2025-10-02 20:41:15.619995
70	2	54	2025-10-02 21:05:06.431353
71	3	54	2025-10-02 21:05:06.431353
72	3	55	2025-10-02 21:07:57.018965
73	2	55	2025-10-02 21:07:57.018965
74	5	57	2025-10-02 21:59:11.568412
75	3	59	2025-10-03 14:37:32.444287
76	2	59	2025-10-03 14:37:32.444287
77	3	60	2025-10-03 15:53:59.696374
78	2	60	2025-10-03 15:53:59.696374
79	3	61	2025-10-03 15:54:23.639651
80	2	61	2025-10-03 15:54:23.639651
81	3	62	2025-10-03 15:54:45.017253
82	2	62	2025-10-03 15:54:45.017253
83	3	63	2025-10-03 15:55:07.591921
84	2	63	2025-10-03 15:55:07.591921
85	3	64	2025-10-03 15:55:31.040214
86	2	64	2025-10-03 15:55:31.040214
\.


--
-- Name: aspirantes_id_seq; Type: SEQUENCE SET; Schema: pruebas16pf; Owner: ats_n8n
--

SELECT pg_catalog.setval('pruebas16pf.aspirantes_id_seq', 64, true);


--
-- Name: baremos_16pf_id_seq; Type: SEQUENCE SET; Schema: pruebas16pf; Owner: ats_n8n
--

SELECT pg_catalog.setval('pruebas16pf.baremos_16pf_id_seq', 788, true);


--
-- Name: cargo_requisitos_id_seq; Type: SEQUENCE SET; Schema: pruebas16pf; Owner: ats_n8n
--

SELECT pg_catalog.setval('pruebas16pf.cargo_requisitos_id_seq', 59, true);


--
-- Name: cargos_id_seq; Type: SEQUENCE SET; Schema: pruebas16pf; Owner: ats_n8n
--

SELECT pg_catalog.setval('pruebas16pf.cargos_id_seq', 25, true);


--
-- Name: citas_agendadas_id_seq; Type: SEQUENCE SET; Schema: pruebas16pf; Owner: ats_n8n
--

SELECT pg_catalog.setval('pruebas16pf.citas_agendadas_id_seq', 1, false);


--
-- Name: clave_detalle_16pf_id_seq; Type: SEQUENCE SET; Schema: pruebas16pf; Owner: ats_n8n
--

SELECT pg_catalog.setval('pruebas16pf.clave_detalle_16pf_id_seq', 606, true);


--
-- Name: consumos_ia_id_seq; Type: SEQUENCE SET; Schema: pruebas16pf; Owner: ats_n8n
--

SELECT pg_catalog.setval('pruebas16pf.consumos_ia_id_seq', 65, true);


--
-- Name: horarios_disponibles_id_seq; Type: SEQUENCE SET; Schema: pruebas16pf; Owner: ats_n8n
--

SELECT pg_catalog.setval('pruebas16pf.horarios_disponibles_id_seq', 1, false);


--
-- Name: interpretaciones_16pf_id_seq; Type: SEQUENCE SET; Schema: pruebas16pf; Owner: ats_n8n
--

SELECT pg_catalog.setval('pruebas16pf.interpretaciones_16pf_id_seq', 48, true);


--
-- Name: interpretacions_ia_id_seq; Type: SEQUENCE SET; Schema: pruebas16pf; Owner: ats_n8n
--

SELECT pg_catalog.setval('pruebas16pf.interpretacions_ia_id_seq', 119, true);


--
-- Name: requisitos_id_seq; Type: SEQUENCE SET; Schema: pruebas16pf; Owner: ats_n8n
--

SELECT pg_catalog.setval('pruebas16pf.requisitos_id_seq', 31, true);


--
-- Name: respuestas_16pf_id_seq; Type: SEQUENCE SET; Schema: pruebas16pf; Owner: ats_n8n
--

SELECT pg_catalog.setval('pruebas16pf.respuestas_16pf_id_seq', 5645, true);


--
-- Name: resultados_16pf_id_seq; Type: SEQUENCE SET; Schema: pruebas16pf; Owner: ats_n8n
--

SELECT pg_catalog.setval('pruebas16pf.resultados_16pf_id_seq', 2000, true);


--
-- Name: usuarios_aspirantes_id_seq; Type: SEQUENCE SET; Schema: pruebas16pf; Owner: ats_n8n
--

SELECT pg_catalog.setval('pruebas16pf.usuarios_aspirantes_id_seq', 86, true);


--
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: pruebas16pf; Owner: ats_n8n
--

SELECT pg_catalog.setval('pruebas16pf.usuarios_id_seq', 5, true);


--
-- Name: aspirantes aspirantes_cedula_key; Type: CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.aspirantes
    ADD CONSTRAINT aspirantes_cedula_key UNIQUE (cedula);


--
-- Name: aspirantes aspirantes_pkey; Type: CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.aspirantes
    ADD CONSTRAINT aspirantes_pkey PRIMARY KEY (id);


--
-- Name: baremos_16pf baremos_16pf_pkey; Type: CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.baremos_16pf
    ADD CONSTRAINT baremos_16pf_pkey PRIMARY KEY (id);


--
-- Name: cargo_requisitos cargo_requisitos_cargo_id_requisito_id_key; Type: CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.cargo_requisitos
    ADD CONSTRAINT cargo_requisitos_cargo_id_requisito_id_key UNIQUE (cargo_id, requisito_id);


--
-- Name: cargo_requisitos cargo_requisitos_pkey; Type: CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.cargo_requisitos
    ADD CONSTRAINT cargo_requisitos_pkey PRIMARY KEY (id);


--
-- Name: cargos cargos_pkey; Type: CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.cargos
    ADD CONSTRAINT cargos_pkey PRIMARY KEY (id);


--
-- Name: citas_agendadas citas_agendadas_pkey; Type: CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.citas_agendadas
    ADD CONSTRAINT citas_agendadas_pkey PRIMARY KEY (id);


--
-- Name: citas_agendadas citas_agendadas_telefono_candidato_key; Type: CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.citas_agendadas
    ADD CONSTRAINT citas_agendadas_telefono_candidato_key UNIQUE (telefono_candidato);


--
-- Name: clave_detalle_16pf clave_detalle_16pf_pkey; Type: CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.clave_detalle_16pf
    ADD CONSTRAINT clave_detalle_16pf_pkey PRIMARY KEY (id);


--
-- Name: consumos_ia consumos_ia_pkey; Type: CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.consumos_ia
    ADD CONSTRAINT consumos_ia_pkey PRIMARY KEY (id);


--
-- Name: factores_16pf factores_16pf_pkey; Type: CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.factores_16pf
    ADD CONSTRAINT factores_16pf_pkey PRIMARY KEY (codigo);


--
-- Name: horarios_disponibles horarios_disponibles_fecha_hora_key; Type: CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.horarios_disponibles
    ADD CONSTRAINT horarios_disponibles_fecha_hora_key UNIQUE (fecha, hora);


--
-- Name: horarios_disponibles horarios_disponibles_pkey; Type: CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.horarios_disponibles
    ADD CONSTRAINT horarios_disponibles_pkey PRIMARY KEY (id);


--
-- Name: interpretaciones_16pf interpretaciones_16pf_factor_nivel_key; Type: CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.interpretaciones_16pf
    ADD CONSTRAINT interpretaciones_16pf_factor_nivel_key UNIQUE (factor, nivel);


--
-- Name: interpretaciones_16pf interpretaciones_16pf_pkey; Type: CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.interpretaciones_16pf
    ADD CONSTRAINT interpretaciones_16pf_pkey PRIMARY KEY (id);


--
-- Name: interpretaciones_ia interpretacions_ia_pkey; Type: CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.interpretaciones_ia
    ADD CONSTRAINT interpretacions_ia_pkey PRIMARY KEY (id);


--
-- Name: invitaciones_pendientes invitaciones_pendientes_pkey; Type: CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.invitaciones_pendientes
    ADD CONSTRAINT invitaciones_pendientes_pkey PRIMARY KEY (telefono_whatsapp);


--
-- Name: preguntas_16pf preguntas_16pf_pkey; Type: CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.preguntas_16pf
    ADD CONSTRAINT preguntas_16pf_pkey PRIMARY KEY (numero);


--
-- Name: reglas_decatipo_16pf reglas_decatipo_16pf_pkey; Type: CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.reglas_decatipo_16pf
    ADD CONSTRAINT reglas_decatipo_16pf_pkey PRIMARY KEY (factor_codigo);


--
-- Name: requisitos requisitos_pkey; Type: CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.requisitos
    ADD CONSTRAINT requisitos_pkey PRIMARY KEY (id);


--
-- Name: respuestas_16pf respuestas_16pf_aspirante_id_numero_pregunta_key; Type: CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.respuestas_16pf
    ADD CONSTRAINT respuestas_16pf_aspirante_id_numero_pregunta_key UNIQUE (aspirante_id, numero_pregunta);


--
-- Name: respuestas_16pf respuestas_16pf_pkey; Type: CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.respuestas_16pf
    ADD CONSTRAINT respuestas_16pf_pkey PRIMARY KEY (id);


--
-- Name: respuestas_16pf respuestas_16pf_unique; Type: CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.respuestas_16pf
    ADD CONSTRAINT respuestas_16pf_unique UNIQUE (aspirante_id, numero_pregunta);


--
-- Name: resultados_16pf resultados_16pf_aspirante_id_factor_key; Type: CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.resultados_16pf
    ADD CONSTRAINT resultados_16pf_aspirante_id_factor_key UNIQUE (aspirante_id, factor);


--
-- Name: resultados_16pf resultados_16pf_pkey; Type: CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.resultados_16pf
    ADD CONSTRAINT resultados_16pf_pkey PRIMARY KEY (id);


--
-- Name: resultados_16pf resultados_16pf_unique; Type: CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.resultados_16pf
    ADD CONSTRAINT resultados_16pf_unique UNIQUE (aspirante_id, factor);


--
-- Name: usuarios_aspirantes usuarios_aspirantes_pkey; Type: CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.usuarios_aspirantes
    ADD CONSTRAINT usuarios_aspirantes_pkey PRIMARY KEY (id);


--
-- Name: usuarios_aspirantes usuarios_aspirantes_usuario_id_aspirante_id_key; Type: CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.usuarios_aspirantes
    ADD CONSTRAINT usuarios_aspirantes_usuario_id_aspirante_id_key UNIQUE (usuario_id, aspirante_id);


--
-- Name: usuarios usuarios_correo_key; Type: CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.usuarios
    ADD CONSTRAINT usuarios_correo_key UNIQUE (correo);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- Name: ux_resultados_asp_factor; Type: INDEX; Schema: pruebas16pf; Owner: ats_n8n
--

CREATE UNIQUE INDEX ux_resultados_asp_factor ON pruebas16pf.resultados_16pf USING btree (aspirante_id, factor);


--
-- Name: aspirantes aspirantes_cargo_aplicado_fkey; Type: FK CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.aspirantes
    ADD CONSTRAINT aspirantes_cargo_aplicado_fkey FOREIGN KEY (cargo_aplicado) REFERENCES pruebas16pf.cargos(id) ON DELETE SET NULL;


--
-- Name: baremos_16pf baremos_16pf_factor_id_fkey; Type: FK CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.baremos_16pf
    ADD CONSTRAINT baremos_16pf_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES pruebas16pf.factores_16pf(codigo) ON DELETE CASCADE;


--
-- Name: cargo_requisitos cargo_requisitos_cargo_id_fkey; Type: FK CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.cargo_requisitos
    ADD CONSTRAINT cargo_requisitos_cargo_id_fkey FOREIGN KEY (cargo_id) REFERENCES pruebas16pf.cargos(id) ON DELETE CASCADE;


--
-- Name: cargo_requisitos cargo_requisitos_requisito_id_fkey; Type: FK CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.cargo_requisitos
    ADD CONSTRAINT cargo_requisitos_requisito_id_fkey FOREIGN KEY (requisito_id) REFERENCES pruebas16pf.requisitos(id) ON DELETE CASCADE;


--
-- Name: citas_agendadas citas_agendadas_horario_id_fkey; Type: FK CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.citas_agendadas
    ADD CONSTRAINT citas_agendadas_horario_id_fkey FOREIGN KEY (horario_id) REFERENCES pruebas16pf.horarios_disponibles(id) ON DELETE CASCADE;


--
-- Name: clave_detalle_16pf clave_detalle_16pf_factor_fkey; Type: FK CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.clave_detalle_16pf
    ADD CONSTRAINT clave_detalle_16pf_factor_fkey FOREIGN KEY (factor) REFERENCES pruebas16pf.factores_16pf(codigo) ON DELETE CASCADE;


--
-- Name: consumos_ia consumos_ia_interpretacion_id_fkey; Type: FK CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.consumos_ia
    ADD CONSTRAINT consumos_ia_interpretacion_id_fkey FOREIGN KEY (interpretacion_id) REFERENCES pruebas16pf.interpretaciones_ia(id) ON DELETE CASCADE;


--
-- Name: clave_detalle_16pf fk_pregunta; Type: FK CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.clave_detalle_16pf
    ADD CONSTRAINT fk_pregunta FOREIGN KEY (numero_pregunta) REFERENCES pruebas16pf.preguntas_16pf(numero);


--
-- Name: respuestas_16pf fk_pregunta_respuesta; Type: FK CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.respuestas_16pf
    ADD CONSTRAINT fk_pregunta_respuesta FOREIGN KEY (numero_pregunta) REFERENCES pruebas16pf.preguntas_16pf(numero);


--
-- Name: reglas_decatipo_16pf fk_reglas_factor; Type: FK CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.reglas_decatipo_16pf
    ADD CONSTRAINT fk_reglas_factor FOREIGN KEY (factor_codigo) REFERENCES pruebas16pf.factores_16pf(codigo);


--
-- Name: interpretaciones_16pf interpretaciones_16pf_factor_fkey; Type: FK CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.interpretaciones_16pf
    ADD CONSTRAINT interpretaciones_16pf_factor_fkey FOREIGN KEY (factor) REFERENCES pruebas16pf.factores_16pf(codigo) ON DELETE CASCADE;


--
-- Name: interpretaciones_ia interpretacions_ia_aspirante_id_fkey; Type: FK CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.interpretaciones_ia
    ADD CONSTRAINT interpretacions_ia_aspirante_id_fkey FOREIGN KEY (aspirante_id) REFERENCES pruebas16pf.aspirantes(id) ON DELETE CASCADE;


--
-- Name: respuestas_16pf respuestas_16pf_aspirante_id_fkey; Type: FK CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.respuestas_16pf
    ADD CONSTRAINT respuestas_16pf_aspirante_id_fkey FOREIGN KEY (aspirante_id) REFERENCES pruebas16pf.aspirantes(id) ON DELETE CASCADE;


--
-- Name: resultados_16pf resultados_16pf_aspirante_id_fkey; Type: FK CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.resultados_16pf
    ADD CONSTRAINT resultados_16pf_aspirante_id_fkey FOREIGN KEY (aspirante_id) REFERENCES pruebas16pf.aspirantes(id) ON DELETE CASCADE;


--
-- Name: resultados_16pf resultados_16pf_factor_fkey; Type: FK CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.resultados_16pf
    ADD CONSTRAINT resultados_16pf_factor_fkey FOREIGN KEY (factor) REFERENCES pruebas16pf.factores_16pf(codigo);


--
-- Name: usuarios_aspirantes usuarios_aspirantes_aspirante_id_fkey; Type: FK CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.usuarios_aspirantes
    ADD CONSTRAINT usuarios_aspirantes_aspirante_id_fkey FOREIGN KEY (aspirante_id) REFERENCES pruebas16pf.aspirantes(id) ON DELETE CASCADE;


--
-- Name: usuarios_aspirantes usuarios_aspirantes_usuario_id_fkey; Type: FK CONSTRAINT; Schema: pruebas16pf; Owner: ats_n8n
--

ALTER TABLE ONLY pruebas16pf.usuarios_aspirantes
    ADD CONSTRAINT usuarios_aspirantes_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES pruebas16pf.usuarios(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict 8XyGHpfbsd6eGxgSYM6Ufwu0GHpHYuXs4asmQU4rX1gYm9nw2r4H0912kvT53Qk

