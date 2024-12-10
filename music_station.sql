/*
 Navicat Premium Data Transfer

 Source Server         : 京东云主机 PostgreSQL
 Source Server Type    : PostgreSQL
 Source Server Version : 130015 (130015)
 Source Host           : 117.72.65.176:5432
 Source Catalog        : rogaluna_database
 Source Schema         : music_station

 Target Server Type    : PostgreSQL
 Target Server Version : 130015 (130015)
 File Encoding         : 65001

 Date: 11/12/2024 04:05:08
*/


-- ----------------------------
-- Sequence structure for albums_album_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "albums_album_id_seq";
CREATE SEQUENCE "albums_album_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Table structure for albums
-- ----------------------------
DROP TABLE IF EXISTS "albums";
CREATE TABLE "albums" (
  "album_id" char(32) COLLATE "pg_catalog"."default" NOT NULL,
  "album_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "artist" varchar(255) COLLATE "pg_catalog"."default",
  "release_year" int4,
  "genre" varchar(100) COLLATE "pg_catalog"."default",
  "description" varchar(255) COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "albums"."album_id" IS '专辑编号（由服务器计算的md5值）';
COMMENT ON COLUMN "albums"."album_name" IS '专辑名称';
COMMENT ON COLUMN "albums"."artist" IS '艺术家';
COMMENT ON COLUMN "albums"."release_year" IS '发行年份';
COMMENT ON COLUMN "albums"."genre" IS '音乐流派';
COMMENT ON COLUMN "albums"."description" IS '专辑描述';

-- ----------------------------
-- Records of albums
-- ----------------------------
BEGIN;
INSERT INTO "albums" ("album_id", "album_name", "artist", "release_year", "genre", "description", "created_at", "updated_at") VALUES ('2e178b2d43b1615b9e4e2a363bbd0323', 'Pop Candy Wonderland', '削除 (Sakuzyo)', 0, '', '', '2024-12-06 03:57:36.379', '2024-12-06 03:57:36.379'), ('68c1500b30e6eee677314013221dedf4', '曾经陪你一起听过的歌', '桑子', 0, '', '', '2024-12-06 23:18:15.661478', '2024-12-06 23:18:15.661478');
COMMIT;

-- ----------------------------
-- Table structure for content
-- ----------------------------
DROP TABLE IF EXISTS "content";
CREATE TABLE "content" (
  "content_md5" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "size" int8 NOT NULL,
  "created_at" timestamp(6) NOT NULL DEFAULT now()
)
;

-- ----------------------------
-- Records of content
-- ----------------------------
BEGIN;
INSERT INTO "content" ("content_md5", "size", "created_at") VALUES ('9c142049a5a4a2c082bde672b31e5d29', 52424594, '2024-12-06 03:57:36.495587'), ('9d9477eb36bff707857976ca18da2942', 15778985, '2024-12-06 23:18:15.795993');
COMMIT;

-- ----------------------------
-- Table structure for metadata
-- ----------------------------
DROP TABLE IF EXISTS "metadata";
CREATE TABLE "metadata" (
  "uid" uuid NOT NULL DEFAULT gen_random_uuid(),
  "user_id" int4 NOT NULL,
  "content_md5" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "file_type" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "album_id" char(32) COLLATE "pg_catalog"."default" NOT NULL,
  "bitrate" int4 NOT NULL,
  "is_published" bool NOT NULL DEFAULT false,
  "created_at" timestamp(6) NOT NULL DEFAULT now(),
  "updated_at" timestamp(6) NOT NULL DEFAULT now(),
  "music_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "artist" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "duration" int4 NOT NULL
)
;
COMMENT ON COLUMN "metadata"."uid" IS '音乐编号';
COMMENT ON COLUMN "metadata"."user_id" IS '上传者编号';
COMMENT ON COLUMN "metadata"."content_md5" IS '音乐文件Md5值';
COMMENT ON COLUMN "metadata"."file_type" IS '音乐类型';
COMMENT ON COLUMN "metadata"."description" IS '音乐描述';
COMMENT ON COLUMN "metadata"."album_id" IS '所属专辑编号（md5）';
COMMENT ON COLUMN "metadata"."bitrate" IS '音乐文件的码率（以 kbps 为单位）';
COMMENT ON COLUMN "metadata"."is_published" IS '发布状态，表示是私有的还是公共的';
COMMENT ON COLUMN "metadata"."created_at" IS '创建时间';
COMMENT ON COLUMN "metadata"."updated_at" IS '更新时间';
COMMENT ON COLUMN "metadata"."music_name" IS '音乐名称';
COMMENT ON COLUMN "metadata"."artist" IS '艺术家名称';
COMMENT ON COLUMN "metadata"."duration" IS '音频时长';

-- ----------------------------
-- Records of metadata
-- ----------------------------
BEGIN;
INSERT INTO "metadata" ("uid", "user_id", "content_md5", "file_type", "description", "album_id", "bitrate", "is_published", "created_at", "updated_at", "music_name", "artist", "duration") VALUES ('fa469fa8-6f63-4d35-92b3-061635a2c0b3', 5, '9c142049a5a4a2c082bde672b31e5d29', 'flac', '', '2e178b2d43b1615b9e4e2a363bbd0323', 1639, 'f', '2024-12-06 03:57:36.609256', '2024-12-06 03:57:36.609256', 'Lost Memory', '削除 (Sakuzyo)', 255), ('1cc4515a-27b1-4d1c-9349-ca7964309e6b', 5, '9d9477eb36bff707857976ca18da2942', 'flac', '', '68c1500b30e6eee677314013221dedf4', 497, 'f', '2024-12-06 23:18:15.929743', '2024-12-06 23:18:15.929743', '一天一天', '桑子', 253);
COMMIT;

-- ----------------------------
-- Function structure for update_metadata_timestamp
-- ----------------------------
DROP FUNCTION IF EXISTS "update_metadata_timestamp"();
CREATE OR REPLACE FUNCTION "update_metadata_timestamp"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "albums_album_id_seq"
OWNED BY "albums"."album_id";
SELECT setval('"albums_album_id_seq"', 1, false);

-- ----------------------------
-- Primary Key structure for table albums
-- ----------------------------
ALTER TABLE "albums" ADD CONSTRAINT "albums_pkey" PRIMARY KEY ("album_id");

-- ----------------------------
-- Primary Key structure for table content
-- ----------------------------
ALTER TABLE "content" ADD CONSTRAINT "content_pkey" PRIMARY KEY ("content_md5");

-- ----------------------------
-- Primary Key structure for table metadata
-- ----------------------------
ALTER TABLE "metadata" ADD CONSTRAINT "metadata_pkey" PRIMARY KEY ("uid");

-- ----------------------------
-- Foreign Keys structure for table metadata
-- ----------------------------
ALTER TABLE "metadata" ADD CONSTRAINT "fk_content_md5" FOREIGN KEY ("content_md5") REFERENCES "content" ("content_md5") ON DELETE CASCADE ON UPDATE NO ACTION;
