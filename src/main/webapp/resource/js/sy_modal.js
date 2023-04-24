/**
 * 
 */

//모달 버튼 할당
function openModal(modalID,openBtn){
	//모달 닫기버튼으로 닫기
	$('.btn-close').on('click',function(){
		$(modalID).addClass('modal')
		$(modalID).removeClass('modal-open')
	})
	//4번째 열 누르면 모달 열리게
	$(openBtn).on('click',function(){
		$(modalID).addClass('modal-open')
		$(modalID).removeClass('modal')
	})
}
