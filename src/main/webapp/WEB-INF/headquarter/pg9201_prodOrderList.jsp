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
<title>발주목록 조회</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>

<link rel="stylesheet" href="${path}/resource/css/basicStyle.css" />
<link rel="stylesheet" href="${path}/resource/css/displayingSY.css" />
<script type="text/javascript" src="${path }/resource/js/sy_fetchs.js"></script>
<script type="text/javascript" src="${path }/resource/js/sy_modal.js"></script>

<c:if test="${login.frRegiNum == 9999999999 }">
<style>
.main_wrapper td:nth-child(1),.main_wrapper td:nth-child(2),.main_wrapper td:nth-child(3),.main_wrapper td:nth-child(7),.main_wrapper td:nth-child(8){
	text-align:center;
	}
.main_wrapper td:nth-child(5),.main_wrapper td:nth-child(6){
	text-align:right;
}
.modal-body td:nth-child(3){
	text-align:right;
}
</style>
</c:if>

<c:if test="${login.frRegiNum != 9999999999 }"><style>
.main_wrapper td:nth-child(1),.main_wrapper td:nth-child(4),.main_wrapper td:nth-child(5),.modal-body td:nth-child(1){
	text-align:center;
	}
.main_wrapper td:nth-child(3),.main_wrapper td:nth-child(6),.modal-body td:nth-child(3){
	text-align:right;
}
</style></c:if>
</head>

<body class="container">
<script>
localStorage.setItem("pageIdx","9201")
localStorage.setItem("eqIdx","9000")
</script>
	<%@ include file="/resource/templates/header.jsp"%>
	<div class="main_wrapper">
		<%@ include file="/resource/templates/sidebar.jsp"%>
		<div class="contents">
	<h2>발주 조회</h2>
	<hr>
	<br>
	<div class="toolbox">
	<form id="searchform">
	<h3>조회 기간 선택</h3>
	<div class="toolbar">
		<div>
			<label>주문일자 <input type="date" name="orderDate" required><div style="position: absolute;font-size: 0.8em;color: #007bff;">주문일자,월별 조회, 발주번호 중 하나의 조건을 입력하세요</div></label>
			<label>월별 조회 <input type="month" name="orderDateMonth" required disabled></label>
			<label title="발주번호를 검색조건으로 사용합니다">발주번호<input placeholder="발주번호로 검색" name="orderNum" required disabled></label>
		</div>
	</div>
	<h3>추가 조건 지정</h3>
	<div class="toolbar" title="조건은 다중적용이 가능합니다">
	<div>
	<fieldset class="noDisplayForStores">
		<label>주문지점<input name="demander" list="storeList"></label><datalist id="storeList"></datalist>
		<label>담당자<input name="supplier" list="empList"></label><datalist id="empList"></datalist>
	</fieldset>
		<label>상품 선택<input name="productNum" list="productList"></label><datalist id="productList"></datalist>
		<label>발주상태<select name="orderState"><option value="">전체 보기</option><option>요청</option><option>배송중</option><option>완료</option><option>조정중</option><option>발주취소</option></select></label>
		<label>결제상태<select name="paymentState"><option value="">전체 보기</option><option>정산전</option><option>청구</option><option>계산서 발행</option><option>완료</option><option>취소</option></select></label>
	</div>
	<div style="position: relative;">
<c:if test="${login.frRegiNum == 9999999999 }">
		<button type="button" id="list999" style="position: absolute;right:0px;bottom: 60px;">본사물류조회</button>
</c:if>
		<button class="btn-secondary">발주조회</button>
	</div>
	</div>
	</form>
	</div>
<table>
<thead>
	<c:if test="${login.frRegiNum == 9999999999 }">
	<tr><th class="sorted" onclick="sortList(this,'prodOrder','orderDate')">주문일자</th><th class="sorted" onclick="sortList(this,'store','frName')">주문지점</th><th class="sorted" onclick="sortList(this,'emp','ename')">담당자</th><th><span class="sorted" onclick="sortList(this,'product','productName')">자재</span> <button class="btn-sm">자재별 보기</button></th>
	<th class="sorted" onclick="sortList(this,'prodOrder','amount')">수량</th><th class="sorted" onclick="sortList(this,'stock','remainAmount')">본사 재고</th><th class="sorted" onclick="sortList(this,'prodOrder','orderState')">배송상태</th><th class="sorted" onclick="sortList(this,'prodOrder','paymentState')">결제상태</th></tr>
	</c:if>
	
	<c:if test="${login.frRegiNum != 9999999999 }">
	<tr><th>주문일자</th><th>자재 <button class="btn-sm">자재별 보기</button></th><th>수량</th><th>배송상태</th><th>결제상태</th></tr>
	</c:if>
</thead>
<tbody>

</tbody>
</table>
		</div>
	</div>
<div class="modal" id="modalByProd">
<div class="modal-dialog">

 <div class="modal-header">
        <h3 class="modal-title">상품별 수량</h3>
        <button class="btn-close">&nbsp; &nbsp;</button>
      </div>
 <div class="modal-body">
<form id="orderStateForm">
<div style="display: none">
<input name="orderNum" placeholder="orderNum">
<input name="orderDate" placeholder="orderDate">
<input name="demander" placeholder="demander">
<input name="supplier" placeholder="담당자">
<input name="productNum" placeholder="productNum">
<input name="orderState">
<input name="paymentState">
<input name="orderStateUpdate" placeholder="orderStateUpdate">
</div>
	<table><thead><th>자재코드</th><th>자재명</th><th>총 수량</th><c:if test="${login.frRegiNum == 9999999999 }"><th>상태 일괄 변경</th></c:if></thead>
	<tbody></tbody>
	</table>
</form>


</div>
</div>
</div>
	
	
<script>
//submit 비동기로 불러와서 표에 출력하기
var resultlist=[];
const form1= document.querySelector('#searchform')
form1.addEventListener('submit', (e) => {
   e.preventDefault();
   selectProdOrderListJson();
})


//fetch받아서 전체 목록 출력하고 상품별 수량 모달 만들기
function selectProdOrderListJson(){
    fetchSelectPromise('#searchform',"${path }/productOrderListJson.do?").then(json=>{
    	resultlist=json.list
    	let htmls=htmlPrint(resultlist)	//인쇄할 코드 만들기
		printTotalAmountbyProd(resultlist,(json.prodOrder.orderDate!=null||json.prodOrder.orderNum!=null));
		document.querySelector('tbody').innerHTML=htmls
		updateState();
		$('#modalByProd [name=orderNum]').val(json.prodOrder.orderNum)
		$('#modalByProd [name=orderDate]').val(json.prodOrder.orderDate)
		$('#modalByProd [name=demander]').val(json.prodOrder.demander)
		$('#modalByProd [name=supplier]').val(json.prodOrder.supplier)
		$('#modalByProd [name=productNum]').val(json.prodOrder.productNum)
		$('#modalByProd [name=orderState]').val(json.prodOrder.orderState)
		$('#modalByProd [name=paymentState]').val(json.prodOrder.paymentState)
    }).catch(function(err){console.log(err)})
} 

function htmlPrint(list){
	let htmls='';
	list.forEach(function(each){
		htmls+=`<tr><td title="`+each.prodOrder.orderDate+`">`+each.prodOrder.orderDate.substr(0,10)
		<c:if test="${login.frRegiNum == 9999999999 }">
			+`</td><td title="`+each.prodOrder.demander+`">`+each.store.frName
			+`</td><td title="`+each.emp.empnum+`">`+each.emp.ename
		</c:if>
			+`</td><td title="`+each.prodOrder.productNum+`">`+each.product.productName
			+`</td><td>`+each.prodOrder.amount
		<c:if test="${login.frRegiNum == 9999999999 }">
			+`</td><td>`+each.stock.remainAmount
		</c:if>
		<c:if test="${login.frRegiNum != 9999999999 }">
			+`</td><td>`+each.prodOrder.orderState
		</c:if>
		<c:if test="${login.frRegiNum == 9999999999 }">
			+`</td><td>`+`<select id='`+each.prodOrder.productNum+each.prodOrder.orderDate.substr(0,10)+each.prodOrder.demander+`'>`;	//id에 지점 일자 상품 들어가야됨
			if(each.prodOrder.orderState=='요청'){htmls+=`<option selected>요청</option><option>배송중</option>`}
			if(each.prodOrder.orderState=='배송중'){htmls+=`<option selected>배송중</option><option>완료</option>`}
			if(each.prodOrder.orderState=='완료'){htmls+=`<option selected>완료</option>`}
			if(each.prodOrder.orderState=='조정중'){htmls+=`<option selected disabled>조정중</option>`}
			if(each.prodOrder.orderState=='발주취소'){htmls+=`<option selected disabled>발주취소</option>`}
			htmls+=`</select>`
		</c:if>
			+`</td><td>`+each.prodOrder.paymentState
			+`</td></tr>`;
	})
	return htmls;
}


//모달에서 상품별 전체수량 볼때 배송상태 일괄변경 버튼에 이벤트 할당하는 함수
function totalUpdateBtn(){
	$('#orderStateForm .btn-sm').on('click',function(){
		let prodnum=$(this).attr('id');
		let stateupdate=$(this).text();
		$('#orderStateForm [name=productNum]').val(prodnum)
		$('#orderStateForm [name=orderStateUpdate]').val(stateupdate)
		fetchUpdatePromise('#orderStateForm','${path}/updateOrderState.do?')
		.then(function(result){
			 alert(`배송상태 변경 `+result);
			 selectProdOrderListJson();
		}).catch(function(reject){
			console.error(reject);
			alert(`배송상태 변경에 실패했습니다.`)
			})
	})
}
//개별 select로 상태 업뎃하는 이벤트 리스너도 추가
function updateState(){
	let selects=document.querySelectorAll('td select');
	selects.forEach(function(each){
		let productNum=(each.id.substr(0,7))
		let orderDate=(each.id.substr(7,10))
		let demander=(each.id.substr(17,10))
		each.addEventListener('change',function(){
			if(confirm('배송상태를 변경할까요?')){
				$('#orderStateForm [name=productNum]').val(productNum)
				$('#orderStateForm [name=orderDate]').val(orderDate)
				$('#orderStateForm [name=demander]').val(demander)
				$('#orderStateForm [name=orderStateUpdate]').val(this.value)
				fetchUpdatePromise('#orderStateForm','${path}/updateOrderState.do?').then(function(result){
					 alert(`배송상태 변경 `+result);
					 selectProdOrderListJson();}).catch(function(reject){console.error(reject);
					 	alert(`배송상태 변경에 실패했습니다.`)})
			}else{
				return false;
			}
		})
	})
	
}

//fetch결과로 상품별 총 주문량 보여주기(모달에 출력)
function printTotalAmountbyProd(list,isDaily){
	var jsonprodAmount=[]
	list.forEach(function(each){
		let nullornot = jsonprodAmount.find(v => v.num === each.prodOrder.productNum)
		if(nullornot!=null){
			let amnt=nullornot.amount
			nullornot.amount= amnt+each.prodOrder.amount
		}else{
			let prodjson=new Object();
			prodjson.num = each.prodOrder.productNum;
			prodjson.name = each.product.productName;
			prodjson.amount=each.prodOrder.amount
			prodjson.orderState=each.prodOrder.orderState
			jsonprodAmount.push(prodjson)
		}
	})
	//여기까지 json 배열 생성한거, 아래서 출력하기	
	let htmls='';
	jsonprodAmount.forEach(function(each){
	<c:if test="${login.frRegiNum == 9999999999 }">
	//본사일때
		if(isDaily){
			htmls+=`<tr><td>`+each.num+`</td><td>`+each.name+`</td><td>`+each.amount+`</td><td title="조회한 조건에 따라 발주 상태가 변경됩니다."><button type="button" class="btn-primary btn-sm" id="`+each.num+`">배송중</button> <button type="button" class="btn-success btn-sm" id="`+each.num+`">완료</button></td></tr>`
		}else{
			htmls+=`<tr><td>`+each.num+`</td><td>`+each.name+`</td><td>`+each.amount+`</td><td>일자별 조회시 일괄변경 가능</td></tr>`
		}
	</c:if>
	<c:if test="${login.frRegiNum != 9999999999 }">
	//가맹점일때
		htmls+=`<tr><td>`+each.num+`</td><td>`+each.name+`</td><td>`+each.amount+`</td></tr>`
	</c:if>
	})
	$('#modalByProd tbody').html(htmls)
	<c:if test="${login.frRegiNum == 9999999999 }">
	totalUpdateBtn()
	</c:if>
}

$(function(){
	//오늘 날짜 기본 입력
	$('[type=date]').val(new Date().toISOString().slice(0, 10));
	//로딩할때 날짜만 활성화되어있게
	$('[type=date]').trigger("click");
	//datalist 만들기 - 가맹점 리스트
	fetchActiveList();
	//가맹점은 주문지점 담당자 선택 못하게
	if(${login.frRegiNum !=9999999999}){
		$(".noDisplayForStores").css("display","none")
		$('[name=demander]').val('${login.frRegiNum}')
	}
	//로딩하자마자 오늘거 검색
	selectProdOrderListJson();
	
	//모달 버튼 할당
	openModal('#modalByProd','th .btn-sm')
	
	//셋 중 하나만 입력할 수 있게
	$('.toolbar').first().find('label').each(function(){
		$(this).on('click',function(){
			$('.toolbar').first().find('label').each(function(){
				$(this).find('input').attr("disabled",true);
			})
			$(this).find('input').attr("disabled",false);
			$(this).find('input').focus();
		})
	})
});

const btn999=document.querySelector('#list999')
if(btn999!=null){
	btn999.addEventListener('click',function(){
		 fetchSelectPromise('#searchform',"${path }/productOrderList999.do?").then(json=>{
		    resultlist=json.list
		   	let htmls=htmlPrint(resultlist)	//인쇄할 코드 만들기
			printTotalAmountbyProd(resultlist,(json.prodOrder.orderDate!=null||json.prodOrder.orderNum!=null));
			document.querySelector('tbody').innerHTML=htmls
			updateState();
			$('#modalByProd [name=orderNum]').val(json.prodOrder.orderNum)
			$('#modalByProd [name=orderDate]').val(json.prodOrder.orderDate)
			$('#modalByProd [name=demander]').val('9999999999')
			$('#modalByProd [name=supplier]').val(json.prodOrder.supplier)
			$('#modalByProd [name=productNum]').val(json.prodOrder.productNum)
			$('#modalByProd [name=orderState]').val(json.prodOrder.orderState)
			$('#modalByProd [name=paymentState]').val(json.prodOrder.paymentState)
	    }).catch(function(err){console.log(err)})
	})
}
</script>
</body>
</html>