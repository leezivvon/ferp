/**
 * input 할때마다 실행되게
 */
function dateMinMax(start,end){
	let di1= document.querySelector(start);
	let di2 = document.querySelector(end);
	di1.setAttribute('max',di2.value)
	di2.setAttribute('min',di1.value)
}