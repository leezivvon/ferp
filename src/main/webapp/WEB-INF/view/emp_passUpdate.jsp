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
<title>비밀번호 변경</title>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<link rel="stylesheet" href="/ferp/resource/css/emp_insert.css"/>
<link rel="stylesheet" href="${path}/resource/css/reset.css"/>
<link rel="stylesheet" href="${path}/resource/css/store_main_index.css"/>

</head>
<script type="text/javascript">
	localStorage.setItem("pageIdx","4104")
	localStorage.setItem("eqIdx","4100")
</script>
<body class="container">
	<%@ include file="/resource/templates/header.jsp"%>
	<div class="main_wrapper">
		<%@ include file="/resource/templates/sidebar.jsp"%>
		<div class="contents">
        	<form method="post">
     	        <h2 class="insert_emp">비밀번호 변경</h2>
     	        <input type="hidden" name="empnum" value="${login.empnum}">
	
        	<div class="content">
				<div class="first_line">
					<h3 class="emp_ename">현재 비밀번호</h3>
				</div>
				<div class="second_line">
					<input type="password" name="nowPass" placeholder="현재 비밀번호 입력">
					<p class="nowPass"></p>
				</div>
				<div class="third_line">
					<h3 class="emp_pass">변경할 비밀번호</h3>
				</div>
				<div class="fourth_line">
					<input type="password" name="pass" placeholder="비밀번호 입력">
					<p class="comment"></p>
				</div>
				<div class="fifth_line">
					<h3 class="emp_dname">비밀번호 확인</h3>
				</div>
				<div class="sixth_line">
					<input type="password" name="passChk" placeholder="비밀번호 재입력">	
					<p class="commentChk"></p>			
				</div>					

				<div class="submit_line">
					<button type="button" class="uptBtn">수 정</button>
				</div>	
				
			</div>
			</form>
		</div>
	</div>
</body>
<script type="text/javascript">
$(document).ready(function(){
    var insMsg = "${passupt}"
       if(insMsg != ""){
   	  Swal.fire({
   		  title: '비밀번호 변경 성공!',
   		  icon: 'success',
   		  showCancelButton: false, // cancel버튼 보이기. 기본은 원래 없음
   		  confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
   		  confirmButtonText: '확인', // confirm 버튼 텍스트 지정
   		}).then((result) => {
   		  if (result.value) {
   			//"확인" 버튼을 눌렀을 때 작업할 내용
   			  location.href="${path}/logoutEmp.do"
   		  }
   		})
       }
    
	$("[name=nowPass]").keyup(function(){
		if($(this).val() != '${login.pass}'){
			$(this).addClass("isNotPass")
			$(".nowPass").text("비밀번호가 다릅니다.")
		}else{
			$(this).removeClass("isNotPass")
			$(".nowPass").text("")
			$(this).addClass("isPass")
		}
	})
	
	var isPass1 = false;
	var isPass2 = false;
	$("[name=pass]").keyup(function chPW(){
		var pw = $(this).val();
		var number = pw.search(/[0-9]/g);
		var english = pw.search(/[a-z]/ig);
		var spece = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
		var reg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/;

        if (pw.length < 8 || pw.length > 20) {
        	$(this).addClass("isNotPass")
            $(".comment").text("8자리 ~ 20자리 이내로 입력해주세요.")

        } else if (pw.search(/\s/) != -1) {
        	$(this).removeClass("isNotPass")
        	$(".comment").text("비밀번호는 공백 없이 입력해주세요.")
        	$(this).addClass("isNotPass")

        } else if ((number < 0 && english < 0) || (english < 0 && spece < 0) || (spece < 0 && number < 0)) {
        	$(this).removeClass("isNotPass")
        	$(".comment").text("영문,숫자, 특수문자 중 2가지 이상을 혼합하여 입력해주세요.")
        	$(this).addClass("isNotPass")        	

        } else if (/(\w)\1\1\1/.test(pw)) {
        	$(this).removeClass("isNotPass")
        	$(".comment").text("같은 문자를 4번 이상 사용하실 수 없습니다.")
        	$(this).addClass("isNotPass")       	

        } else if($(this).val() == '${login.pass}'){
        	$(this).removeClass("isNotPass")
        	$(".comment").text("현재 비밀번와 같은 비밀번호를 사용할 수 없습니다.")
        	$(this).addClass("isNotPass") 
        } else {
        	$(this).removeClass("isNotPass")
        	$(".comment").text("");
        	$(this).addClass("isPass") 
        	isPass1 = true;
        }		
	})
	
	$("[name=passChk]").keyup(function(){
		var pass = $("[name=pass]").val()
		var passChk = $(this).val()
		
		if(pass != passChk){
        	$(this).addClass("isNotPass")
        	$(".commentChk").text("비밀번호가 다릅니다.");
		}else{
			$(this).removeClass("isNotPass")
			$(".commentChk").text("");
			$(this).addClass("isPass")
			isPass2 = true;
		}
	})
	
	
    $(".uptBtn").click(function(){
		  Swal.fire({
			  title: '변경하시겠습니까?',
			  icon: 'question',
			  showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
			  confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
			  cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
			  confirmButtonText: '확인', // confirm 버튼 텍스트 지정
			  cancelButtonText: '취소' // cancel 버튼 텍스트 지정
			}).then((result) => {
			  if (result.value) {
				  if(!isPass1 || !isPass2){
					  Swal.fire({
						  title: '비밀번호를 다시 확인해주세요.',
						  icon: 'warning',
						  showCancelButton: false,
						  confirmButtonColor: '#3085d6',
						  confirmButtonText: '확인'
						}).then((result) => {
						  if (result.value) {
						      return;
						  }
					  })
				  }else{
					  $("form").submit();
				  }

				  
			  }
			})	    	
  	})

    
    

});
</script>
</html>