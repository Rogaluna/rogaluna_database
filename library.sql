/*
 Navicat Premium Data Transfer

 Source Server         : 京东云主机 PostgreSQL
 Source Server Type    : PostgreSQL
 Source Server Version : 130015 (130015)
 Source Host           : 117.72.65.176:5432
 Source Catalog        : rogaluna_database
 Source Schema         : library

 Target Server Type    : PostgreSQL
 Target Server Version : 130015 (130015)
 File Encoding         : 65001

 Date: 11/12/2024 04:04:31
*/


-- ----------------------------
-- Sequence structure for book_comments_comment_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "book_comments_comment_id_seq";
CREATE SEQUENCE "book_comments_comment_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for chapter_comments_comment_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "chapter_comments_comment_id_seq";
CREATE SEQUENCE "chapter_comments_comment_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for tags_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "tags_id_seq";
CREATE SEQUENCE "tags_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Table structure for book_categories
-- ----------------------------
DROP TABLE IF EXISTS "book_categories";
CREATE TABLE "book_categories" (
  "book_id" uuid NOT NULL,
  "category_id" int4 NOT NULL
)
;

-- ----------------------------
-- Records of book_categories
-- ----------------------------
BEGIN;
INSERT INTO "book_categories" ("book_id", "category_id") VALUES ('d83b0679-1785-4202-a8cf-9748b691eabc', 4), ('d83b0679-1785-4202-a8cf-9748b691eabc', 6);
COMMIT;

-- ----------------------------
-- Table structure for book_comments
-- ----------------------------
DROP TABLE IF EXISTS "book_comments";
CREATE TABLE "book_comments" (
  "comment_id" int4 NOT NULL DEFAULT nextval('library.book_comments_comment_id_seq'::regclass),
  "book_id" uuid,
  "user_id" int4,
  "content" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamp(6) DEFAULT now(),
  "rating" int4
)
;

-- ----------------------------
-- Records of book_comments
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for books
-- ----------------------------
DROP TABLE IF EXISTS "books";
CREATE TABLE "books" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "user_id" int4 NOT NULL,
  "created_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP
)
;

-- ----------------------------
-- Records of books
-- ----------------------------
BEGIN;
INSERT INTO "books" ("id", "name", "description", "user_id", "created_at") VALUES ('d83b0679-1785-4202-a8cf-9748b691eabc', '测试书籍', '测试', 5, '2024-12-04 05:33:32.173864');
COMMIT;

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS "categories";
CREATE TABLE "categories" (
  "id" int4 NOT NULL DEFAULT nextval('library.tags_id_seq'::regclass),
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "parent_id" int4
)
;

-- ----------------------------
-- Records of categories
-- ----------------------------
BEGIN;
INSERT INTO "categories" ("id", "name", "parent_id") VALUES (1, 'Root', NULL), (2, '科学技术', 1), (3, '计算机技术', 2), (4, 'C++', 3), (5, 'Unreal Engine', 3), (6, 'HTML', 3), (7, 'Vue', 3), (8, 'Qt', 3);
COMMIT;

-- ----------------------------
-- Table structure for chapter_comments
-- ----------------------------
DROP TABLE IF EXISTS "chapter_comments";
CREATE TABLE "chapter_comments" (
  "comment_id" int4 NOT NULL DEFAULT nextval('library.chapter_comments_comment_id_seq'::regclass),
  "book_id" uuid,
  "chapter_number" int4,
  "user_id" int4,
  "content" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamp(6) DEFAULT now()
)
;

-- ----------------------------
-- Records of chapter_comments
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for chapters
-- ----------------------------
DROP TABLE IF EXISTS "chapters";
CREATE TABLE "chapters" (
  "book_id" uuid NOT NULL,
  "chapter_number" int4 NOT NULL,
  "title" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "word_count" int4,
  "status" varchar(50) COLLATE "pg_catalog"."default" DEFAULT 'published'::character varying,
  "created_at" timestamp(6) DEFAULT now(),
  "updated_at" timestamp(6) DEFAULT now(),
  "group" varchar(255) COLLATE "pg_catalog"."default",
  "file_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Records of chapters
-- ----------------------------
BEGIN;
INSERT INTO "chapters" ("book_id", "chapter_number", "title", "word_count", "status", "created_at", "updated_at", "group", "file_name") VALUES ('d83b0679-1785-4202-a8cf-9748b691eabc', 0, '测试', NULL, 'published', '2024-12-08 02:54:28.243141', '2024-12-08 02:54:28.243141', '', '{b83b936b-1394-4b64-8d76-4d9e776c2d68}');
COMMIT;

-- ----------------------------
-- Table structure for reading_progress
-- ----------------------------
DROP TABLE IF EXISTS "reading_progress";
CREATE TABLE "reading_progress" (
  "user_id" int4 NOT NULL,
  "book_id" uuid NOT NULL,
  "chapter_number" int4,
  "progress_percent" numeric(5,2),
  "last_read_at" timestamp(6) DEFAULT now()
)
;

-- ----------------------------
-- Records of reading_progress
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for user_collections
-- ----------------------------
DROP TABLE IF EXISTS "user_collections";
CREATE TABLE "user_collections" (
  "user_id" int4 NOT NULL,
  "book_id" uuid NOT NULL,
  "created_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP
)
;

-- ----------------------------
-- Records of user_collections
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "book_comments_comment_id_seq"
OWNED BY "book_comments"."comment_id";
SELECT setval('"book_comments_comment_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "chapter_comments_comment_id_seq"
OWNED BY "chapter_comments"."comment_id";
SELECT setval('"chapter_comments_comment_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "tags_id_seq"
OWNED BY "categories"."id";
SELECT setval('"tags_id_seq"', 8, true);

-- ----------------------------
-- Indexes structure for table book_categories
-- ----------------------------
CREATE INDEX "idx_book_tags_book_id" ON "book_categories" USING btree (
  "book_id" "pg_catalog"."uuid_ops" ASC NULLS LAST
);
CREATE INDEX "idx_book_tags_tag_id" ON "book_categories" USING btree (
  "category_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table book_categories
-- ----------------------------
ALTER TABLE "book_categories" ADD CONSTRAINT "book_tags_pkey" PRIMARY KEY ("book_id", "category_id");

-- ----------------------------
-- Checks structure for table book_comments
-- ----------------------------
ALTER TABLE "book_comments" ADD CONSTRAINT "book_comments_rating_check" CHECK (rating >= 1 AND rating <= 5);

-- ----------------------------
-- Primary Key structure for table book_comments
-- ----------------------------
ALTER TABLE "book_comments" ADD CONSTRAINT "book_comments_pkey" PRIMARY KEY ("comment_id");

-- ----------------------------
-- Primary Key structure for table books
-- ----------------------------
ALTER TABLE "books" ADD CONSTRAINT "books_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table categories
-- ----------------------------
CREATE INDEX "idx_tags_parent_id" ON "categories" USING btree (
  "parent_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table categories
-- ----------------------------
ALTER TABLE "categories" ADD CONSTRAINT "tags_name_key" UNIQUE ("name");

-- ----------------------------
-- Primary Key structure for table categories
-- ----------------------------
ALTER TABLE "categories" ADD CONSTRAINT "tags_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table chapter_comments
-- ----------------------------
ALTER TABLE "chapter_comments" ADD CONSTRAINT "chapter_comments_pkey" PRIMARY KEY ("comment_id");

-- ----------------------------
-- Primary Key structure for table chapters
-- ----------------------------
ALTER TABLE "chapters" ADD CONSTRAINT "chapters_pkey" PRIMARY KEY ("book_id", "chapter_number");

-- ----------------------------
-- Primary Key structure for table reading_progress
-- ----------------------------
ALTER TABLE "reading_progress" ADD CONSTRAINT "reading_progress_pkey" PRIMARY KEY ("user_id", "book_id");

-- ----------------------------
-- Indexes structure for table user_collections
-- ----------------------------
CREATE INDEX "idx_user_collections_book_id" ON "user_collections" USING btree (
  "book_id" "pg_catalog"."uuid_ops" ASC NULLS LAST
);
CREATE INDEX "idx_user_collections_user_id" ON "user_collections" USING btree (
  "user_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table user_collections
-- ----------------------------
ALTER TABLE "user_collections" ADD CONSTRAINT "user_collections_pkey" PRIMARY KEY ("user_id", "book_id");

-- ----------------------------
-- Foreign Keys structure for table book_categories
-- ----------------------------
ALTER TABLE "book_categories" ADD CONSTRAINT "book_tags_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "books" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "book_categories" ADD CONSTRAINT "book_tags_tag_id_fkey" FOREIGN KEY ("category_id") REFERENCES "categories" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table book_comments
-- ----------------------------
ALTER TABLE "book_comments" ADD CONSTRAINT "book_comments_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "books" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "book_comments" ADD CONSTRAINT "book_comments_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "account"."users" ("id") ON DELETE SET NULL ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table categories
-- ----------------------------
ALTER TABLE "categories" ADD CONSTRAINT "tags_parent_id_fkey" FOREIGN KEY ("parent_id") REFERENCES "categories" ("id") ON DELETE SET NULL ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table chapter_comments
-- ----------------------------
ALTER TABLE "chapter_comments" ADD CONSTRAINT "chapter_comments_book_id_chapter_number_fkey" FOREIGN KEY ("book_id", "chapter_number") REFERENCES "chapters" ("book_id", "chapter_number") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "chapter_comments" ADD CONSTRAINT "chapter_comments_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "account"."users" ("id") ON DELETE SET NULL ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table chapters
-- ----------------------------
ALTER TABLE "chapters" ADD CONSTRAINT "chapters_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "books" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table reading_progress
-- ----------------------------
ALTER TABLE "reading_progress" ADD CONSTRAINT "reading_progress_book_id_chapter_number_fkey" FOREIGN KEY ("book_id", "chapter_number") REFERENCES "chapters" ("book_id", "chapter_number") ON DELETE SET NULL ON UPDATE NO ACTION;
ALTER TABLE "reading_progress" ADD CONSTRAINT "reading_progress_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "books" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "reading_progress" ADD CONSTRAINT "reading_progress_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "account"."users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table user_collections
-- ----------------------------
ALTER TABLE "user_collections" ADD CONSTRAINT "fk_book" FOREIGN KEY ("book_id") REFERENCES "books" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "user_collections" ADD CONSTRAINT "fk_user" FOREIGN KEY ("user_id") REFERENCES "account"."users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
