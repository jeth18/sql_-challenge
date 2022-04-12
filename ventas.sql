create table ventas (
  id SERIAL PRIMARY KEY,
  id_product integer references product(id) not null,
  id_user integer references users(id) not null,
  cantidad_solicitada INT not null default 0
);

BEGIN;
  \set product_code 1
  \set product_quantity 10
  \set user_id 1

  -- Validamos que la cantidad que se pida sea mayor a lo que hay y que se encuentre disponible para venta
  SELECT * FROM product WHERE id = :product_code AND CAST (stock as INTEGER) > :product_quantity AND available_for_selling = TRUE;
  
  -- Si se encuentra disponible, se actualiza el stock
  UPDATE product SET stock = CAST(stock as INTEGER) - :product_quantity WHERE id = :product_code;

  -- Se inserta la venta
  INSERT INTO ventas (id_product, id_user, cantidad_solicitada) VALUES (:product_code, :user_id, :product_quantity);

  raise notice 'Value: %', producto;
COMMIT;
