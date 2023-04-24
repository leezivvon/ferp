<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<fmt:requestEncoding value="utf-8"/>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${path}/a00_com/jquery-ui.css" >
<link rel="stylesheet" href="${path}/resource/css/reset.css" >
<link rel="stylesheet" href="${path}/resource/css/A2_jhCSS.css" >
<link rel="stylesheet" href="${path}/resource/css/A2_storeclerkJH.css">
<style>
	td{text-align:center;}
</style>
<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/popper.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
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
		$("[name=clerkName]").val("")
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
	<div class="containerJ">
		<h2 class="h2Title">급여액 조회</h2>
		<br>
		<div class="toolbox">
			<div class="row margin-sm space-between">
				<div class="col left" >
					<div class="row" style="margin-top: 7px;">
						<input type="checkbox" id="monthCheck" checked>
						<label>월 포함</label>
					</div>
					<div class="row">
						<select class="yearCheck">
							<option value="${SCpsch.orderDateYear}">${SCpsch.orderDateYear}</option>
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
				<div class="right">
					<div>
					<form id="reqSchFrm" method="post">
						<div class="row schDiv schDiv-padding">
							<div class="col left schDiv-padding" >
								<label>직원명</label>
								<input type="text" name="clerkName" value="${SCpsch.clerkName}">				
							</div>
							<button type="button" id="schFrmBtn">조회</button>
							<button type="button" id="rstFrmBtn">초기화</button>
						</div>
						<input type="hidden" name="orderDateYear" value="${SCpsch.orderDateYear}">
						<input type="hidden" name="orderDateMonth" value="${SCpsch.orderDateMonth}">
						<input type="hidden" name="frRegiNum" value="${login.frRegiNum}">	
						<input type="hidden" name="curPage" value="${SCpsch.curPage}" />	
					</form>
					</div>
				</div>
			</div>
		</div>
		<div>
			<div>
				<div class="row">
					<div class="thDiv" style="width:15%;">직원번호</div>
					<div class="thDiv" style="width:10%;">직원명</div>
					<div class="thDiv" style="width:5%;">성별</div>
					<div class="thDiv" style="width:10%;">시급</div>
					<div class="thDiv" style="width:10%;">근로시간</div>
					<div class="thDiv" style="width:10%;">지급액</div>
					<div class="thDiv" style="width:40%;">주소</div>
				</div> 
				<c:forEach var="sc" items="${scList }">
					<div class="row">
						<div class="tdDiv" style="width:15%;">${sc.clerkNum }</div>
						<div class="tdDiv" style="width:10%;">${sc.clerkName }</div>
						<div class="tdDiv" style="width:5%;">${sc.gender }</div>
						<div class="tdDiv" style="width:10%;">
							<div class="right">
								<fmt:formatNumber value='${sc.hourlyPay }' type='currency'/>
							</div>
						</div>
						<div class="tdDiv" style="width:10%;">${sc.workhour }시간</div>
						<div class="tdDiv" style="width:10%;">
							<div class="right"> 
								<fmt:formatNumber value='${sc.pay }' type='currency'/>								
							</div>
						</div>
						<div class="tdDiv" style="width:5%;"></div>
						<div class="tdDiv" style="width:35%;">
							<div class="left">
								${sc.address }
							</div>
						</div>
					</div>
				</c:forEach>
				<c:if test="${SCpsch.startBlock > 0}">
					<div class="row pBtn_center">
						<button name="prev" class="pgBtnPrev" onclick="location.href='javascript:goPage(${SCpsch.startBlock-1});'">
							&lt;
						</button>
							<c:forEach var="cnt" begin="${SCpsch.startBlock }" end="${SCpsch.endBlock}">
						  		<button class="pgBtn pg${cnt}" onclick="location.href='javascript:goPage(${cnt});'">
									${cnt}
								</button>
						  	</c:forEach>
					  	<button name="next" class="pgBtnNext" onclick="location.href='javascript:goPage(${SCpsch.startBlock+1});'">
							&gt;
						</button>
					</div>
				</c:if>
			</div>
		</div>
	</div>	
</body>
<script type="text/javascript">
function goPage(cnt){
	$("[name=curPage]").val(cnt);
	$("#reqSchFrm").submit()
}
if(${SCpsch.curPage==1}){
	$("[name=prev]").attr("disabled",true)
}
if(${SCpsch.curPage==SCpsch.endBlock}){
	$("[name=next]").attr("disabled",true)
}

$(".pg"+${SCpsch.curPage}).css({
	'background' : '#a4a4a4',
	'color' : 'white'
})
</script>
</html>