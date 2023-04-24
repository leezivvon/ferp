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
<title>주문하기</title>

<!-- remixicon cdn -->
<link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">

<!-- 제이쿼리 CDN -->
<script src="https://code.jquery.com/jquery-3.6.3.js" integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${path}/resource/css/reset.css"/>
<link rel="stylesheet" href="${path}/resource/css/store_main_index.css"/>

<!-- 알럿창 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

<style type="text/css">
	.wrap_container{
				max-width: 1200px;
				width: 100%;
				margin: 0 auto;
			}
		
	.headerTop{
		width: 100%;
		height: 90px;
		text-align: center;
		color: #fff;
		background: #2262F3;
		line-height: 90px;
	    font-size: 35px;
    	font-weight: 600;
	}
	
	.howbox{
		text-align: center;
		cursor: pointer;
	}
	
	.howbox:hover span{
		color: #2262F3;
	}
	
	.howtoPay{
		display: flex;
		justify-content: center;
	    gap: 140px;
	    padding: 50px 0;
	}
	
	.howbox>span{
	    font-size: 22px;
    	line-height: 45px;
	}
	
	.price{
	    text-align: center;
	    font-size: 45px;
	    padding: 90px 0 70px;
        color: #2262f3;
		font-weight: 700;
	}
	
	.payprice{
		display: none;
	}
	
	h3{
		font-size: 30px;
		font-weight: 500;
	    color: #444;
	}

.orderNum{
	display: none;
}

.goHome{
	padding: 50px 0;
}

.goHomeBtn{
    line-height: 68px;
    width: 200px;
    height: 70px;
    color: #2262f3;
    display: block;
    text-align: center;
    font-size: 22px;
    margin: auto;
    border-radius: 10px;
    border: 3px solid #2262f3;
    font-weight: 600;
}

.goHomeBtn:hover{
	border:none;
	color: #fff;
	background: #2262f3;
}
</style>
</head>

<body>
	<div class="wrap_container">
		<div class="headerTop">
			결제하기
		</div>
		<p class="price">가격</p>
		<h3>* 원하시는 결제 수단을 선택해 주세요.</h3>
		<div class="howtoPay">
			<div class="howbox kakao" name="카카오">
				<img alt="" src="${path}/resource/img/kakao.png"><br>
				<span>카카오페이</span>
			</div>
			<div class="howbox card" name="카드결제대행사">
				<img alt="" src="${path}/resource/img/card.png"><br>
				<span>카드 결제</span>
			</div>
		</div>
		<div class="goHome">
			<a href="${path}/kiosqueMainForCustomer.do" class="goHomeBtn">주문 취소하기</a>
		</div>
		<c:forEach var="no" items="${NowOrders}">
			<div class="payprice">${no. payprice}</div>
		</c:forEach>
		<p class="orderNum">${orderNum }</p>


	</div>	
</body>
<script type="text/javascript">
'use strict';

var payprices = document.querySelectorAll('.payprice');
var total = 0;
for (var i = 0; i < payprices.length; i++) {
  total += parseInt(payprices[i].textContent);
}
var price = total;
var tax = price*0.1;

$(".price").text("결제 금액 : "+total.toLocaleString()+"￦");

var orderNum = $(".orderNum").text();
$(".howbox").click(function () {
	var oppm = $(this).attr('name');
	var pay = $(this).find("span").text();
	console.log(oppm);
	console.log(price);
	console.log(tax);
	Swal.fire({
		  title: pay+'로 결제하시겠습니까?',
		  icon: 'question',
		  showCancelButton: true,
		  confirmButtonColor: '#2262F3',
		  cancelButtonColor: '#888',
		  confirmButtonText: '결제',
		  cancelButtonText: '취소'
		}).then((result) => {
			if (result.value) {				
				location.href="payState.do?orderNum="+orderNum+"&price="+price+"&tax="+tax+"&oppm="+oppm;
			}
		});
});

</script>
</html>