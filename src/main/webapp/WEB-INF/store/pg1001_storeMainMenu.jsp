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

<!-- 아이콘 -->
<link rel="shortcut icon" type="image/x-icon" href="${path}/resource/img/favicon.ico" />

<!-- 제이쿼리 CDN -->
<script src="https://code.jquery.com/jquery-3.6.3.js" integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${path}/resource/css/reset.css"/>
<link rel="stylesheet" href="${path}/resource/css/store_main_index.css"/>
<style type="text/css">

	.left_btns, .right_btns{
		display: flex;
	    margin: 60px 0;
	    flex-direction: column;
	    gap: 45px;
	    align-items: center;
	    box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
	    background: #fff;
	    padding-bottom: 60px;
	}
	
	.btn{
	       width: 300px;
		    border: 2px solid #2262F3;
		    border-radius: 10px;
		    color: #333;
		    font-weight: 600;
		    font-size: 29px;
		    text-align: center;
		    cursor: pointer;
		    padding: 30px;
		    background: #fff;
	}
	
	.btn:hover{
		color: #fff;
		background: #2262F3;
	}
	
	.btnText{
	       width: 400px;
		    background: #2262F3;
		    color: #fff;
		    font-weight: 600;
		    font-size: 29px;
		    text-align: center;
		    padding: 20px;
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
	    display: flex;
	    justify-content: center;
	    gap: 100px;
	    background: #f8f8f8;
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
	
</style>
</head>

<body>
    <div class="container">
<%@ include file="/resource/templates/header.jsp"%>
        <div class="main_wrapper">
        	<div class="left_btns">
        		<div class="btnText">키오스크<br>관련 메뉴</div>
        		<div class="btn" onclick="location.href='${path}/goOrderCheck.do'">주문 확인<br>(직원용)</div>
        		<div class="btn" onclick="location.href='${path}/kiosqueMainForCustomer.do'">주문하기<br>(고객용)</div>
        		<div class="btn" onclick="location.href='${path}/callCustomer.do'">고객 호출<br>(고객용)</div>
        	</div>
        	<div class="right_btns">
        		<div class="btnText">매장 관리<br>관련 메뉴</div>
        		<div class="btn" onclick="location.href='${path}/addCommute.do'">출퇴근<br>등록</div>
        		<div class="btn" onclick="location.href='${path}/storeSet2.do'">매장<br>관리</div>
        	</div>
		</div>
    </div>
</body>
<script type="text/javascript">

</script>
</html>