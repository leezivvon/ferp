--DROP TABLE store CASCADE CONSTRAINT;

CREATE TABLE store (
	FrRegiNum	varchar2(50)		NOT NULL,
	empNum	varchar2(10)		NOT NULL,
	frName	varchar2(50)		NULL,
	frOpen	date		NULL,
	frOperTime	varchar2(50)		NULL,
	frClosedDte	varchar2(50)		NULL,
	frRepName	varchar2(20)		NULL,
	frTel	varchar2(20)		NULL,
	frAddress	varchar2(100)		NULL,
	frPass	varchar2(20)		NULL
);

--DROP TABLE menu;

CREATE TABLE menu (
	menuNum	varchar2(50)		NOT NULL,
	menuName	varchar2(50)		NULL,
	price	number		NULL,
	info	varchar2(100)		NULL,
	img	varchar2(100)		NULL,
	necessary	varchar2(50)		NULL,
	category	varchar2(50)		NULL
);

--DROP TABLE orders;

CREATE TABLE orders (
	orderNum	varchar2(50)		NOT NULL,
	orderDate	date		NOT NULL,
	menuNum	varchar2(50)		NOT NULL,
	FrRegiNum	varchar2(50)		NOT NULL,
	state	varchar2(50)		NULL,
	amount	number		NULL,
	payprice	number		NULL,
	orderOption	varchar2(500)		NULL
);

--DROP TABLE onSale;

CREATE TABLE onSale (
	menuNum	varchar2(50)		NOT NULL,
	FrRegiNum	varchar2(50)		NOT NULL
);

--DROP TABLE storeClerk;

CREATE TABLE storeClerk (
	clerkNum	varchar2(50)		NOT NULL,
	FrRegiNum	varchar2(50)		NOT NULL,
	clerkName	varchar2(50)		NULL,
	residentNum	varchar2(20)		NULL,
	phoneNum	varchar2(20)		NULL,
	address	varchar2(300)		NULL,
	hourlyPay	number		NULL
);

--DROP TABLE clerkSchedule;

CREATE TABLE clerkSchedule (
	onDay	date		NULL,
	offDay	date		NULL,
	clerkNum	varchar2(50)		NOT NULL,
	FrRegiNum	varchar2(50)		NOT NULL
);

--DROP TABLE empCheckIn;

CREATE TABLE empCheckIn (
	FrRegiNum	varchar2(50)		NOT NULL,
	clerkNum	varchar2(50)		NOT NULL,
	onTime	date		NULL,
	offTime	date		NULL
);

--DROP TABLE notice;

CREATE TABLE notice (
	noticeNum	varchar2(50)		NOT NULL,
	title	varchar2(300)		NULL,
	content	varchar2(1000)		NULL,
	empNum	varchar2(10)		NULL,
	readcnt	number		NULL,
	regdte	date		NULL,
	uptdte	date		NULL,
	fname	varchar2(300)		NULL,
	important	varchar2(50)		NULL,
	replyNum	varchar2(50)		NULL,
	category	varchar2(50)		NULL,
	state	varchar2(50)		NULL
);

--DROP TABLE emp;

CREATE TABLE emp (
	empNum	varchar2(10)		NOT NULL,
	pass	varchar2(20)		NULL,
	ename	varchar2(20)		NULL,
	dname	varchar2(30)		NULL
);

--DROP TABLE QA;

CREATE TABLE QA (
	inspectionNum	varchar2(50)		NOT NULL,
	FrRegiNum	varchar2(50)		NOT NULL,
	QANum	varchar2(50)		NOT NULL,
	results	varchar2(50)		NULL,
	empNum	varchar2(10)		NOT NULL,
	inspectdte	date		NULL,
	regdte	date		NULL,
	comments	varchar2(100)		NULL
);

--DROP TABLE prodOrder;

CREATE TABLE prodOrder (
	orderNum	varchar2(50)		NOT NULL,
	productNum	varchar2(50)		NOT NULL,
	demander	varchar2(50)		NOT NULL,
	supplier	varchar2(50)		NULL,
	orderDate	date		NOT NULL,
	amount	number		NULL,
	paymentState	varchar2(50)		NULL,
	orderState	varchar2(50)		NULL
);

--DROP TABLE QAcheckList;

CREATE TABLE QAcheckList (
	QANum	varchar2(50)		NOT NULL,
	QAitem	varchar2(300)		NULL,
	usable	varchar2(50)		NULL
);

--DROP TABLE defectOrder;

CREATE TABLE defectOrder (
	defNum	varchar2(50)		NOT NULL,
	orderNum	varchar2(50)		NOT NULL,
	productNum	varchar2(50)		NOT NULL,
	applyDate	date		NOT NULL,
	img	varchar2(1000)		NULL,
	state	varchar2(50)		NOT NULL,
	methods	varchar2(50)		NOT NULL
);

--DROP TABLE stock;

CREATE TABLE stock (
	productNum	varchar2(50)		NOT NULL,
	FrRegiNum	varchar2(50)		NOT NULL,
	stockDate	date		NULL,
	applyAmount	number		NULL,
	remainAmount	number		NULL,
	remark	varchar2(1000)		NULL
);

--DROP TABLE Product;

CREATE TABLE Product (
	productNum	varchar2(50)		NOT NULL,
	category	varchar2(50)		NULL,
	productName	varchar2(50)		NULL,
	opposite	varchar2(50)		NULL,
	price	number		NULL,
	img	varchar2(1000)		NULL,
	remark	varchar2(1000)		NULL
);
/*
DROP TABLE Account;

CREATE TABLE Account (
	acntNum	varchar2(50)		NOT NULL,
	acntGroup	varchar2(20)		NULL,
	acntTitle	varchar2(50)		NULL,
	acntUsing	number		NULL
);
*/
--DROP TABLE clerkFile;

CREATE TABLE clerkFile (
	fname	varchar2(300)		NULL,
	regdte	date		NULL,
	uptdte	date		NULL,
	clerkNum	varchar2(50)		NOT NULL,
	FrRegiNum	varchar2(50)		NOT NULL
);

--DROP TABLE ACStatement;

CREATE TABLE ACStatement (
	statementNum	varchar2(50)		NULL,
	FrRegiNum	varchar2(50)		NULL,
	lineNum	number		NOT NULL,
	stmtDate	date		NULL,
	acntNum	varchar2(50)		NOT NULL,
	debt	number		NULL,
	credit	number		NULL,
	stmtOpposite	varchar2(50)		NULL,
	remark	varchar2(1000)		NULL
);

ALTER TABLE store ADD CONSTRAINT PK_STORE PRIMARY KEY (
	FrRegiNum
);

ALTER TABLE menu ADD CONSTRAINT PK_MENU PRIMARY KEY (
	menuNum
);

ALTER TABLE orders ADD CONSTRAINT PK_ORDERS PRIMARY KEY (
	orderNum,
	orderDate,
	menuNum,
	FrRegiNum
);

ALTER TABLE storeClerk ADD CONSTRAINT PK_STORECLERK PRIMARY KEY (
	clerkNum,
	FrRegiNum
);

ALTER TABLE notice ADD CONSTRAINT PK_NOTICE PRIMARY KEY (
	noticeNum
);

ALTER TABLE emp ADD CONSTRAINT PK_EMP PRIMARY KEY (
	empNum
);

ALTER TABLE QA ADD CONSTRAINT PK_QA PRIMARY KEY (
	inspectionNum,
	FrRegiNum,
	QANum
);

ALTER TABLE prodOrder ADD CONSTRAINT PK_PRODORDER PRIMARY KEY (
	orderNum,
	productNum
);

ALTER TABLE QAcheckList ADD CONSTRAINT PK_QACHECKLIST PRIMARY KEY (
	QANum
);

ALTER TABLE defectOrder ADD CONSTRAINT PK_DEFECTORDER PRIMARY KEY (
	defNum,
	orderNum,
	productNum
);

ALTER TABLE stock ADD CONSTRAINT PK_STOCK PRIMARY KEY (
	productNum,
	FrRegiNum,
	stockDate
);

ALTER TABLE FERD.stock DROP CONSTRAINT PK_STOCK;


ALTER TABLE Product ADD CONSTRAINT PK_PRODUCT PRIMARY KEY (
	productNum
);
/*
ALTER TABLE Account ADD CONSTRAINT PK_ACCOUNT PRIMARY KEY (
	acntNum
);
*/
ALTER TABLE ACStatement ADD CONSTRAINT PK_ACSTATEMENT PRIMARY KEY (
	statementNum,
	FrRegiNum,
	lineNum,
	stmtDate
);

ALTER TABLE store ADD CONSTRAINT FK_emp_TO_store_1 FOREIGN KEY (
	empNum
)
REFERENCES emp (
	empNum
);

ALTER TABLE orders ADD CONSTRAINT FK_menu_TO_orders_1 FOREIGN KEY (
	menuNum
)
REFERENCES menu (
	menuNum
);

ALTER TABLE orders ADD CONSTRAINT FK_store_TO_orders_1 FOREIGN KEY (
	FrRegiNum
)
REFERENCES store (
	FrRegiNum
);

ALTER TABLE onSale ADD CONSTRAINT FK_menu_TO_onSale_1 FOREIGN KEY (
	menuNum
)
REFERENCES menu (
	menuNum
);

ALTER TABLE onSale ADD CONSTRAINT FK_store_TO_onSale_1 FOREIGN KEY (
	FrRegiNum
)
REFERENCES store (
	FrRegiNum
);

ALTER TABLE storeClerk ADD CONSTRAINT FK_store_TO_storeClerk_1 FOREIGN KEY (
	FrRegiNum
)
REFERENCES store (
	FrRegiNum
);

ALTER TABLE empCheckIn ADD CONSTRAINT PK_EMPCHECKIN PRIMARY KEY (
	clerkNum,
	FrRegiNum
);

ALTER TABLE clerkSchedule ADD CONSTRAINT FK_storeC_clerkSchedule_1 FOREIGN KEY (
	clerkNum,
	FrRegiNum
)
REFERENCES storeClerk (
	clerkNum,
	FrRegiNum
);

ALTER TABLE empCheckIn ADD CONSTRAINT FK_storeClerk_TO_empCheckIn_1 FOREIGN KEY (
	FrRegiNum,
	clerkNum
)
REFERENCES storeClerk (
	FrRegiNum,
	clerkNum
);


ALTER TABLE QA ADD CONSTRAINT FK_QAcheckList_TO_QA_1 FOREIGN KEY (
	QANum
)
REFERENCES QAcheckList (
	QANum
);

ALTER TABLE QA ADD CONSTRAINT FK_emp_TO_QA_1 FOREIGN KEY (
	empNum
)
REFERENCES emp (
	empNum
);

ALTER TABLE prodOrder ADD CONSTRAINT FK_Product_TO_prodOrder_1 FOREIGN KEY (
	productNum
)
REFERENCES Product (
	productNum
);

ALTER TABLE prodOrder ADD CONSTRAINT FK_store_TO_prodOrder_1 FOREIGN KEY (
	demander
)
REFERENCES store (
	FrRegiNum
);
--수정한거
ALTER TABLE FERD.PRODORDER
ADD CONSTRAINT PRODORDER_PK PRIMARY KEY (ORDERNUM,PRODUCTNUM,ORDERDATE)
ENABLE;

ALTER TABLE FERD.PRODORDER DROP CONSTRAINT PRODORDER_PK;
ALTER TABLE FERD.PRODORDER DROP CONSTRAINT FK_store_TO_prodOrder_1;
ALTER TABLE FERD.PRODORDER DROP CONSTRAINT FK_Product_TO_prodOrder_1;
ALTER TABLE FERD.defectOrder DROP CONSTRAINT FK_prodOrder_TO_defectOrder_1;
ALTER TABLE FERD.defectOrder DROP CONSTRAINT PK_DEFECTORDER;


ALTER TABLE defectOrder ADD CONSTRAINT PK_DEFECTORDER PRIMARY KEY (
	defNum,
	orderNum,
	productNum,
	orderDate
);
--orderDate 추가

ALTER TABLE DEFECTORDER ADD orderDate DATE;


ALTER TABLE defectOrder ADD CONSTRAINT FK_prodOrder_TO_defectOrder_1 FOREIGN KEY (
	orderNum,
	productNum
)
REFERENCES prodOrder (
	orderNum,
	productNum
);

--재고 
ALTER TABLE FERD.stock DROP CONSTRAINT FK_Product_TO_stock_1;
ALTER TABLE FERD.stock DROP CONSTRAINT FK_store_TO_stock_1;


ALTER TABLE stock ADD CONSTRAINT FK_Product_TO_stock_1 FOREIGN KEY (
	productNum
)
REFERENCES Product (
	productNum
);

ALTER TABLE stock ADD CONSTRAINT FK_store_TO_stock_1 FOREIGN KEY (
	FrRegiNum
)
REFERENCES store (
	FrRegiNum
);

ALTER TABLE clerkFile ADD CONSTRAINT PK_CLERKFILE PRIMARY KEY (
	clerkNum,
	FrRegiNum
);
ALTER TABLE clerkFile ADD CONSTRAINT FK_storeClerk_TO_clerkFile_1 FOREIGN KEY (
	clerkNum,
	FrRegiNum
)
REFERENCES storeClerk (
	clerkNum,
	FrRegiNum
);

ALTER TABLE ACStatement ADD CONSTRAINT FK_Account_TO_ACStatement_1 FOREIGN KEY (
	acntNum
)
REFERENCES Account (
	acntNum
);

