from flask import Flask, render_template, request, redirect
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import and_, select

app = Flask(__name__)

# Configure SQLite database
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///site.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False  # Avoids a warning

# Create SQLAlchemy instance
db = SQLAlchemy(app)

# Model
class Product(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(20), unique=False, nullable=False)
    sku = db.Column(db.String(20), unique=False, nullable=False)
    price = db.Column(db.Integer, nullable=False)

    # repr method represents how one object of this datatable
    # will look like
    def __repr__(self):
        return "Completed"

# Model
class Inventory(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    product_id = db.Column(db.String(20), unique=False, nullable=False)
    quantity = db.Column(db.Integer, nullable=False)
    warehouse_id = db.Column(db.Integer, nullable=False)

    # repr method represents how one object of this datatable
    # will look like
    def __repr__(self):
        return "Completed"

# Model
class Supplier(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(20), unique=False, nullable=False)
    contact_email = db.Column(db.Integer, nullable=False)

    # repr method represents how one object of this datatable
    # will look like
    def __repr__(self):
        return "Completed"

class Company(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(20), unique=False, nullable=False)
    warehouse_id = db.Column(db.String(20), unique=False, nullable=False)
    product_id = db.Column(db.Integer, nullable=False)

    # repr method represents how one object of this datatable
    # will look like
    def __repr__(self):
        return "Completed"

class Warehouse(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(20), unique=False, nullable=False)
    supplier_id = db.Column(db.Integer, nullable=False)
    product_id = db.Column(db.Integer, nullable=False)
    current_stock = db.Column(db.Integer, nullable=False)
    threshold = db.Column(db.Integer, nullable=False)
    days_until_stockout = db.Column(db.Integer, nullable=False)
    company_id = db.Column(db.Integer, nullable=False)

    # repr method represents how one object of this datatable
    # will look like
    def __repr__(self):
        return "Completed"

@app.route('/api/products', methods=['POST'])
def create_product():
    data = request.get_json()
    
    # Create new product
    product = Product(
        name=data['name'],
        sku=data['sku'],
        price=data['price']
    )
    
    db.session.add(product)
    db.session.commit()
    
    # Update inventory count
    inventory = Inventory(
        product_id=product.id,
        warehouse_id=data['warehouse_id'],
        quantity=data['initial_quantity']
    )
    
    db.session.add(inventory)
    db.session.commit()
    
    return {"message": "Product created", "product_id": product.id}

@app.route('/api/companies/<company_id>/alerts/low-stock', methods=['GET'])
def stock_alert(company_id):
    data = db.session.query(Warehouse, Product, Supplier).join(Product, Product.id == Warehouse.product_id).join(Supplier, Supplier.id == Warehouse.supplier_id).all()
    alerts = []
    print(data)
    for warehouse, product, supplier in data:
        print(product.sku)
        alerts.append({"product_id": warehouse.product_id,
      "product_name": product.name,
      "sku": product.sku,
      "warehouse_id": warehouse.id,
      "warehouse_name": warehouse.name,
      "current_stock": warehouse.current_stock,
      "threshold": warehouse.threshold,
      "days_until_stockout": warehouse.days_until_stockout,
      "supplier": {
        "id": warehouse.supplier_id,
        "name": supplier.name,
        "contact_email": supplier.contact_email
}})
    output = {"alerts": alerts, "total_alerts": len(alerts)}
    return output


# Run the app and create database
if __name__ == '__main__':
    with app.app_context():  # Needed for DB operations
        db.create_all()      # Creates the database and tables
    app.run(debug=True)
