SELECT * FROM account ;
SELECT * FROM STORE s ;
SELECT * FROM emp;
SELECT * FROM ACSTATEMENT ORDER BY stmtdate;
SELECT * FROM prodOrder;
SELECT * FROM stock;

INSERT INTO store values('1234567893','23031000','연남센트럴파크점',sysdate,'09:00-23:00','연중무휴','김박자','02-457-4145','서울특별시 마포구 연남로12','1234','kim_se_0@naver.com');
UPDATE store SET empnum='23031000' WHERE FRREGINUM ='9999999999';
INSERT INTO ACCOUNT values('10100','자산','현금');
ALTER TABLE statement RENAME TO ACStatement;
ALTER TABLE ACSTATEMENT RENAME COLUMN debt TO debit;

UPDATE store SET FRNAME ='투썸플레이스 본사', FRREPNAME ='김박박' WHERE frreginum='9999999999';

UPDATE account SET ACNTUSING = 0 WHERE acntnum='10110';

INSERT INTO acstatement values('A0001','10174252589','11100',1000,0,null,sysdate,null);
INSERT INTO acstatement values('A0001','10174252589','11200',0,1000,null,sysdate,null);

SELECT count(DISTINCT statementNum) FROM ACSTATEMENT a WHERE TO_CHAR(stmtdate,'YYYY-MM-DD') = '2023-03-01';

--전표입력
--첫번째거는 +1, 뒤에거는 그냥
INSERT INTO ACSTATEMENT VALUES('WR'||(SELECT nvl(substr(MAX(statementNum),3,5),1000)+1 FROM ACSTATEMENT a  WHERE TO_CHAR(stmtdate,'YYYY-MM-DD') = '2023-02-27'),'1234567890',0,TO_DATE('2023-02-27','YYYY-MM-DD'),10100,2000,0,NULL,null);
INSERT INTO ACSTATEMENT VALUES('WR'||(SELECT nvl(substr(MAX(statementNum),3,5),1000) FROM ACSTATEMENT a  WHERE TO_CHAR(stmtdate,'YYYY-MM-DD') = '2023-02-27'),'1234567890',1,TO_DATE('2023-02-27','YYYY-MM-DD'),10100,0,2000,NULL,null);
DELETE ACSTATEMENT WHERE to_char(stmtdate,'yyyy-mm-dd')='0023-03-13';

/*MERGE INTO ACSTATEMENT a USING dual ON (a.STATEMENTNUM='WR1010' AND a.FRREGINUM ='1234567890' AND a.STMTDATE = TO_DATE('2023-03-23','YYYY-MM-DD') AND a.LINENUM =2 )
WHEN MATCHED THEN
UPDATE SET acntnum= '10100', debit=3000, credit=0,STMTOPPOSITE ='정기거래처',REMARK ='참고용'
WHEN NOT MATCHED THEN INSERT (a.STATEMENTNUM, a.STMTDATE, a.linenum, a.FRREGINUM, a.acntnum, a.debit, a.credit, a.STMTOPPOSITE, a.REMARK) 
VALUES ('WR1010',TO_DATE('2023-03-23','YYYY-MM-DD'),1,'1234567890','10100',54100,0,'정기거래처','참고용')
;*/
/*
MERGE INTO ACSTATEMENT s
USING (
    SELECT 'WR1010' as statementNum, TO_DATE('2023-03-13','YYYY-MM-DD') as stmtDate, 5 as lineNum,'1234567890' as frRegiNum, '10100' as acntNum, 3000 as debit, 1000 as credit, '' as stmtOpposite, '' as remark
    FROM dual
) d
ON (
    s.STATEMENTNUM = d.statementNum AND
    TO_CHAR(s.stmtdate, 'YYYY-MM-DD') = d.stmtDate AND
    s.lineNum = d.lineNum AND
    s.FRREGINUM = d.frRegiNum
)
WHEN MATCHED THEN
    UPDATE SET s.acntnum = d.acntNum, s.debit = d.debit, s.credit = d.credit, s.STMTOPPOSITE = d.stmtOpposite, s.REMARK = d.remark
WHEN NOT MATCHED THEN
    INSERT (s.STATEMENTNUM, s.STMTDATE, s.linenum, s.FRREGINUM, s.acntnum, s.debit, s.credit, s.STMTOPPOSITE, s.REMARK)
    VALUES (d.statementNum, TO_DATE(d.stmtDate, 'YYYY-MM-DD'), d.lineNum, d.frRegiNum, d.acntNum, d.debit, d.credit, d.stmtOpposite, d.remark);
*/
MERGE INTO ACSTATEMENT t
USING (
  SELECT 'WR1001' AS STATEMENTNUM, '9999999999' AS FRREGINUM, 
         TO_DATE('2023-02-01', 'YYYY-MM-DD') AS STMTDATE, 
         '1' AS LINENUM, '40100' AS ACNTNUM, '0' AS DEBIT, 
         '15000' AS CREDIT, '' AS STMTOPPOSITE, '' AS REMARK
  FROM dual
) s
ON (t.STATEMENTNUM = s.STATEMENTNUM AND t.FRREGINUM = s.FRREGINUM 
    AND t.STMTDATE = s.STMTDATE AND t.LINENUM = s.LINENUM)
WHEN MATCHED THEN
  UPDATE SET t.ACNTNUM = s.ACNTNUM, t.DEBIT = s.DEBIT, 
             t.CREDIT = s.CREDIT, t.STMTOPPOSITE = s.STMTOPPOSITE, 
             t.REMARK = s.REMARK
WHEN NOT MATCHED THEN
  INSERT (STATEMENTNUM, FRREGINUM, LINENUM, STMTDATE, ACNTNUM, DEBIT, CREDIT, STMTOPPOSITE, REMARK)
  VALUES (s.STATEMENTNUM, s.FRREGINUM, s.LINENUM, s.STMTDATE, s.ACNTNUM, s.DEBIT, s.CREDIT, s.STMTOPPOSITE, s.REMARK);

 SELECT * FROM ACSTATEMENT WHERE  STATEMENTNUM = 'WR1001' ORDER BY stmtdate;

SELECT substr(MAX(statementNum),3,5) FROM ACSTATEMENT a WHERE STMTDATE = TO_DATE('2023-02-28','YYYY-MM-DD'); 
SELECT nvl(substr(MAX(statementNum),3,5),1000) FROM ACSTATEMENT a  WHERE TO_CHAR(stmtdate,'YYYY-MM-DD') = '2023-02-28'; 

/*
INSERT INTO ACSTATEMENT VALUES ('WR1001','1234567890',0,sysdate,10100,1000,0,NULL,null);
INSERT INTO ACSTATEMENT VALUES ('WR1001','1234567890',1,sysdate,10100,0,1000,NULL,null);
INSERT INTO ACSTATEMENT VALUES ('WR1002','1234567890',0,sysdate,10100,1000,0,NULL,null);
INSERT INTO ACSTATEMENT VALUES ('WR1002','1234567890',1,sysdate,10100,0,1000,NULL,null);
*/
INSERT INTO ACSTATEMENT VALUES ('AA1001','9999999999',0,sysdate,10100,1000,0,NULL,'testing');
INSERT INTO ACSTATEMENT VALUES ('AA1001','9999999999',1,sysdate,10100,0,1000,NULL,'testing');
INSERT INTO ACSTATEMENT VALUES ('AA1005','9999999999',0,sysdate,10100,55555,0,NULL,'testing');
INSERT INTO ACSTATEMENT VALUES ('AA1005','9999999999',1,sysdate,10100,0,55555,NULL,'testing');
--기본 전표검색
SELECT a.*, ii.rrnn AS stmtDate2 FROM ACSTATEMENT a,
	(SELECT rownum AS rrnn, a.statementNum FROM ACSTATEMENT a WHERE TO_CHAR(stmtdate,'YYYY-MM-DD') ='2023-03-03' AND FRREGINUM ='9999999999' AND LINENUM =1 ORDER BY STATEMENTNUM
	) ii
WHERE ii.statementNum=a.STATEMENTNUM  
AND TO_CHAR(a.stmtdate,'YYYY-MM-DD') ='2023-03-03' AND a.FRREGINUM ='9999999999' AND a.STATEMENTNUM ='WR1001';

--그날 가장 최근 전표(방금 입력한거
SELECT max(STATEMENTNUM) FROM ACSTATEMENT a;
--전표 번호 모르면 최근전표 조회
SELECT a.* ,CASE WHEN ii2.maxrn=ii.rronum THEN (ii.rronum*-1) ELSE ii.rronum END as rronum
FROM ACSTATEMENT a ,
(SELECT rownum AS rronum, a.statementNum FROM ACSTATEMENT a WHERE TO_CHAR(stmtdate,'YYYY-MM-DD') ='2023-03-03' AND FRREGINUM ='9999999999' AND LINENUM =1 ORDER BY STATEMENTNUM) ii,
(SELECT max(rn) AS maxrn from(SELECT rownum AS rn, STATEMENTNUM FROM ACSTATEMENT WHERE TO_CHAR(stmtdate,'YYYY-MM-DD') ='2023-03-03' AND FRREGINUM ='9999999999' AND LINENUM =1 ORDER BY STATEMENTNUM) )ii2
WHERE ii.statementNum=a.STATEMENTNUM  
AND TO_CHAR(a.stmtdate,'YYYY-MM-DD') ='2023-03-01' AND a.FRREGINUM ='9999999999' 
	AND a.STATEMENTNUM = (SELECT max(STATEMENTNUM) FROM ACSTATEMENT a2 WHERE FRREGINUM='9999999999' AND TO_CHAR(stmtdate,'YYYY-MM-DD') ='2023-03-03');

--여기부터 앞뒤 전표 조회기능
--오늘 전표번호 모두+순서대로
SELECT rownum AS rronum, a.* FROM ACSTATEMENT a WHERE TO_CHAR(stmtdate,'YYYY-MM-DD') ='2023-03-03' AND FRREGINUM ='9999999999' AND linenum=1 ORDER BY STATEMENTNUM ;
--입력받은 전표번호의 rownum을 구하고 그거보다 앞뒤에 있는 rownum의 전표번호 구해서 line모두
SELECT DISTINCT rrnn, a.* FROM ACSTATEMENT a, 
	(SELECT rownum AS rrnn, a.STATEMENTNUM FROM ACSTATEMENT a WHERE TO_CHAR(stmtdate,'YYYY-MM-DD') ='2023-03-03' AND FRREGINUM ='9999999999' AND LINENUM =1 ORDER BY STATEMENTNUM) ii
WHERE a.STATEMENTNUM = ii.statementNum	--같은전표번호
AND TO_CHAR(a.stmtdate,'YYYY-MM-DD') ='2023-03-03' AND a.FRREGINUM ='9999999999'
AND a.STATEMENTNUM ='AA1002'	--지금 입력받은 전표번호(앞뒤 찾을 대상)
;	--결과 : 지금 받은 전표번호가 오늘 전체중에 몇번이냐

--다시다시
SELECT rownum AS rrrnnn, aa.*,rrnn 
FROM ACSTATEMENT aa,(
		SELECT DISTINCT rrnn, aaa.* FROM ACSTATEMENT aaa, 
			(SELECT rownum AS rrnn, a.STATEMENTNUM FROM ACSTATEMENT a WHERE TO_CHAR(stmtdate,'YYYY-MM-DD') ='2023-03-03' AND FRREGINUM ='9999999999' AND LINENUM =1 ORDER BY STATEMENTNUM) ii
			WHERE aaa.STATEMENTNUM = ii.statementNum	--같은전표번호
			AND TO_CHAR(aaa.stmtdate,'YYYY-MM-DD') ='2023-03-03' AND aaa.FRREGINUM ='9999999999'
			AND aaa.STATEMENTNUM ='AA1003' AND aaa.LINENUM =1
			) iii	--결과 : 지금 받은 전표번호가 오늘 전체중에 몇번이냐
WHERE TO_CHAR(aa.stmtdate,'YYYY-MM-DD') ='2023-03-03' AND aa.FRREGINUM ='9999999999'
;
SELECT CEIL(15/2)  FROM dual;

--마지믹인가
SELECT * FROM 
	(SELECT rownum AS rrrnnn, aa.*,rrnn 
FROM ACSTATEMENT aa,(
		SELECT DISTINCT rrnn, aaa.* FROM ACSTATEMENT aaa, 
			(SELECT rownum AS rrnn, a.STATEMENTNUM FROM ACSTATEMENT a WHERE TO_CHAR(stmtdate,'YYYY-MM-DD') ='2023-03-03' AND FRREGINUM ='9999999999' AND LINENUM =1 ORDER BY STATEMENTNUM) ii
			WHERE aaa.STATEMENTNUM = ii.statementNum	--같은전표번호
			AND TO_CHAR(aaa.stmtdate,'YYYY-MM-DD') ='2023-03-03' AND aaa.FRREGINUM ='9999999999'
			AND aaa.STATEMENTNUM ='AA1001' AND aaa.LINENUM =1
			) iii	--결과 : 지금 받은 전표번호가 오늘 전체중에 몇번이냐
WHERE TO_CHAR(aa.stmtdate,'YYYY-MM-DD') ='2023-03-03' AND aa.FRREGINUM ='9999999999') fin
WHERE CEIL(rrrnnn/2)=rrnn+1	--라인번호 하나만 하면 또 다시 검색해야하니까 나머지 올림해서 쓰면 끝
; 
--그냥 모든 전표vo가 rownum을 가지고 있다면??ㅅㅂ
SELECT a2.*,CASE WHEN ii2.maxrn=ii.rronum THEN (ii.rronum*-1) ELSE ii.rronum END as rronum FROM ACSTATEMENT a2, (
	SELECT rownum AS rronum, a.* 
	FROM ACSTATEMENT a 
	WHERE TO_CHAR(stmtdate,'YYYY-MM-DD') ='2023-03-03' AND FRREGINUM ='9999999999' AND LINENUM =1 ORDER BY STATEMENTNUM) ii ,
	(SELECT max(rn) AS maxrn from(SELECT rownum AS rn, STATEMENTNUM FROM ACSTATEMENT WHERE TO_CHAR(stmtdate,'YYYY-MM-DD') ='2023-03-03' AND FRREGINUM ='9999999999' AND LINENUM =1 ORDER BY STATEMENTNUM) )ii2
WHERE a2.STATEMENTNUM =ii.statementNum 
AND rronum= 7
AND TO_CHAR(a2.stmtdate,'YYYY-MM-DD') ='2023-03-03' AND a2.FRREGINUM ='9999999999'
	;
--여기까지 앞뒤전표 조회 기능

SELECT 7*-1 FROM dual;


--전표 수정 반복문으로 돌려가면서
UPDATE ACSTATEMENT SET acntnum= 10100, debit=3000, credit=0,STMTOPPOSITE ='정기거래처',REMARK ='참고용' WHERE STATEMENTNUM ='A0001' AND TO_CHAR(stmtdate,'YYYY-MM-DD') = '2023-02-01' AND lineNum=0;


SELECT * FROM Account where acntNum Like '%'||''||'%' And acntTitle LIKE '%'||'현'||'%';


--전표목록 aka 거래내역
SELECT a.ACNTGROUP, s.* FROM ACSTATEMENT s, ACCOUNT a 
WHERE s.acntnum = a.acntnum 
AND a.ACNTNUM = 10100
AND (STMTOPPOSITE IS NULL OR STMTOPPOSITE LIKE '%'||''||'%')
AND STMTDATE BETWEEN TO_DATE('2023-02-01','YYYY-MM-DD') AND TO_DATE('2023-03-10','YYYY-MM-DD')
;


SELECT STATEMENTNUM,a.ACNTTITLE "ACNTNUM",
	CASE WHEN acntgroup='비용' THEN debit-credit 
	WHEN acntgroup='자산' THEN debit-credit
	ELSE CREDIT - debit END AS DEBIT,
	STMTOPPOSITE,TO_CHAR(STMTDATE,'YYYY-MM-DD') "STMTDATE", REMARK FROM ACSTATEMENT s , ACCOUNT a
WHERE s.ACNTNUM = a.ACNTNUM 
AND s.ACNTNUM LIKE '%'||''||'%'
AND (STMTOPPOSITE IS NULL OR STMTOPPOSITE LIKE '%'||''||'%')
AND STMTDATE BETWEEN TO_DATE('2023-03-03','YYYY-MM-DD') AND TO_DATE('2023-03-10','YYYY-MM-DD')
AND FRREGINUM = '9999999999'
;


SELECT nvl(substr(MAX(statementNum),3,5),1000)+1 FROM ACSTATEMENT;

DELETE FROM ACSTATEMENT a WHERE STATEMENTNUM ='WR100210021';

SELECT acntgroup,
CASE WHEN acntgroup='비용' THEN debit-credit 
	WHEN acntgroup='자산' THEN debit-credit
	ELSE CREDIT - debit END AS DEBIT 
FROM ACSTATEMENT s , ACCOUNT a
WHERE s.ACNTNUM = a.ACNTNUM 
AND s.acntnum='40100';

SELECT TO_CHAR(STMTDATE,'YYYY-MM-DD') AS "STMTDATE", a.ACNTTITLE "ACNTNUM",
		sum(CASE WHEN acntgroup='비용' THEN debit-credit 
		WHEN acntgroup='자산' THEN debit-credit
		ELSE CREDIT - debit END) AS DEBIT
	FROM ACSTATEMENT s , ACCOUNT a
WHERE s.ACNTNUM = a.ACNTNUM 
AND s.ACNTNUM LIKE '%'||''||'%'
AND (STMTOPPOSITE IS NULL OR STMTOPPOSITE LIKE '%'||''||'%')
AND STMTDATE BETWEEN TO_DATE('2023-02-01','YYYY-MM-DD') AND TO_DATE('2023-03-10','YYYY-MM-DD')
AND FRREGINUM = '9999999999'
	GROUP BY STMTDATE ,a.ACNTTITLE ;

SELECT * FROM PRODORDER p ;
/*CREATE SEQUENCE pdSeq
INCREMENT BY 1
START WITH 10000
MINVALUE 10000
MAXVALUE 99999
ORDER
CYCLE;*/
SELECT * FROM product;
--INSERT INTO Product values('PD'||pdSeq.nextval,'유제품','매일우유 바리스타 1L*5','매일우유 서부통판센터',7200,'/resource/img/PD10001.jpg',null);
--INSERT INTO Product values('PD'||pdSeq.nextval,'유제품','매일우유 1% 저지방우유 1.5L','매일우유 서부통판센터',4980,'/resource/img/PD10002.PNG',null);
INSERT INTO PRODORDER values((SELECT TO_CHAR(SYSDATE,'YYMMDD')||'1234567892' FROM dual),'PD10001','1234567892','9999999999',sysdate,3,'정산전','완료');
INSERT INTO PRODORDER values((SELECT TO_CHAR(SYSDATE,'YYMMDD')||'1234567892' FROM dual),'PD10002','1234567892','9999999999',sysdate,1,'정산전','완료');
INSERT INTO PRODORDER values((SELECT TO_CHAR(SYSDATE,'YYMMDD')||'1234567891' FROM dual),'PD10001','1234567891','9999999999',sysdate,23,'요청','완료');
INSERT INTO PRODORDER values((SELECT TO_CHAR(SYSDATE,'YYMMDD')||'1234567891' FROM dual),'PD10002','1234567891','9999999999',sysdate,12,'요청','완료');
INSERT INTO PRODORDER values((SELECT TO_CHAR(SYSDATE,'YYMMDD')||'1234567890' FROM dual),'PD10001','1234567890','9999999999',sysdate,32,'배송','완료');
INSERT INTO PRODORDER values((SELECT TO_CHAR(SYSDATE,'YYMMDD')||'1234567890' FROM dual),'PD10002','1234567890','9999999999',sysdate,8,'배송','완료');
INSERT INTO PRODORDER values('2302011234567890','PD10022','1234567890','9999999999',to_date('2023-02-01','YYYY-MM-DD'),10,'정산전','요청');


--물류관리 발주 조회 메뉴
--주문지점, 발주번호, 날짜로 검색 + 월별 조회
SELECT * FROM PRODORDER o,PRODUCT p 
WHERE o.PRODUCTNUM =p.PRODUCTNUM
and (DEMANDER LIKE '%'||'1234567892'||'%' OR ORDERNUM LIKE '%'||'2023021234567890'||'%' )
AND TRUNC(orderdate,'month') = trunc(to_date('2023-02-28','YYYY-MM-DD'),'month')
;

--조건으로 검색
SELECT p.*, s1.ename,s1.frname FROM PRODORDER p ,(SELECT * FROM store s, emp e WHERE s.EMPNUM =e.EMPNUM ) s1 
WHERE p.DEMANDER = s1.FRREGINUM
AND PRODUCTNUM LIKE '%'||'PD10001'||'%'
AND s1.ename LIKE '%'||''||'%'
AND PAYMENTSTATE LIKE '%'||''||'%'
AND ORDERSTATE LIKE '%'||''||'%'
AND TRUNC(orderdate) = to_date('2023-02-25','YYYY-MM-DD')
;

--발주 검색: 최종
SELECT po.*, se.empnum,se.ename,se.frreginum,se.frname,stck.remainamount FROM PRODORDER po, product pd, 
		(SELECT FRREGINUM ,FRNAME,e.empnum,ename FROM store s, emp e WHERE s.EMPNUM =e.EMPNUM) se,
		(SELECT * FROM STOCK s WHERE STOCKDATE IN (SELECT max(STOCKDATE) FROM stock GROUP BY PRODUCTNUM)) stck
WHERE po.DEMANDER = se.FRREGINUM AND pd.PRODUCTNUM =po.PRODUCTNUM AND stck.productNum = po.PRODUCTNUM 
	AND (TRUNC(orderdate) = to_date('','YYYY-MM-DD')	--일별일때
			OR TRUNC(orderdate,'month') = TRUNC(to_date('','YYYY-MM-DD'),'month')--월별일때
			OR ORDERNUM LIKE '%'||''||'%')	--발주번호
	AND (po.DEMANDER LIKE '%'||''||'%' OR se.frname LIKE '%'||''||'%')	--주문지점
	AND (se.ename LIKE '%'||''||'%' OR se.empNum LIKE '%'||''||'%')	--담당자
	AND (pd.PRODUCTNUM LIKE '%'||''||'%' OR pd.PRODUCTNAME LIKE '%'||''||'%') --상품번호 또는 이름
	AND po.PAYMENTSTATE LIKE '%'||''||'%' AND po.ORDERSTATE LIKE '%'||''||'%'
	AND po.demander != '9999999999'
ORDER BY po.ORDERDATE asc ;
;


UPDATE PRODORDER SET PAYMENTSTATE  ='정산전' WHERE ORDERDATE < sysdate;
UPDATE PRODORDER SET PAYMENTSTATE ='청구' WHERE ORDERDATE < to_date('2023-03-01','yyyy-mm-dd') AND demander = '1234567890';
UPDATE PRODORDER SET PAYMENTSTATE ='계산서 발행' WHERE ORDERDATE < to_date('2023-02-28','yyyy-mm-dd');
UPDATE PRODORDER SET PAYMENTSTATE ='완료' WHERE ORDERDATE < to_date('2023-01-31','yyyy-mm-dd');

UPDATE PRODORDER SET ORDERSTATE  ='요청' WHERE ORDERDATE < sysdate;
UPDATE PRODORDER SET ORDERSTATE ='배송중' WHERE ORDERDATE < to_date('2023-03-07','yyyy-mm-dd');
UPDATE PRODORDER SET ORDERSTATE ='완료' WHERE ORDERDATE < to_date('2023-03-06','yyyy-mm-dd');
--발주상태 변경
/*UPDATE PRODORDER SET ORDERSTATE ='완료' WHERE (ORDERNUM,PRODUCTNUM) IN (SELECT po.ORDERNUM,po.PRODUCTNUM  FROM PRODORDER po, product pd, 
		(SELECT FRREGINUM ,FRNAME,e.empnum,ename FROM store s, emp e WHERE s.EMPNUM =e.EMPNUM) se,
		(SELECT * FROM STOCK s WHERE STOCKDATE IN (SELECT max(STOCKDATE) FROM stock GROUP BY PRODUCTNUM)) stck
WHERE po.DEMANDER = se.FRREGINUM AND pd.PRODUCTNUM =po.PRODUCTNUM AND stck.productNum = po.PRODUCTNUM 
	AND (TRUNC(orderdate) = to_date('','YYYY-MM-DD')	--일별일때
			OR TRUNC(orderdate,'month') = TRUNC(to_date('','YYYY-MM-DD'),'month')--월별일때
			OR ORDERNUM LIKE '%'||'2302281234567890'||'%')	--발주번호
	AND (po.DEMANDER LIKE '%'||'디맨더로 받아온 변수'||'%' AND se.frname LIKE '%'||'독산'||'%')	--주문지점
	AND (se.ename LIKE '%'||''||'%' OR se.empNum LIKE '%'||''||'%')	--담당자
	AND (pd.PRODUCTNUM LIKE '%'||'PD10002'||'%' OR pd.PRODUCTNAME LIKE '%'||''||'%') --상품번호 또는 이름
	AND po.PAYMENTSTATE LIKE '%'||''||'%' AND po.ORDERSTATE LIKE '%'||''||'%');*/

--결제상태 검색
SELECT to_char(TRUNC(ORDERDATE,'month'),'YYYY-MM') AS orderDateMonth,FRREGINUM,FRNAME,sum(CASE WHEN CATEGORY LIKE '면세'||'%' THEN 0 ELSE AMOUNT * price * 0.1 END ) AS remark
		,sum(AMOUNT*price) AS price, ename, empnum, po.PAYMENTSTATE
FROM prodOrder po,
	product pd, 
	(SELECT FRREGINUM ,FRNAME,e.empnum,ename FROM store s, emp e WHERE s.EMPNUM =e.EMPNUM) se
WHERE po.DEMANDER = se.FRREGINUM AND pd.PRODUCTNUM =po.PRODUCTNUM
	AND TRUNC(orderdate,'month') BETWEEN to_date('2023-03', 'YYYY-MM') AND to_date('2023-03', 'YYYY-MM')	--날짜
	AND (po.DEMANDER LIKE '%'||''||'%' or se.frname LIKE '%'||''||'%')	--주문지점
	AND (se.ename LIKE '%'||''||'%' or se.empNum LIKE '%'||''||'%')	--담당자
	AND po.PAYMENTSTATE LIKE '%'||''||'%' 
GROUP BY TRUNC(ORDERDATE,'month'),FRREGINUM,FRNAME,ename,empnum,po.PAYMENTSTATE
;
--정산서 검색
SELECT po.PAYMENTSTATE,pd.productnum,pd.category,pd.PRODUCTNAME ,pd.PRICE,(CASE WHEN CATEGORY LIKE '면세'||'%' THEN 0 ELSE price * 0.1 END) AS remark,
to_char(monthly,'yyyy-mm') AS orderDateMonth,po.frreginum,po.AMOUNT,s.frname,s.FRREPNAME ,s.FRADDRESS 
	FROM PRODUCT pd,
		store s,
		(SELECT PAYMENTSTATE,TRUNC(ORDERDATE,'month') AS monthly,po.DEMANDER AS frreginum, po.productnum,sum(amount) AS amount
		FROM PRODORDER po 
		WHERE po.DEMANDER ='1234567890' AND TRUNC(ORDERDATE,'month')=TO_DATE('2023-03','YYYY-MM')
		GROUP BY TRUNC(ORDERDATE,'month'), po.productnum,po.DEMANDER,PAYMENTSTATE) po
WHERE pd.PRODUCTNUM =po.productnum AND s.FRREGINUM =po.frreginum
ORDER BY CATEGORY 
;

SELECT TRUNC(ORDERDATE,'month') AS monthly,po.DEMANDER, po.productnum,sum(amount) AS amount
	FROM PRODORDER po 
	WHERE po.DEMANDER ='1234567890' AND TRUNC(ORDERDATE,'month')=TO_DATE('2023-03','YYYY-MM')
	GROUP BY TRUNC(ORDERDATE,'month'), po.productnum,po.DEMANDER;


SELECT * FROM PRODUCT p ;
--INSERT INTO Product values('PD'||pdSeq.nextval,'면세_과일','고당도 설향 딸기 중과 2kg','경남 설기농장',15700,'PD10022.PNG',null);

--서브테이블
SELECT FRREGINUM ,FRNAME,e.empnum,ename FROM store s, emp e WHERE s.EMPNUM =e.EMPNUM;
--서브테이블 실시간 본사 재고
SELECT * FROM STOCK s WHERE STOCKDATE IN (SELECT max(STOCKDATE) FROM stock GROUP BY PRODUCTNUM);

SELECT * FROM stock;
SELECT * FROM emp  ;
/*INSERT INTO emp values('00009999','1234','admin','관리자');
INSERT INTO store(frreginum) values('9999999999',); 
INSERT INTO stock VALUES ('PD10001','9999999999',sysdate,100,100,null);
INSERT INTO stock VALUES ('PD10022','9999999999',sysdate,40,40,null);*/

SELECT * FROM emp;

SELECT * FROM stock s, PRODORDER p WHERE s.PRODUCTNUM =p.PRODUCTNUM ;

--조건받아서 insert into acstmt
SELECT * FROM prodOrder po,
		product pd, 
		(SELECT FRREGINUM ,FRNAME,e.empnum,ename FROM store s, emp e WHERE s.EMPNUM =e.EMPNUM) se
WHERE po.DEMANDER = se.FRREGINUM AND pd.PRODUCTNUM =po.PRODUCTNUM
	AND TRUNC(ORDERDATE,'month') = TO_DATE('2023-03','YYYY-MM')
	AND empnum LIKE '%'||'22051002'||'%'
	AND PAYMENTSTATE LIKE '%'||''||'%'
	;

SELECT po.*,stck.remainamount,pd.productName FROM PRODORDER po, product pd, 
		(SELECT * FROM STOCK s WHERE STOCKDATE IN (SELECT max(STOCKDATE) FROM stock GROUP BY PRODUCTNUM)) stck
WHERE pd.PRODUCTNUM =po.PRODUCTNUM AND stck.productNum = po.PRODUCTNUM 
	AND (po.DEMANDER ='9999999999')	-- 주문지점
	AND (pd.PRODUCTNUM LIKE '%'||''||'%' OR pd.PRODUCTNAME LIKE '%'||''||'%') --상품번호 또는 이름
	AND po.PAYMENTSTATE LIKE '%'||''||'%' AND po.ORDERSTATE LIKE '%'||''||'%'
ORDER BY po.ORDERDATE ASC;

SELECT * FROM DEFECTORDER d 
WHERE APPLYDATE > TO_DATE('2022-03-01','yyyy-mm-dd') 
;
--INSERT INTO DEFECTORDER values('3','2302011234567890','PD10022',to_date('2023-02-01','YYYY-MM-DD'),NULL,'처리중','교환',to_date('2023-02-01','YYYY-MM-DD'),'1234567890','오배송',null);
