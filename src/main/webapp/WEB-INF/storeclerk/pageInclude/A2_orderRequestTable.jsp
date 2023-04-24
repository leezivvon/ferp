<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<c:set var="now" value="<%=new java.util.Date()%>" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/a00_com/jquery-ui.css">
<link rel="stylesheet" href="${path}/resource/css/reset.css">
<link rel="stylesheet" href="${path}/resource/css/A2_jhCSS.css">
<link rel="stylesheet" href="${path}/resource/css/A2_orderRequestJH.css">
<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/popper.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script
	src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api"
	type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$(".monthDiv").click(function(){
			$("[name=orderDateMonth]").val(this.innerText)
			$("#reqSchFrm").submit()
		})
		$(".yearCheck").change(function(){
			$("[name=orderDateYear]").val($(".yearCheck").val())
			$("#reqSchFrm").submit()
		})
		$("#schFrmBtn").click(function(){
			if(!$("#monthCheck").is(':checked')){
				$("[name=orderDateMonth]").val("")
				$(".yearCheck").val(new Date().getFullYear())
			}
			$("#reqSchFrm").submit()
		})
		$("#rstFrmBtn").click(function(){
			$("[name=orderDateMonth]").val("")
			$("[name=productName]").val("")
			$("[name=category]").val("")
			$("[name=orderDateYear]").val(new Date().getFullYear())
			$("[name=curPage]").val("1")
			$("#reqSchFrm").submit()
		})
		$("div.monthDiv").filter(function() {
		    return $(this).text() === '${rSch.orderDateMonth}';
		}).css({"backgroundColor":"#007bff","color":"white","borderColor":"#007bff"})
	})
</script>
</head>
<body>
	<h2 class="h2Title">발주 신청서 조회</h2>
	<br>
	<div>
	<div class="toolbox">
		<div class="row margin-sm space-between">
				<div class="col left" >
					<div class="row" style="margin-top: 7px;">
						<input type="checkbox" id="monthCheck" checked>
						<label>월 포함</label>
					</div>
					<div class="row">
						<select class="yearCheck">
							<option value="${rSch.orderDateYear}">${rSch.orderDateYear}</option>
							<option value="" disabled>---</option>
							<c:forEach var="year" items="${past5years }">
								<option value="${year.years }">${year.years }</option>
							</c:forEach>
						</select>
						<c:forEach var="i" begin="1" end="12">
							<div class="monthDiv">${i }월</div>
						</c:forEach>
					</div>
				</div>
				<div>
				<form id="reqSchFrm" method="post">
					<div class="row schDiv schDiv-padding">
						<div class="col left" >
							<label>카테고리</label>
							<select name="category">
								<option value="${rSch.category}">${rSch.category}</option>
								<option disabled>-----</option>
								<c:forEach var="c" items="${category }">
									<option>${c.category}</option>
								</c:forEach>
							</select>
						</div>
						&nbsp;&nbsp;&nbsp;
						<div class="col left" >
							<label>자재명</label>
							<input type="text" name="productName" value="${rSch.productName}">				
						</div>
						<button type="button" id="schFrmBtn">조회</button>
						<button type="button" id="rstFrmBtn">초기화</button>
					</div>
					<input type="hidden" name="orderDateYear" value="${rSch.orderDateYear}"/>
					<input type="hidden" name="orderDateMonth" value="${rSch.orderDateMonth}"/>
					<input type="hidden" name="curPage" value="${rSch.curPage}"/>	
					<input type="hidden" name="demander" value="${login.frRegiNum}"/>		
				</form>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="thDiv" style="width: 16%;">발주번호</div>
		<div class="thDiv" style="width: 20%;">자재명</div>
		<div class="thDiv" style="width: 9%;">카테고리</div>
		<div class="thDiv" style="width: 18%;">공급자</div>
		<div class="thDiv" style="width: 13%;">신청날짜</div>
		<div class="thDiv" style="width: 7%;">요청수량</div>
		<div class="thDiv" style="width: 10%;">결제상태</div>
		<div class="thDiv" style="width: 7%;">발주상태</div> 
	</div>
	<div>
	<c:forEach var="req" items="${reqlist }">
		<div class="row tdAll" onclick="prodInfo('${req.orderNum}','${req.productNum }','${req.productName }','${req.amount }',
			'${req.supplier }','${req.demander }','${req.orderDate }','${req.img}','${req.paymentState }','${req.orderState }','${req.remainAmount }')">
			<div class="tdDiv" style="width: 16%;">${req.orderNum }</div>
			<div class="tdDiv" style="width: 20%;">${req.productName }</div>
			<div class="tdDiv" style="width: 9%;">${req.category }</div>
			<div class="tdDiv" style="width: 18%;">
				<c:choose>
					<c:when test="${req.demander eq '9999999999'}">${req.opposite }</c:when>
					<c:otherwise>본사</c:otherwise>
				</c:choose>
			</div>
			<div class="tdDiv" style="width: 13%;">
				<div style="display: none;">
					<fmt:parseDate var="orderDate" value="${req.orderDate }"
						pattern="yyyy-MM-dd HH:mm:ss" />
				</div>
				<fmt:formatDate value="${orderDate }" pattern="yyyy년MM월dd일" />
			</div>
			<div class="tdDiv" style="width: 7%; text-align: right;">
				<fmt:formatNumber value='${req.amount }' pattern='#,##0.##' />
			</div>
			<div class="tdDiv" style="width: 10%;">${req.paymentState }</div>
			<div class="tdDiv" style="width: 7%;">${req.orderState}</div>
		</div>
	</c:forEach>
	<c:if test="${rSch.startBlock > 0}">
		<div class="row pBtn_center">
			<button name="prev" class="pgBtnPrev" onclick="location.href='javascript:goPage(${rSch.startBlock-1});'">
				&lt;
			</button>
			<c:forEach var="cnt" begin="${rSch.startBlock }" end="${rSch.endBlock}">
				<button class="pgBtn pg${cnt}" onclick="location.href='javascript:goPage(${cnt});'">
					${cnt}
				</button>
			</c:forEach>
			<button name="next" class="pgBtnNext" onclick="location.href='javascript:goPage(${rSch.startBlock+1});'">
				&gt;
			</button>
		</div>
	</c:if>
	</div>
	<div id="modal2">
		<div class="modal_content">
			<%@ include
				file="/WEB-INF/storeclerk/pageInclude/A2_orderRequestProdInfo.jsp"%>
			<div style="text-align: right;"></div>
		</div>
		<div class="modal_layer"></div>
	</div>
	</div>
</body>
<script type="text/javascript">
	function prodInfo(orderNum, productNum, productName, amount, supplier,
			demander, orderDate, img, paymentState, orderState,remainAmount) {
		$(".orderNum").text(orderNum)
		$(".productNum").text(productNum)
		$(".productName").text(productName)
		$(".amount").text(amount)
		$(".supplier").text(supplier)
		$(".demander").text(demander)
		$(".orderDate").text(orderDate.substring(0, 10))
		$(".orderDate2").text(orderDate)
		$(".img").attr("src", '${path}/resource/img/' + img)
		$(".paymentState").text(paymentState)
		$(".orderState").text(orderState)
		$(".rmAmount").text(remainAmount)
		console.log($(".rmAmount").text())
		var today = new Date().toLocaleDateString()
		var orderday = new Date($(".orderDate2").text()).toLocaleDateString()
		var t = new Date(today)
		var o = new Date(orderday)
		if(t>o || orderState == '발주취소' || orderState == '완료' || $(".orderState").text()=='조정중'){
			$(".uBtn, .dBtn, .minus1, .minus10, .plus1, .plus10").attr("disabled", true)
			$(".uBtn").css({"backgroundColor":"#dc3545","display":"none"})
			$(".dBtn").text("수정 기간 만료")
			$(".dBtn").css("width", "25%")
			$(".rmAmountCon").css("display","none")
		}else{
			$(".uBtn, .dBtn, .minus1, .minus10, .plus1, .plus10").attr("disabled", false)
			$(".uBtn").css({"backgroundColor":"#6c757d","display":"inline-block"})
			$(".uBtn").text("수정")
			$(".dBtn").text("취소")
			$(".dBtn").css("width", "15%")
			$(".rmAmountCon").css("display","block")
		}
		if($(".paymentState").text() != '정산전' || orderState == '발주취소' || $(".orderState").text()=='조정중' || $(".orderState").text()=='취소완료'){
			$(".wdBtn").css("display","none")
		}else{
			$(".wdBtn").css("display","block")
		}
		$("#modal2").attr("style", "display:block");
	}
	function goPage(cnt){
		$("[name=curPage]").val(cnt);
		$("#reqSchFrm").submit()
	}
	if(${rSch.curPage==1}){
		$("[name=prev]").attr("disabled",true)
	}
	if(${rSch.curPage==rSch.endBlock}){
		$("[name=next]").attr("disabled",true)
	}

	$(".pg"+${rSch.curPage}).css({
		'background' : '#a4a4a4',
		'color' : 'white'
	})
</script>
</html>