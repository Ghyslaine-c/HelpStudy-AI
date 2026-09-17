--
-- PostgreSQL database dump
--

\restrict yQg8fVzXTtR0iaNnpJzWZU9UoPELFK40WIaIvRoM3UATwUMpJnNpzq08FEtIuzG

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-09-16 15:30:36

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 230 (class 1259 OID 16476)
-- Name: annee_academique; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.annee_academique (
    id_annee integer NOT NULL,
    libelle character varying(20) NOT NULL,
    date_debut date,
    date_fin date,
    CONSTRAINT annee_academique_check CHECK (((date_fin IS NULL) OR (date_debut IS NULL) OR (date_fin >= date_debut)))
);


ALTER TABLE public.annee_academique OWNER TO postgres;

--
-- TOC entry 5247 (class 0 OID 0)
-- Dependencies: 230
-- Name: TABLE annee_academique; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.annee_academique IS 'Années académiques (2024-2025, ...)';


--
-- TOC entry 229 (class 1259 OID 16475)
-- Name: annee_academique_id_annee_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.annee_academique_id_annee_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.annee_academique_id_annee_seq OWNER TO postgres;

--
-- TOC entry 5248 (class 0 OID 0)
-- Dependencies: 229
-- Name: annee_academique_id_annee_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.annee_academique_id_annee_seq OWNED BY public.annee_academique.id_annee;


--
-- TOC entry 238 (class 1259 OID 16558)
-- Name: cours; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cours (
    id_cours integer NOT NULL,
    code_cours character varying(30) NOT NULL,
    intitule character varying(150) NOT NULL,
    credits integer NOT NULL,
    id_filiere integer NOT NULL,
    description text,
    CONSTRAINT cours_credits_check CHECK ((credits > 0))
);


ALTER TABLE public.cours OWNER TO postgres;

--
-- TOC entry 5249 (class 0 OID 0)
-- Dependencies: 238
-- Name: TABLE cours; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cours IS 'Cours';


--
-- TOC entry 237 (class 1259 OID 16557)
-- Name: cours_id_cours_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cours_id_cours_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cours_id_cours_seq OWNER TO postgres;

--
-- TOC entry 5250 (class 0 OID 0)
-- Dependencies: 237
-- Name: cours_id_cours_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cours_id_cours_seq OWNED BY public.cours.id_cours;


--
-- TOC entry 260 (class 1259 OID 16835)
-- Name: decision_academique; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.decision_academique (
    id_decision integer NOT NULL,
    id_etudiant integer NOT NULL,
    id_annee integer NOT NULL,
    decision character varying(100) NOT NULL,
    justification text,
    date_decision date DEFAULT CURRENT_DATE,
    CONSTRAINT decision_academique_decision_check CHECK (((decision)::text = ANY ((ARRAY['Admis'::character varying, 'Admis sous conditions'::character varying, 'Ajourné'::character varying, 'Exclu'::character varying, 'Diplômé'::character varying])::text[])))
);


ALTER TABLE public.decision_academique OWNER TO postgres;

--
-- TOC entry 5251 (class 0 OID 0)
-- Dependencies: 260
-- Name: TABLE decision_academique; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.decision_academique IS 'Décisions académiques';


--
-- TOC entry 259 (class 1259 OID 16834)
-- Name: decision_academique_id_decision_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.decision_academique_id_decision_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.decision_academique_id_decision_seq OWNER TO postgres;

--
-- TOC entry 5252 (class 0 OID 0)
-- Dependencies: 259
-- Name: decision_academique_id_decision_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.decision_academique_id_decision_seq OWNED BY public.decision_academique.id_decision;


--
-- TOC entry 224 (class 1259 OID 16424)
-- Name: departement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departement (
    id_departement integer NOT NULL,
    id_faculte integer NOT NULL,
    nom character varying(150) NOT NULL,
    sigle character varying(20),
    chef character varying(150),
    description text
);


ALTER TABLE public.departement OWNER TO postgres;

--
-- TOC entry 5253 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE departement; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.departement IS 'Départements';


--
-- TOC entry 223 (class 1259 OID 16423)
-- Name: departement_id_departement_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.departement_id_departement_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.departement_id_departement_seq OWNER TO postgres;

--
-- TOC entry 5254 (class 0 OID 0)
-- Dependencies: 223
-- Name: departement_id_departement_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.departement_id_departement_seq OWNED BY public.departement.id_departement;


--
-- TOC entry 242 (class 1259 OID 16614)
-- Name: enseignant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enseignant (
    id_enseignant integer NOT NULL,
    nom character varying(100) NOT NULL,
    postnom character varying(100),
    prenom character varying(100) NOT NULL,
    email character varying(150),
    telephone character varying(30),
    grade character varying(100),
    specialite character varying(150)
);


ALTER TABLE public.enseignant OWNER TO postgres;

--
-- TOC entry 5255 (class 0 OID 0)
-- Dependencies: 242
-- Name: TABLE enseignant; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.enseignant IS 'Enseignants';


--
-- TOC entry 241 (class 1259 OID 16613)
-- Name: enseignant_id_enseignant_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.enseignant_id_enseignant_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.enseignant_id_enseignant_seq OWNER TO postgres;

--
-- TOC entry 5256 (class 0 OID 0)
-- Dependencies: 241
-- Name: enseignant_id_enseignant_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enseignant_id_enseignant_seq OWNED BY public.enseignant.id_enseignant;


--
-- TOC entry 244 (class 1259 OID 16628)
-- Name: enseignement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enseignement (
    id_enseignement integer NOT NULL,
    id_enseignant integer NOT NULL,
    id_cours integer NOT NULL,
    id_annee integer NOT NULL,
    id_semestre integer NOT NULL
);


ALTER TABLE public.enseignement OWNER TO postgres;

--
-- TOC entry 5257 (class 0 OID 0)
-- Dependencies: 244
-- Name: TABLE enseignement; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.enseignement IS 'Affectation enseignant ↔ cours ↔ année/semestre';


--
-- TOC entry 243 (class 1259 OID 16627)
-- Name: enseignement_id_enseignement_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.enseignement_id_enseignement_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.enseignement_id_enseignement_seq OWNER TO postgres;

--
-- TOC entry 5258 (class 0 OID 0)
-- Dependencies: 243
-- Name: enseignement_id_enseignement_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enseignement_id_enseignement_seq OWNED BY public.enseignement.id_enseignement;


--
-- TOC entry 234 (class 1259 OID 16499)
-- Name: etudiant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etudiant (
    id_etudiant integer NOT NULL,
    matricule character varying(50) NOT NULL,
    nom character varying(100) NOT NULL,
    postnom character varying(100),
    prenom character varying(100) NOT NULL,
    sexe character(1),
    date_naissance date,
    lieu_naissance character varying(150),
    nationalite character varying(100) DEFAULT 'Congolaise (RDC)'::character varying,
    email character varying(150),
    telephone character varying(30),
    adresse character varying(255),
    id_filiere integer NOT NULL,
    statut character varying(30) DEFAULT 'Actif'::character varying,
    date_creation date DEFAULT CURRENT_DATE,
    CONSTRAINT etudiant_sexe_check CHECK ((sexe = ANY (ARRAY['M'::bpchar, 'F'::bpchar]))),
    CONSTRAINT etudiant_statut_check CHECK (((statut)::text = ANY ((ARRAY['Actif'::character varying, 'Suspendu'::character varying, 'Diplômé'::character varying, 'Abandon'::character varying])::text[])))
);


ALTER TABLE public.etudiant OWNER TO postgres;

--
-- TOC entry 5259 (class 0 OID 0)
-- Dependencies: 234
-- Name: TABLE etudiant; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.etudiant IS 'Étudiants';


--
-- TOC entry 233 (class 1259 OID 16498)
-- Name: etudiant_id_etudiant_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etudiant_id_etudiant_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etudiant_id_etudiant_seq OWNER TO postgres;

--
-- TOC entry 5260 (class 0 OID 0)
-- Dependencies: 233
-- Name: etudiant_id_etudiant_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etudiant_id_etudiant_seq OWNED BY public.etudiant.id_etudiant;


--
-- TOC entry 246 (class 1259 OID 16662)
-- Name: evaluation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evaluation (
    id_evaluation integer NOT NULL,
    id_enseignement integer NOT NULL,
    type_evaluation character varying(50) NOT NULL,
    date_evaluation date DEFAULT CURRENT_DATE,
    ponderation numeric(5,2) NOT NULL,
    CONSTRAINT evaluation_ponderation_check CHECK ((ponderation > (0)::numeric)),
    CONSTRAINT evaluation_type_evaluation_check CHECK (((type_evaluation)::text = ANY ((ARRAY['TP'::character varying, 'TD'::character varying, 'Interrogation'::character varying, 'Examen'::character varying, 'Travail'::character varying])::text[])))
);


ALTER TABLE public.evaluation OWNER TO postgres;

--
-- TOC entry 5261 (class 0 OID 0)
-- Dependencies: 246
-- Name: TABLE evaluation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.evaluation IS 'Évaluations liées à un enseignement';


--
-- TOC entry 245 (class 1259 OID 16661)
-- Name: evaluation_id_evaluation_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.evaluation_id_evaluation_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.evaluation_id_evaluation_seq OWNER TO postgres;

--
-- TOC entry 5262 (class 0 OID 0)
-- Dependencies: 245
-- Name: evaluation_id_evaluation_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.evaluation_id_evaluation_seq OWNED BY public.evaluation.id_evaluation;


--
-- TOC entry 222 (class 1259 OID 16405)
-- Name: faculte; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.faculte (
    id_faculte integer NOT NULL,
    id_universite integer NOT NULL,
    nom character varying(150) NOT NULL,
    sigle character varying(20),
    doyen character varying(150),
    description text
);


ALTER TABLE public.faculte OWNER TO postgres;

--
-- TOC entry 5263 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE faculte; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.faculte IS 'Facultés';


--
-- TOC entry 221 (class 1259 OID 16404)
-- Name: faculte_id_faculte_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.faculte_id_faculte_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.faculte_id_faculte_seq OWNER TO postgres;

--
-- TOC entry 5264 (class 0 OID 0)
-- Dependencies: 221
-- Name: faculte_id_faculte_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.faculte_id_faculte_seq OWNED BY public.faculte.id_faculte;


--
-- TOC entry 226 (class 1259 OID 16443)
-- Name: filiere; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.filiere (
    id_filiere integer NOT NULL,
    id_departement integer NOT NULL,
    nom character varying(150) NOT NULL,
    sigle character varying(20),
    cycle character varying(30),
    duree_annees integer DEFAULT 5,
    description text,
    CONSTRAINT filiere_cycle_check CHECK (((cycle)::text = ANY ((ARRAY['Licence'::character varying, 'Master'::character varying, 'Doctorat'::character varying, 'Graduat'::character varying])::text[]))),
    CONSTRAINT filiere_duree_annees_check CHECK ((duree_annees > 0))
);


ALTER TABLE public.filiere OWNER TO postgres;

--
-- TOC entry 5265 (class 0 OID 0)
-- Dependencies: 226
-- Name: TABLE filiere; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.filiere IS 'Filières';


--
-- TOC entry 225 (class 1259 OID 16442)
-- Name: filiere_id_filiere_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.filiere_id_filiere_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.filiere_id_filiere_seq OWNER TO postgres;

--
-- TOC entry 5266 (class 0 OID 0)
-- Dependencies: 225
-- Name: filiere_id_filiere_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.filiere_id_filiere_seq OWNED BY public.filiere.id_filiere;


--
-- TOC entry 236 (class 1259 OID 16527)
-- Name: inscription; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inscription (
    id_inscription integer NOT NULL,
    id_etudiant integer NOT NULL,
    id_annee integer NOT NULL,
    id_niveau integer NOT NULL,
    date_inscription date DEFAULT CURRENT_DATE,
    statut character varying(50) DEFAULT 'Inscrit'::character varying,
    id_cours integer,
    CONSTRAINT inscription_statut_check CHECK (((statut)::text = ANY ((ARRAY['Inscrit'::character varying, 'Validé'::character varying, 'Échec'::character varying, 'Abandon'::character varying])::text[])))
);


ALTER TABLE public.inscription OWNER TO postgres;

--
-- TOC entry 5267 (class 0 OID 0)
-- Dependencies: 236
-- Name: TABLE inscription; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.inscription IS 'Inscriptions annuelles';


--
-- TOC entry 235 (class 1259 OID 16526)
-- Name: inscription_id_inscription_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inscription_id_inscription_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.inscription_id_inscription_seq OWNER TO postgres;

--
-- TOC entry 5268 (class 0 OID 0)
-- Dependencies: 235
-- Name: inscription_id_inscription_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inscription_id_inscription_seq OWNED BY public.inscription.id_inscription;


--
-- TOC entry 254 (class 1259 OID 16767)
-- Name: moyenne_annuelle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.moyenne_annuelle (
    id_moyenne_annuelle integer NOT NULL,
    id_etudiant integer NOT NULL,
    id_annee integer NOT NULL,
    moyenne numeric(5,2),
    credits_obtenus integer DEFAULT 0,
    decision character varying(100),
    CONSTRAINT moyenne_annuelle_credits_obtenus_check CHECK ((credits_obtenus >= 0)),
    CONSTRAINT moyenne_annuelle_moyenne_check CHECK (((moyenne >= (0)::numeric) AND (moyenne <= (20)::numeric)))
);


ALTER TABLE public.moyenne_annuelle OWNER TO postgres;

--
-- TOC entry 5269 (class 0 OID 0)
-- Dependencies: 254
-- Name: TABLE moyenne_annuelle; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.moyenne_annuelle IS 'Moyennes annuelles + décision';


--
-- TOC entry 253 (class 1259 OID 16766)
-- Name: moyenne_annuelle_id_moyenne_annuelle_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.moyenne_annuelle_id_moyenne_annuelle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.moyenne_annuelle_id_moyenne_annuelle_seq OWNER TO postgres;

--
-- TOC entry 5270 (class 0 OID 0)
-- Dependencies: 253
-- Name: moyenne_annuelle_id_moyenne_annuelle_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.moyenne_annuelle_id_moyenne_annuelle_seq OWNED BY public.moyenne_annuelle.id_moyenne_annuelle;


--
-- TOC entry 252 (class 1259 OID 16736)
-- Name: moyenne_semestre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.moyenne_semestre (
    id_moyenne_semestre integer NOT NULL,
    id_etudiant integer NOT NULL,
    id_semestre integer NOT NULL,
    id_annee integer NOT NULL,
    moyenne numeric(5,2),
    credits_obtenus integer DEFAULT 0,
    CONSTRAINT moyenne_semestre_credits_obtenus_check CHECK ((credits_obtenus >= 0)),
    CONSTRAINT moyenne_semestre_moyenne_check CHECK (((moyenne >= (0)::numeric) AND (moyenne <= (20)::numeric)))
);


ALTER TABLE public.moyenne_semestre OWNER TO postgres;

--
-- TOC entry 5271 (class 0 OID 0)
-- Dependencies: 252
-- Name: TABLE moyenne_semestre; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.moyenne_semestre IS 'Moyennes semestrielles';


--
-- TOC entry 251 (class 1259 OID 16735)
-- Name: moyenne_semestre_id_moyenne_semestre_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.moyenne_semestre_id_moyenne_semestre_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.moyenne_semestre_id_moyenne_semestre_seq OWNER TO postgres;

--
-- TOC entry 5272 (class 0 OID 0)
-- Dependencies: 251
-- Name: moyenne_semestre_id_moyenne_semestre_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.moyenne_semestre_id_moyenne_semestre_seq OWNED BY public.moyenne_semestre.id_moyenne_semestre;


--
-- TOC entry 228 (class 1259 OID 16465)
-- Name: niveau; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.niveau (
    id_niveau integer NOT NULL,
    libelle character varying(50) NOT NULL,
    ordre integer
);


ALTER TABLE public.niveau OWNER TO postgres;

--
-- TOC entry 5273 (class 0 OID 0)
-- Dependencies: 228
-- Name: TABLE niveau; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.niveau IS 'Niveaux d''études (L1, L2, ...)';


--
-- TOC entry 227 (class 1259 OID 16464)
-- Name: niveau_id_niveau_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.niveau_id_niveau_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.niveau_id_niveau_seq OWNER TO postgres;

--
-- TOC entry 5274 (class 0 OID 0)
-- Dependencies: 227
-- Name: niveau_id_niveau_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.niveau_id_niveau_seq OWNED BY public.niveau.id_niveau;


--
-- TOC entry 248 (class 1259 OID 16681)
-- Name: note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.note (
    id_note integer NOT NULL,
    id_etudiant integer NOT NULL,
    id_evaluation integer NOT NULL,
    valeur numeric(5,2) NOT NULL,
    observation text,
    CONSTRAINT note_valeur_check CHECK (((valeur >= (0)::numeric) AND (valeur <= (20)::numeric)))
);


ALTER TABLE public.note OWNER TO postgres;

--
-- TOC entry 5275 (class 0 OID 0)
-- Dependencies: 248
-- Name: TABLE note; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.note IS 'Notes des étudiants';


--
-- TOC entry 247 (class 1259 OID 16680)
-- Name: note_id_note_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.note_id_note_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.note_id_note_seq OWNER TO postgres;

--
-- TOC entry 5276 (class 0 OID 0)
-- Dependencies: 247
-- Name: note_id_note_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.note_id_note_seq OWNED BY public.note.id_note;


--
-- TOC entry 258 (class 1259 OID 16806)
-- Name: perequation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.perequation (
    id_perequation integer NOT NULL,
    id_etudiant integer NOT NULL,
    id_cours integer,
    id_annee integer,
    ancienne_moyenne numeric(5,2),
    nouvelle_moyenne numeric(5,2),
    justification text,
    date_perequation date DEFAULT CURRENT_DATE,
    CONSTRAINT perequation_ancienne_moyenne_check CHECK (((ancienne_moyenne >= (0)::numeric) AND (ancienne_moyenne <= (20)::numeric))),
    CONSTRAINT perequation_nouvelle_moyenne_check CHECK (((nouvelle_moyenne >= (0)::numeric) AND (nouvelle_moyenne <= (20)::numeric)))
);


ALTER TABLE public.perequation OWNER TO postgres;

--
-- TOC entry 5277 (class 0 OID 0)
-- Dependencies: 258
-- Name: TABLE perequation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.perequation IS 'Péréquations appliquées';


--
-- TOC entry 257 (class 1259 OID 16805)
-- Name: perequation_id_perequation_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.perequation_id_perequation_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.perequation_id_perequation_seq OWNER TO postgres;

--
-- TOC entry 5278 (class 0 OID 0)
-- Dependencies: 257
-- Name: perequation_id_perequation_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.perequation_id_perequation_seq OWNED BY public.perequation.id_perequation;


--
-- TOC entry 240 (class 1259 OID 16580)
-- Name: programme_cours; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.programme_cours (
    id_programme integer NOT NULL,
    id_cours integer NOT NULL,
    id_niveau integer NOT NULL,
    id_semestre integer NOT NULL,
    id_annee integer NOT NULL
);


ALTER TABLE public.programme_cours OWNER TO postgres;

--
-- TOC entry 5279 (class 0 OID 0)
-- Dependencies: 240
-- Name: TABLE programme_cours; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.programme_cours IS 'Programme des cours par niveau/semestre/année';


--
-- TOC entry 239 (class 1259 OID 16579)
-- Name: programme_cours_id_programme_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.programme_cours_id_programme_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.programme_cours_id_programme_seq OWNER TO postgres;

--
-- TOC entry 5280 (class 0 OID 0)
-- Dependencies: 239
-- Name: programme_cours_id_programme_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.programme_cours_id_programme_seq OWNED BY public.programme_cours.id_programme;


--
-- TOC entry 264 (class 1259 OID 16887)
-- Name: recommandation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recommandation (
    id_recommandation integer NOT NULL,
    id_etudiant integer NOT NULL,
    type_recommandation character varying(100),
    contenu text NOT NULL,
    priorite character varying(20) DEFAULT 'Normale'::character varying,
    lue boolean DEFAULT false,
    date_recommandation timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT recommandation_priorite_check CHECK (((priorite)::text = ANY ((ARRAY['Basse'::character varying, 'Normale'::character varying, 'Haute'::character varying, 'Urgente'::character varying])::text[]))),
    CONSTRAINT recommandation_type_recommandation_check CHECK (((type_recommandation)::text = ANY ((ARRAY['Orientation'::character varying, 'Soutien'::character varying, 'Réorientation'::character varying, 'Félicitations'::character varying, 'Avertissement'::character varying])::text[])))
);


ALTER TABLE public.recommandation OWNER TO postgres;

--
-- TOC entry 5281 (class 0 OID 0)
-- Dependencies: 264
-- Name: TABLE recommandation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.recommandation IS 'Recommandations générées';


--
-- TOC entry 263 (class 1259 OID 16886)
-- Name: recommandation_id_recommandation_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recommandation_id_recommandation_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.recommandation_id_recommandation_seq OWNER TO postgres;

--
-- TOC entry 5282 (class 0 OID 0)
-- Dependencies: 263
-- Name: recommandation_id_recommandation_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recommandation_id_recommandation_seq OWNED BY public.recommandation.id_recommandation;


--
-- TOC entry 256 (class 1259 OID 16792)
-- Name: regle_academique; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.regle_academique (
    id_regle integer NOT NULL,
    titre character varying(150) NOT NULL,
    description text NOT NULL,
    condition_regle text,
    consequence text,
    active boolean DEFAULT true,
    date_creation date DEFAULT CURRENT_DATE
);


ALTER TABLE public.regle_academique OWNER TO postgres;

--
-- TOC entry 5283 (class 0 OID 0)
-- Dependencies: 256
-- Name: TABLE regle_academique; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.regle_academique IS 'Règles académiques UCB';


--
-- TOC entry 255 (class 1259 OID 16791)
-- Name: regle_academique_id_regle_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.regle_academique_id_regle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.regle_academique_id_regle_seq OWNER TO postgres;

--
-- TOC entry 5284 (class 0 OID 0)
-- Dependencies: 255
-- Name: regle_academique_id_regle_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.regle_academique_id_regle_seq OWNED BY public.regle_academique.id_regle;


--
-- TOC entry 250 (class 1259 OID 16707)
-- Name: resultat_cours; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resultat_cours (
    id_resultat integer NOT NULL,
    id_etudiant integer NOT NULL,
    id_cours integer NOT NULL,
    id_annee integer,
    moyenne numeric(5,2),
    statut character varying(50),
    CONSTRAINT resultat_cours_moyenne_check CHECK (((moyenne >= (0)::numeric) AND (moyenne <= (20)::numeric))),
    CONSTRAINT resultat_cours_statut_check CHECK (((statut)::text = ANY ((ARRAY['Validé'::character varying, 'Échec'::character varying, 'En cours'::character varying])::text[])))
);


ALTER TABLE public.resultat_cours OWNER TO postgres;

--
-- TOC entry 5285 (class 0 OID 0)
-- Dependencies: 250
-- Name: TABLE resultat_cours; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.resultat_cours IS 'Résultats par cours';


--
-- TOC entry 249 (class 1259 OID 16706)
-- Name: resultat_cours_id_resultat_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.resultat_cours_id_resultat_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.resultat_cours_id_resultat_seq OWNER TO postgres;

--
-- TOC entry 5286 (class 0 OID 0)
-- Dependencies: 249
-- Name: resultat_cours_id_resultat_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.resultat_cours_id_resultat_seq OWNED BY public.resultat_cours.id_resultat;


--
-- TOC entry 232 (class 1259 OID 16488)
-- Name: semestre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.semestre (
    id_semestre integer NOT NULL,
    libelle character varying(50) NOT NULL,
    ordre integer
);


ALTER TABLE public.semestre OWNER TO postgres;

--
-- TOC entry 5287 (class 0 OID 0)
-- Dependencies: 232
-- Name: TABLE semestre; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.semestre IS 'Semestres (S1, S2, ...)';


--
-- TOC entry 231 (class 1259 OID 16487)
-- Name: semestre_id_semestre_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.semestre_id_semestre_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.semestre_id_semestre_seq OWNER TO postgres;

--
-- TOC entry 5288 (class 0 OID 0)
-- Dependencies: 231
-- Name: semestre_id_semestre_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.semestre_id_semestre_seq OWNED BY public.semestre.id_semestre;


--
-- TOC entry 220 (class 1259 OID 16390)
-- Name: universite; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.universite (
    id_universite integer NOT NULL,
    nom character varying(150) NOT NULL,
    sigle character varying(20),
    adresse character varying(255),
    ville character varying(100),
    pays character varying(100) DEFAULT 'RDC'::character varying,
    telephone character varying(30),
    email character varying(150),
    site_web character varying(150),
    date_creation date DEFAULT CURRENT_DATE
);


ALTER TABLE public.universite OWNER TO postgres;

--
-- TOC entry 5289 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE universite; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.universite IS 'Université (racine)';


--
-- TOC entry 219 (class 1259 OID 16389)
-- Name: universite_id_universite_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.universite_id_universite_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.universite_id_universite_seq OWNER TO postgres;

--
-- TOC entry 5290 (class 0 OID 0)
-- Dependencies: 219
-- Name: universite_id_universite_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.universite_id_universite_seq OWNED BY public.universite.id_universite;


--
-- TOC entry 262 (class 1259 OID 16862)
-- Name: utilisateur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utilisateur (
    id_utilisateur integer NOT NULL,
    nom_utilisateur character varying(100) NOT NULL,
    mot_de_passe character varying(255) NOT NULL,
    role character varying(50) NOT NULL,
    id_etudiant integer,
    id_enseignant integer,
    date_creation timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT utilisateur_role_check CHECK (((role)::text = ANY ((ARRAY['admin'::character varying, 'enseignant'::character varying, 'etudiant'::character varying, 'assistant'::character varying])::text[])))
);


ALTER TABLE public.utilisateur OWNER TO postgres;

--
-- TOC entry 5291 (class 0 OID 0)
-- Dependencies: 262
-- Name: TABLE utilisateur; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.utilisateur IS 'Comptes utilisateurs';


--
-- TOC entry 261 (class 1259 OID 16861)
-- Name: utilisateur_id_utilisateur_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.utilisateur_id_utilisateur_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.utilisateur_id_utilisateur_seq OWNER TO postgres;

--
-- TOC entry 5292 (class 0 OID 0)
-- Dependencies: 261
-- Name: utilisateur_id_utilisateur_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.utilisateur_id_utilisateur_seq OWNED BY public.utilisateur.id_utilisateur;


--
-- TOC entry 4873 (class 2604 OID 16479)
-- Name: annee_academique id_annee; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.annee_academique ALTER COLUMN id_annee SET DEFAULT nextval('public.annee_academique_id_annee_seq'::regclass);


--
-- TOC entry 4882 (class 2604 OID 16561)
-- Name: cours id_cours; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cours ALTER COLUMN id_cours SET DEFAULT nextval('public.cours_id_cours_seq'::regclass);


--
-- TOC entry 4899 (class 2604 OID 16838)
-- Name: decision_academique id_decision; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.decision_academique ALTER COLUMN id_decision SET DEFAULT nextval('public.decision_academique_id_decision_seq'::regclass);


--
-- TOC entry 4869 (class 2604 OID 16427)
-- Name: departement id_departement; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departement ALTER COLUMN id_departement SET DEFAULT nextval('public.departement_id_departement_seq'::regclass);


--
-- TOC entry 4884 (class 2604 OID 16617)
-- Name: enseignant id_enseignant; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enseignant ALTER COLUMN id_enseignant SET DEFAULT nextval('public.enseignant_id_enseignant_seq'::regclass);


--
-- TOC entry 4885 (class 2604 OID 16631)
-- Name: enseignement id_enseignement; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enseignement ALTER COLUMN id_enseignement SET DEFAULT nextval('public.enseignement_id_enseignement_seq'::regclass);


--
-- TOC entry 4875 (class 2604 OID 16502)
-- Name: etudiant id_etudiant; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etudiant ALTER COLUMN id_etudiant SET DEFAULT nextval('public.etudiant_id_etudiant_seq'::regclass);


--
-- TOC entry 4886 (class 2604 OID 16665)
-- Name: evaluation id_evaluation; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluation ALTER COLUMN id_evaluation SET DEFAULT nextval('public.evaluation_id_evaluation_seq'::regclass);


--
-- TOC entry 4868 (class 2604 OID 16408)
-- Name: faculte id_faculte; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculte ALTER COLUMN id_faculte SET DEFAULT nextval('public.faculte_id_faculte_seq'::regclass);


--
-- TOC entry 4870 (class 2604 OID 16446)
-- Name: filiere id_filiere; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filiere ALTER COLUMN id_filiere SET DEFAULT nextval('public.filiere_id_filiere_seq'::regclass);


--
-- TOC entry 4879 (class 2604 OID 16530)
-- Name: inscription id_inscription; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscription ALTER COLUMN id_inscription SET DEFAULT nextval('public.inscription_id_inscription_seq'::regclass);


--
-- TOC entry 4892 (class 2604 OID 16770)
-- Name: moyenne_annuelle id_moyenne_annuelle; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moyenne_annuelle ALTER COLUMN id_moyenne_annuelle SET DEFAULT nextval('public.moyenne_annuelle_id_moyenne_annuelle_seq'::regclass);


--
-- TOC entry 4890 (class 2604 OID 16739)
-- Name: moyenne_semestre id_moyenne_semestre; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moyenne_semestre ALTER COLUMN id_moyenne_semestre SET DEFAULT nextval('public.moyenne_semestre_id_moyenne_semestre_seq'::regclass);


--
-- TOC entry 4872 (class 2604 OID 16468)
-- Name: niveau id_niveau; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.niveau ALTER COLUMN id_niveau SET DEFAULT nextval('public.niveau_id_niveau_seq'::regclass);


--
-- TOC entry 4888 (class 2604 OID 16684)
-- Name: note id_note; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.note ALTER COLUMN id_note SET DEFAULT nextval('public.note_id_note_seq'::regclass);


--
-- TOC entry 4897 (class 2604 OID 16809)
-- Name: perequation id_perequation; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perequation ALTER COLUMN id_perequation SET DEFAULT nextval('public.perequation_id_perequation_seq'::regclass);


--
-- TOC entry 4883 (class 2604 OID 16583)
-- Name: programme_cours id_programme; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.programme_cours ALTER COLUMN id_programme SET DEFAULT nextval('public.programme_cours_id_programme_seq'::regclass);


--
-- TOC entry 4903 (class 2604 OID 16890)
-- Name: recommandation id_recommandation; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recommandation ALTER COLUMN id_recommandation SET DEFAULT nextval('public.recommandation_id_recommandation_seq'::regclass);


--
-- TOC entry 4894 (class 2604 OID 16795)
-- Name: regle_academique id_regle; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regle_academique ALTER COLUMN id_regle SET DEFAULT nextval('public.regle_academique_id_regle_seq'::regclass);


--
-- TOC entry 4889 (class 2604 OID 16710)
-- Name: resultat_cours id_resultat; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resultat_cours ALTER COLUMN id_resultat SET DEFAULT nextval('public.resultat_cours_id_resultat_seq'::regclass);


--
-- TOC entry 4874 (class 2604 OID 16491)
-- Name: semestre id_semestre; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.semestre ALTER COLUMN id_semestre SET DEFAULT nextval('public.semestre_id_semestre_seq'::regclass);


--
-- TOC entry 4865 (class 2604 OID 16393)
-- Name: universite id_universite; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.universite ALTER COLUMN id_universite SET DEFAULT nextval('public.universite_id_universite_seq'::regclass);


--
-- TOC entry 4901 (class 2604 OID 16865)
-- Name: utilisateur id_utilisateur; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur ALTER COLUMN id_utilisateur SET DEFAULT nextval('public.utilisateur_id_utilisateur_seq'::regclass);


--
-- TOC entry 5207 (class 0 OID 16476)
-- Dependencies: 230
-- Data for Name: annee_academique; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.annee_academique (id_annee, libelle, date_debut, date_fin) FROM stdin;
1	2024-2025	2024-09-01	2025-07-31
2	2025-2026	2025-09-01	2026-07-31
3	2026-2027	2026-09-01	2027-07-31
\.


--
-- TOC entry 5215 (class 0 OID 16558)
-- Dependencies: 238
-- Data for Name: cours; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cours (id_cours, code_cours, intitule, credits, id_filiere, description) FROM stdin;
1	INF101	Introduction à l'informatique	4	17	Bases de l'informatique et des systèmes
2	INF102	Algorithmique et programmation	6	17	Structures de données et algorithmes
3	INF201	Bases de données	5	17	Modèle relationnel, SQL, normalisation
4	INF202	Réseaux informatiques	5	17	Modèles OSI, TCP/IP, configuration
5	INF301	Génie logiciel	5	17	Méthodes de développement logiciel
6	INF302	Systèmes d'exploitation	5	17	Processus, mémoire, fichiers
7	DRT101	Introduction au droit	4	5	Notions fondamentales du droit
8	DRT102	Droit constitutionnel	5	5	Organisation de l'État et Constitution
9	DRT201	Droit des obligations	5	5	Contrats et responsabilité civile
10	DRT202	Droit commercial	5	5	Activités commerciales et sociétés
11	GES101	Comptabilité générale	5	11	Principes comptables OHADA
12	GES102	Mathématiques financières	4	11	Intérêts, actualisation, emprunts
13	GES201	Analyse financière	5	11	Lecture et interprétation des états financiers
14	GES202	Gestion budgétaire	5	11	Budgets et contrôle de gestion
15	MED101	Anatomie générale	6	16	Structure du corps humain
16	MED102	Physiologie	6	16	Fonctions des organes et systèmes
17	MED201	Biochimie médicale	5	16	Molécules et métabolisme
18	AGR101	Introduction à l'agronomie	4	1	Bases de l'agronomie
19	AGR102	Sciences du sol	5	1	Pédologie et fertilité
20	AGR201	Production végétale	5	1	Techniques de culture et rendement
21	TRV101	Introduction aux sciences du travail	4	20	Notions de base du travail
22	TRV102	Gestion des ressources humaines	5	20	Recrutement, formation, carrière
23	ARC101	Introduction à l'architecture	5	23	Histoire et théories de l'architecture
24	ARC102	Dessin technique	4	23	Représentation graphique et plans
\.


--
-- TOC entry 5237 (class 0 OID 16835)
-- Dependencies: 260
-- Data for Name: decision_academique; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.decision_academique (id_decision, id_etudiant, id_annee, decision, justification, date_decision) FROM stdin;
1	1	1	Admis	Moyenne 14.10 - Crédits validés	2025-07-15
2	2	1	Admis	Moyenne 13.20 - Crédits validés	2025-07-15
3	3	1	Admis	Moyenne 14.30 - Crédits validés	2025-07-15
4	4	1	Admis	Moyenne 13.75 - Crédits validés	2025-07-15
5	5	1	Admis	Moyenne 12.30 - Compensation appliquée	2025-07-15
6	6	1	Admis	Moyenne 15.70 - Excellents résultats	2025-07-15
7	7	1	Admis	Moyenne 13.30 - Crédits validés	2025-07-15
8	8	1	Admis	Moyenne 13.00 - Compensation appliquée	2025-07-15
9	9	1	Admis	Moyenne 15.20 - Excellents résultats	2025-07-15
10	10	1	Admis	Moyenne 13.55 - Crédits validés	2025-07-15
11	11	1	Admis	Moyenne 13.70 - Crédits validés	2025-07-15
12	12	1	Admis	Moyenne 15.70 - Excellents résultats	2025-07-15
13	13	1	Admis	Moyenne 13.50 - Crédits validés	2025-07-15
14	14	1	Admis	Moyenne 13.00 - Crédits validés	2025-07-15
15	15	1	Admis	Moyenne 14.00 - Crédits validés	2025-07-15
16	16	1	Admis	Moyenne 13.50 - Crédits validés	2025-07-15
\.


--
-- TOC entry 5201 (class 0 OID 16424)
-- Dependencies: 224
-- Data for Name: departement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.departement (id_departement, id_faculte, nom, sigle, chef, description) FROM stdin;
1	1	Productions Végétales	\N	\N	Production et protection des cultures
2	1	Gestion des Ressources en Eau et Assainissement	\N	\N	Eaux, assainissement, environnement
3	1	Écologie et Biodiversité	\N	\N	Écosystèmes et biodiversité
4	1	Gestion des Sols	\N	\N	Sciences du sol et fertilité
5	2	Droit Économique et des Affaires	\N	\N	Droit des affaires et économique
6	2	Droit Privé et Judiciaire	\N	\N	Droit privé et procédures judiciaires
7	2	Droit Public	\N	\N	Droit public et constitutionnel
8	3	Économie de Développement	\N	\N	Économie du développement
9	3	Économie Rurale	\N	\N	Économie rurale et agricole
10	3	Économie Publique	\N	\N	Économie publique et politiques
11	3	Gestion Financière	\N	\N	Finance et gestion
12	3	Comptabilité et Audit	\N	\N	Comptabilité, contrôle, audit
13	3	Entrepreneuriat	\N	\N	Création et gestion d'entreprises
14	4	Sciences Biomédicales	\N	\N	Sciences biomédicales
15	4	Santé Publique	\N	\N	Santé publique et épidémiologie
16	4	Médecine Humaine	\N	\N	Médecine humaine
17	5	Sciences Informatiques	\N	\N	Informatique et systèmes
18	5	Sciences de l'Environnement	\N	\N	Environnement et développement durable
19	5	Polytechnique	\N	\N	Génie civil, électrique, mécanique
20	6	Sciences du Travail	\N	\N	Travail et organisation
21	6	Information et Communication	\N	\N	Journalisme et communication
22	6	Étude de Paix et Conflits	\N	\N	Paix, conflits et résolution
23	7	Architecture	\N	\N	Conception architecturale
24	7	Urbanisme	\N	\N	Aménagement urbain
25	8	Criminologie	\N	\N	Études criminologiques
26	9	Santé Publique (3e cycle)	\N	\N	Programmes avancés en santé publique
\.


--
-- TOC entry 5219 (class 0 OID 16614)
-- Dependencies: 242
-- Data for Name: enseignant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enseignant (id_enseignant, nom, postnom, prenom, email, telephone, grade, specialite) FROM stdin;
1	KABUYA	MULUMBA	Jean	jean.kabuya@ucb.ac.cd	+243 970 001 001	Professeur Ordinaire	Génie logiciel et bases de données
2	MUTOMBO	KALALA	Patrick	patrick.mutombo@ucb.ac.cd	+243 970 001 002	Professeur Associé	Réseaux et systèmes distribués
3	NGOY	TSHIBANGU	Marie	marie.ngoy@ucb.ac.cd	+243 970 001 003	Chef de Travaux	Algorithmique et programmation
4	BISIMWA	KAMATE	Augustin	augustin.bisimwa@ucb.ac.cd	+243 970 001 004	Professeur Ordinaire	Droit des affaires
5	MUKENDI	LUBABA	Solange	solange.mukendi@ucb.ac.cd	+243 970 001 005	Professeur Associé	Droit constitutionnel
6	KASONGO	MWENZE	David	david.kasongo@ucb.ac.cd	+243 970 001 006	Professeur Associé	Comptabilité OHADA
7	BAGALWA	NTERANYA	Espérance	esperance.bagalwa@ucb.ac.cd	+243 970 001 007	Chef de Travaux	Analyse financière
8	CIBALONZA	MWEZE	Antoine	antoine.cibalonza@ucb.ac.cd	+243 970 001 008	Professeur Ordinaire	Anatomie
9	NAMWIRA	KAHINDO	Chantal	chantal.namwira@ucb.ac.cd	+243 970 001 009	Professeur Associé	Physiologie
10	BAHATI	NSHIMIYE	Joseph	joseph.bahati@ucb.ac.cd	+243 970 001 010	Professeur Associé	Sciences du sol
11	MULONGO	KABASELE	Thérèse	therese.mulongo@ucb.ac.cd	+243 970 001 011	Chef de Travaux	Gestion des RH
12	MWAMBA	TSHOMBA	Éric	eric.mwamba@ucb.ac.cd	+243 970 001 012	Professeur Associé	Architecture durable
\.


--
-- TOC entry 5221 (class 0 OID 16628)
-- Dependencies: 244
-- Data for Name: enseignement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enseignement (id_enseignement, id_enseignant, id_cours, id_annee, id_semestre) FROM stdin;
1	1	1	1	1
2	2	2	1	1
3	1	3	1	1
4	2	4	1	1
5	3	5	1	2
6	3	6	1	2
7	4	7	1	1
8	5	8	1	1
9	4	9	1	2
10	5	10	1	2
11	6	11	1	1
12	7	12	1	1
13	6	13	1	2
14	7	14	1	2
15	8	15	1	1
16	9	16	1	1
17	8	17	1	2
18	10	18	1	1
19	10	19	1	1
20	10	20	1	2
21	11	21	1	1
22	11	22	1	2
23	12	23	1	1
24	12	24	1	2
\.


--
-- TOC entry 5211 (class 0 OID 16499)
-- Dependencies: 234
-- Data for Name: etudiant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.etudiant (id_etudiant, matricule, nom, postnom, prenom, sexe, date_naissance, lieu_naissance, nationalite, email, telephone, adresse, id_filiere, statut, date_creation) FROM stdin;
1	UCB/INF/2024/001	MUKENDI	KABASELE	Jonathan	M	2003-05-12	Bukavu	Congolaise (RDC)	jonathan.mukendi@etu.ucb.ac.cd	+243 970 100 001	Kadutu, Bukavu	17	Actif	2026-09-16
2	UCB/INF/2024/002	NGOY	MULUMBA	Sarah	F	2004-02-18	Goma	Congolaise (RDC)	sarah.ngoy@etu.ucb.ac.cd	+243 970 100 002	Ibanda, Bukavu	17	Actif	2026-09-16
3	UCB/INF/2024/003	BISIMWA	KAMATE	David	M	2003-11-25	Bukavu	Congolaise (RDC)	david.bisimwa@etu.ucb.ac.cd	+243 970 100 003	Bagira, Bukavu	17	Actif	2026-09-16
4	UCB/DRT/2024/001	MUTOMBO	TSHIBANGU	Grâce	F	2004-07-08	Bukavu	Congolaise (RDC)	grace.mutombo@etu.ucb.ac.cd	+243 970 100 004	Kadutu, Bukavu	5	Actif	2026-09-16
5	UCB/DRT/2024/002	KASONGO	MWENZE	Patrick	M	2003-09-14	Uvira	Congolaise (RDC)	patrick.kasongo@etu.ucb.ac.cd	+243 970 100 005	Ibanda, Bukavu	5	Actif	2026-09-16
6	UCB/GES/2024/001	BAHATI	NSHIMIYE	Espérance	F	2004-03-22	Bukavu	Congolaise (RDC)	esperance.bahati@etu.ucb.ac.cd	+243 970 100 006	Bagira, Bukavu	11	Actif	2026-09-16
7	UCB/GES/2024/002	NAMWIRA	KAHINDO	Joseph	M	2003-12-30	Bukavu	Congolaise (RDC)	joseph.namwira@etu.ucb.ac.cd	+243 970 100 007	Kadutu, Bukavu	11	Actif	2026-09-16
8	UCB/GES/2024/003	MULONGO	KABASELE	Chantal	F	2004-06-17	Bukavu	Congolaise (RDC)	chantal.mulongo@etu.ucb.ac.cd	+243 970 100 008	Ibanda, Bukavu	11	Actif	2026-09-16
9	UCB/MED/2024/001	CIBALONZA	MWEZE	Antoine	M	2003-04-05	Bukavu	Congolaise (RDC)	antoine.cibalonza@etu.ucb.ac.cd	+243 970 100 009	Ibanda, Bukavu	16	Actif	2026-09-16
10	UCB/MED/2024/002	MWAMBA	TSHOMBA	Marie	F	2004-08-11	Bukavu	Congolaise (RDC)	marie.mwamba@etu.ucb.ac.cd	+243 970 100 010	Bagira, Bukavu	16	Actif	2026-09-16
11	UCB/AGR/2024/001	LUBABA	MUKENDI	Jean	M	2003-10-19	Bukavu	Congolaise (RDC)	jean.lubaba@etu.ucb.ac.cd	+243 970 100 011	Kadutu, Bukavu	1	Actif	2026-09-16
12	UCB/AGR/2024/002	KALALA	BISIMWA	Thérèse	F	2004-01-27	Bukavu	Congolaise (RDC)	therese.kalala@etu.ucb.ac.cd	+243 970 100 012	Ibanda, Bukavu	1	Actif	2026-09-16
13	UCB/TRV/2024/001	KAMATE	NGOY	Éric	M	2003-06-03	Bukavu	Congolaise (RDC)	eric.kamate@etu.ucb.ac.cd	+243 970 100 013	Bagira, Bukavu	20	Actif	2026-09-16
14	UCB/TRV/2024/002	TSHIBANGU	MULONGO	Solange	F	2004-05-21	Bukavu	Congolaise (RDC)	solange.tshibangu@etu.ucb.ac.cd	+243 970 100 014	Kadutu, Bukavu	20	Actif	2026-09-16
15	UCB/ARC/2024/001	MWEZE	CIBALONZA	Patrick	M	2003-08-15	Bukavu	Congolaise (RDC)	patrick.mweze@etu.ucb.ac.cd	+243 970 100 015	Ibanda, Bukavu	23	Actif	2026-09-16
16	UCB/ARC/2024/002	NSHIMIYE	BAHATI	Grâce	F	2004-09-30	Bukavu	Congolaise (RDC)	grace.nshimiye@etu.ucb.ac.cd	+243 970 100 016	Bagira, Bukavu	23	Actif	2026-09-16
\.


--
-- TOC entry 5223 (class 0 OID 16662)
-- Dependencies: 246
-- Data for Name: evaluation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.evaluation (id_evaluation, id_enseignement, type_evaluation, date_evaluation, ponderation) FROM stdin;
1	1	Interrogation	2024-10-15	20.00
2	1	TP	2024-11-10	20.00
3	1	Examen	2024-12-20	60.00
4	2	Interrogation	2024-10-20	20.00
5	2	Examen	2024-12-18	80.00
6	3	TP	2024-11-05	30.00
7	3	Examen	2024-12-22	70.00
8	4	TD	2024-11-15	30.00
9	4	Examen	2024-12-19	70.00
10	5	Interrogation	2025-03-10	20.00
11	5	Examen	2025-05-25	80.00
12	6	TP	2025-03-15	40.00
13	6	Examen	2025-05-28	60.00
14	7	Interrogation	2024-10-18	30.00
15	7	Examen	2024-12-21	70.00
16	8	Travail	2024-11-12	30.00
17	8	Examen	2024-12-23	70.00
18	9	Examen	2025-05-20	100.00
19	10	Examen	2025-05-22	100.00
20	11	Interrogation	2024-10-22	25.00
21	11	Examen	2024-12-17	75.00
22	12	TD	2024-11-08	30.00
23	12	Examen	2024-12-16	70.00
24	13	Examen	2025-05-15	100.00
25	14	Examen	2025-05-18	100.00
26	15	Interrogation	2024-10-25	20.00
27	15	Examen	2024-12-15	80.00
28	16	TP	2024-11-20	20.00
29	16	Examen	2024-12-14	80.00
30	17	Examen	2025-05-12	100.00
31	18	Interrogation	2024-10-28	30.00
32	18	Examen	2024-12-13	70.00
33	19	TD	2024-11-18	30.00
34	19	Examen	2024-12-12	70.00
35	20	Examen	2025-05-10	100.00
36	21	Interrogation	2024-10-30	30.00
37	21	Examen	2024-12-11	70.00
38	22	Examen	2025-05-08	100.00
39	23	TP	2024-11-25	40.00
40	23	Examen	2024-12-10	60.00
41	24	Examen	2025-05-05	100.00
\.


--
-- TOC entry 5199 (class 0 OID 16405)
-- Dependencies: 222
-- Data for Name: faculte; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.faculte (id_faculte, id_universite, nom, sigle, doyen, description) FROM stdin;
1	1	Faculté d'Agronomie	\N	\N	Sciences Agronomiques & Environnement
2	1	Faculté de Droit	\N	\N	Sciences Juridiques
3	1	Faculté d'Économie et de Gestion	\N	\N	Sciences Économiques et de Gestion
4	1	Faculté de Médecine	\N	\N	Sciences de la Santé
5	1	Faculté des Sciences & Technologies	\N	\N	Sciences et Technologie
6	1	Faculté des Sciences Sociales	\N	\N	Sciences de l'Homme et de la Société
7	1	École d'Architecture et Urbanisme	\N	\N	Architecture et gestion de l'espace urbain
8	1	École de Criminologie	\N	\N	Sciences criminologiques
9	1	École Régionale de Santé Publique	\N	\N	Santé publique régionale (3e cycle)
\.


--
-- TOC entry 5203 (class 0 OID 16443)
-- Dependencies: 226
-- Data for Name: filiere; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.filiere (id_filiere, id_departement, nom, sigle, cycle, duree_annees, description) FROM stdin;
1	1	Sciences Agronomiques	\N	Licence	5	\N
2	2	Gestion des Eaux et Assainissement	\N	Licence	5	\N
3	3	Écologie et Biodiversité	\N	Licence	5	\N
4	4	Sciences du Sol	\N	Licence	5	\N
5	5	Droit Économique et des Affaires	\N	Licence	5	\N
6	6	Droit Privé et Judiciaire	\N	Licence	5	\N
7	7	Droit Public	\N	Licence	5	\N
8	8	Économie de Développement	\N	Licence	5	\N
9	9	Économie Rurale	\N	Licence	5	\N
10	10	Économie Publique	\N	Licence	5	\N
11	11	Gestion Financière	\N	Licence	5	\N
12	12	Comptabilité et Audit	\N	Licence	5	\N
13	13	Entrepreneuriat	\N	Licence	5	\N
14	14	Sciences Biomédicales	\N	Licence	5	\N
15	15	Santé Publique	\N	Licence	5	\N
16	16	Médecine Humaine	\N	Licence	7	\N
17	17	Sciences Informatiques	\N	Licence	5	\N
18	18	Sciences de l'Environnement	\N	Licence	5	\N
19	19	Polytechnique	\N	Licence	5	\N
20	20	Sciences du Travail	\N	Licence	5	\N
21	21	Information et Communication	\N	Licence	5	\N
22	22	Étude de Paix et Conflits	\N	Licence	5	\N
23	23	Architecture	\N	Licence	5	\N
24	24	Urbanisme	\N	Licence	5	\N
25	25	Criminologie	\N	Licence	5	\N
26	26	Santé Publique (3e cycle)	\N	Master	2	\N
\.


--
-- TOC entry 5213 (class 0 OID 16527)
-- Dependencies: 236
-- Data for Name: inscription; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inscription (id_inscription, id_etudiant, id_annee, id_niveau, date_inscription, statut, id_cours) FROM stdin;
1	1	1	1	2024-09-15	Inscrit	1
2	1	1	1	2024-09-15	Inscrit	2
3	1	1	1	2024-09-15	Inscrit	3
4	1	1	1	2024-09-15	Inscrit	4
5	2	1	1	2024-09-16	Inscrit	1
6	2	1	1	2024-09-16	Inscrit	2
7	2	1	1	2024-09-16	Inscrit	3
8	2	1	1	2024-09-16	Inscrit	4
9	3	1	2	2024-09-17	Inscrit	3
10	3	1	2	2024-09-17	Inscrit	4
11	3	1	2	2024-09-17	Inscrit	5
12	3	1	2	2024-09-17	Inscrit	6
13	4	1	1	2024-09-18	Inscrit	7
14	4	1	1	2024-09-18	Inscrit	8
15	5	1	1	2024-09-19	Inscrit	7
16	5	1	1	2024-09-19	Inscrit	8
17	6	1	1	2024-09-20	Inscrit	11
18	6	1	1	2024-09-20	Inscrit	12
19	7	1	1	2024-09-21	Inscrit	11
20	7	1	1	2024-09-21	Inscrit	12
21	8	1	2	2024-09-22	Inscrit	13
22	8	1	2	2024-09-22	Inscrit	14
23	9	1	1	2024-09-23	Inscrit	15
24	9	1	1	2024-09-23	Inscrit	16
25	10	1	1	2024-09-24	Inscrit	15
26	10	1	1	2024-09-24	Inscrit	16
27	11	1	1	2024-09-25	Inscrit	18
28	11	1	1	2024-09-25	Inscrit	19
29	12	1	1	2024-09-26	Inscrit	18
30	12	1	1	2024-09-26	Inscrit	19
31	13	1	1	2024-09-27	Inscrit	21
32	13	1	1	2024-09-27	Inscrit	22
33	14	1	1	2024-09-28	Inscrit	21
34	14	1	1	2024-09-28	Inscrit	22
35	15	1	1	2024-09-29	Inscrit	23
36	15	1	1	2024-09-29	Inscrit	24
37	16	1	1	2024-09-30	Inscrit	23
38	16	1	1	2024-09-30	Inscrit	24
\.


--
-- TOC entry 5231 (class 0 OID 16767)
-- Dependencies: 254
-- Data for Name: moyenne_annuelle; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.moyenne_annuelle (id_moyenne_annuelle, id_etudiant, id_annee, moyenne, credits_obtenus, decision) FROM stdin;
1	1	1	14.10	60	Admis
2	2	1	13.20	60	Admis
3	3	1	14.30	60	Admis
4	4	1	13.75	60	Admis
5	5	1	12.30	60	Admis
6	6	1	15.70	60	Admis
7	7	1	13.30	60	Admis
8	8	1	13.00	60	Admis
9	9	1	15.20	60	Admis
10	10	1	13.55	60	Admis
11	11	1	13.70	60	Admis
12	12	1	15.70	60	Admis
13	13	1	13.50	60	Admis
14	14	1	13.00	60	Admis
15	15	1	14.00	60	Admis
16	16	1	13.50	60	Admis
\.


--
-- TOC entry 5229 (class 0 OID 16736)
-- Dependencies: 252
-- Data for Name: moyenne_semestre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.moyenne_semestre (id_moyenne_semestre, id_etudiant, id_semestre, id_annee, moyenne, credits_obtenus) FROM stdin;
1	1	1	1	14.10	30
2	2	1	1	13.20	30
3	3	1	1	14.30	30
4	4	1	1	13.75	30
5	5	1	1	12.30	30
6	6	1	1	15.70	30
7	7	1	1	13.30	30
8	8	1	1	13.00	30
9	9	1	1	15.20	30
10	10	1	1	13.55	30
11	11	1	1	13.70	30
12	12	1	1	15.70	30
13	13	1	1	13.50	30
14	14	1	1	13.00	30
15	15	1	1	14.00	30
16	16	1	1	13.50	30
\.


--
-- TOC entry 5205 (class 0 OID 16465)
-- Dependencies: 228
-- Data for Name: niveau; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.niveau (id_niveau, libelle, ordre) FROM stdin;
1	Licence 1	1
2	Licence 2	2
3	Licence 3	3
4	Master 1	4
5	Master 2	5
6	Doctorat 1	6
\.


--
-- TOC entry 5225 (class 0 OID 16681)
-- Dependencies: 248
-- Data for Name: note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.note (id_note, id_etudiant, id_evaluation, valeur, observation) FROM stdin;
1	1	1	14.00	Bon travail
2	1	2	15.50	TP réussi
3	1	3	13.75	Examen correct
4	2	1	12.00	Passable
5	2	2	16.00	Excellent TP
6	2	3	14.50	Bien
7	1	4	15.00	Bon
8	1	5	14.00	Bien
9	2	4	11.00	Juste
10	2	5	12.50	Passable
11	3	6	16.00	Très bon TP
12	3	7	15.00	Bien
13	3	8	14.00	Bon TD
14	3	9	13.00	Correct
15	4	14	13.00	Correct
16	4	15	14.00	Bien
17	5	14	15.00	Très bon
18	5	15	12.00	Passable
19	4	16	14.50	Bon travail
20	4	17	13.50	Correct
21	5	16	12.00	Passable
22	5	17	11.50	Juste
23	6	20	16.00	Excellent
24	6	21	15.00	Bien
25	7	20	13.00	Correct
26	7	21	14.00	Bien
27	6	22	15.50	Très bon TD
28	6	23	16.50	Excellent
29	7	22	12.50	Passable
30	7	23	13.00	Correct
31	9	26	14.00	Bon
32	9	27	15.00	Bien
33	10	26	13.50	Correct
34	10	27	14.50	Bien
35	9	28	16.00	Très bon TP
36	9	29	15.50	Excellent
37	10	28	12.00	Passable
38	10	29	13.00	Correct
39	11	31	13.00	Correct
40	11	32	14.00	Bien
41	12	31	15.00	Très bon
42	12	32	16.00	Excellent
\.


--
-- TOC entry 5235 (class 0 OID 16806)
-- Dependencies: 258
-- Data for Name: perequation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.perequation (id_perequation, id_etudiant, id_cours, id_annee, ancienne_moyenne, nouvelle_moyenne, justification, date_perequation) FROM stdin;
1	5	7	1	9.50	10.00	Compensation appliquée - moyenne générale satisfaisante	2026-09-17
2	8	11	1	9.00	10.00	Compensation appliquée - efforts constatés	2026-09-17
\.


--
-- TOC entry 5217 (class 0 OID 16580)
-- Dependencies: 240
-- Data for Name: programme_cours; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.programme_cours (id_programme, id_cours, id_niveau, id_semestre, id_annee) FROM stdin;
\.


--
-- TOC entry 5241 (class 0 OID 16887)
-- Dependencies: 264
-- Data for Name: recommandation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recommandation (id_recommandation, id_etudiant, type_recommandation, contenu, priorite, lue, date_recommandation) FROM stdin;
1	1	Félicitations	Excellent parcours en informatique. Continuez ainsi et envisagez une spécialisation en génie logiciel.	Normale	f	2026-09-17 03:13:48.217621
2	2	Soutien	Des difficultés en INF102. Un renforcement en algorithmique est recommandé.	Haute	f	2026-09-17 03:13:48.217621
3	5	Soutien	Compensation appliquée en Droit. Un travail supplémentaire en droit des obligations est conseillé.	Haute	f	2026-09-17 03:13:48.217621
4	6	Félicitations	Résultats remarquables en Gestion Financière. Pensez à l'audit ou à la finance internationale.	Normale	f	2026-09-17 03:13:48.217621
5	8	Soutien	Un soutien en comptabilité est recommandé pour consolider les bases.	Normale	f	2026-09-17 03:13:48.217621
6	9	Félicitations	Très bon niveau en Médecine. Orientation vers la recherche médicale possible.	Normale	f	2026-09-17 03:13:48.217621
7	12	Félicitations	Excellents résultats en Agronomie. Envisagez une spécialisation en production végétale.	Normale	f	2026-09-17 03:13:48.217621
8	5	Avertissement	Attention à la régularité du travail en Droit Public.	Haute	f	2026-09-17 03:13:48.217621
\.


--
-- TOC entry 5233 (class 0 OID 16792)
-- Dependencies: 256
-- Data for Name: regle_academique; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.regle_academique (id_regle, titre, description, condition_regle, consequence, active, date_creation) FROM stdin;
1	Seuil de passage	La moyenne minimale pour valider une année est de 10/20.	moyenne_annuelle >= 10	Admis en année supérieure	t	2026-09-17
2	Seuil de compensation	Une note entre 8 et 10 peut être compensée si la moyenne générale est >= 10.	note BETWEEN 8 AND 10 AND moyenne_generale >= 10	Cours compensé	t	2026-09-17
3	Crédits minimum	Un étudiant doit valider au moins 60 crédits par an pour passer.	credits_obtenus >= 60	Passage autorisé	t	2026-09-17
4	Ajournement	Un étudiant avec une moyenne < 10 est ajourné.	moyenne_annuelle < 10	Ajourné - redouble	t	2026-09-17
5	Exclusion	Un étudiant ajourné 2 fois de suite peut être exclu.	echecs_consecutifs >= 2	Exclusion définitive	t	2026-09-17
6	Mention Distinction	Mention Distinction à partir de 14/20.	moyenne_annuelle >= 14	Mention Distinction	t	2026-09-17
7	Mention Satisfaction	Mention Satisfaction entre 12 et 14.	moyenne_annuelle BETWEEN 12 AND 14	Mention Satisfaction	t	2026-09-17
\.


--
-- TOC entry 5227 (class 0 OID 16707)
-- Dependencies: 250
-- Data for Name: resultat_cours; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resultat_cours (id_resultat, id_etudiant, id_cours, id_annee, moyenne, statut) FROM stdin;
1	1	1	1	14.05	Validé
2	1	2	1	14.20	Validé
3	2	1	1	14.20	Validé
4	2	2	1	12.20	Validé
5	3	3	1	15.30	Validé
6	3	4	1	13.30	Validé
7	4	7	1	13.70	Validé
8	4	8	1	13.80	Validé
9	5	7	1	12.90	Validé
10	5	8	1	11.65	Validé
11	6	11	1	15.25	Validé
12	6	12	1	16.20	Validé
13	7	11	1	13.75	Validé
14	7	12	1	12.85	Validé
15	9	15	1	14.80	Validé
16	9	16	1	15.60	Validé
17	10	15	1	14.30	Validé
18	10	16	1	12.80	Validé
19	11	18	1	13.70	Validé
20	12	18	1	15.70	Validé
\.


--
-- TOC entry 5209 (class 0 OID 16488)
-- Dependencies: 232
-- Data for Name: semestre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.semestre (id_semestre, libelle, ordre) FROM stdin;
1	Semestre 1	1
2	Semestre 2	2
\.


--
-- TOC entry 5197 (class 0 OID 16390)
-- Dependencies: 220
-- Data for Name: universite; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.universite (id_universite, nom, sigle, adresse, ville, pays, telephone, email, site_web, date_creation) FROM stdin;
1	Université Catholique de Bukavu	UCB	\N	Bukavu	RDC	\N	\N	https://ucbukavu.ac.cd	2026-09-16
\.


--
-- TOC entry 5239 (class 0 OID 16862)
-- Dependencies: 262
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateur (id_utilisateur, nom_utilisateur, mot_de_passe, role, id_etudiant, id_enseignant, date_creation) FROM stdin;
1	admin	$2b$12$hash_admin	admin	\N	\N	2026-09-17 02:59:37.978796
2	jkabuya	$2b$12$hash_kabuya	enseignant	\N	1	2026-09-17 02:59:37.978796
3	pmutombo	$2b$12$hash_mutombo	enseignant	\N	2	2026-09-17 02:59:37.978796
4	mngoy	$2b$12$hash_ngoy	enseignant	\N	3	2026-09-17 02:59:37.978796
5	jmukendi	$2b$12$hash_etudiant1	etudiant	1	\N	2026-09-17 02:59:37.978796
6	sngoy	$2b$12$hash_etudiant2	etudiant	2	\N	2026-09-17 02:59:37.978796
\.


--
-- TOC entry 5293 (class 0 OID 0)
-- Dependencies: 229
-- Name: annee_academique_id_annee_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.annee_academique_id_annee_seq', 1, false);


--
-- TOC entry 5294 (class 0 OID 0)
-- Dependencies: 237
-- Name: cours_id_cours_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cours_id_cours_seq', 1, false);


--
-- TOC entry 5295 (class 0 OID 0)
-- Dependencies: 259
-- Name: decision_academique_id_decision_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.decision_academique_id_decision_seq', 1, false);


--
-- TOC entry 5296 (class 0 OID 0)
-- Dependencies: 223
-- Name: departement_id_departement_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.departement_id_departement_seq', 1, false);


--
-- TOC entry 5297 (class 0 OID 0)
-- Dependencies: 241
-- Name: enseignant_id_enseignant_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enseignant_id_enseignant_seq', 1, false);


--
-- TOC entry 5298 (class 0 OID 0)
-- Dependencies: 243
-- Name: enseignement_id_enseignement_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enseignement_id_enseignement_seq', 1, false);


--
-- TOC entry 5299 (class 0 OID 0)
-- Dependencies: 233
-- Name: etudiant_id_etudiant_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.etudiant_id_etudiant_seq', 1, false);


--
-- TOC entry 5300 (class 0 OID 0)
-- Dependencies: 245
-- Name: evaluation_id_evaluation_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.evaluation_id_evaluation_seq', 1, false);


--
-- TOC entry 5301 (class 0 OID 0)
-- Dependencies: 221
-- Name: faculte_id_faculte_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.faculte_id_faculte_seq', 1, false);


--
-- TOC entry 5302 (class 0 OID 0)
-- Dependencies: 225
-- Name: filiere_id_filiere_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.filiere_id_filiere_seq', 1, false);


--
-- TOC entry 5303 (class 0 OID 0)
-- Dependencies: 235
-- Name: inscription_id_inscription_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inscription_id_inscription_seq', 1, false);


--
-- TOC entry 5304 (class 0 OID 0)
-- Dependencies: 253
-- Name: moyenne_annuelle_id_moyenne_annuelle_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.moyenne_annuelle_id_moyenne_annuelle_seq', 1, false);


--
-- TOC entry 5305 (class 0 OID 0)
-- Dependencies: 251
-- Name: moyenne_semestre_id_moyenne_semestre_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.moyenne_semestre_id_moyenne_semestre_seq', 1, false);


--
-- TOC entry 5306 (class 0 OID 0)
-- Dependencies: 227
-- Name: niveau_id_niveau_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.niveau_id_niveau_seq', 1, false);


--
-- TOC entry 5307 (class 0 OID 0)
-- Dependencies: 247
-- Name: note_id_note_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.note_id_note_seq', 1, false);


--
-- TOC entry 5308 (class 0 OID 0)
-- Dependencies: 257
-- Name: perequation_id_perequation_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.perequation_id_perequation_seq', 1, false);


--
-- TOC entry 5309 (class 0 OID 0)
-- Dependencies: 239
-- Name: programme_cours_id_programme_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.programme_cours_id_programme_seq', 1, false);


--
-- TOC entry 5310 (class 0 OID 0)
-- Dependencies: 263
-- Name: recommandation_id_recommandation_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recommandation_id_recommandation_seq', 1, false);


--
-- TOC entry 5311 (class 0 OID 0)
-- Dependencies: 255
-- Name: regle_academique_id_regle_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.regle_academique_id_regle_seq', 1, false);


--
-- TOC entry 5312 (class 0 OID 0)
-- Dependencies: 249
-- Name: resultat_cours_id_resultat_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.resultat_cours_id_resultat_seq', 1, false);


--
-- TOC entry 5313 (class 0 OID 0)
-- Dependencies: 231
-- Name: semestre_id_semestre_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.semestre_id_semestre_seq', 1, false);


--
-- TOC entry 5314 (class 0 OID 0)
-- Dependencies: 219
-- Name: universite_id_universite_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.universite_id_universite_seq', 1, false);


--
-- TOC entry 5315 (class 0 OID 0)
-- Dependencies: 261
-- Name: utilisateur_id_utilisateur_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.utilisateur_id_utilisateur_seq', 1, false);


--
-- TOC entry 4950 (class 2606 OID 16486)
-- Name: annee_academique annee_academique_libelle_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.annee_academique
    ADD CONSTRAINT annee_academique_libelle_key UNIQUE (libelle);


--
-- TOC entry 4952 (class 2606 OID 16484)
-- Name: annee_academique annee_academique_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.annee_academique
    ADD CONSTRAINT annee_academique_pkey PRIMARY KEY (id_annee);


--
-- TOC entry 4966 (class 2606 OID 16573)
-- Name: cours cours_code_cours_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cours
    ADD CONSTRAINT cours_code_cours_key UNIQUE (code_cours);


--
-- TOC entry 4968 (class 2606 OID 16571)
-- Name: cours cours_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cours
    ADD CONSTRAINT cours_pkey PRIMARY KEY (id_cours);


--
-- TOC entry 5004 (class 2606 OID 16850)
-- Name: decision_academique decision_academique_id_etudiant_id_annee_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.decision_academique
    ADD CONSTRAINT decision_academique_id_etudiant_id_annee_key UNIQUE (id_etudiant, id_annee);


--
-- TOC entry 5006 (class 2606 OID 16848)
-- Name: decision_academique decision_academique_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.decision_academique
    ADD CONSTRAINT decision_academique_pkey PRIMARY KEY (id_decision);


--
-- TOC entry 4938 (class 2606 OID 16436)
-- Name: departement departement_id_faculte_nom_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departement
    ADD CONSTRAINT departement_id_faculte_nom_key UNIQUE (id_faculte, nom);


--
-- TOC entry 4940 (class 2606 OID 16434)
-- Name: departement departement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departement
    ADD CONSTRAINT departement_pkey PRIMARY KEY (id_departement);


--
-- TOC entry 4974 (class 2606 OID 16626)
-- Name: enseignant enseignant_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enseignant
    ADD CONSTRAINT enseignant_email_key UNIQUE (email);


--
-- TOC entry 4976 (class 2606 OID 16624)
-- Name: enseignant enseignant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enseignant
    ADD CONSTRAINT enseignant_pkey PRIMARY KEY (id_enseignant);


--
-- TOC entry 4978 (class 2606 OID 16640)
-- Name: enseignement enseignement_id_enseignant_id_cours_id_annee_id_semestre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enseignement
    ADD CONSTRAINT enseignement_id_enseignant_id_cours_id_annee_id_semestre_key UNIQUE (id_enseignant, id_cours, id_annee, id_semestre);


--
-- TOC entry 4980 (class 2606 OID 16638)
-- Name: enseignement enseignement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enseignement
    ADD CONSTRAINT enseignement_pkey PRIMARY KEY (id_enseignement);


--
-- TOC entry 4958 (class 2606 OID 16520)
-- Name: etudiant etudiant_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etudiant
    ADD CONSTRAINT etudiant_email_key UNIQUE (email);


--
-- TOC entry 4960 (class 2606 OID 16518)
-- Name: etudiant etudiant_matricule_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etudiant
    ADD CONSTRAINT etudiant_matricule_key UNIQUE (matricule);


--
-- TOC entry 4962 (class 2606 OID 16516)
-- Name: etudiant etudiant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etudiant
    ADD CONSTRAINT etudiant_pkey PRIMARY KEY (id_etudiant);


--
-- TOC entry 4982 (class 2606 OID 16674)
-- Name: evaluation evaluation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluation
    ADD CONSTRAINT evaluation_pkey PRIMARY KEY (id_evaluation);


--
-- TOC entry 4934 (class 2606 OID 16417)
-- Name: faculte faculte_id_universite_nom_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculte
    ADD CONSTRAINT faculte_id_universite_nom_key UNIQUE (id_universite, nom);


--
-- TOC entry 4936 (class 2606 OID 16415)
-- Name: faculte faculte_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculte
    ADD CONSTRAINT faculte_pkey PRIMARY KEY (id_faculte);


--
-- TOC entry 4942 (class 2606 OID 16458)
-- Name: filiere filiere_id_departement_nom_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filiere
    ADD CONSTRAINT filiere_id_departement_nom_key UNIQUE (id_departement, nom);


--
-- TOC entry 4944 (class 2606 OID 16456)
-- Name: filiere filiere_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filiere
    ADD CONSTRAINT filiere_pkey PRIMARY KEY (id_filiere);


--
-- TOC entry 4964 (class 2606 OID 16539)
-- Name: inscription inscription_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscription
    ADD CONSTRAINT inscription_pkey PRIMARY KEY (id_inscription);


--
-- TOC entry 4996 (class 2606 OID 16780)
-- Name: moyenne_annuelle moyenne_annuelle_id_etudiant_id_annee_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moyenne_annuelle
    ADD CONSTRAINT moyenne_annuelle_id_etudiant_id_annee_key UNIQUE (id_etudiant, id_annee);


--
-- TOC entry 4998 (class 2606 OID 16778)
-- Name: moyenne_annuelle moyenne_annuelle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moyenne_annuelle
    ADD CONSTRAINT moyenne_annuelle_pkey PRIMARY KEY (id_moyenne_annuelle);


--
-- TOC entry 4992 (class 2606 OID 16750)
-- Name: moyenne_semestre moyenne_semestre_id_etudiant_id_semestre_id_annee_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moyenne_semestre
    ADD CONSTRAINT moyenne_semestre_id_etudiant_id_semestre_id_annee_key UNIQUE (id_etudiant, id_semestre, id_annee);


--
-- TOC entry 4994 (class 2606 OID 16748)
-- Name: moyenne_semestre moyenne_semestre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moyenne_semestre
    ADD CONSTRAINT moyenne_semestre_pkey PRIMARY KEY (id_moyenne_semestre);


--
-- TOC entry 4946 (class 2606 OID 16474)
-- Name: niveau niveau_libelle_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.niveau
    ADD CONSTRAINT niveau_libelle_key UNIQUE (libelle);


--
-- TOC entry 4948 (class 2606 OID 16472)
-- Name: niveau niveau_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.niveau
    ADD CONSTRAINT niveau_pkey PRIMARY KEY (id_niveau);


--
-- TOC entry 4984 (class 2606 OID 16695)
-- Name: note note_id_etudiant_id_evaluation_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.note
    ADD CONSTRAINT note_id_etudiant_id_evaluation_key UNIQUE (id_etudiant, id_evaluation);


--
-- TOC entry 4986 (class 2606 OID 16693)
-- Name: note note_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.note
    ADD CONSTRAINT note_pkey PRIMARY KEY (id_note);


--
-- TOC entry 5002 (class 2606 OID 16818)
-- Name: perequation perequation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perequation
    ADD CONSTRAINT perequation_pkey PRIMARY KEY (id_perequation);


--
-- TOC entry 4970 (class 2606 OID 16592)
-- Name: programme_cours programme_cours_id_cours_id_niveau_id_semestre_id_annee_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.programme_cours
    ADD CONSTRAINT programme_cours_id_cours_id_niveau_id_semestre_id_annee_key UNIQUE (id_cours, id_niveau, id_semestre, id_annee);


--
-- TOC entry 4972 (class 2606 OID 16590)
-- Name: programme_cours programme_cours_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.programme_cours
    ADD CONSTRAINT programme_cours_pkey PRIMARY KEY (id_programme);


--
-- TOC entry 5012 (class 2606 OID 16902)
-- Name: recommandation recommandation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recommandation
    ADD CONSTRAINT recommandation_pkey PRIMARY KEY (id_recommandation);


--
-- TOC entry 5000 (class 2606 OID 16804)
-- Name: regle_academique regle_academique_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regle_academique
    ADD CONSTRAINT regle_academique_pkey PRIMARY KEY (id_regle);


--
-- TOC entry 4988 (class 2606 OID 16719)
-- Name: resultat_cours resultat_cours_id_etudiant_id_cours_id_annee_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resultat_cours
    ADD CONSTRAINT resultat_cours_id_etudiant_id_cours_id_annee_key UNIQUE (id_etudiant, id_cours, id_annee);


--
-- TOC entry 4990 (class 2606 OID 16717)
-- Name: resultat_cours resultat_cours_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resultat_cours
    ADD CONSTRAINT resultat_cours_pkey PRIMARY KEY (id_resultat);


--
-- TOC entry 4954 (class 2606 OID 16497)
-- Name: semestre semestre_libelle_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.semestre
    ADD CONSTRAINT semestre_libelle_key UNIQUE (libelle);


--
-- TOC entry 4956 (class 2606 OID 16495)
-- Name: semestre semestre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.semestre
    ADD CONSTRAINT semestre_pkey PRIMARY KEY (id_semestre);


--
-- TOC entry 4930 (class 2606 OID 16403)
-- Name: universite universite_nom_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.universite
    ADD CONSTRAINT universite_nom_key UNIQUE (nom);


--
-- TOC entry 4932 (class 2606 OID 16401)
-- Name: universite universite_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.universite
    ADD CONSTRAINT universite_pkey PRIMARY KEY (id_universite);


--
-- TOC entry 5008 (class 2606 OID 16875)
-- Name: utilisateur utilisateur_nom_utilisateur_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_nom_utilisateur_key UNIQUE (nom_utilisateur);


--
-- TOC entry 5010 (class 2606 OID 16873)
-- Name: utilisateur utilisateur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_pkey PRIMARY KEY (id_utilisateur);


--
-- TOC entry 5021 (class 2606 OID 16574)
-- Name: cours cours_id_filiere_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cours
    ADD CONSTRAINT cours_id_filiere_fkey FOREIGN KEY (id_filiere) REFERENCES public.filiere(id_filiere) ON DELETE CASCADE;


--
-- TOC entry 5044 (class 2606 OID 16856)
-- Name: decision_academique decision_academique_id_annee_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.decision_academique
    ADD CONSTRAINT decision_academique_id_annee_fkey FOREIGN KEY (id_annee) REFERENCES public.annee_academique(id_annee) ON DELETE RESTRICT;


--
-- TOC entry 5045 (class 2606 OID 16851)
-- Name: decision_academique decision_academique_id_etudiant_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.decision_academique
    ADD CONSTRAINT decision_academique_id_etudiant_fkey FOREIGN KEY (id_etudiant) REFERENCES public.etudiant(id_etudiant) ON DELETE CASCADE;


--
-- TOC entry 5014 (class 2606 OID 16437)
-- Name: departement departement_id_faculte_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departement
    ADD CONSTRAINT departement_id_faculte_fkey FOREIGN KEY (id_faculte) REFERENCES public.faculte(id_faculte) ON DELETE CASCADE;


--
-- TOC entry 5026 (class 2606 OID 16651)
-- Name: enseignement enseignement_id_annee_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enseignement
    ADD CONSTRAINT enseignement_id_annee_fkey FOREIGN KEY (id_annee) REFERENCES public.annee_academique(id_annee) ON DELETE RESTRICT;


--
-- TOC entry 5027 (class 2606 OID 16646)
-- Name: enseignement enseignement_id_cours_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enseignement
    ADD CONSTRAINT enseignement_id_cours_fkey FOREIGN KEY (id_cours) REFERENCES public.cours(id_cours) ON DELETE CASCADE;


--
-- TOC entry 5028 (class 2606 OID 16641)
-- Name: enseignement enseignement_id_enseignant_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enseignement
    ADD CONSTRAINT enseignement_id_enseignant_fkey FOREIGN KEY (id_enseignant) REFERENCES public.enseignant(id_enseignant) ON DELETE CASCADE;


--
-- TOC entry 5029 (class 2606 OID 16656)
-- Name: enseignement enseignement_id_semestre_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enseignement
    ADD CONSTRAINT enseignement_id_semestre_fkey FOREIGN KEY (id_semestre) REFERENCES public.semestre(id_semestre) ON DELETE RESTRICT;


--
-- TOC entry 5016 (class 2606 OID 16521)
-- Name: etudiant etudiant_id_filiere_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etudiant
    ADD CONSTRAINT etudiant_id_filiere_fkey FOREIGN KEY (id_filiere) REFERENCES public.filiere(id_filiere) ON DELETE RESTRICT;


--
-- TOC entry 5030 (class 2606 OID 16675)
-- Name: evaluation evaluation_id_enseignement_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evaluation
    ADD CONSTRAINT evaluation_id_enseignement_fkey FOREIGN KEY (id_enseignement) REFERENCES public.enseignement(id_enseignement) ON DELETE CASCADE;


--
-- TOC entry 5013 (class 2606 OID 16418)
-- Name: faculte faculte_id_universite_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculte
    ADD CONSTRAINT faculte_id_universite_fkey FOREIGN KEY (id_universite) REFERENCES public.universite(id_universite) ON DELETE CASCADE;


--
-- TOC entry 5015 (class 2606 OID 16459)
-- Name: filiere filiere_id_departement_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filiere
    ADD CONSTRAINT filiere_id_departement_fkey FOREIGN KEY (id_departement) REFERENCES public.departement(id_departement) ON DELETE CASCADE;


--
-- TOC entry 5017 (class 2606 OID 16547)
-- Name: inscription inscription_id_annee_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscription
    ADD CONSTRAINT inscription_id_annee_fkey FOREIGN KEY (id_annee) REFERENCES public.annee_academique(id_annee) ON DELETE RESTRICT;


--
-- TOC entry 5018 (class 2606 OID 17011)
-- Name: inscription inscription_id_cours_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscription
    ADD CONSTRAINT inscription_id_cours_fkey FOREIGN KEY (id_cours) REFERENCES public.cours(id_cours) ON DELETE CASCADE;


--
-- TOC entry 5019 (class 2606 OID 16542)
-- Name: inscription inscription_id_etudiant_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscription
    ADD CONSTRAINT inscription_id_etudiant_fkey FOREIGN KEY (id_etudiant) REFERENCES public.etudiant(id_etudiant) ON DELETE CASCADE;


--
-- TOC entry 5020 (class 2606 OID 16552)
-- Name: inscription inscription_id_niveau_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscription
    ADD CONSTRAINT inscription_id_niveau_fkey FOREIGN KEY (id_niveau) REFERENCES public.niveau(id_niveau) ON DELETE RESTRICT;


--
-- TOC entry 5039 (class 2606 OID 16786)
-- Name: moyenne_annuelle moyenne_annuelle_id_annee_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moyenne_annuelle
    ADD CONSTRAINT moyenne_annuelle_id_annee_fkey FOREIGN KEY (id_annee) REFERENCES public.annee_academique(id_annee) ON DELETE RESTRICT;


--
-- TOC entry 5040 (class 2606 OID 16781)
-- Name: moyenne_annuelle moyenne_annuelle_id_etudiant_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moyenne_annuelle
    ADD CONSTRAINT moyenne_annuelle_id_etudiant_fkey FOREIGN KEY (id_etudiant) REFERENCES public.etudiant(id_etudiant) ON DELETE CASCADE;


--
-- TOC entry 5036 (class 2606 OID 16761)
-- Name: moyenne_semestre moyenne_semestre_id_annee_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moyenne_semestre
    ADD CONSTRAINT moyenne_semestre_id_annee_fkey FOREIGN KEY (id_annee) REFERENCES public.annee_academique(id_annee) ON DELETE RESTRICT;


--
-- TOC entry 5037 (class 2606 OID 16751)
-- Name: moyenne_semestre moyenne_semestre_id_etudiant_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moyenne_semestre
    ADD CONSTRAINT moyenne_semestre_id_etudiant_fkey FOREIGN KEY (id_etudiant) REFERENCES public.etudiant(id_etudiant) ON DELETE CASCADE;


--
-- TOC entry 5038 (class 2606 OID 16756)
-- Name: moyenne_semestre moyenne_semestre_id_semestre_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moyenne_semestre
    ADD CONSTRAINT moyenne_semestre_id_semestre_fkey FOREIGN KEY (id_semestre) REFERENCES public.semestre(id_semestre) ON DELETE RESTRICT;


--
-- TOC entry 5031 (class 2606 OID 16696)
-- Name: note note_id_etudiant_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.note
    ADD CONSTRAINT note_id_etudiant_fkey FOREIGN KEY (id_etudiant) REFERENCES public.etudiant(id_etudiant) ON DELETE CASCADE;


--
-- TOC entry 5032 (class 2606 OID 16701)
-- Name: note note_id_evaluation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.note
    ADD CONSTRAINT note_id_evaluation_fkey FOREIGN KEY (id_evaluation) REFERENCES public.evaluation(id_evaluation) ON DELETE CASCADE;


--
-- TOC entry 5041 (class 2606 OID 16829)
-- Name: perequation perequation_id_annee_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perequation
    ADD CONSTRAINT perequation_id_annee_fkey FOREIGN KEY (id_annee) REFERENCES public.annee_academique(id_annee) ON DELETE SET NULL;


--
-- TOC entry 5042 (class 2606 OID 16824)
-- Name: perequation perequation_id_cours_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perequation
    ADD CONSTRAINT perequation_id_cours_fkey FOREIGN KEY (id_cours) REFERENCES public.cours(id_cours) ON DELETE SET NULL;


--
-- TOC entry 5043 (class 2606 OID 16819)
-- Name: perequation perequation_id_etudiant_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perequation
    ADD CONSTRAINT perequation_id_etudiant_fkey FOREIGN KEY (id_etudiant) REFERENCES public.etudiant(id_etudiant) ON DELETE CASCADE;


--
-- TOC entry 5022 (class 2606 OID 16608)
-- Name: programme_cours programme_cours_id_annee_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.programme_cours
    ADD CONSTRAINT programme_cours_id_annee_fkey FOREIGN KEY (id_annee) REFERENCES public.annee_academique(id_annee) ON DELETE RESTRICT;


--
-- TOC entry 5023 (class 2606 OID 16593)
-- Name: programme_cours programme_cours_id_cours_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.programme_cours
    ADD CONSTRAINT programme_cours_id_cours_fkey FOREIGN KEY (id_cours) REFERENCES public.cours(id_cours) ON DELETE CASCADE;


--
-- TOC entry 5024 (class 2606 OID 16598)
-- Name: programme_cours programme_cours_id_niveau_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.programme_cours
    ADD CONSTRAINT programme_cours_id_niveau_fkey FOREIGN KEY (id_niveau) REFERENCES public.niveau(id_niveau) ON DELETE RESTRICT;


--
-- TOC entry 5025 (class 2606 OID 16603)
-- Name: programme_cours programme_cours_id_semestre_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.programme_cours
    ADD CONSTRAINT programme_cours_id_semestre_fkey FOREIGN KEY (id_semestre) REFERENCES public.semestre(id_semestre) ON DELETE RESTRICT;


--
-- TOC entry 5048 (class 2606 OID 16903)
-- Name: recommandation recommandation_id_etudiant_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recommandation
    ADD CONSTRAINT recommandation_id_etudiant_fkey FOREIGN KEY (id_etudiant) REFERENCES public.etudiant(id_etudiant) ON DELETE CASCADE;


--
-- TOC entry 5033 (class 2606 OID 16730)
-- Name: resultat_cours resultat_cours_id_annee_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resultat_cours
    ADD CONSTRAINT resultat_cours_id_annee_fkey FOREIGN KEY (id_annee) REFERENCES public.annee_academique(id_annee) ON DELETE SET NULL;


--
-- TOC entry 5034 (class 2606 OID 16725)
-- Name: resultat_cours resultat_cours_id_cours_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resultat_cours
    ADD CONSTRAINT resultat_cours_id_cours_fkey FOREIGN KEY (id_cours) REFERENCES public.cours(id_cours) ON DELETE CASCADE;


--
-- TOC entry 5035 (class 2606 OID 16720)
-- Name: resultat_cours resultat_cours_id_etudiant_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resultat_cours
    ADD CONSTRAINT resultat_cours_id_etudiant_fkey FOREIGN KEY (id_etudiant) REFERENCES public.etudiant(id_etudiant) ON DELETE CASCADE;


--
-- TOC entry 5046 (class 2606 OID 16881)
-- Name: utilisateur utilisateur_id_enseignant_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_id_enseignant_fkey FOREIGN KEY (id_enseignant) REFERENCES public.enseignant(id_enseignant) ON DELETE SET NULL;


--
-- TOC entry 5047 (class 2606 OID 16876)
-- Name: utilisateur utilisateur_id_etudiant_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_id_etudiant_fkey FOREIGN KEY (id_etudiant) REFERENCES public.etudiant(id_etudiant) ON DELETE SET NULL;


-- Completed on 2026-09-16 15:30:36

--
-- PostgreSQL database dump complete
--

\unrestrict yQg8fVzXTtR0iaNnpJzWZU9UoPELFK40WIaIvRoM3UATwUMpJnNpzq08FEtIuzG

