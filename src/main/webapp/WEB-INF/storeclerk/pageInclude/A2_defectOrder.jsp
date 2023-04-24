<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/a00_com/jquery-ui.css">
<link rel="stylesheet" href="${path}/resource/css/reset.css">
<link rel="stylesheet" href="${path}/resource/css/A2_jhCSS.css">
<link rel="stylesheet" href="${path}/resource/css/A2_storeclerkJH.css">
<link rel="stylesheet" href="${path}/resource/css/A2_modalCSS.css">
<link rel="stylesheet" href="${path}/resource/css/A2_defectCSS.css">
<link rel="stylesheet" href="${path}/resource/css/A2_fileCss.css">
<script src="${path}/a00_com/jquery.min.js"></script>
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
			return $(this).text() === '${dSch.orderDateMonth}';
		}).css({
			"backgroundColor" : "#007bff",
			"color" : "white",
			"borderColor" : "#007bff"
		})
		
		let params = new URL(document.location).searchParams;
		let orNm = params.get("orderNum")
		let prNm = params.get("productNum")
		let orDt = params.get("orderDate")
		let prodN = params.get("productNameFrm")
		$(".productNameFrm").val(prodN)
		if(orNm==null || prNm==null || orDt==null || prodN==null){
			$("[name=orderNum], .productNameFrm, [name=type], [name=methods], [name=file], .regBtn, .upload-name").attr("disabled",true)
		}
	});
</script>
</head>
<!--  
발주 번호 입력, 자재명 선택, 종류(오배/누송락/파손) 선택, 처리 방식(환불/재배송) 선택, 이미지 첨부(필요 시)
-->
<body>
	<h2 class="h2Title">배송 불량 신청</h2>
	<br>
	<div>
		<div class="toolbox">
		<h3>누락/오배송/자재 파손 처리 신청</h3>
			<form id="regForm" method="post" enctype="multipart/form-data" action="${path }/insDefectProd.do">
				<br>
				<div class="row">
					<input type="hidden" name="frRegiNum" value="${login.frRegiNum }"/>
					<input type="hidden" name="orderDate" value="${param.orderDate }" required/>
					<div class="col margin-tn w20">
						<label>발주 번호</label> 
						<input type="text" name="orderNum" value="${param.orderNum }" style="background-color:white;border: 1px solid #a4a4a4;" class="margin-tln regList" readOnly required />
					</div>
					<div class="col margin-tn w20">
						<label>자재명</label> 
						<input type="text" class="margin-tln regList productNameFrm" style="background-color:white;border: 1px solid #a4a4a4;" readOnly required />
						<input type="hidden" name="productNum" value="${param.productNum }" class="margin-tln regList" placeholder="" required />
					</div>
					<div class="col margin-tn w20">
						<label>종류</label> 
						<select name="type" class="regList" required>
							<option>오배송</option>
							<option>누락</option>
							<option>파손</option>
						</select>
					</div>
					<div class="col margin-tn w20">
						<label>처리방식</label> 
						<select name="methods" class="regList" required>
							<option>환불</option>
							<option>재배송</option>
						</select>
					</div>
				</div>
				<label style="margin-left: 18px;">사진첨부</label>
				<div class="filebox">
					<div class="margin-sm fileInput" style="margin-left:20px;">
						<input class="upload-name" style="width:84%;" value="첨부파일" placeholder="첨부파일"><label for="file">파일찾기</label> 
						<input type="file" id="file" name="file" onchange="filename()">
					</div>
				</div>
				<br>
				<div class="right">
					<button type="submit" class="regBtn" style="margin-right: 80px;">신청</button>
				</div>
			</form>
			<br>
		</div>
		<div>
			<br>
			<h2 class="h2Title">배송 불량 신청 현황</h2>
			<br>
			<div class="toolbox">
				<div class="row margin-sm space-between">
					<div class="col left">
						<div class="row" style="margin-top: 7px;">
							<input type="checkbox" id="monthCheck" checked> 
							<label>월 포함</label>
						</div>
						<div class="row">
							<select class="yearCheck">
								<option value="${dSch.orderDateYear}">${dSch.orderDateYear}</option>
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
								<div class="col left">
									<label>카테고리</label> <select name="category">
										<option value="${dSch.category }">${dSch.category }</option>
										<option disabled>-----</option>
										<c:forEach var="c" items="${category }">
											<option>${c.category}</option>
										</c:forEach>
									</select>
								</div>
								&nbsp;&nbsp;&nbsp;
								<div class="col left">
									<label>자재명</label> 
									<input type="text" name="productName" value="${dSch.productName }">
								</div>
								<button type="button" id="schFrmBtn">조회</button>
								<button type="button" id="rstFrmBtn">초기화</button>
							</div>
							<input type="hidden" name="orderDateYear" value="${dSch.orderDateYear}">
							<input type="hidden" name="orderDateMonth" value="${dSch.orderDateMonth }">
							<input type="hidden" name="curPage" value="${dSch.curPage}"/>	 
							<input type="hidden" name="frRegiNum" value="${login.frRegiNum}">
						</form>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="thDiv" style="width: 18%;">신청번호</div>
				<div class="thDiv" style="width: 27%;">자재명</div>
				<div class="thDiv" style="width: 20%;">신청일</div>
				<div class="thDiv" style="width: 15%;">종류</div>
				<div class="thDiv" style="width: 10%;">처리방식</div>
				<div class="thDiv" style="width: 10%;">처리상태</div>
			</div>
			<c:forEach var="dl" items="${defectlist }">
				<form id="uptForm${dl.defNum}" method="post" class="">
					<div class="row reg" onclick="showImg('${dl.defNum}')" onmouseout="hideImg('${dl.defNum}')">
						<div style="display: none;"></div>
						<div class="tdDiv" style="width: 18%;">${dl.defNum}</div>
						<div class="tdDiv" style="width: 27%;">${dl.productName }</div>
						<div class="tdDiv left" style="width: 20%;">${dl.applyDate }</div>
						<div class="tdDiv" style="width: 15%;">${dl.type }</div>
						<div class="tdDiv" style="width: 10%;">${dl.methods }</div>
						<div class="tdDiv" style="width: 10%;">${dl.state }</div>
						<input type="hidden" name="defNum" value="${dl.defNum}"/>
						<input type="hidden" name="img" value="${dl.img}"/>
					</div>
					<div>
						<img src="${path }/resource/img/defectOrder/${dl.img}" class="defectImg defectImg${dl.defNum}" onerror="this.onerror=null;this.src='${path }/resource/img/noimg.png'" />
					</div>
				</form>
			</c:forEach>
			<c:if test="${dSch.startBlock > 0}">
				<div class="row pBtn_center">
					<button name="prev" class="pgBtnPrev" onclick="location.href='javascript:goPage(${dSch.startBlock-1});'">
						&lt;
					</button>
					<c:forEach var="cnt" begin="${dSch.startBlock }" end="${dSch.endBlock}">
						<button class="pgBtn pg${cnt}" onclick="location.href='javascript:goPage(${cnt});'">
							${cnt}
						</button>
					</c:forEach>
					<button name="next" class="pgBtnNext" onclick="location.href='javascript:goPage(${dSch.startBlock+1});'">
						&gt;
					</button>
				</div>
			</c:if>
		</div>
	</div>
	<script type="text/javascript">
		function showImg(i) {
			$(".defectImg" + i).css("display", "block")
		}
		function hideImg(i) {
			$(".defectImg" + i).css("display", "none")
		}
		function filename(){
			var fileInput = document.getElementById("file");
			var files = fileInput.files;
			var i = files.length
			if(i == 1){
				$('.upload-name').val($("#file").val())			
			}else{
				$('.upload-name').val($("#file").val()+" 외 "+parseInt(i-1) + "개")			
			}
		}
		function goPage(cnt){
			$("[name=curPage]").val(cnt);
			$("#reqSchFrm").submit()
		}
		if(${dSch.curPage==1}){
			$("[name=prev]").attr("disabled",true)
		}
		if(${dSch.curPage==dSch.endBlock}){
			$("[name=next]").attr("disabled",true)
		}

		$(".pg"+${dSch.curPage}).css({
			'background' : '#a4a4a4',
			'color' : 'white'
		})
	</script>
</body>
</html>