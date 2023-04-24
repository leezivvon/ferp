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
<title>문의글 조회</title>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<link rel="stylesheet" href="/ferp/resource/css/notice_list.css"/>
<link rel="stylesheet" href="${path}/resource/css/reset.css"/>
<link rel="stylesheet" href="${path}/resource/css/store_main_index.css"/>

</head>
<script type="text/javascript">
	localStorage.setItem("pageIdx","5103")
	localStorage.setItem("eqIdx","5000")
</script>
<body class="container">
	<%@ include file="/resource/templates/header.jsp"%>
	<div class="main_wrapper">
		<%@ include file="/resource/templates/sidebar.jsp"%>
		<div class="contents">
          		<h2 class="notice_main">문의글</h2>
          		<div class="sch_line">
          			<form method="post">
	           		<input type="text" name="title" id="title" value="${sch.title}" placeholder="제목 검색">
					<button type="button" class="schBtn">검 색</button>
					<input type="hidden" name="curPage" value="${sch.curPage}"/>
				</form>
          		</div>
			<table>
		   	<col width="15%">
		   	<col width="50%">
		   	<col width="15%">
		   	<col width="10%">
		   	<col width="10%">
			    <thead>
			      <tr>
			        <th>NO</th>
			        <th>제목</th>
			        <th>작성자</th>
			        <th>작성일</th>
			        <th>조회수</th>
			      </tr>
   				</thead>
			    <tbody>
			    	<c:forEach var="qna" items="${qna}">
			    	<tr>
			    		<td>${qna.cnt}</td>
			    		<td class="tab_title" style="text-align: left;" onclick="goDetail('${qna.noticeNum}')">
    		    			<c:if test="${qna.level>1}">
				    			<c:forEach begin="2" end="${qna.level}">
				    			&nbsp;&nbsp;&nbsp;
				    			</c:forEach>
			    				<img src="${path}/resource/img/rere.png" width="3%" height="5%">
			    			</c:if>
			    		${qna.title}</td>
			    		<td>${qna.writer}</td>
			    		<td><fmt:formatDate value="${qna.regdte}"/></td>
			    		<td class="numberData">${qna.readCnt}</td>
			    	</tr>
					</c:forEach>
			    </tbody>	
			</table>
			<div class="page_wrap">
			   <div class="page_nation">
			   <c:if test="${sch.startBlock > 0}">
			      <a class="arrow prev" href="javascript:goPage(${sch.startBlock-1});"></a>
			      <c:forEach var="cnt" begin="${sch.startBlock}" end="${sch.endBlock}">
			      	<a href="#" class="${sch.curPage==cnt?'active':''}" onclick="goPage(${cnt})">${cnt}</a>
			      </c:forEach>			    
			      <a class="arrow next" href="javascript:goPage(${sch.endBlock+1});"></a>
			   </c:if>
			   </div>
			</div>
		</div>

	</div>
</body>
<script type="text/javascript">
$(document).ready(function(){
	<%-- 
	
	--%>
    var insMsg = "${insMsg}"
    if(insMsg != ""){
		  Swal.fire({
			  title: '등록 성공!',
			  icon: 'success',
			  showCancelButton: false, // cancel버튼 보이기. 기본은 원래 없음
			  confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
			  confirmButtonText: '확인', // confirm 버튼 텍스트 지정
			}).then((result) => {
			  if (result.value) {
				//"확인" 버튼을 눌렀을 때 작업할 내용
			  }
			})	
    }
    var uptMsg = "${uptMsg}"
    if(uptMsg != ""){
		  Swal.fire({
			  title: '문의글 수정 성공!',
			  icon: 'success',
			  showCancelButton: false, // cancel버튼 보이기. 기본은 원래 없음
			  confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
			  confirmButtonText: '확인', // confirm 버튼 텍스트 지정
			}).then((result) => {
			  if (result.value) {
				//"확인" 버튼을 눌렀을 때 작업할 내용
			  }
			})	
    }
    var delMsg = "${delMsg}"
    if(delMsg != ""){
		  Swal.fire({
			  title: '문의글 삭제 성공!',
			  icon: 'success',
			  showCancelButton: false, // cancel버튼 보이기. 기본은 원래 없음
			  confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
			  confirmButtonText: '확인', // confirm 버튼 텍스트 지정
			}).then((result) => {
			  if (result.value) {
				//"확인" 버튼을 눌렀을 때 작업할 내용
			  }
			})	
    }
    $(".schBtn").click(function(){
    	$("form").submit()
    })
});

function goPage(cnt) {
	$("[name=curPage]").val(cnt);
	$("form").submit()
}
// 상세페이지로 이동
function goDetail(noticeNum) {
	  location.href="${path}/qnaDetail.do?noticeNum="+noticeNum;
}
</script>
</html>