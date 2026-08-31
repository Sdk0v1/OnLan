-- =========================================================
-- OnLan Mini Logistics Analytics — Database Schema
-- International freight forwarding: Ukraine -> Europe routes
-- =========================================================

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS drivers;

-- ---------------------------------------------------------
-- Table: drivers
-- ---------------------------------------------------------
CREATE TABLE drivers (
    driver_id     INT PRIMARY KEY,
    driver_name   VARCHAR(100) NOT NULL,
    vehicle_type  VARCHAR(30)  NOT NULL
);

-- ---------------------------------------------------------
-- Table: orders
-- ---------------------------------------------------------
CREATE TABLE orders (
    order_id          INT PRIMARY KEY,
    order_date        DATE            NOT NULL,
    city_from         VARCHAR(50)     NOT NULL, -- origin hub in Ukraine
    city_to           VARCHAR(50)     NOT NULL, -- international destination city
    delivery_type     VARCHAR(20)     NOT NULL,
    weight_kg         DECIMAL(6,2)    NOT NULL,
    delivery_cost     DECIMAL(8,2)    NOT NULL,
    delivery_status   VARCHAR(20)     NOT NULL,
    delivery_days     INT             NOT NULL,
    profit            DECIMAL(8,2)    NOT NULL,
    driver_id         INT             NOT NULL,
    CONSTRAINT fk_driver
        FOREIGN KEY (driver_id)
        REFERENCES drivers (driver_id)
);

-- Relationship: drivers (1) --- (many) orders
-- One driver can be assigned to many orders (One-to-Many).
