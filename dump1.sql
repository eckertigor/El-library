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
-- Name: auth_group; Type: TABLE; Schema: public; Owner: el_library; Tablespace: 
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO el_library;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: el_library
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO el_library;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: el_library
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: el_library; Tablespace: 
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO el_library;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: el_library
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO el_library;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: el_library
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: el_library; Tablespace: 
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO el_library;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: el_library
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO el_library;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: el_library
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: el_library; Tablespace: 
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO el_library;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: el_library; Tablespace: 
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO el_library;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: el_library
--

CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO el_library;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: el_library
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: el_library
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO el_library;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: el_library
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: el_library; Tablespace: 
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO el_library;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: el_library
--

CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO el_library;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: el_library
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: el_library; Tablespace: 
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO el_library;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: el_library
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO el_library;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: el_library
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: el_library; Tablespace: 
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO el_library;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: el_library
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO el_library;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: el_library
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: el_library; Tablespace: 
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO el_library;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: el_library
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO el_library;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: el_library
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: el_library; Tablespace: 
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO el_library;

--
-- Name: el_library_access; Type: TABLE; Schema: public; Owner: el_library; Tablespace: 
--

CREATE TABLE el_library_access (
    id integer NOT NULL,
    name character varying(25) NOT NULL,
    access_level integer NOT NULL,
    is_deleted integer NOT NULL
);


ALTER TABLE public.el_library_access OWNER TO el_library;

--
-- Name: el_library_access_id_seq; Type: SEQUENCE; Schema: public; Owner: el_library
--

CREATE SEQUENCE el_library_access_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.el_library_access_id_seq OWNER TO el_library;

--
-- Name: el_library_access_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: el_library
--

ALTER SEQUENCE el_library_access_id_seq OWNED BY el_library_access.id;


--
-- Name: el_library_access_users; Type: TABLE; Schema: public; Owner: el_library; Tablespace: 
--

CREATE TABLE el_library_access_users (
    id integer NOT NULL,
    access_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.el_library_access_users OWNER TO el_library;

--
-- Name: el_library_access_users_id_seq; Type: SEQUENCE; Schema: public; Owner: el_library
--

CREATE SEQUENCE el_library_access_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.el_library_access_users_id_seq OWNER TO el_library;

--
-- Name: el_library_access_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: el_library
--

ALTER SEQUENCE el_library_access_users_id_seq OWNED BY el_library_access_users.id;


--
-- Name: el_library_collection; Type: TABLE; Schema: public; Owner: el_library; Tablespace: 
--

CREATE TABLE el_library_collection (
    id integer NOT NULL,
    title character varying(50) NOT NULL,
    is_deleted integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.el_library_collection OWNER TO el_library;

--
-- Name: el_library_collection_id_seq; Type: SEQUENCE; Schema: public; Owner: el_library
--

CREATE SEQUENCE el_library_collection_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.el_library_collection_id_seq OWNER TO el_library;

--
-- Name: el_library_collection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: el_library
--

ALTER SEQUENCE el_library_collection_id_seq OWNED BY el_library_collection.id;


--
-- Name: el_library_collection_materials; Type: TABLE; Schema: public; Owner: el_library; Tablespace: 
--

CREATE TABLE el_library_collection_materials (
    id integer NOT NULL,
    collection_id integer NOT NULL,
    material_id integer NOT NULL
);


ALTER TABLE public.el_library_collection_materials OWNER TO el_library;

--
-- Name: el_library_collection_materials_id_seq; Type: SEQUENCE; Schema: public; Owner: el_library
--

CREATE SEQUENCE el_library_collection_materials_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.el_library_collection_materials_id_seq OWNER TO el_library;

--
-- Name: el_library_collection_materials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: el_library
--

ALTER SEQUENCE el_library_collection_materials_id_seq OWNED BY el_library_collection_materials.id;


--
-- Name: el_library_material; Type: TABLE; Schema: public; Owner: el_library; Tablespace: 
--

CREATE TABLE el_library_material (
    id integer NOT NULL,
    title character varying(100) NOT NULL,
    author character varying(100) NOT NULL,
    description character varying(2000) NOT NULL,
    rating double precision NOT NULL,
    type_material character varying(20) NOT NULL,
    isbn bigint,
    rubrik_id integer,
    document character varying(100) NOT NULL,
    is_approved integer NOT NULL,
    user_id integer NOT NULL,
    is_deleted integer NOT NULL,
    is_app_changed integer NOT NULL,
    group_id integer
);


ALTER TABLE public.el_library_material OWNER TO el_library;

--
-- Name: el_library_material_id_seq; Type: SEQUENCE; Schema: public; Owner: el_library
--

CREATE SEQUENCE el_library_material_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.el_library_material_id_seq OWNER TO el_library;

--
-- Name: el_library_material_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: el_library
--

ALTER SEQUENCE el_library_material_id_seq OWNED BY el_library_material.id;


--
-- Name: el_library_material_tags; Type: TABLE; Schema: public; Owner: el_library; Tablespace: 
--

CREATE TABLE el_library_material_tags (
    id integer NOT NULL,
    material_id integer NOT NULL,
    tags_id integer NOT NULL
);


ALTER TABLE public.el_library_material_tags OWNER TO el_library;

--
-- Name: el_library_material_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: el_library
--

CREATE SEQUENCE el_library_material_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.el_library_material_tags_id_seq OWNER TO el_library;

--
-- Name: el_library_material_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: el_library
--

ALTER SEQUENCE el_library_material_tags_id_seq OWNED BY el_library_material_tags.id;


--
-- Name: el_library_profile; Type: TABLE; Schema: public; Owner: el_library; Tablespace: 
--

CREATE TABLE el_library_profile (
    id integer NOT NULL,
    nickname character varying(20) NOT NULL,
    fio character varying(50) NOT NULL
);


ALTER TABLE public.el_library_profile OWNER TO el_library;

--
-- Name: el_library_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: el_library
--

CREATE SEQUENCE el_library_profile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.el_library_profile_id_seq OWNER TO el_library;

--
-- Name: el_library_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: el_library
--

ALTER SEQUENCE el_library_profile_id_seq OWNED BY el_library_profile.id;


--
-- Name: el_library_rubrik; Type: TABLE; Schema: public; Owner: el_library; Tablespace: 
--

CREATE TABLE el_library_rubrik (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    parent_id integer,
    is_approved integer NOT NULL
);


ALTER TABLE public.el_library_rubrik OWNER TO el_library;

--
-- Name: el_library_rubrik_id_seq; Type: SEQUENCE; Schema: public; Owner: el_library
--

CREATE SEQUENCE el_library_rubrik_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.el_library_rubrik_id_seq OWNER TO el_library;

--
-- Name: el_library_rubrik_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: el_library
--

ALTER SEQUENCE el_library_rubrik_id_seq OWNED BY el_library_rubrik.id;


--
-- Name: el_library_tags; Type: TABLE; Schema: public; Owner: el_library; Tablespace: 
--

CREATE TABLE el_library_tags (
    id integer NOT NULL,
    tag character varying(25) NOT NULL,
    is_deleted integer NOT NULL
);


ALTER TABLE public.el_library_tags OWNER TO el_library;

--
-- Name: el_library_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: el_library
--

CREATE SEQUENCE el_library_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.el_library_tags_id_seq OWNER TO el_library;

--
-- Name: el_library_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: el_library
--

ALTER SEQUENCE el_library_tags_id_seq OWNED BY el_library_tags.id;


--
-- Name: tagging_tag; Type: TABLE; Schema: public; Owner: el_library; Tablespace: 
--

CREATE TABLE tagging_tag (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.tagging_tag OWNER TO el_library;

--
-- Name: tagging_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: el_library
--

CREATE SEQUENCE tagging_tag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tagging_tag_id_seq OWNER TO el_library;

--
-- Name: tagging_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: el_library
--

ALTER SEQUENCE tagging_tag_id_seq OWNED BY tagging_tag.id;


--
-- Name: tagging_taggeditem; Type: TABLE; Schema: public; Owner: el_library; Tablespace: 
--

CREATE TABLE tagging_taggeditem (
    id integer NOT NULL,
    object_id integer NOT NULL,
    content_type_id integer NOT NULL,
    tag_id integer NOT NULL,
    CONSTRAINT tagging_taggeditem_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE public.tagging_taggeditem OWNER TO el_library;

--
-- Name: tagging_taggeditem_id_seq; Type: SEQUENCE; Schema: public; Owner: el_library
--

CREATE SEQUENCE tagging_taggeditem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tagging_taggeditem_id_seq OWNER TO el_library;

--
-- Name: tagging_taggeditem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: el_library
--

ALTER SEQUENCE tagging_taggeditem_id_seq OWNED BY tagging_taggeditem.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY el_library_access ALTER COLUMN id SET DEFAULT nextval('el_library_access_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY el_library_access_users ALTER COLUMN id SET DEFAULT nextval('el_library_access_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY el_library_collection ALTER COLUMN id SET DEFAULT nextval('el_library_collection_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY el_library_collection_materials ALTER COLUMN id SET DEFAULT nextval('el_library_collection_materials_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY el_library_material ALTER COLUMN id SET DEFAULT nextval('el_library_material_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY el_library_material_tags ALTER COLUMN id SET DEFAULT nextval('el_library_material_tags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY el_library_profile ALTER COLUMN id SET DEFAULT nextval('el_library_profile_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY el_library_rubrik ALTER COLUMN id SET DEFAULT nextval('el_library_rubrik_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY el_library_tags ALTER COLUMN id SET DEFAULT nextval('el_library_tags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY tagging_tag ALTER COLUMN id SET DEFAULT nextval('tagging_tag_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY tagging_taggeditem ALTER COLUMN id SET DEFAULT nextval('tagging_taggeditem_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: el_library
--

COPY auth_group (id, name) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: el_library
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, false);


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: el_library
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: el_library
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: el_library
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can add permission	2	add_permission
5	Can change permission	2	change_permission
6	Can delete permission	2	delete_permission
7	Can add user	3	add_user
8	Can change user	3	change_user
9	Can delete user	3	delete_user
10	Can add group	4	add_group
11	Can change group	4	change_group
12	Can delete group	4	delete_group
13	Can add content type	5	add_contenttype
14	Can change content type	5	change_contenttype
15	Can delete content type	5	delete_contenttype
16	Can add session	6	add_session
17	Can change session	6	change_session
18	Can delete session	6	delete_session
19	Can add profile	7	add_profile
20	Can change profile	7	change_profile
21	Can delete profile	7	delete_profile
22	Can add material	8	add_material
23	Can change material	8	change_material
24	Can delete material	8	delete_material
25	Can add tag	9	add_tag
26	Can change tag	9	change_tag
27	Can delete tag	9	delete_tag
28	Can add tagged item	10	add_taggeditem
29	Can change tagged item	10	change_taggeditem
30	Can delete tagged item	10	delete_taggeditem
37	Can add tags	13	add_tags
38	Can change tags	13	change_tags
39	Can delete tags	13	delete_tags
40	Can add rubrik	14	add_rubrik
41	Can change rubrik	14	change_rubrik
42	Can delete rubrik	14	delete_rubrik
43	Can add collection	15	add_collection
44	Can change collection	15	change_collection
45	Can delete collection	15	delete_collection
46	Can add access	16	add_access
47	Can change access	16	change_access
48	Can delete access	16	delete_access
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: el_library
--

SELECT pg_catalog.setval('auth_permission_id_seq', 48, true);


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: el_library
--

COPY auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
2	pbkdf2_sha256$24000$Dzs56xsuTEur$O7zPNmjNXL7O6AsDzDPOx43xuoXT9LjieNeTO9s0ySk=	2017-05-22 21:57:15.052004+03	f	test			test@mail.ru	f	f	2017-04-07 10:58:27.817773+03
1	pbkdf2_sha256$24000$plr5g37GolLB$fQG8J+08giEjd080mVU0MtlzotFAn52W+SpH/Y4j0Dc=	2017-05-22 19:58:41.598436+03	t	admin			admin@el-library.ru	t	t	2017-04-07 02:28:25.980823+03
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: el_library
--

COPY auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: el_library
--

SELECT pg_catalog.setval('auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: el_library
--

SELECT pg_catalog.setval('auth_user_id_seq', 2, true);


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: el_library
--

COPY auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: el_library
--

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, false);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: el_library
--

COPY django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: el_library
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 1, false);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: el_library
--

COPY django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	user
4	auth	group
5	contenttypes	contenttype
6	sessions	session
7	el_library	profile
8	el_library	material
9	tagging	tag
10	tagging	taggeditem
13	el_library	tags
14	el_library	rubrik
15	el_library	collection
16	el_library	access
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: el_library
--

SELECT pg_catalog.setval('django_content_type_id_seq', 16, true);


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: el_library
--

COPY django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2017-04-07 02:27:12.76546+03
2	auth	0001_initial	2017-04-07 02:27:13.723633+03
3	admin	0001_initial	2017-04-07 02:27:13.96895+03
4	admin	0002_logentry_remove_auto_add	2017-04-07 02:27:14.002027+03
5	contenttypes	0002_remove_content_type_name	2017-04-07 02:27:14.078652+03
6	auth	0002_alter_permission_name_max_length	2017-04-07 02:27:14.111929+03
7	auth	0003_alter_user_email_max_length	2017-04-07 02:27:14.145489+03
8	auth	0004_alter_user_username_opts	2017-04-07 02:27:14.166997+03
9	auth	0005_alter_user_last_login_null	2017-04-07 02:27:14.222855+03
10	auth	0006_require_contenttypes_0002	2017-04-07 02:27:14.23411+03
11	auth	0007_alter_validators_add_error_messages	2017-04-07 02:27:14.256186+03
12	auth	0008_alter_user_username_max_length	2017-04-07 02:27:14.334275+03
13	sessions	0001_initial	2017-04-07 02:27:14.533856+03
16	tagging	0001_initial	2017-04-13 17:32:38.79533+03
17	tagging	0002_on_delete	2017-04-13 17:32:39.10599+03
28	el_library	0007_auto_20170414_0028	2017-04-14 03:39:19.185814+03
34	el_library	0001_initial	2017-04-14 18:59:13.747073+03
35	el_library	0002_material	2017-04-14 18:59:13.768146+03
36	el_library	0003_auto_20170413_2316	2017-04-14 18:59:13.779044+03
37	el_library	0004_auto_20170413_2326	2017-04-14 18:59:13.79107+03
38	el_library	0005_auto_20170413_2352	2017-04-14 18:59:13.801287+03
39	el_library	0006_auto_20170414_0012	2017-04-14 18:59:13.81248+03
40	el_library	0007_auto_20170414_0047	2017-04-14 18:59:13.824249+03
41	el_library	0008_auto_20170414_0048	2017-04-14 18:59:13.834568+03
42	el_library	0009_auto_20170414_1223	2017-04-14 18:59:13.845619+03
43	el_library	0010_auto_20170414_1249	2017-04-14 18:59:13.856832+03
44	el_library	0011_remove_material_document	2017-04-17 19:37:16.414715+03
45	el_library	0012_material_document	2017-04-17 19:37:16.771598+03
46	el_library	0013_auto_20170420_2325	2017-04-21 02:25:41.489193+03
47	el_library	0014_auto_20170421_0059	2017-04-21 03:59:29.916734+03
48	el_library	0015_rubrik_is_approved	2017-04-21 14:59:02.408707+03
50	el_library	0016_auto_20170503_1511	2017-05-03 18:12:18.277497+03
51	el_library	0017_auto_20170503_1731	2017-05-03 20:31:11.445321+03
52	el_library	0015_auto_20170503_1734	2017-05-03 20:39:44.883929+03
53	el_library	0016_profile_avatar	2017-05-03 20:39:45.016585+03
54	el_library	0017_remove_profile_avatar	2017-05-03 20:39:45.049478+03
55	el_library	0018_material_is_deleted	2017-05-03 21:52:06.568795+03
56	el_library	0019_auto_20170511_1433	2017-05-11 17:33:52.133816+03
57	el_library	0020_collection	2017-05-12 02:09:37.149782+03
58	el_library	0021_auto_20170511_2328	2017-05-12 02:28:39.370286+03
59	el_library	0022_material_is_app_changed	2017-05-15 18:51:34.383503+03
60	el_library	0023_tags_is_deleted	2017-05-19 12:32:14.465717+03
61	el_library	0024_access	2017-05-19 15:12:23.676692+03
62	el_library	0025_material_group	2017-05-23 01:02:37.267761+03
\.


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: el_library
--

SELECT pg_catalog.setval('django_migrations_id_seq', 62, true);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: el_library
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
vdvl0aoxirraxeolmsy97pdzj9f9svbh	YTA3NzhkMzBhNjE0N2Q1YmYzMzY3ZTE2YTE0OWJhZWVmNjAxZTFlZDp7Il9hdXRoX3VzZXJfaGFzaCI6IjJhMWQxYjc4ZDk2OGU1MDVlM2JmODI3YTg2MzAyZGM0ZTRlODYzM2MiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2017-05-17 17:39:18.348925+03
001j42e9saonvxse6c5tn1yctjjyue8l	YTA3NzhkMzBhNjE0N2Q1YmYzMzY3ZTE2YTE0OWJhZWVmNjAxZTFlZDp7Il9hdXRoX3VzZXJfaGFzaCI6IjJhMWQxYjc4ZDk2OGU1MDVlM2JmODI3YTg2MzAyZGM0ZTRlODYzM2MiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2017-05-26 17:37:03.218504+03
upojq6391iuiw2qdqjy4fafb6r7yzd72	YTA3NzhkMzBhNjE0N2Q1YmYzMzY3ZTE2YTE0OWJhZWVmNjAxZTFlZDp7Il9hdXRoX3VzZXJfaGFzaCI6IjJhMWQxYjc4ZDk2OGU1MDVlM2JmODI3YTg2MzAyZGM0ZTRlODYzM2MiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2017-05-29 16:06:55.534793+03
ty94qkxkiwxgnz8g4lrdpjlvk2lwqmli	YTA3NzhkMzBhNjE0N2Q1YmYzMzY3ZTE2YTE0OWJhZWVmNjAxZTFlZDp7Il9hdXRoX3VzZXJfaGFzaCI6IjJhMWQxYjc4ZDk2OGU1MDVlM2JmODI3YTg2MzAyZGM0ZTRlODYzM2MiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2017-05-29 18:39:56.36041+03
pc03xdgwdcmwwggi4syqvx5ltsape7hp	YTA3NzhkMzBhNjE0N2Q1YmYzMzY3ZTE2YTE0OWJhZWVmNjAxZTFlZDp7Il9hdXRoX3VzZXJfaGFzaCI6IjJhMWQxYjc4ZDk2OGU1MDVlM2JmODI3YTg2MzAyZGM0ZTRlODYzM2MiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2017-06-05 19:58:41.642851+03
stpeofxa952w5gs18uvukhrfm3w68j99	YTA3NzhkMzBhNjE0N2Q1YmYzMzY3ZTE2YTE0OWJhZWVmNjAxZTFlZDp7Il9hdXRoX3VzZXJfaGFzaCI6IjJhMWQxYjc4ZDk2OGU1MDVlM2JmODI3YTg2MzAyZGM0ZTRlODYzM2MiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2017-06-05 19:58:41.653848+03
yi7ddrwzjwzizts6lb92i6qst0la4iaz	OTM4YmRhNTc1ZjZkMjZkMDk0NzhiY2Q5MmFlMjc1MGExMjEzYTU5ZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImY2MWJkYjdlZGQ5OWYyNTEyY2U2NzdlZjczOWYwMjEyOWRjYWM1MjQiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2017-06-05 21:54:42.860793+03
j44gierhzd4xuw9o070cuaf8r2kbdjyi	OTM4YmRhNTc1ZjZkMjZkMDk0NzhiY2Q5MmFlMjc1MGExMjEzYTU5ZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImY2MWJkYjdlZGQ5OWYyNTEyY2U2NzdlZjczOWYwMjEyOWRjYWM1MjQiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2017-06-05 21:57:15.063621+03
\.


--
-- Data for Name: el_library_access; Type: TABLE DATA; Schema: public; Owner: el_library
--

COPY el_library_access (id, name, access_level, is_deleted) FROM stdin;
1	Администраторы	0	0
2	Группа 2	0	0
6	Группа 3	0	1
10	Модераторы	0	0
\.


--
-- Name: el_library_access_id_seq; Type: SEQUENCE SET; Schema: public; Owner: el_library
--

SELECT pg_catalog.setval('el_library_access_id_seq', 11, true);


--
-- Data for Name: el_library_access_users; Type: TABLE DATA; Schema: public; Owner: el_library
--

COPY el_library_access_users (id, access_id, user_id) FROM stdin;
1	1	1
2	2	1
3	2	2
4	10	1
5	10	2
\.


--
-- Name: el_library_access_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: el_library
--

SELECT pg_catalog.setval('el_library_access_users_id_seq', 7, true);


--
-- Data for Name: el_library_collection; Type: TABLE DATA; Schema: public; Owner: el_library
--

COPY el_library_collection (id, title, is_deleted, user_id) FROM stdin;
1	fdfdfd	0	1
2	dffd	0	1
3	fddf	0	1
4	rerere	0	1
5	rereree	0	1
6	rere	0	1
7	ereee	0	1
8	rrfdfdfd fddffffffffffff fddfffffffffd fdddddddddd	0	1
9	fdsds dddsds dsdsdsds dsdsdsdsdsds dsssssssss	0	1
10	тест тест тест теестовая коллекция тест ааааа	0	1
11	Моя коллекция 2	0	1
12	gg	0	1
\.


--
-- Name: el_library_collection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: el_library
--

SELECT pg_catalog.setval('el_library_collection_id_seq', 44, true);


--
-- Data for Name: el_library_collection_materials; Type: TABLE DATA; Schema: public; Owner: el_library
--

COPY el_library_collection_materials (id, collection_id, material_id) FROM stdin;
5	10	21
8	1	2
11	4	28
44	2	21
45	2	29
46	2	11
47	2	12
\.


--
-- Name: el_library_collection_materials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: el_library
--

SELECT pg_catalog.setval('el_library_collection_materials_id_seq', 47, true);


--
-- Data for Name: el_library_material; Type: TABLE DATA; Schema: public; Owner: el_library
--

COPY el_library_material (id, title, author, description, rating, type_material, isbn, rubrik_id, document, is_approved, user_id, is_deleted, is_app_changed, group_id) FROM stdin;
1	test1	test2	ddssd	0	Book	\N	\N	0	1	1	0	0	\N
6	test3	тест233	материал	0	Book	\N	\N	0	1	1	0	0	\N
9	тест3	игорь	выыввы	0	Book	\N	\N	0	1	1	0	0	\N
7	заголовок 2	автрр1	пробуем теги	0	Book	\N	\N	0	1	1	0	0	\N
2	test1	test1	sddsds	0	Book	\N	\N	0	1	1	0	0	\N
23	test1	77899	рррррррррррррр	0	Book	77899	12	./Screenshot_from_2016-03-23_234439_ewVjbpw.png	0	1	0	1	\N
25	материал 25	автор 66	описание	0	Ucheb	434334	19	./Снимок_экрана_от_2016-03-29_185157.png	0	1	0	1	\N
27	тестовый материал	автор 5	описание	0	Method	0	27	./Снимок_экрана_от_2016-03-29_185157_Z1Tiwyi.png	1	1	1	1	\N
17	материал 2	4	вавава	0	Book	4	25	0	0	1	0	0	\N
19	вава	вава	описание3	0	Book	0	14	0	1	1	0	1	\N
8	тест3	игорь	выыввы	0	Book	\N	\N	0	1	1	0	1	\N
22	test1	' UNION SELECT * FROM users WHERE '1'='1	пааааааа	0	Book	0	13	0	1	1	0	1	\N
26	тестовый материал	автор 5	описание	0	Method	0	26	./Снимок_экрана_от_2016-03-29_185157_dWj4n1h.png	1	1	0	1	\N
34	Тестовый материал	' UNION SELECT * FROM users WHERE '1'='1	Описание материала	0	Book	0	38	./Screenshot_from_2016-03-26_004010_4WzbroC.png	0	1	0	0	\N
35	Тестовый материал	' UNION SELECT * FROM users WHERE '1'='1	Описание материала	0	Book	0	38	./Screenshot_from_2016-03-26_004010_RR1lzF0.png	0	1	0	0	\N
36	материал	Автор 4	описание	0	Article	0	26	./8081-2.png	0	1	0	0	\N
37	материал	Автор 4	описание	0	Article	0	26	./8081-2_x9RZapM.png	0	1	0	0	\N
39	материал	Автор 4	описание	0	Article	0	26	./8081-2_iEOZ2H1.png	0	1	0	0	\N
43	dede	ddede	dedede	0	Book	0	12	./photo5249148831642265543.jpg	0	1	0	0	\N
21	ваав	ваав	ваавваав	0	Book	0	13	./Screenshot_from_2016-03-02_131908_6dOJICW.png	1	1	0	1	\N
38	материал	Автор 4	описание	0	Article	0	26	./8081-2_VCKZz14.png	0	1	0	0	\N
28	Тестовый материал 26	Автор 5	описание 777	0	Book	0	29	./Снимок_экрана_от_2016-09-16_013322_0y7O5Hq.png	0	1	0	0	\N
29	Тестовый материал 26	Автор 5	описание 777	0	Book	0	28	./Снимок_экрана_от_2016-09-16_013322_DgJyubA.png	1	1	0	1	\N
18	ghdf	пушкин	ddd	0	Book	43323232	12	./Screenshot_from_2016-03-08_142750.png	0	1	0	1	\N
20	аав	ваав	описание4	0	Book	0	13	0	1	1	0	1	\N
10	тест3	игорь	выыввы	0	Book	\N	\N	0	0	1	0	1	\N
31	вавававв	вававава	ава	0	Book	0	31	./Screenshot_from_2016-03-23_234457_kxloCgL.png	0	1	0	0	\N
30	вавававв	вававава	ава	0	Book	0	30	./Screenshot_from_2016-03-23_234457_4Gwzawp.png	0	1	0	0	\N
44	dede	ddede	dedede	0	Book	0	12	./photo5249148831642265543_9vNA3zH.jpg	0	1	0	0	\N
33	Тестовый материал	автор 5	описание 3	0	Book	0	37	./ask_8MIclLm.png	0	1	0	0	\N
32	Тестовый материал	автор 5	описание 3	0	Book	0	36	./ask_cJsIx1U.png	0	1	0	0	\N
15	dssd	333332111	dssdsd	0	Book	333332111	4	0	0	1	0	1	\N
24	test1	' UNION SELECT * FROM users WHERE '1'='1	пппппиир\r\nррр	0	Book	0	13	0	1	1	0	1	\N
14	dsds	333333	sdsfds	0	Book	333333	4	0	0	1	0	1	\N
12	автор	сччсвыыв	jgbcfybt	0	Book	\N	\N	0	1	1	0	1	\N
13	тестовый1	автор1	материл проверочный	0	Book	\N	\N	0	0	1	0	1	\N
16	материа 4	4444444	описание	0	Book	4444444	22	0	0	1	0	1	\N
45	Тестовый материал	fdnjh 5	jgbcfybt	0	Book	0	12	./photo5249148831642265543_RnceQTF.jpg	0	1	0	0	\N
40	Название 222	Есенин А	описание 4	0	Article	3333	18	./bykov_l6v8_yIUiGtc.pptx	0	1	1	0	\N
46	Тестовый материал	fdnjh 5	jgbcfybt	0	Book	0	12	./photo5249148831642265543_FRfw0ie.jpg	0	1	0	0	\N
11	тест3	игорь	выыввы	0	Book	\N	\N	0	0	1	0	1	\N
41	Название 222	Есенин А	описание 4	0	Article	3333	18	1	0	1	0	0	\N
42	Материал 31	Иванов	описание материала	0	Book	0	40	./bykov_l6v8_1SKghFc.pptx	0	1	0	0	1
47	aaaad	dsdsdsd	sdd	0	Book	0	12	./photo5249148831642265544.jpg	0	1	0	0	\N
48	aaaad	dsdsdsd	sdd	0	Book	0	12	./photo5249148831642265544_sG2ZkO2.jpg	0	1	0	0	\N
49	test44	sdffd	описание	0	Book	0	12	./photo5249148831642265544_NR2UCdm.jpg	0	1	0	0	\N
50	test44	sdffd	описание	0	Book	0	12	./photo5249148831642265544_VOSgrOM.jpg	0	1	0	0	\N
51	test5	автор 5	описание материала	0	Book	43343443	12	./photo5249148831642265543_6k5g3JC.jpg	0	1	0	0	10
\.


--
-- Name: el_library_material_id_seq; Type: SEQUENCE SET; Schema: public; Owner: el_library
--

SELECT pg_catalog.setval('el_library_material_id_seq', 51, true);


--
-- Data for Name: el_library_material_tags; Type: TABLE DATA; Schema: public; Owner: el_library
--

COPY el_library_material_tags (id, material_id, tags_id) FROM stdin;
1	11	1
2	11	2
3	11	3
5	12	1
6	12	2
8	12	5
9	13	1
10	13	2
12	13	5
13	14	6
14	14	7
15	15	8
16	15	9
17	15	10
18	16	1
19	16	11
20	16	12
21	16	5
22	17	13
23	17	14
25	19	1
26	19	5
27	20	1
28	20	5
32	22	1
36	24	2
178	23	2
179	23	5
180	21	16
116	18	1
181	21	17
183	26	2
184	26	3
185	27	2
186	27	3
187	29	3
188	28	3
189	29	11
190	28	11
191	29	5
192	28	5
193	31	38
195	33	40
197	34	1
199	35	1
201	38	5
202	39	5
204	40	5
207	41	5
208	42	11
209	42	5
210	43	42
212	45	44
217	47	46
218	49	5
219	50	5
221	51	48
163	25	34
\.


--
-- Name: el_library_material_tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: el_library
--

SELECT pg_catalog.setval('el_library_material_tags_id_seq', 221, true);


--
-- Data for Name: el_library_profile; Type: TABLE DATA; Schema: public; Owner: el_library
--

COPY el_library_profile (id, nickname, fio) FROM stdin;
1	test	Иванов Иван Иванович
\.


--
-- Name: el_library_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: el_library
--

SELECT pg_catalog.setval('el_library_profile_id_seq', 1, true);


--
-- Data for Name: el_library_rubrik; Type: TABLE DATA; Schema: public; Owner: el_library
--

COPY el_library_rubrik (id, name, parent_id, is_approved) FROM stdin;
3	Религия. Теология	\N	1
4	Общественные науки	\N	1
5	Математика и естественные науки	\N	1
6	Прикладные науки	\N	1
7	Медицина	\N	1
8	Технология	\N	1
9	Искусство	\N	1
10	Лингвистика	\N	1
11	История	\N	1
0	Биографии	\N	1
1	Литературоведение	\N	1
12	Литература. Литературоведение	1	1
13	Теория литературы. Изучение литературы. Литературная техника	1	1
14	История философии	2	1
15	Метафизика	2	1
16	Телеология	2	1
17	Этика. Учение о морали. Практическая философия	2	1
18	Общие вопросы математических и естественных наук	5	1
19	Химия. Кристаллография. Минералогия	5	1
21	Медицина. Охрана здоровья	7	1
22	fdddddd	7	1
25	Тестовая рубрика 1	6	1
26	Моя рубрика	13	1
28	Метафизика подкатегория 1	15	1
30	Метафизика подподкатегория 2	28	1
29	233232	15	0
35	undefined	3	1
38	История Европы	11	1
20	Физика	5	1
37	Подкатегория 78	9	1
40	ddsdsds	12	0
36	frfdfd	9	1
27	dsddsdsds	13	1
31	Матфизика подкатегория 3	28	1
2	Философские науки. Психология	\N	1
\.


--
-- Name: el_library_rubrik_id_seq; Type: SEQUENCE SET; Schema: public; Owner: el_library
--

SELECT pg_catalog.setval('el_library_rubrik_id_seq', 41, true);


--
-- Data for Name: el_library_tags; Type: TABLE DATA; Schema: public; Owner: el_library
--

COPY el_library_tags (id, tag, is_deleted) FROM stdin;
3	тегr	0
5	тег4	0
6	fdfd	0
7	dff	0
8	dsds	0
9	ds	0
10	ss	0
11	теги	0
12	а	0
13	4	0
15	dddd	0
16	ваавва	0
18	аввавава	0
19	теееееееееее	0
20	sddsdsds	0
21	вав	0
22	авав	0
34	тегегегег	0
38	вввв	0
40	ntdfddfdf	0
1	тег3	1
14	45hh44	0
42	dedede	0
44	555vv	0
46	sdds	0
48	тегииииии	0
17	ававваав	0
2	тег2	0
\.


--
-- Name: el_library_tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: el_library
--

SELECT pg_catalog.setval('el_library_tags_id_seq', 48, true);


--
-- Data for Name: tagging_tag; Type: TABLE DATA; Schema: public; Owner: el_library
--

COPY tagging_tag (id, name) FROM stdin;
\.


--
-- Name: tagging_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: el_library
--

SELECT pg_catalog.setval('tagging_tag_id_seq', 1, false);


--
-- Data for Name: tagging_taggeditem; Type: TABLE DATA; Schema: public; Owner: el_library
--

COPY tagging_taggeditem (id, object_id, content_type_id, tag_id) FROM stdin;
\.


--
-- Name: tagging_taggeditem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: el_library
--

SELECT pg_catalog.setval('tagging_taggeditem_id_seq', 1, false);


--
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions_group_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_content_type_id_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_user_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_user_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: const_1; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY el_library_rubrik
    ADD CONSTRAINT const_1 UNIQUE (name);


--
-- Name: constraint_name_1; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY el_library_tags
    ADD CONSTRAINT constraint_name_1 UNIQUE (tag);


--
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type_app_label_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: el_library_access_pkey; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY el_library_access
    ADD CONSTRAINT el_library_access_pkey PRIMARY KEY (id);


--
-- Name: el_library_access_users_access_id_980940c6_uniq; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY el_library_access_users
    ADD CONSTRAINT el_library_access_users_access_id_980940c6_uniq UNIQUE (access_id, user_id);


--
-- Name: el_library_access_users_pkey; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY el_library_access_users
    ADD CONSTRAINT el_library_access_users_pkey PRIMARY KEY (id);


--
-- Name: el_library_collection_materials_collection_id_d95ab8b6_uniq; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY el_library_collection_materials
    ADD CONSTRAINT el_library_collection_materials_collection_id_d95ab8b6_uniq UNIQUE (collection_id, material_id);


--
-- Name: el_library_collection_materials_pkey; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY el_library_collection_materials
    ADD CONSTRAINT el_library_collection_materials_pkey PRIMARY KEY (id);


--
-- Name: el_library_collection_pkey; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY el_library_collection
    ADD CONSTRAINT el_library_collection_pkey PRIMARY KEY (id);


--
-- Name: el_library_material_pkey; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY el_library_material
    ADD CONSTRAINT el_library_material_pkey PRIMARY KEY (id);


--
-- Name: el_library_material_tags_material_id_14ce06c1_uniq; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY el_library_material_tags
    ADD CONSTRAINT el_library_material_tags_material_id_14ce06c1_uniq UNIQUE (material_id, tags_id);


--
-- Name: el_library_material_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY el_library_material_tags
    ADD CONSTRAINT el_library_material_tags_pkey PRIMARY KEY (id);


--
-- Name: el_library_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY el_library_profile
    ADD CONSTRAINT el_library_profile_pkey PRIMARY KEY (id);


--
-- Name: el_library_rubrik_pkey; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY el_library_rubrik
    ADD CONSTRAINT el_library_rubrik_pkey PRIMARY KEY (id);


--
-- Name: el_library_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY el_library_tags
    ADD CONSTRAINT el_library_tags_pkey PRIMARY KEY (id);


--
-- Name: tagging_tag_name_key; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY tagging_tag
    ADD CONSTRAINT tagging_tag_name_key UNIQUE (name);


--
-- Name: tagging_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY tagging_tag
    ADD CONSTRAINT tagging_tag_pkey PRIMARY KEY (id);


--
-- Name: tagging_taggeditem_pkey; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY tagging_taggeditem
    ADD CONSTRAINT tagging_taggeditem_pkey PRIMARY KEY (id);


--
-- Name: tagging_taggeditem_tag_id_3d53f09d_uniq; Type: CONSTRAINT; Schema: public; Owner: el_library; Tablespace: 
--

ALTER TABLE ONLY tagging_taggeditem
    ADD CONSTRAINT tagging_taggeditem_tag_id_3d53f09d_uniq UNIQUE (tag_id, content_type_id, object_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: el_library; Tablespace: 
--

CREATE INDEX auth_group_name_a6ea08ec_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_0e939a4f; Type: INDEX; Schema: public; Owner: el_library; Tablespace: 
--

CREATE INDEX auth_group_permissions_0e939a4f ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_8373b171; Type: INDEX; Schema: public; Owner: el_library; Tablespace: 
--

CREATE INDEX auth_group_permissions_8373b171 ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_417f1b1c; Type: INDEX; Schema: public; Owner: el_library; Tablespace: 
--

CREATE INDEX auth_permission_417f1b1c ON auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_0e939a4f; Type: INDEX; Schema: public; Owner: el_library; Tablespace: 
--

CREATE INDEX auth_user_groups_0e939a4f ON auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_e8701ad4; Type: INDEX; Schema: public; Owner: el_library; Tablespace: 
--

CREATE INDEX auth_user_groups_e8701ad4 ON auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_8373b171; Type: INDEX; Schema: public; Owner: el_library; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_8373b171 ON auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_e8701ad4; Type: INDEX; Schema: public; Owner: el_library; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_e8701ad4 ON auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: el_library; Tablespace: 
--

CREATE INDEX auth_user_username_6821ab7c_like ON auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_417f1b1c; Type: INDEX; Schema: public; Owner: el_library; Tablespace: 
--

CREATE INDEX django_admin_log_417f1b1c ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_e8701ad4; Type: INDEX; Schema: public; Owner: el_library; Tablespace: 
--

CREATE INDEX django_admin_log_e8701ad4 ON django_admin_log USING btree (user_id);


--
-- Name: django_session_de54fa62; Type: INDEX; Schema: public; Owner: el_library; Tablespace: 
--

CREATE INDEX django_session_de54fa62 ON django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: el_library; Tablespace: 
--

CREATE INDEX django_session_session_key_c0390e0f_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: el_library_access_users_ae441468; Type: INDEX; Schema: public; Owner: el_library; Tablespace: 
--

CREATE INDEX el_library_access_users_ae441468 ON el_library_access_users USING btree (access_id);


--
-- Name: el_library_access_users_e8701ad4; Type: INDEX; Schema: public; Owner: el_library; Tablespace: 
--

CREATE INDEX el_library_access_users_e8701ad4 ON el_library_access_users USING btree (user_id);


--
-- Name: el_library_collection_e8701ad4; Type: INDEX; Schema: public; Owner: el_library; Tablespace: 
--

CREATE INDEX el_library_collection_e8701ad4 ON el_library_collection USING btree (user_id);


--
-- Name: el_library_collection_materials_0a1a4dd8; Type: INDEX; Schema: public; Owner: el_library; Tablespace: 
--

CREATE INDEX el_library_collection_materials_0a1a4dd8 ON el_library_collection_materials USING btree (collection_id);


--
-- Name: el_library_collection_materials_eb4b9aaa; Type: INDEX; Schema: public; Owner: el_library; Tablespace: 
--

CREATE INDEX el_library_collection_materials_eb4b9aaa ON el_library_collection_materials USING btree (material_id);


--
-- Name: el_library_material_0e939a4f; Type: INDEX; Schema: public; Owner: el_library; Tablespace: 
--

CREATE INDEX el_library_material_0e939a4f ON el_library_material USING btree (group_id);


--
-- Name: el_library_material_e8701ad4; Type: INDEX; Schema: public; Owner: el_library; Tablespace: 
--

CREATE INDEX el_library_material_e8701ad4 ON el_library_material USING btree (user_id);


--
-- Name: el_library_material_f47c3b8f; Type: INDEX; Schema: public; Owner: el_library; Tablespace: 
--

CREATE INDEX el_library_material_f47c3b8f ON el_library_material USING btree (rubrik_id);


--
-- Name: el_library_material_tags_8f9ab750; Type: INDEX; Schema: public; Owner: el_library; Tablespace: 
--

CREATE INDEX el_library_material_tags_8f9ab750 ON el_library_material_tags USING btree (tags_id);


--
-- Name: el_library_material_tags_eb4b9aaa; Type: INDEX; Schema: public; Owner: el_library; Tablespace: 
--

CREATE INDEX el_library_material_tags_eb4b9aaa ON el_library_material_tags USING btree (material_id);


--
-- Name: tagging_tag_name_a1527681_like; Type: INDEX; Schema: public; Owner: el_library; Tablespace: 
--

CREATE INDEX tagging_tag_name_a1527681_like ON tagging_tag USING btree (name varchar_pattern_ops);


--
-- Name: tagging_taggeditem_417f1b1c; Type: INDEX; Schema: public; Owner: el_library; Tablespace: 
--

CREATE INDEX tagging_taggeditem_417f1b1c ON tagging_taggeditem USING btree (content_type_id);


--
-- Name: tagging_taggeditem_76f094bc; Type: INDEX; Schema: public; Owner: el_library; Tablespace: 
--

CREATE INDEX tagging_taggeditem_76f094bc ON tagging_taggeditem USING btree (tag_id);


--
-- Name: tagging_taggeditem_af31437c; Type: INDEX; Schema: public; Owner: el_library; Tablespace: 
--

CREATE INDEX tagging_taggeditem_af31437c ON tagging_taggeditem USING btree (object_id);


--
-- Name: auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_per_permission_id_1fbb5f2c_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_per_permission_id_1fbb5f2c_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_content_type_id_c4bce8eb_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_content_type_id_c4bce8eb_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: el_library_access_us_access_id_1ec6b661_fk_el_library_access_id; Type: FK CONSTRAINT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY el_library_access_users
    ADD CONSTRAINT el_library_access_us_access_id_1ec6b661_fk_el_library_access_id FOREIGN KEY (access_id) REFERENCES el_library_access(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: el_library_access_users_user_id_cbe06ed4_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY el_library_access_users
    ADD CONSTRAINT el_library_access_users_user_id_cbe06ed4_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: el_library_c_collection_id_983ce89d_fk_el_library_collection_id; Type: FK CONSTRAINT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY el_library_collection_materials
    ADD CONSTRAINT el_library_c_collection_id_983ce89d_fk_el_library_collection_id FOREIGN KEY (collection_id) REFERENCES el_library_collection(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: el_library_colle_material_id_17b1a767_fk_el_library_material_id; Type: FK CONSTRAINT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY el_library_collection_materials
    ADD CONSTRAINT el_library_colle_material_id_17b1a767_fk_el_library_material_id FOREIGN KEY (material_id) REFERENCES el_library_material(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: el_library_collection_user_id_d8d48bf5_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY el_library_collection
    ADD CONSTRAINT el_library_collection_user_id_d8d48bf5_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: el_library_mater_material_id_13e4e681_fk_el_library_material_id; Type: FK CONSTRAINT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY el_library_material_tags
    ADD CONSTRAINT el_library_mater_material_id_13e4e681_fk_el_library_material_id FOREIGN KEY (material_id) REFERENCES el_library_material(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: el_library_material_group_id_9106b548_fk_el_library_access_id; Type: FK CONSTRAINT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY el_library_material
    ADD CONSTRAINT el_library_material_group_id_9106b548_fk_el_library_access_id FOREIGN KEY (group_id) REFERENCES el_library_access(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: el_library_material_rubrik_id_e49ab961_fk_el_library_rubrik_id; Type: FK CONSTRAINT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY el_library_material
    ADD CONSTRAINT el_library_material_rubrik_id_e49ab961_fk_el_library_rubrik_id FOREIGN KEY (rubrik_id) REFERENCES el_library_rubrik(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: el_library_material_tags_tags_id_5c519111_fk_el_library_tags_id; Type: FK CONSTRAINT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY el_library_material_tags
    ADD CONSTRAINT el_library_material_tags_tags_id_5c519111_fk_el_library_tags_id FOREIGN KEY (tags_id) REFERENCES el_library_tags(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: el_library_material_user_id_5566e7f1_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY el_library_material
    ADD CONSTRAINT el_library_material_user_id_5566e7f1_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tagging_tagg_content_type_id_ede1c265_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY tagging_taggeditem
    ADD CONSTRAINT tagging_tagg_content_type_id_ede1c265_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tagging_taggeditem_tag_id_f008ca79_fk_tagging_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: el_library
--

ALTER TABLE ONLY tagging_taggeditem
    ADD CONSTRAINT tagging_taggeditem_tag_id_f008ca79_fk_tagging_tag_id FOREIGN KEY (tag_id) REFERENCES tagging_tag(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

