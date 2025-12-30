INSERT INTO companies (name) VALUES ('StockFlow');

INSERT INTO warehouses (company_id, name, location) VALUES (1, 'Main Warehouse', 'Pune');

-- Suppliers
INSERT INTO suppliers (name, contact_info) VALUES ('ABC Suppliers', 'abc@suppliers.com');
INSERT INTO suppliers (name, contact_info) VALUES ('XYZ Traders', 'xyz@traders.com');

-- Products
INSERT INTO products (name, sku, description) VALUES ('Laptop', 'LP100', 'High-end laptop');
INSERT INTO products (name, sku, description) VALUES ('Mouse', 'MS200', 'Wireless mouse');
INSERT INTO products (name, sku, description, is_bundle) VALUES ('Laptop Bundle', 'LB300', 'Laptop + Mouse Bundle', TRUE);

-- Product Bundles
INSERT INTO product_bundles (bundle_id, product_id, quantity) VALUES (3, 1, 1); -- Laptop
INSERT INTO product_bundles (bundle_id, product_id, quantity) VALUES (3, 2, 1); -- Mouse

-- Inventory
INSERT INTO inventory (warehouse_id, product_id, quantity) VALUES (1, 1, 50);
INSERT INTO inventory (warehouse_id, product_id, quantity) VALUES (1, 2, 100);

-- Product Suppliers
INSERT INTO product_suppliers (product_id, supplier_id, supplier_sku) VALUES (1, 1, 'ABC-LP100');
INSERT INTO product_suppliers (product_id, supplier_id, supplier_sku) VALUES (2, 2, 'XYZ-MS200');


SELECT w.name AS warehouse, w.location, p.name AS product, i.quantity
FROM inventory i
JOIN warehouses w ON i.warehouse_id = w.id
JOIN products p ON i.product_id = p.id
ORDER BY w.id, p.id;

-- Record inventory change
INSERT INTO inventory_history (warehouse_id, product_id, change, reason) VALUES (1, 1, -5, 'Sale');

-- View inventory history
SELECT * FROM inventory_history;

-- Products and their suppliers
SELECT p.name AS product, s.name AS supplier, ps.supplier_sku
FROM product_suppliers ps
JOIN products p ON ps.product_id = p.id
JOIN suppliers s ON ps.supplier_id = s.id;
