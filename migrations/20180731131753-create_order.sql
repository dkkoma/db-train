
-- +migrate Up
CREATE TABLE customers (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  address VARCHAR(255) NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE items (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255),
  price INT NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE orders (
  id INT NOT NULL,
  order_date DATE NOT NULL,
  customer_id INT NOT NULL,
  PRIMARY KEY(id),
  FOREIGN KEY(customer_id) REFERENCES customers(id)
);

CREATE TABLE order_items (
  order_id INT NOT NULL,
  item_id INT NOT NULL,
  amount INT NOT NULL,
  PRIMARY KEY(order_id, item_id),
  FOREIGN KEY(order_id) REFERENCES orders(id),
  FOREIGN KEY(item_id) REFERENCES items(id)
);
-- +migrate Down
DROP TABLE order_items;
DROP TABLE orders;
DROP TABLE items;
DROP TABLE customers;
