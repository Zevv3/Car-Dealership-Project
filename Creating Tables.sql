CREATE TABLE "sales_service_staff" (
  "staff_id" SERIAL,
  "first_name" VARCHAR(50),
  "last_name" VARCHAR(50),
  "department" VARCHAR(50),
  PRIMARY KEY ("staff_id")
);

CREATE TABLE "vehicle_serviced" (
  "vin" VARCHAR(17),
  "make" VARCHAR(50),
  "model" VARCHAR(50),
  "year" INTEGER,
  "mileage" INTEGER,
  PRIMARY KEY ("vin")
);

CREATE TABLE "mechanic" (
  "mechanic_id" SERIAL,
  "first_name" VARCHAR(50),
  "last_name" VARCHAR(50),
  PRIMARY KEY ("mechanic_id")
);

CREATE TABLE "services" (
  "service_id" SERIAL,
  "name" VARCHAR(50),
  "price" NUMERIC(7,2),
  PRIMARY KEY ("service_id")
);

CREATE TABLE "parts" (
  "parts_id" SERIAL,
  "name" VARCHAR(50),
  "price" NUMERIC(7,2),
  PRIMARY KEY ("parts_id")
);

CREATE TABLE "customer" (
  "customer_id" SERIAL,
  "first_name" VARCHAR(50),
  "last_name" VARCHAR(50),
  "address" VARCHAR(150),
  "email" VARCHAR(100),
  "phone" VARCHAR(14),
  "billing_info" VARCHAR(100),
  PRIMARY KEY ("customer_id")
);

CREATE TABLE "service_ticket" (
  "service_ticket_id" SERIAL,
  "date" DATE,
  "total_cost" NUMERIC(7,2),
  "staff_id" INTEGER,
  "customer_id" INTEGER,
  "vin" VARCHAR(17),
  PRIMARY KEY ("service_ticket_id"),
  FOREIGN KEY ("customer_id")    
	REFERENCES "customer"("customer_id"),
  FOREIGN KEY ("staff_id")    
	REFERENCES "sales_service_staff"("staff_id")
);

-- 
CREATE TABLE "service_mechanics" (
  "service_mechanics_id" SERIAL,
  "mechanic_id" INTEGER,
  "service_ticket_id" INTEGER,
  PRIMARY KEY ("service_mechanics_id"),
  FOREIGN KEY ("service_ticket_id")
    REFERENCES "service_ticket"("service_ticket_id"),
  FOREIGN KEY ("mechanic_id")
    REFERENCES "mechanic"("mechanic_id")
);

CREATE TABLE "service_parts" (
  "service_parts_id" SERIAL,
  "service_id" INTEGER,
  "parts_id" INTEGER,
  "parts_quantity" INTEGER,
  "service_ticket_id" INTEGER,
  PRIMARY KEY ("service_parts_id"),
  FOREIGN KEY ("parts_id")
    REFERENCES "parts"("parts_id"),
  FOREIGN KEY ("service_ticket_id")
    REFERENCES "service_ticket"("service_ticket_id"),
  FOREIGN KEY ("service_id")
    REFERENCES "services"("service_id")
);

-- CREATE TABLE "service_history" (
--   "service_history_id" SERIAL,
--   "service_ticket_id" INTEGER,
--   PRIMARY KEY ("service_history_id"),
--   FOREIGN KEY ("service_ticket_id")
-- 	REFERENCES "service_ticket"("service_ticket_id")
-- );
-- This seems redundant, instead, I'm treating the service_ticket table as the history

CREATE TABLE "vehicle_inventory" (
  "vin" VARCHAR(17),
  "make" VARCHAR(50),
  "model" VARCHAR(50),
  "year" INTEGER,
  "vintage" VARCHAR(10),
  "mileage" INTEGER,
  "price" NUMERIC(9,2),
  PRIMARY KEY ("vin")
);

CREATE TABLE "invoice" (
  "invoice_id" SERIAL,
  "date" DATE,
  "total_cost" NUMERIC(9,2),
  "staff_id" INTEGER,
  "customer_id" INTEGER,
  "vin" VARCHAR(17),
  PRIMARY KEY ("invoice_id"),
  FOREIGN KEY ("staff_id")
    REFERENCES "sales_service_staff"("staff_id"),
  FOREIGN KEY ("customer_id")
    REFERENCES "customer"("customer_id"),
  FOREIGN KEY ("vin")
	REFERENCES "vehicle_inventory"("vin")
);









