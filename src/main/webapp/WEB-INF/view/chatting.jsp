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
<title>채팅</title>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<link rel="stylesheet" href="/ferp/resource/css/chatting.css"/>

<link rel="stylesheet" href="${path}/resource/css/reset.css"/>
<link rel="stylesheet" href="${path}/resource/css/store_main_index.css"/>

</head>
<script type="text/javascript">
	localStorage.setItem("pageIdx","5201")
	localStorage.setItem("eqIdx","5000")
</script>
<body class="container">
	<%@ include file="/resource/templates/header.jsp"%>
	<div class="main_wrapper">
		<%@ include file="/resource/templates/sidebar.jsp"%>
		<div class="contents">
			<h2 class="title">chatting</h2>
			<div class="input-group">	
				<div class="input-group-prepend">
					<span class="input-group-text  justify-content-center">접속아이디</span>
				</div>
				<input type="hidden" id="idHidden" value="${not empty login.ename?'본사':login.frName}">
				<input id="id" class="form-control"  placeholder="접속할 아이디를 입력하세요" 
					value="${not empty login.ename?'본사':login.frName}" readonly="readonly"/>
				<button id="enterBtn" type="button" class="btn btn-success">입장</button>
				<button id="exitBtn" type="button" class="btn btn-danger" >나가기</button>			
			</div>	
			<div class="input-group">
				<div class="input-group-prepend">
					<span class="input-group-text">접속자</span>
				</div>
				<div class="input-group-append group">
				</div>
			</div>
			<div class="input-group">	
				<div class="input-group-prepend">
					<span class="input-group-text">내용</span>
				</div>
				<div id="chatArea" class="input-group-append">
					<div id="chatMessageArea"></div>
				</div>
			</div>
			<div class="input-group">	
				<div class="input-group-prepend">
					<span class="input-group-text">메시지</span>
				</div>
				<input id="msg" class="form-control" value="" placeholder="보낼 메시지 입력" readOnly/>
				<button id="sendBtn" type="button" class="btn btn-info">메시지전송</button>		
			</div>
		</div>
		

		
	</div>	
</body>
<script type="text/javascript">
console.log('${important.title}')
	window.addEventListener("resize", function() {
		//console.log("크기 변경")
		//console.log("#chatArea 크기 변경:"+$("#chatArea").width())
		//console.log("#chatMessageArea크기 변경:"+$("#chatMessageArea>div").width())
		$("#chatMessageArea>div").width($("#chatArea").width()-20)
	});	
	// 전역변수 설정 : 핸들러나 다른 기능메서드를 넘어 사용해야 되기에
	var wsocket;
	var members=[];
	
$(document).ready(function(){
	// 화면 로딩시, ajax로 접속된 아이디 출력..
	conUsers()
	$("#id").focus()
	// 이벤트 핸들러 익명 함수 호출
	// 1. 접속시1(버튼)
	$("#enterBtn").click(function(){
		console.log("접속1")
		cKId()
	})
	// 2. 접속시2(enter키) 
	$("#id").keyup(function(){
		if(event.keyCode==13){
			console.log("접속2")
			cKId()
		}
	})
	// 3. 메시지보내기1(버튼)
	$("#sendBtn").click(function(){
		console.log("메시지1")
		// 보내는사람아이디:메시지:받는사람아이디
		// 보내는사람아이디:메시지:그룹
		sendMsg()	
		
	})
	// 4. 메시지보내기2(enter키) 
	$("#msg").keyup(function(){
		if(event.keyCode==13){
			sendMsg()			
		}
	})	

	// 5. 종료 버튼    10:05~
	$("#exitBtn").click(function(){
		console.log("종료")
		if($("#id").val()!="")
		if(confirm("접속을 종료하시겠습니까?")){
			
			// 핸들러 클래스의 afterConnectionClosed 메서드 호출
			wsocket.close()
			conUsers()
			$("#chatMessageArea").text("")
			$("#msg").attr("readOnly","readOnly")
		}
		
	})
	// 6. 전송해보는 메시지 처리(socket 객체를 통해서 처리)
});
// 아이디에 대한 유효성(공백, 접속된 아이디 제외), 처리 후, 접속..
function cKId(){
	console.log(members)
	var idVal = $("#id").val()
	
	
	if($("#id").val()==""){
		alert("아이디를 입력하셔야 접속가능합니다.")
	}else{
		var isNotValid=false;
		$(members).each(function(idx, mem){
			console.log(idVal+":"+mem)
			if(idVal==mem){
				isNotValid=true;
			}
		})
		if(isNotValid){
			alert("접속한 동일한 아이디가 있습니다.")
			$("#id").val("").focus()
		}else{
			conn()
			$("#id").attr("readOnly","readOnly")
			$("#msg").removeAttr("readOnly")
			$("#msg").focus()
		}
		
	}		
	
}

// 소캩 통신 관련 공통메서드 처리
function conn(){
	wsocket = new WebSocket("ws:61.103.5.62:6080/${path}/chat-ws.do")

	wsocket.onopen=function(evt){
		console.log(evt)
		wsocket.send($("#id").val()+
				":연결 접속했습니다.")
	}

	wsocket.onmessage=function(evt){
		var revMsg = evt.data
		revMsgFun(revMsg)
	}
}

function sendMsg(){
	if($("#msg").val().length>0){
		wsocket.send( $("#id").val()+":"+
				$("#msg").val() )
		$("#msg").val("").focus()					
	}else{
		alert("메시지를 입력하세요!!")
	}
	
}	

function revMsgFun(msg){
	var alignOpt = "left"
	var backgroundOpt = "#ddd"
	var msgArr= msg.split(":");
	var sndId = msgArr[0]

	if($("#id").val()==sndId){
		alignOpt="right"
		backgroundOpt="#F9EB54"
	}

	var msgObj =$("<div></div>").text(""
			).attr("align",alignOpt).css({"width":
					$("#chatArea").width()-20, "padding":"10px 0px 5px 5px"})
	var textObj = $("<span></span>").text(msg).css({"background":backgroundOpt, "border-radius":"10px", "padding":"3px 5px 2px 5px"})
	msgObj.append(textObj)
	$("#chatMessageArea").append(msgObj)

	
	// 스크롤링 처리
	// 1. 전체 해당 데이터의 높이를 구한다.
	// 2. 포함하고 있는 부모 객체(#chatArea)에서
	//    스크롤 기능메서드로 스크롤되겡 처리한다.
	//    scrollTop()
	var height = 
		parseInt($("#chatMessageArea").height())
	//console.log("chatMessageArea 높이:"+height)
	mx+=height+20
	console.log("chatArea 높이:"+$("#chatArea").height())	
	$("#chatArea").scrollTop(mx)	
	conUsers()
}
var mx = 0
// 등록된 사용자 리스트 ajax로 가져와서, 버튼으로 리스트 처리
function conUsers(){
	$.ajax({
		url:"${path}/chGroup.do",
		dataType:"json",
		success:function(data){
			members = data.group
			var add=""
			$(data.group).each(function(idx,group){
				console.log(idx)
				console.log(group)
				add+="<button class='connectors'>"+group+"</button>"
			})
			$(".group").html(add)

		}
	})		
}



</script>
</html>