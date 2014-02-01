--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: data_types; Type: TABLE; Schema: public; Owner: jfoucault; Tablespace: 
--

CREATE TABLE data_types (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public.data_types OWNER TO jfoucault;

--
-- Name: data_types_id_seq; Type: SEQUENCE; Schema: public; Owner: jfoucault
--

CREATE SEQUENCE data_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data_types_id_seq OWNER TO jfoucault;

--
-- Name: data_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jfoucault
--

ALTER SEQUENCE data_types_id_seq OWNED BY data_types.id;


--
-- Name: modulations; Type: TABLE; Schema: public; Owner: jfoucault; Tablespace: 
--

CREATE TABLE modulations (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public.modulations OWNER TO jfoucault;

--
-- Name: modulations_id_seq; Type: SEQUENCE; Schema: public; Owner: jfoucault
--

CREATE SEQUENCE modulations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.modulations_id_seq OWNER TO jfoucault;

--
-- Name: modulations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jfoucault
--

ALTER SEQUENCE modulations_id_seq OWNED BY modulations.id;


--
-- Name: rooms; Type: TABLE; Schema: public; Owner: jfoucault; Tablespace: 
--

CREATE TABLE rooms (
    id integer NOT NULL,
    name character varying(255),
    surface integer
);


ALTER TABLE public.rooms OWNER TO jfoucault;

--
-- Name: rooms_id_seq; Type: SEQUENCE; Schema: public; Owner: jfoucault
--

CREATE SEQUENCE rooms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rooms_id_seq OWNER TO jfoucault;

--
-- Name: rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jfoucault
--

ALTER SEQUENCE rooms_id_seq OWNED BY rooms.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: jfoucault; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO jfoucault;

--
-- Name: sensor_data; Type: TABLE; Schema: public; Owner: jfoucault; Tablespace: 
--

CREATE TABLE sensor_data (
    id integer NOT NULL,
    value double precision,
    sensor_id integer,
    data_type_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.sensor_data OWNER TO jfoucault;

--
-- Name: sensor_data_id_seq; Type: SEQUENCE; Schema: public; Owner: jfoucault
--

CREATE SEQUENCE sensor_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sensor_data_id_seq OWNER TO jfoucault;

--
-- Name: sensor_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jfoucault
--

ALTER SEQUENCE sensor_data_id_seq OWNED BY sensor_data.id;


--
-- Name: sensors; Type: TABLE; Schema: public; Owner: jfoucault; Tablespace: 
--

CREATE TABLE sensors (
    id integer NOT NULL,
    frequency double precision,
    name character varying(255),
    modulation_id integer,
    room_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.sensors OWNER TO jfoucault;

--
-- Name: sensors_data_types; Type: TABLE; Schema: public; Owner: jfoucault; Tablespace: 
--

CREATE TABLE sensors_data_types (
    sensor_id integer,
    data_type_id integer
);


ALTER TABLE public.sensors_data_types OWNER TO jfoucault;

--
-- Name: sensors_id_seq; Type: SEQUENCE; Schema: public; Owner: jfoucault
--

CREATE SEQUENCE sensors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sensors_id_seq OWNER TO jfoucault;

--
-- Name: sensors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jfoucault
--

ALTER SEQUENCE sensors_id_seq OWNED BY sensors.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jfoucault
--

ALTER TABLE ONLY data_types ALTER COLUMN id SET DEFAULT nextval('data_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jfoucault
--

ALTER TABLE ONLY modulations ALTER COLUMN id SET DEFAULT nextval('modulations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jfoucault
--

ALTER TABLE ONLY rooms ALTER COLUMN id SET DEFAULT nextval('rooms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jfoucault
--

ALTER TABLE ONLY sensor_data ALTER COLUMN id SET DEFAULT nextval('sensor_data_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jfoucault
--

ALTER TABLE ONLY sensors ALTER COLUMN id SET DEFAULT nextval('sensors_id_seq'::regclass);


--
-- Data for Name: data_types; Type: TABLE DATA; Schema: public; Owner: jfoucault
--

COPY data_types (id, name) FROM stdin;
\.


--
-- Name: data_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jfoucault
--

SELECT pg_catalog.setval('data_types_id_seq', 1, false);


--
-- Data for Name: modulations; Type: TABLE DATA; Schema: public; Owner: jfoucault
--

COPY modulations (id, name) FROM stdin;
\.


--
-- Name: modulations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jfoucault
--

SELECT pg_catalog.setval('modulations_id_seq', 1, false);


--
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: jfoucault
--

COPY rooms (id, name, surface) FROM stdin;
\.


--
-- Name: rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jfoucault
--

SELECT pg_catalog.setval('rooms_id_seq', 1, false);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: jfoucault
--

COPY schema_migrations (version) FROM stdin;
20140127175423
20140127175443
20140127175636
20140127175815
20140127175849
20140127180006
\.


--
-- Data for Name: sensor_data; Type: TABLE DATA; Schema: public; Owner: jfoucault
--

COPY sensor_data (id, value, sensor_id, data_type_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: sensor_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jfoucault
--

SELECT pg_catalog.setval('sensor_data_id_seq', 1, false);


--
-- Data for Name: sensors; Type: TABLE DATA; Schema: public; Owner: jfoucault
--

COPY sensors (id, frequency, name, modulation_id, room_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sensors_data_types; Type: TABLE DATA; Schema: public; Owner: jfoucault
--

COPY sensors_data_types (sensor_id, data_type_id) FROM stdin;
\.


--
-- Name: sensors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jfoucault
--

SELECT pg_catalog.setval('sensors_id_seq', 1, false);


--
-- Name: data_types_pkey; Type: CONSTRAINT; Schema: public; Owner: jfoucault; Tablespace: 
--

ALTER TABLE ONLY data_types
    ADD CONSTRAINT data_types_pkey PRIMARY KEY (id);


--
-- Name: modulations_pkey; Type: CONSTRAINT; Schema: public; Owner: jfoucault; Tablespace: 
--

ALTER TABLE ONLY modulations
    ADD CONSTRAINT modulations_pkey PRIMARY KEY (id);


--
-- Name: rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: jfoucault; Tablespace: 
--

ALTER TABLE ONLY rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);


--
-- Name: sensor_data_pkey; Type: CONSTRAINT; Schema: public; Owner: jfoucault; Tablespace: 
--

ALTER TABLE ONLY sensor_data
    ADD CONSTRAINT sensor_data_pkey PRIMARY KEY (id);


--
-- Name: sensors_pkey; Type: CONSTRAINT; Schema: public; Owner: jfoucault; Tablespace: 
--

ALTER TABLE ONLY sensors
    ADD CONSTRAINT sensors_pkey PRIMARY KEY (id);


--
-- Name: index_sensor_data_on_data_type_id; Type: INDEX; Schema: public; Owner: jfoucault; Tablespace: 
--

CREATE INDEX index_sensor_data_on_data_type_id ON sensor_data USING btree (data_type_id);


--
-- Name: index_sensor_data_on_sensor_id; Type: INDEX; Schema: public; Owner: jfoucault; Tablespace: 
--

CREATE INDEX index_sensor_data_on_sensor_id ON sensor_data USING btree (sensor_id);


--
-- Name: index_sensors_data_types_on_sensor_id_and_data_type_id; Type: INDEX; Schema: public; Owner: jfoucault; Tablespace: 
--

CREATE INDEX index_sensors_data_types_on_sensor_id_and_data_type_id ON sensors_data_types USING btree (sensor_id, data_type_id);


--
-- Name: index_sensors_on_modulation_id; Type: INDEX; Schema: public; Owner: jfoucault; Tablespace: 
--

CREATE INDEX index_sensors_on_modulation_id ON sensors USING btree (modulation_id);


--
-- Name: index_sensors_on_room_id; Type: INDEX; Schema: public; Owner: jfoucault; Tablespace: 
--

CREATE INDEX index_sensors_on_room_id ON sensors USING btree (room_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: jfoucault; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: public; Type: ACL; Schema: -; Owner: Jeremie
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM "Jeremie";
GRANT ALL ON SCHEMA public TO "Jeremie";
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

