<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정산서 조회</title>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" href="${path}/resource/css/basicStyle.css" />
<link rel="stylesheet" href="${path}/resource/css/displayingSY.css" />

<script type="text/javascript" src="${path }/resource/js/sy_fetchs.js"></script>
<style>
table{
	border-collapse: collapse;
	border:2px gray solid;
}
table th,table td,table thead th{
	border:1px gray solid;
	padding:0.3rem;
}

.table{
	width: 95%;
}
.table tbody td:nth-child(3),.table tbody td:nth-child(4),.table tbody td:nth-child(5),.table tbody td:nth-child(6),.table tbody td:nth-child(7){
	text-align: right;
}
tfoot td:nth-child(1){
	text-align: center;}
tfoot td:not(:nth-child(1)){
	text-align: right;
}
.accent{
	background-color: lightgray;
	font-weight: bold;
	font-size: 1.1rem;
}
.print{
	border:2px solid black;
	display: flex;
	flex-direction:column;
	flex-wrap:wrap;
	flex-shrink: initial;
	padding:2em;
	align-content: center;
}
.infotable{width:65%;}
@page {margin:0}
@media print{
  html, body { 
  	-webkit-print-color-adjust:exact; 
 	 width: 210mm; 
 	 height: 297mm;
 	 }
  header,header *,.lnb,.lnb *,.toolbox,hr,h2{
  	display:none;
  }
	.main_wrapper,.contents,.container{
	padding:0;
	margin:0;
	}
	.print{
	margin:0;
	padding:1em;
		}
}
</style>
<script>
localStorage.setItem("pageIdx","9301")
localStorage.setItem("eqIdx","9000")
$(function(){
	//가맹점일땐 사업자번호 자기걸로 채우고 숨기기
	if(${login.frRegiNum !=9999999999}){
		let frRegiNum='${login.frRegiNum}'
		document.querySelector('[name=demander]').value=frRegiNum;
		document.querySelector('[name=demander]').style.display='none';
		document.querySelector('[for=demander]').style.display='none';
		document.querySelector('[name=demander]').readOnly=true;
	}else{
		//datalist 만들기 - 가맹점 리스트
		fetchActiveList();
	}	
});
</script>
</head>

<body class="container">
	<%@ include file="/resource/templates/header.jsp"%>
	<div class="main_wrapper">
		<%@ include file="/resource/templates/sidebar.jsp"%>
		<div class="contents">
<h2>정산서 조회</h2><hr><br>
<div class="toolbox">
<div class="toolbar">
<div>
<button class="btn-dark" onclick="prevMonth()">전월조회</button>
<button class="btn-dark" onclick="nextMonth()">후월조회</button>
</div>
<button class="btn-success" onclick="window.print()">인쇄</button>
</div>
<div class="toolbar">
<form action="${path }/prodOrderPayDetail.do" method="post">
<div>
<label for="demander">사업자등록번호<input name="demander" value="${prodOrder.demander }" list="storeList" required></label>
<label>조회 월<input name="orderDateMonth" type="month" value="${prodOrder.orderDateMonth }"></label>
</div>
<button>조회</button>
</form>
<datalist id="storeList"></datalist>
</div>
</div>
<script>
function prevMonth(){
	let year = document.querySelector('[name=orderDateMonth]').value.substr(0,4)
	let mon = document.querySelector('[name=orderDateMonth]').value.substr(5,6)
	if(mon!=1){
		mon=(Number(mon)-1)
		if(mon<10){mon='0'+mon}
		document.querySelector('[name=orderDateMonth]').value=year+'-'+mon
	}else{
		document.querySelector('[name=orderDateMonth]').value=(Number(year)-1)+'-12'
	}
	document.querySelector('form').submit();
}

function nextMonth(){
	let year = document.querySelector('[name=orderDateMonth]').value.substr(0,4)
	let mon = document.querySelector('[name=orderDateMonth]').value.substr(5,6)
	if(mon!=12){
		mon=(Number(mon)+1)
		if(mon<10){mon='0'+mon}
		document.querySelector('[name=orderDateMonth]').value=year+'-'+mon
	}else{
		document.querySelector('[name=orderDateMonth]').value=(Number(year)+1)+'-01'
	}
	document.querySelector('form').submit();
}
</script>


<div class="print">
<h1 style="text-align: center;">정산서</h1>
<div class="infotable">
<table>
<tr><th>수신</th><td>${list[0].store.frName}</td><th>구분</th><td>${list[0].prodOrder.paymentState}</td></tr>
<tr><th>사업자번호</th><td>${list[0].store.frRegiNum}</td><th>연락처</th><td>02-753-7917</td></tr>
<tr><th>대표자명</th><td>${list[0].store.frRepName}</td><th>작성일</th><td>2023-03-10</td></tr>
<tr><th>소재지</th><td colspan="3">${list[0].store.frAddress}</td></tr>
</table>
</div>
<script>
var price=0;
var tax=0;
var total=0;
</script>
<table class="table">
<thead>
<tr class="accent"><th colspan="4"><h3>구매내역</h3></th><th>정산기간</th><th colspan="2" >${fn:substring(prodOrder.orderDateMonth,0,4) }년${fn:substring(prodOrder.orderDateMonth,5,7) }월</th></tr>
<tr class="accent"><th>품목번호</th><th>품목명</th><th>단가</th><th>수량</th><th>공급가액</th><th>부가세액</th><th>합계금액</th></tr></thead>
<tbody>
<c:forEach var="ii" items="${list }">
<tr><td>${ii.prodOrder.productNum}</td>
	<td>${ii.product.productName}</td>
	<td><fmt:formatNumber value='${ii.product.price}'/></td>
	<td><fmt:formatNumber value='${ii.prodOrder.amount}'/></td>
	<td><fmt:formatNumber value='${ii.prodOrder.amount * ii.product.price}'/></td>
	<td><fmt:formatNumber value='${ii.prodOrder.amount * ii.product.remark}'/></td>
	<td><fmt:formatNumber value='${ii.prodOrder.amount * ii.product.price + (ii.prodOrder.amount * ii.product.remark)}'/></td>
</tr>
<script>
price =price+Number(${ii.prodOrder.amount * ii.product.price});
tax=tax+Number(${ii.prodOrder.amount * ii.product.remark});
total= total+Number(${ii.prodOrder.amount * ii.product.price + (ii.prodOrder.amount * ii.product.remark)});
</script>
</c:forEach>
</tbody>
<tfoot>
<tr><td colspan="4" class="accent">총 합계금액</td><td id='priceSum'>정산불가</td><td id='taxSum'>정산불가</td><td id='totalSum'style="font-weight: bold;">정산불가</td></tr>
</tfoot>
</table>
</div>

<script type="text/javascript">
document.querySelector('#priceSum').innerText=price.toLocaleString()
document.querySelector('#taxSum').innerText=tax.toLocaleString()
document.querySelector('#totalSum').innerText=total.toLocaleString()
</script>

		</div>
	</div>
</body>
</html>