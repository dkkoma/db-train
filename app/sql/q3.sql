SELECT SUM(order_items.amount * item_histories.price)
FROM order_items INNER JOIN item_histories ON order_items.item_history_id = item_histories.id
WHERE order_items.order_id = 1;
