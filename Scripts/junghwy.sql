SELECT * FROM HOemp;
CREATE TABLE HOemp (
	eno	number	NOT NULL,
	pass	varchar2(20)	NULL,
	ename	varchar2(20)	NULL,
	dname	varchar2(30)	NULL
);
INSERT INTO HOemp values(0001,'1234','홍길동','관리');

SELECT  * FROM store;
CREATE TABLE store (
	FrRegiNum	varchar2(50)	NOT NULL,
	eno	number	NOT NULL,
	frName	varchar2(50)	NULL,
	frOpen	varchar2(20)	NULL,
	frOperTime	varchar2(20)	NULL,
	frClosedDte	varchar2(20)	NULL,
	frRepName	varchar2(20)	NULL,
	frTel	varchar2(20)	NULL,
	frAddress	varchar2(100)	NULL,
	frPass	varchar2(20)	NULL
);
INSERT INTO store values('fr01',1,'문벅스','9:00','8:00 ~ 23:00','','김세영','02-0221-0322','홍대입구역','1324');

SELECT * FROM storeclerk
WHERE clerkname LIKE '%'||''||'%';
SELECT COUNT(*)
		FROM storeclerk
		WHERE 1=1
		AND clerkname LIKE '%'||''||'%';
select *
	from (
	select rownum cnt, s.*
		from storeclerk s
		where 1=1
		and clerkname LIKE '%'||''||'%'
		AND frreginum = '1234567890'
		AND s.hourlypay != 0)
where cnt between 1 and 20;
	
CREATE TABLE storeClerk (
	clerkNum	varchar2(50)	NOT NULL,
	FrRegiNum	varchar2(50)	NOT NULL,
	clerkName	varchar2(50)	NULL,
	gender	varchar2(10)	NULL,
	residentNum	varchar2(20)	NULL,
	phoneNum	varchar2(20)	NULL,
	address	varchar2(300)	NULL
);
INSERT INTO storeclerk values('0','123456789','김세영','여','940101','010-1100-0011','서울',12000);
INSERT INTO storeclerk values('1','123456789','김중휘','남','960101','010-1111-1111','구의',9800);
INSERT INTO storeclerk values('2','123456789','신아령','여','950202','010-2222-2222','한국');
INSERT INTO storeclerk values('3','123456789','이지원','여','960303','010-3333-3333','한국');
INSERT INTO storeclerk values('4','123456789','이희준','남','970404','010-4444-4444','한국');
INSERT INTO storeclerk values('5','123456789','허다솜','여','970505','010-5555-5555','한국');
INSERT INTO storeclerk values('6','123456789','김재윤','남','960606','010-1111-4444','한국');
INSERT INTO storeclerk values('7','123456789','김다솜','여','960707','010-2312-1111','한국');
INSERT INTO storeclerk values('8','123456789','이준형','남','970808','010-5252-1324','한국');
INSERT INTO storeclerk values(clerkNum_seq.nextval,'fr01','김석준','남','960909','010-5211-1324','한국');

ALTER TABLE storeclerk ADD hourlyPay NUMBER;

UPDATE storeclerk
SET clerkName = '김준형',
	gender = '남',
	residentNum = '970808',
	phoneNum = '010-5252-1324',
	address = '한국'
WHERE clerkNum = '8';

SELECT * FROM storeclerk;

UPDATE storeclerk
SET hourlyPay = 9100;

DELETE FROM storeclerk WHERE clerknum = '29';

SELECT clerkNum FROM storeclerk;

CREATE SEQUENCE clerkNum_seq
	START WITH 9
	MAXVALUE 9999 ;

SELECT * FROM schedule;
CREATE TABLE schedule (
	onDay	date	NULL,
	offDay	date	NULL,
	clerkNum	varchar2(50)	NOT NULL,
	FrRegiNum	varchar2(50)	NOT NULL
);

SELECT * FROM empcheckininfo;
CREATE TABLE empCheckInInfo (
	FrRegiNum	varchar2(50)	NOT NULL,
	clerkNum	varchar2(50)	NOT NULL,
	onTime	date	NULL,
	offTime	date	NULL
);

SELECT * FROM store;

SELECT * FROM PRODUCT;
INSERT INTO product values('pd-frt-0001','과일','사과','본사',1200,'','1ea');
INSERT INTO product values('pd-frt-0002','과일','망고','본사',6000,'','1ea');
INSERT INTO product values('pd-dai-0001','유제품','우유','본사',2500,'','900ml');
INSERT INTO product values('pd-dai-0002','유제품','크림','본사',12000,'','1kg');
INSERT INTO product values('pd-cfb-0001','커피빈','아라비카','본사',7900,'','200g');
INSERT INTO product values('pd-f-0001','과일','사과','본사',1200,'','');
DELETE FROM PRODUCT p WHERE p.PRODUCTNUM ='pd-f-0001';

SELECT * FROM PRODORDER;
INSERT INTO PRODORDER values('fr01-1','pd-frt-0001','store1','본사',to_date('2023-01-11','YYYY-MM-DD'),30,'결제완료','요청');
INSERT INTO PRODORDER values('fr01-2','pd-frt-0001','store1','본사',to_date('2023-02-11','YYYY-MM-DD'),30,'결제완료','완료');
INSERT INTO PRODORDER values('fr01-3','pd-dai-0001','store1','본사',to_date('2023-02-21','YYYY-MM-DD'),10,'미결제','요청');
INSERT INTO PRODORDER values('fr01-4','pd-dai-0002','store1','본사',to_date('2023-02-01','YYYY-MM-DD'),2,'결제완료','완료');
INSERT INTO PRODORDER values('fr01-5','pd-cfb-0001','store1','본사',to_date('2023-02-21','YYYY-MM-DD'),5,'미결제','요청');

SELECT * FROM STOCK;
INSERT INTO STOCK values('pd-frt-0001','fr01',to_date('2023-02-02','YYYY-MM-DD'),50,100,'');
INSERT INTO STOCK values('pd-frt-0002','fr01',to_date('2023-01-30','YYYY-MM-DD'),10,50,'');
INSERT INTO STOCK values('pd-dai-0001','fr01',to_date('2023-02-11','YYYY-MM-DD'),10,100,'');
INSERT INTO STOCK values('pd-dai-0002','fr01',to_date('2023-01-22','YYYY-MM-DD'),5,40,'');
INSERT INTO STOCK values('pd-cfb-0001','fr01',to_date('2023-02-09','YYYY-MM-DD'),30,150,'');

-- 발주신청에 필요한 데이터 컬럼(가맹점번호, 신청날짜, 거래처, 자재명, 수량)
-- 발주신청에 필요한 데이터 테이블(자재, 발주 신청)
SELECT s.FRREGINUM ,po.ORDERDATE ,p.OPPOSITE ,p.PRODUCTNAME ,po.AMOUNT 
FROM PRODUCT p, PRODORDER po, STOCK s 
WHERE p.PRODUCTNUM = po.PRODUCTNUM 
AND p.PRODUCTNUM = s.PRODUCTNUM;

SELECT po.*, p.img, p.PRODUCTNAME, p.CATEGORY, p.OPPOSITE 
FROM PRODUCT p, PRODORDER po
WHERE p.PRODUCTNUM = po.PRODUCTNUM
AND p.PRODUCTNAME LIKE '%'||''||'%' 
AND p.CATEGORY LIKE '%'||''||'%' 
AND to_char(to_date(ORDERDATE,'YYYY-MM-DD HH24:MI:SS'),'MONTH') LIKE '%'||''||'%' 
AND DEMANDER = '1234567890'
ORDER BY to_char(orderdate, 'YYMMDD HH24:MI:SS') DESC;

SELECT to_char(to_date('2023-03-01 11:11:11','YYYY-MM-DD HH24:MI:SS'),'MONTH') FROM dual;

SELECT * FROM ORDERS;

ALTER TABLE orders ADD orderOPTION varchar2(500);

ALTER TABLE orders MODIFY orderdate DATE;

DELETE FROM orders WHERE orderdate LIKE '%'||''||'%'; 

SELECT * FROM store;

SELECT * FROM emp;

SELECT to_char(s.STOCKDATE,'YYYY-MM-dd') ,p.PRODUCTNUM ,p.CATEGORY ,p.PRODUCTNAME ,p.OPPOSITE ,p.PRICE ,p2.AMOUNT ,p2.ORDERSTATE ,p.REMARK 
FROM PRODUCT p , STOCK s , PRODORDER p2 
WHERE p.PRODUCTNUM = s.PRODUCTNUM 
AND p.PRODUCTNUM = p2.PRODUCTNUM 
AND to_char(s.STOCKDATE,'YYYY-MM-dd') = '2023-02-11'
AND p.productNum LIKE '%'||''||'%'
AND category LIKE '%'||''||'%'
AND productName LIKE '%'||''||'%'
AND opposite LIKE '%'||''||'%'
AND orderState LIKE '%'||''||'%';

SELECT DISTINCT category FROM product;

SELECT * FROM clerkschedule;

SELECT TO_DATE('2023-02-12 12:00:00', 'YYYY-MM-DD HH24:MI:SS') FROM dual;
SELECT TO_DATE('2021-12-12', 'YYYY-MM-DD')
     , TO_DATE('2021-12-12 17:10:00', 'YYYY-MM-DD HH24:MI:SS')
  FROM dual;
 
SELECT *
from(
	SELECT rownum cnt, nvl(h.workHOUR,0) workhour, nvl(h.workHOUR * s.hourlypay,0) pay,s.*
	FROM (SELECT CLERKNUM ,sum((to_date(REPLACE(offday, 'T', ''),'YYYY-MM-DD HH24:MI:SS') - to_date(REPLACE(onday, 'T', ''),'YYYY-MM-DD HH24:MI:SS')) * 24) workhour
	FROM clerkschedule
	WHERE to_char(to_date(REPLACE(offday, 'T', ''),'YYYY-MM-DD HH24:MI:SS'),'MONTH') LIKE '%'||''||'%' -- 월 vo에 따로 추가
	GROUP BY CLERKNUM) h, storeclerk s  
	WHERE h.clerknum(+) = s.clerknum
	AND frreginum = '1234567890' -- 세션처리
)
where cnt BETWEEN 11 and 15;
SELECT * FROM STORECLERK s ;
SELECT * FROM CLERKSCHEDULE;
SELECT * FROM CLERKSCHEDULE c2 WHERE CLERKNUM = '12345678901014';
SELECT c.CLERKNAME  ,s.CLERKNUM ,sum((to_date(REPLACE(offday, 'T', ''),'YYYY-MM-DD HH24:MI:SS') - to_date(REPLACE(onday, 'T', ''),'YYYY-MM-DD HH24:MI:SS')) * 24) workhour
	FROM clerkschedule s, STORECLERK c
	WHERE to_char(to_date(REPLACE(offday, 'T', ''),'YYYY-MM-DD HH24:MI:SS'),'MONTH') LIKE '%'||''||'%' -- 월 vo에 따로 추가
	AND c.CLERKNUM = s.CLERKNUM 
	GROUP BY c.CLERKNAME  ,s.CLERKNUM;

SELECT REPLACE(onday, 'T', '') FROM clerkschedule;

INSERT INTO clerkschedule values('2023-02-12T12:00:00','2023-03-02T18:00:00','12345678901001','1234567890');
INSERT INTO clerkschedule values('2023-02-17T11:00:00','2023-02-17T18:00:00','12345678901001','1234567890');
INSERT INTO clerkschedule values('2023-02-22T14:00:00','2023-02-22T18:00:00','12345678901001','1234567890');
INSERT INTO clerkschedule values('2023-02-27T17:00:00','2023-02-27T18:00:00','12345678901001','1234567890');
INSERT INTO clerkschedule values('2023-03-02T08:00:00','2023-03-02T18:00:00','12345678901001','1234567890');
INSERT INTO clerkschedule values('2023-03-10T11:00:00','2023-03-10T18:00:00','12345678901001','1234567890');
INSERT INTO clerkschedule values('2023-03-18T13:00:00','2023-03-18T18:00:00','12345678901001','1234567890');
INSERT INTO clerkschedule values('2023-03-26T10:00:00','2023-03-26T18:00:00','12345678901001','1234567890');
-- ----------
INSERT INTO clerkschedule values('2023-02-12T12:00:00','2023-03-02T18:00:00','12345678901002','1234567890');
INSERT INTO clerkschedule values('2023-02-17T11:00:00','2023-02-17T18:00:00','12345678901002','1234567890');
INSERT INTO clerkschedule values('2023-02-22T14:00:00','2023-02-22T18:00:00','12345678901002','1234567890');
INSERT INTO clerkschedule values('2023-02-27T17:00:00','2023-02-27T18:00:00','12345678901002','1234567890');
INSERT INTO clerkschedule values('2023-03-02T08:00:00','2023-03-02T18:00:00','12345678901002','1234567890');
INSERT INTO clerkschedule values('2023-03-10T11:00:00','2023-03-10T18:00:00','12345678901002','1234567890');
INSERT INTO clerkschedule values('2023-03-18T13:00:00','2023-03-18T18:00:00','12345678901002','1234567890');
INSERT INTO clerkschedule values('2023-03-26T10:00:00','2023-03-26T18:00:00','12345678901002','1234567890');
-- ----------
INSERT INTO clerkschedule values('2023-02-12T11:00:00','2023-03-02T18:00:00','12345678901003','1234567890');
INSERT INTO clerkschedule values('2023-02-17T15:00:00','2023-02-17T18:00:00','12345678901003','1234567890');
INSERT INTO clerkschedule values('2023-02-22T12:00:00','2023-02-22T18:00:00','12345678901003','1234567890');
INSERT INTO clerkschedule values('2023-02-27T11:00:00','2023-02-27T18:00:00','12345678901003','1234567890');
INSERT INTO clerkschedule values('2023-03-02T08:00:00','2023-03-02T18:00:00','12345678901003','1234567890');
INSERT INTO clerkschedule values('2023-03-10T07:00:00','2023-03-10T18:00:00','12345678901003','1234567890');
INSERT INTO clerkschedule values('2023-03-18T12:00:00','2023-03-18T18:00:00','12345678901003','1234567890');
INSERT INTO clerkschedule values('2023-03-26T11:00:00','2023-03-26T18:00:00','12345678901003','1234567890');
-- ---------
INSERT INTO clerkschedule values('2023-02-12T13:00:00','2023-03-02T18:00:00','12345678901004','1234567890');
INSERT INTO clerkschedule values('2023-02-17T12:00:00','2023-02-17T18:00:00','12345678901004','1234567890');
INSERT INTO clerkschedule values('2023-02-22T15:00:00','2023-02-22T18:00:00','12345678901004','1234567890');
INSERT INTO clerkschedule values('2023-02-27T13:00:00','2023-02-27T18:00:00','12345678901004','1234567890');
INSERT INTO clerkschedule values('2023-03-02T02:00:00','2023-03-02T18:00:00','12345678901004','1234567890');
INSERT INTO clerkschedule values('2023-03-10T11:00:00','2023-03-10T18:00:00','12345678901004','1234567890');
INSERT INTO clerkschedule values('2023-03-18T14:00:00','2023-03-18T18:00:00','12345678901004','1234567890');
INSERT INTO clerkschedule values('2023-03-26T16:00:00','2023-03-26T18:00:00','12345678901004','1234567890');
-- ----------
INSERT INTO clerkschedule values('2023-02-12T10:00:00','2023-03-02T18:00:00','12345678901005','1234567890');
INSERT INTO clerkschedule values('2023-02-17T11:00:00','2023-02-17T18:00:00','12345678901005','1234567890');
INSERT INTO clerkschedule values('2023-02-22T12:00:00','2023-02-22T18:00:00','12345678901005','1234567890');
INSERT INTO clerkschedule values('2023-02-27T11:00:00','2023-02-27T18:00:00','12345678901005','1234567890');
INSERT INTO clerkschedule values('2023-03-02T09:00:00','2023-03-02T18:00:00','12345678901005','1234567890');
INSERT INTO clerkschedule values('2023-03-10T10:00:00','2023-03-10T18:00:00','12345678901005','1234567890');
INSERT INTO clerkschedule values('2023-03-18T12:00:00','2023-03-18T18:00:00','12345678901005','1234567890');
INSERT INTO clerkschedule values('2023-03-26T09:00:00','2023-03-26T18:00:00','12345678901005','1234567890');
-- ----------
INSERT INTO clerkschedule values('2023-02-12T07:00:00','2023-03-02T18:00:00','12345678901006','1234567890');
INSERT INTO clerkschedule values('2023-02-17T10:00:00','2023-02-17T18:00:00','12345678901006','1234567890');
INSERT INTO clerkschedule values('2023-02-22T11:00:00','2023-02-22T18:00:00','12345678901006','1234567890');
INSERT INTO clerkschedule values('2023-02-27T12:00:00','2023-02-27T18:00:00','12345678901006','1234567890');
INSERT INTO clerkschedule values('2023-03-02T09:00:00','2023-03-02T18:00:00','12345678901006','1234567890');
INSERT INTO clerkschedule values('2023-03-10T10:00:00','2023-03-10T18:00:00','12345678901006','1234567890');
INSERT INTO clerkschedule values('2023-03-18T11:00:00','2023-03-18T18:00:00','12345678901006','1234567890');
INSERT INTO clerkschedule values('2023-03-26T12:00:00','2023-03-26T18:00:00','12345678901006','1234567890');
INSERT INTO clerkschedule values('2023-03-27T12:30:00','2023-03-27T18:00:00','12345678901006','1234567890');
-- ----------
SELECT rownum cnt, h.workHOUR, nvl(h.workHOUR,0) * s.hourlypay pay,s.*
FROM (SELECT CLERKNUM ,sum((to_date(REPLACE(offday, 'T', ''),'YYYY-MM-DD HH24:MI:SS') - to_date(REPLACE(onday, 'T', ''),'YYYY-MM-DD HH24:MI:SS')) * 24) workhour
FROM clerkschedule
WHERE to_char(to_date(REPLACE(offday, 'T', ''),'YYYY-MM-DD HH24:MI:SS'),'MONTH') LIKE '%'||''||'%' -- 월 vo에 따로 추가
GROUP BY CLERKNUM) h, storeclerk s  
WHERE h.clerknum(+) = s.clerknum
AND frreginum = '1234567890';

SELECT cs.CLERKNUM ,sum((to_date(REPLACE(offday, 'T', ''),'YYYY-MM-DD HH24:MI:SS') - to_date(REPLACE(onday, 'T', ''),'YYYY-MM-DD HH24:MI:SS')) * 24) workhour
FROM clerkschedule cs, STORECLERK s 
WHERE cs.CLERKNUM = s.CLERKNUM
GROUP BY cs.CLERKNUM;

SELECT 
SELECT s.CLERKNUM ,sum((to_date(REPLACE(offday, 'T', ''),'YYYY-MM-DD HH24:MI:SS') - to_date(REPLACE(onday, 'T', ''),'YYYY-MM-DD HH24:MI:SS')) * 24) workhour
FROM CLERKSCHEDULE c ,STORECLERK s 
WHERE c.CLERKNUM = s.CLERKNUM 
GROUP BY s.CLERKNUM;

SELECT c.ONDAY ,s.* 
FROM CLERKSCHEDULE c , STORECLERK s 
WHERE c.FRREGINUM = s.FRREGINUM(+)
AND c.CLERKNUM = s.CLERKNUM ;

SELECT * from(
	SELECT rownum cnt, c.* 
	FROM CLERKFILE c
	WHERE CLERKNUM LIKE '%'||''||'%'
	AND FRREGINUM like '%'||''||'%');

DELETE FROM CLERKFILE c WHERE fname = '테스트';

INSERT INTO CLERKFILE values('',sysdate,sysdate,'','','');

SELECT *
	FROM (
	SELECT rownum cnt, s.*
		FROM storeclerk s,
		emp e
		WHERE 1=1
		AND clerkname LIKE '%'||''||'%'
		AND frreginum = '9999999999')
WHERE cnt BETWEEN 1 AND 5;

SELECT * FROM emp;

SELECT * FROM PRODORDER p WHERE DEMANDER = '9999999999';

SELECT p2.DEMANDER , p2.ORDERSTATE, s.PRODUCTNUM ,p.PRODUCTNAME  
FROM PRODUCT p, PRODORDER p2 , STOCK s 
WHERE p.PRODUCTNUM = s.PRODUCTNUM 
AND p2.PRODUCTNUM = p.PRODUCTNUM
AND p2.PRODUCTNUM = s.PRODUCTNUM;

ALTER TABLE clerkfile ADD fileInfo varchar2(30);

UPDATE CLERKFILE 
	SET UPTDTE = SYSDATE,
		fileinfo = '파일설명'
WHERE FNAME ='스크린샷 2023-03-06 오후 11.21.40.png'
AND CLERKNUM = '12345678901001'
AND FRREGINUM  = '1234567890';

DELETE FROM clerkfile 
WHERE FNAME ='스크린샷 2023-03-06 오후 11.21.40.png'
AND CLERKNUM = '12345678901001'
AND FRREGINUM  = '1234567890';

SELECT to_char(rcv_dt,'YYYY-MM-DD HH24:MI:SS') as rcv_dt FROM dual;

SELECT * FROM DEFECTORDER d ;

SELECT * FROM PRODORDER p ;

INSERT INTO DEFECTORDER values('1','2303051234567891','PD10001',sysdate,'','처리중','교환',to_date('2023-03-05 17:56:30','yyyy-mm-dd hh24:mi:ss'),'1234567891');
INSERT INTO DEFECTORDER values('2','2303051234567891','PD10002',sysdate,'','처리중','교환',to_date('2023-03-05 17:56:31','yyyy-mm-dd hh24:mi:ss'),'1234567891');

ALTER TABLE DEFECTORDER ADD type varchar2(30);
ALTER TABLE DEFECTORDER ADD completeDate date;

UPDATE DEFECTORDER
SET TYPE = '오배송'
WHERE STATE  = '처리중';

SELECT nvl(sum(payprice),0) allfrsales
FROM orders
WHERE state='완료'
AND to_char(orderdate, 'YYYY/MM/DD')=to_char(sysdate,'YYYY/MM/DD');

SELECT nvl(sum(payprice),0) allfrsales
		FROM orders
		WHERE state='완료'
		AND to_char(orderdate, 'YYYY/MM')=to_char(add_months(SYSDATE, -1),'YYYY/MM');

SELECT nvl(sum(PAYPRICE),0) 
FROM orders 
WHERE to_char(orderdate, 'YYYY/MM/DD') = to_char(SYSDATE,'YYYY/MM/DD') 
AND state = '완료'
AND FRREGINUM = '1234567890';

SELECT nvl(sum(PAYPRICE),0) FROM ORDERS 
WHERE state = '완료'
AND FRREGINUM = '1234567890'
AND to_char(orderdate, 'YYYY/MM/DD') BETWEEN to_char(sysdate, 'YYYY/MM/DD') AND to_char(sysdate-7, 'YYYY/MM/DD');

SELECT * FROM orders WHERE ORDERDATE >= TO_CHAR(SYSDATE-7,'YYYYMMDD');

SELECT nvl(sum(PAYPRICE),0)
FROM (
SELECT TO_CHAR(SYSDATE-LEVEL+1, 'YYYYMMDD') od
  FROM DUAL CONNECT BY LEVEL <= 10) d, orders o
WHERE d.od = o.orderdate;

SELECT DISTINCT TO_CHAR(SYSDATE-LEVEL+1, 'YYYYMMDD') od
FROM ORDERS CONNECT BY LEVEL <= 10;

SELECT DISTINCT TO_CHAR(SYSDATE-LEVEL+1, 'YYYYMMDD') od
FROM ORDERS CONNECT BY LEVEL <= 7
ORDER BY od DESC ;

SELECT to_char(orderdate, 'YYYYMMDD') ord, nvl(sum(PAYPRICE),0) tsum, FRREGINUM 
FROM ORDERS
WHERE state = '완료'
GROUP BY to_char(orderdate, 'YYYYMMDD'),FRREGINUM
ORDER BY to_char(orderdate, 'YYYYMMDD');

SELECT nvl(tot,0) AS tot, b.orderdate
FROM (
	SELECT to_char(orderdate, 'YYYY/MM/DD') ord, nvl(sum(PAYPRICE),0) tot
	FROM ORDERS
	WHERE state = '완료'
	AND frreginum = '1234567890'
	GROUP BY to_char(orderdate, 'YYYY/MM/DD')) a,
	(SELECT DISTINCT TO_CHAR(SYSDATE-LEVEL+1, 'YYYY/MM/DD') orderdate
	FROM ORDERS CONNECT BY LEVEL <= 7
	ORDER BY orderdate DESC) b
WHERE a.ord(+) = b.orderdate
ORDER BY orderdate DESC;

SELECT p.PRODUCTNUM, CATEGORY , PRODUCTNAME , OPPOSITE , PRICE , IMG , p.REMARK  , frreginum, stockdate, applyamount, remainamount 
		FROM STOCK s , PRODUCT p 
		WHERE STOCKDATE IN 
			(SELECT max(STOCKDATE) FROM stock GROUP BY PRODUCTNUM)
		AND p.PRODUCTNUM = s.PRODUCTNUM 
		AND PRODUCTNAME LIKE '%'||''||'%'
		AND FRREGINUM = '9999999999';
	
SELECT * FROM stock;

SELECT * FROM ORDERS o WHERE FRREGINUM = '1234567892';

SELECT e.ONTIME, e.CLERKNUM 
FROM STORECLERK s ,EMPCHECKIN e 
WHERE s.FRREGINUM = e.FRREGINUM
AND s.CLERKNUM = e.CLERKNUM
AND s.FRREGINUM = '1234567891'
AND to_char(to_date(ontime,'YYYY-MM-DD HH24:MI:SS'),'MMDD') = '0303';

SELECT * FROM STORECLERK s WHERE FRREGINUM = '1234567892';
SELECT * FROM EMPCHECKIN e  WHERE FRREGINUM = '1234567890';

SELECT to_char(to_date(sysdate,'YYYY-MM-DD HH24:MI:SS'),'MMDD') FROM dual;

SELECT to_char(ontime, 'HH24:MI:SS') ontime, to_char(offtime, 'HH24:MI:SS') offtime,clerkName FROM (
SELECT e.ONTIME,e.offtime, e.CLERKNUM 
FROM STORECLERK s ,EMPCHECKIN e 
WHERE s.FRREGINUM = e.FRREGINUM
AND s.CLERKNUM = e.CLERKNUM
AND to_char(to_date(ontime,'YYYY-MM-DD HH24:MI:SS'),'MM/DD') = to_char(sysdate,'MM/DD')) a, storeclerk s
WHERE a.clerknum(+) = s.CLERKNUM 
AND s.FRREGINUM = '1234567890'
ORDER BY s.CLERKNUM ASC;

-- defnum, ordernum, productnum, applydate, img, state, methods, orderdate, frreginum, type, completedate

SELECT count(*)+101
FROM DEFECTORDER d
WHERE FRREGINUM = '1234567891';

--신청건에 대한 상태 조회 가능
--→ 발주 번호, 자재명, 종류, 처리방식, 첨부 이미지, 
--신청 상태(처리 대기/처리 완료), 신청일, 처리일(완료 시)

SELECT d.DEFNUM ,p.ORDERNUM, p2.productName, p2.CATEGORY, d.METHODS, d.IMG, d.STATE, d.APPLYDATE,p.ORDERDATE ,d.frreginum
FROM DEFECTORDER d, PRODORDER p, PRODUCT p2 
WHERE d.ORDERNUM = p.ORDERNUM 
AND d.ORDERDATE = p.ORDERDATE 
AND p.PRODUCTNUM = p2.PRODUCTNUM 
AND frreginum = '1234567890'
AND p2.PRODUCTNAME  LIKE '%'||''||'%'
AND p2.CATEGORY  LIKE '%'||''||'%'
AND to_char(to_date(d.APPLYDATE ,'YYYY-MM-DD HH24:MI:SS'),'MONTH') LIKE '%'||''||'%' ;

SELECT d.*,p.*,p2.*
FROM DEFECTORDER d, PRODORDER p, PRODUCT p2 
WHERE d.PRODUCTNUM = p2.PRODUCTNUM
AND d.ORDERDATE = p.ORDERDATE ;

SELECT * FROM DEFECTORDER ;
SELECT * FROM PRODORDER p WHERE DEMANDER = '1234567890';

DELETE FROM DEFECTORDER d WHERE ORDERDATE = to_date('2023-03-13 20:50:04','yyyy-MM-dd HH24:MI:SS');

UPDATE DEFECTORDER 
	SET img = 'missingfew.png'
WHERE img = 'test22.png';

SELECT * FROM PRODUCT p ;
SELECT to_date('2023-03-05 17:56:31','yyyy-MM-dd HH24:MI:SS') FROM DEFECTORDER d ;

SELECT * FROM CLERKFILE c ;

SELECT * FROM CLERKSCHEDULE c ;

DELETE FROM CLERKFILE c ;

SELECT * FROM EMPCHECKIN e WHERE CLERKNUM = '12345678901005';

SELECT *
from(
	SELECT rownum cnt, a.* FROM (
		SELECT nvl(TRUNC(h.workHOUR,1),0) workhour, nvl(TRUNC(h.workHOUR * s.hourlypay,-2),0) pay,s.*
		FROM (SELECT CLERKNUM ,sum((OFFTIME-ONTIME) * 24) workhour
		FROM EMPCHECKIN e 
		WHERE to_char(to_date(OFFTIME ,'YYYY-MM-DD HH24:MI:SS'),'MONTH') LIKE '%'||''||'%' -- 월 vo에 따로 추가
		AND EXTRACT(YEAR FROM OFFTIME) LIKE '%'||'22'||'%' -- 년 vo에 따로 추가
		GROUP BY CLERKNUM) h, storeclerk s  
		WHERE h.clerknum(+) = s.clerknum
		AND frreginum = '1234567890' -- 세션처리
		ORDER BY s.clerknum
	) a
)
where cnt BETWEEN 1 and 15;
SELECT * FROM EMPCHECKIN e ;
SELECT EXTRACT(YEAR FROM OFFTIME) 
FROM EMPCHECKIN
WHERE EXTRACT(YEAR FROM OFFTIME) = '2023';

SELECT * FROM STORECLERK s ;
SELECT * FROM CLERKSCHEDULE;
SELECT * FROM CLERKSCHEDULE c2 WHERE CLERKNUM = '12345678901014';

SELECT CLERKNUM ,sum((OFFTIME-ONTIME) * 24) workhour
	FROM EMPCHECKIN e 
	WHERE to_char(to_date(OFFTIME ,'YYYY-MM-DD HH24:MI:SS'),'MONTH') LIKE '%'||''||'%' -- 월 vo에 따로 추가
	GROUP BY CLERKNUM
ORDER BY clerknum;

SELECT * FROM STORECLERK s ;
SELECT OFFTIME FROM EMPCHECKIN e; 
SELECT OFFTIME  FROM EMPCHECKIN e
WHERE to_char(to_date(OFFTIME ,'YYYY-MM-DD HH24:MI:SS'),'MONTH') LIKE '%'||'3'||'%';

	SELECT nvl(h.workHOUR,0) workhour, nvl(TRUNC(h.workHOUR * s.hourlypay,-2),0) pay,s.*
		FROM (SELECT CLERKNUM ,sum((OFFTIME-ONTIME) * 24) workhour
		FROM EMPCHECKIN e 
		WHERE to_char(to_date(OFFTIME ,'YYYY-MM-DD HH24:MI:SS'),'MONTH') LIKE '%'||''||'%' -- 월 vo에 따로 추가
		GROUP BY CLERKNUM) h, storeclerk s  
		WHERE h.clerknum(+) = s.clerknum
		AND frreginum = '1234567890' -- 세션처리
		ORDER BY s.clerknum;
		
SELECT * FROM PRODORDER p WHERE ORDERNUM = '202303061234567890';
UPDATE PRODORDER
	SET ORDERNUM = '2303061234567890'
WHERE ORDERNUM = '202303061234567890'
AND PRODUCTNUM = 'PD10002'
AND DEMANDER = '1234567890';
SELECT * FROM PRODUCT p ;

SELECT * FROM DEFECTORDER ;

ALTER TABLE DEFECTORDER DROP COLUMN methods;

SELECT po.*, p.img, p.PRODUCTNAME, p.CATEGORY, p.OPPOSITE 
FROM PRODUCT p, PRODORDER po 
WHERE p.PRODUCTNUM = po.PRODUCTNUM
AND p.PRODUCTNAME LIKE '%'||''||'%' 
AND p.CATEGORY LIKE '%'||''||'%'
AND to_char(to_date(ORDERDATE,'YYYY-MM-DD HH24:MI:SS'),'MONTH') LIKE '%'||''||'%' 
AND DEMANDER = '1234567890'
ORDER BY to_char(orderdate, 'YYMMDD HH24:MI:SS') DESC;

SELECT po.*, p.img, p.PRODUCTNAME, p.CATEGORY, p.OPPOSITE , s.REMAINAMOUNT 
FROM PRODUCT p, PRODORDER po, STOCK s 
WHERE p.PRODUCTNUM = po.PRODUCTNUM
AND s.PRODUCTNUM = p.PRODUCTNUM
AND STOCKDATE IN (SELECT max(STOCKDATE) FROM stock GROUP BY PRODUCTNUM)
AND p.PRODUCTNAME LIKE '%'||''||'%' 
AND p.CATEGORY LIKE '%'||''||'%'
AND to_char(to_date(ORDERDATE,'YYYY-MM-DD HH24:MI:SS'),'MONTH') LIKE '%'||''||'%' 
AND DEMANDER = '1234567890'
ORDER BY to_char(orderdate, 'YYMMDD HH24:MI:SS') DESC;

SELECT * 
FROM PRODUCT p, STOCK s 
WHERE p.PRODUCTNUM = s.PRODUCTNUM 
AND STOCKDATE IN (SELECT max(STOCKDATE) FROM stock GROUP BY PRODUCTNUM);

SELECT * FROM STORECLERK s ;

SELECT * FROM PRODUCT p ;

SELECT * FROM PRODORDER p WHERE DEMANDER = '1234567890' AND PRODUCTNUM = 'PD10001';

UPDATE PRODORDER
	SET orderState = '배송중'
WHERE ordernum = '2303151234567890'
AND productnum = 'PD10001'
AND orderdate = to_date('2023-03-15 18:44:57','YYYY-MM-DD HH24:MI:SS');

SELECT * 
FROM PRODORDER
WHERE DEMANDER = '1234567890'
AND ORDERNUM  = '2303151234567890'
AND PRODUCTNUM = 'PD10002'
AND ORDERDATE =to_date('2023-03-15 18:44:46','YYYY-MM-DD HH24:MI:SS')
;

UPDATE PRODORDER
	SET ORDERSTATE = '배송중'
WHERE DEMANDER = '1234567890'
AND ORDERNUM  = '2303151234567890'
AND PRODUCTNUM = 'PD10002'
AND ORDERDATE =to_date('2023-03-15 18:44:46','YYYY-MM-DD HH24:MI:SS')
;

SELECT nvl(h.workHOUR,0) workhour, nvl(TRUNC(h.workHOUR * s.hourlypay,-2),0) pay,s.*
FROM (SELECT CLERKNUM ,sum((OFFTIME-ONTIME) * 24) workhour
FROM EMPCHECKIN e 
WHERE to_char(to_date(OFFTIME ,'YYYY-MM-DD HH24:MI:SS'),'MONTH') LIKE '%'||''||'%' -- 월 vo에 따로 추가
GROUP BY CLERKNUM) h, storeclerk s  
WHERE h.clerknum(+) = s.clerknum
AND frreginum = '1234567890' -- 세션처리
ORDER BY s.clerknum;

UPDATE STORECLERK 
	SET HOURLYPAY = 0
WHERE CLERKNUM ='12345678901016';

UPDATE STORECLERK 
	SET HOURLYPAY = 9500
WHERE CLERKNUM ='12345678901016';

SELECT * FROM STORECLERK s WHERE FRREGINUM = '1234567890';

SELECT *
from(
	SELECT rownum cnt, a.* FROM (
		SELECT nvl(TRUNC(h.workHOUR,1),0) workhour, nvl(TRUNC(h.workHOUR * s.hourlypay,-2),0) pay,s.*
		FROM (SELECT CLERKNUM ,sum((OFFTIME-ONTIME) * 24) workhour
		FROM EMPCHECKIN e 
		WHERE to_char(to_date(OFFTIME ,'YYYY-MM-DD HH24:MI:SS'),'MONTH') LIKE '%'||''||'%' -- 월 vo에 따로 추가
		AND EXTRACT(YEAR FROM OFFTIME) LIKE '%'||''||'%' -- 년 vo에 따로 추가
		GROUP BY CLERKNUM) h, storeclerk s  
		WHERE h.clerknum(+) = s.clerknum
		AND frreginum = '1234567890' -- 세션처리
		AND s.hourlypay != 0 -- 급여가 0이 아닌 직원 출력
		ORDER BY s.clerknum
	) a
)
where cnt BETWEEN 1 and 20;

SELECT * FROM DEFECTORDER d ;

select count(*)+1000
from storeclerk 
where frRegiNum = '1234567890' 
and hourlypay != 0;

SELECT * FROM STORECLERK s WHERE frRegiNum = '1234567890' ;

SELECT * FROM PRODUCT p , (SELECT PRODUCTNUM, REMAINAMOUNT, frreginum, stockdate, applyamount  FROM STOCK WHERE STOCKDATE IN 
			(SELECT max(STOCKDATE) FROM stock GROUP BY PRODUCTNUM)) h
WHERE p.PRODUCTNUM = h.PRODUCTNUM(+)
AND PRODUCTNAME LIKE '%'||''||'%';

SELECT PRODUCTNUM, REMAINAMOUNT  FROM STOCK s WHERE STOCKDATE IN 
			(SELECT max(STOCKDATE) FROM stock GROUP BY PRODUCTNUM);
		
select count(*)+1001 from storeclerk where frRegiNum = '1234567890';

SELECT to_char(ontime, 'HH24:MI:SS') ontime, to_char(offtime, 'HH24:MI:SS') offtime,clerkName,s.clerkNum,hourlypay FROM (
		SELECT e.ONTIME,e.offtime, e.CLERKNUM 
		FROM STORECLERK s ,EMPCHECKIN e 
		WHERE s.FRREGINUM = e.FRREGINUM
		AND s.CLERKNUM = e.CLERKNUM
		AND to_char(to_date(ontime,'YYYY-MM-DD HH24:MI:SS'),'MM/DD') = to_char(sysdate,'MM/DD')) a, storeclerk s
		WHERE a.clerknum(+) = s.CLERKNUM 
		AND s.FRREGINUM = '1234567890'
		AND hourlypay != 0
		ORDER BY s.CLERKNUM ASC;

SELECT * FROM menu;
SELECT * FROM emp;
SELECT * FROM store;

SELECT to_char(sysdate,'YYYY') FROM dual;

SELECT * FROM STORECLERK s ;

SELECT * FROM CLERKFILE c ;

UPDATE STORE
	SET FRPASS  = 'ektha1'
WHERE FRREGINUM  = '1234567890';

UPDATE STORECLERK 
	SET HOURLYPAY = '9700'
WHERE CLERKNUM  = '12345678901001';

SELECT * from(
SELECT rownum cnt, c.* 
FROM CLERKFILE c
WHERE CLERKNUM LIKE '%'||''||'%'
AND FRREGINUM = '1234567890');
		
SELECT * FROM CLERKFILE c ;
		
SELECT * 
from(
	SELECT rownum cnt, a.*
	from(
		SELECT * 
		FROM CLERKFILE c
		WHERE CLERKNUM LIKE '%'||'12345678901001'||'%'
		AND FRREGINUM = '1234567890'
		ORDER BY uptdte desc
		) a
	)
ORDER BY cnt;

SELECT rownum cnt, a.*
	from(
		SELECT * 
		FROM CLERKFILE c
		WHERE CLERKNUM LIKE '%'||'12345678901001'||'%'
		AND FRREGINUM = '1234567890'
		ORDER BY uptdte DESC
		) a;
		
SELECT * FROM defectorder;

SELECT to_char(sysdate, 'yyyy'),to_char(sysdate, 'yyyy')-1 FROM dual;

SELECT DISTINCT (TO_char(sysdate, 'YYYY')+1 - (LEVEL)) AS years FROM STORECLERK 
CONNECT BY LEVEL <= 5
ORDER BY years DESC;

SELECT * FROM (
	SELECT rownum AS cnt, po.*, p.img, p.PRODUCTNAME, p.CATEGORY, p.OPPOSITE 
	FROM PRODUCT p, PRODORDER po
	WHERE p.PRODUCTNUM = po.PRODUCTNUM
	AND p.PRODUCTNAME LIKE '%'||''||'%' 
	AND p.CATEGORY LIKE '%'||''||'%'
	AND to_char(to_date(ORDERDATE,'YYYY-MM-DD HH24:MI:SS'),'MONTH') LIKE '%'||''||'%' 
	AND EXTRACT(YEAR FROM ORDERDATE) LIKE '%'||''||'%'
	ORDER BY to_char(orderdate, 'YYMMDD HH24:MI:SS') DESC
) WHERE cnt BETWEEN 1 AND 50
ORDER BY cnt ASC ;

SELECT * FROM (
	SELECT rownum cnt, a.* FROM (
		SELECT po.*, p.img, p.PRODUCTNAME, p.CATEGORY, p.OPPOSITE , s.REMAINAMOUNT 
		FROM PRODUCT p, PRODORDER po, STOCK s 
		WHERE p.PRODUCTNUM = po.PRODUCTNUM
		AND s.PRODUCTNUM = p.PRODUCTNUM
		AND STOCKDATE IN (SELECT max(STOCKDATE) FROM stock GROUP BY PRODUCTNUM)
		AND p.PRODUCTNAME LIKE '%'||''||'%' 
		AND p.CATEGORY LIKE '%'||''||'%'
		AND to_char(to_date(ORDERDATE,'YYYY-MM-DD HH24:MI:SS'),'MONTH') LIKE '%'||''||'%' 
		AND EXTRACT(YEAR FROM ORDERDATE) LIKE '%'||''||'%'
		AND DEMANDER = '1234567890'
		ORDER BY to_char(orderdate, 'YYMMDD HH24:MI:SS') DESC) a
	)
WHERE cnt BETWEEN 1 AND 50;

SELECT po.*, p.img, p.PRODUCTNAME, p.CATEGORY, p.OPPOSITE , s.REMAINAMOUNT 
		FROM PRODUCT p, PRODORDER po, STOCK s 
		WHERE p.PRODUCTNUM = po.PRODUCTNUM
		AND s.PRODUCTNUM = p.PRODUCTNUM
		AND STOCKDATE IN (SELECT max(STOCKDATE) FROM stock GROUP BY PRODUCTNUM)
		AND p.PRODUCTNAME LIKE '%'||''||'%' 
		AND p.CATEGORY LIKE '%'||''||'%'
		AND to_char(to_date(ORDERDATE,'YYYY-MM-DD HH24:MI:SS'),'MONTH') LIKE '%'||''||'%' 
		AND EXTRACT(YEAR FROM ORDERDATE) LIKE '%'||''||'%'
		AND DEMANDER = '1234567890'
		ORDER BY to_char(orderdate, 'YYMMDD HH24:MI:SS') DESC;


SELECT count(*) FROM (
SELECT po.*, p.img, p.PRODUCTNAME, p.CATEGORY, p.OPPOSITE 
FROM PRODUCT p, PRODORDER po
WHERE p.PRODUCTNUM = po.PRODUCTNUM
AND p.PRODUCTNAME LIKE '%'||''||'%' 
AND p.CATEGORY LIKE '%'||''||'%'
AND to_char(to_date(ORDERDATE,'YYYY-MM-DD HH24:MI:SS'),'MONTH') LIKE '%'||''||'%' 
AND EXTRACT(YEAR FROM ORDERDATE) LIKE '%'||''||'%');

SELECT count(*)
FROM DEFECTORDER d, PRODORDER p, PRODUCT p2 
WHERE d.ORDERNUM = p.ORDERNUM 
AND d.ORDERDATE = p.ORDERDATE 
AND p.PRODUCTNUM = p2.PRODUCTNUM 
AND frreginum = '1234567890'
AND p2.PRODUCTNAME  LIKE '%'||''||'%'
AND p2.CATEGORY  LIKE '%'||''||'%'
AND to_char(to_date(d.APPLYDATE,'YYYY-MM-DD HH24:MI:SS'),'MONTH') LIKE '%'||''||'%' 
AND EXTRACT(YEAR FROM d.APPLYDATE) LIKE '%'||''||'%';

SELECT to_char(ontime, 'HH24:MI:SS') ontime,clerkName FROM (
		SELECT e.ONTIME,e.offtime, e.CLERKNUM 
		FROM STORECLERK s ,EMPCHECKIN e 
		WHERE s.FRREGINUM = e.FRREGINUM
		AND s.CLERKNUM = e.CLERKNUM
		AND to_char(to_date(ontime,'YYYY-MM-DD HH24:MI:SS'),'MM/DD') = to_char(sysdate,'MM/DD')) a, storeclerk s
		WHERE a.clerknum(+) = s.CLERKNUM 
		AND s.FRREGINUM = '1234567890'
		AND hourlypay != 0
		ORDER BY s.CLERKNUM ASC;
		
SELECT * FROM EMPCHECKIN e WHERE CLERKNUM = '12345678901005'

DELETE FROM EMPCHECKIN 
WHERE CLERKNUM = '12345678901005' 
AND ontime = to_date('2023-03-19 12:08:41','yyyy-MM-dd hh24:mi:ss' )
AND offtime = to_date('2023-03-19 12:11:37','yyyy-MM-dd hh24:mi:ss' );