<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>계정과목 생성</title>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link rel="stylesheet" href="${path}/resource/css/basicStyle.css" />
<link rel="stylesheet" href="${path}/resource/css/displayingSY.css" />
<style>
.search{background-color:lightgray;}
</style>
<script type="text/javascript">
	localStorage.setItem("pageIdx","7201")
	localStorage.setItem("eqIdx","2")
</script>
</head>

<body class="container">
	<%@ include file="/resource/templates/header.jsp"%>
	<div class="main_wrapper">
		<%@ include file="/resource/templates/sidebar.jsp"%>
		<div class="contents">
		<h2>계정과목 관리</h2>
		<hr><br>
		<div class="toolbox">
		<h3>계정과목 검색</h3>
			<form class="toolbar" action="${path}/selectAccount.do" method="post">
			<div>
				<label>계정코드<input name="acntNum" value="${account.acntNum}" type="number"></label>
				<label>구분<select name="acntGroup">
						<option <c:if test="${account.acntGroup == '' }">selected="selected"</c:if> value="">전체</option>
						<option <c:if test="${account.acntGroup == '자산' }">selected="selected"</c:if> >자산</option>
						<option <c:if test="${account.acntGroup == '자본' }">selected="selected"</c:if> >자본</option>
						<option <c:if test="${account.acntGroup == '부채' }">selected="selected"</c:if> >부채</option>
						<option <c:if test="${account.acntGroup == '비용' }">selected="selected"</c:if> >비용</option>
						<option <c:if test="${account.acntGroup == '수익' }">selected="selected"</c:if> >수익</option></select></label>
				<label>계정명<input name="acntTitle" value="${account.acntTitle }"></label>
			</div>
				<button class="btn-secondary">계정검색</button>
			</form>
		</div>
			<table>
				<thead>
					<tr>
						<th>계정코드</th>
						<th>구분</th>
						<th>계정명</th>
						<th>사용여부</th>
					</tr>
				</thead>
				<tbody>
					<tr>
					<form action="${path }/insertAccount.do" id='insertForm'>
						<td><input id="insertNum" name="acntNum" placeholder="새로운 계정을 등록합니다" required="required" type="number" min="10000" max="99999"><div id="insertNumValid" class="valid-feedback">이미 사용중인 계정번호입니다.</div></td>
						<td><select name="acntGroup" required>
							<option>자산</option>
							<option>자본</option>
							<option>부채</option>
							<option>비용</option>
							<option>수익</option>
							</select></td>
						<td><input name="acntTitle" placeholder="새로운 계정을 등록합니다" required></td>
						<td><input value="1" type="hidden" name="acntUsing" required><button class="btn-primary">계정등록</button></td>
					</form>
					</tr>
					<c:forEach items="${accountListtrue }" var="each">
						<tr>
							<td>${each.acntNum }</td>
							<td>${each.acntGroup }</td>
							<td>${each.acntTitle }</td>
							<td><input name="acntUsing" value="${each.acntNum }" type="checkbox" checked="${each.acntUsing }"></td>
						</tr>
					</c:forEach>
					<c:forEach items="${accountListfalse }" var="each">
						<tr>
							<td>${each.acntNum }</td>
							<td>${each.acntGroup }</td>
							<td>${each.acntTitle }</td>
							<td><input name="acntUsing" value="${each.acntNum }" type="checkbox"></td>
						</tr>
					</c:forEach>
					
				</tbody>
			</table>
		</div>
	</div>
	<script type="text/javascript" src="${path }/resource/js/sy_fetchs.js"></script>
	<script type="text/javascript" src="${path }/resource/js/sy_validateCheck.js"></script>
	
	<script>
var accountListBoth=[]
<c:forEach items="${accountListtrue }" var="each">
accountListBoth.push({acntNum:'${each.acntNum }',acntGroup:'${each.acntGroup }',acntTitle:'${each.acntTitle }'})
</c:forEach>
<c:forEach items="${accountListfalse }" var="each">
accountListBoth.push({acntNum:'${each.acntNum }',acntGroup:'${each.acntGroup }',acntTitle:'${each.acntTitle }'})
</c:forEach>

$('#insertNum').on('keyup',function(){
	let myinput=$('#insertNum').val();
	for(var i=0;i<accountListBoth.length;i++){
		if(accountListBoth[i].acntNum==myinput){
			invalidClass('#insertNum','#insertNumValid')
			$('.btn-primary').attr('disabled',true);
			$('.btn-primary').addClass('btn-danger');
			break;
		}else{
			validClass('#insertNum','#insertNumValid')	
			$('.btn-primary').attr('disabled',false);
			$('.btn-primary').removeClass('btn-danger');
		}
	}
})
	
	$('[name=acntUsing]').on('click',function(){
		let acntNumVal = $(this).val()
		let acntUsingChecked = $(this).is(':checked')
		let url="${path}/updateAccountUsing.do?acntNum="+acntNumVal+"&acntUsing="+acntUsingChecked;
		console.log(url)
			fetch(url).then(function(response){return response.text() }).then(function(text){
				if(text==1){
					alert('사용여부가 변경되었습니다.')
				}
		 	}).catch(function(err){console.log(err)})
		
	})

	</script>
</body>
</html>