--Functions for inserting
-- customers
SELECT *
FROM customer;

CREATE OR REPLACE FUNCTION add_cust(
	_first_name VARCHAR(50),
	_last_name VARCHAR(50),
	_address VARCHAR(150),
	_email VARCHAR(100),
	_phone VARCHAR(14),
	_billing_info VARCHAR(100)
)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO customer(first_name, last_name, address, email, phone, billing_info)
	VALUES(_first_name, _last_name, _address, _email, _phone, _billing_info);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_cust('Kelsey', 'Selvaggi', '2601 Street Rd, Bensalem, PA 19020', 'fake@email.com', 
				'(215)638-2216', 'MasterCard 1234345698572567 123');
SELECT add_cust('John', 'DarkSoul', '260 E Street Rd, Warminster, PA 18974', 'email@Aldi.com',
			   '(855)955-2534', 'MasterCard 1234342849571287 123');

--sales_service_staff
SELECT *
FROM sales_service_staff;

CREATE FUNCTION add_staff(
	_first_name VARCHAR(50),
	_last_name VARCHAR(50),
	_department VARCHAR(50)
)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO sales_service_staff(first_name, last_name, department)
	VALUES(_first_name, _last_name, _department);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_staff('Joe', 'Sutter', 'sales');
SELECT add_staff('Roz', 'TheSlime', 'sales');
SELECT add_staff('Curtis', 'Jackson', 'Service')

-- vehicle inventory
SELECT *
FROM vehicle_inventory;

CREATE FUNCTION add_vehicle_inventory(
	_vin VARCHAR(17),
	_make VARCHAR(50),
	_model VARCHAR(50),
	_year INTEGER,
	_vintage VARCHAR(10),
	_mileage INTEGER,
	_price NUMERIC(9,2)
)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO vehicle_inventory(vin, make, model, year, vintage, mileage, price)
	VALUES(_vin, _make, _model, _year, _vintage, _mileage, _price);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_vehicle_inventory('AN39081HJ28CJM93J', 'MINI', 'Countryman', 2013, 'Used', 60000, 15000.00);
SELECT add_vehicle_inventory('NABCO390OEKMANEJ2', 'Honda', 'Accord', 2022, 'New', 0, 34000.00);

--  invoice
SELECT *
FROM invoice;

CREATE OR REPLACE FUNCTION add_invoice(
	_total_cost NUMERIC(9,2),
	_date DATE,
	_staff_id INTEGER,
	_customer_id INTEGER,
	_vin VARCHAR(17)
)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO invoice(total_cost, date, staff_id, customer_id, vin)
	VALUES(_total_cost, _date, _staff_id, _customer_id, _vin);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_invoice(14500.00, TO_DATE('11/13/2021', 'MM/DD/YYYY'), 1, 2, 'AN39081HJ28CJM93J');
SELECT add_invoice(33500.00, TO_DATE('11/05/2022', 'MM/DD/YYYY'), 2, 1, 'NABCO390OEKMANEJ2');

-- mechanic
SELECT *
FROM mechanic;

CREATE FUNCTION add_mech(
	_first_name VARCHAR(50),
	_last_name VARCHAR(50)
)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO mechanic(first_name, last_name)
	VALUES(_first_name, _last_name);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_mech('Turk', 'Turkleton');
SELECT add_mech('Steve', 'Jobs');

-- parts
SELECT *
FROM parts;

CREATE FUNCTION add_part(
	_name VARCHAR(50),
	_price NUMERIC(7,2)
)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO parts(name, price)
	VALUES(_name, _price);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_part('engine', '5000.00');
SELECT add_part('battery', '100.00');

--service_ticket
SELECT *
FROM service_ticket;

CREATE OR REPLACE FUNCTION add_service_ticket(
	_total_cost NUMERIC(7,2),
	_date DATE,
	_staff_id INTEGER,
	_customer_id INTEGER,
	_vin VARCHAR(17)
)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO service_ticket(total_cost, date, staff_id, customer_id, vin)
	VALUES(_total_cost, _date, _staff_id, _customer_id, _vin);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_service_ticket(1000.00,TO_DATE('03/08/2021', 'MM/DD/YYYY'), 3, 2, 'AN39081HJ28CJM93J');
SELECT add_service_ticket(1200.00,TO_DATE('11/13/2022', 'MM/DD/YYYY'), 3, 1, 'NABCO390OEKMANEJ2');

-- services
SELECT *
FROM services;

CREATE OR REPLACE FUNCTION add_service(
	_name VARCHAR(50),
	_price NUMERIC(7,2)
)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO services(name, price)
	VALUES(_name, _price);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_service('oil change', 25.00);
SELECT add_service('fix car', 400.00);
SELECT add_service('maintenance', 700.00);

--vehicle serviced
SELECT *
FROM vehicle_serviced;

CREATE OR REPLACE FUNCTION add_vehicle_serviced(
	_vin VARCHAR(17),
	_make VARCHAR(50),
	_model VARCHAR(50),
	_year INTEGER,
	_mileage INTEGER
)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO vehicle_serviced(vin, make, model, year, mileage)
	VALUES(_vin, _make, _model, _year, _mileage);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_vehicle_serviced('NABCO390OEKMANEJ2', 'Honda', 'Accord', 2022, 1000);
SELECT add_vehicle_serviced('AN39081HJ28CJM93J', 'MINI', 'Countryman', 2013, 70000);

-- service_history
SELECT *
FROM service_history;

-- CREATE FUNCTION add_history(
-- 	_service_ticket_id INTEGER
-- )
-- RETURNS void
-- AS $MAIN$
-- BEGIN
-- 	INSERT INTO service_history(service_ticket_id)
-- 	VALUES(_service_ticket_id);
-- END;
-- $MAIN$
-- LANGUAGE plpgsql;

-- SELECT add_history(1);
-- SELECT add_history(2);
-- SELECT add_history(3);
-- SELECT add_history(4);

-- service mechanics
SELECT *
FROM service_mechanics;

CREATE FUNCTION add_service_mech(
	_mechanic_id INTEGER,
	_service_ticket_id INTEGER
)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO service_mechanics(mechanic_id, service_ticket_id)
	VALUES(_mechanic_id, _service_ticket_id);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_service_mech(1, 1);
SELECT add_service_mech(2, 1);
SELECT add_service_mech(2, 2);
SELECT add_service_mech(1, 3);
SELECT add_service_mech(2, 4);
SELECT add_service_mech(1, 4);

-- service_parts
SELECT *
FROM service_parts;

CREATE FUNCTION add_service_parts(
	_service_id INTEGER,
	_parts_id INTEGER,
	_parts_quantity INTEGER,
	_service_ticket_id INTEGER
)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO service_parts(service_id, parts_id, parts_quantity, service_ticket_id)
	VALUES(_service_id, _parts_id, _parts_quantity, _service_ticket_id);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_service_parts(3, 2, 1, 3);
SELECT add_service_parts(3, 2, 1, 2);
SELECT add_service_parts(2, 1, 1, 4);
SELECT add_service_parts(1, 2, 1, 1);