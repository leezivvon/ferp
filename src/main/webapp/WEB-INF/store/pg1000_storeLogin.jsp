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
<link rel="stylesheet" href="${path}/resource/css/reset.css"/>
<link rel="stylesheet" href="${path}/resource/css/store_main_index.css"/>

<!-- 아이콘 -->
<link rel="shortcut icon" type="image/x-icon" href="${path}/resource/img/favicon.ico" />

<style type="text/css">
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
    
    input[name=frRegiNum]{
   	    width: 250px;
	    padding-left: 15px;
	    font-size: 15px;
	    height: 40px;
    }
    
    input[name=frPass]{
    	width: 250px;
    	font-size: 15px;
    	padding-left: 15px;
    	height: 40px;
    }
    
    .idBox{
   	    padding: 100px 0 10px;
	    text-align: center;
	    font-size: 20px;
	    display: flex;
	    justify-content: center;
    }
    
    .passBox{
    	text-align: center;
    	padding: 10px 0 70px;
    	font-size: 20px;
    	display: flex;
	    justify-content: center;
    }
    
    .btn{
		display: block;
	    font-size: 18px;
	    font-family: inherit;
	    width: 120px;
	    height: 40px;
	    background: #fff;
	    border: 1px solid #000;
	    border-radius: 5px;
	    cursor: pointer;
	    line-height: 40px;
	    text-align: center;
    }
    
    .loginBtn{
    	background: #2262F3;
    	border: none;
    	color: #fff;
    }
    
    .loginBox{
    	margin: auto;
    }
    
    span{
    	width: 200px;
    	text-align: left;
    	display: block;
   	    line-height: 40px;
    }
    
    .pwText{
    	text-align: center;
	    padding: 60px;
	    line-height: 30px;
	    font-size: 17px;
    	color: #666;
    }
    
    .btnWrapper{
    	display: flex;
    	justify-content: center;
	    gap: 60px;
    }
	
</style>
</head>

<body>
    <div class="container">
        <header>  
            <div class="logo">
                <h1><a href="#"><img src="${path}/resource/img/F.ERP.png" alt=""></a></h1>
            </div>
           	<h2>프랜차이즈 매장 관리 시스템</h1>
        </header>
        <div class="main_wrapper">
	        <div class="loginBox">
	        	<form method="post" id="loginForm">
	        		<div class="idBox">
	      				<span>사업자 번호</span>
						<input type="text" name="frRegiNum" placeholder="'-'는 제외하고 입력하세요.">
	        		</div>
	        		<div class="passBox">
	        			<span>비밀번호</span>
						<input type="password" name="frPass">
					</div>
					<div class="btnWrapper">
						<button type="submit" class="loginBtn btn">로그인</button>
		        	</form>
						<div class="btn" onclick="location.href='${path}/tempPassword.do'">비밀번호 찾기</div>
					</div>
	        </div>
		</div>
    </div>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		var loginState = "${loginState}";
		if(loginState == "틀림"){
			alert("아이디 혹은 비밀번호를 확인하세요.")
		}
	})
</script>
</html>