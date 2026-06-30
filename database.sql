CREATE DATABASE abc;

USE abc;

-- USERS TABLE
CREATE TABLE users (
                       user_id INT PRIMARY KEY AUTO_INCREMENT,
                       name VARCHAR(100),
                       email VARCHAR(100),
                       password VARCHAR(100)
);

-- PRODUCTS TABLE
CREATE TABLE products (
                          product_id INT PRIMARY KEY AUTO_INCREMENT,
                          name VARCHAR(100),
                          price DOUBLE,
                          image VARCHAR(255)
);

-- CART TABLE
CREATE TABLE cart (
                      cart_id INT PRIMARY KEY AUTO_INCREMENT,
                      user_id INT,
                      product_id INT,
                      quantity INT,
                      FOREIGN KEY (user_id) REFERENCES users(user_id),
                      FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- SAMPLE USERS
INSERT INTO users (name, email, password) VALUES
                                              ('Rohit Kumar', 'rohit@gmail.com', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c'),
                                              ('Anjali Sharma', 'anjali@gmail.com', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c'),
                                              ('Vikram Singh', 'vikram@gmail.com', '9b8769a4a742959a2d0298c36fb70623f2dfacda8436237df08d8dfd5b37374c');

-- SAMPLE PRODUCTS
INSERT INTO products (name, price, image) VALUES
                                              ('iPhone 13', 70000, 'images/product1.jpg'),
                                              ('Samsung Galaxy S21', 60000, 'images/product2.jpg'),
                                              ('Nike Shoes', 5000, 'images/product3.jpg'),
                                              ('HP Laptop', 55000, 'images/product4.jpg'),
                                              ('Backpack', 1500, 'images/product5.jpg');