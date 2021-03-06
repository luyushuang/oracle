PROMPT 
PROMPT STDDEV function
PROMPT
  col product format A30
  col country format A10
  col region format A10
  col year format 9999
  col week format 99
  col sale format 999999.99
  col receipts format 999999.99
  set lines 120 pages 100
select  year, week,sale,
   stddev (sale) over(
          partition by product, country, region , year 
	  order by Sale desc
      	  rows between unbounded preceding and unbounded following
          ) stddv 
  from sales_fact
  where country in ('Australia')  and product ='Xtend Memory'
order by year, week
/