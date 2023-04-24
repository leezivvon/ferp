<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*" 
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<fmt:requestEncoding value="UTF-8" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ferp 매장 관리</title>

<!-- 제이쿼리 CDN -->
<script src="https://code.jquery.com/jquery-3.6.3.js" integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<link rel="stylesheet" href="${path}/resource/css/reset.css"/>
<link rel="stylesheet" href="${path}/resource/css/store_main_index.css"/>
<style type="text/css">
	.btns{
		display: flex;
	    gap: 80px;
	    width: 100%;
	    justify-content: center;
        padding: 60px 0;
	}
	
	.btn{
		width: 200px;
		height: 200px;
		background: #2262F3;
		border-radius: 10px;
		color: #fff;
		font-weight: 600;
		font-size: 48px;
		line-height: 200px;
		text-align: center;
		cursor: pointer;
	}
	
	header h2{
		text-align: center;
	    font-size: 25px;
	    line-height: 74px;
    }
    
    .logo{
		padding: 70px 0 10px;
    }
    
    .main_wrapper{
    	display: block;
    }
    
    select[name=clerkNum]{
	    margin: auto;
	    display: block;
	    width: 480px;
	    height: 50px;
	    border-radius: 10px;
	    padding-left: 20px;
	    font-size: 20px;
	    font-family: inherit;
    }
    
    #commuteFm{
    	padding: 50px;
    	margin: auto;
    }
	
</style>
<script type="text/javascript">

</script>
</head>

<body>
    <div class="container">
	<%@ include file="/resource/templates/header.jsp"%>
        <div class="main_wrapper">
        <form method="post" id="commuteFm">
        		<select name="clerkNum">
        		<option value="" selected>직원명 선택</option>
        		<c:forEach var="mc" items="${myClerk}">
        			<option value="${mc.clerkNum}">${mc.clerkName}</option>
        		</c:forEach>
        		</select>
        	<div class="btns">
        		<div class="btn start_btn">출근</div>
        		<div class="btn end_btn">퇴근</div>
        	</div>
        </form>
		</div>
    </div>
</body>
<script type="text/javascript">

$(document).ready(function() {
	var arr=[];
	$(".start_btn").click(function () {
		  Swal.fire({
			  title: '출근 등록을 하시겠습니까?',
			  icon: 'question',
			  showCancelButton: true,
			  confirmButtonColor: '#2262F3',
			  cancelButtonColor: '#888',
			  confirmButtonText: '등록',
			  cancelButtonText: '취소'
			}).then((result) => {
				if(result.value){					
					if($("[name=clerkNum]").val() == ""){
						  Swal.fire({
							  title: '등록할 직원을 골라주세요',
							  icon: 'warning',
							  showCancelButton: false,
							  confirmButtonColor: '#2262F3',
							  confirmButtonText: '확인'
							}).then((result) => {
							  if (result.value) {
								  $("[name=clerkNum]").focus()
							      return;
							  }
						  })
					}else{
						<c:forEach var="check" items="${clerkToday }">
							arr.push({ontime:"${check.ontime}", clerkName:"${check.clerkName}", clerkNum:"${check.clerkNum}"})
						</c:forEach>
						for(var i=0;i<arr.length;i++){
							if($("[name=clerkNum]").val() == arr[i].clerkNum && arr[i].clerkName != "" && arr[i].ontime == ""){
								regAjax("/addOnDay.do");	
								return;
							}
							if($("[name=clerkNum]").val() == arr[i].clerkNum && arr[i].clerkName != "" && arr[i].ontime != ""){
								Swal.fire({
									title: '이미 출근한 직원입니다',
									icon: 'warning',
									showCancelButton: false,
									confirmButtonColor: '#2262F3',
									confirmButtonText: '확인'
									}).then((result) => {
										if (result.value) {
										$("[name=clerkNum]").focus()
									    return;
									} 
								})
							}
						}
					}
				}
			})
	})
	$(".end_btn").click(function () {
		  Swal.fire({
			  title: '퇴근 등록을 하시겠습니까?',
			  icon: 'question',
			  showCancelButton: true,
			  confirmButtonColor: '#2262F3',
			  cancelButtonColor: '#888',
			  confirmButtonText: '등록',
			  cancelButtonText: '취소'
			}).then((result) => {
				if(result.value){					
					if($("[name=clerkNum]").val() == ""){
						  Swal.fire({
							  title: '등록할 직원을 골라주세요',
							  icon: 'warning',
							  showCancelButton: false,
							  confirmButtonColor: '#2262F3',
							  confirmButtonText: '확인'
							}).then((result) => {
							  if (result.value) {
								  $("[name=clerkNum]").focus()
							      return;
							  }
						  })
					}else{
						regAjax("/addOffTime.do");
					}
				}
			})
	})
	
	function regAjax(url) {
		$.ajax({
			type : "post",
			url : "/ferp" + url,
			data : $("#commuteFm").serialize(),
			dataType : "json",
			success : function(data) {
				if(data.msg=="출근 정보가 없습니다."){
					  Swal.fire({
						  title: '출근 정보가 없습니다.',
						  icon: 'warning',
						  showCancelButton: false,
						  confirmButtonColor: '#2262F3',
						  confirmButtonText: '확인'
						}).then((result) => {
						  if (result.value) {
							  $("[name=clerkNum]").focus()
						      return;
						  }
					  })
				}else{
					if(url == "/addOffTime.do"){
						alert("퇴근 등록이 완료되었습니다.");
					}
					if(url == "/addOnDay.do"){
						alert("출근 등록이 완료되었습니다.");
					}
					location.href="/ferp/storeMainMenu.do";					
				}
			},
			error : function(err) {
				console.log(err)
			}
		})
	}
});
</script>
</html>