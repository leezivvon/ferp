<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
<title>스케줄 관리</title>
<script src='${path}/a00_com/dist/index.global.js'></script>
<!-- 제이쿼리 CDN -->
<script src="https://code.jquery.com/jquery-3.6.3.js" integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<link rel="stylesheet" href="${path}/resource/css/basicStyle.css"/>
<link rel="stylesheet" href="${path}/resource/css/displayingSY.css" />
<style type="text/css">
.fc-scroller{
	overflow: hidden !important;
}
</style>
<script type="text/javascript">
	localStorage.setItem("pageIdx","3204")
	localStorage.setItem("eqIdx","3000")
</script>
<script>
  // 위 js를 사용할 수 있게 같은 폴드에 있는 dist 폴드를
  // 복사해서 webapp/a00_com 폴드하위에 넣어주세요.
  var today = new Date().toISOString().split("T")[0];
  
  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
      headerToolbar: {
    	  left: 'prev,next today',
          center: 'title',
          right: 'dayGridMonth,timeGridWeek'//,timeGridDay
      },
      initialDate: today,
      //navLinks: true, // can click day/week names to navigate views
      selectable: false,
      selectMirror: true,
      select: function(arg) {
        /*
    	var title = prompt('일정 등록:');
        if (title) {
          calendar.addEvent({
            title: title,
            start: arg.start,
            end: arg.end,
            allDay: arg.allDay
          })
        }
        calendar.unselect()
        */
      },
      eventClick: function(arg) {
    	    if (confirm('해당 스케줄을 삭제 하시겠습니까?')) {
    	        function formatDate(date) {
    	            let year = date.getFullYear();
    	            let month = ("0" + (date.getMonth() + 1)).slice(-2);
    	            let day = ("0" + date.getDate()).slice(-2);
    	            let hour = ("0" + date.getHours()).slice(-2);
    	            let minute = ("0" + date.getMinutes()).slice(-2);
    	            let second = ("0" + date.getSeconds()).slice(-2);
    	            return year + "-" + month + "-" + day + "T" + hour + ":" + minute ;
    	        }
    	        $.ajax({
    	            url: '${path}/sclerkschdDel.do',
    	            type: 'POST',
    	            data: { clerkName: arg.event.title, onDay: formatDate(arg.event.start) },
    	            success: function(result) {
    	                alert('삭제 완료');
    	                location.reload();
    	            },
    	            error: function(jqXHR, textStatus, errorThrown) {
    	                alert('삭제 실패');
    	            }
    	        });
    	        arg.event.remove();
    	    }
    	},

      /*
      eventClick: function(arg) {
        if (confirm('Are you sure you want to delete this event?')) {
          arg.event.remove()
        }
      },
      editable: true,*/
      dayMaxEvents: true, // allow "more" link when too many events
      events: function (info, successCallback, failureCallback){
    	  $.ajax({
    		  type:"post",
    		  url:"${path}/schdajax.do", 
    		  dataType:"json",
    		  success:function(data){
    			  console.log(data.list)
    			  successCallback(data.list)
    		  },error:function(err){
    			  console.log(err)
    		  }
    	  })
      }
    	  
    });

    calendar.render();
  });

</script>
<style>

  body {
    margin: 40px 10px;
    padding: 0;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
  }

  #calendar {
    max-width: 1100px;
    margin: 0 auto;
  }

	#insertForm {
        display: flex;
        flex-direction: row;
    }
</style>
</head>
<body class="container">
	<%@ include file="/resource/templates/header.jsp"%>
	<div class="main_wrapper">
		<%@ include file="/resource/templates/sidebar.jsp"%>
		<div class="contents">
		<h2>직원 스케줄 캘린더</h2><br><hr><br>
		<div class="toolbox">
		<h3>직원 스케줄 등록</h3><br>
			<div class="toolbar">
				<div>
					<form action="${path}/sclerkschdIns.do" id='insertForm' class="form-inline">
				    <label>직원선택
				    <select name="clerkNum" class="ckValid" required>
				        <option value="">직원선택</option>
				        <c:forEach var="ck" items="${clerkNumCom}">
					        <c:if test="${ck.frRegiNum == login.frRegiNum}">
								<option value="${ck.clerkNum}">${ck.clerkName}</option>
							</c:if>
						</c:forEach>
				    </select></label>
				    <input type="hidden" name="frRegiNum" value="${login.frRegiNum}" id="frRegiNum">
				    <label>출근시간 <input type="datetime-local" name="onDay" 
						value="${param.onDay}" class="ckValid timeset" id="onDay" 
						placeholder="출근시간 입력" step="1800" 
						pattern="\d{4}-\d{2}-\d{2}T([01]\d|2[0-3]):([03]0)"></label>
					<label>퇴근시간 <input type="datetime-local" name="offDay" 
						value="${param.offDay}" class="ckValid timeset" id="offDay" 
						placeholder="퇴근시간 입력" step="1800" 
						pattern="\d{4}-\d{2}-\d{2}T([01]\d|2[0-3]):([03]0)"></label>
				</div>
			    <div>
			    	<button id="insBtn" class="btn-primary" type="button">등록</button>
			    </div>
				</form>
			</div>
		</div>
  			<div id='calendar'></div>
		</div>
	</div>
</body>
<script type="text/javascript">
	function setTo30Minutes(input) {
		const value = input.value;
		const date = new Date(value);
		const timezoneOffset = date.getTimezoneOffset() * 60000; // milliseconds
		const localDate = new Date(date.getTime() - timezoneOffset); // 현재 시간대 고려
		const minutes = Math.floor(localDate.getMinutes() / 30) * 30;
		localDate.setMinutes(minutes);
		const newValue = localDate.toISOString().slice(0, 16);
		input.value = newValue;
	}
	$(document).ready(function() {
		// 현재 날짜와 시간을 구합니다.
		var now = new Date().toISOString().slice(0, 16);
		
		// 출근시간 입력 폼을 가져와서 현재 날짜 이전의 모든 날짜를 비활성화합니다.
		$("#onDay").attr("min", now);
		
		// 퇴근시간 입력 폼을 가져와서 현재 날짜 이전의 모든 날짜를 비활성화합니다.
		$("#offDay").attr("min", now);
		
		$(".timeset").on("change", function() {
			setTo30Minutes(this);
		});
		
		// 출근시간 선택 시
		$('#onDay').change(function() {
			// 출근시간에서 년월일 정보 추출
			var onDate = $('#onDay').val().substr(0, 10);
			// 퇴근시간에 년월일 정보 입력 및 시간 선택 가능하도록 처리
			$('#offDay').val(onDate + 'T00:00');
		});

		// 퇴근시간 선택 시
		$('#offDay').change(function() {
			var onTime = new Date($('#onDay').val()).getTime();
			var offTime = new Date($('#offDay').val()).getTime();
			// 근무시간 계산
			var workHours = (offTime - onTime) / (1000 * 60 * 60);
			if (workHours > 8) {
				alert("하루 근무시간이 8시간을 초과할 수 없습니다");
				$('#offDay').val("");
			}
		});
		
		
		$("#insBtn").click(function() {
			var isInValid = false;
			for (var idx = 0; idx < $(".ckValid").length; idx++) {
				if ($(".ckValid").eq(idx).val() == "") {
					alert("입력하여야 등록 가능합니다.");
					$(".ckValid").eq(idx).focus();
					isInValid = true;
					break;
				}
			}
			if (isInValid) {
				return;
			}
			// 출근시간, 퇴근시간 값을 가져옴
			var onDay = $("#onDay").val();
			var offDay = $("#offDay").val();
			
			// 출근시간이 퇴근시간보다 작을 때만 등록
			if (onDay < offDay) {
				// 등록 처리
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
						$("form").submit()
					}
				})
			} else {
				alert("출근시간이 퇴근시간보다 큽니다.");
			}
		});
	});
	
</script>
</html>
