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
<title>전표입력</title>

<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<link rel="stylesheet" href="${path}/resource/css/basicStyle.css" />
<link rel="stylesheet" href="${path}/resource/css/displayingSY.css" />
<script type="text/javascript" src="${path }/resource/js/sy_fetchs.js"></script>
<script type="text/javascript" src="${path }/resource/js/sy_validateCheck.js"></script>
	
<script>
localStorage.setItem("pageIdx","7210")
localStorage.setItem("eqIdx","7000")
</script>

<style>
td:nth-child(1),td:nth-child(2),td:nth-child(4){width: 8em;	}
td:nth-child(2) input ,td:nth-child(4) input{text-align: right;}
tfoot td:nth-child(2),tfoot td:nth-child(4){text-align: right;}
td:nth-child(3){width:9em;}
.rowAddRemove{
display: flex;
justify-content: flex-end;
}
.rowAddRemove button{
margin:0.5em;
font-size: 1em;
text-align: center;}
</style>
</head>

<body class="container">
	<%@ include file="/resource/templates/header.jsp"%>
	<div class="main_wrapper">
		<%@ include file="/resource/templates/sidebar.jsp"%>
		<div class="contents">
		<h2>전표 입력</h2>
		<hr><br>
		<form action="${path }/insertACstatement.do" method="post" id="form1">
		<div class="toolbox">
			<div class="toolbar">
				<div><button class="btn-dark" type="button" @click='prevSelect' :style="prevbtn" style="display: none;">이전전표</button>
				<button class="btn-dark" type="button" @click='nextSelect' :style="nextbtn" style="display: none;">다음전표</button></div>
			<div>
					<button class="btn-reset" title="저장되지 않은 내용을 모두 삭제하고 새 전표를 입력합니다." type="button" @click='resetBtn'>새 전표</button>
					<button class="btn-danger" type="button" @click='deleteThis'>삭제하기</button>
				</div>
			</div>
			<div class="toolbar">
				<div title="전표번호가 비어있으면 새로운 전표로 입력하고, 그렇지 않으면 기존 전표가 수정됩니다.">
				<fieldset id="forSelect">
					<label>전표일자<span id="stmtDateVFD" class="valid-feedback">날짜를 입력하세요</span><input type="date" name="stmtDate" required="required" v-model='stmtDate'>
					</label>
					<label>전표번호<span id="stmtNumVFD" class="valid-feedback">전표번호를 입력하세요</span><input name="statementNum" placeholder="검색할때만 입력하세요" required v-model="statementNum"></label>
					<input name="frRegiNum" v-model="frRegiNum" type="hidden" >
				</fieldset>
					<button type="button" class="btn-secondary" @click='select'>검색</button>
				</div>
				<div><button type="button" class="btn-primary" @click='primary'>등록</button></div>
				<div style='display: none;'><button type="submit" id='real-submit-btn' >real-submit-btn</button></div>
			</div>
			</div>
<table>
<thead><tr><th>계정코드</th><th>차변금액</th><th>계정명</th><th>대변금액</th><th>거래처</th><th>적요</th></tr></thead>
<tbody>
 	<tr v-for="(stmt, index) in stmtlist" :key="index">
        <td><input class="lineNum" :name="`stmtlist[`+index+`].lineNum`" v-model="stmt.lineNum" type="hidden">
        <input class='acntNum' :name="`stmtlist[`+index+`].acntNum`" v-model="stmt.acntNum" required list="numList" @input="acntMatch(index)"></td>
        <td><input @input='numinput' class='debit' :name="`stmtlist[`+index+`].debit`" v-model="stmt.debit" required></td>
        <td class='acntTitle' v-text='stmt.acntTitle'> </td>
        <td><input @input='numinput' class='credit' :name="`stmtlist[`+index+`].credit`" v-model="stmt.credit" required></td>
        <td><input :name="`stmtlist[`+index+`].stmtOpposite`" v-model="stmt.stmtOpposite"></td>
        <td><input :name="`stmtlist[`+index+`].remark`" v-model="stmt.remark"></td>
    </tr>
</tbody>       
<tfoot>
<tr><td>차변합계</td><td>{{totaldebit}}</td><td>대변합계</td><td>{{totalcredit}}</td><td>차액</td><td>{{debitCreditGap}}</td></tr>
</tfoot>
</table>
<datalist id="numList">
<option v-for='(each) in accountList' :value='each.acntNum' :label='each.acntTitle'/>
</datalist>
</form>
<div class="rowAddRemove"><button type="button" @click="addRow">행 추가</button><button type="button" id="BtnRemoveRow" @click="removeRow">행 삭제</button>	</div>
<div class="valid-feedback" id="needmorethan2rows" style="text-align: right;">2행 미만일땐 등록이 불가능합니다</div>
		</div>
	</div>
	
<script>
$(document).ready(function(){
	fetchSelectPromise('#searchform','${path}/selectAccountJson.do').then(result=>{
	var vm=	new Vue({
		  el: '.contents',
		  data: {
			index:0,
			rronum:0,
			frRegiNum:'${login.frRegiNum}',
			totaldebit:0,
			totalcredit:0,
			debitCreditGap:0,
			stmtDate:'',
			statementNum:'',
		    stmtlist: [
		      { lineNum: 0, acntNum: '', debit: 0, acntTitle: '', credit: 0, stmtOpposite: '', remark: '' },
		      { lineNum: 1, acntNum: '', debit: 0, acntTitle: '', credit: 0, stmtOpposite: '', remark: '' }
		    ],
		    prevbtn:'',
		    nextbtn:'',
		    accountList:result.list
		  },
		  methods: {
		    addRow() {
		      // 행 추가 로직 구현
		      this.index=this.stmtlist.length;
		      let newrow={ lineNum: this.index , acntNum: '', debit: 0, acntTitle: '', credit: 0, stmtOpposite: '', remark: '' }
		      this.stmtlist.push(newrow);
		      const btnremove=document.querySelector('#BtnRemoveRow')
			    if(this.stmtlist.length>2){
			    	btnremove.disabled=false;
			    	validClass('#BtnRemoveRow','#needmorethan2rows')
			    }
		    },
		    removeRow(){
		    	const btnremove=document.querySelector('#BtnRemoveRow')
			    if(this.stmtlist.length==2){
			    	btnremove.disabled=true;
			    	invalidClass('#BtnRemoveRow','#needmorethan2rows')
			    }else{
			    	this.stmtlist.pop();
			    }
		    },
		   acntMatch(index){
		    	const stmt = this.stmtlist[index];
		        const account = this.accountList.find(a => a.acntNum === stmt.acntNum);
		        if (account) {
		        	this.$set(this.stmtlist[index], 'acntTitle', account.acntTitle);
		        } else {
		        	this.$set(stmt, 'acntTitle', '');
		        }
		    },
		   numinput(){
		    	 let debitSum = 0;
		         for (let i = 0; i < this.stmtlist.length; i++) {
		           if (this.stmtlist[i].debit !== '') {
		             debitSum += parseFloat(this.stmtlist[i].debit);
		           }
		         }
		         this.totaldebit = debitSum.toLocaleString();;

		         // stmtlist의 모든 credit을 더해서 this.totalcredit을 구하는 로직
		         let creditSum = 0;
		         for (let i = 0; i < this.stmtlist.length; i++) {
		           if (this.stmtlist[i].credit !== '') {
		             creditSum += parseFloat(this.stmtlist[i].credit);
		           }
		         }
		         this.totalcredit = creditSum.toLocaleString();
		         this.debitCreditGap=(debitSum-creditSum).toLocaleString();
		    },
		    generalSelect(url){
		    		fetch(url)
		    		.then(response=>response.json())
		    		.then(json=>{
		    			console.log(json.stmtList)
						if(json.stmtList.length>0){
			    			//출력하고 총액구하기 
			    			this.stmtlist=json.stmtList;
			    			this.rronum=json.stmtList[0].rronum;
			    			this.frRegiNum=json.stmtList[0].frRegiNum;
			    			this.stmtDate=json.stmtList[0].stmtDate.substr(0,10);
			    			this.statementNum=json.stmtList[0].statementNum;
			    			this.numinput()
			    			//앞뒤로 가는 버튼 
			    			let rronum=this.rronum;
			    			this.prevbtn=``;
			    			this.nextbtn=``;
			    			if(rronum!=1 && rronum!=-1 ){	//맨앞 아닐때 
			    				this.prevbtn='display:inline-block;'
			    			}else{
			    				this.prevbtn='display:none;'
			    			}
			    			if(this.rronum>0){
			    				this.nextbtn='display:inline-block;'
			    			}else{
			    				this.nextbtn='display:none;'
			    			}
			    			//계정명
			    			for(let i=0; i<this.stmtlist.length; i++){
					    		this.acntMatch(i);
					    	}
						}else{
							this.stmtlist=json.stmtList;
							this.totalcredit = 0;
					        this.totaldebit=0;
							this.debitCreditGap=0;
						}
		    		}).catch(error=>{console.error(error)})
		    },
		    select(){
		    	if(document.querySelector('[name=stmtDate]').checkValidity()){
		    		let serial=$('#forSelect').serialize()
		    		this.generalSelect("${path }/selectACstatementJson.do?"+serial)
		    	}else{
		    		invalidClass('[name=stmtDate]','#stmtDateVFD')
		    	}
		   },
		   prevSelect(){
				let rronum=this.rronum;
				if(rronum<0){rronum=rronum*(-1);}
				rronum=rronum-1;
			    let url="${path }/selectACstatementJson.do?stmtDate="+this.stmtDate+"&rronum="+rronum+"&frRegiNum="+this.frRegiNum;
			    console.log(url)
			    this.generalSelect(url)
		   },
		   nextSelect(){
				let rronum=this.rronum;
				rronum=Number(rronum)+1
				let url="${path }/selectACstatementJson.do?stmtDate="+this.stmtDate+"&rronum="+rronum+"&frRegiNum="+this.frRegiNum;
				console.log(url)
				this.generalSelect(url)
		   },
		   resetBtn(){
			   this.stmtlist= [
				      { lineNum: 0, acntNum: '', debit: 0, acntTitle: '', credit: 0, stmtOpposite: '', remark: '' },
				      { lineNum: 1, acntNum: '', debit: 0, acntTitle: '', credit: 0, stmtOpposite: '', remark: '' }
				    ]
			   this.statementNum='';
		   },
		   primary(){
				let statementNum = $('[name=statementNum]').val();
				if(statementNum==''){
					let conf=confirm('새 전표를 등록할까요?')
					if(conf){
					$('[name=statementNum]').val('WR');
					multipathSubmit('form1',"${path }/insertACstatement.do");
					}else{ return false;}
				}else if(statementNum.length==6){
					let conf=confirm('전표를 수정하시겠습니까?')
					if(conf){
					multipathSubmit('form1',"${path }/updateACstatement.do");
					}else{return false;}
				}
		   },
		  deleteThis(){
			   if(!document.querySelector('[name=stmtDate]').checkValidity()){
					invalidClass('[name=stmtDate]','#stmtDateVFD')
				}else if(document.querySelector('[name=statementNum]').value.length!=6){
					invalidClass('[name=statementNum]','#stmtNumVFD')
					setTimeout(validClass,5000,'[name=statementNum]','#stmtNumVFD');
				}else{
					location.href="${path }/deleteACstatement.do?stmtDate="+$('[name=stmtDate]').val()+"&statementNum="+$('[name=statementNum]').val()+"&frRegiNum="+$('[name=frRegiNum]').val()
				}   
		   }
		  }
		});
	}).catch(function(error){console.error(error);})
	
})	
	
</script>

</body>
</html>