--매장매출은 주문 
--매장배입은 발주

SELECT frregfinum, sum(payprice) frsales
FROM orders
WHERE state='완료'
AND to_char(orderdate,'YYYY-MM')=''
GROUP BY frrefinum='';