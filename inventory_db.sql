-- Categories table
CREATE TABLE Categories (
    id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(50) NOT NULL,
    description NVARCHAR(MAX)
);

-- Suppliers table
CREATE TABLE Suppliers (
    id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL,
    contact_number NVARCHAR(20),
    email NVARCHAR(100),
    address NVARCHAR(MAX)
);

-- Users table
CREATE TABLE Users (
    id INT PRIMARY KEY IDENTITY(1,1),
    username NVARCHAR(50) NOT NULL UNIQUE,
    password NVARCHAR(255) NOT NULL,
    role NVARCHAR(10) NOT NULL CHECK (role IN ('admin', 'manager', 'staff')),
    email NVARCHAR(100) UNIQUE,
    created_at DATETIME DEFAULT GETDATE()
);

-- Products table
CREATE TABLE Products (
    id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL,
    category_id INT,
    supplier_id INT,
    quantity INT NOT NULL DEFAULT 0,
    reorder_level INT DEFAULT 0,
    price DECIMAL(10,2) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Products_Categories FOREIGN KEY (category_id) REFERENCES Categories(id),
    CONSTRAINT FK_Products_Suppliers FOREIGN KEY (supplier_id) REFERENCES Suppliers(id)
);

-- Customers table
CREATE TABLE Customers (
    id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL,
    email NVARCHAR(100),
    phone NVARCHAR(20),
    address NVARCHAR(MAX)
);

-- Stock_Log table
CREATE TABLE Stock_Log (
    id INT PRIMARY KEY IDENTITY(1,1),
    product_id INT NOT NULL,
    change_type NVARCHAR(10) NOT NULL CHECK (change_type IN ('in', 'out')),
    quantity_changed INT NOT NULL,
    changed_by INT,
    change_date DATETIME DEFAULT GETDATE(),
    notes NVARCHAR(MAX),
    CONSTRAINT FK_StockLog_Products FOREIGN KEY (product_id) REFERENCES Products(id),
    CONSTRAINT FK_StockLog_Users FOREIGN KEY (changed_by) REFERENCES Users(id)
);

-- Purchases table
CREATE TABLE Purchases (
    id INT PRIMARY KEY IDENTITY(1,1),
    product_id INT NOT NULL,
    supplier_id INT NOT NULL,
    quantity INT NOT NULL,
    purchase_date DATETIME DEFAULT GETDATE(),
    unit_cost DECIMAL(10,2) NOT NULL,
    total_cost DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_Purchases_Products FOREIGN KEY (product_id) REFERENCES Products(id),
    CONSTRAINT FK_Purchases_Suppliers FOREIGN KEY (supplier_id) REFERENCES Suppliers(id)
);

-- Sales table
CREATE TABLE Sales (
    id INT PRIMARY KEY IDENTITY(1,1),
    product_id INT NOT NULL,
    customer_id INT,
    quantity_sold INT NOT NULL,
    sale_price DECIMAL(10,2) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    sale_date DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Sales_Products FOREIGN KEY (product_id) REFERENCES Products(id),
    CONSTRAINT FK_Sales_Customers FOREIGN KEY (customer_id) REFERENCES Customers(id)
);

-- Returns table
CREATE TABLE Returns (
    id INT PRIMARY KEY IDENTITY(1,1),
    sale_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity_returned INT NOT NULL,
    return_reason NVARCHAR(MAX),
    return_date DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Returns_Sales FOREIGN KEY (sale_id) REFERENCES Sales(id),
    CONSTRAINT FK_Returns_Products FOREIGN KEY (product_id) REFERENCES Products(id)
);

-- Payments table
CREATE TABLE Payments (
    id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT NOT NULL,
    amount_paid DECIMAL(10,2) NOT NULL,
    payment_date DATETIME DEFAULT GETDATE(),
    payment_method NVARCHAR(50) NOT NULL,
    CONSTRAINT FK_Payments_Customers FOREIGN KEY (customer_id) REFERENCES Customers(id)
);

    --data entry Categories
    INSERT INTO Categories (name, description) VALUES 
    ('Electronics', 'Gadgets and devices'),
    ('Clothing', 'Apparel items'),
    ('Furniture', 'Home furniture'),
    ('Food', 'Groceries');
    
    -- Suppliers
    INSERT INTO Suppliers (name, contact_number, email, address) VALUES 
    ('Tech Supplier', '111-1111', 'tech@example.com', '123 Tech St'),
    ('Clothes Supplier', '222-2222', 'clothes@example.com', '456 Fashion Ave'),
    ('Furniture Supplier', '333-3333', 'furniture@example.com', '789 Home Ln'),
    ('Food Supplier', '444-4444', 'food@example.com', '321 Market Rd');
    
    -- Users
    INSERT INTO Users (username, password, role, email) VALUES 
    ('admin', 'admin123', 'admin', 'admin@store.com'),
    ('manager', 'manager123', 'manager', 'manager@store.com'),
    ('staff1', 'staff123', 'staff', 'staff1@store.com'),
    ('staff2', 'staff123', 'staff', 'staff2@store.com');
    
    -- Products
    INSERT INTO Products (name, category_id, supplier_id, quantity, reorder_level, price) VALUES 
    ('Laptop', 1, 1, 10, 2, 999.99),
    ('T-Shirt', 2, 2, 50, 10, 19.99),
    ('Chair', 3, 3, 5, 1, 149.99),
    ('Bread', 4, 4, 20, 5, 3.99);
    
    -- Customers
    INSERT INTO Customers (name, email, phone, address) VALUES 
    ('John Doe', 'john@email.com', '555-1000', '123 Main St'),
    ('Jane Smith', 'jane@email.com', '555-2000', '456 Oak Ave'),
    ('Bob Johnson', 'bob@email.com', '555-3000', '789 Pine Rd'),
    ('Alice Brown', 'alice@email.com', '555-4000', '321 Elm St');
    
    -- Purchases
    INSERT INTO Purchases (product_id, supplier_id, quantity, unit_cost, total_cost, purchase_date) VALUES 
    (1, 1, 5, 800.00, 4000.00, GETDATE()),
    (2, 2, 20, 15.00, 300.00, GETDATE()),
    (3, 3, 3, 100.00, 300.00, GETDATE()),
    (4, 4, 10, 2.00, 20.00, GETDATE());
    
    -- Stock Log
    INSERT INTO Stock_Log (product_id, change_type, quantity_changed, changed_by, notes) VALUES 
    (1, 'in', 5, 1, 'Initial stock'),
    (2, 'in', 20, 2, 'New shipment'),
    (3, 'in', 3, 3, 'Furniture delivery'),
    (4, 'in', 10, 4, 'Weekly restock');
    
    -- Sales
    INSERT INTO Sales (product_id, customer_id, quantity_sold, sale_price, total_price, sale_date) VALUES 
    (1, 1, 1, 999.99, 999.99, GETDATE()),
    (2, 2, 2, 19.99, 39.98, GETDATE()),
    (3, 3, 1, 149.99, 149.99, GETDATE()),
    (4, 4, 3, 3.99, 11.97, GETDATE());
    
    -- Returns
    INSERT INTO Returns (sale_id, product_id, quantity_returned, return_reason) VALUES 
    (1, 1, 1, 'Defective'),
    (2, 2, 1, 'Wrong size'),
    (3, 3, 1, 'Damaged'),
    (4, 4, 1, 'Expired');
    
    -- Payments
    INSERT INTO Payments (customer_id, amount_paid, payment_method) VALUES 
    (1, 999.99, 'Credit Card'),
    (2, 39.98, 'Cash'),
    (3, 149.99, 'Debit Card'),
    (4, 11.97, 'Mobile Pay');
    
    