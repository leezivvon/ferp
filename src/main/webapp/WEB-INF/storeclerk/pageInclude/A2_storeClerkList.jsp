<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${path}/a00_com/jquery-ui.css">
<link rel="stylesheet" href="${path}/resource/css/reset.css">
<link rel="stylesheet" href="${path}/resource/css/A2_jhCSS.css">
<link rel="stylesheet" href="${path}/resource/css/A2_storeclerkJH.css">
<link rel="stylesheet" href="${path}/resource/css/A2_modalCSS.css">
<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$(".regBtn").click(function(){
			if($("#regForm [name=clerkName]").val() == ""){
				alert("직원명을 입력해주세요")
				$("#regForm [name=clerkName]").css('borderColor','red')
				$("[name=hourlyPay], [name=residentNum], [name=phoneNum], [name=address]").css('borderColor','#a4a4a4')
			}else if($("[name=hourlyPay]").val() == ""){
				alert("시급을 입력해주세요")
				$("[name=hourlyPay]").css('borderColor','red')
				$("#regForm [name=clerkName], [name=residentNum], [name=phoneNum], [name=address]").css('borderColor','#a4a4a4')
			}else if($("[name=residentNum]").val() == ""){
				alert("주민번호를 입력해주세요")
				$("[name=residentNum]").css('borderColor','red')
				$("#regForm [name=clerkName], [name=hourlyPay], [name=phoneNum], [name=address]").css('borderColor','#a4a4a4')
			}else if($("[name=phoneNum]").val() == ""){
				alert("전화번호를 입력해주세요")
				$("[name=phoneNum]").css('borderColor','red')
				$("#regForm [name=clerkName], [name=hourlyPay], [name=residentNum], [name=address]").css('borderColor','#a4a4a4')
			}else if($("[name=address]").val() == ""){
				alert("주소를 입력해주세요")
				$("[name=address]").css('borderColor','red')
				$("#regForm [name=clerkName], [name=hourlyPay], [name=residentNum], [name=phoneNum]").css('borderColor','#a4a4a4')
			}else{
				if(confirm("등록하시겠습니까?")){
				$("#regForm [name=clerkName], [name=hourlyPay], [name=residentNum], [name=phoneNum], [name=address]").css('borderColor','#a4a4a4')
					regAjax("insStoreclerk.do")	
				}
			}
		})
		function regAjax(url) {
			$.ajax({
				type : "post",
				url : "/ferp/" + url,
				data : $("#regForm").serialize(),
				dataType : "json",
				success : function(data) {
					alert(data.msg)
					location.reload()
				},
				error : function(err) {
					console.log(err)
				}
			})
		}
	});
</script>
</head>
<body>
	<h2 class="h2Title">직원 정보 조회</h2>
	<br>
	<div>
		<div class="toolbox">
			<form id="regForm" method="post">
				<h3>직원 등록</h3>
				<br>
				<div class="row">
					<input type="hidden" name="clerkNum" value="${login.frRegiNum}${clerkTot}" readOnly required /> 
					<input type="hidden" name="frRegiNum" value="${login.frRegiNum}" readOnly required /> 
					<div class="col margin-tn w25">
						<label>직원명</label>
						<input type="text" name="clerkName" class="margin-tln regList" placeholder="직원명" required /> 
					</div>
					<div class="col margin-tn w25">
						<label>시급</label>
						<input type="text" name="hourlyPay" class="margin-tln regList" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" placeholder="시급" required />					 
					</div>
				</div>
				<div class="row">
					<div class="col margin-tn w25">
						<label>주민등록번호(생년월일)</label>
						<input type="text" name="residentNum" class="margin-tln regList" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" maxlength="6" placeholder="주민등록번호" required /> 
					</div>
					<div class="col margin-tn w25">
						<label>전화번호</label>
						<input type="text" name="phoneNum" class="margin-tln regList" placeholder="전화번호" oninput="tel(this)" maxlength="13" required /> 
					</div>
					<div class="col margin-tn">
						<label>성별</label>
						<div class="row">
							<input type="radio" class="margin-radio" name="gender" value="남" checked="checked"> 
								<label class="margin-radio">남</label> 
							&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" class="margin-radio" name="gender" value="여"> 
								<label class="margin-radio">여</label>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col margin-tn w100">
						<label>주소</label>
						<div class="row">
							<input type="text" name="address" class="margin-tln regList" placeholder="주소" required />
							<button type="button" class="regBtn">등록</button>
						</div>
					</div>
				</div>
			</form>
			<br>
		</div>
		<div>
			<div>
				<form id="frm01" method="post">
					<div class=" row schDiv toolbox" style="margin-left: 80%;">
						<div class="col left" >
							<label>직원명</label>
							<input type="text" name="clerkName" value="${SCsch.clerkName}"/>							 
						</div>
						<input type="hidden" name="curPage" value="${SCsch.curPage}" />
						<input type="hidden" name="frRegiNum" value="${login.frRegiNum}" />
						<button type="submit" class="schBtn">조회</button>
					</div>
				</form>
			</div>
			<div class="row">
				<div class="thDiv" style="width: 13%;">직원명</div>
				<div class="thDiv" style="width: 5%;">성별</div>
				<div class="thDiv" style="width: 15%;">전화번호</div>
				<div class="thDiv" style="width: 15%;">주민등록번호</div>
				<div class="thDiv" style="width: 26%;">주소</div>
				<div class="thDiv" style="width: 9%;">시급</div>
				<div class="thDiv" style="width: 7%;">파일</div>
				<div class="thDiv" style="width: 10%;">수정/삭제</div>
			</div>
			<c:forEach var="sc" items="${scList }"> 
				<form id="uptForm${sc.clerkNum }" method="post">
					<div class="row reg${sc.clerkNum }">
						<div style="display: none;">
							<input type="text" name="clerkNum" value="${sc.clerkNum }" />
						</div>
						<div class="tdDiv" style="width: 13%;">
							<input type="text" class="listInput i${sc.clerkNum } center" name="clerkName" value="${sc.clerkName }" disabled />
						</div>
						<div class="tdDiv" style="width: 5%;">
							<input type="text" class="listInput i${sc.clerkNum } center" name="gender" style="width: 100%;" value="${sc.gender }" disabled />
						</div>
						<div class="tdDiv" style="width: 15%;">
							<input type="text" class="listInput i${sc.clerkNum } center" name="phoneNum" style="width: 100%;" oninput="tel(this)" value="${sc.phoneNum }" disabled />
						</div>
						<div class="tdDiv" style="width: 15%;">
							<input type="text" class="listInput i${sc.clerkNum } center" name="residentNum" style="width: 100%;" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" maxlength="6" value="${sc.residentNum }" disabled />
						</div>
						<div class="tdDiv left" style="width: 26%;">
							<input type="text" class="listInput i${sc.clerkNum } left" name="address" style="width: 100%;" value="${sc.address }" disabled />
						</div>
						<div class="tdDiv right" style="width: 9%;">
							<input type="text" class="listInput i${sc.clerkNum } right" name="hourlyPay" style="width: 100%;" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" value="<fmt:formatNumber value='${sc.hourlyPay }' pattern='#,##0.##'/>" disabled />
						</div>
						<div class="tdDiv" style="width: 7%;">
							<button type="button" class="fileBtn" onclick="cFile('${sc.clerkName }','${sc.clerkNum }')">파일</button>
						</div>
						<div class="tdDiv" style="width: 10%;">
							<button type="button" class="uptCfm cfm${sc.clerkNum }" style="display: none;">완료</button>
							<button type="button" class="uptBtn upt${sc.clerkNum }" onclick="location.href='javascript:activateInput(${sc.clerkNum })'">수정</button>
							<button type="button" class="delBtn" onclick="location.href='javascript:delInfo(${sc.clerkNum })'">삭제</button>
						</div>
					</div>
				</form>
			</c:forEach>
			<c:if test="${SCsch.startBlock > 0}">
				<div class="row pBtn_center">
					<button name="prev" class="pgBtnPrev" onclick="location.href='javascript:goPage(${SCsch.startBlock-1});'">
						&lt;
					</button>
					<c:forEach var="cnt" begin="${SCsch.startBlock }" end="${SCsch.endBlock}">
						<button class="pgBtn pg${cnt}" onclick="location.href='javascript:goPage(${cnt});'">
							${cnt}
						</button>
					</c:forEach>
					<button name="next" class="pgBtnNext" onclick="location.href='javascript:goPage(${SCsch.startBlock+1});'">
						&gt;
					</button>
				</div>
			</c:if>
		</div>
		<div id="modal3" class="fileModal">
			<div class="modal_content">
				<%@ include file="/WEB-INF/storeclerk/pageInclude/A2_storeClerkFile.jsp"%>
				<%@ include file="/WEB-INF/storeclerk/pageInclude/A2_storeClerkFileList.jsp"%>
				<br>
				<div style="text-align: right;">
					<button id="closeBtn">닫기</button>
				</div>
			</div>
			<div class="modal_layer"></div>
		</div>
	</div>
<script type="text/javascript">
	function goPage(cnt){
		$("[name=curPage]").val(cnt);
		localStorage.setItem("sclistPg",cnt) 
		$("#frm01").submit()
	}
	if(${SCsch.curPage==1}){
		$("[name=prev]").attr("disabled",true)
	}
	if(${SCsch.curPage==SCsch.endBlock}){
		$("[name=next]").attr("disabled",true)
	}				
	$(".pg"+${SCsch.curPage}).css({
		'background' : '#a4a4a4',
		'color' : 'white'
	})				
	function activateInput(i){
		if(confirm("수정하시겠습니까?")){
			$(".i"+i).attr("disabled",false)
			$(".cfm"+i).css("display","inline")
			$(".upt"+i).css("display","none")
		}
		$(".uptCfm").click(function(){
			if(confirm("변경사항을 저장하시겠습니까?")){
				uptAjax("uptStoreClerk.do",i)				
			}
		})
	}
	function uptAjax(url,i) {
		$.ajax({
			type : "post",
			url : "/ferp/" + url,
			data : $("#uptForm"+i).serialize(),
			dataType : "json",
			success : function(data) {
				console.log(data)
				location.reload()
			},
			error : function(err) {
				console.log(err)
			}
		})
	}				
	function delInfo(i){
		if(confirm("직원정보를 삭제하시겠습니까?")){
			delAjax("delStoreClerk.do",i)				
		}
	}
	function delAjax(url,i) {
		$.ajax({
			type : "post",
			url : "/ferp/" + url,
			data : $("#uptForm"+i).serialize(),
			dataType : "json",
			success : function(data) {
				console.log(data)
				alert(data.msg)
				location.reload()
			},
			error : function(err) {
				console.log($("#uptForm"+i).serialize())
				console.log(err)
			}
		})
	}
	function cFile(clerkName,clerkNum){
		$("#modal3").attr("style", "display:block");
		$("#clerkname").text(clerkName)
		$("#clerknum").text(clerkNum)
		$(".fileip[name=clerkNum]").val(clerkNum)
	}
	$("#closeBtn").click(function() {
		$("#modal3").attr("style", "display:none");
	}); 
	function tel(target) {
	    target.value = target.value
	        .replace(/[^0-9]/g, '')
	        .replace(/(^02.{0}|^01.{1}|[0-9]{3,4})([0-9]{3,4})([0-9]{4})/g, "$1-$2-$3");
	}
</script>
<script src="${path}/resource/templates/A2_modalJS.js"></script>
</body>
</html>