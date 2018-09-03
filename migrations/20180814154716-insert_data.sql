-- +migrate Up
INSERT INTO customers(name, address) VALUES
('A商事', '東京都'),
('B商会', '埼玉県'),
('C商店', '神奈川県');

INSERT INTO items(name, price) VALUES
('シャツ', 1000),
('パンツ', 950),
('マフラー', 1200),
('ブルゾン', 1800);

INSERT INTO orders(id, order_date, customer_id)
SELECT 1, '2013/10/1', id FROM customers WHERE name = 'A商事';
INSERT INTO order_items(order_id, item_id, amount)
SELECT 1, id, 3 FROM items WHERE name = 'シャツ' UNION ALL
SELECT 1, id, 2 FROM items WHERE name = 'パンツ';

INSERT INTO orders(id, order_date, customer_id)
SELECT 2, '2013/10/1', id FROM customers WHERE name = 'B商会';
INSERT INTO order_items(order_id, item_id, amount)
SELECT 2, id, 1 FROM items WHERE name = 'シャツ' UNION ALL
SELECT 2, id, 10 FROM items WHERE name = 'マフラー' UNION ALL
SELECT 2, id, 5 FROM items WHERE name = 'ブルゾン';

INSERT INTO orders(id, order_date, customer_id)
SELECT 3, '2013/10/1', id FROM customers WHERE name = 'B商会';
INSERT INTO order_items(order_id, item_id, amount)
SELECT 3, id, 80 FROM items WHERE name = 'パンツ';

INSERT INTO orders(id, order_date, customer_id)
SELECT 4, '2013/10/1', id FROM customers WHERE name = 'C商店';
INSERT INTO order_items(order_id, item_id, amount)
SELECT 4, id, 25 FROM items WHERE name = 'マフラー';

-- +migrate Down
DELETE FROM order_items;
DELETE FROM orders;
DELETE FROM items;
DELETE FROM customers;
