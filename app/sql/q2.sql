SELECT SUM(amount)
FROM order_items INNER JOIN items ON order_items.item_id = items.id
WHERE items.name = 'シャツ';
