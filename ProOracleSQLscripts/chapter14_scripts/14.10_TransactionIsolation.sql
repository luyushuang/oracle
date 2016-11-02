--- Session A: Serializable transaction to add an additional item

variable o number 
execute :o := &order_id 

execute :d := &discount 
--- Add new ordered item and reduce on-hand inventory
execute :i := &first_item 

execute :q := &item_quantity 

execute :p := get_ListPrice(:i)
  (order_id, line_item_id, product_id, unit_price, discount_price, quantity)
  (:o, 1, :i, :p, :p-(:p*:d), :q) ;

update inventories
   set quantity_on_hand = quantity_on_hand - :q
 where product_id = :i
   and warehouse_id = 1 ;

commit;

pause 

execute :o := &order_id 

execute :s := &status 

   set order_status = :s

       customer, 
       mobile,
       status,
       order_total,
       order_date
  from order_detail_header

select line_item_id, product_name, unit_price, discount_price, quantity, line_item_total 
 where order_id = :o

commit;