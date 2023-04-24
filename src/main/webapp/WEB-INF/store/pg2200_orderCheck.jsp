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
<title>주문 확인</title>

<!-- 아이콘 -->
<link rel="shortcut icon" type="image/x-icon" href="${path}/resource/img/favicon.ico" />


<!-- 제이쿼리 CDN -->
<script src="https://code.jquery.com/jquery-3.6.3.js" integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${path}/resource/css/reset.css"/>
<link rel="stylesheet" href="${path}/resource/css/store_main_index.css"/>
<link rel="stylesheet" href="${path}/resource/css/basicStyle.css"/>
<style type="text/css">

.orderWrapper{
	display: flex;
    justify-content: center;
    width: 100%;
    flex-wrap: wrap;
    gap: 50px;
	padding: 30px 0;
}

.orderBox{
	width: 400px;
	height: 400px;
	background: #FFFFFF;
	border: 5px solid #2262F3;
	border-radius: 10px;
	overflow-y: scroll;
	padding-bottom: 20px;
}


.orderBox h3{
    font-size: 45px;
    text-align: center;
    line-height: 50px;
    color: #2262F3;
}

.btn-primary{
	display: block;
	margin: auto;
}

.container{
	padding: 30px 0;
}

.menuSetBtn {
    font-size: 2rem;
    font-family: inherit;
}



button{
	   font-family: inherit;
}

.menuName{
	font-size: 24px;
    padding-top: 25px;
}


.option{
	font-size: 20px;
	color: #999;
}

.btnWrapper{
	display: flex;
    justify-content: center;
    padding: 20px 0px;
}

.orderList{
	text-align: center;
}

</style>
</head>

<body>
    <div class="container">
        <header>  
            <div class="logo">
                <h1><a href="${path}/storeMainMenu.do"><img src="${path}/resource/img/F.ERP.png" alt=""></a></h1>
            </div>
        </header>
		<div class="orderWrapper">
		
<c:forEach var="sl" items="${slist}" varStatus="status">
  <c:if test="${status.index == 0 || sl.orderNum != slist[status.index - 1].orderNum}">
    <div class="orderBox">
      <div class="btnWrapper">
	      <button class="btn-primary delBtn">결제 취소</button>
	      <button class="btn-primary clearBtn">제조 완료</button>
      </div>
      <h3>${sl.orderNum}</h3>
      <input type="hidden" name="orderNum" value="${sl.orderNum }">
      <ul class="orderList">
        <li class="menuName">${sl.menuName} x ${sl.amount}</li>
        <li class="option">${sl.orderOption}</li>
      </ul>
    </div>
  </c:if>
  <c:if test="${status.index != 0 && sl.orderNum == slist[status.index - 1].orderNum}">
    <script type="text/javascript">
    $('.orderList').last().append(`
    	    <li class="menuName">${sl.menuName} x ${sl.amount}</li>
    	    <li class="option">${sl.orderOption}</li>
    	`);
    </script>
  </c:if>
</c:forEach>
		</div>
	</div>
</body>
<script type="text/javascript">
$('h3').text(function(index, text) {
	  return text.slice(-4);
	});
	
$('.delBtn').click(function() {
	  var orderNum = $(this).closest('.orderBox').find('input[name=orderNum]').val();
	  location.href="delOrder.do?orderNum="+orderNum;
	});
	
$('.clearBtn').click(function() {
	  var orderNum = $(this).closest('.orderBox').find('input[name=orderNum]').val();
	  location.href="clearOrder.do?orderNum="+orderNum;
	});
</script>
</html>