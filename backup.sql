--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.20
-- Dumped by pg_dump version 9.6.20

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
-- Name: audit; Type: SCHEMA; Schema: -; Owner: maarch
--

CREATE SCHEMA audit;


ALTER SCHEMA audit OWNER TO maarch;

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: maarch
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO maarch;

--
-- Name: batchProcessing; Type: SCHEMA; Schema: -; Owner: maarch
--

CREATE SCHEMA "batchProcessing";


ALTER SCHEMA "batchProcessing" OWNER TO maarch;

--
-- Name: contact; Type: SCHEMA; Schema: -; Owner: maarch
--

CREATE SCHEMA contact;


ALTER SCHEMA contact OWNER TO maarch;

--
-- Name: digitalResource; Type: SCHEMA; Schema: -; Owner: maarch
--

CREATE SCHEMA "digitalResource";


ALTER SCHEMA "digitalResource" OWNER TO maarch;

--
-- Name: filePlan; Type: SCHEMA; Schema: -; Owner: maarch
--

CREATE SCHEMA "filePlan";


ALTER SCHEMA "filePlan" OWNER TO maarch;

--
-- Name: lifeCycle; Type: SCHEMA; Schema: -; Owner: maarch
--

CREATE SCHEMA "lifeCycle";


ALTER SCHEMA "lifeCycle" OWNER TO maarch;

--
-- Name: medona; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA medona;


ALTER SCHEMA medona OWNER TO postgres;

--
-- Name: organization; Type: SCHEMA; Schema: -; Owner: maarch
--

CREATE SCHEMA organization;


ALTER SCHEMA organization OWNER TO maarch;

--
-- Name: recordsManagement; Type: SCHEMA; Schema: -; Owner: maarch
--

CREATE SCHEMA "recordsManagement";


ALTER SCHEMA "recordsManagement" OWNER TO maarch;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: event; Type: TABLE; Schema: audit; Owner: maarch
--

CREATE TABLE audit.event (
    "eventId" text NOT NULL,
    "eventDate" timestamp without time zone NOT NULL,
    "accountId" text NOT NULL,
    "orgRegNumber" text,
    "orgUnitRegNumber" text,
    path text,
    variables json,
    input json,
    output text,
    status boolean DEFAULT true,
    info text,
    "instanceName" text
);


ALTER TABLE audit.event OWNER TO maarch;

--
-- Name: account; Type: TABLE; Schema: auth; Owner: maarch
--

CREATE TABLE auth.account (
    "accountId" text NOT NULL,
    "accountName" text NOT NULL,
    "displayName" text NOT NULL,
    "accountType" text DEFAULT 'user'::text,
    "emailAddress" text NOT NULL,
    enabled boolean DEFAULT true,
    password text,
    "passwordChangeRequired" boolean DEFAULT true,
    "passwordLastChange" timestamp without time zone,
    locked boolean DEFAULT false,
    "lockDate" timestamp without time zone,
    "badPasswordCount" integer,
    "lastLogin" timestamp without time zone,
    "lastIp" text,
    "replacingUserAccountId" text,
    "firstName" text,
    "lastName" text,
    title text,
    salt text,
    "tokenDate" timestamp without time zone,
    authentication jsonb,
    preferences jsonb,
    "ownerOrgId" text,
    "isAdmin" boolean
);


ALTER TABLE auth.account OWNER TO maarch;

--
-- Name: privilege; Type: TABLE; Schema: auth; Owner: maarch
--

CREATE TABLE auth.privilege (
    "roleId" text,
    "userStory" text
);


ALTER TABLE auth.privilege OWNER TO maarch;

--
-- Name: role; Type: TABLE; Schema: auth; Owner: maarch
--

CREATE TABLE auth.role (
    "roleId" text NOT NULL,
    "roleName" text NOT NULL,
    description text,
    "securityLevel" text,
    enabled boolean DEFAULT true
);


ALTER TABLE auth.role OWNER TO maarch;

--
-- Name: roleMember; Type: TABLE; Schema: auth; Owner: maarch
--

CREATE TABLE auth."roleMember" (
    "roleId" text,
    "userAccountId" text NOT NULL
);


ALTER TABLE auth."roleMember" OWNER TO maarch;

--
-- Name: servicePrivilege; Type: TABLE; Schema: auth; Owner: maarch
--

CREATE TABLE auth."servicePrivilege" (
    "accountId" text,
    "serviceURI" text
);


ALTER TABLE auth."servicePrivilege" OWNER TO maarch;

--
-- Name: logScheduling; Type: TABLE; Schema: batchProcessing; Owner: maarch
--

CREATE TABLE "batchProcessing"."logScheduling" (
    "logId" text NOT NULL,
    "schedulingId" text NOT NULL,
    "executedBy" text NOT NULL,
    "launchedBy" text NOT NULL,
    "logDate" timestamp without time zone NOT NULL,
    status boolean DEFAULT true,
    info text
);


ALTER TABLE "batchProcessing"."logScheduling" OWNER TO maarch;

--
-- Name: notification; Type: TABLE; Schema: batchProcessing; Owner: maarch
--

CREATE TABLE "batchProcessing".notification (
    "notificationId" text NOT NULL,
    receivers text NOT NULL,
    message text NOT NULL,
    title text NOT NULL,
    "createdDate" timestamp without time zone NOT NULL,
    "createdBy" text,
    status text NOT NULL,
    "sendDate" timestamp without time zone,
    "sendBy" text
);


ALTER TABLE "batchProcessing".notification OWNER TO maarch;

--
-- Name: scheduling; Type: TABLE; Schema: batchProcessing; Owner: maarch
--

CREATE TABLE "batchProcessing".scheduling (
    "schedulingId" text NOT NULL,
    name text NOT NULL,
    "taskId" text NOT NULL,
    frequency text NOT NULL,
    parameters text,
    "executedBy" text NOT NULL,
    "lastExecution" timestamp without time zone,
    "nextExecution" timestamp without time zone,
    status text
);


ALTER TABLE "batchProcessing".scheduling OWNER TO maarch;

--
-- Name: address; Type: TABLE; Schema: contact; Owner: maarch
--

CREATE TABLE contact.address (
    "addressId" text NOT NULL,
    "contactId" text NOT NULL,
    purpose text NOT NULL,
    room text,
    floor text,
    building text,
    number text,
    street text,
    "postBox" text,
    block text,
    "citySubDivision" text,
    "postCode" text,
    city text,
    country text
);


ALTER TABLE contact.address OWNER TO maarch;

--
-- Name: communication; Type: TABLE; Schema: contact; Owner: maarch
--

CREATE TABLE contact.communication (
    "communicationId" text NOT NULL,
    "contactId" text NOT NULL,
    purpose text NOT NULL,
    "comMeanCode" text NOT NULL,
    value text NOT NULL,
    info text
);


ALTER TABLE contact.communication OWNER TO maarch;

--
-- Name: communicationMean; Type: TABLE; Schema: contact; Owner: maarch
--

CREATE TABLE contact."communicationMean" (
    code text NOT NULL,
    name text NOT NULL,
    enabled boolean
);


ALTER TABLE contact."communicationMean" OWNER TO maarch;

--
-- Name: contact; Type: TABLE; Schema: contact; Owner: maarch
--

CREATE TABLE contact.contact (
    "contactId" text NOT NULL,
    "contactType" text DEFAULT 'person'::text NOT NULL,
    "orgName" text,
    "firstName" text,
    "lastName" text,
    title text,
    function text,
    service text,
    "displayName" text
);


ALTER TABLE contact.contact OWNER TO maarch;

--
-- Name: address; Type: TABLE; Schema: digitalResource; Owner: maarch
--

CREATE TABLE "digitalResource".address (
    "resId" text NOT NULL,
    "repositoryId" text NOT NULL,
    path text NOT NULL,
    "lastIntegrityCheck" timestamp without time zone,
    "integrityCheckResult" boolean,
    packed boolean DEFAULT false,
    created timestamp without time zone NOT NULL
);


ALTER TABLE "digitalResource".address OWNER TO maarch;

--
-- Name: cluster; Type: TABLE; Schema: digitalResource; Owner: maarch
--

CREATE TABLE "digitalResource".cluster (
    "clusterId" text NOT NULL,
    "clusterName" text,
    "clusterDescription" text
);


ALTER TABLE "digitalResource".cluster OWNER TO maarch;

--
-- Name: clusterRepository; Type: TABLE; Schema: digitalResource; Owner: maarch
--

CREATE TABLE "digitalResource"."clusterRepository" (
    "clusterId" text NOT NULL,
    "repositoryId" text NOT NULL,
    "writePriority" integer,
    "readPriority" integer,
    "deletePriority" integer
);


ALTER TABLE "digitalResource"."clusterRepository" OWNER TO maarch;

--
-- Name: contentType; Type: TABLE; Schema: digitalResource; Owner: maarch
--

CREATE TABLE "digitalResource"."contentType" (
    name text NOT NULL,
    mediatype text NOT NULL,
    description text,
    puids text,
    "validationMode" text,
    "conversionMode" text,
    "textExtractionMode" text,
    "metadataExtractionMode" text
);


ALTER TABLE "digitalResource"."contentType" OWNER TO maarch;

--
-- Name: conversionRule; Type: TABLE; Schema: digitalResource; Owner: maarch
--

CREATE TABLE "digitalResource"."conversionRule" (
    "conversionRuleId" text NOT NULL,
    puid text NOT NULL,
    "conversionService" text NOT NULL,
    "targetPuid" text NOT NULL
);


ALTER TABLE "digitalResource"."conversionRule" OWNER TO maarch;

--
-- Name: digitalResource; Type: TABLE; Schema: digitalResource; Owner: maarch
--

CREATE TABLE "digitalResource"."digitalResource" (
    "archiveId" text NOT NULL,
    "resId" text NOT NULL,
    "clusterId" text NOT NULL,
    size bigint NOT NULL,
    puid text,
    mimetype text,
    hash text,
    "hashAlgorithm" text,
    "fileExtension" text,
    "fileName" text,
    "mediaInfo" text,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone,
    "relatedResId" text,
    "relationshipType" text
);


ALTER TABLE "digitalResource"."digitalResource" OWNER TO maarch;

--
-- Name: package; Type: TABLE; Schema: digitalResource; Owner: maarch
--

CREATE TABLE "digitalResource".package (
    "packageId" text NOT NULL,
    method text NOT NULL
);


ALTER TABLE "digitalResource".package OWNER TO maarch;

--
-- Name: packedResource; Type: TABLE; Schema: digitalResource; Owner: maarch
--

CREATE TABLE "digitalResource"."packedResource" (
    "packageId" text NOT NULL,
    "resId" text NOT NULL,
    name text NOT NULL
);


ALTER TABLE "digitalResource"."packedResource" OWNER TO maarch;

--
-- Name: repository; Type: TABLE; Schema: digitalResource; Owner: maarch
--

CREATE TABLE "digitalResource".repository (
    "repositoryId" text NOT NULL,
    "repositoryName" text NOT NULL,
    "repositoryReference" text NOT NULL,
    "repositoryType" text NOT NULL,
    "repositoryUri" text NOT NULL,
    parameters text,
    "maxSize" integer,
    enabled boolean
);


ALTER TABLE "digitalResource".repository OWNER TO maarch;

--
-- Name: folder; Type: TABLE; Schema: filePlan; Owner: maarch
--

CREATE TABLE "filePlan".folder (
    "folderId" text NOT NULL,
    name text NOT NULL,
    "parentFolderId" text,
    description text,
    "ownerOrgRegNumber" text,
    closed boolean
);


ALTER TABLE "filePlan".folder OWNER TO maarch;

--
-- Name: position; Type: TABLE; Schema: filePlan; Owner: maarch
--

CREATE TABLE "filePlan"."position" (
    "folderId" text NOT NULL,
    "archiveId" text NOT NULL
);


ALTER TABLE "filePlan"."position" OWNER TO maarch;

--
-- Name: event; Type: TABLE; Schema: lifeCycle; Owner: maarch
--

CREATE TABLE "lifeCycle".event (
    "eventId" text NOT NULL,
    "eventType" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "instanceName" text NOT NULL,
    "orgRegNumber" text,
    "orgUnitRegNumber" text,
    "accountId" text,
    "objectClass" text NOT NULL,
    "objectId" text NOT NULL,
    "operationResult" boolean,
    description text,
    "eventInfo" text
);


ALTER TABLE "lifeCycle".event OWNER TO maarch;

--
-- Name: eventFormat; Type: TABLE; Schema: lifeCycle; Owner: maarch
--

CREATE TABLE "lifeCycle"."eventFormat" (
    type text NOT NULL,
    format text NOT NULL,
    message text NOT NULL,
    notification boolean DEFAULT false
);


ALTER TABLE "lifeCycle"."eventFormat" OWNER TO maarch;

--
-- Name: archivalAgreement; Type: TABLE; Schema: medona; Owner: maarch
--

CREATE TABLE medona."archivalAgreement" (
    "archivalAgreementId" text NOT NULL,
    name text NOT NULL,
    reference text NOT NULL,
    description text,
    "archivalProfileReference" text,
    "serviceLevelReference" text,
    "archiverOrgRegNumber" text NOT NULL,
    "depositorOrgRegNumber" text NOT NULL,
    "originatorOrgIds" text,
    "beginDate" date,
    "endDate" date,
    enabled boolean,
    "allowedFormats" text,
    "maxSizeAgreement" integer,
    "maxSizeTransfer" integer,
    "maxSizeDay" integer,
    "maxSizeWeek" integer,
    "maxSizeMonth" integer,
    "maxSizeYear" integer,
    signed boolean,
    "autoTransferAcceptance" boolean,
    "processSmallArchive" boolean
);


ALTER TABLE medona."archivalAgreement" OWNER TO maarch;

--
-- Name: controlAuthority; Type: TABLE; Schema: medona; Owner: maarch
--

CREATE TABLE medona."controlAuthority" (
    "originatorOrgUnitId" text NOT NULL,
    "controlAuthorityOrgUnitId" text NOT NULL
);


ALTER TABLE medona."controlAuthority" OWNER TO maarch;

--
-- Name: message; Type: TABLE; Schema: medona; Owner: maarch
--

CREATE TABLE medona.message (
    "messageId" text NOT NULL,
    schema text,
    type text NOT NULL,
    status text NOT NULL,
    date timestamp without time zone NOT NULL,
    reference text NOT NULL,
    "accountId" text,
    "senderOrgRegNumber" text NOT NULL,
    "senderOrgName" text,
    "recipientOrgRegNumber" text NOT NULL,
    "recipientOrgName" text,
    "archivalAgreementReference" text,
    "replyCode" text,
    "operationDate" timestamp without time zone,
    "receptionDate" timestamp without time zone,
    "relatedReference" text,
    "requestReference" text,
    "replyReference" text,
    "authorizationReference" text,
    "authorizationReason" text,
    "authorizationRequesterOrgRegNumber" text,
    derogation boolean,
    "dataObjectCount" integer,
    size numeric,
    data text,
    path text,
    active boolean,
    archived boolean,
    "isIncoming" boolean,
    comment text
);


ALTER TABLE medona.message OWNER TO maarch;

--
-- Name: messageComment; Type: TABLE; Schema: medona; Owner: maarch
--

CREATE TABLE medona."messageComment" (
    "messageId" text,
    comment text,
    "commentId" text NOT NULL
);


ALTER TABLE medona."messageComment" OWNER TO maarch;

--
-- Name: unitIdentifier; Type: TABLE; Schema: medona; Owner: maarch
--

CREATE TABLE medona."unitIdentifier" (
    "messageId" text NOT NULL,
    "objectClass" text NOT NULL,
    "objectId" text NOT NULL
);


ALTER TABLE medona."unitIdentifier" OWNER TO maarch;

--
-- Name: archivalProfileAccess; Type: TABLE; Schema: organization; Owner: maarch
--

CREATE TABLE organization."archivalProfileAccess" (
    "orgId" text NOT NULL,
    "archivalProfileReference" text NOT NULL,
    "originatorAccess" boolean DEFAULT true,
    "serviceLevelReference" text,
    "userAccess" jsonb
);


ALTER TABLE organization."archivalProfileAccess" OWNER TO maarch;

--
-- Name: orgContact; Type: TABLE; Schema: organization; Owner: maarch
--

CREATE TABLE organization."orgContact" (
    "contactId" text NOT NULL,
    "orgId" text NOT NULL,
    "isSelf" boolean
);


ALTER TABLE organization."orgContact" OWNER TO maarch;

--
-- Name: orgType; Type: TABLE; Schema: organization; Owner: maarch
--

CREATE TABLE organization."orgType" (
    code text NOT NULL,
    name text
);


ALTER TABLE organization."orgType" OWNER TO maarch;

--
-- Name: organization; Type: TABLE; Schema: organization; Owner: maarch
--

CREATE TABLE organization.organization (
    "orgId" text NOT NULL,
    "orgName" text NOT NULL,
    "otherOrgName" text,
    "displayName" text NOT NULL,
    "registrationNumber" text NOT NULL,
    "beginDate" date,
    "endDate" date,
    "legalClassification" text,
    "businessType" text,
    description text,
    "orgTypeCode" text,
    "orgRoleCodes" text,
    "taxIdentifier" text,
    "parentOrgId" text,
    "ownerOrgId" text,
    history text,
    "isOrgUnit" boolean,
    enabled boolean
);


ALTER TABLE organization.organization OWNER TO maarch;

--
-- Name: servicePosition; Type: TABLE; Schema: organization; Owner: maarch
--

CREATE TABLE organization."servicePosition" (
    "serviceAccountId" text NOT NULL,
    "orgId" text NOT NULL
);


ALTER TABLE organization."servicePosition" OWNER TO maarch;

--
-- Name: userPosition; Type: TABLE; Schema: organization; Owner: maarch
--

CREATE TABLE organization."userPosition" (
    "userAccountId" text NOT NULL,
    "orgId" text NOT NULL,
    function text,
    "default" boolean
);


ALTER TABLE organization."userPosition" OWNER TO maarch;

--
-- Name: accessRule; Type: TABLE; Schema: recordsManagement; Owner: maarch
--

CREATE TABLE "recordsManagement"."accessRule" (
    code text NOT NULL,
    duration text,
    description text NOT NULL
);


ALTER TABLE "recordsManagement"."accessRule" OWNER TO maarch;

--
-- Name: archivalProfile; Type: TABLE; Schema: recordsManagement; Owner: maarch
--

CREATE TABLE "recordsManagement"."archivalProfile" (
    "archivalProfileId" text NOT NULL,
    reference text NOT NULL,
    name text NOT NULL,
    "descriptionSchema" text,
    "descriptionClass" text,
    "retentionStartDate" text,
    "retentionRuleCode" text,
    description text,
    "accessRuleCode" text,
    "acceptUserIndex" boolean DEFAULT false,
    "acceptArchiveWithoutProfile" boolean DEFAULT true,
    "fileplanLevel" text,
    "processingStatuses" jsonb
);


ALTER TABLE "recordsManagement"."archivalProfile" OWNER TO maarch;

--
-- Name: archivalProfileContents; Type: TABLE; Schema: recordsManagement; Owner: maarch
--

CREATE TABLE "recordsManagement"."archivalProfileContents" (
    "parentProfileId" text NOT NULL,
    "containedProfileId" text NOT NULL
);


ALTER TABLE "recordsManagement"."archivalProfileContents" OWNER TO maarch;

--
-- Name: archive; Type: TABLE; Schema: recordsManagement; Owner: maarch
--

CREATE TABLE "recordsManagement".archive (
    "archiveId" text NOT NULL,
    "originatorArchiveId" text,
    "depositorArchiveId" text,
    "archiverArchiveId" text,
    "archiveName" text,
    "storagePath" text,
    "filePlanPosition" text,
    "fileplanLevel" text,
    "originatingDate" date,
    "descriptionClass" text,
    description jsonb,
    text text,
    "originatorOrgRegNumber" text NOT NULL,
    "originatorOwnerOrgId" text,
    "originatorOwnerOrgRegNumber" text,
    "depositorOrgRegNumber" text,
    "archiverOrgRegNumber" text,
    "userOrgRegNumbers" text,
    "archivalProfileReference" text,
    "archivalAgreementReference" text,
    "serviceLevelReference" text,
    "retentionRuleCode" text,
    "retentionStartDate" date,
    "retentionDuration" text,
    "finalDisposition" text,
    "disposalDate" date,
    "retentionRuleStatus" text,
    "accessRuleCode" text,
    "accessRuleDuration" text,
    "accessRuleStartDate" date,
    "accessRuleComDate" date,
    "storageRuleCode" text,
    "storageRuleDuration" text,
    "storageRuleStartDate" date,
    "storageRuleEndDate" date,
    "classificationRuleCode" text,
    "classificationRuleDuration" text,
    "classificationRuleStartDate" date,
    "classificationEndDate" date,
    "classificationLevel" text,
    "classificationOwner" text,
    "depositDate" timestamp without time zone NOT NULL,
    "lastCheckDate" timestamp without time zone,
    "lastDeliveryDate" timestamp without time zone,
    "lastModificationDate" timestamp without time zone,
    status text NOT NULL,
    "processingStatus" text,
    "parentArchiveId" text,
    "fullTextIndexation" text DEFAULT 'none'::text
);


ALTER TABLE "recordsManagement".archive OWNER TO maarch;

--
-- Name: archiveDescription; Type: TABLE; Schema: recordsManagement; Owner: maarch
--

CREATE TABLE "recordsManagement"."archiveDescription" (
    "archivalProfileId" text NOT NULL,
    "fieldName" text NOT NULL,
    required boolean,
    "position" integer,
    "isImmutable" boolean DEFAULT false,
    "isRetained" boolean DEFAULT true,
    "isInList" boolean DEFAULT false
);


ALTER TABLE "recordsManagement"."archiveDescription" OWNER TO maarch;

--
-- Name: archiveRelationship; Type: TABLE; Schema: recordsManagement; Owner: maarch
--

CREATE TABLE "recordsManagement"."archiveRelationship" (
    "archiveId" text NOT NULL,
    "relatedArchiveId" text NOT NULL,
    "typeCode" text NOT NULL,
    description jsonb
);


ALTER TABLE "recordsManagement"."archiveRelationship" OWNER TO maarch;

--
-- Name: archiverArchiveIdSequence; Type: SEQUENCE; Schema: recordsManagement; Owner: maarch
--

CREATE SEQUENCE "recordsManagement"."archiverArchiveIdSequence"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "recordsManagement"."archiverArchiveIdSequence" OWNER TO maarch;

--
-- Name: descriptionClass; Type: TABLE; Schema: recordsManagement; Owner: maarch
--

CREATE TABLE "recordsManagement"."descriptionClass" (
    name text NOT NULL,
    label text NOT NULL
);


ALTER TABLE "recordsManagement"."descriptionClass" OWNER TO maarch;

--
-- Name: descriptionField; Type: TABLE; Schema: recordsManagement; Owner: maarch
--

CREATE TABLE "recordsManagement"."descriptionField" (
    name text NOT NULL,
    label text,
    type text,
    "default" text,
    "minLength" smallint,
    "maxLength" smallint,
    "minValue" numeric,
    "maxValue" numeric,
    enumeration text,
    facets jsonb,
    pattern text,
    "isArray" boolean DEFAULT false
);


ALTER TABLE "recordsManagement"."descriptionField" OWNER TO maarch;

--
-- Name: log; Type: TABLE; Schema: recordsManagement; Owner: maarch
--

CREATE TABLE "recordsManagement".log (
    "archiveId" text NOT NULL,
    "fromDate" timestamp without time zone NOT NULL,
    "toDate" timestamp without time zone NOT NULL,
    "processId" text,
    "processName" text,
    type text NOT NULL,
    "ownerOrgRegNumber" text
);


ALTER TABLE "recordsManagement".log OWNER TO maarch;

--
-- Name: retentionRule; Type: TABLE; Schema: recordsManagement; Owner: maarch
--

CREATE TABLE "recordsManagement"."retentionRule" (
    code text NOT NULL,
    duration text NOT NULL,
    "finalDisposition" text,
    description text,
    label text NOT NULL,
    "implementationDate" date
);


ALTER TABLE "recordsManagement"."retentionRule" OWNER TO maarch;

--
-- Name: serviceLevel; Type: TABLE; Schema: recordsManagement; Owner: maarch
--

CREATE TABLE "recordsManagement"."serviceLevel" (
    "serviceLevelId" text NOT NULL,
    reference text NOT NULL,
    "digitalResourceClusterId" text NOT NULL,
    control text,
    "default" boolean,
    "samplingFrequency" integer,
    "samplingRate" integer
);


ALTER TABLE "recordsManagement"."serviceLevel" OWNER TO maarch;

--
-- Name: storageRule; Type: TABLE; Schema: recordsManagement; Owner: maarch
--

CREATE TABLE "recordsManagement"."storageRule" (
    code text NOT NULL,
    duration text NOT NULL,
    description text,
    label text
);


ALTER TABLE "recordsManagement"."storageRule" OWNER TO maarch;

--
-- Data for Name: event; Type: TABLE DATA; Schema: audit; Owner: maarch
--

COPY audit.event ("eventId", "eventDate", "accountId", "orgRegNumber", "orgUnitRegNumber", path, variables, input, output, status, info, "instanceName") FROM stdin;
maarchRM_scpf7i-bmgw-0nqzu2	2024-04-29 12:40:30.542417	superadmin	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"superadmin"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpf7m-2ig6-ccdh8t	2024-04-29 12:40:34.11725	__system__	\N	\N	auth/authentication/deleteUserlogin	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpf8k-jsra-0y1vkc	2024-04-29 12:41:08.923789	superadmin	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"superadmin"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfbl-finu-va3k3x	2024-04-29 12:42:57.724046	superadmin	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"superadmin"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpffe-9gh0-j4109v	2024-04-29 12:45:14.441283	superadmin	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"superadmin"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfhk-bzx5-ib3k6l	2024-04-29 12:46:32.559787	superadmin	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"superadmin"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfhq-1s7q-4y16lv	2024-04-29 12:46:38.083248	__system__	\N	\N	auth/authentication/deleteUserlogin	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfmt-717u-4s7q01	2024-04-29 12:49:41.328185	superadmin	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"superadmin"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfod-8th1-2jn4x0	2024-04-29 12:50:37.411495	__system__	\N	\N	auth/authentication/deleteUserlogin	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfp9-af1n-73cqba	2024-04-29 12:51:09.486103	superadmin	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"superadmin"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfpf-1963-2igbke	2024-04-29 12:51:15.058573	__system__	\N	\N	auth/authentication/deleteUserlogin	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfpy-9ljk-cboo0w	2024-04-29 12:51:34.447863	__system__	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"mmaiga"}	Username and / or password invalid	f	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfqd-i6at-di3kv8	2024-04-29 12:51:49.84799	bblier	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"bblier"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfqh-js8o-rgm5x0	2024-04-29 12:51:53.923085	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfqi-1yyl-9ldary	2024-04-29 12:51:54.091985	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfsu-0yrj-oeh837	2024-04-29 12:53:18.045082	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpftk-l73x-7punr0	2024-04-29 12:53:44.989019	bblier	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"bblier"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpftp-9tmb-5nton4	2024-04-29 12:53:49.458312	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpftp-du9v-umzbcu	2024-04-29 12:53:49.645808	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfvn-3758-155dzq	2024-04-29 12:54:59.149255	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfwk-fbis-ebcghz	2024-04-29 12:55:32.714787	bblier	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"bblier"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfwo-9vul-ksmav3	2024-04-29 12:55:36.461211	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfwo-dhx7-4d5tfd	2024-04-29 12:55:36.629795	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfwq-418y-goe4wa	2024-04-29 12:55:38	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfwq-4lxb-e51rqy	2024-04-29 12:55:38	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfwr-c5ht-0guyr8	2024-04-29 12:55:39	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfwr-chpt-7msrun	2024-04-29 12:55:39	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfws-fw19-k13xsu	2024-04-29 12:55:40	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfws-g9bl-98g7m1	2024-04-29 12:55:40	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfye-3ne6-1rv372	2024-04-29 12:56:38	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfye-47iv-irifty	2024-04-29 12:56:38	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfyf-6lcx-nc4lx3	2024-04-29 12:56:39	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfyf-6yw0-5dfd17	2024-04-29 12:56:39	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfyg-aesp-dl53oq	2024-04-29 12:56:40	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfyg-anlg-0zl5xu	2024-04-29 12:56:40	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfyh-i2u8-bljfpu	2024-04-29 12:56:41	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfyh-ic15-laimn7	2024-04-29 12:56:41	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfyi-hd1x-w7lowc	2024-04-29 12:56:42	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfyi-hlxh-49etzi	2024-04-29 12:56:42	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfyj-gbgy-i392c0	2024-04-29 12:56:43	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpfyj-gkqy-7m818f	2024-04-29 12:56:43	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpg0l-9zq8-c7uu6x	2024-04-29 12:57:57.466244	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpg0n-k2oj-c2gqtk	2024-04-29 12:57:59	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpg0n-kc2w-shpgf2	2024-04-29 12:57:59	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpg55-ieo4-c3z4xo	2024-04-29 13:00:41.858844	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpg12-6z32-aflcpl	2024-04-29 12:58:14.325448	bblier	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"bblier"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpg17-3uyi-mbwew7	2024-04-29 12:58:19.180115	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpg17-71w2-3e0zqu	2024-04-29 12:58:19.329062	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpg18-hslk-6tm5bo	2024-04-29 12:58:20	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpg18-i1wr-x6n946	2024-04-29 12:58:20	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpg5p-5pn7-5pobos	2024-04-29 13:01:01.266531	bblier	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"bblier"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpg5x-0vxh-8kmtxm	2024-04-29 13:01:09	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpg5x-1ceu-2g9q80	2024-04-29 13:01:09	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpg5z-9jjf-13j3ut	2024-04-29 13:01:11.445246	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpg5z-e2nb-8kfr5s	2024-04-29 13:01:11.656635	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpg60-cwdz-nz4psi	2024-04-29 13:01:12	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpg60-d7lj-tfk8e3	2024-04-29 13:01:12	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpg68-71uv-e02tcc	2024-04-29 13:01:20	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpg68-7gke-nkncsv	2024-04-29 13:01:20	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpg74-5hzm-fb7qw8	2024-04-29 13:01:52	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpg74-5t62-gpvnvu	2024-04-29 13:01:52	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpg7d-0t17-7mie5l	2024-04-29 13:02:01	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpg7d-13o7-2jf3pp	2024-04-29 13:02:01	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgag-efj1-1ft41c	2024-04-29 13:03:52.673327	bblier	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"bblier"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgai-fcuo-6apjfk	2024-04-29 13:03:54	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgai-fsjf-seajre	2024-04-29 13:03:54	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgcl-fwuu-k4osqo	2024-04-29 13:05:09.742445	bblier	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"bblier"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgcp-91h6-h0bv1f	2024-04-29 13:05:13	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgcp-9bxi-aq3bkm	2024-04-29 13:05:13	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgd2-kvi6-o2c9ms	2024-04-29 13:05:26	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgd2-l7pw-7hsux5	2024-04-29 13:05:26	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgd9-5lgx-x57iqu	2024-04-29 13:05:33	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgd9-63dt-xosa37	2024-04-29 13:05:33	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgdi-gaqw-ymzn9k	2024-04-29 13:05:42	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgdi-goim-nkyp7n	2024-04-29 13:05:42	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgf4-bco7-hypptp	2024-04-29 13:06:40	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgf4-bmjh-3mug77	2024-04-29 13:06:40	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgf6-2okp-pn0rsq	2024-04-29 13:06:42	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgf6-32d6-o1x61x	2024-04-29 13:06:42	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgf6-gyx2-0rle2t	2024-04-29 13:06:42	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgf6-hc5r-00wlic	2024-04-29 13:06:42	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgf9-2bn8-gqkn9s	2024-04-29 13:06:45	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgf9-2o4b-debyni	2024-04-29 13:06:45	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgl8-5qnx-3jkarl	2024-04-29 13:10:20	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgl8-64yn-6zfszr	2024-04-29 13:10:20	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgs3-c8iz-5c52xk	2024-04-29 13:14:27	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgs3-ck8d-bmercx	2024-04-29 13:14:27	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgtb-gu43-vp6yyv	2024-04-29 13:15:11	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgtb-h3mh-2p3sky	2024-04-29 13:15:11	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgtn-aayv-qycksn	2024-04-29 13:15:23	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgtn-alkb-xlef3m	2024-04-29 13:15:23	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgyy-fwlj-i1x3ds	2024-04-29 13:18:34.742104	bblier	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"bblier"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgz2-jofb-5eykx7	2024-04-29 13:18:38	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgz2-k5g1-b1vm61	2024-04-29 13:18:38	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpkxy-5jmb-5ao56f	2024-04-29 14:44:22.258734	superadmin	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"superadmin"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpl0f-5q4j-omi9yo	2024-04-29 14:45:51.267158	superadmin	\N	\N	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scplb4-4hho-cup04l	2024-04-29 14:52:16.209309	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scplb4-8zqf-b2nwxt	2024-04-29 14:52:16.419578	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scplb6-2b71-c2a8tv	2024-04-29 14:52:18	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scplb6-2rur-0w11zj	2024-04-29 14:52:18	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgyi-376d-bmhuex	2024-04-29 13:18:18	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpgyi-3ot9-xxduf2	2024-04-29 13:18:18	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpkyd-e1jp-mz6fjo	2024-04-29 14:44:37.655211	superadmin	\N	\N	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scplbk-7jxm-349alt	2024-04-29 14:52:32.352444	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":true,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scph38-aw3k-boagdz	2024-04-29 13:21:08	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scph38-bbww-2pcdh5	2024-04-29 13:21:08	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scph3c-8hv1-jps1av	2024-04-29 13:21:12	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scph3c-8xib-agzqgr	2024-04-29 13:21:12	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scph3f-7shm-n0f9qe	2024-04-29 13:21:15	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scph3f-88rj-bkhph3	2024-04-29 13:21:15	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scph3k-3uxh-51b8e3	2024-04-29 13:21:20.180071	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scph3k-7blr-jvmd1f	2024-04-29 13:21:20.34165	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scph3m-ggga-dkxkzg	2024-04-29 13:21:22	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scph3m-gy4p-8jicsj	2024-04-29 13:21:22	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scph3v-3tfs-mvrmak	2024-04-29 13:21:31	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scph3v-43nn-mghres	2024-04-29 13:21:31	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpl0f-53d8-ffbfe7	2024-04-29 14:45:51.237662	superadmin	\N	\N	auth/serviceAccount/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scplax-dmnf-8btiz8	2024-04-29 14:52:09.635919	bblier	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"bblier"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scplbr-8q3c-2a6085	2024-04-29 14:52:39.407112	bblier	ACME	GIC	recordsManagement/log/readFind	\N	{"sortBy":">fromDate","maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scplbr-8zje-87mnbx	2024-04-29 14:52:39.419321	bblier	ACME	GIC	recordsManagement/log/countFind	\N	[]	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scplbz-8xse-cw7xr5	2024-04-29 14:52:47.417058	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scplbz-ddhq-vqmhsg	2024-04-29 14:52:47.624034	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scplc1-587x-oyqtsa	2024-04-29 14:52:49	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scplc1-5o78-j13zg9	2024-04-29 14:52:49	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scplcb-2n2i-2i2v13	2024-04-29 14:52:59.123233	bblier	ACME	GIC	recordsManagement/log/readFind	\N	{"sortBy":">fromDate","maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scplcb-2yqk-x9qfwy	2024-04-29 14:52:59.138352	bblier	ACME	GIC	recordsManagement/log/countFind	\N	[]	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scplcd-6vb0-msfdra	2024-04-29 14:53:01.32053	__system__	\N	\N	auth/authentication/deleteUserlogin	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scplco-2oow-oofmra	2024-04-29 14:53:12.125328	superadmin	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"superadmin"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scplcu-888q-rzlb8v	2024-04-29 14:53:18.38395	superadmin	\N	\N	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scplcu-8c2d-okp7oi	2024-04-29 14:53:18.388922	superadmin	\N	\N	auth/serviceAccount/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scplj4-7gya-0vqc6a	2024-04-29 14:57:04.348598	__system__	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"superadmin"}	Username and / or password invalid	f	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scplj9-4r06-rvqq5t	2024-04-29 14:57:09.221646	superadmin	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"superadmin"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scplje-ilyg-5jf1ay	2024-04-29 14:57:14.868303	superadmin	\N	\N	auth/serviceAccount/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scplje-iv6k-52vwno	2024-04-29 14:57:14.880255	superadmin	\N	\N	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scplmz-e399-40kp70	2024-04-29 14:59:23.657446	superadmin	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"superadmin"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpln5-ezhn-hd04fq	2024-04-29 14:59:29.699219	superadmin	\N	\N	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpln5-f1ym-zbeqw8	2024-04-29 14:59:29.702413	superadmin	\N	\N	auth/serviceAccount/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpltl-2qps-uvkj9k	2024-04-29 15:03:21.127977	superadmin	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"superadmin"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpltr-iq2n-pp0ybk	2024-04-29 15:03:27.873627	superadmin	\N	\N	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpltr-j26x-9k08ow	2024-04-29 15:03:27.88933	superadmin	\N	\N	auth/serviceAccount/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpm58-7pzu-2ok3kh	2024-04-29 15:10:20.360306	__system__	\N	\N	auth/authentication/deleteUserlogin	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpm5e-1sf4-2kdb6w	2024-04-29 15:10:26.083509	bblier	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"bblier"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpm5h-kkux-8dwclk	2024-04-29 15:10:29	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpm5h-kyjz-jnbl0g	2024-04-29 15:10:29	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpmhs-dyqy-xbyr0y	2024-04-29 15:17:52	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpmhs-eg5b-is51m2	2024-04-29 15:17:52	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpmmv-3ukr-akawyk	2024-04-29 15:20:55	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpmmv-4ctn-mg8ajk	2024-04-29 15:20:55	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpmrb-0q8i-sjoj32	2024-04-29 15:23:35.034022	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpmre-36o6-566hwx	2024-04-29 15:23:38.148655	bblier	ACME	GIC	auth/userAccount/readNew	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpmre-6geq-ez7xof	2024-04-29 15:23:38.301224	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpn1a-510u-ea2uip	2024-04-29 15:29:34.234661	bblier	ACME	GIC	auth/userAccount/readNew	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpn1a-ganm-qdsjkp	2024-04-29 15:29:34.760349	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpn59-8644-o5bxn6	2024-04-29 15:31:57.381188	bblier	ACME	GIC	auth/userAccount/readNew	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpn59-id92-agfxpj	2024-04-29 15:31:57.857001	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpn6l-c0jc-ldi5xt	2024-04-29 15:32:45.560602	bblier	ACME	GIC	auth/userAccount/readNew	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpn6m-5id7-88i434	2024-04-29 15:32:46.257112	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpn6u-9te8-g25b6q	2024-04-29 15:32:54.45804	bblier	ACME	GIC	auth/userAccount/readNew	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpn6v-3qpq-e0nm1z	2024-04-29 15:32:55.174612	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpn9c-gdi4-5vky8a	2024-04-29 15:34:24.764037	bblier	ACME	GIC	auth/userAccount/readNew	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpn9d-9ylo-kibh3s	2024-04-29 15:34:25.464764	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpnj6-6c9n-hdnq1k	2024-04-29 15:40:18.295865	bblier	ACME	GIC	auth/userAccount/readNew	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpnj6-k7xq-409a35	2024-04-29 15:40:18.943428	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpnjf-ks4n-t9qwh1	2024-04-29 15:40:27.969641	bblier	ACME	GIC	auth/userAccount/readNew	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpnjg-f1wm-4dc7e6	2024-04-29 15:40:28.702341	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpnx7-atm5-v97343	2024-04-29 15:48:43.50502	bblier	ACME	GIC	organization/organization/readTree	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpnx7-bc2k-qc0fbv	2024-04-29 15:48:43.52888	bblier	ACME	GIC	organization/orgType/readList	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpnx7-ku30-5r6k21	2024-04-29 15:48:43.972131	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpnxw-589b-pmq89l	2024-04-29 15:49:08.244032	bblier	ACME	GIC	organization/organization/readTree	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpnxz-9j3q-s3z2pi	2024-04-29 15:49:11.444698	bblier	ACME	GIC	organization/organization/read_orgId_	{"orgId":"ACME"}	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpnzf-dxyy-ocdnqt	2024-04-29 15:50:03.650587	bblier	ACME	GIC	organization/organization/readTree	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpnzk-8noi-68mq5u	2024-04-29 15:50:08.403965	bblier	ACME	GIC	organization/organization/read_orgId_	{"orgId":"ACME"}	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpnx7-l5pb-d7bmed	2024-04-29 15:48:43.987198	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":true,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpnx8-07j1-14q5a6	2024-04-29 15:48:44.00982	bblier	ACME	GIC	organization/organization/readTree	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpnx9-4hfm-p42eov	2024-04-29 15:48:45.209242	bblier	ACME	GIC	organization/organization/read_orgId_	{"orgId":"ACME"}	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpnzf-do29-dyei6j	2024-04-29 15:50:03.637746	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpnxi-6est-duv93j	2024-04-29 15:48:54	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpnxi-6t7g-g0qj07	2024-04-29 15:48:54	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpnxs-g76i-co6iea	2024-04-29 15:49:04.755833	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":true,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpnxv-imgm-qbypy2	2024-04-29 15:49:07.868954	bblier	ACME	GIC	organization/organization/readTree	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpnxv-izmc-m47a8h	2024-04-29 15:49:07.88599	bblier	ACME	GIC	organization/orgType/readList	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpnxw-4yxx-whwlzi	2024-04-29 15:49:08.23193	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpnz8-h9on-ph1ssq	2024-04-29 15:49:56.805742	bblier	ACME	GIC	organization/organization/readTree	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpnz8-hl73-d43be9	2024-04-29 15:49:56.820637	bblier	ACME	GIC	organization/orgType/readList	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpnz9-h28u-ahpmv8	2024-04-29 15:49:57.796085	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":true,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpo0w-ay22-r604c9	2024-04-29 15:50:56.510722	bblier	ACME	GIC	organization/organization/read_orgId_	{"orgId":"DAF"}	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpnz9-h1d5-7sf08h	2024-04-29 15:49:57.794954	bblier	ACME	GIC	organization/organization/readTree	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpnze-eo26-6go2nk	2024-04-29 15:50:02.684397	bblier	ACME	GIC	organization/organization/readTree	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpnze-f27s-ll2t52	2024-04-29 15:50:02.702731	bblier	ACME	GIC	organization/orgType/readList	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpo1a-1bml-v9gt1l	2024-04-29 15:51:10.061803	bblier	ACME	GIC	organization/organization/read_orgId_	{"orgId":"ACME"}	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpo70-4koz-9lk9h9	2024-04-29 15:54:36.213604	bblier	ACME	GIC	organization/organization/readTree	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpo70-547l-ixr7xt	2024-04-29 15:54:36.238769	bblier	ACME	GIC	organization/orgType/readList	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpo71-4pzq-v1xmml	2024-04-29 15:54:37.220336	bblier	ACME	GIC	organization/organization/readTree	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpo71-508y-l947m9	2024-04-29 15:54:37.233634	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":true,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpo72-h8nh-hklnqi	2024-04-29 15:54:38.8044	bblier	ACME	GIC	organization/organization/read_orgId_	{"orgId":"ACME"}	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpo77-h8ud-ywts0i	2024-04-29 15:54:43.80463	bblier	ACME	GIC	organization/organization/read_orgId_	{"orgId":"DAF"}	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpo8x-dqex-8uxxbc	2024-04-29 15:55:45.640833	bblier	ACME	GIC	organization/organization/createArchivalprofileaccess	\N	[]	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpofk-f4ek-k71d3x	2024-04-29 15:59:44.705585	bblier	ACME	GIC	organization/organization/read_orgId_	{"orgId":"ACME"}	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpofl-ig88-fq2yjg	2024-04-29 15:59:45.860874	bblier	ACME	GIC	organization/organization/read_orgId_	{"orgId":"DAF"}	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpofn-7xnp-olh9k8	2024-04-29 15:59:47.370242	bblier	ACME	GIC	organization/organization/read_orgId_	{"orgId":"DG"}	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpojy-c3ui-adnuza	2024-04-29 16:02:22.564941	bblier	ACME	GIC	organization/organization/readTree	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpojy-cfva-67mbd9	2024-04-29 16:02:22.580453	bblier	ACME	GIC	organization/orgType/readList	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpojz-9s1n-fi3c8b	2024-04-29 16:02:23.456283	bblier	ACME	GIC	organization/organization/readTree	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpojz-9zge-nfqaay	2024-04-29 16:02:23.465873	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpok5-e2o1-3o7bhf	2024-04-29 16:02:29.65666	bblier	ACME	GIC	organization/organization/readTree	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpok5-ee23-453mm0	2024-04-29 16:02:29.671437	bblier	ACME	GIC	organization/orgType/readList	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpok6-d2qp-bs11ua	2024-04-29 16:02:30.610098	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":true,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpok6-deqj-p4iw6b	2024-04-29 16:02:30.625652	bblier	ACME	GIC	organization/organization/readTree	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpok8-8d3r-51975l	2024-04-29 16:02:32.390254	bblier	ACME	GIC	organization/organization/read_orgId_	{"orgId":"ACME"}	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpok9-klrl-wc2hke	2024-04-29 16:02:33.961346	bblier	ACME	GIC	organization/organization/read_orgId_	{"orgId":"DAF"}	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpom0-16ej-t0h8k7	2024-04-29 16:03:36.055	bblier	ACME	GIC	organization/orgType/readList	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpoo1-bk3e-3tlg12	2024-04-29 16:04:49.539279	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpoo1-g00f-v9j4z2	2024-04-29 16:04:49.746532	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpop0-iuk2-wlhsc4	2024-04-29 16:05:24	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpop0-ja4m-fq1421	2024-04-29 16:05:24	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpop5-hcls-yqhal4	2024-04-29 16:05:29.809517	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpow3-h67j-m2n6yr	2024-04-29 16:09:39.801225	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpow3-jizj-d9kk5l	2024-04-29 16:09:39.911089	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpow6-7o12-3bqqvq	2024-04-29 16:09:42.357761	bblier	ACME	GIC	auth/userAccount/read_userAccountId_	{"userAccountId":"aackermann"}	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpow6-b0rq-23ou6a	2024-04-29 16:09:42.514238	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpow8-hnaq-re4m56	2024-04-29 16:09:44.823373	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpowa-7zy5-nin1lh	2024-04-29 16:09:46.373205	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	{"query":"enabled=true"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpowd-j21j-mvkwie	2024-04-29 16:09:49.889138	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpowe-bvog-3zlxif	2024-04-29 16:09:50.554294	bblier	ACME	GIC	auth/userAccount/readNew	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpowe-f9gb-jfmxop	2024-04-29 16:09:50.712112	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpoz6-5103-i4o9tw	2024-04-29 16:11:30.234646	bblier	ACME	GIC	auth/userAccount/readNew	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpoz6-iwvt-m1u5ws	2024-04-29 16:11:30.882447	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpozc-b8kj-g1goch	2024-04-29 16:11:36.524366	bblier	ACME	GIC	auth/userAccount/readNew	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpozd-48fs-9ystcp	2024-04-29 16:11:37.197591	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpp0z-fod0-z506yu	2024-04-29 16:12:35.731473	bblier	ACME	GIC	auth/userAccount/readNew	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpp10-a4gs-ppxei2	2024-04-29 16:12:36.472366	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpp5a-c6pv-1t7lv9	2024-04-29 16:15:10.568636	bblier	ACME	GIC	auth/userAccount/readNew	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpp5b-3l0s-4a4qnt	2024-04-29 16:15:11.167231	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpp5f-koj9-aoha9m	2024-04-29 16:15:15.964938	bblier	ACME	GIC	auth/userAccount/readNew	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppi7-6ttu-q5dbc7	2024-04-29 16:22:55	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppi7-7a48-y48k84	2024-04-29 16:22:55	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppq3-8q40-5ryr1p	2024-04-29 16:27:39.407132	bblier	ACME	GIC	recordsManagement/accessRule/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpp5g-ech8-k3at0p	2024-04-29 16:15:16.669384	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpp93-4dna-56qqyr	2024-04-29 16:17:27	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpp93-4pn3-mqsxw6	2024-04-29 16:17:27	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppaz-0ydu-x3s9f2	2024-04-29 16:18:35	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppaz-18gg-p5e5bo	2024-04-29 16:18:35	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppfp-awu7-5jx5gj	2024-04-29 16:21:25	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppfp-b95y-j6rw9r	2024-04-29 16:21:25	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppg8-jpk5-1xm82e	2024-04-29 16:21:44	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppg8-k0vk-1on4ms	2024-04-29 16:21:44	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppio-fifa-348ymc	2024-04-29 16:23:12.723744	bblier	ACME	GIC	auth/userAccount/readProfile	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppjs-4q7l-ss24at	2024-04-29 16:23:52.220615	bblier	ACME	GIC	auth/userAccount/readProfile	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppjz-i16l-mtvfws	2024-04-29 16:23:59.841383	bblier	ACME	GIC	Statistics/Statistics/index	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppk2-4y18-nzc8rb	2024-04-29 16:24:02.230763	bblier	ACME	GIC	Statistics/Statistics/retrieve	\N	{"sizeFilter":3}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppk4-hs6f-hf8cgs	2024-04-29 16:24:04.829707	bblier	ACME	GIC	Statistics/Statistics/retrieve	\N	{"sizeFilter":3}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppqd-arwy-7xpyar	2024-04-29 16:27:49.502769	bblier	ACME	GIC	recordsManagement/accessRule/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppkt-6t7n-skf5b9	2024-04-29 16:24:29.317819	bblier	ACME	GIC	recordsManagement/archivalProfile/readNew	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpplb-bk0g-foiuyk	2024-04-29 16:24:47.539193	bblier	ACME	GIC	recordsManagement/accessRule/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpplj-g00o-syllvh	2024-04-29 16:24:55.746541	bblier	ACME	GIC	recordsManagement/retentionRule/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppll-b9wf-vi9cnr	2024-04-29 16:24:57.526061	bblier	ACME	GIC	recordsManagement/retentionRule/read_code_	{"code":"BULPAI"}	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppqt-bw2h-52vi6e	2024-04-29 16:28:05.554795	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppmf-k3sy-y04gtc	2024-04-29 16:25:27.938086	bblier	ACME	GIC	recordsManagement/accessRule/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppqj-kcu0-92vt6i	2024-04-29 16:27:55	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppqj-kpls-r81jnf	2024-04-29 16:27:55	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppr2-hhxs-x679r7	2024-04-29 16:28:14.81644	bblier	ACME	GIC	auth/userAccount/readNew	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppr2-kqwa-8j3bk0	2024-04-29 16:28:14.967995	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppr5-kby7-3ah7vc	2024-04-29 16:28:17.948634	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppub-cvrw-uwdw0c	2024-04-29 16:30:11.60107	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppub-fhmu-f8r11c	2024-04-29 16:30:11.722717	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppuj-61ke-20hrmr	2024-04-29 16:30:19.281986	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppuj-8d04-bg1c3o	2024-04-29 16:30:19.390115	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppuo-hj5a-4qn5z7	2024-04-29 16:30:24.818009	bblier	ACME	GIC	auth/userAccount/updateDisable_userAccountId_	{"userAccountId":"aackermann"}	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppuq-cinv-m0nzmc	2024-04-29 16:30:26.584093	bblier	ACME	GIC	auth/userAccount/updateEnable_userAccountId_	{"userAccountId":"aackermann"}	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppv3-bcua-7kjukp	2024-04-29 16:30:39.529892	bblier	ACME	GIC	auth/userAccount/updateLock_userAccountId_	{"userAccountId":"aackermann"}	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppv9-3zpf-hzdouv	2024-04-29 16:30:45.186267	bblier	ACME	GIC	auth/userAccount/updateUnlock_userAccountId_	{"userAccountId":"aackermann"}	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppvu-2fld-j7o9wb	2024-04-29 16:31:06.113568	bblier	ACME	GIC	auth/userAccount/updateLock_userAccountId_	{"userAccountId":"aackermann"}	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppvx-2y2p-adhe20	2024-04-29 16:31:09.137504	bblier	ACME	GIC	auth/userAccount/updateUnlock_userAccountId_	{"userAccountId":"aackermann"}	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scppxm-jy86-hklf49	2024-04-29 16:32:10.930839	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpq26-dmkd-2bm0fu	2024-04-29 16:34:54.635793	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpq27-7xl2-c77h28	2024-04-29 16:34:55.370144	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpq2d-0e0h-5zu30u	2024-04-29 16:35:01.018191	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpq2k-1pxc-489xr4	2024-04-29 16:35:08.080283	bblier	ACME	GIC	auth/userAccount/read_userAccountId_	{"userAccountId":"aackermann"}	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpq2k-4tjx-40w3na	2024-04-29 16:35:08.224943	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpq2l-gnl1-9h0qfh	2024-04-29 16:35:09.777098	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpq48-6lv1-gwrybd	2024-04-29 16:36:08.308299	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpq48-97fc-05llvf	2024-04-29 16:36:08.429551	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpq4c-ez14-e5tm02	2024-04-29 16:36:12.698604	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpq4i-1pep-wq5dsa	2024-04-29 16:36:18.079609	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpq4j-5tim-rrpewr	2024-04-29 16:36:19.271574	bblier	ACME	GIC	auth/userAccount/readNew	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpq4j-8u8r-klfity	2024-04-29 16:36:19.412464	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpq4n-8nr6-w4mz2t	2024-04-29 16:36:23	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpq4n-931z-mxs0cs	2024-04-29 16:36:23	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpq4v-ddhl-9alfzd	2024-04-29 16:36:31.624025	__system__	\N	\N	auth/authentication/deleteUserlogin	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpq9p-j8yr-v0pusj	2024-04-29 16:39:25.898126	superadmin	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"superadmin"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpqa1-4ggm-ss73er	2024-04-29 16:39:37.207982	superadmin	\N	\N	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpqa4-2xbp-gyfcgm	2024-04-29 16:39:40.136524	superadmin	\N	\N	auth/userAccount/readUserlist	\N	{"query":"enabled=true"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpqa4-gneo-pu990y	2024-04-29 16:39:40.776863	superadmin	\N	\N	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpqa8-fi1r-yhyfrk	2024-04-29 16:39:44.723273	superadmin	\N	\N	digitalResource/repository/readList	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpqaa-7qxv-9woq0f	2024-04-29 16:39:46.361549	superadmin	\N	\N	digitalResource/repository/read_repositoryId_	{"repositoryId":"archives_1"}	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpqad-6nsj-8tshru	2024-04-29 16:39:49.310814	superadmin	\N	\N	digitalResource/repository/readList	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpqag-8lv6-34t2lj	2024-04-29 16:39:52.401628	superadmin	\N	\N	digitalResource/repository/readList	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpqai-i5xi-aflns3	2024-04-29 16:39:54.847533	superadmin	\N	\N	digitalResource/cluster/readList	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpqbc-ayly-9flhs3	2024-04-29 16:40:24.511439	superadmin	\N	\N	digitalResource/format/readList	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpqbh-akpw-4602wd	2024-04-29 16:40:29.493446	superadmin	\N	\N	digitalResource/conversionRule/readList	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpqje-6qmx-w8t0ka	0034-10-15 16:45:14	superadmin	\N	\N	batchProcessing/scheduling/readSchedulings	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpqjf-gz4j-m04406	0034-10-15 16:45:15	superadmin	\N	\N	batchProcessing/scheduling/readExecute_schedulingId_	{"schedulingId":"chainJournalAudit"}	\N	[{"message":"New journal identifier : %s","variables":"maarchRM_scpqjf-e70a-1l24dw","fullMessage":"New journal identifier : maarchRM_scpqjf-e70a-1l24dw"}]	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpqjg-iekr-jv1w2m	0034-10-15 16:45:16	superadmin	\N	\N	lifeCycle/journal/createChainjournal	\N	\N	[{"message":"New journal identifier : %s","variables":"maarchRM_scpqjg-gpp6-yz273j","fullMessage":"New journal identifier : maarchRM_scpqjg-gpp6-yz273j"}]	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpqjj-2utj-ur0kxi	0034-10-15 16:45:19	superadmin	\N	\N	recordsManagement/archiveCompliance/readPeriodic	\N	\N	[{"message":"%s archive(s) to check","variables":1,"fullMessage":"1 archive(s) to check"},{"message":"%s archive(s) in sample","variables":1,"fullMessage":"1 archive(s) in sample"},{"message":"%s archive(s) checked","variables":1,"fullMessage":"1 archive(s) checked"}]	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpqjk-561p-7q4ua8	0034-10-15 16:45:20	superadmin	\N	\N	recordsManagement/archives/deleteDisposablearchives	\N	\N	[{"message":"%s archives checked","variables":0,"fullMessage":"0 archives checked"},{"message":"%s archives are valid","variables":0,"fullMessage":"0 archives are valid"},{"message":"%s archives are not valid","variables":0,"fullMessage":"0 archives are not valid"}]	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scpqjl-5v4v-70o053	0034-10-15 16:45:21	superadmin	\N	\N	medona/message/deleteMessagedirectorypurge	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqx6y-aan7-w5sbei	0035-10-15 08:06:34	__system__	\N	\N	auth/authentication/deleteUserlogin	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqx9y-6kfp-ax13qt	0035-10-15 08:08:22	bblier	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"bblier"}	\N	t	{"remoteIp":"10.83.1.104"}	maarchRM
maarchRM_scpqlg-38zt-h7jxmy	0034-10-15 16:46:28	superadmin	\N	\N	batchProcessing/scheduling/readSchedulings	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqwfb-90uf-lquvda	0035-10-15 07:49:59	bblier	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"bblier"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqxa8-53xj-54x90f	0035-10-15 08:08:32	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.104"}	maarchRM
maarchRM_scqxa8-5jm3-54x9tf	0035-10-15 08:08:32	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.104"}	maarchRM
maarchRM_scqxek-kpmd-avg4wa	0035-10-15 08:11:08	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":true,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqy1t-6iq3-yigumn	0035-10-15 08:25:05	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqy1t-ayv2-9y9jh4	0035-10-15 08:25:05	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqwfk-a0za-h5uj4l	0035-10-15 07:50:08	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqwfk-ago0-nvrs8i	0035-10-15 07:50:08	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqwfx-c0qx-u5xjft	0035-10-15 07:50:21	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqwfx-gjsq-9tbj3s	0035-10-15 07:50:21	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqwg2-3jfy-fox3yi	0035-10-15 07:50:26	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqwg2-3xmc-k5uhj0	0035-10-15 07:50:26	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqwgk-382j-dohief	0035-10-15 07:50:44	bblier	ACME	GIC	recordsManagement/archiveDescription/read_archiveId_	{"archiveId":"maarchRM_scpqjg-gpp6-yz273j"}	{"isCommunication":"1"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqwgk-ah24-ej73pf	0035-10-15 07:50:44	bblier	ACME	GIC	recordsManagement/archiveDescription/read_archiveId_	{"archiveId":"maarchRM_scpqjg-gpp6-yz273j"}	{"isCommunication":"1"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqxaz-2162-2jp7w3	0035-10-15 08:08:59	bblier	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"bblier"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqxb3-f4y8-r2ymin	0035-10-15 08:09:03	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqxb3-fgkb-al13ud	0035-10-15 08:09:03	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqxsu-1xfv-nd3ro1	0035-10-15 08:19:42	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":true,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqy23-hk0v-mng6da	0035-10-15 08:25:15	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqy23-hz8j-ti6dei	0035-10-15 08:25:15	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqxag-2bku-gkma99	0035-10-15 08:08:40	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjg-gsp2-etc3jo","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.104"}	maarchRM
maarchRM_scqxag-2khu-40kzkf	0035-10-15 08:08:40	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjg-gsp2-etc3jo","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.104"}	maarchRM
maarchRM_scqxah-cmit-bdfod3	0035-10-15 08:08:41	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.104"}	maarchRM
maarchRM_scqxah-cyyl-4rtots	0035-10-15 08:08:41	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.104"}	maarchRM
maarchRM_scqxak-0das-qddzbm	0035-10-15 08:08:44	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-euzk-dl0c6t","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.104"}	maarchRM
maarchRM_scqxak-0raz-bm70mi	0035-10-15 08:08:44	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-euzk-dl0c6t","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.104"}	maarchRM
maarchRM_scqxaq-f8vq-kmnirq	0035-10-15 08:08:50	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.104"}	maarchRM
maarchRM_scqxaq-fj1h-fj8olc	0035-10-15 08:08:50	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.104"}	maarchRM
maarchRM_scqy2e-4wkd-l9fcqw	0035-10-15 08:25:26	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqy56-6hq2-9jtz4w	0035-10-15 08:27:06	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqy57-0pn1-yyxbjw	0035-10-15 08:27:07	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqy7s-amey-1e60ib	0035-10-15 08:28:40	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqy86-9o5u-nfxvjj	0035-10-15 08:28:54	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":true,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqy9y-29at-hinbye	0035-10-15 08:29:58	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqy9y-6e3i-sjkrkd	0035-10-15 08:29:58	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqygg-ft38-8zhm2n	0035-10-15 08:33:52	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqyka-bjlu-99gkvn	0035-10-15 08:36:10	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqykb-6vhf-2gqetp	0035-10-15 08:36:11	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqylp-24lt-fnixqc	0035-10-15 08:37:01	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqylw-aqlq-il15me	0035-10-15 08:37:08	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqylx-4bxa-9b8lny	0035-10-15 08:37:09	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqynu-8j3g-9txzjk	0035-10-15 08:38:18	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqyr5-18qk-wbn7yq	0035-10-15 08:40:17	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqyr5-1l8g-33arrp	0035-10-15 08:40:17	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqyrb-8141-xhz9fq	0035-10-15 08:40:23	bblier	ACME	GIC	recordsManagement/archiveDescription/read_archiveId_	{"archiveId":"maarchRM_scpqjf-e70a-1l24dw"}	{"isCommunication":"1"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqyrb-f0cm-kqa3pt	0035-10-15 08:40:23	bblier	ACME	GIC	recordsManagement/archiveDescription/read_archiveId_	{"archiveId":"maarchRM_scpqjf-e70a-1l24dw"}	{"isCommunication":"1"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqyrn-4iec-l22vv4	0035-10-15 08:40:35	bblier	ACME	GIC	recordsManagement/archiveDescription/read_archiveId_	{"archiveId":"maarchRM_scpqjf-e70a-1l24dw"}	{"isCommunication":"1"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqyz4-1igj-242d53	0035-10-15 08:45:04	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqyz4-isao-0ju4wu	0035-10-15 08:45:04	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqz0t-4uvr-6y8fae	0035-10-15 08:46:05	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqz3x-f61c-wo1nng	0035-10-15 08:47:57	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqz3y-2uai-uhswr9	0035-10-15 08:47:58	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqz58-ibk2-1qa57u	0035-10-15 08:48:44	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqz77-ksd3-sdgqak	0035-10-15 08:49:55	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqz78-98g8-g4lmd2	0035-10-15 08:49:56	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqz84-9esb-mklefy	0035-10-15 08:50:28	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"archiveExpired":"false","partialRetentionRule":true,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqz84-9x6x-6wzpl4	0035-10-15 08:50:28	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"archiveExpired":"false","partialRetentionRule":true,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqz9x-050r-kmebp3	0035-10-15 08:51:33	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"archiveExpired":"false","partialRetentionRule":true,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqz9x-0lgi-rm3dpa	0035-10-15 08:51:33	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"archiveExpired":"false","partialRetentionRule":true,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqza1-bv17-rcms23	0035-10-15 08:51:37	bblier	ACME	GIC	recordsManagement/archive/readAccessrule_archiveId_	{"archiveId":"maarchRM_scpqjg-gpp6-yz273j"}	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqzee-8v8a-twq04g	0035-10-15 08:54:14	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqzib-3oqr-f78woa	0035-10-15 08:56:35	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqzib-ed9c-ngs68s	0035-10-15 08:56:35	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqzij-ef5s-3occg0	0035-10-15 08:56:43	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqzjh-3ta7-pm5qsc	0035-10-15 08:57:17	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqzjh-eyew-okb1j6	0035-10-15 08:57:17	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqzks-2c0c-ez33t1	0035-10-15 08:58:04	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"partialRetentionRule":true,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqzks-2owk-q6h1x8	0035-10-15 08:58:04	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"partialRetentionRule":true,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqzmc-8mqe-3rxc04	0035-10-15 08:59:00	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqzsu-a3y2-6v8m9a	0035-10-15 09:02:54	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqzsv-3byx-txcjc0	0035-10-15 09:02:55	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr10p-hok2-y5oes9	0035-10-15 09:29:13	bblier	ACME	GIC	lifeCycle/event/readSearch	\N	{"eventType":"digitalResource/integrityCheck","maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr10p-i261-r1sk2j	0035-10-15 09:29:13	bblier	ACME	GIC	lifeCycle/event/readCount	\N	{"eventType":"digitalResource/integrityCheck"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1me-54g6-i2qbqs	0035-10-15 09:42:14	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1me-5nwu-4poq60	0035-10-15 09:42:14	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1me-ims9-lc5u67	0035-10-15 09:42:14	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1me-iyjm-padyga	0035-10-15 09:42:14	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1mg-14as-kydgy5	0035-10-15 09:42:16	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1mg-1i2s-fbjpjc	0035-10-15 09:42:16	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1mg-ikf7-j7qgda	0035-10-15 09:42:16	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1mg-j7z5-dxyrbn	0035-10-15 09:42:16	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1mi-l2q6-iqovm6	0035-10-15 09:42:18	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1mj-03am-rkmo17	0035-10-15 09:42:18	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1mj-9tal-k78s3k	0035-10-15 09:42:19	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjg-gsp2-etc3jo","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1mj-a9eo-jzqdyz	0035-10-15 09:42:19	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjg-gsp2-etc3jo","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1mk-5bvg-1umrwz	0035-10-15 09:42:20	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1mk-65mo-6dclzw	0035-10-15 09:42:20	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqzoe-co46-942sor	0035-10-15 09:00:14	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqzof-7tl8-qbf9y5	0035-10-15 09:00:15	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqzvj-2s80-smyjo5	0035-10-15 09:04:31	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqzvj-gots-6oy7xl	0035-10-15 09:04:31	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqzp5-8frl-66j0og	0035-10-15 09:00:41	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqzz2-l812-ns7688	0035-10-15 09:06:38	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqzz3-dj08-cjln3d	0035-10-15 09:06:39	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqzpd-i8e7-y9y07u	0035-10-15 09:00:49	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqzpe-49kx-lpu6ap	0035-10-15 09:00:50	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqzsm-jy6s-onlxyz	0035-10-15 09:02:46	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqzt9-fgl0-0peqpq	0035-10-15 09:03:09	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqzzc-3gsz-2vjxmh	0035-10-15 09:06:48	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqzzc-3zk9-41eytj	0035-10-15 09:06:48	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr10f-i4t6-1n31e5	0035-10-15 09:29:03	bblier	ACME	GIC	lifeCycle/event/readSearch	\N	{"eventType":"organization/counting","objectClass":"organization/organization","maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr10f-ihxt-3l5cxt	0035-10-15 09:29:03	bblier	ACME	GIC	lifeCycle/event/readCount	\N	{"eventType":"organization/counting","objectClass":"organization/organization"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr13s-28hj-g2rhtc	0035-10-15 09:31:04	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr13s-2m7b-vvg1ss	0035-10-15 09:31:04	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr13t-43nc-udk6n5	0035-10-15 09:31:05	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr13t-4i8z-mbzobu	0035-10-15 09:31:05	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr13w-eajm-gm5z53	0035-10-15 09:31:08	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr13w-enip-d1ww8g	0035-10-15 09:31:08	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1ko-gijr-dsbixe	0035-10-15 09:41:12	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1ko-gudt-ibrb7k	0035-10-15 09:41:12	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scqzvq-95rw-qmqcfc	0035-10-15 09:04:38	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr0ce-2la6-ci363f	0035-10-15 09:14:38	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":true,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr009-huvt-pgnhkc	0035-10-15 09:07:21	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":true,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr16u-bkk5-6su3oy	0035-10-15 09:32:54	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr16u-bwdp-0jx9py	0035-10-15 09:32:54	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr0ra-7qmg-iltygo	0035-10-15 09:23:34	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":true,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr10v-7kny-x84x8s	0035-10-15 09:29:19	bblier	ACME	GIC	lifeCycle/event/readSearch	\N	{"eventType":"recordsManagement/profileCreation","objectClass":"recordsManagement/archivalProfile","maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr10v-7vg2-e83qtw	0035-10-15 09:29:19	bblier	ACME	GIC	lifeCycle/event/readCount	\N	{"eventType":"recordsManagement/profileCreation","objectClass":"recordsManagement/archivalProfile"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr110-4lj6-3w8z2i	0035-10-15 09:29:24	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr110-5056-cwc79r	0035-10-15 09:29:24	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr131-8r5b-vo1xs7	0035-10-15 09:30:37	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr131-972y-50osrz	0035-10-15 09:30:37	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr133-cawe-qq7sh8	0035-10-15 09:30:39	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr133-csar-tc1aai	0035-10-15 09:30:39	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr135-fd3a-v0x3zy	0035-10-15 09:30:41	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-euzk-dl0c6t","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr135-ft7u-lwke4m	0035-10-15 09:30:41	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-euzk-dl0c6t","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr136-ik7b-p05q7p	0035-10-15 09:30:42	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-f1e4-tltpik","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr136-j07b-mr7x0h	0035-10-15 09:30:42	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-f1e4-tltpik","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr138-bltv-4lq35l	0035-10-15 09:30:44	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr138-bzmq-8f705g	0035-10-15 09:30:44	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr17o-591i-gw25ld	0035-10-15 09:33:24	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr17o-5t36-vxs5kv	0035-10-15 09:33:24	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1ou-ghea-f72i71	0035-10-15 09:43:42	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1ou-grvk-qp2tag	0035-10-15 09:43:42	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1ov-eh0s-p5s3r3	0035-10-15 09:43:43	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1ov-etb6-p1jywk	0035-10-15 09:43:43	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1qm-dq8u-rdu6gg	0035-10-15 09:44:46	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1qm-e26v-ou49en	0035-10-15 09:44:46	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1qy-cmn2-jy7fr6	0035-10-15 09:44:58	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1qy-cvwb-smad7d	0035-10-15 09:44:58	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1qz-eplx-lecwq7	0035-10-15 09:44:59	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1qz-f4jc-fpy4e2	0035-10-15 09:44:59	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1s5-aw68-ygknqy	0035-10-15 09:45:41	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1s5-ba2w-ssqo66	0035-10-15 09:45:41	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1sl-62wk-6e56bl	0035-10-15 09:45:57	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1sl-6fvz-3tz1px	0035-10-15 09:45:57	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1so-0og6-2demq8	0035-10-15 09:46:00	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-euzk-dl0c6t","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1so-155z-yun428	0035-10-15 09:46:00	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-euzk-dl0c6t","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1t1-294l-8ssrea	0035-10-15 09:46:13	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1t1-2liw-jl0szb	0035-10-15 09:46:13	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1t2-7263-rpb7ts	0035-10-15 09:46:14	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1t2-7f3w-yg5jh1	0035-10-15 09:46:14	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1t3-dmff-tqk5oy	0035-10-15 09:46:15	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1t3-e8zj-bcc837	0035-10-15 09:46:15	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1uu-fh9l-ov3db3	0035-10-15 09:47:18	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1uu-fql8-dlzcga	0035-10-15 09:47:18	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1wj-0va7-2bthzc	0035-10-15 09:48:19	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1wj-1bp5-wstc3x	0035-10-15 09:48:19	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr20k-cn4x-g8dfzv	0035-10-15 09:50:44	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr20k-d0md-nobeln	0035-10-15 09:50:44	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr22v-7gyf-imdcuv	0035-10-15 09:52:07	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-euzk-dl0c6t","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr22v-7xhv-nptj1r	0035-10-15 09:52:07	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-euzk-dl0c6t","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr22w-kbxh-0ha65i	0035-10-15 09:52:08	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-euzk-dl0c6t","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr22w-l57q-xuzcz9	0035-10-15 09:52:08	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-euzk-dl0c6t","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr232-gum5-bzq815	0035-10-15 09:52:14	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr232-hcmg-xtyfsw	0035-10-15 09:52:14	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr235-ei5e-b8lrvg	0035-10-15 09:52:17	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr235-ezzl-f6k0eb	0035-10-15 09:52:17	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr236-c3da-jmakx6	0035-10-15 09:52:18	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr236-cex7-7578it	0035-10-15 09:52:18	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr23a-7jdh-tydi4j	0035-10-15 09:52:22	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr23a-86xf-9xmh82	0035-10-15 09:52:22	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr23b-25v6-7ckrxl	0035-10-15 09:52:23	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr23b-2ty8-doq25f	0035-10-15 09:52:23	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1vv-j2e7-4fkt4v	0035-10-15 09:47:55	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1vv-jil1-slnyfm	0035-10-15 09:47:55	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1y5-gkpb-61s4h9	0035-10-15 09:49:17	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1y5-gyqx-hjh5cv	0035-10-15 09:49:17	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1y9-8eqy-jqxrqi	0035-10-15 09:49:21	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1y9-8p88-7vrqte	0035-10-15 09:49:21	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr25a-f9w6-ioqqbb	0035-10-15 09:53:34	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr25c-5fif-hrzv9k	0035-10-15 09:53:36	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	{"query":"enabled=true"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr25d-52vy-fkdjr5	0035-10-15 09:53:37	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr25f-e714-s475rr	0035-10-15 09:53:39	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr25f-h70s-isdiho	0035-10-15 09:53:39	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1w3-kfuj-kpezz1	0035-10-15 09:48:03	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1w3-ktdh-ik8l8u	0035-10-15 09:48:03	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1w4-hvzn-s3cm1j	0035-10-15 09:48:04	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjg-gsp2-etc3jo","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1w4-i4ho-c5dtbf	0035-10-15 09:48:04	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjg-gsp2-etc3jo","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1w5-d6ub-0c06tb	0035-10-15 09:48:05	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1w5-dhem-mfibuk	0035-10-15 09:48:05	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1xq-jkmu-xvd933	0035-10-15 09:49:02	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1xq-k0cs-pry5uy	0035-10-15 09:49:02	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1xs-bz6w-nlaw8z	0035-10-15 09:49:04	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1xs-ci1f-u721lz	0035-10-15 09:49:04	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1xu-0r9u-ist1o4	0035-10-15 09:49:06	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-euzk-dl0c6t","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1xu-1eir-sie9bh	0035-10-15 09:49:06	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-euzk-dl0c6t","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1xu-l431-wkcqnq	0035-10-15 09:49:06	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr1xv-029v-0fgnh1	0035-10-15 09:49:06	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr20c-3kom-bj2ptp	0035-10-15 09:50:36	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr20c-3yw0-t1lztl	0035-10-15 09:50:36	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr212-ht20-p32um7	0035-10-15 09:51:02	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr212-i23c-3t8ylo	0035-10-15 09:51:02	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr21e-fb87-amzlwe	0035-10-15 09:51:14	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr21e-foo6-j59y1l	0035-10-15 09:51:14	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr21n-dgp5-rsafs1	0035-10-15 09:51:23	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr21n-dx6y-wckzgt	0035-10-15 09:51:23	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr21s-iyh5-mhzeg4	0035-10-15 09:51:28	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr21s-je1y-pztxo3	0035-10-15 09:51:28	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr21w-b9xd-mxlgc2	0035-10-15 09:51:32	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr21w-bp12-lq2was	0035-10-15 09:51:32	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr25z-8b5w-r8g6y1	0035-10-15 09:53:59	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	{"query":"enabled=true"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr25z-kad8-ygxo1w	0035-10-15 09:53:59	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr264-8hh6-qa9jbs	0035-10-15 09:54:04	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr264-b5j1-cl798w	0035-10-15 09:54:04	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr2yo-9wro-e2jjgc	0035-10-15 10:11:12	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr2yo-aa8d-6zlmlr	0035-10-15 10:11:12	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr2yq-0wc8-kcsexr	0035-10-15 10:11:14	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr2yq-1c7l-1yduiu	0035-10-15 10:11:14	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr23o-71dv-legbyn	0035-10-15 09:52:36	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-euzk-dl0c6t","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr23o-79n6-je4m8n	0035-10-15 09:52:36	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-euzk-dl0c6t","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr23o-iw0o-cz17e6	0035-10-15 09:52:36	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjg-gsp2-etc3jo","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr23o-javp-c9v1b4	0035-10-15 09:52:36	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjg-gsp2-etc3jo","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr23t-2d9k-kpl88b	0035-10-15 09:52:41	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr23t-5zrx-7ddxfw	0035-10-15 09:52:41	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr241-0oa5-089xgy	0035-10-15 09:52:49	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"hasParent":false,"partialRetentionRule":true,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr241-0zgr-h80tjd	0035-10-15 09:52:49	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"hasParent":false,"partialRetentionRule":true,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr245-i1os-gjzab7	0035-10-15 09:52:53	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr245-ig7b-8nkzrc	0035-10-15 09:52:53	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr249-882s-78dyz7	0035-10-15 09:52:57	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr24b-gegj-vh0o3z	0035-10-15 09:52:59	bblier	ACME	GIC	auth/userAccount/readNew	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr24b-jksu-kr7xe7	0035-10-15 09:52:59	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr477-h21v-npn080	0035-10-15 10:37:55	__system__	\N	\N	auth/authentication/deleteUserlogin	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr47k-g07k-tkpwi5	0035-10-15 10:38:08	__system__	\N	\N	auth/authentication/deleteUserlogin	\N	\N	Object of class auth/account identified by  was not found	f	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr47r-991i-2pibhl	0035-10-15 10:38:15	bblier	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"bblier"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr4nj-8g4c-fms42z	0035-10-15 10:47:43	__system__	\N	\N	auth/authentication/deleteUserlogin	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr516-ij7r-5i50oz	0035-10-15 10:55:54	bblier	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"bblier"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr51d-6h16-i08u1a	0035-10-15 10:56:01	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr51d-718e-3xt73a	0035-10-15 10:56:01	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr51h-hc01-g7bpmm	0035-10-15 10:56:05	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr51h-ldd3-leqz6c	0035-10-15 10:56:05	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr51x-0b5o-sll3y6	0035-10-15 10:56:21	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"partialRetentionRule":true,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr51x-0l6j-dwu8lz	0035-10-15 10:56:21	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"partialRetentionRule":true,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr521-c511-vx8y91	0035-10-15 10:56:25	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr521-chri-51sn2b	0035-10-15 10:56:25	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr529-2pya-dd9gw4	0035-10-15 10:56:33	__system__	\N	\N	auth/authentication/deleteUserlogin	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5bk-8ryd-omwx9v	0035-10-15 11:02:08	bblier	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"bblier"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5bs-2wu3-p3fkyp	0035-10-15 11:02:16	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5bs-3cck-a2wb19	0035-10-15 11:02:16	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5bx-jaw9-5eh6d0	0035-10-15 11:02:21	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5c3-i5v6-l7gzns	0035-10-15 11:02:27	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5c4-0zt1-w4vf27	0035-10-15 11:02:28	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5f8-9gem-3mclb1	0035-10-15 11:04:20	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5f8-9uo8-k247ub	0035-10-15 11:04:20	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5f9-4qug-f8c007	0035-10-15 11:04:21	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5f9-54li-9ynlia	0035-10-15 11:04:21	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5f9-jkkt-jnfw54	0035-10-15 11:04:21	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5n0-54er-5x6ov2	0035-10-15 11:09:00	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5f9-jyg5-oon4us	0035-10-15 11:04:21	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5fa-hysd-m0tlkc	0035-10-15 11:04:22	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5fa-icnp-kvp6gs	0035-10-15 11:04:22	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5fc-45vz-v4ke4y	0035-10-15 11:04:24	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5fc-515w-jwxp78	0035-10-15 11:04:24	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5fe-borp-navmvg	0035-10-15 11:04:26	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5fe-c3we-t09trl	0035-10-15 11:04:26	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5fn-f0xm-svh3cg	0035-10-15 11:04:35	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5fn-fhv0-t01hoq	0035-10-15 11:04:35	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5ge-4hzb-najkm7	0035-10-15 11:05:02	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjg-gsp2-etc3jo","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5ge-4wqc-9lik7v	0035-10-15 11:05:02	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjg-gsp2-etc3jo","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5hz-j4mx-8phxib	0035-10-15 11:05:59	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5hz-jkbr-fkjg7n	0035-10-15 11:05:59	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5i1-0bqq-9wqljj	0035-10-15 11:06:01	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjg-gsp2-etc3jo","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5i1-0txi-0b6psb	0035-10-15 11:06:01	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjg-gsp2-etc3jo","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5i1-i5z6-jvetyg	0035-10-15 11:06:01	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5i1-ink9-tlb3nr	0035-10-15 11:06:01	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5i4-d6lt-k0iob0	0035-10-15 11:06:04	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjg-gsp2-etc3jo","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5i4-e107-rnmrl2	0035-10-15 11:06:04	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjg-gsp2-etc3jo","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5i5-87q8-hi22ya	0035-10-15 11:06:05	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5i5-8krq-57he0e	0035-10-15 11:06:05	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5i6-1gz5-qqf7si	0035-10-15 11:06:06	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5i6-1rwf-asuhqm	0035-10-15 11:06:06	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5ie-j5is-oeerab	0035-10-15 11:06:14	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5ie-jnri-2icua5	0035-10-15 11:06:14	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5if-hh2j-aw80bz	0035-10-15 11:06:15	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjg-gsp2-etc3jo","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5if-hsv6-8j37fi	0035-10-15 11:06:15	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjg-gsp2-etc3jo","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5ig-g547-th2hoh	0035-10-15 11:06:16	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5ig-glm4-2bnobe	0035-10-15 11:06:16	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5ii-5s4j-vczx09	0035-10-15 11:06:18	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5ii-69nw-70cr1o	0035-10-15 11:06:18	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5ii-iz88-dc07nj	0035-10-15 11:06:18	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjg-gsp2-etc3jo","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5ii-jegx-d88rkt	0035-10-15 11:06:18	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjg-gsp2-etc3jo","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5im-i087-sn8mcs	0035-10-15 11:06:22	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5k3-0pky-307xj0	0035-10-15 11:07:15	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5k3-eo5b-rg7c32	0035-10-15 11:07:15	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5lv-6nzw-gg6106	0035-10-15 11:08:19	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5m6-j3w8-pouz58	0035-10-15 11:08:30	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5m7-77fg-nzwtnw	0035-10-15 11:08:31	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5ma-go57-ex38yz	0035-10-15 11:08:34	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5vs-c30c-b6nu16	0035-10-15 11:14:16	bblier	ACME	GIC	batchProcessing/scheduling/readSchedulings	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5yq-bx2d-pw6sse	0035-10-15 11:16:02	bblier	ACME	GIC	batchProcessing/scheduling/readSchedulings	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5n0-9wa3-vb01z4	0035-10-15 11:09:00	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5n5-blnj-iql464	0035-10-15 11:09:05	bblier	ACME	GIC	batchProcessing/scheduling/readSchedulings	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5na-9ete-opbe42	0035-10-15 11:09:10	bblier	ACME	GIC	auth/serviceAccount/readByRoute	\N	{"serviceUri":"lifeCycle/journal/createChainjournal"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5nb-gvqk-cn8a1w	0035-10-15 11:09:11	bblier	ACME	GIC	auth/serviceAccount/readByRoute	\N	{"serviceUri":"audit/event/createChainjournal"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5nc-jbde-rgxew5	0035-10-15 11:09:12	bblier	ACME	GIC	auth/serviceAccount/readByRoute	\N	{"serviceUri":"lifeCycle/journal/createChainjournal"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5y9-639r-tfieuc	0035-10-15 11:15:45	bblier	ACME	GIC	batchProcessing/scheduling/readSchedulings	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr63d-73e2-pzrqp4	0035-10-15 11:18:49	bblier	ACME	GIC	batchProcessing/scheduling/readSchedulings	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr658-9jmu-dwt16i	0035-10-15 11:19:56	bblier	ACME	GIC	auth/serviceAccount/readByRoute	\N	{"serviceUri":"audit/event/createChainjournal"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr659-in8e-0glnyo	0035-10-15 11:19:57	bblier	ACME	GIC	auth/serviceAccount/readByRoute	\N	{"serviceUri":"lifeCycle/journal/createChainjournal"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr65b-7gvb-vdy0qa	0035-10-15 11:19:59	bblier	ACME	GIC	auth/serviceAccount/readByRoute	\N	{"serviceUri":"recordsManagement/archiveCompliance/readPeriodic"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr65c-e2um-jo8u18	0035-10-15 11:20:00	bblier	ACME	GIC	auth/serviceAccount/readByRoute	\N	{"serviceUri":"recordsManagement/archives/deleteDisposablearchives"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr65d-hgbd-818uvf	0035-10-15 11:20:01	bblier	ACME	GIC	auth/serviceAccount/readByRoute	\N	{"serviceUri":"medona/message/deleteMessageDirectoryPurge"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr65g-jwb7-52mbbt	0035-10-15 11:20:04	bblier	ACME	GIC	batchProcessing/scheduling/updateChangestatus	\N	{"schedulingId":"chainJournalAudit","status":"paused"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr65k-8x7a-6z5457	0035-10-15 11:20:08	bblier	ACME	GIC	auth/serviceAccount/readByRoute	\N	{"serviceUri":"audit/event/createChainjournal"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5on-536s-bb3qd7	0035-10-15 11:09:59	bblier	ACME	GIC	auth/serviceAccount/readByRoute	\N	{"serviceUri":"lifeCycle/journal/createChainjournal"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5tn-cufg-z0rp66	0035-10-15 11:12:59	bblier	ACME	GIC	batchProcessing/scheduling/readSchedulings	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5yw-3xlw-p93v1e	0035-10-15 11:16:08	bblier	ACME	GIC	batchProcessing/scheduling/readSchedulings	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr648-45aj-avkxuj	0035-10-15 11:19:20	bblier	ACME	GIC	batchProcessing/scheduling/readSchedulings	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5on-5xpe-4hlgjs	0035-10-15 11:09:59	bblier	ACME	GIC	batchProcessing/scheduling/updateChangestatus	\N	{"schedulingId":"chainJournalLifeCycle","status":"paused"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5ot-49ai-wlln85	0035-10-15 11:10:05	bblier	ACME	GIC	auth/serviceAccount/readByRoute	\N	{"serviceUri":"lifeCycle/journal/createChainjournal"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5yi-6x7q-fd7po6	0035-10-15 11:15:54	bblier	ACME	GIC	batchProcessing/scheduling/readSchedulings	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5ot-4g7j-ehw0bh	0035-10-15 11:10:05	bblier	ACME	GIC	batchProcessing/scheduling/updateChangestatus	\N	{"schedulingId":"chainJournalLifeCycle","status":"scheduled"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5p0-dh62-bkqpsk	0035-10-15 11:10:12	bblier	ACME	GIC	auth/serviceAccount/readByRoute	\N	{"serviceUri":"audit/event/createChainjournal"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5tq-96k5-w6vul5	0035-10-15 11:13:02	bblier	ACME	GIC	auth/serviceAccount/readByRoute	\N	{"serviceUri":"lifeCycle/journal/createChainjournal"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5tf-778q-wwzmze	0035-10-15 11:12:51	bblier	ACME	GIC	batchProcessing/scheduling/readSchedulings	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr64x-aa3h-gnf9nk	0035-10-15 11:19:45	bblier	ACME	GIC	auth/serviceAccount/readByRoute	\N	{"serviceUri":"lifeCycle/journal/createChainjournal"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5u0-0qdo-30xmvl	0035-10-15 11:13:12	bblier	ACME	GIC	auth/serviceAccount/readByRoute	\N	{"serviceUri":"recordsManagement/archiveCompliance/readPeriodic"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5zi-4m7v-uc5swz	0035-10-15 11:16:30	bblier	ACME	GIC	batchProcessing/scheduling/readSchedulings	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr5zo-h5m0-4wbbhb	0035-10-15 11:16:36	bblier	ACME	GIC	batchProcessing/scheduling/readSchedulings	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr64x-apkp-8tyez5	0035-10-15 11:19:45	bblier	ACME	GIC	batchProcessing/scheduling/updateChangestatus	\N	{"schedulingId":"chainJournalLifeCycle","status":"paused"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr65g-k8j0-jgwkk2	0035-10-15 11:20:04	bblier	ACME	GIC	auth/serviceAccount/readByRoute	\N	{"serviceUri":"audit/event/createChainjournal"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr65k-8yg6-1tu8ie	0035-10-15 11:20:08	bblier	ACME	GIC	batchProcessing/scheduling/updateChangestatus	\N	{"schedulingId":"chainJournalAudit","status":"scheduled"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr65p-5yk2-ffisme	0035-10-15 11:20:13	bblier	ACME	GIC	auth/serviceAccount/readByRoute	\N	{"serviceUri":"lifeCycle/journal/createChainjournal"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr65s-ib5g-av9bzs	0035-10-15 11:20:16	bblier	ACME	GIC	auth/serviceAccount/readByRoute	\N	{"serviceUri":"audit/event/createChainjournal"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr65u-dls5-kkvshl	0035-10-15 11:20:18	bblier	ACME	GIC	auth/serviceAccount/readByRoute	\N	{"serviceUri":"recordsManagement/archives/deleteDisposablearchives"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr68h-c3i2-5mfu1o	0035-10-15 11:21:53	bblier	ACME	GIC	batchProcessing/scheduling/readSchedulings	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr68o-b63u-cm0cqp	0035-10-15 11:22:00	bblier	ACME	GIC	batchProcessing/scheduling/readSchedulings	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr6am-amr8-yowij0	0035-10-15 11:23:10	bblier	ACME	GIC	auth/serviceAccount/readByRoute	\N	{"serviceUri":"audit/event/createChainjournal"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr6am-atpq-mzbijc	0035-10-15 11:23:10	bblier	ACME	GIC	batchProcessing/scheduling/updateChangestatus	\N	{"schedulingId":"chainJournalAudit","status":"paused"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr6as-6a3a-vvoq25	0035-10-15 11:23:16	bblier	ACME	GIC	batchProcessing/scheduling/readSchedulings	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr6au-hjp3-q2hmaw	0035-10-15 11:23:18	bblier	ACME	GIC	auth/serviceAccount/readByRoute	\N	{"serviceUri":"lifeCycle/journal/createChainjournal"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr6b5-jmf0-rdu6zy	0035-10-15 11:23:29	bblier	ACME	GIC	Statistics/Statistics/index	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr6b7-chlw-8rcq4d	0035-10-15 11:23:31	bblier	ACME	GIC	Statistics/Statistics/retrieve	\N	{"sizeFilter":3}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr6bt-bv30-b2xkrx	0035-10-15 11:23:53	bblier	ACME	GIC	Statistics/Statistics/retrieve	\N	{"sizeFilter":0}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr6bx-h4iq-bo70nm	0035-10-15 11:23:57	bblier	ACME	GIC	Statistics/Statistics/retrieve	\N	{"sizeFilter":1}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr9pq-ere6-l4dry6	0035-10-15 12:37:02	bblier	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"bblier"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scr9se-9uc6-x6h53s	0035-10-15 12:38:38	__system__	\N	\N	auth/authentication/deleteUserlogin	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scurjy-ah7m-75kqf1	0007-11-14 09:55:10	bblier	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"bblier"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scurk0-f3st-jp9ff4	0007-11-14 09:55:12	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scurk0-fb7v-0f87k4	0007-11-14 09:55:12	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scurk8-dpow-wxo1f6	0007-11-14 09:55:20	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-euzk-dl0c6t","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scurk8-e4bx-bg2e7g	0007-11-14 09:55:20	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-euzk-dl0c6t","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scurk9-fug5-1eyxey	0007-11-14 09:55:21	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-f1e4-tltpik","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scurk9-g5yi-8a3xof	0007-11-14 09:55:21	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-f1e4-tltpik","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scurka-8ewo-j6o56h	0007-11-14 09:55:22	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjg-gsp2-etc3jo","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scurka-8p03-lmtwp3	0007-11-14 09:55:22	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjg-gsp2-etc3jo","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scurkd-dla1-adgj3k	0007-11-14 09:55:25	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":true,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scurki-enmw-1mn6iz	0007-11-14 09:55:30	bblier	ACME	GIC	lifeCycle/event/readSearch	\N	{"eventType":"digitalResource/integrityCheck","maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scurki-f26s-di2rtz	0007-11-14 09:55:30	bblier	ACME	GIC	lifeCycle/event/readCount	\N	{"eventType":"digitalResource/integrityCheck"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scurkq-1ox6-htwxsc	0007-11-14 09:55:38	bblier	ACME	GIC	lifeCycle/event/readSearch	\N	{"eventType":"organization/counting","objectClass":"organization/organization","maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scurkq-1wsm-8y9nj0	0007-11-14 09:55:38	bblier	ACME	GIC	lifeCycle/event/readCount	\N	{"eventType":"organization/counting","objectClass":"organization/organization"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scurks-dtzm-239mer	0007-11-14 09:55:40	bblier	ACME	GIC	lifeCycle/event/readSearch	\N	{"objectClass":"recordsManagement/archivalProfile","maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scurks-e8nd-gtsesz	0007-11-14 09:55:40	bblier	ACME	GIC	lifeCycle/event/readCount	\N	{"objectClass":"recordsManagement/archivalProfile"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scurkw-6uux-m40kct	0007-11-14 09:55:44	bblier	ACME	GIC	lifeCycle/event/readSearch	\N	{"objectClass":"recordsManagement/serviceLevel","maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scurlk-bw1x-562lgr	0007-11-14 09:56:08	superadmin	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"superadmin"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scurkw-78rb-z3izh1	0007-11-14 09:55:44	bblier	ACME	GIC	lifeCycle/event/readCount	\N	{"objectClass":"recordsManagement/serviceLevel"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scurky-hs6g-6gr87e	0007-11-14 09:55:46	bblier	ACME	GIC	lifeCycle/event/read_eventId_	{"eventId":"maarchRM_scpqjj-2ap5-3h74wy"}	\N	[{"message":"%s archives checked","variables":1,"fullMessage":"1 archives checked"},{"message":"%s archives are valid","variables":1,"fullMessage":"1 archives are valid"},{"message":"%s archives are not valid","variables":0,"fullMessage":"0 archives are not valid"}]	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scurl0-edqp-ripp5g	0007-11-14 09:55:48	bblier	ACME	GIC	lifeCycle/event/read_eventId_	{"eventId":"maarchRM_scpqjj-2ap5-3h74wy"}	\N	[{"message":"%s archives checked","variables":1,"fullMessage":"1 archives checked"},{"message":"%s archives are valid","variables":1,"fullMessage":"1 archives are valid"},{"message":"%s archives are not valid","variables":0,"fullMessage":"0 archives are not valid"}]	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scurl2-j0n5-ul7j5n	0007-11-14 09:55:50	bblier	ACME	GIC	lifeCycle/event/read_eventId_	{"eventId":"maarchRM_scpqji-jzoc-iiho8k"}	\N	[{"message":"%s archives checked","variables":1,"fullMessage":"1 archives checked"},{"message":"%s archives are valid","variables":1,"fullMessage":"1 archives are valid"},{"message":"%s archives are not valid","variables":0,"fullMessage":"0 archives are not valid"}]	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scurlb-80oq-717bal	0007-11-14 09:55:59	__system__	\N	\N	auth/authentication/deleteUserlogin	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scus8z-2nf1-0pwask	0007-11-14 10:10:11	superadmin	\N	\N	batchProcessing/scheduling/readSchedulings	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scus91-glq4-gs00ga	0007-11-14 10:10:13	superadmin	\N	\N	auth/serviceAccount/readByRoute	\N	{"serviceUri":"audit/event/createChainjournal"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scus9d-kta3-7z7ihp	0007-11-14 10:10:25	superadmin	\N	\N	auth/serviceAccount/readByRoute	\N	{"serviceUri":"lifeCycle/journal/createChainjournal"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scusba-f4bo-ltm5jm	0007-11-14 10:11:34	superadmin	\N	\N	auth/serviceAccount/readByRoute	\N	{"serviceUri":"medona/message/deleteMessageDirectoryPurge"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scusej-13x7-dyoeo0	0007-11-14 10:13:31	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	{"query":"enabled=true"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scusf3-eqzm-w1zh1s	0007-11-14 10:13:51	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scusgd-gl0x-lrifxb	0007-11-14 10:14:37	bblier	ACME	GIC	auth/userAccount/readProfile	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scusgj-ilha-99mchr	0007-11-14 10:14:43	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scusgj-ivjl-u74xv7	0007-11-14 10:14:43	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scusgo-cfqk-345qqb	0007-11-14 10:14:48	bblier	ACME	GIC	organization/orgType/readList	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scusq2-a1dy-q7l7aw	0007-11-14 10:20:26	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scusq2-age7-aef3te	0007-11-14 10:20:26	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scusqd-jzml-gumheh	0007-11-14 10:20:37	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scusqd-keqb-q3zlmm	0007-11-14 10:20:37	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2dzo-ir4z-qnts10	0011-11-14 12:43:00	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"profileReference":"ATTT","partialRetentionRule":false,"depositStartDate":"2024-05-06","depositEndDate":"2024-05-06","maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2dzo-jaoo-57vel0	0011-11-14 12:43:00	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"profileReference":"ATTT","partialRetentionRule":false,"depositStartDate":"2024-05-06","depositEndDate":"2024-05-06","maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2et3-0zvo-3xq3x1	0011-11-14 13:00:39	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"profileReference":"NOTSER","partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2et3-1jum-8zzxpx	0011-11-14 13:00:39	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"profileReference":"NOTSER","partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2etb-8u0z-j3kmk2	0011-11-14 13:00:47	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2etb-9e18-2a4f8v	0011-11-14 13:00:47	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scurlr-l8n7-77eulq	0007-11-14 09:56:15	superadmin	\N	\N	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scurls-0a0b-w12p22	0007-11-14 09:56:16	superadmin	\N	\N	auth/serviceAccount/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scurlw-7bek-skyyyv	0007-11-14 09:56:20	superadmin	\N	\N	lifeCycle/eventFormat/readEventformatlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scus97-ayhd-p7jek0	0007-11-14 10:10:19	superadmin	\N	\N	auth/serviceAccount/readByRoute	\N	{"serviceUri":"audit/event/createChainjournal"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scusfa-57ay-92zabh	0007-11-14 10:13:58	bblier	ACME	GIC	auth/userAccount/readProfile	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scus97-b18t-u2bzp7	0007-11-14 10:10:19	superadmin	\N	\N	batchProcessing/scheduling/updateChangestatus	\N	{"schedulingId":"chainJournalAudit","status":"scheduled"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scus9c-3iiv-eqk2ws	0007-11-14 10:10:24	superadmin	\N	\N	batchProcessing/scheduling/readExecute_schedulingId_	{"schedulingId":"chainJournalAudit"}	\N	[{"message":"New journal identifier : %s","variables":"maarchRM_scus9b-lf16-y093tu","fullMessage":"New journal identifier : maarchRM_scus9b-lf16-y093tu"}]	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scus9d-l0fg-hcffwf	0007-11-14 10:10:25	superadmin	\N	\N	batchProcessing/scheduling/updateChangestatus	\N	{"schedulingId":"chainJournalLifeCycle","status":"scheduled"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scus9h-9dqj-rl06u2	0007-11-14 10:10:29	superadmin	\N	\N	lifeCycle/journal/createChainjournal	\N	\N	[{"message":"New journal identifier : %s","variables":"maarchRM_scus9h-6fjy-utkgw7","fullMessage":"New journal identifier : maarchRM_scus9h-6fjy-utkgw7"}]	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scus9r-62y9-xgdet6	0007-11-14 10:10:39	superadmin	\N	\N	auth/serviceAccount/readByRoute	\N	{"serviceUri":"recordsManagement/archiveCompliance/readPeriodic"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scus9r-6mzs-32owph	0007-11-14 10:10:39	superadmin	\N	\N	batchProcessing/scheduling/updateChangestatus	\N	{"schedulingId":"integrity","status":"paused"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scus9s-3k8f-32tkbk	0007-11-14 10:10:40	superadmin	\N	\N	auth/serviceAccount/readByRoute	\N	{"serviceUri":"recordsManagement/archiveCompliance/readPeriodic"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scus9s-3kyk-siq5nv	0007-11-14 10:10:40	superadmin	\N	\N	batchProcessing/scheduling/updateChangestatus	\N	{"schedulingId":"integrity","status":"scheduled"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scusd5-jjpz-aqw5sy	0007-11-14 10:12:41	superadmin	\N	\N	batchProcessing/scheduling/readSchedulings	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scusda-c2g8-z3nqm7	0007-11-14 10:12:46	__system__	\N	\N	auth/authentication/deleteUserlogin	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scusdj-i2vd-df71m8	0007-11-14 10:12:55	bblier	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"bblier"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scusdn-9856-f09sgd	0007-11-14 10:12:59	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scusdn-9lxa-behkv8	0007-11-14 10:12:59	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scusdp-9axd-96yvhp	0007-11-14 10:13:01	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scusdp-e1i7-bxnsi2	0007-11-14 10:13:01	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scusdu-dy8e-iqvg1m	0007-11-14 10:13:06	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scushg-1adl-50xt4t	0007-11-14 10:15:16	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scushg-1i3i-m24olo	0007-11-14 10:15:16	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scusod-3qe5-fqs4lw	0007-11-14 10:19:25	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scusod-40nw-0qyn73	0007-11-14 10:19:25	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scusqz-58ua-ukp9fi	0007-11-14 10:20:59	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scusqz-5k62-xdbh5i	0007-11-14 10:20:59	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scusrf-dfp1-c1c9h6	0007-11-14 10:21:15	bblier	ACME	GIC	recordsManagement/archive/create	\N	{"zipContainer":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scusrf-hedv-oscj47	0007-11-14 10:21:15	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scusrf-hub5-ll847y	0007-11-14 10:21:15	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scusrh-dmxe-u1o1js	0007-11-14 10:21:17	bblier	ACME	GIC	recordsManagement/archive/readMetadata_archiveId_	{"archiveId":"maarchRM_scusrf-atjd-t2un3c"}	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scut74-5z0m-njy920	0007-11-14 10:30:40	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scut74-6k2y-j1dv25	0007-11-14 10:30:40	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scut77-cnc0-ds7al8	0007-11-14 10:30:43	bblier	ACME	GIC	recordsManagement/archive/readMetadata_archiveId_	{"archiveId":"maarchRM_scusrf-atjd-t2un3c"}	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scut79-lelz-5q4cj0	0007-11-14 10:30:45	bblier	ACME	GIC	recordsManagement/archive/readMetadata_archiveId_	{"archiveId":"maarchRM_scusrf-atjd-t2un3c"}	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scut7d-hnr6-tqe4vj	0007-11-14 10:30:49	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scut7f-2eu5-97sleu	0007-11-14 10:30:51	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scut7f-31ni-q2i2ck	0007-11-14 10:30:51	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scut7i-1qh0-db99lp	0007-11-14 10:30:54	bblier	ACME	GIC	recordsManagement/archiveDescription/read_archiveId_	{"archiveId":"maarchRM_scpqjg-gpp6-yz273j"}	{"isCommunication":"1"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scut7i-8d6q-cfpe8w	0007-11-14 10:30:54	bblier	ACME	GIC	recordsManagement/archiveDescription/read_archiveId_	{"archiveId":"maarchRM_scpqjg-gpp6-yz273j"}	{"isCommunication":"1"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_scut7m-18so-oghw9x	0007-11-14 10:30:58	bblier	ACME	GIC	recordsManagement/archive/readConsultation_archiveId_Digitalresource_resId_	{"archiveId":"maarchRM_scpqjg-gpp6-yz273j","resId":"maarchRM_scpqjg-hb98-o34mp2"}	{"isCommunication":"1","embedded":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2dyt-fpuj-5r2ps9	0011-11-14 12:42:29	bblier	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"bblier"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2dyx-aq7a-934sno	0011-11-14 12:42:33	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2dyx-b5ks-etdqll	0011-11-14 12:42:33	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2dyz-k22c-lg84di	0011-11-14 12:42:35	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2dyz-kd4x-wsghtm	0011-11-14 12:42:35	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2dz1-fohg-45ud9w	0011-11-14 12:42:37	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2dz1-j7mw-rl9b67	0011-11-14 12:42:37	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2dz2-jfix-9tvzek	0011-11-14 12:42:38	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2dz2-k0hu-pfyfde	0011-11-14 12:42:38	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2nng-ans3-bwxsmj	0011-11-14 16:11:40	bblier	ACME	GIC	organization/organization/readTree	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2nno-dc7b-tkfi9r	0011-11-14 16:11:48	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-euzk-dl0c6t","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2nno-dqbr-hyi6tp	0011-11-14 16:11:48	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-euzk-dl0c6t","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2nnq-aev5-ofotu5	0011-11-14 16:11:50	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-f1e4-tltpik","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2nnq-axqf-kforxr	0011-11-14 16:11:50	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-f1e4-tltpik","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2nnr-473u-z442yj	0011-11-14 16:11:51	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scus9c-2btn-z28c07","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2nnr-4lkw-1jao9y	0011-11-14 16:11:51	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scus9c-2btn-z28c07","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2nns-157e-p8ru03	0011-11-14 16:11:52	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-f1e4-tltpik","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2nns-1mgc-7y5ye0	0011-11-14 16:11:52	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-f1e4-tltpik","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2nns-e26q-xrhhuj	0011-11-14 16:11:52	bblier	ACME	GIC	recordsManagement/archive/readMetadata_archiveId_	{"archiveId":"maarchRM_scpqjf-e70a-1l24dw"}	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2dzw-j9cr-ue47e5	0011-11-14 12:43:08	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"profileReference":"ATTT","partialRetentionRule":false,"depositStartDate":"2024-05-06","depositEndDate":"2024-05-06","maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2dzw-jsv0-d3a0tq	0011-11-14 12:43:08	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"profileReference":"ATTT","partialRetentionRule":false,"depositStartDate":"2024-05-06","depositEndDate":"2024-05-06","maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2esk-kkdx-ugvejp	0011-11-14 13:00:20	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"profileReference":"ATTT","partialRetentionRule":false,"depositStartDate":"2024-05-06","depositEndDate":"2024-05-06","maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2esk-l2o4-dgw3il	0011-11-14 13:00:20	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"profileReference":"ATTT","partialRetentionRule":false,"depositStartDate":"2024-05-06","depositEndDate":"2024-05-06","maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2esq-catz-we3nsm	0011-11-14 13:00:26	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"profileReference":"ATTT","partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2esq-ck6f-rvrank	0011-11-14 13:00:26	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"profileReference":"ATTT","partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2ess-8pxj-slfmoh	0011-11-14 13:00:28	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"profileReference":"ATTT","partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2ess-8yvc-lavd0z	0011-11-14 13:00:28	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"profileReference":"ATTT","partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2esv-75l2-xc6j37	0011-11-14 13:00:31	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2esv-7pqg-89jck3	0011-11-14 13:00:31	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2etp-1cok-wbh8ky	0011-11-14 13:01:01	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2etp-1v8w-xbjvsr	0011-11-14 13:01:01	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2nmy-e6fc-ibk1j8	0011-11-14 16:11:22	bblier	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"bblier"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2nn2-bnyu-szgiif	0011-11-14 16:11:26	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2nn2-c3ut-xvlzix	0011-11-14 16:11:26	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2nn3-0ywb-4tf4ud	0011-11-14 16:11:27	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2nn3-1m8q-vqhp8c	0011-11-14 16:11:27	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2nn5-bv0k-nersm0	0011-11-14 16:11:29	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2nn6-fihv-z5jwt4	0011-11-14 16:11:30	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2nn6-ftih-dbsih7	0011-11-14 16:11:30	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2nnb-5xxc-k1vrjz	0011-11-14 16:11:35	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2nnf-kvku-ekey6j	0011-11-14 16:11:39	bblier	ACME	GIC	organization/organization/readTree	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2nnf-l905-b8n151	0011-11-14 16:11:39	bblier	ACME	GIC	organization/orgType/readList	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2nng-ad9b-cmxrr2	0011-11-14 16:11:40	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2nng-amri-o1qkny	0011-11-14 16:11:40	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":true,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2nnw-ku7q-4qefxg	0011-11-14 16:11:56	bblier	ACME	GIC	recordsManagement/archive/readMetadata_archiveId_	{"archiveId":"maarchRM_scpqjf-e70a-1l24dw"}	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2nnz-aref-2z33m9	0011-11-14 16:11:59	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scus9c-2btn-z28c07","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2nnz-b6te-cmh57g	0011-11-14 16:11:59	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scus9c-2btn-z28c07","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2no0-8yyx-03onv1	0011-11-14 16:12:00	bblier	ACME	GIC	recordsManagement/archive/readMetadata_archiveId_	{"archiveId":"maarchRM_scus9b-lf16-y093tu"}	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2no1-d3no-joxjob	0011-11-14 16:12:01	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjg-gsp2-etc3jo","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2no1-dg4c-z8ttjk	0011-11-14 16:12:01	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjg-gsp2-etc3jo","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2no2-il1a-469am3	0011-11-14 16:12:02	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjg-h05w-44qu54","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2no2-j98a-53748z	0011-11-14 16:12:02	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjg-h05w-44qu54","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2no3-kjiz-or97td	0011-11-14 16:12:03	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjg-h7gc-jqom3g","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2no3-l11a-d456tp	0011-11-14 16:12:03	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjg-h7gc-jqom3g","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2no4-8wwx-m9t4bg	0011-11-14 16:12:04	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scus9h-85sf-ub6ax7","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2no4-9dfa-wpqavs	0011-11-14 16:12:04	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scus9h-85sf-ub6ax7","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2no5-8s85-ok77no	0011-11-14 16:12:05	bblier	ACME	GIC	recordsManagement/archive/readMetadata_archiveId_	{"archiveId":"maarchRM_scus9h-6fjy-utkgw7"}	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2nod-gk2z-dmc1p7	0011-11-14 16:12:13	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2nod-h05f-x1xtkk	0011-11-14 16:12:13	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2nol-evdm-tdjvpx	0011-11-14 16:12:21	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2nol-fdbt-1zoler	0011-11-14 16:12:21	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2non-i25k-u4orlr	0011-11-14 16:12:23	__system__	\N	\N	auth/authentication/deleteUserlogin	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2o87-glid-dpkrpx	0011-11-14 16:24:07	bblier	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"bblier"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2o8d-eari-ajp3to	0011-11-14 16:24:13	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2o8d-j0ym-x7px4j	0011-11-14 16:24:13	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2ob4-imtq-ghcoef	0011-11-14 16:25:52	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2ob4-izmo-j96ojh	0011-11-14 16:25:52	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2ob6-65f3-xf56m5	0011-11-14 16:25:54	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2ob6-6xzt-omn63v	0011-11-14 16:25:54	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2ob7-h5s0-smcc1z	0011-11-14 16:25:55	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2ob7-hmcc-6t8twm	0011-11-14 16:25:55	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-em33-qkfr8k","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2obb-1h4t-ezyqd5	0011-11-14 16:25:59	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-f1e4-tltpik","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2obb-1wko-wm4wgb	0011-11-14 16:25:59	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","filePlanPosition":"maarchRM_scpqjf-f1e4-tltpik","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2oeo-21ng-5clzfo	0011-11-14 16:28:00	__system__	\N	\N	auth/authentication/deleteUserlogin	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2ov6-bmwb-uu5wli	0011-11-14 16:37:54	bblier	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"bblier"}	\N	t	{"remoteIp":"10.83.1.74"}	maarchRM
maarchRM_sd2ovl-7osh-hr28md	0011-11-14 16:38:09	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.74"}	maarchRM
maarchRM_sd2ovl-82vd-xwjsgz	0011-11-14 16:38:09	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.74"}	maarchRM
maarchRM_sd2ovq-16fm-rs6snt	0011-11-14 16:38:14	bblier	ACME	GIC	recordsManagement/archive/readMetadata_archiveId_	{"archiveId":"maarchRM_scusrf-atjd-t2un3c"}	\N	\N	t	{"remoteIp":"10.83.1.74"}	maarchRM
maarchRM_sd2qe8-4btw-jgkitw	0011-11-14 17:10:56	bblier	ACME	GIC	organization/organization/read_orgId_	{"orgId":"DAF"}	\N	\N	t	{"remoteIp":"10.83.1.74"}	maarchRM
maarchRM_sd40q2-iw7g-0adrzi	0012-11-13 09:51:38	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd40q3-24cz-tcyd07	0012-11-13 09:51:39	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd42nb-lb3x-oajvzb	0012-11-13 10:33:11	bblier	ACME	GIC	auth/userAccount/readProfile	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd43ok-hq87-0acngi	0012-11-13 10:55:32	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd440j-j7r8-2hbqjo	0012-11-13 11:02:43	bblier	ACME	GIC	recordsManagement/archives/read	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd440j-jq7n-7236vp	0012-11-13 11:02:43	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2ow0-4lfv-0xmq3a	0011-11-14 16:38:24	bblier	ACME	GIC	recordsManagement/archive/readExport_archiveId_	{"archiveId":"maarchRM_scusrf-atjd-t2un3c"}	\N	\N	t	{"remoteIp":"10.83.1.74"}	maarchRM
maarchRM_sd2ox7-7w52-wqz0sn	0011-11-14 16:39:07	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.74"}	maarchRM
maarchRM_sd2oxd-j45d-ufqwy6	0011-11-14 16:39:13	bblier	ACME	GIC	auth/userAccount/read_userAccountId_	{"userAccountId":"bbardot"}	\N	\N	t	{"remoteIp":"10.83.1.74"}	maarchRM
maarchRM_sd2oxe-1awp-whr4jo	0011-11-14 16:39:14	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.74"}	maarchRM
maarchRM_sd2qed-gd0b-61lawg	0011-11-14 17:11:01	bblier	ACME	GIC	organization/organization/read_orgId_	{"orgId":"DCIAL"}	\N	\N	t	{"remoteIp":"10.83.1.74"}	maarchRM
maarchRM_sd2qeg-9w2b-p2g71h	0011-11-14 17:11:04	bblier	ACME	GIC	organization/organization/read_orgId_	{"orgId":"RH"}	\N	\N	t	{"remoteIp":"10.83.1.74"}	maarchRM
maarchRM_sd3zve-g0u6-nyj8c3	0012-11-13 09:33:14	bblier	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"bblier"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd41qn-ex1h-e3u7ml	0012-11-13 10:13:35	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd41qr-em2p-snuyoi	0012-11-13 10:13:39	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd41qs-0nnr-48jb22	0012-11-13 10:13:40	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd42j5-7fd4-l8t5qp	0012-11-13 10:30:41	bblier	ACME	GIC	auth/userAccount/readProfile	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd42j7-9rsp-va6177	0012-11-13 10:30:43	bblier	ACME	GIC	auth/userAccount/readProfile	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd42j9-8v2g-w8q9av	0012-11-13 10:30:45	bblier	ACME	GIC	auth/userAccount/readProfile	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd42n3-7s7c-n7s4k4	0012-11-13 10:33:03	bblier	ACME	GIC	auth/userAccount/readProfile	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd43l0-dq2k-cararu	0012-11-13 10:53:24	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd43l0-i4sl-t148hr	0012-11-13 10:53:24	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd43qc-11l6-kr5vwe	0012-11-13 10:56:36	bblier	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"bblier"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd43qf-h9zm-t4z616	0012-11-13 10:56:39	bblier	ACME	GIC	recordsManagement/archives/read	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd43qf-hncd-bp29t1	0012-11-13 10:56:39	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd440g-1u3d-z8rpxo	0012-11-13 11:02:40	bblier	ACME	GIC	recordsManagement/archives/read	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd440g-2a8v-cp5jiq	0012-11-13 11:02:40	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd449g-ct1x-bxvhk5	0012-11-13 11:08:04	bblier	ACME	GIC	recordsManagement/archives/read	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd449g-d60g-0zd1x5	0012-11-13 11:08:04	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2oxy-gxd4-8ry1i2	0011-11-14 16:39:34	bblier	ACME	GIC	recordsManagement/archives/readList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.74"}	maarchRM
maarchRM_sd2oxy-hdiz-f6xb5b	0011-11-14 16:39:34	bblier	ACME	GIC	recordsManagement/archives/readCountList	\N	{"originatorOrgRegNumber":"GIC","archiveUnit":false}	\N	t	{"remoteIp":"10.83.1.74"}	maarchRM
maarchRM_sd2qcm-fybv-x0ro33	0011-11-14 17:09:58	bblier	ACME	GIC	auth/role/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.74"}	maarchRM
maarchRM_sd2qcr-lchu-xq4il5	0011-11-14 17:10:03	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.74"}	maarchRM
maarchRM_sd42kj-gl5m-nvlwfm	0012-11-13 10:31:31	bblier	ACME	GIC	auth/userAccount/readProfile	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd42t6-fer9-16qi6x	0012-11-13 10:36:42	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd43sl-29dh-hbpohs	0012-11-13 10:57:57	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd43sl-69fh-szk588	0012-11-13 10:57:57	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd43sm-6axs-d71s8j	0012-11-13 10:57:58	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd43sm-6vm4-m47wmo	0012-11-13 10:57:58	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd43so-cqdq-djaobv	0012-11-13 10:58:00	bblier	ACME	GIC	recordsManagement/archives/read	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd43so-d89o-cm3xz6	0012-11-13 10:58:00	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd449n-8ydd-mlvhfs	0012-11-13 11:08:11	bblier	ACME	GIC	recordsManagement/archives/read	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd449n-9iro-fghi8o	0012-11-13 11:08:11	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2qde-iqir-5nim8m	0011-11-14 17:10:26	bblier	ACME	GIC	organization/organization/readTree	\N	\N	\N	t	{"remoteIp":"10.83.1.74"}	maarchRM
maarchRM_sd2qde-j49v-8m60ia	0011-11-14 17:10:26	bblier	ACME	GIC	organization/orgType/readList	\N	\N	\N	t	{"remoteIp":"10.83.1.74"}	maarchRM
maarchRM_sd2qdf-4vio-6mkf37	0011-11-14 17:10:27	bblier	ACME	GIC	auth/userAccount/readUserlist	\N	\N	\N	t	{"remoteIp":"10.83.1.74"}	maarchRM
maarchRM_sd2qdf-5uat-rfitkh	0011-11-14 17:10:27	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":true,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.74"}	maarchRM
maarchRM_sd2qdf-5uuy-fu50qd	0011-11-14 17:10:27	bblier	ACME	GIC	organization/organization/readTree	\N	\N	\N	t	{"remoteIp":"10.83.1.74"}	maarchRM
maarchRM_sd3xej-83yu-5x8fc2	0012-11-13 08:39:55	bblier	\N	\N	auth/authentication/createUserlogin	\N	{"userName":"bblier"}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd3xen-ik9b-ee1ziu	0012-11-13 08:39:59	bblier	ACME	GIC	medona/message/read_messageId_	{"messageId":"Search"}	\N	Object of class medona/message identified by Search was not found	f	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd408n-7cxu-d8zrmh	0012-11-13 09:41:11	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":true,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd41t8-f4be-hi58ke	0012-11-13 10:15:08	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd41tb-b0f4-sceb09	0012-11-13 10:15:11	bblier	ACME	GIC	recordsManagement/archivalProfile/readIndex	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd41tb-ee0h-q25d8y	0012-11-13 10:15:11	bblier	ACME	GIC	organization/organization/readTodisplay	\N	{"ownerOrg":false,"orgUnit":true}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd41tc-e19v-e2yown	0012-11-13 10:15:12	bblier	ACME	GIC	recordsManagement/archives/read	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd41tc-eh5m-2eyhtq	0012-11-13 10:15:12	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	{"partialRetentionRule":false,"maxResults":500}	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd42ls-hk23-ly8ovn	0012-11-13 10:32:16	bblier	ACME	GIC	auth/userAccount/readProfile	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd42lu-50y3-w22vn7	0012-11-13 10:32:18	bblier	ACME	GIC	auth/userAccount/readProfile	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd42lu-k1rw-nmtzet	0012-11-13 10:32:18	bblier	ACME	GIC	auth/userAccount/readProfile	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd42lv-drth-3o1mmq	0012-11-13 10:32:19	bblier	ACME	GIC	auth/userAccount/readProfile	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd42lx-i2rc-23gyaf	0012-11-13 10:32:21	bblier	ACME	GIC	auth/userAccount/readProfile	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd42m3-61hw-ur0t6s	0012-11-13 10:32:27	bblier	ACME	GIC	auth/userAccount/readProfile	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd43t0-c9i9-cyza6v	0012-11-13 10:58:12	bblier	ACME	GIC	recordsManagement/archives/read	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd43t0-cj2w-xy08m2	0012-11-13 10:58:12	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd2qdr-kyax-e16nrv	0011-11-14 17:10:39	bblier	ACME	GIC	organization/organization/read_orgId_	{"orgId":"RH"}	\N	\N	t	{"remoteIp":"10.83.1.74"}	maarchRM
maarchRM_sd2qdv-gqd7-1g69tt	0011-11-14 17:10:43	bblier	ACME	GIC	organization/organization/read_orgId_	{"orgId":"DSI"}	\N	\N	t	{"remoteIp":"10.83.1.74"}	maarchRM
maarchRM_sd2qdy-761s-pfdfj6	0011-11-14 17:10:46	bblier	ACME	GIC	organization/organization/read_orgId_	{"orgId":"GIC"}	\N	\N	t	{"remoteIp":"10.83.1.74"}	maarchRM
maarchRM_sd43pv-1s1w-4w2uzv	0012-11-13 10:56:19	bblier	ACME	GIC	recordsManagement/archives/read	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd43pv-24sg-i04fmz	0012-11-13 10:56:19	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd43q5-7jay-ymisxa	0012-11-13 10:56:29	__system__	\N	\N	auth/authentication/deleteUserlogin	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd440s-cjj9-g0fcpu	0012-11-13 11:02:52	bblier	ACME	GIC	recordsManagement/archives/read	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd440s-d5zz-d4av6g	0012-11-13 11:02:52	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd449x-fp5v-0701x0	0012-11-13 11:08:21	bblier	ACME	GIC	recordsManagement/archives/read	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
maarchRM_sd449x-g5oh-kl0jn3	0012-11-13 11:08:21	bblier	ACME	GIC	recordsManagement/archives/readCount	\N	\N	\N	t	{"remoteIp":"10.83.1.126"}	maarchRM
\.


--
-- Data for Name: account; Type: TABLE DATA; Schema: auth; Owner: maarch
--

COPY auth.account ("accountId", "accountName", "displayName", "accountType", "emailAddress", enabled, password, "passwordChangeRequired", "passwordLastChange", locked, "lockDate", "badPasswordCount", "lastLogin", "lastIp", "replacingUserAccountId", "firstName", "lastName", title, salt, "tokenDate", authentication, preferences, "ownerOrgId", "isAdmin") FROM stdin;
aadams	aadams	Amy ADAMS	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	2019-03-15 10:20:33.964708	127.0.0.1	\N	Amy	ADAMS	Mme.	\N	\N	\N	\N	ACME	f
aalambic	aalambic	Alain ALAMBIC	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	2019-09-23 14:00:29.059065	127.0.0.1	\N	Alain	ALAMBIC	M.	\N	\N	{"csrf": {"2019-09-23T14:05:44,406456Z": "a45c4a7784bd8ed0d7c25f74ce3029e24693f112e03fd606f38f508a61f9554b"}}	\N	ACME	f
aastier	aastier	Alexandre ASTIER	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	2019-03-15 10:19:10.46925	127.0.0.1	\N	Alexandre	ASTIER	M.	\N	\N	\N	\N	ACME	f
bbain	bbain	Barbara BAIN	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	\N	\N	\N	Barbara	BAIN	Mme.	\N	\N	\N	\N	ACME	f
bbardot	bbardot	Brigitte BARDOT	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	t	2019-03-14 15:55:48.901327	f	\N	0	\N	\N	\N	Brigitte	BARDOT	Mme	\N	\N	\N	\N	ACME	f
bboule	bboule	Bruno BOULE	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	\N	\N	\N	Bruno	BOULE	M.	\N	\N	\N	\N	ACME	f
ccamus	ccamus	Cyril CAMUS	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	\N	\N	\N	Cyril	CAMUS	M.	\N	\N	\N	\N	ACME	f
cchaplin	cchaplin	Charlie CHAPLIN	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	\N	\N	\N	Charlie	CHAPLIN	M.	\N	\N	\N	\N	ACME	f
ccharles	ccharles	Charlotte CHARLES	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	\N	\N	\N	Charlotte	CHARLES	Mme.	\N	\N	\N	\N	ACME	f
ccordy	ccordy	Chloé CORDY	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	2019-09-18 16:09:53.920859	127.0.0.1	\N	Chloé	CORDY	Mme.	\N	\N	\N	\N	ACME	f
ccox	ccox	Courtney COX	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	\N	\N	\N	Courtney	COX	Mme.	\N	\N	\N	\N	ACME	f
ddaull	ddaull	Denis DAULL	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	\N	\N	\N	Denis	DAULL	M.	\N	\N	\N	\N	ACME	f
ddenis	ddenis	Didier DENIS	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	\N	\N	\N	Didier	DENIS	M.	\N	\N	\N	\N	ACME	f
ddur	ddur	Dominique DUR	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	\N	\N	\N	Dominique	DUR	M.	\N	\N	\N	\N	ACME	f
eerina	eerina	Edith ERINA	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	\N	\N	\N	Edith	ERINA	Mme.	\N	\N	\N	\N	ACME	f
ggrand	ggrand	George GRAND	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	2019-09-25 12:07:44.170506	127.0.0.1	\N	George	GRAND	M.	\N	\N	{"csrf": {"2019-09-25T12:07:45,573625Z": "ba8478523dd582f81bd42c3052b7f5ce32db1245e3b2b9cf2b0226dd4baa428c"}}	\N	ACME	f
hhier	hhier	Hubert HIER	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	\N	\N	\N	Hubert	HIER	M.	\N	\N	\N	\N	ACME	f
jjane	jjane	Jenny JANE	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	\N	\N	\N	Jenny	JANE	Mme.	\N	\N	\N	\N	ACME	f
jjonasz	jjonasz	Jean JONASZ	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	\N	\N	\N	Jean	JONASZ	M.	\N	\N	\N	\N	ACME	f
kkaar	kkaar	Katy KAAR	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	\N	\N	\N	Katy	KAAR	Mme.	\N	\N	\N	\N	ACME	f
kkrach	kkrach	Kevin KRACH	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	2019-03-15 08:30:03.559857	127.0.0.1	\N	Kevin	KRACH	M.	\N	\N	\N	\N	ACME	f
mmanfred	mmanfred	Martin MANFRED	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	\N	\N	\N	Martin	MANFRED	M.	\N	\N	\N	\N	ACME	f
nnataly	nnataly	Nancy NATALY	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	2019-03-15 11:07:45.462923	127.0.0.1	\N	Nancy	NATALY	Mme.	\N	\N	\N	\N	ACME	t
ppacioli	ppacioli	Paolo PACIOLI	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	\N	\N	\N	Paolo	PACIOLI	M.	\N	\N	\N	\N	ACME	f
ppetit	ppetit	Patricia PETIT	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	\N	\N	\N	Patricia	PETIT	Mme.	\N	\N	\N	\N	ACME	f
ppreboist	ppreboist	Paul PREBOIST	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	\N	\N	\N	Paul	PREBOIST	M.	\N	\N	\N	\N	ACME	f
ppruvost	ppruvost	Pierre PRUVOST	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	\N	\N	\N	Pierre	PRUVOST	M.	\N	\N	\N	\N	ACME	f
rrenaud	rrenaud	Robert RENAUD	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	\N	\N	\N	Robert	RENAUD	M.	\N	\N	\N	\N	ACME	f
rreynolds	rreynolds	Ryan REYNOLDS	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	\N	\N	\N	Ryan	REYNOLDS	M.	\N	\N	\N	\N	ACME	f
ssaporta	ssaporta	Sabrina SAPORTA	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	\N	\N	\N	Sabrina	SAPORTA	Mme.	\N	\N	\N	\N	ACME	f
ssissoko	ssissoko	Sylvain SISSOKO	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	\N	\N	\N	Sylvain	SISSOKO	M.	\N	\N	\N	\N	ACME	f
sstallone	sstallone	Sylvester STALLONE	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	\N	\N	\N	Sylvester	STALLONE	M.	\N	\N	\N	\N	ACME	f
sstar	sstar	Suzanne STAR	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	\N	\N	\N	Suzanne	STAR	Mme.	\N	\N	\N	\N	ACME	f
System	Systeme	Systeme	service	support@maarch.fr	t	RJpzB36bmR+iuz/aHN9Zl9PDn8tZEs4mzsz9OXNeNIrej2+v3UMzAsF3PSzDUlZ73kPvgqbQmZvza0eZO062uQu57Rdah9z3mdbTh6NBiiR8FQTnW6eVgQ==	t	\N	f	\N	0	\N	\N	\N	\N	\N	\N	63ce15235abe97db0182e6857c1da763	2019-03-19 07:54:33.464846	\N	\N	ACME	f
SystemDepositor	Systeme versant	Systeme versant	service	support@maarch.fr	t	RJpzB36bmR+iuz/aHN9Zl9PDn8tZEs4mzsz9ORUXZpbMim/ilUMpE9FzYG3TW0Eii0Oy1PaFyJ35aBqcMU3gvAq4v0ZY0Z/r0cPVzbAaymd1UEnsAe3MjqGLt7BxvxiHJQ==	t	\N	f	\N	0	\N	\N	\N	\N	\N	\N	87eda47a7218326af0e3f4eaad7c2c22	2019-03-19 07:56:55.287696	\N	\N	ACME	f
aackermann	aackermann	Amanda ACKERMANN	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	\N	\N	\N	Amanda	ACKERMANN	Mme.	\N	\N	\N	\N	ACME	f
ttong	ttong	Tony TONG	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	\N	\N	\N	Tony	TONG	M.	\N	\N	\N	\N	ACME	f
sstone	sstone	Sharon STONE	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	2019-03-15 08:30:27.732025	127.0.0.1	\N	Sharon	STONE	Mme.	\N	\N	\N	\N	ACME	f
ttule	ttule	Thierry TULE	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	\N	\N	\N	Thierry	TULE	M.	\N	\N	\N	\N	ACME	f
vvictoire	vvictoire	Victor VICTOIRE	user	support@maarch.fr	t	fffd2272074225feae229658e248b81529639e6199051abdeb49b6ed60adf13d	f	\N	f	\N	0	\N	\N	\N	Victor	VICTOIRE	M.	\N	\N	\N	\N	ACME	f
superadmin	superadmin	super admin	user	support@maarch.fr	t	$2y$10$csesVEanubmyVzewS5T86u7seKYDE0hFxv1WTkc1xi9u/JpAclNVi	f	\N	f	\N	0	0014-11-07 09:56:08	10.83.1.126	\N	SUPERAdmin	Super	M.	\N	\N	{"csrf": {"2024-05-02T10:10:40,208705Z": "2098b3868ed0472037e04fc0c720d4d1d3b97ef3e5c07c9274ddb859ea5500dd"}, "sessionId": null}	\N	\N	t
bblier	bblier	Bernard BLIER	user	support@maarch.fr	t	$2y$10$9nSpe1A9fAaJfApT7pj40eRBR61WLWzWnXHpyz1Wy3Km3159R8D12	f	\N	f	\N	0	0012-11-13 10:56:35	10.83.1.126	\N	Bernard	BLIER	M.	\N	\N	{"csrf": {"2024-05-07T10:53:24,747385Z": "66b6fc3f3f7ebe3861622a3d20977d89cee3e962d5f47e81f13252ef079fae55"}, "sessionId": "sd43qc-clsg-ooz320"}	\N	ACME	f
\.


--
-- Data for Name: privilege; Type: TABLE DATA; Schema: auth; Owner: maarch
--

COPY auth.privilege ("roleId", "userStory") FROM stdin;
ADMIN_FONCTIONNEL	adminFunc/adminAuthorization
ADMIN_FONCTIONNEL	adminFunc/adminOrganization
ADMIN_FONCTIONNEL	adminFunc/adminOrgContact
ADMIN_FONCTIONNEL	adminFunc/adminOrgUser
ADMIN_FONCTIONNEL	adminFunc/adminServiceaccount
ADMIN_FONCTIONNEL	adminFunc/adminUseraccount
ADMIN_FONCTIONNEL	adminFunc/batchScheduling
ADMIN_FONCTIONNEL	export/*
ADMIN_FONCTIONNEL	import/*
ADMIN_GENERAL	adminFunc/adminAuthorization
ADMIN_GENERAL	adminFunc/adminOrganization
ADMIN_GENERAL	adminFunc/adminServiceaccount
ADMIN_GENERAL	adminFunc/adminUseraccount
ADMIN_GENERAL	adminFunc/batchScheduling
ADMIN_GENERAL	adminTech/*
ADMIN_GENERAL	journal/audit
CORRESPONDANT_ARCHIVES	adminArchive/*
CORRESPONDANT_ARCHIVES	adminFunc/*
CORRESPONDANT_ARCHIVES	adminTech/adminFormat
CORRESPONDANT_ARCHIVES	archiveDeposit/*
CORRESPONDANT_ARCHIVES	archiveManagement/*
CORRESPONDANT_ARCHIVES	destruction/destructionRequest
CORRESPONDANT_ARCHIVES	journal/certificate
CORRESPONDANT_ARCHIVES	journal/lifeCycleJournal
CORRESPONDANT_ARCHIVES	journal/searchLogArchive
PRODUCTEUR	archiveDeposit/deposit
PRODUCTEUR	archiveManagement/filePlan
PRODUCTEUR	archiveManagement/modifyDescription
RESPONSABLE_ACTIVITE	archiveDeposit/deposit
RESPONSABLE_ACTIVITE	archiveManagement/checkIntegrity
RESPONSABLE_ACTIVITE	archiveManagement/filePlan
RESPONSABLE_ACTIVITE	archiveManagement/modifyDescription
RESPONSABLE_ACTIVITE	archiveManagement/modify
RESPONSABLE_ACTIVITE	archiveManagement/retrieve
RESPONSABLE_ACTIVITE	destruction/destructionRequest
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: auth; Owner: maarch
--

COPY auth.role ("roleId", "roleName", description, "securityLevel", enabled) FROM stdin;
ADMIN_FONCTIONNEL	Administrateur fonctionnel	Groupe des administrateurs fonctionnels du système	func_admin	t
ADMIN_GENERAL	Administrateur général	Groupe des administrateurs techniques du système	gen_admin	t
CORRESPONDANT_ARCHIVES	Correspondant d'archives	Groupe des archivistes, records managers et référents d'archives	user	t
PRODUCTEUR	Producteur	Groupe des producteurs, versants	user	t
RESPONSABLE_ACTIVITE	Responsable d'activité	Groupe des responsables de service et des activités	user	t
UTILISATEUR	Utilisateur	Groupe des utilisateurs, consultation et navigation	user	t
\.


--
-- Data for Name: roleMember; Type: TABLE DATA; Schema: auth; Owner: maarch
--

COPY auth."roleMember" ("roleId", "userAccountId") FROM stdin;
ADMIN_FONCTIONNEL	nnataly
ADMIN_GENERAL	superadmin
CORRESPONDANT_ARCHIVES	bblier
CORRESPONDANT_ARCHIVES	ccharles
CORRESPONDANT_ARCHIVES	ddenis
PRODUCTEUR	aalambic
PRODUCTEUR	bbain
PRODUCTEUR	bbardot
PRODUCTEUR	ccamus
PRODUCTEUR	ccordy
PRODUCTEUR	ddaull
PRODUCTEUR	ddur
PRODUCTEUR	ggrand
PRODUCTEUR	hhier
PRODUCTEUR	jjane
PRODUCTEUR	jjonasz
PRODUCTEUR	kkaar
PRODUCTEUR	kkrach
PRODUCTEUR	mmanfred
PRODUCTEUR	ppacioli
PRODUCTEUR	ppetit
PRODUCTEUR	ppreboist
PRODUCTEUR	rrenaud
PRODUCTEUR	rreynolds
PRODUCTEUR	ssaporta
PRODUCTEUR	ssissoko
PRODUCTEUR	sstar
PRODUCTEUR	ttong
PRODUCTEUR	ttule
PRODUCTEUR	vvictoire
RESPONSABLE_ACTIVITE	aackermann
RESPONSABLE_ACTIVITE	aadams
RESPONSABLE_ACTIVITE	aastier
RESPONSABLE_ACTIVITE	ccox
RESPONSABLE_ACTIVITE	eerina
RESPONSABLE_ACTIVITE	nnataly
RESPONSABLE_ACTIVITE	sstone
UTILISATEUR	bboule
UTILISATEUR	cchaplin
UTILISATEUR	ccordy
UTILISATEUR	ppruvost
UTILISATEUR	sstallone
\.


--
-- Data for Name: servicePrivilege; Type: TABLE DATA; Schema: auth; Owner: maarch
--

COPY auth."servicePrivilege" ("accountId", "serviceURI") FROM stdin;
System	audit/event/createChainjournal
System	batchProcessing/scheduling/updateProcess
System	lifeCycle/journal/createChainjournal
System	recordsmanagement/archivecompliance/readperiodic
System	recordsManagement/archives/deleteDisposablearchives
System	recordsManagement/archives/updateArchivesretentionrule
System	recordsManagement/archives/updateIndexfulltext
SystemDepositor	recordsManagement/archive/create
SystemDepositor	recordsManagement/archive/createArchiveBatch
\.


--
-- Data for Name: logScheduling; Type: TABLE DATA; Schema: batchProcessing; Owner: maarch
--

COPY "batchProcessing"."logScheduling" ("logId", "schedulingId", "executedBy", "launchedBy", "logDate", status, info) FROM stdin;
maarchRM_5k7cwmpb4-0000-7v4gda	chainJournalAudit	System	superadmin	2019-09-19 09:24:29.660848	t	[{"message":"Timestamp file generated","fullMessage":"Timestamp file generated"},{"message":"New journal identifier : %s","variables":"maarchRM_py2ngt-16cc-ylua9s","fullMessage":"New journal identifier : maarchRM_py2ngt-16cc-ylua9s"}]
maarchRM_scpqjf-gstf-xhoff0	chainJournalAudit	System	superadmin	0034-10-15 16:45:15	t	[{"message":"New journal identifier : %s","variables":"maarchRM_scpqjf-e70a-1l24dw","fullMessage":"New journal identifier : maarchRM_scpqjf-e70a-1l24dw"}]
maarchRM_scpqjg-i7so-klh8fw	chainJournalLifeCycle	System	superadmin	0034-10-15 16:45:16	t	[{"message":"New journal identifier : %s","variables":"maarchRM_scpqjg-gpp6-yz273j","fullMessage":"New journal identifier : maarchRM_scpqjg-gpp6-yz273j"}]
maarchRM_scpqjj-2npc-7zsshx	integrity	System	superadmin	0034-10-15 16:45:19	t	[{"message":"%s archive(s) to check","variables":1,"fullMessage":"1 archive(s) to check"},{"message":"%s archive(s) in sample","variables":1,"fullMessage":"1 archive(s) in sample"},{"message":"%s archive(s) checked","variables":1,"fullMessage":"1 archive(s) checked"}]
maarchRM_scpqjk-4z19-0pc4gf	processdestruction	System	superadmin	0034-10-15 16:45:20	t	[{"message":"%s archives checked","variables":0,"fullMessage":"0 archives checked"},{"message":"%s archives are valid","variables":0,"fullMessage":"0 archives are valid"},{"message":"%s archives are not valid","variables":0,"fullMessage":"0 archives are not valid"}]
maarchRM_scpqjl-5oaq-w2x4gi	purge	System	superadmin	0034-10-15 16:45:21	t	\N
maarchRM_scus9c-3bn2-erz2hf	chainJournalAudit	System	superadmin	0007-11-14 10:10:24	t	[{"message":"New journal identifier : %s","variables":"maarchRM_scus9b-lf16-y093tu","fullMessage":"New journal identifier : maarchRM_scus9b-lf16-y093tu"}]
maarchRM_scus9h-96ne-48udww	chainJournalLifeCycle	System	superadmin	0007-11-14 10:10:29	t	[{"message":"New journal identifier : %s","variables":"maarchRM_scus9h-6fjy-utkgw7","fullMessage":"New journal identifier : maarchRM_scus9h-6fjy-utkgw7"}]
\.


--
-- Data for Name: notification; Type: TABLE DATA; Schema: batchProcessing; Owner: maarch
--

COPY "batchProcessing".notification ("notificationId", receivers, message, title, "createdDate", "createdBy", status, "sendDate", "sendBy") FROM stdin;
\.


--
-- Data for Name: scheduling; Type: TABLE DATA; Schema: batchProcessing; Owner: maarch
--

COPY "batchProcessing".scheduling ("schedulingId", name, "taskId", frequency, parameters, "executedBy", "lastExecution", "nextExecution", status) FROM stdin;
processdestruction	Traiter les destructions	04	00;04;;;;;;;	\N	System	0034-10-15 16:45:20	0035-10-15 04:00:00	scheduled
purge	Purge	05	00;08;;;;;;;	\N	System	0034-10-15 16:45:21	0035-10-15 08:00:00	scheduled
chainJournalAudit	Chaînage audit	01	00;20;;;;;;;	\N	System	0007-11-14 10:10:24	0008-11-13 20:00:00	scheduled
chainJournalLifeCycle	Chaînage du journal du cycle de vie	02	00;20;;;;;;;	\N	System	0007-11-14 10:10:29	0008-11-13 20:00:00	scheduled
integrity	Intégrité	03	00;01;;;;4;H;00;20	\N	System	0003-11-15 16:45:19	\N	scheduled
\.


--
-- Data for Name: address; Type: TABLE DATA; Schema: contact; Owner: maarch
--

COPY contact.address ("addressId", "contactId", purpose, room, floor, building, number, street, "postBox", block, "citySubDivision", "postCode", city, country) FROM stdin;
\.


--
-- Data for Name: communication; Type: TABLE DATA; Schema: contact; Owner: maarch
--

COPY contact.communication ("communicationId", "contactId", purpose, "comMeanCode", value, info) FROM stdin;
\.


--
-- Data for Name: communicationMean; Type: TABLE DATA; Schema: contact; Owner: maarch
--

COPY contact."communicationMean" (code, name, enabled) FROM stdin;
AH	World Wide Web	f
AL	Téléphone mobile	t
AO	URL	t
AU	FTP	t
EM	E-mail	t
FX	Fax	t
TE	Téléphone	t
\.


--
-- Data for Name: contact; Type: TABLE DATA; Schema: contact; Owner: maarch
--

COPY contact.contact ("contactId", "contactType", "orgName", "firstName", "lastName", title, function, service, "displayName") FROM stdin;
\.


--
-- Data for Name: address; Type: TABLE DATA; Schema: digitalResource; Owner: maarch
--

COPY "digitalResource".address ("resId", "repositoryId", path, "lastIntegrityCheck", "integrityCheckResult", packed, created) FROM stdin;
maarchRM_scpqjf-f6w1-jbwi1r	archives_1	//journal/application/_2024_/_04_/maarchRM_scpqjf-e70a-1l24dw/maarchRM_scpqjf-f6w1-jbwi1r	0034-10-15 16:45:19	t	\N	0015-11-03 16:45:15
maarchRM_scpqjf-f6w1-jbwi1r	archives_2	//journal/application/_2024_/_04_/maarchRM_scpqjf-e70a-1l24dw/maarchRM_scpqjf-f6w1-jbwi1r	0034-10-15 16:45:19	t	\N	0015-11-03 16:45:15
maarchRM_scpqjg-hb98-o34mp2	archives_2	//journal/lifeCycle/_2024_/_04_/maarchRM_scpqjg-gpp6-yz273j/maarchRM_scpqjg-hb98-o34mp2	0007-11-14 09:55:50	t	\N	0015-11-03 16:45:16
maarchRM_scus9c-2f3e-5wlax0	archives_1	//journal/application/_2024_/_05_/maarchRM_scus9b-lf16-y093tu/maarchRM_scus9c-2f3e-5wlax0	\N	\N	\N	0007-11-14 10:10:24
maarchRM_scus9c-2f3e-5wlax0	archives_2	//journal/application/_2024_/_05_/maarchRM_scus9b-lf16-y093tu/maarchRM_scus9c-2f3e-5wlax0	\N	\N	\N	0007-11-14 10:10:24
maarchRM_scus9h-8a2w-0mq7ax	archives_1	//journal/lifeCycle/_2024_/_05_/maarchRM_scus9h-6fjy-utkgw7/maarchRM_scus9h-8a2w-0mq7ax	\N	\N	\N	0007-11-14 10:10:29
maarchRM_scus9h-8a2w-0mq7ax	archives_2	//journal/lifeCycle/_2024_/_05_/maarchRM_scus9h-6fjy-utkgw7/maarchRM_scus9h-8a2w-0mq7ax	\N	\N	\N	0007-11-14 10:10:29
maarchRM_scusrf-bw5n-ubcc8a	archives_2	//maarchRM/ACME/GIC/NOTSER/2024/05/02/maarchRM_scusrf-atjd-t2un3c/maarchRM_scusrf-bw5n-ubcc8a	\N	\N	\N	0007-11-14 10:21:15
maarchRM_scpqjg-hb98-o34mp2	archives_1	//journal/lifeCycle/_2024_/_04_/maarchRM_scpqjg-gpp6-yz273j/maarchRM_scpqjg-hb98-o34mp2	0007-11-14 10:30:58	t	\N	0015-11-03 16:45:16
maarchRM_scusrf-bw5n-ubcc8a	archives_1	//maarchRM/ACME/GIC/NOTSER/2024/05/02/maarchRM_scusrf-atjd-t2un3c/maarchRM_scusrf-bw5n-ubcc8a	0011-11-14 16:38:24	t	\N	0014-11-07 10:21:15
\.


--
-- Data for Name: cluster; Type: TABLE DATA; Schema: digitalResource; Owner: maarch
--

COPY "digitalResource".cluster ("clusterId", "clusterName", "clusterDescription") FROM stdin;
archives	Digital_resource_cluster_for_archives	Digital resource cluster for archives
\.


--
-- Data for Name: clusterRepository; Type: TABLE DATA; Schema: digitalResource; Owner: maarch
--

COPY "digitalResource"."clusterRepository" ("clusterId", "repositoryId", "writePriority", "readPriority", "deletePriority") FROM stdin;
archives	archives_1	1	1	1
archives	archives_2	1	2	2
\.


--
-- Data for Name: contentType; Type: TABLE DATA; Schema: digitalResource; Owner: maarch
--

COPY "digitalResource"."contentType" (name, mediatype, description, puids, "validationMode", "conversionMode", "textExtractionMode", "metadataExtractionMode") FROM stdin;
\.


--
-- Data for Name: conversionRule; Type: TABLE DATA; Schema: digitalResource; Owner: maarch
--

COPY "digitalResource"."conversionRule" ("conversionRuleId", puid, "conversionService", "targetPuid") FROM stdin;
workflow_pod75x-151b-v9jsef	fmt/412	dependency/fileSystem/plugins/libreOffice	fmt/95
workflow_pod763-1691-dli2t0	fmt/291	dependency/fileSystem/plugins/libreOffice	fmt/18
\.


--
-- Data for Name: digitalResource; Type: TABLE DATA; Schema: digitalResource; Owner: maarch
--

COPY "digitalResource"."digitalResource" ("archiveId", "resId", "clusterId", size, puid, mimetype, hash, "hashAlgorithm", "fileExtension", "fileName", "mediaInfo", created, updated, "relatedResId", "relationshipType") FROM stdin;
maarchRM_scpqjf-e70a-1l24dw	maarchRM_scpqjf-f6w1-jbwi1r	archives	174	x-fmt/18	text/csv	62487b45f4762e21ac4cb4a71fae6de1f23a6b0af2098e1aa4835034e7d8e0c1	SHA256	csv	maarchRM_scpqjf-e70a-1l24dw_2024-04-29_16-45-15.csv	\N	0034-10-15 16:45:15	\N	\N	\N
maarchRM_scpqjg-gpp6-yz273j	maarchRM_scpqjg-hb98-o34mp2	archives	529	x-fmt/18	text/csv	2f0250033f0940b47a378f0e45b1d64f0ecf9e1ac469881e50756c409b6b391a	SHA256	csv	maarchRM_scpqjg-gpp6-yz273j_2024-04-29_16-45-16.csv	\N	0034-10-15 16:45:16	\N	\N	\N
maarchRM_scus9b-lf16-y093tu	maarchRM_scus9c-2f3e-5wlax0	archives	188	x-fmt/18	text/csv	e3e10a7dfb0b7a87731824854fbc01beaa4a14ffd72ef5a0437291ef5de5d540	SHA256	csv	maarchRM_scus9b-lf16-y093tu_2024-05-02_10-10-24.csv	\N	0007-11-14 10:10:24	\N	\N	\N
maarchRM_scus9h-6fjy-utkgw7	maarchRM_scus9h-8a2w-0mq7ax	archives	218	x-fmt/18	text/csv	1b7d6f0f9a8d741bba10e7674cdeb79ecdfae301199617b18eccf9a35baa19c9	SHA256	csv	maarchRM_scus9h-6fjy-utkgw7_2024-05-02_10-10-29.csv	\N	0007-11-14 10:10:29	\N	\N	\N
maarchRM_scusrf-atjd-t2un3c	maarchRM_scusrf-bw5n-ubcc8a	archives	267507	\N	application/pdf	5246e58d5ad102122a0e52734e266aa6cdca1ab67f3dc9d3ba9583ed45b9cd86	GOST	\N	Offre_Fourniture_Cartouches_UBA_29_04_2024.pdf	\N	0007-11-14 10:21:15	\N	\N	\N
\.


--
-- Data for Name: package; Type: TABLE DATA; Schema: digitalResource; Owner: maarch
--

COPY "digitalResource".package ("packageId", method) FROM stdin;
\.


--
-- Data for Name: packedResource; Type: TABLE DATA; Schema: digitalResource; Owner: maarch
--

COPY "digitalResource"."packedResource" ("packageId", "resId", name) FROM stdin;
\.


--
-- Data for Name: repository; Type: TABLE DATA; Schema: digitalResource; Owner: maarch
--

COPY "digitalResource".repository ("repositoryId", "repositoryName", "repositoryReference", "repositoryType", "repositoryUri", parameters, "maxSize", enabled) FROM stdin;
archives_1	Digital resource repository for archives	repository_1	fileSystem	/var/www/laabs/data/maarchRM/repository/archives_1	\N	\N	t
archives_2	Digital resource repository for archives 2	repository_2	fileSystem	/var/www/laabs/data/maarchRM/repository/archives_2	\N	\N	t
\.


--
-- Data for Name: folder; Type: TABLE DATA; Schema: filePlan; Owner: maarch
--

COPY "filePlan".folder ("folderId", name, "parentFolderId", description, "ownerOrgRegNumber", closed) FROM stdin;
maarchRM_scpqjf-em33-qkfr8k	Journal de l'application	\N	\N	GIC	f
maarchRM_scpqjf-euzk-dl0c6t	2024	maarchRM_scpqjf-em33-qkfr8k	\N	GIC	f
maarchRM_scpqjf-f1e4-tltpik	04	maarchRM_scpqjf-euzk-dl0c6t	\N	GIC	f
maarchRM_scpqjg-gsp2-etc3jo	Journal du cycle de vie	\N	\N	GIC	f
maarchRM_scpqjg-h05w-44qu54	2024	maarchRM_scpqjg-gsp2-etc3jo	\N	GIC	f
maarchRM_scpqjg-h7gc-jqom3g	04	maarchRM_scpqjg-h05w-44qu54	\N	GIC	f
maarchRM_scus9c-2btn-z28c07	05	maarchRM_scpqjf-euzk-dl0c6t	\N	GIC	f
maarchRM_scus9h-85sf-ub6ax7	05	maarchRM_scpqjg-h05w-44qu54	\N	GIC	f
\.


--
-- Data for Name: position; Type: TABLE DATA; Schema: filePlan; Owner: maarch
--

COPY "filePlan"."position" ("folderId", "archiveId") FROM stdin;
\.


--
-- Data for Name: event; Type: TABLE DATA; Schema: lifeCycle; Owner: maarch
--

COPY "lifeCycle".event ("eventId", "eventType", "timestamp", "instanceName", "orgRegNumber", "orgUnitRegNumber", "accountId", "objectClass", "objectId", "operationResult", description, "eventInfo") FROM stdin;
maarchRM_scpqjf-gbcw-qol45n	recordsManagement/deposit	0034-10-15 16:45:15	maarchRM	ACME	GIC	superadmin	recordsManagement/archive	maarchRM_scpqjf-e70a-1l24dw	t	Dépôt de l'archive maarchRM_scpqjf-e70a-1l24dw	["maarchRM_scpqjf-f6w1-jbwi1r","SHA256","62487b45f4762e21ac4cb4a71fae6de1f23a6b0af2098e1aa4835034e7d8e0c1","\\/\\/journal\\/application\\/_2024_\\/_04_\\/maarchRM_scpqjf-e70a-1l24dw\\/maarchRM_scpqjf-f6w1-jbwi1r","GIC","GIC","GIC","",174,"",""]
maarchRM_scpqjg-hueg-2u8uww	recordsManagement/deposit	0034-10-15 16:45:16	maarchRM	ACME	GIC	superadmin	recordsManagement/archive	maarchRM_scpqjg-gpp6-yz273j	t	Dépôt de l'archive maarchRM_scpqjg-gpp6-yz273j	["maarchRM_scpqjg-hb98-o34mp2","SHA256","2f0250033f0940b47a378f0e45b1d64f0ecf9e1ac469881e50756c409b6b391a","\\/\\/journal\\/lifeCycle\\/_2024_\\/_04_\\/maarchRM_scpqjg-gpp6-yz273j\\/maarchRM_scpqjg-hb98-o34mp2","GIC","GIC","GIC","",529,"",""]
maarchRM_scpqji-jzoc-iiho8k	recordsManagement/periodicIntegrityCheck	0034-10-15 16:45:18	maarchRM	ACME	GIC	superadmin	recordsManagement/serviceLevel	ServiceLevel_001	t	Validation périodique de l'intégrité	["2024-04-29T16:45:18+00:00","2024-04-29T16:45:18+00:00",0,0,0,""]
maarchRM_scpqjj-1rd5-9d8z73	recordsManagement/integrityCheck	0034-10-15 16:45:19	maarchRM	ACME	GIC	superadmin	recordsManagement/archive	maarchRM_scpqjf-e70a-1l24dw	t	Validation d'intégrité	["maarchRM_scpqjf-f6w1-jbwi1r","62487b45f4762e21ac4cb4a71fae6de1f23a6b0af2098e1aa4835034e7d8e0c1","SHA256","\\/\\/journal\\/application\\/_2024_\\/_04_\\/maarchRM_scpqjf-e70a-1l24dw\\/maarchRM_scpqjf-f6w1-jbwi1r","GIC","Checking succeeded",""]
maarchRM_scpqjj-243s-ro7pln	recordsManagement/integrityCheck	0034-10-15 16:45:19	maarchRM	ACME	GIC	superadmin	recordsManagement/archive	maarchRM_scpqjf-e70a-1l24dw	t	Validation d'intégrité	["","","","\\/journal\\/application\\/_2024_\\/_04_\\/maarchRM_scpqjf-e70a-1l24dw","GIC","Checking succeeded",""]
maarchRM_scpqjj-2ap5-3h74wy	recordsManagement/periodicIntegrityCheck	0034-10-15 16:45:19	maarchRM	ACME	GIC	superadmin	recordsManagement/serviceLevel	ServiceLevel_002	t	Validation périodique de l'intégrité	["2024-04-29T16:45:18+00:00","2024-04-29T16:45:19+00:00",1,1,1,""]
maarchRM_scurky-h0gt-e2gr2w	recordsManagement/integrityCheck	0007-11-14 09:55:46	maarchRM	ACME	GIC	bblier	recordsManagement/archive	maarchRM_scpqjg-gpp6-yz273j	t	Validation d'intégrité	["maarchRM_scpqjg-hb98-o34mp2","2f0250033f0940b47a378f0e45b1d64f0ecf9e1ac469881e50756c409b6b391a","SHA256","\\/\\/journal\\/lifeCycle\\/_2024_\\/_04_\\/maarchRM_scpqjg-gpp6-yz273j\\/maarchRM_scpqjg-hb98-o34mp2","GIC","Checking succeeded",""]
maarchRM_scurky-hjfi-sjtha1	recordsManagement/integrityCheck	0007-11-14 09:55:46	maarchRM	ACME	GIC	bblier	recordsManagement/archive	maarchRM_scpqjg-gpp6-yz273j	t	Validation d'intégrité	["","","","\\/journal\\/lifeCycle\\/_2024_\\/_04_\\/maarchRM_scpqjg-gpp6-yz273j","GIC","Checking succeeded",""]
maarchRM_scurl0-dlkd-2s0scj	recordsManagement/integrityCheck	0007-11-14 09:55:48	maarchRM	ACME	GIC	bblier	recordsManagement/archive	maarchRM_scpqjg-gpp6-yz273j	t	Validation d'intégrité	["maarchRM_scpqjg-hb98-o34mp2","2f0250033f0940b47a378f0e45b1d64f0ecf9e1ac469881e50756c409b6b391a","SHA256","\\/\\/journal\\/lifeCycle\\/_2024_\\/_04_\\/maarchRM_scpqjg-gpp6-yz273j\\/maarchRM_scpqjg-hb98-o34mp2","GIC","Checking succeeded",""]
maarchRM_scurl0-e4yq-x98jlj	recordsManagement/integrityCheck	0007-11-14 09:55:48	maarchRM	ACME	GIC	bblier	recordsManagement/archive	maarchRM_scpqjg-gpp6-yz273j	t	Validation d'intégrité	["","","","\\/journal\\/lifeCycle\\/_2024_\\/_04_\\/maarchRM_scpqjg-gpp6-yz273j","GIC","Checking succeeded",""]
maarchRM_scurl2-ieqo-ulgylu	recordsManagement/integrityCheck	0007-11-14 09:55:50	maarchRM	ACME	GIC	bblier	recordsManagement/archive	maarchRM_scpqjg-gpp6-yz273j	t	Validation d'intégrité	["maarchRM_scpqjg-hb98-o34mp2","2f0250033f0940b47a378f0e45b1d64f0ecf9e1ac469881e50756c409b6b391a","SHA256","\\/\\/journal\\/lifeCycle\\/_2024_\\/_04_\\/maarchRM_scpqjg-gpp6-yz273j\\/maarchRM_scpqjg-hb98-o34mp2","GIC","Checking succeeded",""]
maarchRM_scurl2-irmx-jo8r3d	recordsManagement/integrityCheck	0007-11-14 09:55:50	maarchRM	ACME	GIC	bblier	recordsManagement/archive	maarchRM_scpqjg-gpp6-yz273j	t	Validation d'intégrité	["","","","\\/journal\\/lifeCycle\\/_2024_\\/_04_\\/maarchRM_scpqjg-gpp6-yz273j","GIC","Checking succeeded",""]
maarchRM_scus9c-2sg1-fjyml2	recordsManagement/deposit	0007-11-14 10:10:24	maarchRM	ACME	GIC	superadmin	recordsManagement/archive	maarchRM_scus9b-lf16-y093tu	t	Dépôt de l'archive maarchRM_scus9b-lf16-y093tu	["maarchRM_scus9c-2f3e-5wlax0","SHA256","e3e10a7dfb0b7a87731824854fbc01beaa4a14ffd72ef5a0437291ef5de5d540","\\/\\/journal\\/application\\/_2024_\\/_05_\\/maarchRM_scus9b-lf16-y093tu\\/maarchRM_scus9c-2f3e-5wlax0","GIC","GIC","GIC","",188,"",""]
maarchRM_scus9h-8n3l-lsnxo4	recordsManagement/deposit	0007-11-14 10:10:29	maarchRM	ACME	GIC	superadmin	recordsManagement/archive	maarchRM_scus9h-6fjy-utkgw7	t	Dépôt de l'archive maarchRM_scus9h-6fjy-utkgw7	["maarchRM_scus9h-8a2w-0mq7ax","SHA256","1b7d6f0f9a8d741bba10e7674cdeb79ecdfae301199617b18eccf9a35baa19c9","\\/\\/journal\\/lifeCycle\\/_2024_\\/_05_\\/maarchRM_scus9h-6fjy-utkgw7\\/maarchRM_scus9h-8a2w-0mq7ax","GIC","GIC","GIC","",218,"",""]
maarchRM_scusrf-d2dr-cc2o4r	recordsManagement/deposit	0007-11-14 10:21:15	maarchRM	ACME	GIC	bblier	recordsManagement/archive	maarchRM_scusrf-atjd-t2un3c	t	Dépôt de l'archive maarchRM_scusrf-atjd-t2un3c	["maarchRM_scusrf-bw5n-ubcc8a","GOST","5246e58d5ad102122a0e52734e266aa6cdca1ab67f3dc9d3ba9583ed45b9cd86","\\/\\/maarchRM\\/ACME\\/GIC\\/NOTSER\\/2024\\/05\\/02\\/maarchRM_scusrf-atjd-t2un3c\\/maarchRM_scusrf-bw5n-ubcc8a","GIC","","GIC","",267507,"teest","NOTSER"]
\.


--
-- Data for Name: eventFormat; Type: TABLE DATA; Schema: lifeCycle; Owner: maarch
--

COPY "lifeCycle"."eventFormat" (type, format, message, notification) FROM stdin;
digitalResource/integrityCheck	repositoryReference addressesToCheck checkedAddresses failed	Contrôle d'intégrité des ressources présentes dans %6$s	f
medona/acceptance	type senderOrgRegNumber senderOrgName recipientOrgRegNumber recipientOrgName reference	Message %14$s de type %9$s accepté par %13$s (%12$s)	f
medona/acknowledgement	type senderOrgRegNumber senderOrgName recipientOrgRegNumber recipientOrgName reference code info	Acquittement du message %14$s : %16$s (%15$s)	f
medona/processing	type senderOrgRegNumber senderOrgName recipientOrgRegNumber recipientOrgName reference	Traitement du message %14$s de type %9$s de %11$s (%10$s) par %13$s (%12$s)	f
medona/reception	type senderOrgRegNumber senderOrgName recipientOrgRegNumber recipientOrgName reference	Réception du message %14$s de type %9$s de %11$s (%10$s) par %13$s (%12$s)	f
medona/rejection	type senderOrgRegNumber senderOrgName recipientOrgRegNumber recipientOrgName reference	Message %14$s de type %9$s rejeté par %13$s (%12$s)	f
medona/retry	type senderOrgRegNumber senderOrgName recipientOrgRegNumber recipientOrgName reference	Message %14$s de type %9$s réinitialisé par %13$s (%12$s)	f
medona/sending	type senderOrgRegNumber senderOrgName recipientOrgRegNumber recipientOrgName reference code info	Envoi du message %14$s de type %9$s de %11$s (%10$s) à %13$s (%12$s)	f
medona/validation	type senderOrgRegNumber senderOrgName recipientOrgRegNumber recipientOrgName reference code info	Validation du message %14$s : %16$s (%15$s)	f
organization/counting	orgName ownerOrgId	Compter le nombre d'objets numériques dans l'activité %6$s	f
organization/journal	orgName ownerOrgId	Lecture du journal de l'organisation %6$s	f
organization/listing	orgName ownerOrgId	Lister les identifiants d'objets numériques de l'activité %6$s	f
recordsManagement/accessRuleModification	resId hashAlgorithm hash address accessRuleStartDate accessRuleDuration previousAccessRuleStartDate previousAccessRuleDuration originatorOrgRegNumber archiverOrgRegNumber originatorArchiveId	Modification de la règle de communicabilité de l'archive %6$s	f
recordsManagement/addRelationship	resId hashAlgorithm hash address originatorOrgRegNumber archiverOrgRegNumber relatedArchiveId originatorArchiveId	Relation ajoutée avec l'archive %6$s	f
recordsManagement/archivalProfileModification	archivalProfileReference	Modification du profil %6$s.	f
recordsManagement/consultation	resId hash hashAlgorith address size originatorArchiveId	Consultation de la ressource %9$s	f
recordsManagement/conversion	resId hashAlgorithm hash address convertedResId convertedHashAlgorithm convertedHash convertedAddress software docId size originatorArchiveId	Conversion du document %18$s	f
recordsManagement/deleteRelationship	resId hashAlgorithm hash address originatorOrgRegNumber archiverOrgRegNumber relatedArchiveId originatorArchiveId	Relation avec l'archive %6$s supprimée	f
recordsManagement/delivery	resId hashAlgorithm hash address requesterOrgRegNumber archiverOrgRegNumber size originatorArchiveId	Communication de l'archive %6$s	f
recordsManagement/deposit	resId hashAlgorithm hash address originatorOrgRegNumber depositorOrgRegNumber archiverOrgRegNumber format size originatorArchiveId archivalProfileReference	Dépôt de l'archive %6$s	f
recordsManagement/depositNewResource	resId hashAlgorithm hash address originatorOrgRegNumber depositorOrgRegNumber archiverOrgRegNumber format size originatorArchiveId archivalProfileReference	Dépôt d'une ressource dans l'archive	f
recordsManagement/destruction	resId hashAlgorithm hash address originatorOrgRegNumber archiverOrgRegNumber size originatorArchiveId archivalProfileReference	Destruction de l'archive %6$s	f
recordsManagement/destructionRequest	resId hashAlgorithm hash address originatorOrgRegNumber archiverOrgRegNumber size originatorArchiveId	Demande de destruction de l'archive %6$s	f
recordsManagement/destructionRequestCanceling	resId hashAlgorithm hash address originatorOrgRegNumber archiverOrgRegNumber size originatorArchiveId	Annulation de la demande de destruction de l'archive %6$s	f
recordsManagement/elimination	resId hashAlgorithm hash address originatorOrgRegNumber archiverOrgRegNumber size originatorArchiveId	Élimination de l'archive %6$s	f
recordsManagement/freeze	resId hashAlgorithm hash address originatorOrgRegNumber archiverOrgRegNumber originatorArchiveId	Gel de l'archive %6$s	f
recordsManagement/integrityCheck	resId hash hashAlgorithm address requesterOrgRegNumber info originatorArchiveId	Validation d'intégrité	f
recordsManagement/metadataModification	resId hashAlgorithm hash address originatorOrgRegNumber archiverOrgRegNumber originatorArchiveId	Modification des métadonnées de l'archive %6$s	f
recordsManagement/periodicIntegrityCheck	startDatetime endDatetime nbArchivesToCheck nbArchivesInSample archivesChecked originatorArchiveId	Validation périodique de l'intégrité	f
recordsManagement/profileCreation	archivalProfileReference	Création du profil %6$s	f
recordsManagement/profileDestruction	archivalProfileReference	Destruction du profil %6$s	f
recordsManagement/resourceDestruction	resId hashAlgorithm hash address originatorOrgRegNumber archiverOrgRegNumber originatorArchiveId	Destruction de la ressource %9$s	f
recordsManagement/restitution	resId hashAlgorithm hash address originatorOrgRegNumber archiverOrgRegNumber size originatorArchiveId	Restitution de l'archive %6$s	f
recordsManagement/retentionRuleModification	resId hashAlgorithm hash address retentionStartDate retentionDuration finalDisposition previousStartDate previousDuration previousFinalDisposition originatorOrgRegNumber archiverOrgRegNumber originatorArchiveId	Modification de la règle de conservation de l'archive %6$s	f
recordsManagement/unfreeze	resId hashAlgorithm hash address originatorOrgRegNumber archiverOrgRegNumber originatorArchiveId	Dégel de l'archive %6$s	f
\.


--
-- Data for Name: archivalAgreement; Type: TABLE DATA; Schema: medona; Owner: maarch
--

COPY medona."archivalAgreement" ("archivalAgreementId", name, reference, description, "archivalProfileReference", "serviceLevelReference", "archiverOrgRegNumber", "depositorOrgRegNumber", "originatorOrgIds", "beginDate", "endDate", enabled, "allowedFormats", "maxSizeAgreement", "maxSizeTransfer", "maxSizeDay", "maxSizeWeek", "maxSizeMonth", "maxSizeYear", signed, "autoTransferAcceptance", "processSmallArchive") FROM stdin;
\.


--
-- Data for Name: controlAuthority; Type: TABLE DATA; Schema: medona; Owner: maarch
--

COPY medona."controlAuthority" ("originatorOrgUnitId", "controlAuthorityOrgUnitId") FROM stdin;
\.


--
-- Data for Name: message; Type: TABLE DATA; Schema: medona; Owner: maarch
--

COPY medona.message ("messageId", schema, type, status, date, reference, "accountId", "senderOrgRegNumber", "senderOrgName", "recipientOrgRegNumber", "recipientOrgName", "archivalAgreementReference", "replyCode", "operationDate", "receptionDate", "relatedReference", "requestReference", "replyReference", "authorizationReference", "authorizationReason", "authorizationRequesterOrgRegNumber", derogation, "dataObjectCount", size, data, path, active, archived, "isIncoming", comment) FROM stdin;
\.


--
-- Data for Name: messageComment; Type: TABLE DATA; Schema: medona; Owner: maarch
--

COPY medona."messageComment" ("messageId", comment, "commentId") FROM stdin;
\.


--
-- Data for Name: unitIdentifier; Type: TABLE DATA; Schema: medona; Owner: maarch
--

COPY medona."unitIdentifier" ("messageId", "objectClass", "objectId") FROM stdin;
\.


--
-- Data for Name: archivalProfileAccess; Type: TABLE DATA; Schema: organization; Owner: maarch
--

COPY organization."archivalProfileAccess" ("orgId", "archivalProfileReference", "originatorAccess", "serviceLevelReference", "userAccess") FROM stdin;
DAF	FACACH	f	\N	{"subProfile": {}, "processingStatuses": {"QUALIFIED": {"actions": {"reject": {}, "redirect": {}, "validate": {}}}, "VALIDATED": {"actions": {"reject": {}, "approve": {}}}}}
DIP	DOSIP	t	\N	\N
DSI	FACACH	f	\N	{"subProfile": {}, "processingStatuses": {"QUALIFIED": {"actions": {"reject": {}, "redirect": {}, "validate": {}}}, "VALIDATED": {"actions": {"reject": {}, "approve": {}}}}}
FOUR	FACACH	t	\N	{"history": {}, "subProfile": {}, "processingStatuses": {"NEW": {"actions": {"qualify": {}, "cancelQualify": {}}}, "APPROVED": {"actions": {"pay": {}, "updateMetadata": {}}}, "REJECTED": {"actions": {"cancelQualify": {}, "sendValidation": {}, "updateMetadata": {}, "sendToApprobation": {}}}, "MISQUALIFIED": {"actions": {"qualify": {}}}}}
FOUR	FACJU	t	\N	\N
SALES	FACVEN	t	\N	\N
DSG	FACACH	f	\N	{"subProfile": {}, "processingStatuses": {"QUALIFIED": {"actions": {"reject": {}, "redirect": {}, "validate": {}}}, "VALIDATED": {"actions": {"reject": {}, "approve": {}}}}}
PAIE	BULPAI	t	\N	{"subProfile": {}, "processingStatuses": {}}
DAF	NOTSER	t	\N	{"subProfile": {}, "processingStatuses": {}}
DCIAL	NOTSER	t	\N	{"subProfile": {}, "processingStatuses": {}}
RH	NOTSER	t	\N	{"subProfile": {}, "processingStatuses": {}}
DSI	NOTSER	t	\N	{"subProfile": {}, "processingStatuses": {}}
GIC	NOTSER	t	\N	{"subProfile": {}, "processingStatuses": {}}
TENDER	PM	t	\N	{"subProfile": {}, "processingStatuses": {}}
TENDER	COUNM	t	\N	{"subProfile": {}, "processingStatuses": {}}
DOCSOC	FICCR	t	\N	{"subProfile": {}, "processingStatuses": {}}
DOCSOC	LETC	t	\N	{"subProfile": {}, "processingStatuses": {}}
DOCSOC	FICI	t	\N	{"subProfile": {}, "processingStatuses": {}}
MARK	FACACH	f	\N	{"subProfile": {}, "processingStatuses": {"QUALIFIED": {"actions": {"reject": {}, "redirect": {}, "validate": {}}}}}
DCIAL	FACACH	f	\N	{"subProfile": {}, "processingStatuses": {"VALIDATED": {"actions": {"reject": {}, "approve": {}}}}}
DAF	COUDE	t		{"subProfile": {}, "processingStatuses": {}}
\.


--
-- Data for Name: orgContact; Type: TABLE DATA; Schema: organization; Owner: maarch
--

COPY organization."orgContact" ("contactId", "orgId", "isSelf") FROM stdin;
\.


--
-- Data for Name: orgType; Type: TABLE DATA; Schema: organization; Owner: maarch
--

COPY organization."orgType" (code, name) FROM stdin;
Collectivite	Collectivité
Direction	Direction d'une entreprise ou d'une collectivité
Division	Division d'une entreprise
Service	Service d'une entreprise ou d'une collectivité
Societe	Société
\.


--
-- Data for Name: organization; Type: TABLE DATA; Schema: organization; Owner: maarch
--

COPY organization.organization ("orgId", "orgName", "otherOrgName", "displayName", "registrationNumber", "beginDate", "endDate", "legalClassification", "businessType", description, "orgTypeCode", "orgRoleCodes", "taxIdentifier", "parentOrgId", "ownerOrgId", history, "isOrgUnit", enabled) FROM stdin;
ACME	Archives Conservation et Mémoire Électronique	\N	Archives Conservation et Mémoire Électronique	ACME	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	t
DAF	Direction Administrative et Financière	\N	Direction Administrative et Financière	DAF	\N	\N	\N	\N	\N	\N	\N	\N	ACME	ACME	\N	t	t
DSG	Services généraux	\N	Direction des Services Généraux	DSG	\N	\N	\N	\N	\N	\N	\N	\N	DAF	ACME	\N	t	t
ACHAT	Achats Groupe	\N	Achats Groupe	ACHAT	\N	\N	\N	\N	\N	\N	\N	\N	DSG	ACME	\N	t	t
AUTO	Gestion parc Auto	\N	Gestion du Parc Automobile	AUTO	\N	\N	\N	\N	\N	\N	\N	\N	DSG	ACME	\N	t	t
NETT	Nettoyage des Locaux	\N	Nettoyage des Locaux	NETT	\N	\N	\N	\N	\N	\N	\N	\N	DSG	ACME	\N	t	t
SJ	Service Juridique	\N	Service Juridique	SJ	\N	\N	\N	\N	\N	\N	\N	\N	DAF	ACME	\N	t	t
ASSU	Assurances Groupe	\N	Assurances du Groupe	ASSU	\N	\N	\N	\N	\N	\N	\N	\N	SJ	ACME	\N	t	t
CONCOM	Contrats Commerciaux	\N	Contrats Commerciaux	CONCOM	\N	\N	\N	\N	\N	\N	\N	\N	SJ	ACME	\N	t	t
DSOC	Droit des sociétés	\N	Droit des Sociétés	DSOC	\N	\N	\N	\N	\N	\N	\N	\N	SJ	ACME	\N	t	t
CTBLE	Service Comptable	\N	Service Comptable	CTBLE	\N	\N	\N	\N	\N	\N	\N	\N	DAF	ACME	\N	t	t
BILAN	Comptes de bilan	\N	Comptes de Bilan et Clôture d'Exercice	BILAN	\N	\N	\N	\N	\N	\N	\N	\N	CTBLE	ACME	\N	t	t
FISCA	Fiscalité	\N	Fiscalité	FISCA	\N	\N	\N	\N	\N	\N	\N	\N	CTBLE	ACME	\N	t	t
FOUR	Achats/Fournisseurs	\N	Comptabilité Achats/Fournisseurs	FOUR	\N	\N	\N	\N	\N	\N	\N	\N	CTBLE	ACME	\N	t	t
GEN	Comptabilité Générale	\N	Comptabilité Générale/Éditions comptables	GEN	\N	\N	\N	\N	\N	\N	\N	\N	CTBLE	ACME	\N	t	t
SALES	Ventes/Clients	\N	Comptabilité Ventes/Clients	SALES	\N	\N	\N	\N	\N	\N	\N	\N	CTBLE	ACME	\N	t	t
TRESO	Trésorerie	\N	Trésorerie	TRESO	\N	\N	\N	\N	\N	\N	\N	\N	CTBLE	ACME	\N	t	t
DG	Direction Générale	\N	Direction Générale	DG	\N	\N	\N	\N	\N	\N	\N	\N	DAF	ACME	\N	t	t
DOCSOC	Documents de société	\N	Document de société	DOCSOC	\N	\N	\N	\N	\N	\N	\N	\N	DG	ACME	\N	t	t
LITIGES	Suivi litiges Contentieux	\N	Suivi des litiges et contentieux	LITIGES	\N	\N	\N	\N	\N	\N	\N	\N	DG	ACME	\N	t	t
DCIAL	Direction Commerciale	\N	Direction Commerciale	DCIAL	\N	\N	\N	\N	\N	\N	\N	\N	ACME	ACME	\N	t	t
CUST	Gestion Clients	\N	Gestion Clients	CUST	\N	\N	\N	\N	\N	\N	\N	\N	DCIAL	ACME	\N	t	t
DEAL	Offres Commerciales	\N	Offres Commerciales	DEAL	\N	\N	\N	\N	\N	\N	\N	\N	DCIAL	ACME	\N	t	t
MARK	Marketing	\N	Marketing	MARK	\N	\N	\N	\N	\N	\N	\N	\N	DCIAL	ACME	\N	t	t
TENDER	Appels d'offres	\N	Réponses aux Appels d'Offres/Collectivités	TENDER	\N	\N	\N	\N	\N	\N	\N	\N	DCIAL	ACME	\N	t	t
DSI	Direction des SI	\N	Direction des Systèmes d'Information	DSI	\N	\N	\N	\N	\N	\N	\N	\N	ACME	ACME	\N	t	t
SIG	Gestion systèmes d'informations	\N	Gestion des Systèmes d'Information	SIG	\N	\N	\N	\N	\N	\N	\N	\N	DSI	ACME	\N	t	t
SYSRES	Système et Réseaux	\N	Système et Réseaux	SYSRES	\N	\N	\N	\N	\N	\N	\N	\N	DSI	ACME	\N	t	t
SUPP	Support	\N	Support	SUPP	\N	\N	\N	\N	\N	\N	\N	\N	DSI	ACME	\N	t	t
GIC	Gestion et Conservation de l'Information	\N	Gestion et Conservation de l'Information	GIC	\N	\N	\N	\N	\N	\N	owner	\N	ACME	ACME	\N	t	t
RH	Direction des Ressources Humaines	\N	Direction des Ressources Humaines	RH	\N	\N	\N	\N	\N	\N	\N	\N	ACME	ACME	\N	t	t
DIP	Dossiers du personnel	\N	Dossiers Individuels du Personnel	DIP	\N	\N	\N	\N	\N	\N	\N	\N	RH	ACME	\N	t	t
MUT	Prévoyance/Mutuelle	\N	Prévoyance/Mutuelle	MUT	\N	\N	\N	\N	\N	\N	\N	\N	RH	ACME	\N	t	t
NOTFRA	Notes Frais	\N	Gestion des Notes de Frais	NOTFRA	\N	\N	\N	\N	\N	\N	\N	\N	RH	ACME	\N	t	t
PAIE	Rémunération et Paie	\N	Rémunération et Paie	PAIE	\N	\N	\N	\N	\N	\N	\N	\N	RH	ACME	\N	t	t
SOC	Charges Sociales	\N	Charges Sociales	SOC	\N	\N	\N	\N	\N	\N	\N	\N	RH	ACME	\N	t	t
\.


--
-- Data for Name: servicePosition; Type: TABLE DATA; Schema: organization; Owner: maarch
--

COPY organization."servicePosition" ("serviceAccountId", "orgId") FROM stdin;
System	GIC
SystemDepositor	GIC
\.


--
-- Data for Name: userPosition; Type: TABLE DATA; Schema: organization; Owner: maarch
--

COPY organization."userPosition" ("userAccountId", "orgId", function, "default") FROM stdin;
aackermann	FOUR	\N	t
aadams	DAF	\N	t
aalambic	FOUR	\N	t
aastier	DSG	\N	t
bbain	SJ	\N	t
bbardot	GEN	\N	t
bblier	GIC	\N	t
bboule	SALES	\N	t
ccamus	TRESO	\N	t
cchaplin	RH	\N	t
ccharles	GIC	\N	t
ccordy	FOUR	\N	t
ccox	SJ	\N	t
ddaull	DAF	\N	t
ddenis	GIC	\N	t
ddur	SALES	\N	t
eerina	SALES	\N	t
ggrand	RH	\N	t
hhier	PAIE	\N	t
jjane	DOCSOC	\N	t
jjonasz	LITIGES	\N	t
kkaar	TENDER	\N	t
kkrach	MARK	\N	t
mmanfred	DEAL	\N	t
ppacioli	NETT	\N	t
ppetit	CTBLE	\N	t
ppreboist	DSI	\N	t
ppruvost	DSI	\N	t
rrenaud	DSG	\N	t
rreynolds	ACHAT	\N	t
ssaporta	AUTO	\N	t
ssissoko	CUST	\N	t
sstallone	SUPP	\N	t
sstar	SUPP	\N	t
sstone	DCIAL	\N	t
ttong	SALES	\N	t
ttule	SYSRES	\N	t
vvictoire	RH	\N	t
\.


--
-- Data for Name: accessRule; Type: TABLE DATA; Schema: recordsManagement; Owner: maarch
--

COPY "recordsManagement"."accessRule" (code, duration, description) FROM stdin;
\.


--
-- Data for Name: archivalProfile; Type: TABLE DATA; Schema: recordsManagement; Owner: maarch
--

COPY "recordsManagement"."archivalProfile" ("archivalProfileId", reference, name, "descriptionSchema", "descriptionClass", "retentionStartDate", "retentionRuleCode", description, "accessRuleCode", "acceptUserIndex", "acceptArchiveWithoutProfile", "fileplanLevel", "processingStatuses") FROM stdin;
1	COUA	Courrier Administratif	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
2	PRVN	Procès-Verbal de Négociation	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
3	PRVIF	Procès-verbal à Incidence Financière	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
4	ETAR	État de Rapprochement	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
5	RELCC	Relevé de Contrôle de Caisse	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
6	CTRF	Contrat Fournisseur	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
7	DCLTVA	Déclaration de TVA	\N	\N	originatingDate	IMP	\N	\N	t	t	file	\N
8	QUTP	Quittance de Paiement	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
9	FICIC	Fiche d'Imputation Comptable	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
10	FACJU	Facture Justificative	\N	\N	originatingDate	COM	\N	\N	t	t	item	\N
11	FICREC	Fiche Récapitulative	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
12	DOSC	Dossiers Caisse	\N	\N	originatingDate	\N	\N	\N	t	t	file	\N
13	PIECD	Pièce de Caisse-Dépense	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
14	PIEJ	Pièce Justificative	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
15	DOSB	Dossiers Banque	\N	\N	originatingDate	\N	\N	\N	t	t	file	\N
16	PIEBD	Pièce de Banque-Dépense	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
17	FICDG	Fiche DG	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
18	NOTSER	Note de service	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
19	PM	Passation de marché	\N	\N	originatingDate	\N	\N	\N	t	t	file	\N
20	BORT	Bordereau de transmission	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
21	COUNM	Courrier de notification de marché	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
22	PRVA	Procès-Verbal d'Attribution	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
23	PRVOP	Proces-Verbal d'Ouverture des Plis	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
24	RAPEO	Rapport d’Évaluation des Offres	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
26	DEMC	Demande de Cotation	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
27	RAPFOR	Rapport de Formation	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
28	DOSIP	Dossier Individuel du Personnel	\N	\N	originatingDate	DIP	\N	\N	t	t	file	\N
29	ETAC	Etat Civil	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
30	CURV	Curriculum Vitae	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
31	EXTAN	Extrait d'Acte de Naissance	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
33	CASJU	Casier Judiciaire	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
34	ATTSU	Attestation de succès	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
35	CTRTRV	Contrat de Travail	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
37	ATTT	Attestation de Travail	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
39	CNSS	Caisse Nationale de Sécurité Sociale	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
41	CAR	Carrière	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
42	DECIN	Décision de nomination	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
43	DECIR	Décision de redéploiement	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
47	ATTF	Attestation de formation	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
53	COURRN	Courrier Répartition du Résultat Net	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
54	COUDS	Courrier Domiciliation de Salaire	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
55	FICP	Fiche de Poste	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
56	FICF	Fiche de Fonction	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
57	DEMA	Demandes Administratives	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
58	COUAA	Courrier Autorisation d'Absence	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
59	COUCA	Courrier Congés Administratifs	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
60	COUDE	Courrier Demande d'Emploi	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
61	DOSETU	Dossier de Synthèse et d’Étude	\N	\N	originatingDate	\N	\N	\N	t	t	file	\N
62	FICRM	Fiche de Remontée Mensuelle	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
63	RAPT	Rapport Trimestriel	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
64	RAPMOE	\tRapport de Mise en Œuvre	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
65	RAPA	Rapport d'Activité	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
66	RAPSE	Rapport de Suivi et Évaluation	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
67	RAPGES	Rapport de Gestion	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
68	TDRE	Termes de Références des Études	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
69	DCRN	Décret de Nomination	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
70	FICCR	Fiche de compte rendu	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
71	LETC	Lettre circulaire	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
72	FICI	Fiche d'instruction	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
73	RAPAMI	Rapport d'Audit et Missions Internes	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
74	RAPAE	Rapport d'Audit Externe	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
75	RAPER	Rapport d’Études et Recherches	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
76	COUABID	Courrier Arrivée BID	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
77	SMIROP	Fiche de visite SMIROP	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
78	VISA	Visas obtenus	\N	\N	originatingDate	\N	\N	\N	t	t	item	\N
79	FACVEN	Facture de vente	\N	\N	originatingDate	COM	\N	\N	t	t	item	\N
80	FACACH	Facture d'achat	\N	\N	description/dueDate	COM	\N	\N	t	f	item	{"NEW": {"type": "initial", "label": "Nouvelle(s) facture(s)", "actions": {"qualify": {}, "cancelQualify": {}}, "default": true, "position": 0, "filterUserAccess": false}, "PAYED": {"type": "final", "label": "Payée", "actions": {}, "default": false, "position": 6, "filterUserAccess": false}, "APPROVED": {"type": "intermediate", "label": "À payer", "actions": {"pay": {}, "updateMetadata": {}}, "default": false, "position": 5, "filterUserAccess": true}, "REJECTED": {"type": "intermediate", "label": "Rejetée(s)", "actions": {"sendValidation": {}, "updateMetadata": {}, "sendToApprobation": {}}, "default": false, "position": 3, "filterUserAccess": true}, "CANCELLED": {"type": "final", "label": "Annulée", "actions": {}, "default": false, "position": 7, "filterUserAccess": false}, "QUALIFIED": {"type": "intermediate", "label": "À valider", "actions": {"reject": {}, "redirect": {}, "validate": {}}, "default": false, "position": 1, "filterUserAccess": true}, "VALIDATED": {"type": "intermediate", "label": "À approuver", "actions": {"reject": {}, "approve": {}}, "default": false, "position": 4, "filterUserAccess": true}, "MISQUALIFIED": {"type": "intermediate", "label": "À requalifier", "actions": {"qualify": {}}, "default": false, "position": 2, "filterUserAccess": true}}
81	BULPAI	Bulletins de paie	\N	\N	\N	BULPAI	\N	\N	f	f	item	{}
\.


--
-- Data for Name: archivalProfileContents; Type: TABLE DATA; Schema: recordsManagement; Owner: maarch
--

COPY "recordsManagement"."archivalProfileContents" ("parentProfileId", "containedProfileId") FROM stdin;
7	8
7	9
7	10
7	11
12	9
12	13
12	14
15	9
15	14
15	16
19	2
19	18
19	20
19	21
19	22
19	23
19	24
19	26
28	1
28	29
28	30
28	31
28	33
28	34
28	35
28	37
28	39
28	41
28	42
28	43
28	47
28	53
28	54
28	55
28	56
28	57
28	58
28	59
28	60
28	77
28	78
61	1
61	17
61	63
61	64
61	65
61	66
61	67
61	68
61	69
\.


--
-- Data for Name: archive; Type: TABLE DATA; Schema: recordsManagement; Owner: maarch
--

COPY "recordsManagement".archive ("archiveId", "originatorArchiveId", "depositorArchiveId", "archiverArchiveId", "archiveName", "storagePath", "filePlanPosition", "fileplanLevel", "originatingDate", "descriptionClass", description, text, "originatorOrgRegNumber", "originatorOwnerOrgId", "originatorOwnerOrgRegNumber", "depositorOrgRegNumber", "archiverOrgRegNumber", "userOrgRegNumbers", "archivalProfileReference", "archivalAgreementReference", "serviceLevelReference", "retentionRuleCode", "retentionStartDate", "retentionDuration", "finalDisposition", "disposalDate", "retentionRuleStatus", "accessRuleCode", "accessRuleDuration", "accessRuleStartDate", "accessRuleComDate", "storageRuleCode", "storageRuleDuration", "storageRuleStartDate", "storageRuleEndDate", "classificationRuleCode", "classificationRuleDuration", "classificationRuleStartDate", "classificationEndDate", "classificationLevel", "classificationOwner", "depositDate", "lastCheckDate", "lastDeliveryDate", "lastModificationDate", status, "processingStatus", "parentArchiveId", "fullTextIndexation") FROM stdin;
maarchRM_scpqjf-e70a-1l24dw	\N	\N	\N	journal/application 0034/10/15 - 2024/04/29	/journal/application/_2024_/_04_/maarchRM_scpqjf-e70a-1l24dw	maarchRM_scpqjf-f1e4-tltpik	item	\N	recordsManagement/log	\N	\N	GIC	GIC	\N	GIC	GIC	\N	\N	\N	serviceLevel_002	\N	\N	P0Y	preservation	\N	\N	\N	P0Y	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0015-11-03 16:45:15	0034-10-15 16:45:19	\N	\N	preserved	\N	\N	none
maarchRM_scpqjg-gpp6-yz273j	\N	\N	\N	journal/lifeCycle 0034/10/15 - 2024/04/29	/journal/lifeCycle/_2024_/_04_/maarchRM_scpqjg-gpp6-yz273j	maarchRM_scpqjg-h7gc-jqom3g	item	\N	recordsManagement/log	\N	\N	GIC	GIC	\N	GIC	GIC	\N	\N	\N	serviceLevel_002	\N	\N	P0Y	preservation	\N	\N	\N	P0Y	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0015-11-03 16:45:16	0007-11-14 09:55:50	\N	\N	preserved	\N	\N	none
maarchRM_scus9b-lf16-y093tu	\N	\N	\N	journal/application 0034/10/15 - 2024/05/02	/journal/application/_2024_/_05_/maarchRM_scus9b-lf16-y093tu	maarchRM_scus9c-2btn-z28c07	item	\N	recordsManagement/log	\N	\N	GIC	GIC	\N	GIC	GIC	\N	\N	\N	serviceLevel_002	\N	\N	P0D	preservation	\N	\N	\N	P0D	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0007-11-14 10:10:24	\N	\N	\N	preserved	\N	\N	none
maarchRM_scus9h-6fjy-utkgw7	\N	\N	\N	journal/lifeCycle 0034/10/15 - 2024/05/02	/journal/lifeCycle/_2024_/_05_/maarchRM_scus9h-6fjy-utkgw7	maarchRM_scus9h-85sf-ub6ax7	item	\N	recordsManagement/log	\N	\N	GIC	GIC	\N	GIC	GIC	\N	\N	\N	serviceLevel_002	\N	\N	P0D	preservation	\N	\N	\N	P0D	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0007-11-14 10:10:29	\N	\N	\N	preserved	\N	\N	none
maarchRM_scusrf-atjd-t2un3c	teest	\N	FR094080_2024_AE0001	Offre_Fourniture_Cartouches_UBA_29_04_2024	/maarchRM/ACME/GIC/NOTSER/2024/05/02/maarchRM_scusrf-atjd-t2un3c	\N	item	2024-05-02	\N	{}	Offre_Fourniture_Cartouches_UBA_29_04_2024 teest 02-05-2024 	GIC	ACME	ACME	\N	GIC	\N	NOTSER	\N	serviceLevel_002	BULPAI	2024-05-02	P5Y	destruction	2029-05-02	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0007-11-14 10:21:15	\N	\N	\N	preserved	\N	\N	none
\.


--
-- Data for Name: archiveDescription; Type: TABLE DATA; Schema: recordsManagement; Owner: maarch
--

COPY "recordsManagement"."archiveDescription" ("archivalProfileId", "fieldName", required, "position", "isImmutable", "isRetained", "isInList") FROM stdin;
1	org	f	0	f	f	f
2	org	f	0	f	f	f
3	org	f	0	f	f	f
4	org	f	0	f	f	f
5	org	f	0	f	f	f
6	org	f	0	f	f	f
28	empid	t	1	f	\N	\N
28	fullname	f	0	f	\N	\N
28	reference_addresses	f	2	f	\N	\N
61	service	f	0	f	f	f
69	service	f	0	f	f	f
70	service	f	0	f	f	f
71	service	f	0	f	f	f
72	service	f	0	f	f	f
73	service	f	0	f	f	f
74	service	f	0	f	f	f
75	service	f	0	f	f	f
76	service	f	0	f	f	f
79	customer	f	0	f	f	f
79	salesPerson	f	0	f	f	f
80	dueDate	f	4	f	\N	f
80	netPayable	f	3	f	\N	t
80	orderNumber	f	5	f	\N	f
80	service	f	0	f	\N	t
80	supplier	f	2	f	\N	t
80	taxIdentifier	t	1	f	\N	f
81	empid	t	0	f	\N	f
81	fullname	t	1	f	\N	f
81	service	f	2	f	\N	f
81	org	t	3	f	\N	f
\.


--
-- Data for Name: archiveRelationship; Type: TABLE DATA; Schema: recordsManagement; Owner: maarch
--

COPY "recordsManagement"."archiveRelationship" ("archiveId", "relatedArchiveId", "typeCode", description) FROM stdin;
\.


--
-- Name: archiverArchiveIdSequence; Type: SEQUENCE SET; Schema: recordsManagement; Owner: maarch
--

SELECT pg_catalog.setval('"recordsManagement"."archiverArchiveIdSequence"', 1, true);


--
-- Data for Name: descriptionClass; Type: TABLE DATA; Schema: recordsManagement; Owner: maarch
--

COPY "recordsManagement"."descriptionClass" (name, label) FROM stdin;
\.


--
-- Data for Name: descriptionField; Type: TABLE DATA; Schema: recordsManagement; Owner: maarch
--

COPY "recordsManagement"."descriptionField" (name, label, type, "default", "minLength", "maxLength", "minValue", "maxValue", enumeration, facets, pattern, "isArray") FROM stdin;
customer	Client	text	\N	\N	\N	\N	\N	\N	\N	\N	f
documentId	Identifiant de document	name	\N	\N	\N	\N	\N	\N	\N	\N	f
dueDate	Date d'échéance	date	\N	\N	\N	\N	\N	\N	\N	\N	f
empid	Matricule	name	\N	\N	\N	\N	\N	\N	\N	\N	f
fullname	Nom complet	name	\N	\N	\N	\N	\N	\N	\N	\N	f
netPayable	Net à payer	number	\N	\N	\N	\N	\N	\N	\N	\N	f
orderNumber	Numéro de commande	name	\N	\N	\N	\N	\N	\N	\N	\N	f
org	Organisation	name	\N	\N	\N	\N	\N	["ACME Paris","ACME Dakar","ACME Cotonou"]	\N	\N	f
salesPerson	Vendeur	text	\N	\N	\N	\N	\N	\N	\N	\N	f
service	Service Concerné	name	\N	\N	\N	\N	\N	["MARK","DSG","DSI","DAF"]	\N	\N	f
supplier	Fournisseur	text	\N	\N	\N	\N	\N	\N	\N	\N	f
taxIdentifier	N° TVA Intraco.	name	\N	\N	\N	\N	\N	\N	\N	\N	f
\.


--
-- Data for Name: log; Type: TABLE DATA; Schema: recordsManagement; Owner: maarch
--

COPY "recordsManagement".log ("archiveId", "fromDate", "toDate", "processId", "processName", type, "ownerOrgRegNumber") FROM stdin;
maarchRM_scpqjf-e70a-1l24dw	0015-11-03 16:45:14	0034-10-15 16:45:15	\N	\N	application	\N
maarchRM_scpqjg-gpp6-yz273j	0015-11-03 16:45:15	0034-10-15 16:45:16	\N	\N	lifeCycle	\N
maarchRM_scus9b-lf16-y093tu	0015-11-03 16:45:15	0007-11-14 10:10:23	\N	\N	application	\N
maarchRM_scus9h-6fjy-utkgw7	0015-11-03 16:45:16	0007-11-14 10:10:29	\N	\N	lifeCycle	\N
\.


--
-- Data for Name: retentionRule; Type: TABLE DATA; Schema: recordsManagement; Owner: maarch
--

COPY "recordsManagement"."retentionRule" (code, duration, "finalDisposition", description, label, "implementationDate") FROM stdin;
BULPAI	P5Y	destruction	Code du Travail, art. L3243-4 - Code de la Sécurité Sociale, art. L243-12	Bulletins de paie	\N
COM	P10Y	destruction	Code du commerce, Article L123-22	Documents comptables	\N
DIP	P90Y	destruction	Convention Collective nationale de retraite et de prévoyance des cadres, art. 23	Dossier individuel du personnel	\N
IMP	P6Y	destruction	Livre des Procédures Fiscales, art 102 B et L 169 : Livres, registres, documents ou pièces sur lesquels peuvent s'exercer les droits de communication, d'enquête et de contrôle de l'administration	Contrôle de l'impôt	\N
IMPA	P3Y	destruction	Livre des Procédures Fiscales, art 102 B et L 169 alinea 3	Taxe professionnelle	\N
IMPS	P10Y	destruction	Livre des Procédures Fiscales, art 102 B et L 169 alinea 2: Les registres tenus en application du 9 de l'article 298 sexdecies F du code général des impôts et du 5 de l'article 298 sexdecies G du même code	Impôt sur les sociétés et liasses fiscales	\N
GES	P5Y	destruction	Documents de gestion	Documents de gestion	\N
\.


--
-- Data for Name: serviceLevel; Type: TABLE DATA; Schema: recordsManagement; Owner: maarch
--

COPY "recordsManagement"."serviceLevel" ("serviceLevelId", reference, "digitalResourceClusterId", control, "default", "samplingFrequency", "samplingRate") FROM stdin;
ServiceLevel_001	serviceLevel_001	archives	formatDetection formatValidation virusCheck convertOnDeposit	f	2	50
ServiceLevel_002	serviceLevel_002	archives	\N	t	2	50
\.


--
-- Data for Name: storageRule; Type: TABLE DATA; Schema: recordsManagement; Owner: maarch
--

COPY "recordsManagement"."storageRule" (code, duration, description, label) FROM stdin;
\.


--
-- Name: event event_pkey; Type: CONSTRAINT; Schema: audit; Owner: maarch
--

ALTER TABLE ONLY audit.event
    ADD CONSTRAINT event_pkey PRIMARY KEY ("eventId");


--
-- Name: account account_accountName_key; Type: CONSTRAINT; Schema: auth; Owner: maarch
--

ALTER TABLE ONLY auth.account
    ADD CONSTRAINT "account_accountName_key" UNIQUE ("accountName");


--
-- Name: account account_pkey; Type: CONSTRAINT; Schema: auth; Owner: maarch
--

ALTER TABLE ONLY auth.account
    ADD CONSTRAINT account_pkey PRIMARY KEY ("accountId");


--
-- Name: privilege privilege_roleId_userStory_key; Type: CONSTRAINT; Schema: auth; Owner: maarch
--

ALTER TABLE ONLY auth.privilege
    ADD CONSTRAINT "privilege_roleId_userStory_key" UNIQUE ("roleId", "userStory");


--
-- Name: roleMember roleMember_roleId_userAccountId_key; Type: CONSTRAINT; Schema: auth; Owner: maarch
--

ALTER TABLE ONLY auth."roleMember"
    ADD CONSTRAINT "roleMember_roleId_userAccountId_key" UNIQUE ("roleId", "userAccountId");


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: auth; Owner: maarch
--

ALTER TABLE ONLY auth.role
    ADD CONSTRAINT role_pkey PRIMARY KEY ("roleId");


--
-- Name: servicePrivilege servicePrivilege_accountId_serviceURI_key; Type: CONSTRAINT; Schema: auth; Owner: maarch
--

ALTER TABLE ONLY auth."servicePrivilege"
    ADD CONSTRAINT "servicePrivilege_accountId_serviceURI_key" UNIQUE ("accountId", "serviceURI");


--
-- Name: logScheduling logScheduling_pkey; Type: CONSTRAINT; Schema: batchProcessing; Owner: maarch
--

ALTER TABLE ONLY "batchProcessing"."logScheduling"
    ADD CONSTRAINT "logScheduling_pkey" PRIMARY KEY ("logId");


--
-- Name: notification notification_pkey; Type: CONSTRAINT; Schema: batchProcessing; Owner: maarch
--

ALTER TABLE ONLY "batchProcessing".notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY ("notificationId");


--
-- Name: scheduling scheduling_pkey; Type: CONSTRAINT; Schema: batchProcessing; Owner: maarch
--

ALTER TABLE ONLY "batchProcessing".scheduling
    ADD CONSTRAINT scheduling_pkey PRIMARY KEY ("schedulingId");


--
-- Name: address address_contactId_purpose_key; Type: CONSTRAINT; Schema: contact; Owner: maarch
--

ALTER TABLE ONLY contact.address
    ADD CONSTRAINT "address_contactId_purpose_key" UNIQUE ("contactId", purpose);


--
-- Name: address address_pkey; Type: CONSTRAINT; Schema: contact; Owner: maarch
--

ALTER TABLE ONLY contact.address
    ADD CONSTRAINT address_pkey PRIMARY KEY ("addressId");


--
-- Name: communicationMean communicationMean_name_key; Type: CONSTRAINT; Schema: contact; Owner: maarch
--

ALTER TABLE ONLY contact."communicationMean"
    ADD CONSTRAINT "communicationMean_name_key" UNIQUE (name);


--
-- Name: communicationMean communicationMean_pkey; Type: CONSTRAINT; Schema: contact; Owner: maarch
--

ALTER TABLE ONLY contact."communicationMean"
    ADD CONSTRAINT "communicationMean_pkey" PRIMARY KEY (code);


--
-- Name: communication communication_contactId_purpose_comMeanCode_key; Type: CONSTRAINT; Schema: contact; Owner: maarch
--

ALTER TABLE ONLY contact.communication
    ADD CONSTRAINT "communication_contactId_purpose_comMeanCode_key" UNIQUE ("contactId", purpose, "comMeanCode");


--
-- Name: communication communication_pkey; Type: CONSTRAINT; Schema: contact; Owner: maarch
--

ALTER TABLE ONLY contact.communication
    ADD CONSTRAINT communication_pkey PRIMARY KEY ("communicationId");


--
-- Name: contact contact_pkey; Type: CONSTRAINT; Schema: contact; Owner: maarch
--

ALTER TABLE ONLY contact.contact
    ADD CONSTRAINT contact_pkey PRIMARY KEY ("contactId");


--
-- Name: address address_pkey; Type: CONSTRAINT; Schema: digitalResource; Owner: maarch
--

ALTER TABLE ONLY "digitalResource".address
    ADD CONSTRAINT address_pkey PRIMARY KEY ("resId", "repositoryId");


--
-- Name: clusterRepository clusterRepository_pkey; Type: CONSTRAINT; Schema: digitalResource; Owner: maarch
--

ALTER TABLE ONLY "digitalResource"."clusterRepository"
    ADD CONSTRAINT "clusterRepository_pkey" PRIMARY KEY ("clusterId", "repositoryId");


--
-- Name: cluster cluster_pkey; Type: CONSTRAINT; Schema: digitalResource; Owner: maarch
--

ALTER TABLE ONLY "digitalResource".cluster
    ADD CONSTRAINT cluster_pkey PRIMARY KEY ("clusterId");


--
-- Name: contentType contentType_pkey; Type: CONSTRAINT; Schema: digitalResource; Owner: maarch
--

ALTER TABLE ONLY "digitalResource"."contentType"
    ADD CONSTRAINT "contentType_pkey" PRIMARY KEY (name);


--
-- Name: conversionRule conversionRule_pkey; Type: CONSTRAINT; Schema: digitalResource; Owner: maarch
--

ALTER TABLE ONLY "digitalResource"."conversionRule"
    ADD CONSTRAINT "conversionRule_pkey" PRIMARY KEY ("conversionRuleId");


--
-- Name: conversionRule conversionRule_puid_key; Type: CONSTRAINT; Schema: digitalResource; Owner: maarch
--

ALTER TABLE ONLY "digitalResource"."conversionRule"
    ADD CONSTRAINT "conversionRule_puid_key" UNIQUE (puid);


--
-- Name: digitalResource digitalResource_pkey; Type: CONSTRAINT; Schema: digitalResource; Owner: maarch
--

ALTER TABLE ONLY "digitalResource"."digitalResource"
    ADD CONSTRAINT "digitalResource_pkey" PRIMARY KEY ("resId");


--
-- Name: package package_pkey; Type: CONSTRAINT; Schema: digitalResource; Owner: maarch
--

ALTER TABLE ONLY "digitalResource".package
    ADD CONSTRAINT package_pkey PRIMARY KEY ("packageId");


--
-- Name: repository repository_pkey; Type: CONSTRAINT; Schema: digitalResource; Owner: maarch
--

ALTER TABLE ONLY "digitalResource".repository
    ADD CONSTRAINT repository_pkey PRIMARY KEY ("repositoryId");


--
-- Name: repository repository_repositoryReference_key; Type: CONSTRAINT; Schema: digitalResource; Owner: maarch
--

ALTER TABLE ONLY "digitalResource".repository
    ADD CONSTRAINT "repository_repositoryReference_key" UNIQUE ("repositoryReference");


--
-- Name: repository repository_repositoryUri_key; Type: CONSTRAINT; Schema: digitalResource; Owner: maarch
--

ALTER TABLE ONLY "digitalResource".repository
    ADD CONSTRAINT "repository_repositoryUri_key" UNIQUE ("repositoryUri");


--
-- Name: folder filePlan_name_parentFolderId_key; Type: CONSTRAINT; Schema: filePlan; Owner: maarch
--

ALTER TABLE ONLY "filePlan".folder
    ADD CONSTRAINT "filePlan_name_parentFolderId_key" UNIQUE (name, "parentFolderId");


--
-- Name: folder folder_pkey; Type: CONSTRAINT; Schema: filePlan; Owner: maarch
--

ALTER TABLE ONLY "filePlan".folder
    ADD CONSTRAINT folder_pkey PRIMARY KEY ("folderId");


--
-- Name: eventFormat eventFormat_pkey; Type: CONSTRAINT; Schema: lifeCycle; Owner: maarch
--

ALTER TABLE ONLY "lifeCycle"."eventFormat"
    ADD CONSTRAINT "eventFormat_pkey" PRIMARY KEY (type);


--
-- Name: event event_pkey; Type: CONSTRAINT; Schema: lifeCycle; Owner: maarch
--

ALTER TABLE ONLY "lifeCycle".event
    ADD CONSTRAINT event_pkey PRIMARY KEY ("eventId");


--
-- Name: archivalAgreement archivalAgreement_pkey; Type: CONSTRAINT; Schema: medona; Owner: maarch
--

ALTER TABLE ONLY medona."archivalAgreement"
    ADD CONSTRAINT "archivalAgreement_pkey" PRIMARY KEY ("archivalAgreementId");


--
-- Name: archivalAgreement archivalAgreement_reference_key; Type: CONSTRAINT; Schema: medona; Owner: maarch
--

ALTER TABLE ONLY medona."archivalAgreement"
    ADD CONSTRAINT "archivalAgreement_reference_key" UNIQUE (reference);


--
-- Name: controlAuthority controlAuthority_pkey; Type: CONSTRAINT; Schema: medona; Owner: maarch
--

ALTER TABLE ONLY medona."controlAuthority"
    ADD CONSTRAINT "controlAuthority_pkey" PRIMARY KEY ("originatorOrgUnitId");


--
-- Name: messageComment messageComment_messageId_comment_key; Type: CONSTRAINT; Schema: medona; Owner: maarch
--

ALTER TABLE ONLY medona."messageComment"
    ADD CONSTRAINT "messageComment_messageId_comment_key" UNIQUE ("messageId", comment);


--
-- Name: messageComment messageComment_pkey; Type: CONSTRAINT; Schema: medona; Owner: maarch
--

ALTER TABLE ONLY medona."messageComment"
    ADD CONSTRAINT "messageComment_pkey" PRIMARY KEY ("commentId");


--
-- Name: message message_pkey; Type: CONSTRAINT; Schema: medona; Owner: maarch
--

ALTER TABLE ONLY medona.message
    ADD CONSTRAINT message_pkey PRIMARY KEY ("messageId");


--
-- Name: message message_type_reference_senderOrgRegNumber_key; Type: CONSTRAINT; Schema: medona; Owner: maarch
--

ALTER TABLE ONLY medona.message
    ADD CONSTRAINT "message_type_reference_senderOrgRegNumber_key" UNIQUE (type, reference, "senderOrgRegNumber");


--
-- Name: unitIdentifier unitIdentifier_messageId_objectClass_objectId_key; Type: CONSTRAINT; Schema: medona; Owner: maarch
--

ALTER TABLE ONLY medona."unitIdentifier"
    ADD CONSTRAINT "unitIdentifier_messageId_objectClass_objectId_key" UNIQUE ("messageId", "objectClass", "objectId");


--
-- Name: archivalProfileAccess archivalProfileAccess_pkey; Type: CONSTRAINT; Schema: organization; Owner: maarch
--

ALTER TABLE ONLY organization."archivalProfileAccess"
    ADD CONSTRAINT "archivalProfileAccess_pkey" PRIMARY KEY ("orgId", "archivalProfileReference");


--
-- Name: orgContact orgContact_pkey; Type: CONSTRAINT; Schema: organization; Owner: maarch
--

ALTER TABLE ONLY organization."orgContact"
    ADD CONSTRAINT "orgContact_pkey" PRIMARY KEY ("contactId", "orgId");


--
-- Name: orgType orgType_pkey; Type: CONSTRAINT; Schema: organization; Owner: maarch
--

ALTER TABLE ONLY organization."orgType"
    ADD CONSTRAINT "orgType_pkey" PRIMARY KEY (code);


--
-- Name: organization organization_pkey; Type: CONSTRAINT; Schema: organization; Owner: maarch
--

ALTER TABLE ONLY organization.organization
    ADD CONSTRAINT organization_pkey PRIMARY KEY ("orgId");


--
-- Name: organization organization_registrationNumber_key; Type: CONSTRAINT; Schema: organization; Owner: maarch
--

ALTER TABLE ONLY organization.organization
    ADD CONSTRAINT "organization_registrationNumber_key" UNIQUE ("registrationNumber");


--
-- Name: organization organization_taxIdentifier_key; Type: CONSTRAINT; Schema: organization; Owner: maarch
--

ALTER TABLE ONLY organization.organization
    ADD CONSTRAINT "organization_taxIdentifier_key" UNIQUE ("taxIdentifier");


--
-- Name: servicePosition servicePosition_pkey; Type: CONSTRAINT; Schema: organization; Owner: maarch
--

ALTER TABLE ONLY organization."servicePosition"
    ADD CONSTRAINT "servicePosition_pkey" PRIMARY KEY ("serviceAccountId", "orgId");


--
-- Name: userPosition userPosition_pkey; Type: CONSTRAINT; Schema: organization; Owner: maarch
--

ALTER TABLE ONLY organization."userPosition"
    ADD CONSTRAINT "userPosition_pkey" PRIMARY KEY ("userAccountId", "orgId");


--
-- Name: accessRule accessRule_pkey; Type: CONSTRAINT; Schema: recordsManagement; Owner: maarch
--

ALTER TABLE ONLY "recordsManagement"."accessRule"
    ADD CONSTRAINT "accessRule_pkey" PRIMARY KEY (code);


--
-- Name: archivalProfileContents archivalProfileContents_pkey; Type: CONSTRAINT; Schema: recordsManagement; Owner: maarch
--

ALTER TABLE ONLY "recordsManagement"."archivalProfileContents"
    ADD CONSTRAINT "archivalProfileContents_pkey" PRIMARY KEY ("parentProfileId", "containedProfileId");


--
-- Name: archivalProfile archivalProfile_pkey; Type: CONSTRAINT; Schema: recordsManagement; Owner: maarch
--

ALTER TABLE ONLY "recordsManagement"."archivalProfile"
    ADD CONSTRAINT "archivalProfile_pkey" PRIMARY KEY ("archivalProfileId");


--
-- Name: archivalProfile archivalProfile_reference_key; Type: CONSTRAINT; Schema: recordsManagement; Owner: maarch
--

ALTER TABLE ONLY "recordsManagement"."archivalProfile"
    ADD CONSTRAINT "archivalProfile_reference_key" UNIQUE (reference);


--
-- Name: archiveDescription archiveDescription_pkey; Type: CONSTRAINT; Schema: recordsManagement; Owner: maarch
--

ALTER TABLE ONLY "recordsManagement"."archiveDescription"
    ADD CONSTRAINT "archiveDescription_pkey" PRIMARY KEY ("archivalProfileId", "fieldName");


--
-- Name: archiveRelationship archiveRelationship_pkey; Type: CONSTRAINT; Schema: recordsManagement; Owner: maarch
--

ALTER TABLE ONLY "recordsManagement"."archiveRelationship"
    ADD CONSTRAINT "archiveRelationship_pkey" PRIMARY KEY ("archiveId", "relatedArchiveId", "typeCode");


--
-- Name: archive archive_pkey; Type: CONSTRAINT; Schema: recordsManagement; Owner: maarch
--

ALTER TABLE ONLY "recordsManagement".archive
    ADD CONSTRAINT archive_pkey PRIMARY KEY ("archiveId");


--
-- Name: descriptionClass descriptionClass_pkey; Type: CONSTRAINT; Schema: recordsManagement; Owner: maarch
--

ALTER TABLE ONLY "recordsManagement"."descriptionClass"
    ADD CONSTRAINT "descriptionClass_pkey" PRIMARY KEY (name);


--
-- Name: descriptionField descriptionField_pkey; Type: CONSTRAINT; Schema: recordsManagement; Owner: maarch
--

ALTER TABLE ONLY "recordsManagement"."descriptionField"
    ADD CONSTRAINT "descriptionField_pkey" PRIMARY KEY (name);


--
-- Name: log log_pkey; Type: CONSTRAINT; Schema: recordsManagement; Owner: maarch
--

ALTER TABLE ONLY "recordsManagement".log
    ADD CONSTRAINT log_pkey PRIMARY KEY ("archiveId");


--
-- Name: retentionRule retentionRule_pkey; Type: CONSTRAINT; Schema: recordsManagement; Owner: maarch
--

ALTER TABLE ONLY "recordsManagement"."retentionRule"
    ADD CONSTRAINT "retentionRule_pkey" PRIMARY KEY (code);


--
-- Name: serviceLevel serviceLevel_pkey; Type: CONSTRAINT; Schema: recordsManagement; Owner: maarch
--

ALTER TABLE ONLY "recordsManagement"."serviceLevel"
    ADD CONSTRAINT "serviceLevel_pkey" PRIMARY KEY ("serviceLevelId");


--
-- Name: serviceLevel serviceLevel_reference_key; Type: CONSTRAINT; Schema: recordsManagement; Owner: maarch
--

ALTER TABLE ONLY "recordsManagement"."serviceLevel"
    ADD CONSTRAINT "serviceLevel_reference_key" UNIQUE (reference);


--
-- Name: storageRule storageRule_pkey; Type: CONSTRAINT; Schema: recordsManagement; Owner: maarch
--

ALTER TABLE ONLY "recordsManagement"."storageRule"
    ADD CONSTRAINT "storageRule_pkey" PRIMARY KEY (code);


--
-- Name: audit_event_eventDate_idx; Type: INDEX; Schema: audit; Owner: maarch
--

CREATE INDEX "audit_event_eventDate_idx" ON audit.event USING btree ("eventDate");


--
-- Name: audit_event_instanceName_idx; Type: INDEX; Schema: audit; Owner: maarch
--

CREATE INDEX "audit_event_instanceName_idx" ON audit.event USING btree ("instanceName");


--
-- Name: batchProcessing_logScheduling_schedulingId_idx; Type: INDEX; Schema: batchProcessing; Owner: maarch
--

CREATE INDEX "batchProcessing_logScheduling_schedulingId_idx" ON "batchProcessing"."logScheduling" USING btree ("schedulingId");


--
-- Name: digitalResource_digitalResource_archiveId_idx; Type: INDEX; Schema: digitalResource; Owner: maarch
--

CREATE INDEX "digitalResource_digitalResource_archiveId_idx" ON "digitalResource"."digitalResource" USING btree ("archiveId");


--
-- Name: digitalResource_digitalResource_relatedResId__relationshipType_; Type: INDEX; Schema: digitalResource; Owner: maarch
--

CREATE INDEX "digitalResource_digitalResource_relatedResId__relationshipType_" ON "digitalResource"."digitalResource" USING btree ("relatedResId", "relationshipType");


--
-- Name: filePlan_folder_ownerOrgRegNumber_idx; Type: INDEX; Schema: filePlan; Owner: maarch
--

CREATE INDEX "filePlan_folder_ownerOrgRegNumber_idx" ON "filePlan".folder USING btree ("ownerOrgRegNumber");


--
-- Name: event_objectId_idx; Type: INDEX; Schema: lifeCycle; Owner: maarch
--

CREATE INDEX "event_objectId_idx" ON "lifeCycle".event USING btree ("objectId");


--
-- Name: event_timestamp_idx; Type: INDEX; Schema: lifeCycle; Owner: maarch
--

CREATE INDEX event_timestamp_idx ON "lifeCycle".event USING btree ("timestamp");


--
-- Name: lifeCycle_event_eventType_idx; Type: INDEX; Schema: lifeCycle; Owner: maarch
--

CREATE INDEX "lifeCycle_event_eventType_idx" ON "lifeCycle".event USING btree ("eventType");


--
-- Name: lifeCycle_event_instanceName_idx; Type: INDEX; Schema: lifeCycle; Owner: maarch
--

CREATE INDEX "lifeCycle_event_instanceName_idx" ON "lifeCycle".event USING btree ("instanceName");


--
-- Name: lifeCycle_event_objectClass_idx; Type: INDEX; Schema: lifeCycle; Owner: maarch
--

CREATE INDEX "lifeCycle_event_objectClass_idx" ON "lifeCycle".event USING btree ("objectClass");


--
-- Name: lifeCycle_event_objectClass_objectId_idx; Type: INDEX; Schema: lifeCycle; Owner: maarch
--

CREATE INDEX "lifeCycle_event_objectClass_objectId_idx" ON "lifeCycle".event USING btree ("objectClass", "objectId");


--
-- Name: medona_message_date_idx; Type: INDEX; Schema: medona; Owner: maarch
--

CREATE INDEX medona_message_date_idx ON medona.message USING btree (date);


--
-- Name: medona_message_recipientOrgRegNumber_idx; Type: INDEX; Schema: medona; Owner: maarch
--

CREATE INDEX "medona_message_recipientOrgRegNumber_idx" ON medona.message USING btree ("recipientOrgRegNumber");


--
-- Name: medona_message_status_active_idx; Type: INDEX; Schema: medona; Owner: maarch
--

CREATE INDEX medona_message_status_active_idx ON medona.message USING btree (status, active);


--
-- Name: medona_unitIdentifier_messageId_idx; Type: INDEX; Schema: medona; Owner: maarch
--

CREATE INDEX "medona_unitIdentifier_messageId_idx" ON medona."unitIdentifier" USING btree ("messageId");


--
-- Name: medona_unitIdentifier_objectClass_idx; Type: INDEX; Schema: medona; Owner: maarch
--

CREATE INDEX "medona_unitIdentifier_objectClass_idx" ON medona."unitIdentifier" USING btree ("objectClass", "objectId");


--
-- Name: archive_archivalProfileReference_idx; Type: INDEX; Schema: recordsManagement; Owner: maarch
--

CREATE INDEX "archive_archivalProfileReference_idx" ON "recordsManagement".archive USING btree ("archivalProfileReference");


--
-- Name: archive_disposalDate_idx; Type: INDEX; Schema: recordsManagement; Owner: maarch
--

CREATE INDEX "archive_disposalDate_idx" ON "recordsManagement".archive USING btree ("disposalDate");


--
-- Name: archive_filePlanPosition_idx; Type: INDEX; Schema: recordsManagement; Owner: maarch
--

CREATE INDEX "archive_filePlanPosition_idx" ON "recordsManagement".archive USING btree ("filePlanPosition");


--
-- Name: archive_originatorOrgRegNumber_originatorArchiveId_idx; Type: INDEX; Schema: recordsManagement; Owner: maarch
--

CREATE INDEX "archive_originatorOrgRegNumber_originatorArchiveId_idx" ON "recordsManagement".archive USING btree ("originatorOrgRegNumber", "originatorArchiveId");


--
-- Name: archive_status_idx; Type: INDEX; Schema: recordsManagement; Owner: maarch
--

CREATE INDEX archive_status_idx ON "recordsManagement".archive USING btree (status);


--
-- Name: archive_to_tsvector_idx; Type: INDEX; Schema: recordsManagement; Owner: maarch
--

CREATE INDEX archive_to_tsvector_idx ON "recordsManagement".archive USING gin (to_tsvector('french'::regconfig, translate(text, 'ÀÁÂÃÄÅàáâãäåÆæÞþČčĆćÇçĐđÈÉÊËèéêëÌÍÎÏìíîïÑñÒÓÔÕÖØðòóôõöøœŒŔŕŠšßÙÚÛÜùúûÝýÿŽž'::text, 'AAAAAAaaaaaaAEaeBbCcCcCcDjdjEEEEeeeeIIIIiiiiNnOOOOOOooooooooeOERrSsSsUUUUuuuYyyZz'::text)));


--
-- Name: recordsManagement_archiveRelationship_archiveId_idx; Type: INDEX; Schema: recordsManagement; Owner: maarch
--

CREATE INDEX "recordsManagement_archiveRelationship_archiveId_idx" ON "recordsManagement"."archiveRelationship" USING btree ("archiveId");


--
-- Name: recordsManagement_archiveRelationship_relatedArchiveId_idx; Type: INDEX; Schema: recordsManagement; Owner: maarch
--

CREATE INDEX "recordsManagement_archiveRelationship_relatedArchiveId_idx" ON "recordsManagement"."archiveRelationship" USING btree ("relatedArchiveId");


--
-- Name: recordsManagement_archive_archiverOrgRegNumber_idx; Type: INDEX; Schema: recordsManagement; Owner: maarch
--

CREATE INDEX "recordsManagement_archive_archiverOrgRegNumber_idx" ON "recordsManagement".archive USING btree ("archiverOrgRegNumber");


--
-- Name: recordsManagement_archive_descriptionClass_idx; Type: INDEX; Schema: recordsManagement; Owner: maarch
--

CREATE INDEX "recordsManagement_archive_descriptionClass_idx" ON "recordsManagement".archive USING btree ("descriptionClass");


--
-- Name: recordsManagement_archive_originatingDate_idx; Type: INDEX; Schema: recordsManagement; Owner: maarch
--

CREATE INDEX "recordsManagement_archive_originatingDate_idx" ON "recordsManagement".archive USING btree ("originatingDate");


--
-- Name: recordsManagement_archive_originatorArchiveId_idx; Type: INDEX; Schema: recordsManagement; Owner: maarch
--

CREATE INDEX "recordsManagement_archive_originatorArchiveId_idx" ON "recordsManagement".archive USING btree ("originatorArchiveId");


--
-- Name: recordsManagement_archive_originatorOrgRegNumber_idx; Type: INDEX; Schema: recordsManagement; Owner: maarch
--

CREATE INDEX "recordsManagement_archive_originatorOrgRegNumber_idx" ON "recordsManagement".archive USING btree ("originatorOrgRegNumber");


--
-- Name: recordsManagement_archive_originatorOwnerOrgId_idx; Type: INDEX; Schema: recordsManagement; Owner: maarch
--

CREATE INDEX "recordsManagement_archive_originatorOwnerOrgId_idx" ON "recordsManagement".archive USING btree ("originatorOwnerOrgId");


--
-- Name: recordsManagement_archive_parentArchiveId_idx; Type: INDEX; Schema: recordsManagement; Owner: maarch
--

CREATE INDEX "recordsManagement_archive_parentArchiveId_idx" ON "recordsManagement".archive USING btree ("parentArchiveId");


--
-- Name: privilege privilege_roleId_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: maarch
--

ALTER TABLE ONLY auth.privilege
    ADD CONSTRAINT "privilege_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES auth.role("roleId");


--
-- Name: roleMember roleMember_roleId_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: maarch
--

ALTER TABLE ONLY auth."roleMember"
    ADD CONSTRAINT "roleMember_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES auth.role("roleId");


--
-- Name: roleMember roleMember_userAccountId_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: maarch
--

ALTER TABLE ONLY auth."roleMember"
    ADD CONSTRAINT "roleMember_userAccountId_fkey" FOREIGN KEY ("userAccountId") REFERENCES auth.account("accountId");


--
-- Name: servicePrivilege servicePrivilege_accountId_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: maarch
--

ALTER TABLE ONLY auth."servicePrivilege"
    ADD CONSTRAINT "servicePrivilege_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES auth.account("accountId");


--
-- Name: address address_contactId_fkey; Type: FK CONSTRAINT; Schema: contact; Owner: maarch
--

ALTER TABLE ONLY contact.address
    ADD CONSTRAINT "address_contactId_fkey" FOREIGN KEY ("contactId") REFERENCES contact.contact("contactId");


--
-- Name: communication communication_comMeanCode_fkey; Type: FK CONSTRAINT; Schema: contact; Owner: maarch
--

ALTER TABLE ONLY contact.communication
    ADD CONSTRAINT "communication_comMeanCode_fkey" FOREIGN KEY ("comMeanCode") REFERENCES contact."communicationMean"(code);


--
-- Name: communication communication_contactId_fkey; Type: FK CONSTRAINT; Schema: contact; Owner: maarch
--

ALTER TABLE ONLY contact.communication
    ADD CONSTRAINT "communication_contactId_fkey" FOREIGN KEY ("contactId") REFERENCES contact.contact("contactId");


--
-- Name: address address_repositoryId_fkey; Type: FK CONSTRAINT; Schema: digitalResource; Owner: maarch
--

ALTER TABLE ONLY "digitalResource".address
    ADD CONSTRAINT "address_repositoryId_fkey" FOREIGN KEY ("repositoryId") REFERENCES "digitalResource".repository("repositoryId");


--
-- Name: address address_resId_fkey; Type: FK CONSTRAINT; Schema: digitalResource; Owner: maarch
--

ALTER TABLE ONLY "digitalResource".address
    ADD CONSTRAINT "address_resId_fkey" FOREIGN KEY ("resId") REFERENCES "digitalResource"."digitalResource"("resId");


--
-- Name: clusterRepository clusterRepository_clusterId_fkey; Type: FK CONSTRAINT; Schema: digitalResource; Owner: maarch
--

ALTER TABLE ONLY "digitalResource"."clusterRepository"
    ADD CONSTRAINT "clusterRepository_clusterId_fkey" FOREIGN KEY ("clusterId") REFERENCES "digitalResource".cluster("clusterId");


--
-- Name: clusterRepository clusterRepository_repositoryId_fkey; Type: FK CONSTRAINT; Schema: digitalResource; Owner: maarch
--

ALTER TABLE ONLY "digitalResource"."clusterRepository"
    ADD CONSTRAINT "clusterRepository_repositoryId_fkey" FOREIGN KEY ("repositoryId") REFERENCES "digitalResource".repository("repositoryId");


--
-- Name: digitalResource digitalResource_archiveId_fkey; Type: FK CONSTRAINT; Schema: digitalResource; Owner: maarch
--

ALTER TABLE ONLY "digitalResource"."digitalResource"
    ADD CONSTRAINT "digitalResource_archiveId_fkey" FOREIGN KEY ("archiveId") REFERENCES "recordsManagement".archive("archiveId");


--
-- Name: digitalResource digitalResource_clusterId_fkey; Type: FK CONSTRAINT; Schema: digitalResource; Owner: maarch
--

ALTER TABLE ONLY "digitalResource"."digitalResource"
    ADD CONSTRAINT "digitalResource_clusterId_fkey" FOREIGN KEY ("clusterId") REFERENCES "digitalResource".cluster("clusterId");


--
-- Name: digitalResource digitalResource_relatedResId_fkey; Type: FK CONSTRAINT; Schema: digitalResource; Owner: maarch
--

ALTER TABLE ONLY "digitalResource"."digitalResource"
    ADD CONSTRAINT "digitalResource_relatedResId_fkey" FOREIGN KEY ("relatedResId") REFERENCES "digitalResource"."digitalResource"("resId");


--
-- Name: package package_packageId_fkey; Type: FK CONSTRAINT; Schema: digitalResource; Owner: maarch
--

ALTER TABLE ONLY "digitalResource".package
    ADD CONSTRAINT "package_packageId_fkey" FOREIGN KEY ("packageId") REFERENCES "digitalResource"."digitalResource"("resId");


--
-- Name: packedResource packedResource_packageId_fkey; Type: FK CONSTRAINT; Schema: digitalResource; Owner: maarch
--

ALTER TABLE ONLY "digitalResource"."packedResource"
    ADD CONSTRAINT "packedResource_packageId_fkey" FOREIGN KEY ("packageId") REFERENCES "digitalResource".package("packageId");


--
-- Name: packedResource packedResource_resId_fkey; Type: FK CONSTRAINT; Schema: digitalResource; Owner: maarch
--

ALTER TABLE ONLY "digitalResource"."packedResource"
    ADD CONSTRAINT "packedResource_resId_fkey" FOREIGN KEY ("resId") REFERENCES "digitalResource"."digitalResource"("resId");


--
-- Name: folder folderId_filePlan_fkey; Type: FK CONSTRAINT; Schema: filePlan; Owner: maarch
--

ALTER TABLE ONLY "filePlan".folder
    ADD CONSTRAINT "folderId_filePlan_fkey" FOREIGN KEY ("parentFolderId") REFERENCES "filePlan".folder("folderId");


--
-- Name: position position_filePlan_fkey; Type: FK CONSTRAINT; Schema: filePlan; Owner: maarch
--

ALTER TABLE ONLY "filePlan"."position"
    ADD CONSTRAINT "position_filePlan_fkey" FOREIGN KEY ("folderId") REFERENCES "filePlan".folder("folderId");


--
-- Name: messageComment messageComment_messageId_fkey; Type: FK CONSTRAINT; Schema: medona; Owner: maarch
--

ALTER TABLE ONLY medona."messageComment"
    ADD CONSTRAINT "messageComment_messageId_fkey" FOREIGN KEY ("messageId") REFERENCES medona.message("messageId");


--
-- Name: unitIdentifier unitIdentifier_messageId_fkey; Type: FK CONSTRAINT; Schema: medona; Owner: maarch
--

ALTER TABLE ONLY medona."unitIdentifier"
    ADD CONSTRAINT "unitIdentifier_messageId_fkey" FOREIGN KEY ("messageId") REFERENCES medona.message("messageId");


--
-- Name: archivalProfileAccess archivalProfileAccess_orgId_fkey; Type: FK CONSTRAINT; Schema: organization; Owner: maarch
--

ALTER TABLE ONLY organization."archivalProfileAccess"
    ADD CONSTRAINT "archivalProfileAccess_orgId_fkey" FOREIGN KEY ("orgId") REFERENCES organization.organization("orgId");


--
-- Name: orgContact orgContact_orgId_fkey; Type: FK CONSTRAINT; Schema: organization; Owner: maarch
--

ALTER TABLE ONLY organization."orgContact"
    ADD CONSTRAINT "orgContact_orgId_fkey" FOREIGN KEY ("orgId") REFERENCES organization.organization("orgId");


--
-- Name: organization organization_orgTypeCode_fkey; Type: FK CONSTRAINT; Schema: organization; Owner: maarch
--

ALTER TABLE ONLY organization.organization
    ADD CONSTRAINT "organization_orgTypeCode_fkey" FOREIGN KEY ("orgTypeCode") REFERENCES organization."orgType"(code);


--
-- Name: organization organization_ownerOrgId_fkey; Type: FK CONSTRAINT; Schema: organization; Owner: maarch
--

ALTER TABLE ONLY organization.organization
    ADD CONSTRAINT "organization_ownerOrgId_fkey" FOREIGN KEY ("ownerOrgId") REFERENCES organization.organization("orgId");


--
-- Name: organization organization_parentOrgId_fkey; Type: FK CONSTRAINT; Schema: organization; Owner: maarch
--

ALTER TABLE ONLY organization.organization
    ADD CONSTRAINT "organization_parentOrgId_fkey" FOREIGN KEY ("parentOrgId") REFERENCES organization.organization("orgId");


--
-- Name: userPosition userPosition_orgId_fkey; Type: FK CONSTRAINT; Schema: organization; Owner: maarch
--

ALTER TABLE ONLY organization."userPosition"
    ADD CONSTRAINT "userPosition_orgId_fkey" FOREIGN KEY ("orgId") REFERENCES organization.organization("orgId");


--
-- Name: archivalProfileContents archivalProfileContents_containedProfileId_fkey; Type: FK CONSTRAINT; Schema: recordsManagement; Owner: maarch
--

ALTER TABLE ONLY "recordsManagement"."archivalProfileContents"
    ADD CONSTRAINT "archivalProfileContents_containedProfileId_fkey" FOREIGN KEY ("containedProfileId") REFERENCES "recordsManagement"."archivalProfile"("archivalProfileId");


--
-- Name: archivalProfileContents archivalProfileContents_parentProfileId_fkey; Type: FK CONSTRAINT; Schema: recordsManagement; Owner: maarch
--

ALTER TABLE ONLY "recordsManagement"."archivalProfileContents"
    ADD CONSTRAINT "archivalProfileContents_parentProfileId_fkey" FOREIGN KEY ("parentProfileId") REFERENCES "recordsManagement"."archivalProfile"("archivalProfileId");


--
-- Name: archivalProfile archivalProfile_accessRuleCode_fkey; Type: FK CONSTRAINT; Schema: recordsManagement; Owner: maarch
--

ALTER TABLE ONLY "recordsManagement"."archivalProfile"
    ADD CONSTRAINT "archivalProfile_accessRuleCode_fkey" FOREIGN KEY ("accessRuleCode") REFERENCES "recordsManagement"."accessRule"(code);


--
-- Name: archivalProfile archivalProfile_retentionRuleCode_fkey; Type: FK CONSTRAINT; Schema: recordsManagement; Owner: maarch
--

ALTER TABLE ONLY "recordsManagement"."archivalProfile"
    ADD CONSTRAINT "archivalProfile_retentionRuleCode_fkey" FOREIGN KEY ("retentionRuleCode") REFERENCES "recordsManagement"."retentionRule"(code);


--
-- Name: archiveDescription archiveDescription_archivalProfileId_fkey; Type: FK CONSTRAINT; Schema: recordsManagement; Owner: maarch
--

ALTER TABLE ONLY "recordsManagement"."archiveDescription"
    ADD CONSTRAINT "archiveDescription_archivalProfileId_fkey" FOREIGN KEY ("archivalProfileId") REFERENCES "recordsManagement"."archivalProfile"("archivalProfileId");


--
-- Name: archiveRelationship archiveRelationship_archiveId_fkey; Type: FK CONSTRAINT; Schema: recordsManagement; Owner: maarch
--

ALTER TABLE ONLY "recordsManagement"."archiveRelationship"
    ADD CONSTRAINT "archiveRelationship_archiveId_fkey" FOREIGN KEY ("archiveId") REFERENCES "recordsManagement".archive("archiveId");


--
-- Name: archiveRelationship archiveRelationship_relatedArchiveId_fkey; Type: FK CONSTRAINT; Schema: recordsManagement; Owner: maarch
--

ALTER TABLE ONLY "recordsManagement"."archiveRelationship"
    ADD CONSTRAINT "archiveRelationship_relatedArchiveId_fkey" FOREIGN KEY ("relatedArchiveId") REFERENCES "recordsManagement".archive("archiveId");


--
-- Name: archive archive_accessRuleCode_fkey; Type: FK CONSTRAINT; Schema: recordsManagement; Owner: maarch
--

ALTER TABLE ONLY "recordsManagement".archive
    ADD CONSTRAINT "archive_accessRuleCode_fkey" FOREIGN KEY ("accessRuleCode") REFERENCES "recordsManagement"."accessRule"(code);


--
-- Name: archive archive_parentArchiveId_fkey; Type: FK CONSTRAINT; Schema: recordsManagement; Owner: maarch
--

ALTER TABLE ONLY "recordsManagement".archive
    ADD CONSTRAINT "archive_parentArchiveId_fkey" FOREIGN KEY ("parentArchiveId") REFERENCES "recordsManagement".archive("archiveId");


--
-- PostgreSQL database dump complete
--

