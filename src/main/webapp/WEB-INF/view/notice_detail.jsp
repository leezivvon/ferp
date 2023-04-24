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
<title>공지사항 상세조회</title>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<link rel="stylesheet" href="/ferp/resource/css/notice_detail.css"/>
<link rel="stylesheet" href="${path}/resource/css/reset.css"/>
<link rel="stylesheet" href="${path}/resource/css/store_main_index.css"/>
</head>
<script type="text/javascript">
	localStorage.setItem("pageIdx","5001")
	localStorage.setItem("eqIdx","5000")
</script>
<body class="container">
	<%@ include file="/resource/templates/header.jsp"%>
	<div class="main_wrapper">
		<%@ include file="/resource/templates/sidebar.jsp"%>
		<div class="contents">
          	<h2 class="notice_main">공 지 사 항</h2>
          	<input type="hidden" name="buttonChk" value="${not empty login.ename?'본사':'매장'}">
          	<div class="title_line">
          		<h3 class="notice_title">${notice.title}</h3>
          		<div>
	          		<span>등록일 : <fmt:formatDate value="${notice.regdte}" pattern="yyyy-MM-dd"/></span>
	          		<span style="padding: 0px 15px;">조회수 : ${notice.readCnt}</span>
          		</div>
          	</div>
			
			<div class="notice_content">
				<pre>${notice.content}</pre>
			</div>
	        <div class="file_line">
		        <label>첨 부 파 일</label>
		        <input id="downFile" value="${notice.fname}" type="text" placeholder="등록된 파일이 없습니다." required readonly="readonly">
			</div>
			<div class="btn_line">
			  <button id="goMain" type="button">목 록</button>
	          <button id="uptBtn" type="button">수 정</button>
	          <button id="delBtn" type="button">삭 제</button>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
$(document).ready(function(){
	var store = $("[name=buttonChk]").val()
	if( store == '매장' ){
		$("#uptBtn").hide()
		$("#delBtn").hide()
	}
	<%-- 
	
	--%>
	var fname = '${notice.fname}'
	$("#downFile").click(function(){
		  Swal.fire({
			  title: '파일을 다운로드\n 하시겠습니까?',
			  icon: 'question',
			  showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
			  confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
			  cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
			  confirmButtonText: '확인', // confirm 버튼 텍스트 지정
			  cancelButtonText: '취소' // cancel 버튼 텍스트 지정
			}).then((result) => {
			  if (result.value) {
				//"확인" 버튼을 눌렀을 때 작업할 내용
				if(fname == ''){
					  Swal.fire({
						  title: '등록된 파일이 없습니다.',
						  icon: 'warning',
						  showCancelButton: false, // cancel버튼 보이기. 기본은 원래 없음
						  confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
						  confirmButtonText: '확인', // confirm 버튼 텍스트 지정
						}).then((result) => {
						  if (result.value) {
							//"확인" 버튼을 눌렀을 때 작업할 내용
						  }
						})
				}else{
					location.href = "${path}/download.do?fname="+$(this).val()
				}
			  }
			})	
	})
	$("#goMain").click(function() {
		  Swal.fire({
			  title: '조회페이지로 이동하시겠습니까?',
			  icon: 'question',
			  showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
			  confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
			  cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
			  confirmButtonText: '확인', // confirm 버튼 텍스트 지정
			  cancelButtonText: '취소' // cancel 버튼 텍스트 지정
			}).then((result) => {
			  if (result.value) {
				//"확인" 버튼을 눌렀을 때 작업할 내용
				location.href = "${path}/noticeList.do"
			  }
			})	
	})
	$("#uptBtn").click(function(){
		  Swal.fire({
			  title: '수정페이지로\n 이동하시겠습니까?',
			  icon: 'question',
			  showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
			  confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
			  cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
			  confirmButtonText: '확인', // confirm 버튼 텍스트 지정
			  cancelButtonText: '취소' // cancel 버튼 텍스트 지정
			}).then((result) => {
			  if (result.value) {
				//"확인" 버튼을 눌렀을 때 작업할 내용
				location.href = "${path}/noticeUpdate.do?noticeNum="+'${notice.noticeNum}'
			  }
			})	
	})
	$("#delBtn").click(function(){
		  Swal.fire({
			  title: '해당 공지사항을\n 삭제하시겠습니까?',
			  icon: 'warning',
			  showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
			  confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
			  cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
			  confirmButtonText: '확인', // confirm 버튼 텍스트 지정
			  cancelButtonText: '취소' // cancel 버튼 텍스트 지정
			}).then((result) => {
			  if (result.value) {
				location.href = "${path}/noticeDelete.do?noticeNum="+'${notice.noticeNum}'
			  }
			})	
	})
});
</script>
</html>