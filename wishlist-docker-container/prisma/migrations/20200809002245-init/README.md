# Migration `20200809002245-init`

This migration has been generated by James at 8/9/2020, 1:22:45 AM.
You can check out the [state of the schema](./schema.prisma) after the migration.

## Database Steps

```sql
CREATE TABLE "public"."Product" (
"id" SERIAL,
"createdAt" timestamp(3)  NOT NULL DEFAULT CURRENT_TIMESTAMP,
"updatedAt" timestamp(3)  NOT NULL ,
"title" text   ,
"image" text   ,
"url" text   ,
PRIMARY KEY ("id"))

CREATE TABLE "public"."Purchase" (
"id" SERIAL,
"createdAt" timestamp(3)  NOT NULL DEFAULT CURRENT_TIMESTAMP,
"updatedAt" timestamp(3)  NOT NULL ,
"price" Decimal(65,30)  NOT NULL ,
"productId" integer   ,
PRIMARY KEY ("id"))

ALTER TABLE "public"."Purchase" ADD FOREIGN KEY ("productId")REFERENCES "public"."Product"("id") ON DELETE SET NULL ON UPDATE CASCADE
```

## Changes

```diff
diff --git schema.prisma schema.prisma
migration ..20200809002245-init
--- datamodel.dml
+++ datamodel.dml
@@ -1,0 +1,27 @@
+datasource db {
+  provider = "postgres"
+  url = "***"
+}
+
+generator prisma_client_js {
+  provider = "prisma-client-js"
+}
+
+model Product {
+  id        Int        @default(autoincrement()) @id
+  createdAt DateTime   @default(now())
+  updatedAt DateTime   @updatedAt
+  title     String?
+  image     String?
+  url       String?
+  purchases Purchase[]
+}
+
+model Purchase {
+  id        Int      @default(autoincrement()) @id
+  createdAt DateTime @default(now())
+  updatedAt DateTime @updatedAt
+  price     Float
+  productId Int?
+  product   Product? @relation(fields: [productId], references: [id])
+}
```

