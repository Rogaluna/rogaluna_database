/*
 Navicat Premium Data Transfer

 Source Server         : 京东云主机 PostgreSQL
 Source Server Type    : PostgreSQL
 Source Server Version : 130015 (130015)
 Source Host           : 117.72.65.176:5432
 Source Catalog        : rogaluna_database
 Source Schema         : account

 Target Server Type    : PostgreSQL
 Target Server Version : 130015 (130015)
 File Encoding         : 65001

 Date: 11/12/2024 04:02:39
*/


-- ----------------------------
-- Type structure for user_authority
-- ----------------------------
DROP TYPE IF EXISTS "user_authority";
CREATE TYPE "user_authority" AS ENUM (
  'normal',
  'admin'
);
ALTER TYPE "user_authority" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for users_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "users_id_seq";
CREATE SEQUENCE "users_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS "users";
CREATE TABLE "users" (
  "id" int4 NOT NULL DEFAULT nextval('account.users_id_seq'::regclass),
  "username" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "password" char(60) COLLATE "pg_catalog"."default",
  "authority" "account"."user_authority" DEFAULT 'normal'::account.user_authority
)
;

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO "users" ("id", "username", "password", "authority") VALUES (5, 'rogaluna', '$2b$10$0KmtfUdEgaxKGfQNkJwDt.yt0xfykICL5KUUNUlH6rsqD.kpTS9gC', 'normal'), (6, 'xedia', '$2b$10$Y5Tyy3Udsg6x6Go259aD0Ov/Q/H5/h5ooi3zx54svqTCkWeDiFnbC', 'normal');
COMMIT;

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
SELECT setval('"users_id_seq"', 7, true);

-- ----------------------------
-- Indexes structure for table users
-- ----------------------------
CREATE UNIQUE INDEX "unique_username" ON "users" USING btree (
  "username" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table users
-- ----------------------------
ALTER TABLE "users" ADD CONSTRAINT "users_username_key" UNIQUE ("username");

-- ----------------------------
-- Primary Key structure for table users
-- ----------------------------
ALTER TABLE "users" ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");
