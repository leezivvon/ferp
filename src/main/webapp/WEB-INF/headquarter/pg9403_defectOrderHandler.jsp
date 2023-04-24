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
<title>배송 불량 신청 관리</title>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" href="${path}/resource/css/basicStyle.css" />
<link rel="stylesheet" href="${path}/resource/css/displayingSY.css" />
<script type="text/javascript" src="${path }/resource/js/sy_fetchs.js"></script>
<script type="text/javascript" src="${path }/resource/js/sy_modal.js"></script>
<script type="text/javascript" src="${path }/resource/js/sy_validateCheck.js"></script>
<script type="text/javascript" src="${path }/resource/js/dateValid.js"></script>
<style>
[type=checkbox]{
width:1.3em;
height: 1.3em;
}
h4{
vertical-align: bottom;
padding:0px;
margin:0px;
}
td:nth-child(1),td:nth-child(4),td:nth-child(5){text-align:center;}
td:nth-child(6){text-align: right;}
#modal #buttons{
	display: flex;
	flex-direction: column;
}
#modal #buttons button{
	margin-bottom: 0.5em;
	margin-left: 0.5em;
	min-width: 4em;
	}
#modal span{
font-weight: bold;
margin-left:0.3em;
margin-right:0.7em;
}
</style>
<script type="text/javascript">
	localStorage.setItem("pageIdx","9403")
	localStorage.setItem("eqIdx","9000")
</script>
</head>

<body class="container">
	<%@ include file="/resource/templates/header.jsp"%>
	<div class="main_wrapper">
		<%@ include file="/resource/templates/sidebar.jsp"%>
		<div class="contents">
<h2>배송 불량 신청 관리</h2><hr>	<br>
<div class="toolbar">
<form id="searchForm">
	<div>
		<label>조회시작 신청일<input onchange="dateMinMax('[name=applyDate]','[name=orderDateMonth]')" name='applyDate' type='date' required value='${defectOrder.applyDate }'></label>
		<label>조회종료 신청일<input onchange="dateMinMax('[name=applyDate]','[name=orderDateMonth]')" name='orderDateMonth' type='date' value='${defectOrder.orderDateMonth }'></label>
		<label>신청번호<input name='defNum' value='${defectOrder.defNum}'></label>
		<label title="사업자번호를 입력하세요">주문지점<input name='frRegiNum' list="storeList" value='${defectOrder.frRegiNum}'></label><datalist id='storeList'></datalist>
		<label title="사원번호를 입력하세요">담당자<input name='category' list="empList" value='${defectOrder.category }'></label><datalist id='empList'></datalist>
		<label>처리상태<select name='state'><option value="">전체 보기</option><option>대기</option>	<option>처리중</option><option>완료</option><option>취소</select></label>
		<label>처리방식<select name='methods'><option value="">전체 보기</option><option>재배송</option><option>환불</option></select></label>
	</div>
	<button>조회</button>	
</form>
</div>		

<table>
<thead>
<tr><th>신청일자</th><th>신청지점</th><th>해당상품</th><th>종류</th><th>처리방식</th><th>처리상태</th></tr>
</thead>
<tbody>

</tbody>
</table>


		</div>
	</div>
	
	
<div class="modal" id='modal'><div class="modal-dialog">
<div class="modal-header"><h2 class="modal-title">불량신청건 처리</h2><button class="btn-close">&nbsp; &nbsp;</button></div>
<div class="modal-body">
<form action="${path }/updateDefectOrder.do" method="post" id="updateForm">
	<h4>신청 상태 조정</h4>
	<img style='display: block;max-width: 500px;max-height: 500px;'>
	<div class="toolbar">
		<div><ul>
			<li>신청지점 : <span id='frName'></span><input name='frRegiNum' type="hidden">
			<li>신청번호 : <span id="defNum"></span><input name='defNum' type="hidden">
			<li>신청자재 : <span id='productName'></span> <input name='productNum' type="hidden">
			<li>신청일 : <span id="applyDate"></span>
			<li>불량종류 : <span id="type"></span>
			<li>처리상태 : <span id='state'></span> <input name='state' type="hidden" required="required">
		</ul></div>
		<div><ul>
			<li>발주번호 : <span id="orderNum"></span>
			<li>발주신청일자 : <span id="orderDate"></span>
			<li>주문수량 : <span id='amount'></span>			
			<li>발주상태 : <span id='orderState'></span>			
		</ul></div>
		<div id="buttons">
			<span id='feedback' class="valid-feedback" >처리상태를 변경하세요</span>
			<button type="button">처리중</button>
			<button type="button">완료</button>
			<button type="button">취소</button>
		</div>
	</div>

	<h4><label><input type="checkbox" checked class='stockbar'>재고 수량 조정</label></h4>
	<div class="toolbar stockbar">
		<div>
		<label>적용수량<input name="applyAmount" type="number" required></label>
		<label>비고<input name="remark"></label></div>
	</div>
	<h4><label><input type="checkbox" checked class='prodOrderbar'>발주 기록 수정</label></h4>
	<div class="toolbar prodOrderbar"><div>
		<input name='orderNum' placeholder="발주번호" type="hidden">
		<input name='orderDate' placeholder="발주신청일자" type="hidden">
		<div>
		<label>변경수량<input name="amount" required></label>
		<label>발주상태<select name="orderState"><option>요청</option><option>조정중</option><option>발주취소</option></select></label>
		<label>비고<input name="remark"></label></div>
	</div></div>
	<button class="btn-primary">등록하기</button>
</form>
</div></div></div>


<script type="text/javascript">

/* document.querySelector('[type=checkbox].stockbar').addEventListener('change',function(self){
	console.log(self)
})
 */

function checkdis(param){
 	var selecter='.toolbar.'+param+' input, .toolbar.'+param+' select'
	var checkbox=document.querySelector('[type=checkbox].'+param)
	checkbox.addEventListener('change',function(){
		if(checkbox.checked==true){
			$(selecter).attr('disabled',false)
		}else{
			$(selecter).attr('disabled',true)
		}
	})
}
checkdis('stockbar')
checkdis('prodOrderbar')

function filltheform(dpslist){
	$('.modalOpen').on('click',function(){
		var idindex=$(this).attr('id')
		console.log(dpslist[idindex])
		$('#modal input').attr('disabled',false)
		$('#modal [type=checkbox]').prop('checked',true)
		//체크박스도 다 체크
		if(dpslist[idindex].defectOrder.img!=null){
			$('#modal img').attr('src','${path }/resource/img/defectOrder/'+dpslist[idindex].defectOrder.img)
			$('#modal img').css('display','block');
		}else{
			$('#modal img').css('display','none');
		}
		$('#modal #frName').text(dpslist[idindex].store.frName)
		$('#modal [name=frRegiNum]').val(dpslist[idindex].defectOrder.frRegiNum)
		$('#modal #defNum').text(dpslist[idindex].defectOrder.defNum)
		$('#modal [name=defNum]').val(dpslist[idindex].defectOrder.defNum)
		$('#modal #productName').text(dpslist[idindex].product.productName)
		$('#modal [name=productNum]').val(dpslist[idindex].defectOrder.productNum)
		$('#modal #applyDate').text(dpslist[idindex].defectOrder.applyDate)
		$('#modal #type').text(dpslist[idindex].defectOrder.type)
		$('#modal #state').text(dpslist[idindex].defectOrder.state)
		
		$('#modal #orderNum').text(dpslist[idindex].defectOrder.orderNum)
		$('#modal #orderDate').text(dpslist[idindex].defectOrder.orderDate)
		$('#modal #amount').text(dpslist[idindex].prodOrder.amount)
		$('#modal #orderState').text(dpslist[idindex].prodOrder.orderState)
		
		$('#modal #methods').text(dpslist[idindex].defectOrder.methods)
		$('#modal [name=orderNum]').val(dpslist[idindex].defectOrder.orderNum)
		$('#modal [name=orderDate]').val(dpslist[idindex].defectOrder.orderDate)	
	})
	
	$('#modal .toolbar button').on('click',function(){
		let thistext=$(this).text()
		$('#modal [name=state]').val(thistext)
		$('.toolbar button').removeClass('btn-success')
		$(this).addClass('btn-success')
	}) 

}

function search(){
	fetchSelectPromise("#searchForm","${path }/selectDefectOrderJSON.do?").then(function(result){
		var dpslist=result.list
		var htmls='';
		for(let i=0;i<dpslist.length;i++){
			htmls+='<tr><td>'+dpslist[i].defectOrder.applyDate.substr(0,10)
			+'</td><td>'+dpslist[i].store.frName
			+'</td><td>'+dpslist[i].product.productName
			+'</td><td>'+dpslist[i].defectOrder.type
			+'</td><td>'+dpslist[i].defectOrder.methods
			+'</td><td>'+dpslist[i].defectOrder.state+` <button class='modalOpen' id='`+i+`'>변경</button>`
			+'</td></tr>'
		}
		document.querySelector('tbody').innerHTML=htmls;
		openModal('#modal','.modalOpen')	//모달 오픈 이벤트 할당
		filltheform(dpslist)
	}).catch(function(error){console.error(error);}
)}

const searchForm = document.querySelector('#searchForm');
searchForm.addEventListener('submit', function(e){
    e.preventDefault();	//submit 방지
    search();
})

const updateForm = document.querySelector('#updateForm');
updateForm.addEventListener('submit',function(e){
	e.preventDefault();
	let statelength = $('#modal [name=state]').val().length;
	if(statelength<2){
		//유효성 불합격
		invalidClass('#modal .toolbar button','#feedback')
		$('#modal .toolbar button').addClass('btn-danger');
		setTimeout(function(){
			validClass('#modal .toolbar button','#feedback');
			$('#modal .toolbar button').removeClass('btn-danger');
		},3000,'#modal .toolbar button','#feedback');
		return false;
	}else{
		validClass('#modal .toolbar button','#feedback')
		$('#modal .toolbar button').removeClass('btn-danger');
		updateForm.submit();
	}
})

$('[type=date]').val(new Date().toISOString().slice(0, 10));
fetchActiveList()
</script>
	
</body>
</html>