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

<title>품질관리점검표</title>

<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>


<link rel="stylesheet" href="${path}/resource/css/basicStyle.css" />
<link rel="stylesheet" href="${path}/resource/css/displayingSY.css" />
<style>
  	.addBtn{
		color: #fff;
		background-color: #007bff;
		width:110px;
		height:39px;
		border-radius:10px;
		font-size: 19px;
		text-align: center;/*가로정렬*/
    	line-height: 39px;/*세로정렬*/
		margin: 20px 0;
	}
	.addBtn:hover {
		background-color: #0069d9;
		cursor:pointer;
	}
	.addBtn.focus, .addBtn:focus {
		box-shadow: 0 0 0 .2rem rgba(0, 123, 255, .5)
	}
	
	
	h1#h1ck{
	    text-align: center;
    	margin-bottom: 30px;
	}
	
	/* 버튼 */
	.btn-danger{
		padding: 10px;
		padding: 4px 10px;
    	border-radius: 5px;		
	}
	.btn-secondary{
		padding: 10px;
		padding: 4px 17px;
    	border-radius: 5px;		
	}
	

	table td{
		vertical-align: middle;
	}
	.ctrdata{
		text-align: center;
	}
	
	.row.pBtn_center {
   	 	text-align: center;
   	 	margin: 30px 0;
    }
	
	
	/* 모달 창 */
	.modal {
	  position:absolute;
	  max-width: 1200px;
	  min-width: 1000px;
	  width:100%; 
	  height:100%; 
	  top: 40%;
	  background:rgba(0,0,0,0.8);
	  z-index:100;
	  padding: 120px 110px 300px;
	  margin: auto 0;
	}
	.modal_content{
	  position:relative; 
	  background:#fff; 
	  min-width: 800px;
	  width: 100%;
   	  height: 60%;
	  border-radius:20px;
	  padding: 40px;
	}
	.modal_body{
		display:flex;
		justify-content: space-between;
    	line-height: 100px;
    	width: 100%;
	}
	input#qaItem{
		width: 100%;
    	height: 50px;
	}
	form#addForm {
   	 	width: 80%;
	}
	
	


	

</style>

</head>

<body class="container">
	<%@ include file="/resource/templates/header.jsp"%>
	<div class="main_wrapper">
		<%@ include file="/resource/templates/sidebar.jsp"%>
		<div class="contents">
		
			<h2>품질관리점검표 관리</h2><br><hr><br>
			
			<div class="addBtn" data-toggle="modal" data-target="#addModal">			
			+ 항목추가
			</div>
			
			
			<!-- 표 시작 -->
			<h1 id="h1ck">매장위생안전점검표 전체항목</h1>
			<form  method="post" action="${path}/qaUseable.do">
				<input name="usable" type="hidden" value="">
				<input name="qaNum" type="hidden" value="">
					<table>
						<col width="20%">
						<col width="65%">
						<col width="15%">
						<thead>
							<tr><th>항목번호</th><th>항목</th><th>&nbsp;</th></tr>
						</thead>
						<tbody>
						<%-- <c:forEach var="qal" items="${qalist }">
							<tr><td>${qal.qaNum }</td></tr>
						</c:forEach> --%>
						</tbody>
					
					</table>
			</form>
			<!-- 표 끝 -->
			
			<!-- 페이징처리 시작 -->
			<div class="row pBtn_center">
				<button name="prev" class="pgBtnPrev" onclick="location.href='javascript:goPage(${ql.startBlock-1});'">
					&lt;
				</button>
				<c:forEach var="cnt" begin="${ql.startBlock }" end="${ql.endBlock}">
			  		<button class="pgBtn pg${cnt}" onclick="location.href='javascript:goPage(${cnt});'">
						${cnt}
					</button>
			  	</c:forEach>
			  	<button name="next" class="pgBtnNext" onclick="location.href='javascript:goPage(${ql.startBlock+1});'">
					&gt;
				</button>
			</div>
			<!-- 페이징처리 끝
			<form id="reqSchFrm" method="post" action="${path }/qaList.do">
			 -->
			<form id="reqSchFrm"> 
			 	<input type="hidden" name="curPage" value="${ql.curPage}" />	
			</form>
			
			
			
			<!-- 등록 폼 -->
			<div class="modal" id="addModal" role="dialog" >
				<div class="modal_content">
			      <div class="modal_header">
			        <h3 class="modal_title">항목 추가 등록</h3>
			      </div>
			      <div class="modal_body">
			        <form id="addForm" method="post">
			          <div class="form-group">
			            <input type="text" class="form_control" id="qaItem" name="qaItem" placeholder="등록하시는 항목은 비활성화는 가능하지만 삭제는 할 수 없습니다. 정확히 입력하세요."/>
			          </div>
			        </form>
				      <div class="modal-footer">
				        <button type="button" class="close" >취소</button>
				        <button type="button" class="btn-primary" onclick="add()" disabled>등록</button>
				      </div>
			      </div>
			    </div>
			</div>	
			<!-- 등록 폼 끝-->
			
			
			
			

			
			
		
		</div>
	</div>
</body>


<script>

	//사이드바에 번호 매긴 것 
	localStorage.setItem("pageIdx","6105"); //id값
	localStorage.setItem("eqIdx","6000");
	
	
	
	//표 출력
	var curPage = $("[name=curPage]").val();
	function print(){
		let url="${path}/qaListJson.do?curPage="+curPage
		
		fetch(url).then(function(response){return response.json()}).then(function(json){
			
			var qalist=json.qalist;
			var trtd='';
			var tdA='';
			//var lastqanum=qalist.usable.[qalist.length-1];
			
			qalist.forEach(function(each){		
				if(each.usable=='A'){
					tdA="<td><span class='btn-danger' onclick='changeDA("+each.qaNum+")'>비활성화하기</span></td></tr>"
				}else if(each.usable=='DA'){
					tdA="<td><span class='btn-secondary' onclick='changeA("+each.qaNum+")'>활성화하기</span></td></tr>"
				}			
				trtd+="<tr><td class='ctrdata'>"+each.qaNum+"</td><td>"+each.qaItem+"</td>"+tdA				
				
			})
			$("table tbody").html(trtd);
			//console.log("마지막qanum    "+lastqanum )
			
		}).catch(function(err){console.log(err)})	
	}
	
	$(function() {		
		//표출력
		print();	

		
	})
	
	
	//페이징처리 버튼
	function goPage(cnt){
		$("[name=curPage]").val(cnt);
		$("#reqSchFrm").submit()
		
		print();
	}

	
	if(${ql.curPage==1}){
		$("[name=prev]").attr("disabled",true);
	}
	if(${ql.curPage==ql.endBlock}){
		$("[name=next]").attr("disabled",true)
	}
	
	$(".pg"+${ql.curPage}).css({
		'background' : '#a4a4a4',
		'color' : 'white'
	})
	
	


	
	
	
	//활성화/비활성화
	var form = document.querySelector('form');
  	var usable = form.querySelector('[name=usable]');
  	var qanum = form.querySelector('[name=qaNum]');	
	
  	function changeDA(qaNum){	
		
		 Swal.fire({
			title: '해당 문항을 비활성화하시겠습니까?',
		  	icon: 'question',
		  	showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
		  	confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
		 	cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
		 	confirmButtonText: '확인', // confirm 버튼 텍스트 지정
		  	cancelButtonText: '취소' // cancel 버튼 텍스트 지정
		}).then((result) => {
		  if (result.value) {
				usable.value='DA';
				qanum.value=qaNum;
				form.submit();
			
			  Swal.fire({
				  title: '비활성화되었습니다',
				  icon: 'success',
				  showCancelButton: false, // cancel버튼 보이기. 기본은 원래 없음
				  confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
				  confirmButtonText: '확인' // confirm 버튼 텍스트 지정
				}).then((result) => {
				  if (result.value) {
				  }
				})
		  }
		})
	}	
  	
  	
	function changeA(qaNum){
		
		Swal.fire({
			title: '해당 문항을 활성화하시겠습니까?',//A로바뀜
		  	icon: 'question',
		  	showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
		  	confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
		 	cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
		 	confirmButtonText: '확인', // confirm 버튼 텍스트 지정
		  	cancelButtonText: '취소' // cancel 버튼 텍스트 지정
		}).then((result) => {
		  if (result.value) {
			  	usable.value='A';
				qanum.value=qaNum;
				form.submit();
			
			  Swal.fire({
				  title: '활성화되었습니다',
				  icon: 'success',
				  showCancelButton: false, // cancel버튼 보이기. 기본은 원래 없음
				  confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
				  confirmButtonText: '확인' // confirm 버튼 텍스트 지정
				}).then((result) => {
				  if (result.value) {
				  }
				})
		  }
		})
		
		
	}

	
	

	/* 모달에서 등록 */
	//항목등록
	function add() {
	  var qaItem = $("#qaItem").val();
	  
	  $.ajax({
	    type: "POST",
	    url: "${path}/qaAdd.do",
	    data: { qaItem: qaItem },
	    success: function(data) {	
	
	 		Swal.fire({
			  title: '항목이 등록되었습니다',
			  icon: 'success',
			  showCancelButton: false, // cancel버튼 보이기. 기본은 원래 없음
			  confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
			  confirmButtonText: '확인', // confirm 버튼 텍스트 지정
			}).then((result) => {
			if (result.value) {
				$(".modal").fadeOut();
		        print();
			  }
			})
        	
	    },	    
	    
	    error: function(xhr, status, error) {
	      alert("서버와의 통신에 실패했습니다.");
	    }  
	  });
	  
	}
	
	//등록폼 열기
	$(".addBtn").click(function(){
		$(".modal").fadeIn();
	});
	//취소버튼
	$(".close").click(function(){
		$(".modal").fadeOut();
	});

	//등록버튼
	$(".form_control").on("input", function() {
		
		var qaItem = $("#qaItem").val();
		if (qaItem.length > 0 ) {
			$(".btn-primary").prop("disabled", false);			
	  	} else {
	    	$(".btn-primary").prop("disabled", true);
	  	}
	});
	
	$(".form_control").on("keyup", function(event) {
		var qaItem = $("#qaItem").val();

	  	if (qaItem.length > 0 && event.keyCode === 13) { 
	  		add()
	  	}
	});
	




	

	

</script>
</html>