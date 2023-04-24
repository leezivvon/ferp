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
<title>매장정보 수정</title>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<link rel="stylesheet" href="/ferp/resource/css/store_insert.css"/>
<link rel="stylesheet" href="${path}/resource/css/reset.css"/>
<link rel="stylesheet" href="${path}/resource/css/store_main_index.css"/>
</head>
<script type="text/javascript">
	localStorage.setItem("pageIdx","4201")
	localStorage.setItem("eqIdx","4000")
</script>
<body class="container">
	<%@ include file="/resource/templates/header.jsp"%>
	<div class="main_wrapper">
		<%@ include file="/resource/templates/sidebar.jsp"%>
		<div class="contents">
    	    <h2 class="insert_product">매 장 정 보 수 정</h2>
        	<div class="content">
        	<form method="post">
				<div class="first_line">
					<h3 class="store_num">사업자번호</h3>
					<h3 class="store_pass">비밀번호</h3>
				</div>
				<div class="second_line">
					<input type="text" name="frRegiNum" value="${store.frRegiNum}" placeholder="사업자번호 입력" readonly="readonly" disabled="disabled">
					<input type="text" name="frPass" value="${store.frPass}" placeholder="비밀번호 입력">
				</div>
				<div style="display: flex;justify-content: flex-end;">
					<p class="frPassComment"></p>
				</div>
				<div class="third_line">
					<h3 class="store_name">매장명</h3>
					<h3 class="store_address">주소</h3>
				</div>
				<div class="fourth_line">
					<input type="text" name="frName" value="${store.frName}" placeholder="매장명 입력" readonly="readonly">
					<input type="text" name="frAddress" value="${store.frAddress}" placeholder="주소 입력" readonly="readonly">
				</div>
				<div class="fifth_line">
					<h3 class="store_opertime">운영시간</h3>
					<h3 class="store_closeDte">휴무일</h3>
				</div>
				<div class="sixth_line">
					<input type="text" name="frOperTime" value="${store.frOperTime}" placeholder="운영시간 입력">				
					<input type="text" name="frClosedDte" value="${store.frClosedDte}" placeholder="휴무일 입력">
				</div>
				<div style="display: flex; justify-content: space-between;">
					<p class="frOperTimeComment"></p>
					<p class="frClosedDteComment"></p>
				</div>
				<div class="seventh_line">
					<h3 class="store_repName">대표자명</h3>
					<h3 class="store_tel">전화번호</h3>
				</div>
				<div class="eighth_line">
					<input type="text" name="frRepName" value="${store.frRepName}" placeholder="대표자명 입력">				
					<input type="text" name="frTel" value="${store.frTel}" placeholder="전화번호 입력">
				</div>
				<div style="display: flex;justify-content: flex-end;">
					<p class="frTelComment"></p>
				</div>				
				<div class="ninth_line">
					<h3 class="store_eno">담당직원</h3>
					<h3 class="store_address">이메일</h3>
				</div>
				<div class="tenth_line">
					<select name="empNum">
						<option disabled="disabled" selected="selected">담당직원 선택</option>
						<c:forEach var="emp" items="${empCombo}">
							<c:if test="${emp.ename ne 'admin'}">
							<option value="${emp.empnum}">${emp.ename}</option>
							</c:if>
						</c:forEach>
					</select>	
					<input type="hidden" id="empNumHidden" value="${store.empNum}">
					<input type="text" name="email" value="${store.email}" placeholder="이메일 입력">
				</div>					
				<div style="display: flex;justify-content: flex-end;">
					<p class="emailComment"></p>
				</div>		
						
				<div class="submit_line">
					<button type="button" class="uptBtn">수 정</button>
				</div>	
			</form>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
$(document).ready(function(){
	$("[name=empNum] option").each(function(idx, opt) {
		if($(this).val() == $("#empNumHidden").val()){
			$(this).attr("selected", "selected")
		}
	})
	var isPass1 = true;
	var isPass2 = true;
	var isPass3 = true;
	var isPass4 = true;
	var isPass5 = true;	
	$("[name=frPass]").keyup(function(){
		var pw = $(this).val()
		var number = pw.search(/[0-9]/g);
		var english = pw.search(/[a-z]/ig);
		var spece = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
		var reg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/;
		
        if (pw.length < 5 || pw.length > 15) {
        	$(this).addClass("isNotPass")
            $(".frPassComment").text("5자리 ~ 15자리 이내로 입력해주세요.")
            isPass1 = false;	
        } else if (pw.search(/\s/) != -1) {
        	$(this).removeClass("isNotPass")
        	$(".frPassComment").text("비밀번호는 공백 없이 입력해주세요.")
        	$(this).addClass("isNotPass")
        	isPass1 = false;
        } else if ((number < 0 && english < 0) || (english < 0 && spece < 0) || (spece < 0 && number < 0)) {
        	$(this).removeClass("isNotPass")
        	$(".frPassComment").text("영문,숫자, 특수문자 중 2가지 이상을 혼합하여 입력해주세요.")
        	$(this).addClass("isNotPass")        
        	isPass1 = false;
        } else if (/(\w)\1\1\1/.test(pw)) {
        	$(this).removeClass("isNotPass")
        	$(".frPassComment").text("같은 문자를 4번 이상 사용하실 수 없습니다.")
        	$(this).addClass("isNotPass")  
        	isPass1 = false;
        } else {
        	$(this).removeClass("isNotPass")
        	$(".frPassComment").text("");
        	isPass1 = true;
        }
	})	
	$("[name=frOperTime]").keyup(function(){
		var frOperTime = $(this).val()
		var regfrOperTime = /^(([0-1][0-9])|(2[0-3])):[0-5][0-9]-(([0-1][0-9])|(2[0-3])):[0-5][0-9]$/;
		
	  if (frOperTime.match(regfrOperTime) != null) {
	      $(this).removeClass("isNotPass")
	      $(".frOperTimeComment").text("");
	      isPass2 = true;
	  }else{
      	$(this).addClass("isNotPass")
        $(".frOperTimeComment").text("입력형식이 잘못되었습니다. ex)09:00-21:00")
        isPass2 = false;
	  }
	})
	$("[name=frClosedDte]").keyup(function(){
		var frClosedDte = $(this).val()
		var regfrClosedDte = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
		
	  if (frClosedDte.match(regfrClosedDte) != null) {
	      $(this).removeClass("isNotPass")
	      $(".frTelComment").text("");
	      isPass3 = true;
	  }else{
      	$(this).addClass("isNotPass")
        $(".frClosedDteComment").text("한글만 입력가능합니다. ex)연중무휴, 월요일")
        isPass3 = false;
	  }
	})	
	$("[name=frTel]").keyup(function(){
		var tel = $(this).val()
		var regTel = /^(070|02|0[3-9]{1}[0-9]{1})-[0-9]{3,4}-[0-9]{4}$/;
		
	  if (tel.match(regTel) != null) {
	      $(this).removeClass("isNotPass")
	      $(".frTelComment").text("");
	      isPass4 = true;
	  }else{
      	$(this).addClass("isNotPass")
        $(".frTelComment").text("전화번호 형식으로 입력해주세요. ex)02-357-6813")
        isPass4 = false;
	  }
		
	})
	$("[name=email]").keyup(function(){
		var email = $(this).val()
		var regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i
		
	  if (email.match(regEmail) != null) {
	      $(this).removeClass("isNotPass")
	      $(".emailComment").text("");
	      isPass5 = true;
	  }else{
      	$(this).addClass("isNotPass")
        $(".emailComment").text("이메일형식으로 입력해주세요. ex)email@naver.com")
        isPass5 = false;
	  }
	})	
    $(".uptBtn").click(function(){
		  Swal.fire({
			  title: '수정하시겠습니까?',
			  icon: 'question',
			  showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
			  confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
			  cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
			  confirmButtonText: '확인', // confirm 버튼 텍스트 지정
			  cancelButtonText: '취소' // cancel 버튼 텍스트 지정
			}).then((result) => {
			  if (result.value) {
				  if($("[name=frRegiNum]").val() == ""){
					  Swal.fire({
						  title: '사업자번호를 입력해주세요.',
						  icon: 'warning',
						  showCancelButton: false,
						  confirmButtonColor: '#3085d6',
						  confirmButtonText: '확인'
						}).then((result) => {
						  if (result.value) {
							  $("[name=frRegiNum]").focus()
						      return;
						  }
					  })
				  }
				  else if($("[name=frPass]").val() == ""){
					  Swal.fire({
						  title: '비밀번호를 입력해주세요.',
						  icon: 'warning',
						  showCancelButton: false,
						  confirmButtonColor: '#3085d6',
						  confirmButtonText: '확인'
						}).then((result) => {
						  if (result.value) {
							  $("[name=frPass]").focus()
						      return;
						  }
					  })
				  }
				  else if($("[name=frName]").val() == ""){
					  Swal.fire({
						  title: '매장명을 입력해주세요.',
						  icon: 'warning',
						  showCancelButton: false,
						  confirmButtonColor: '#3085d6',
						  confirmButtonText: '확인'
						}).then((result) => {
						  if (result.value) {
							  $("[name=frName]").focus()
						      return;
						  }
					  })
				  }
				  else if($("[name=frAddress]").val() == ""){
					  Swal.fire({
						  title: '주소를 입력해주세요.',
						  icon: 'warning',
						  showCancelButton: false,
						  confirmButtonColor: '#3085d6',
						  confirmButtonText: '확인'
						}).then((result) => {
						  if (result.value) {
							  $("[name=frAddress]").focus()
						      return;
						  }
					  })
				  }
				  else if($("[name=frOperTime]").val() == ""){
					  Swal.fire({
						  title: '운영시간을 입력해주세요.',
						  icon: 'warning',
						  showCancelButton: false,
						  confirmButtonColor: '#3085d6',
						  confirmButtonText: '확인'
						}).then((result) => {
						  if (result.value) {
							  $("[name=frOperTime]").focus()
						      return;
						  }
					  })
				  }
				  else if($("[name=frClosedDte]").val() == ""){
					  Swal.fire({
						  title: '휴무일을 입력해주세요.',
						  icon: 'warning',
						  showCancelButton: false,
						  confirmButtonColor: '#3085d6',
						  confirmButtonText: '확인'
						}).then((result) => {
						  if (result.value) {
							  $("[name=frClosedDte]").focus()
						      return;
						  }
					  })
				  }
				  else if($("[name=frRepName]").val() == ""){
					  Swal.fire({
						  title: '대표자명를 입력해주세요.',
						  icon: 'warning',
						  showCancelButton: false,
						  confirmButtonColor: '#3085d6',
						  confirmButtonText: '확인'
						}).then((result) => {
						  if (result.value) {
							  $("[name=frRepName]").focus()
						      return;
						  }
					  })
				  }
				  else if($("[name=frTel]").val() == ""){
					  Swal.fire({
						  title: '전화번호를 입력해주세요.',
						  icon: 'warning',
						  showCancelButton: false,
						  confirmButtonColor: '#3085d6',
						  confirmButtonText: '확인'
						}).then((result) => {
						  if (result.value) {
							  $("[name=frTel]").focus()
						      return;
						  }
					  })
				  }
				  else if($("[name=empNum]").val() == null){
					  Swal.fire({
						  title: '담당직원을 선택해주세요.',
						  icon: 'warning',
						  showCancelButton: false,
						  confirmButtonColor: '#3085d6',
						  confirmButtonText: '확인'
						}).then((result) => {
						  if (result.value) {
						      return;
						  }
					  })
				  }
				  else if($("[name=email]").val() == ""){
					  Swal.fire({
						  title: '이메일을 입력해주세요.',
						  icon: 'warning',
						  showCancelButton: false,
						  confirmButtonColor: '#3085d6',
						  confirmButtonText: '확인'
						}).then((result) => {
						  if (result.value) {
							  $("[name=email]").focus()
						      return;
						  }
					  })
				  }
				  else if(!isPass1){
					  Swal.fire({
						  title: '비밀번호 형식을 확인해주세요.',
						  icon: 'warning',
						  showCancelButton: false,
						  confirmButtonColor: '#3085d6',
						  confirmButtonText: '확인'
						}).then((result) => {
						  if (result.value) {
							  $("[name=frPass]").focus()
						      return;
						  }
					  })
				  }else if(!isPass2){
					  Swal.fire({
						  title: '운영시간 형식을 확인해주세요.',
						  icon: 'warning',
						  showCancelButton: false,
						  confirmButtonColor: '#3085d6',
						  confirmButtonText: '확인'
						}).then((result) => {
						  if (result.value) {
							  $("[name=frOperTime]").focus()
						      return;
						  }
					  })
				  }else if(!isPass3){
					  Swal.fire({
						  title: '휴무일 형식을 확인해주세요.',
						  icon: 'warning',
						  showCancelButton: false,
						  confirmButtonColor: '#3085d6',
						  confirmButtonText: '확인'
						}).then((result) => {
						  if (result.value) {
							  $("[name=frClosedDte]").focus()
						      return;
						  }
					  })
				  }else if(!isPass4){
					  Swal.fire({
						  title: '매장 전화번호 형식을 확인해주세요.',
						  icon: 'warning',
						  showCancelButton: false,
						  confirmButtonColor: '#3085d6',
						  confirmButtonText: '확인'
						}).then((result) => {
						  if (result.value) {
							  $("[name=frTel]").focus()
						      return;
						  }
					  })
				  }else if(!isPass5){
					  Swal.fire({
						  title: '이메일 형식을 확인해주세요.',
						  icon: 'warning',
						  showCancelButton: false,
						  confirmButtonColor: '#3085d6',
						  confirmButtonText: '확인'
						}).then((result) => {
						  if (result.value) {
							  $("[name=email]").focus()
						      return;
						  }
					  })
				  }				  
				  else{
					  $("form").submit();
				  }
				  
			  }
			})	    	
  	})


});
</script>
</html>