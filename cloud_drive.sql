/*
 Navicat Premium Data Transfer

 Source Server         : 京东云主机 PostgreSQL
 Source Server Type    : PostgreSQL
 Source Server Version : 130015 (130015)
 Source Host           : 117.72.65.176:5432
 Source Catalog        : rogaluna_database
 Source Schema         : cloud_drive

 Target Server Type    : PostgreSQL
 Target Server Version : 130015 (130015)
 File Encoding         : 65001

 Date: 11/12/2024 04:03:20
*/


-- ----------------------------
-- Table structure for content
-- ----------------------------
DROP TABLE IF EXISTS "content";
CREATE TABLE "content" (
  "content_md5" char(32) COLLATE "pg_catalog"."default" NOT NULL,
  "size" int8 NOT NULL,
  "created_at" timestamptz(6) DEFAULT CURRENT_TIMESTAMP
)
;

-- ----------------------------
-- Records of content
-- ----------------------------
BEGIN;
INSERT INTO "content" ("content_md5", "size", "created_at") VALUES ('6ec66624397b2b7d24f711274272a162', 36, '2024-11-17 09:29:16.477148+08'), ('e267dae1a621523b77c1e75416cd6c59', 11027, '2024-11-17 09:39:05.652847+08'), ('e11af33ac664040723268a82e7a35b85', 428083, '2024-12-09 22:08:33.585108+08'), ('9c142049a5a4a2c082bde672b31e5d29', 52424594, '2024-12-09 22:10:24.800279+08'), ('e5a8989d5e4d6d86aaa6cd6ab9a65bc6', 11081053, '2024-12-10 06:20:02.654101+08'), ('3c901d3f29c03fe8d923aeb3bc128932', 742033, '2024-12-10 07:29:32.273233+08');
COMMIT;

-- ----------------------------
-- Table structure for metadata
-- ----------------------------
DROP TABLE IF EXISTS "metadata";
CREATE TABLE "metadata" (
  "uid" uuid NOT NULL DEFAULT gen_random_uuid(),
  "user_id" int4,
  "file_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "content_md5" char(32) COLLATE "pg_catalog"."default",
  "parent_uid" uuid,
  "is_directory" bool DEFAULT false,
  "version" int4 DEFAULT 1,
  "created_at" timestamptz(6) DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamptz(6) DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "metadata"."content_md5" IS '文件的MD5值';
COMMENT ON COLUMN "metadata"."parent_uid" IS '父文件夹的uid值';

-- ----------------------------
-- Records of metadata
-- ----------------------------
BEGIN;
INSERT INTO "metadata" ("uid", "user_id", "file_name", "content_md5", "parent_uid", "is_directory", "version", "created_at", "updated_at") VALUES ('96b0ec7e-e2eb-47a1-b4e3-0c47b9743bc1', 5, 'root', NULL, NULL, 'f', 1, '2024-11-16 19:00:26.075872+08', '2024-11-16 19:00:26.075872+08'), ('7132f2c0-d7f8-457e-ad6c-59c12b0f0558', 5, '新建文本文档.json', '6ec66624397b2b7d24f711274272a162', '96b0ec7e-e2eb-47a1-b4e3-0c47b9743bc1', 'f', 1, '2024-11-17 09:29:16.477148+08', '2024-11-17 09:29:16.477148+08'), ('1a96dd4d-a231-4d5f-9104-41a13fdc489d', 5, '功能点与技术挑战评估.xlsx', 'e267dae1a621523b77c1e75416cd6c59', '96b0ec7e-e2eb-47a1-b4e3-0c47b9743bc1', 'f', 1, '2024-11-17 09:39:05.652847+08', '2024-11-17 09:39:05.652847+08'), ('5136895e-26cb-40cb-99d9-f82c23049eaa', 5, '测试重命名', NULL, '96b0ec7e-e2eb-47a1-b4e3-0c47b9743bc1', 'f', 1, '2024-11-16 19:01:31.665031+08', '2024-12-09 14:14:25.286+08'), ('6941501a-ad35-411a-8cfd-7bcfdad37175', 5, 'Arcaea.jpg', 'e11af33ac664040723268a82e7a35b85', '96b0ec7e-e2eb-47a1-b4e3-0c47b9743bc1', 'f', 1, '2024-12-09 22:08:33.585108+08', '2024-12-09 22:08:33.585108+08'), ('276c47dc-fdc9-43ea-a9f6-05425ba3bced', 5, '削除 (Sakuzyo) - Lost Memory.flac', '9c142049a5a4a2c082bde672b31e5d29', '96b0ec7e-e2eb-47a1-b4e3-0c47b9743bc1', 'f', 1, '2024-12-09 22:10:24.800279+08', '2024-12-09 22:10:24.800279+08'), ('3e93e308-ef4e-4b0e-ada7-4502e7902d05', 5, 'ARForest - Flashback.mp3', 'e5a8989d5e4d6d86aaa6cd6ab9a65bc6', '96b0ec7e-e2eb-47a1-b4e3-0c47b9743bc1', 'f', 1, '2024-12-10 06:20:02.654101+08', '2024-12-10 06:20:02.654101+08'), ('709fbcb9-6784-4d97-a5ca-30bfe613b05d', 5, 'Arcaea-咲弥.png', '3c901d3f29c03fe8d923aeb3bc128932', '96b0ec7e-e2eb-47a1-b4e3-0c47b9743bc1', 'f', 1, '2024-12-10 07:29:32.273233+08', '2024-12-10 07:29:32.273233+08'), ('5352bda7-aa87-4f2d-a086-03878f392f23', 6, 'root', NULL, NULL, 'f', 1, '2024-12-10 07:32:03.834843+08', '2024-12-10 07:32:03.834843+08');
COMMIT;

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
ALTER TABLE "metadata" ADD CONSTRAINT "metadata_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "account"."users" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
