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
<title>매장QA등록</title>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>


<link rel="stylesheet" href="${path}/resource/css/basicStyle.css" />
<link rel="stylesheet" href="${path}/resource/css/displayingSY.css" />
<style type="text/css">
	
	#h1ck{
		text-align: center;
		padding: 20px 0 30px;
	}
	
	.ctrdata{
		text-align: center;
	}
	
	tbody tr{
		cursor:pointer;
	}
	table td{
		vertical-align: middle;
	}
	
	.btn-primary {
		font-size: 23px;
    	font-weight: 500;
		margin-left: auto;/*오른쪽으로 보내기*/
   		width: 80px;
   		height:50px;
   		line-height:50px;
   		border-radius: 5px;
   	 	text-align:center;
   	 	margin-top: 30px;
	}
	
</style>

</head>

<body class="container">
	<%@ include file="/resource/templates/header.jsp"%>
	<div class="main_wrapper">
		<%@ include file="/resource/templates/sidebar.jsp"%>
		<div class="contents">
			
			
			<h2>QA등록</h2><br><hr><br>
			
			<% 
			request.setCharacterEncoding("UTF-8");
			String frRegiNum =request.getParameter("frRegiNum");
			%>
						
			<!-- 표 시작 -->
			<form> 
			<h1 id="h1ck">매장위생안전점검</h1>
				<table>
					<col width="10%">
					<col width="50%">
					<col width="10%">
					<col width="30%">
					<thead>
						<tr><th>항목번호</th><th>항목</th><th>이상없음</th><th>비고</th></tr>
					</thead>
					<tbody></tbody>
				</table>
				<div class="btn-primary">등록</div>
				<input type="hidden" value="<%=frRegiNum%>" name="hidfrnum">
			</form>
			<!-- 표 끝 -->
			
			

		</div>
	</div>
</body>



<script>

//사이드바에 번호 매긴 것 
localStorage.setItem("pageIdx","6101"); //id값
localStorage.setItem("eqIdx","6000");


var frRegiNum =<%=frRegiNum%>

	function print(){
		let url="${path}/inspectQAclmn.do?frRegiNum="+frRegiNum
		console.log(url);
		
		fetch(url).then(function(response){return response.json()}).then(function(json){
			//console.log(json);
			var ispQAList=json.ispQAList;
			var trtd='';
			
			ispQAList.forEach(function(each){
				trtd+="<tr><td class='ctrdata'>"+each.qaNum+"</td><td>"+each.qaItem+"</td>"
					+"<td class='ctrdata'><input name='chk' value='"+each.qaNum+"' type='checkbox'/></td>"
					+"<td><input name='wrt' type='text'/></td></tr>"
			})
			
			
			$("table tbody").html(trtd);
			console.log(trtd);
			
		}).catch(function(err){console.log(err)})	
	}
	
	
	$(document).ready(function(){
		print();
	})
	
	
	
	
	//등록하기
	var nlist =[];
	var ylist =[];
	var clist =[];
	
	function handout(){
		
		var formData = new FormData();

		var frRegiNum = $("input[name=hidfrnum]").val();
		
		
		for(var idx=0; idx<$("input[name=chk]:checkbox").length; idx++){
			// qanumlist
	    	nlist.push($("input[name=chk]:checkbox")[idx].value)
	    	
	    	// ylist
			if($("input[name=chk]:checkbox")[idx].checked==true){
	       		ylist.push("Y")
	        }else{
	    	    ylist.push("N")
	        }
			
			// clist
			clist.push($("input[name=wrt]")[idx].value)
	    }
		
		console.log(nlist)
		console.log(ylist)
		console.log(clist)
		console.log(frRegiNum)
		formData.append("nlist", nlist);
		formData.append("ylist", ylist);
		formData.append("clist", clist);
		formData.append("frRegiNum", frRegiNum);
		console.log(formData)	
		
		var data01 = { nlist:nlist, ylist:ylist, clist:clist, frRegiNum:frRegiNum}
		console.log(data01)
		//submit
		$.ajax({
		  url: '${path}/updateQAall.do',
		  type: 'post',
		  data: { nlist:nlist, ylist:ylist, clist:clist, frRegiNum:frRegiNum},
		  //contentType: false, //get방식
		  //processData: false,
		  success: function (response) {
    		  Swal.fire({
    			  title: '등록되었습니다!',
    			  icon: 'success',
    			  showCancelButton: false, // cancel버튼 보이기. 기본은 원래 없음
    			  confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
    			  confirmButtonText: '확인', // confirm 버튼 텍스트 지정
    			}).then((result) => {
    			  if (result.value) {
    				  location.href="${path}/inchargeStore.do"
    			  }
    			})	
		  },
		  error: function (xhr, status, error) {
			  alert("등록에 실패하였습니다")
		  }
		});
	
	}
	
	
	
	
	
	//클릭체줄
	$(".btn-primary").click(function(){
		
		  Swal.fire({
			  title: '등록 후 수정이 불가능합니다.\n제출하시겠습니까?',
			  icon: 'question',
			  showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
			  confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
			  cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
			  confirmButtonText: '확인', // confirm 버튼 텍스트 지정
			  cancelButtonText: '취소' // cancel 버튼 텍스트 지정
			}).then((result) => {
			  if (result.value) {
				  handout();
			  }
			})
		
	});
	
	//엔터제출
	$("input").keyup(function(event){
		if(event.keyCode==13){
			  Swal.fire({
				  title: '등록 후 수정이 불가능합니다.\n제출하시겠습니까?',
				  icon: 'question',
				  showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
				  confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
				  cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
				  confirmButtonText: '확인', // confirm 버튼 텍스트 지정
				  cancelButtonText: '취소' // cancel 버튼 텍스트 지정
				}).then((result) => {
				  if (result.value) {
					  handout();
				  }
				})
		}
	});
	
	

	
	var ylist = [];  //y 담을 list
	var fylist="";
	var ych="";
	
	//var comnlist =[]; // 비고 담을 list [[],[],[]]
	//var comn ="";
	//var comnlist = new Array();
	
	/*
	function handout() {
	
		var formData = new FormData();
		/*
		FormData 객체에 form 요소의 데이터를 추가하면 자동으로 URL 인코딩되고, 
		XMLHttpRequest 객체를 이용하여 AJAX 요청을 보낼 때 요청 본문에 FormData 객체를 전달하면 더욱 간편하게 form 데이터를 전송할 수 있습니다.
		또한, FormData 객체는 바이너리 데이터를 처리하는 데도 적합합니다. 
		이러한 이유로 FormData 객체는 HTML form 요소의 데이터를 전송할 때 자주 사용됩니다.
		*./

		var frRegiNum = $("input[name=hidfrnum]").val();
		
		//y
		for(var idx=0; idx<$("input[name=chk]:checkbox").length; idx++){
	    	if($("input[name=chk]:checkbox")[idx].checked==true){
	       		ych = $("input[name=chk]:checkbox")[idx].value+", "
	       		console.log("2  "+ych)
	       		fylist+=ych  
	       }
	    }
		fylist=fylist.substring(0, fylist.length-2)
		ylist.push(fylist);
		//console.log("3 fylist  "+fylist)
		//console.log("3   "+ylist)
		
	
		//비고 
		/*
		console.log("input[name=wrt].length   "+ $('input[name=wrt]').length)
		
		
		
		for(var idxx=0; idxx<$("input[name=wrt]").length; idxx++){
			
			//if( ("input[name=wrt]")[cnt].value!="" || ("input[name=wrt]")[cnt].value==null){
				var comn = new Array();
				comn.push($("input[name=chk]:checkbox")[idxx].value) 
				comn.push($("input[name=wrt]")[idxx].value) 
			    comnlist.push(comn);
			    //console.log("4   "+comn)
				
			    
				comn = "[ "+$("input[name=chk]:checkbox")[cnt].value+", "+$("input[name=wrt]")[cnt].value+"]"
				comnlist += comn
				
				if( cnt < $("input[name=wrt]").length-1 ){
					comnlist.push([]);
					//comnlist+=", ";	
				}
			    
			//}	
		}
		 *./ 
		
		//console.log("5    "+comnlist)	
		
		
		formData.append("frRegiNum", frRegiNum);
		formData.append("ylist", ylist);
		//formData.append("comnlist", JSON.stringify(comnlist));

		//submit
		$.ajax({
		  url: '${path}/updateQAall.do',
		  type: 'post',
		  data: formData,
		  contentType: false,
		  processData: false,
		  success: function (response) {
			alert("등록되었습니다")
		  },
		  error: function (xhr, status, error) {
			  alert("등록에 실패하였습니다")
		  }
		});

	}*/
	
	
	

</script>
</html>