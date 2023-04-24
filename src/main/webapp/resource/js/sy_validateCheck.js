/**
 * 
 */
/*window.addEventListener('load', function() {
	console.log('validateCheck is included')
	document.querySelector('form').addEventListener('submit',function(){
	var invals = document.querySelectorAll(':invalid')
	invals.forEach(function(){
		console.log(this)
	})
		return false;
	})
})*/

//폼아이디랑 폼 action 바꿀거 전체, 제출할때 필요한 숨겨진 real-submit-btn있어야함
function multipathSubmit(formId, realpath) {
	let formm = document.querySelector("#" + formId)
	formm.action = realpath;
	document.querySelector('#real-submit-btn').click();
}

//invalid-feedback 클래스 바꾸는거
function invalidClass(inputid,feedbackid) {
	$(feedbackid).removeClass('valid-feedback');
	$(feedbackid).addClass('invalid-feedback');
	$(inputid).addClass('is-invalid');
}
function validClass(inputid,feedbackid) {
	$(feedbackid).addClass('valid-feedback');
	$(feedbackid).removeClass('invalid-feedback');
	$(inputid).removeClass('is-invalid');
	console.log('밸리드 실행')
}