-- Create the database
CREATE DATABASE HLD;

-- Use the newly created database
USE HLD;

CREATE TABLE Category (
    category_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    sku VARCHAR(100),
    description VARCHAR(100),
    price DECIMAL(10,2),
    stock INT,
    Category_categ_id INT,
    FOREIGN KEY (Category_categ_id) REFERENCES Category(category_id)
);

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100),
    password VARCHAR(100),
    address VARCHAR(100),
    phone_number VARCHAR(100)
);

CREATE TABLE Wishlist (
    wishlist_id INT PRIMARY KEY,
    Customer_customer_id INT,
    Product_product_id INT,
    FOREIGN KEY (Customer_customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (Product_product_id) REFERENCES Product(product_id)
);

CREATE TABLE Cart (
    cart_id INT PRIMARY KEY,
    quantity INT,
    Customer_customer_id INT,
    Product_product_id INT,
    FOREIGN KEY (Customer_customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (Product_product_id) REFERENCES Product(product_id)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_date DATETIME,
    total_price DECIMAL(10,2),
    customer_id INT,
    payment_id INT,
    shipment_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (payment_id) REFERENCES Payment(payment_id),
    FOREIGN KEY (shipment_id) REFERENCES Shipment(shipment_id)
);

CREATE TABLE Order_Item (
    order_item_id INT PRIMARY KEY,
    quantity INT,
    price DECIMAL(10,2),
    Product_produc INT,
    Order_order_i INT,
    FOREIGN KEY (Product_produc) REFERENCES Product(product_id),
    FOREIGN KEY (Order_order) REFERENCES Orders(order_id)
);

CREATE TABLE Payment (
    payment_id INT PRIMARY KEY,
    payment_date DATETIME,
    payment_method VARCHAR(100),
    amount DECIMAL(10,2),
    Customer_custome INT,
    FOREIGN KEY (Customer_custome) REFERENCES Customer(customer_id)
);

CREATE TABLE Shipment (
    shipment_id INT PRIMARY KEY,
    shipment_date DATETIME,
    address VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(50),
    country VARCHAR(50),
    zip_code VARCHAR(20),
    Customer_custom INT,
    FOREIGN KEY (Customer_custom) REFERENCES Customer(customer_id)
);
