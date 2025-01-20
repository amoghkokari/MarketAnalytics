-- Create tables
CREATE TABLE products (
    category_1 VARCHAR NULL, 
    category_2 VARCHAR NULL, 
    category_3 VARCHAR NULL, 
    category_4 VARCHAR NULL, 
    manufacturer VARCHAR NULL, 
    brand VARCHAR NULL,
    barcode NUMERIC NULL
);

CREATE TABLE users (
    id VARCHAR, 
    created_date DATETIME, 
    birth_date DATETIME NULL, 
    state VARCHAR NULL, 
    language VARCHAR NULL, 
    gender VARCHAR NULL
);

CREATE TABLE transactions (
    receipt_id VARCHAR, 
    purchase_date DATETIME, 
    scan_date DATETIME, 
    store_name VARCHAR, 
    user_id VARCHAR, 
    barcode NUMERIC NULL, 
    final_quantity NUMERIC NULL, 
    final_sale NUMERIC NULL,
    FOREIGN KEY (barcode) REFERENCES products(barcode),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Import CSV files
.mode csv
.import ../data/processed/PRODUCTS_TAKEHOME.csv products
.import ../data/processed/USER_TAKEHOME.csv users
.import ../data/processed/TRANSACTION_TAKEHOME.csv transactions