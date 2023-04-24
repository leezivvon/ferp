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
<title>재고 입출고</title>
<!-- 제이쿼리 CDN -->
<script src="https://code.jquery.com/jquery-3.6.3.js" integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${path}/resource/css/basicStyle.css"/>
<link rel="stylesheet" href="${path}/resource/css/displayingSY.css" />
<style>
.inputbox{
	width: 200px;
}
.searchtab{
	border: 1px solid lightgray;
	margin-top: 10px;
}
#insertForm select,
#insertForm input[type="hidden"],
#insertForm input[type="number"],
#insertForm button {
    display: inline-block;
    vertical-align: middle;
    margin-right: 10px;
}
#insertForm select {
    width: 200px; /* 선택한 값의 길이에 따라 조절 */
}
#insertForm button {
    margin-right: 0; /* 버튼과 인풋 요소 사이의 간격 없앰 */
}
#deleteForm {
    display: none;
}
#updateForm {
    display: none;
}
.toolbar {
	display: inline-flex;
}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$("[name=productNum]").val("${sch.productNum}");
		$("#applyAmount").on("keydown", function(event) {
		    event.preventDefault();
		});
		<%-- 
		$('.uptbtn').each(function() {
		    var applyAmount = parseInt($(this).closest('tr').find('td:nth-child(6)').text().trim());
		    if (!isNaN(applyAmount) && applyAmount >= 0) {
				$(this).hide();
			} else {
				$(this).show();
			}
		});
		(+)항목에 삭제 버튼 안보이게
		$('.delBtn').each(function() {
		    var applyAmount = parseInt($(this).closest('tr').find('td:nth-child(6)').text().trim());
		    if (!isNaN(applyAmount) && applyAmount >= 0) {
		        $(this).hide();
		    } else {
		        $(this).show();
		    }
		});
		--%>
		<%--
		// 자재코드별로 최근일자의 데이터에만 버튼 보이게
		$("tbody tr").each(function() {
			// 현재 제품의 자재코드를 가져옴
			var productNum = $(this).find("td:first-child").text();
			// 현재 제품이 가장 위에 있는 데이터인지 확인
			var isFirst = $(this).prevAll().filter(":has(td:first-child:contains('" + productNum + "'))").length === 0;
			// 가장 위에 있는 데이터라면 버튼을 보이게 함
			if (isFirst) {
				$(this).find(".uptbtn").show();
				$(this).find(".delBtn").show();
			} else {
				$(this).find(".uptbtn").hide();
				$(this).find(".delBtn").hide();
			}
		});--%>
		
		if (${sch.curPage} == 1) {
			// 각 자재코드별로 최근일자 데이터를 찾아서 uptbtn, delBtn 버튼을 보이게 함
			$("tbody tr").each(function() {
				// 현재 제품의 자재코드를 가져옴
				var productNum = $(this).find("td:first-child").text();
				// 현재 제품이 가장 위에 있는 데이터인지 확인
				var isFirst = $(this).prevAll().filter(":has(td:first-child:contains('" + productNum + "'))").length === 0;
				// 가장 위에 있는 데이터라면 버튼을 보이게 함
				if (isFirst) {
					$(this).find(".uptbtn").show();
					$(this).find(".delBtn").show();
				} else {
					$(this).find(".uptbtn").hide();
					$(this).find(".delBtn").hide();
				}
			});
		} else {
			$("tbody tr").each(function() {
				$(this).find(".uptbtn").hide();
				$(this).find(".delBtn").hide();
			});
		}
		
		$("#insBtn").click(function(){
			var isInValid = false
			for(var idx=0;idx<$(".ckValid").length;idx++){
				if($(".ckValid").eq(idx).val()==""){
					alert("입력하여야 등록 가능합니다.")
					$(".ckValid").eq(idx).focus()
					isInValid = true
					break;
				}
			}
			if(isInValid){
				return
			}
			Swal.fire({
				title: '등록하시겠습니까?',
				icon: 'warning',
				showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
				confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
				cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
				confirmButtonText: '확인', // confirm 버튼 텍스트 지정
				cancelButtonText: '취소' // cancel 버튼 텍스트 지정
			}).then((result) => {
				if (result.value) {
					$("#insertForm").submit()
				}
			})
		})
		
		// 등록시 최소 수량 지정
		$('select[name="productNum"]').change(function() {
			const remainAmount = $(this).find('option:selected').attr('id');
			$('input[name="applyAmount"]').attr('min', remainAmount);
		}); 
		
		$('.delBtn').on('click', function() {
			Swal.fire({
				title: '삭제하시겠습니까?',
				icon: 'warning',
				showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
				confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
				cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
				confirmButtonText: '확인', // confirm 버튼 텍스트 지정
				cancelButtonText: '취소' // cancel 버튼 텍스트 지정
			}).then((result) => {
				if (result.value) {
					var row = $(this).closest('tr');
					var productNum = row.find('td:nth-child(1)').text().trim();
					var applyAmountS = row.find('td:nth-child(6)').text().trim();
					var applyAmount = applyAmountS !== "" ? parseInt(applyAmountS) : 0;
					var remainAmountS = row.find('td:nth-child(7)').text().trim();
					var remainAmount = remainAmountS !== "" ? parseInt(remainAmountS) : 0;
					$('#deleteForm [name=productNum]').val(productNum);
					$('#deleteForm [name=applyAmount]').val(applyAmount);
					$('#deleteForm [name=remainAmount]').val(remainAmount);
					$("#deleteForm").submit();
				}
			})
		})
		$('.uptbtn').on('click', function() {
			const span = $(this).find('span');
			span.text('완료');
			console.log('1111');
			const row = $(this).closest('tr');
			const productNum = row.find('td:nth-child(1)').text().trim();
			const remainAmount = row.find('td:nth-child(7)').text().trim();
			$('#updateForm [name=productNum]').val(productNum);
			$('#updateForm [name=remainAmount]').val(remainAmount);
			
			const minValue=$('#updateForm [name=remainAmount]').val();
			const applyAmountTd = $(this).closest('tr').find('td:nth-child(6)');
			const applyAmountInput = $(`<input style="width:100px;" type="number" 
				value="${applyAmountTd.text().trim()}" min='-`+minValue+`'>`);
			
			applyAmountTd.html(applyAmountInput);
			span.on('click', function() {
				if (applyAmountInput.val().trim() === '') {
					alert('입력값을 입력해주세요.');
					return;
				}
				Swal.fire({
					title: '수정하시겠습니까?',
					icon: 'warning',
					showCancelButton: true,
					confirmButtonColor: '#3085d6',
					cancelButtonColor: '#d33',
					confirmButtonText: '확인',
					cancelButtonText: '취소'
				}).then((result) => {
					if (result.value) {
						$('#updateForm [name=applyAmount]').val(applyAmountInput.val().trim());
						$("#updateForm").submit();
					}
				})
			});
		});
	});
</script>
</head>
<body class="container">
	<%@ include file="/resource/templates/header.jsp"%>
	<div class="main_wrapper">
		<%@ include file="/resource/templates/sidebar.jsp"%>
		<div class="contents">
		<form id="updateForm" action="${path}/sinoutUpt.do">
		    		<input type="text" name="productNum"/>
		    		<input type="text" name="applyAmount"/>
		    		<input type="text" name="remainAmount"/>
		    	</form>
		<h2>재고 입출고 내역</h2><br><hr><br>
		<div class="toolbox">
		<h3>재고 입출고 검색</h3><br>
			<form class="toolbar" method="post" id="reqSchFrm">
				<select name="productNum" required>
					<option value="">자재코드선택</option>
			        <c:forEach var="pn" items="${productNumCom}">
				        <c:if test="${pn.frRegiNum == login.frRegiNum}">
							<option>${pn.productNum}</option>
						</c:if>
					</c:forEach>
				</select>
				<button class="btn-secondary" type="submit">검색</button>
				<input type="hidden" name="curPage" value="${sch.curPage}" />
			</form>
		</div>
		<div class="toolbox">
		<h3>재고 입출고 등록</h3><br>
			<form action="${path}/sinoutIns.do" id='insertForm'>
				<select name="productNum" class="ckValid" required>
			    	<option value="">자재코드선택</option>
			    	<c:forEach var="pd" items="${remainlist}">
			    		<option id="-${pd.remainAmount}">${pd.productNum}</option>
			    	</c:forEach>
			    </select>
			    <input type="hidden" name="frRegiNum" value="${login.frRegiNum}" id="frRegiNum">
				<input type="number" name="applyAmount" value="${param.applyAmount}"
					class="ckValid"	id="applyAmount" placeholder="수량 입력" required>
				<button id="insBtn" class="btn-primary" type="button">등록</button>
			</form>
		</div>
			<div class="searchtab">
				<table>
				<thead>
					<tr><th>자재코드</th><th>카테고리명</th><th>자재명</th><th>일자</th>
						<th>단가</th><th>변동수량</th><th>전체수량</th><th>비고</th><th>수정/삭제</th></tr>
				</thead>
				<tbody>
					<c:forEach var="prod" items="${list}">
			    	    <tr>
			    	    	<td style="text-align:center">${prod.productNum}</td>
			    	    	<td style="text-align:center">${prod.category}</td>
			    	    	<td>${prod.productName}</td>
			    	    	<td style="text-align:center">${prod.stockDate}</td>
			    	    	<td style="text-align:right"><fmt:formatNumber value="${prod.price}" type='currency'/></td>
			    	    	<td style="text-align:center">${prod.applyAmount}</td>
			    	    	<td style="text-align:center">${prod.remainAmount}</td>
			    	    	<td>${prod.remark}</td>
					        <td style="text-align:center">
				            <button class="btn-secondary uptbtn" type="button"><span>수정</span></button>
							<button class="btn-danger delBtn" type="button">삭제</button></td>
			    	    </tr>
			    	</c:forEach>
				</tbody>
				</table>
				<form id="deleteForm" action="${path}/sinoutDel.do">
		    		<input type="text" name="productNum"/>
		    		<input type="text" name="applyAmount"/>
		    		<input type="text" name="remainAmount"/>
		    	</form>
		    	<c:if test="${sch.startBlock > 0}">
					<div style="text-align:center;">
						<button name="prev" class="pgBtnPrev" onclick="location.href='javascript:goPage(${sch.startBlock-1});'">
							&lt;
						</button>
							<c:forEach var="cnt" begin="${sch.startBlock }" end="${sch.endBlock}">
						  		<button class="pgBtn pg${cnt}" onclick="location.href='javascript:goPage(${cnt});'">
									${cnt}
								</button>
						  	</c:forEach>
					  	<button name="next" class="pgBtnNext" onclick="location.href='javascript:goPage(${sch.startBlock+1});'">
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
if(${sch.curPage==1}){
	$("[name=prev]").attr("disabled",true)
}
if(${sch.curPage==sch.endBlock}){
	$("[name=next]").attr("disabled",true)
}

$(".pg"+${sch.curPage}).css({
	'background' : '#a4a4a4',
	'color' : 'white'
})
</script>
</html>