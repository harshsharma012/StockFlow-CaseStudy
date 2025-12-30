CREATE TABLE companies (
id SERIAL PRIMARY KEY,
name VARCHAR(255) NOT NULL UNIQUE,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE warehouses (
id SERIAL PRIMARY KEY,
company_id INT NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
name VARCHAR(255) NOT NULL,
location TEXT,
is_active BOOLEAN DEFAULT TRUE,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
UNIQUE(company_id, name)
);

CREATE TABLE suppliers (
id SERIAL PRIMARY KEY,
name VARCHAR(255) NOT NULL UNIQUE,
contact_info TEXT,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
id SERIAL PRIMARY KEY,
name VARCHAR(255) NOT NULL,
sku VARCHAR(100) UNIQUE,
description TEXT,
is_bundle BOOLEAN DEFAULT FALSE,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE product_bundles (
bundle_id INT NOT NULL REFERENCES products(id) ON DELETE CASCADE,
product_id INT NOT NULL REFERENCES products(id) ON DELETE CASCADE,
quantity INT NOT NULL DEFAULT 1,
PRIMARY KEY(bundle_id, product_id)
);

CREATE TABLE inventory (
warehouse_id INT NOT NULL REFERENCES warehouses(id) ON DELETE CASCADE,
product_id INT NOT NULL REFERENCES products(id) ON DELETE CASCADE,
quantity INT NOT NULL DEFAULT 0,
last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY(warehouse_id, product_id)
);

CREATE TABLE inventory_history (
id SERIAL PRIMARY KEY,
warehouse_id INT NOT NULL REFERENCES warehouses(id),
product_id INT NOT NULL REFERENCES products(id),
change INT NOT NULL,
reason VARCHAR(255),
changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE product_suppliers (
product_id INT NOT NULL REFERENCES products(id),
supplier_id INT NOT NULL REFERENCES suppliers(id),
supplier_sku VARCHAR(100),
PRIMARY KEY(product_id, supplier_id)
);
