/* Prepare Schema*/
CREATE DATABASE IF NOT EXISTS Sales;

USE Sales;

/* Create Tables */
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email_address VARCHAR(255) NOT NULL,
    number_of_complaints INT DEFAULT 0,
    PRIMARY KEY (customer_id),
    UNIQUE KEY (email_address)
);

CREATE TABLE Companies(
	company_id INT AUTO_INCREMENT,
    company_name VARCHAR(255) NOT NULL,
    headquarters_phone_number VARCHAR(100),
    PRIMARY KEY(company_id)
);

CREATE TABLE Items(
	item_code VARCHAR(10) UNIQUE NOT NULL,
    item VARCHAR(255) NOT NULL,
    unit_price DECIMAL(5,2) NOT NULL,
    company_id INT,
    PRIMARY KEY(item_code),
    FOREIGN KEY(company_id) REFERENCES Companies(company_id) ON DELETE CASCADE
);

CREATE TABLE Sales(
	purchase_number INT AUTO_INCREMENT,
    date_of_purchase DATE NOT NULL,
    customer_id INT,
    item_code VARCHAR(10) NOT NULL,
    PRIMARY KEY (purchase_number),
    FOREIGN KEY(customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (item_code) REFERENCES Items(item_code) ON DELETE CASCADE
);