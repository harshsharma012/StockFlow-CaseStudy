# StockFlow Case Study - Part 2

## Overview
This is Part 2 of the StockFlow B2B inventory management case study.  
In this part, we designed a **database schema** for managing companies, warehouses, products, inventory, suppliers, and product bundles. This schema allows small businesses to track products across multiple warehouses, manage supplier relationships, and maintain inventory history.

---

## Objectives
The main objectives of this part were:

1. **Design a database schema** based on the given requirements:
   - Companies can have multiple warehouses.
   - Products can be stored in multiple warehouses with different quantities.
   - Track when inventory levels change.
   - Suppliers provide products to companies.
   - Some products may be bundles containing other products.

2. **Identify missing requirements** and ask questions for clarification.

3. **Explain design decisions**, including indexes, constraints, and table relationships.

---

## Database Schema
The schema includes the following tables:

- `companies` – Stores company information.  
- `warehouses` – Stores warehouses for each company, including location and status.  
- `products` – Stores individual products and bundles.  
- `product_bundles` – Links bundle products to their components.  
- `inventory` – Tracks product quantities in each warehouse.  
- `inventory_history` – Tracks all inventory changes for auditing.  
- `suppliers` – Stores supplier information.  
- `product_suppliers` – Links products to suppliers.

> Schema files: `schema.sql` (table definitions)  
> Queries: `queries.sql` (sample data insertion and example queries)

---

## Design Decisions
- **Primary Keys & Indexes:** Ensure uniqueness and fast lookup. Composite keys used for `inventory` and `product_bundles`.  
- **Foreign Keys:** Ensure referential integrity between tables.  
- **Timestamps:** Track creation and inventory changes.  
- **Bundles:** Products can be marked as bundles, and their components tracked separately.  
- **Inventory History:** Maintains a full audit trail for all changes.

---

## Sample Queries
- View products in a warehouse.  
- Record inventory changes.  
- List products and their suppliers.  

> See `queries.sql` for detailed examples.

---

## Notes / Gaps Identified
- User roles and access permissions are not defined.  
- Pricing, units, and thresholds (alerts) were not specified.  
- Purchase orders, delivery dates, and lead times for suppliers are not tracked.  

---

This completes **Part 2** of the StockFlow case study.

