-- FashionHub — optional schema tweaks (MySQL 8+)

-- Your project already has `orders` (order_id, user_id, total_amount, order_date, status)

-- and `order_items` (order_item_id, order_id, product_id, quantity, price).

-- The Java code matches these column names. Run only what you still need.



-- 1) Member join date (optional; profile "Join date" uses this when present)

-- ALTER TABLE users

--     ADD COLUMN created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;



-- 2) Optional: persist delivery date on orders (not required — app uses order_date + 7 days)

-- ALTER TABLE orders

--     ADD COLUMN delivery_date DATE NULL;



-- If you ever create `order_items` from scratch on a new database, use `price`:

-- CREATE TABLE IF NOT EXISTS order_items (

--     order_item_id INT NOT NULL AUTO_INCREMENT,

--     order_id INT NOT NULL,

--     product_id INT NOT NULL,

--     quantity INT NOT NULL,

--     price DECIMAL(10,2) NOT NULL,

--     PRIMARY KEY (order_item_id),

--     KEY idx_order_items_order (order_id),

--     KEY idx_order_items_product (product_id),

--     CONSTRAINT fk_order_items_order FOREIGN KEY (order_id) REFERENCES orders (order_id)

--         ON DELETE CASCADE,

--     CONSTRAINT fk_order_items_product FOREIGN KEY (product_id) REFERENCES products (product_id)

--         ON DELETE RESTRICT

-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


