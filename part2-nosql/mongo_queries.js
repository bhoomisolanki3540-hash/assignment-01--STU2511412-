// OP1: insertMany() — insert all 3 documents from sample_documents.json
db.products.insertMany([
  { "product_id": "E101", "name": "UltraBook Pro 15", "category": "Electronics", "price": 85000, "attributes": { "warranty_years": 2, "specs": { "ram": "16GB" } } },
  { "product_id": "C202", "name": "Classic Denim Jacket", "category": "Clothing", "price": 3500, "attributes": { "sizes": ["S", "M", "L"] } },
  { "product_id": "G303", "name": "Premium Greek Yogurt", "category": "Groceries", "price": 120, "attributes": { "expiry_date": "2024-12-15" } }
]);

// OP2: find() — retrieve all Electronics products with price > 20000
db.products.find({ 
  "category": "Electronics", 
  "price": { "$gt": 20000 } 
});

// OP3: find() — retrieve all Groceries expiring before 2025-01-01
db.products.find({ 
  "category": "Groceries", 
  "attributes.expiry_date": { "$lt": "2025-01-01" } 
});

// OP4: updateOne() — add a "discount_percent" field to a specific product
db.products.updateOne(
  { "product_id": "E101" },
  { "$set": { "discount_percent": 15 } }
);

// OP5: createIndex() — create an index on category field and explain why
db.products.createIndex({ "category": 1 });
/* EXPLANATION: 
Creating an index on the 'category' field improves query performance. 
Instead of scanning every document in the collection (a 'Collection Scan'), 
MongoDB can jump straight to the relevant entries in the 'Electronics' 
or 'Groceries' categories, making searches much faster as the catalog grows.
*/
