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
<title>사원 등록</title>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<link rel="stylesheet" href="/ferp/resource/css/emp_insert.css"/>
<link rel="stylesheet" href="${path}/resource/css/reset.css"/>
<link rel="stylesheet" href="${path}/resource/css/store_main_index.css"/>
<style type="text/css">
table {
	width: 50%;
	border-collapse: collapse;
	margin-bottom: 1rem;
	background-color: transparent;
	font-size: 18px;
}

table td, table th {
	padding: 8px;
	vertical-align: top;
	border-top: 1px solid #dee2e6;
	text-align: center;
}

table thead th {
	vertical-align: middle;
	border-bottom: 2px solid #dee2e6
}

table tbody+tbody {
	border-top: 2px solid #dee2e6
}

tbody tr:hover {
	background-color: rgba(0, 0, 0, .075);
}

</style>
</head>
<script type="text/javascript">
	localStorage.setItem("pageIdx","4101")
	localStorage.setItem("eqIdx","4100")
</script>
<body class="container">
	<%@ include file="/resource/templates/header.jsp"%>
	<div class="main_wrapper">
		<%@ include file="/resource/templates/sidebar.jsp"%>
		<div class="contents">
        	<form method="post">
     	        <h2 class="insert_emp">직원 등록</h2>
	
	        	<div class="content">
					<div class="first_line">
						<h3 class="emp_ename">사원명</h3>
					</div>
					<div class="second_line">
						<input type="text" name="ename" placeholder="사원명 입력">
					</div>
					<div class="third_line">
						<h3 class="emp_pass">비밀번호</h3>
					</div>
					<div class="fourth_line">
						<input type="text" name="pass" placeholder="비밀번호 입력">
						<p class="passComment"></p>
					</div>
					<div class="fifth_line">
						<h3 class="emp_dname">부서명</h3>
					</div>
					<div class="sixth_line">
						<select name="dname">
							<option disabled="disabled" selected="selected">부서명 선택</option>
							<c:forEach var="dname" items="${dnameCombo}">
								<option>${dname}</option>
							</c:forEach>
						</select>
					</div>					
	
					<div class="submit_line">
						<button type="button" class="insBtn">등 록</button>
					</div>	
				</div>
			</form>
			
			<div class="empInfo">
				<h2 style="margin-bottom: 30px;">등록한 직원 정보</h2>
				<table>
					<tr><th>직원번호</th><td>${emp.empnum}</td></tr>
					<tr><th>비밀번호</th><td>${emp.pass}</td></tr>
					<tr><th>사원명</th><td>${emp.ename}</td></tr>
					<tr><th>부서명</th><td>${emp.dname}</td></tr>
				</table>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">

$(document).ready(function(){
	var emp = '${emp.ename}'
	if(emp == null || emp == ''){
		$("form").show()
		$(".empInfo").hide()
	}else{
		$("form").hide()
		$(".empInfo").show()
	}

    var insMsg = "${insMsg}"
    if(insMsg != ""){
	  Swal.fire({
		  title: '아이디 발급 성공!',
		  icon: 'success',
		  showCancelButton: false, // cancel버튼 보이기. 기본은 원래 없음
		  confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
		  confirmButtonText: '확인', // confirm 버튼 텍스트 지정
		}).then((result) => {
		  if (result.value) {
			//"확인" 버튼을 눌렀을 때 작업할 내용
		  }
		})	
    }
    
    var isPass = false;
    $("[name=pass]").keyup(function(){
    	var pass = $(this).val()
    	var refPass = /([0-9]{2}(0[1-9]|1[0-2])(0[1-9]|[1,2][0-9]|3[0,1]))/
    	
 		if (pass.match(refPass) != null) {
 		    $(this).removeClass("isNotPass")
 		    $(".passComment").text("");
 		    isPass = true;
 	 	}else{
 	     	$(this).addClass("isNotPass")
 	     	$(".passComment").text("초기비밀번호는 생년월일로 작성해주세요. ex)950423")
 		}
    })
    
    $(".insBtn").click(function(){
		  Swal.fire({
			  title: '등록하시겠습니까?',
			  icon: 'question',
			  showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
			  confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
			  cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
			  confirmButtonText: '확인', // confirm 버튼 텍스트 지정
			  cancelButtonText: '취소' // cancel 버튼 텍스트 지정
			}).then((result) => {
			  if (result.value) {
				  if($("[name=ename]").val() == ""){
					  Swal.fire({
						  title: '사원명을 입력해주세요.',
						  icon: 'warning',
						  showCancelButton: false,
						  confirmButtonColor: '#3085d6',
						  confirmButtonText: '확인'
						}).then((result) => {
						  if (result.value) {
							  $("[name=ename]").focus()
						      return;
						  }
					  })
				  }
				  else if($("[name=pass]").val() == ""){
					  Swal.fire({
						  title: '비밀번호를 입력해주세요.',
						  icon: 'warning',
						  showCancelButton: false,
						  confirmButtonColor: '#3085d6',
						  confirmButtonText: '확인'
						}).then((result) => {
						  if (result.value) {
							  $("[name=pass]").focus()
						      return;
						  }
					  })
				  }
				  else if($("[name=dname]").val() == null){
					  Swal.fire({
						  title: '부서를 선택해주세요.',
						  icon: 'warning',
						  showCancelButton: false,
						  confirmButtonColor: '#3085d6',
						  confirmButtonText: '확인'
						}).then((result) => {
						  if (result.value) {
							  $("[name=dname]").focus()
						      return;
						  }
					  })
				  }
				  else if(!isPass){
					  Swal.fire({
						  title: '비밀번호 형식을 확인해주세요.',
						  icon: 'warning',
						  showCancelButton: false,
						  confirmButtonColor: '#3085d6',
						  confirmButtonText: '확인'
						}).then((result) => {
						  if (result.value) {
							  $("[name=pass]").focus()
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