package ferp.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ferp.dao.B1_Dao;
import vo.OpenTimeCalender;
import vo.Orders;
import vo.QA;
import vo.QAchecklist;
import vo.SCPage;
import vo.Store;

@Service
public class B1_Service {

	@Autowired(required=false)
	private B1_Dao dao;
	
	/*매장정보조회*/	
	//본사:지난달전체매장매출총액
	public int lastmonthAllSales() {
		return dao.lastmonthAllSales();
	}
	//본사:매장별매출 전체조회
	public List<Orders> salesByStoreList(Orders sbsl){
		
		if(sbsl.getFrSchOrderdt()==null) {
			// 서비스에서 if문써서 자바데이트로 넣기 
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM");
		    Calendar cal = Calendar.getInstance();
		    cal.add(Calendar.MONTH, -1);
		    sbsl.setFrSchOrderdt(formatter.format(cal.getTime()));
		    sbsl.setToSchOrderdt(formatter.format(cal.getTime()));
		}
		return dao.salesByStoreList(sbsl);
	}
	
	//본사:특정매장정보
	public Orders storeDetailInfo(String frRegiNum){
		return dao.storeDetailInfo(frRegiNum);
	}
	//본사:특정매장정보조회JSON
	public Map<String, Object> multipleJson(Orders dlist){
		
		Map<String, Object> jsonMap = new HashMap<>();		
		//본사:특정매장매출조회JSON
		jsonMap.put("detailSales", dao.detailSalesList(dlist));
		// 본사:특정매장메뉴매출조회JSON
		jsonMap.put("detailMenu", dao.detailMenuList(dlist));
		
		return jsonMap;
	}
	
	
	
	/*매장qa점검*/
	//qa표항목전체출력
	public List<QAchecklist> qaList(QAchecklist ql){
		pagination(ql);
		return dao.qaList(ql);
	};
	//페이징처리
	private void pagination(QAchecklist ql) { //vo
		if(ql.getPageSize()==0) {
			ql.setPageSize(7);//한 페이지에 몇 개
			System.out.println("출력데이터 수"+ql.getPageSize());
		}
		ql.setCount(dao.totNum()); //sql vo에 있는 데이터 수 count()
		if(ql.getCurPage()==0) { //전체데이터
			ql.setCurPage(1);
			System.out.println("현재 페이지"+ql.getCurPage());
		}
		ql.setPageCount(
			(int)Math.ceil(
					ql.getCount()/(double)ql.getPageSize())
			);
		if(ql.getCurPage()>ql.getPageCount()) {
			ql.setCurPage(ql.getPageCount());
		}
		ql.setStart((ql.getCurPage()-1)*ql.getPageSize()+1);
		ql.setEnd(ql.getCurPage()*ql.getPageSize());
		ql.setBlockSize(5);
		int blocknum = (int)Math.ceil(ql.getCurPage()/
					(double)ql.getBlockSize());
		int endBlock = blocknum*ql.getBlockSize();
		if(endBlock>ql.getPageCount()) {
			endBlock = ql.getPageCount();
		}
		ql.setEndBlock(endBlock);
		ql.setStartBlock((blocknum-1)*ql.getBlockSize()+1);
	}
	
	
	//qa표항목추가등록
	public void qaListIns(String qaItem) {
		dao.qaListIns(qaItem);
	}
	//qa표항목활성.비활성화
	public void qaListUpt(QAchecklist upt) {
		dao.qaListUpt(upt); 
	}
	
	//이달qa 전매장 조회
	public List<QA> qaStoresList(QA qa){
		return dao.qaStoresList(qa);
	}
	//이달qa 특정매장-매장정보 
	public QA qaDetailStrinfo(String frRegiNum){
		return dao.qaDetailStrinfo(frRegiNum);
	}
	//이달qa 특정매장-결과표  //json으로 넘기기
	public List<QA> qaDetailList(QA qa){
		return dao.qaDetailList(qa);
	}
	//이달qa 특정매장-결과점수
	public QA qaDetailScore(QA qa) {
		return dao.qaDetailScore(qa);
	}
	
	
	
	/*담당 매장 점검*/
	//담당매장 목록
	public List<QA> inchargeStore(String empNum){
		return dao.inchargeStore(empNum);
	}
	//담당매장 중 특정매장 점검목록
	public List<QA> inchargeStrQA(QA qa){
		return dao.inchargeStrQA(qa);
	}
	//특정매장 과거점검결과
	public List<QA> inchargeStrPastQA(QA qa){
		return dao.inchargeStrPastQA(qa);
	}
	
	//점검등록
	//	항목출력
	public List<QA> inspectQAclmn(QA qa){
		return dao.inspectQAclmn(qa);
	}
	// 	등록
	public void updateQA(QA qa) {
		
		//체크하면 y로 변경, comments변경 
		for(int idx=0;idx<qa.getNlist().size();idx++) {
			
			QA cqa= new QA();
			cqa.setQaNum(qa.getNlist().get(idx));
			cqa.setResults(qa.getYlist().get(idx));
			cqa.setComments(qa.getClist().get(idx));
			cqa.setFrRegiNum(qa.getFrRegiNum());
			
			dao.updateQA(cqa);
		}
	
		//등록일
		dao.updateQAregdte(qa);
	}
	
	
	
	// 	등록
	/*
	public void updateQAall(QA	qa) {
		
		
		//y
		dao.updateQAresultsY(qa);
		System.out.println("qa.getYlist()           "+ Arrays.toString(qa.getYlist()));
		System.out.println("qa.getFrRegiNum()      "+ qa.getFrRegiNum());
		
		//등록일
		dao.updateQAregdte(qa);
		
		//비고
		
		String[] comnList = qa.getComnlist();
		System.out.println("comnList    "+Arrays.toString(comnList) );
		QA  cqa= new QA();
		for (int idx=0; idx<comnList.length; idx++) {		
			dao.updateQAcomnt(cqa);
			System.out.println("cqa "+Arrays.toString(comnList) );
		}
		
		

	};
	*/
	
	/*
	//	y체크 변경
//	public void updateQAResultsY(List<String> qanumList, String results) {
	public void updateQAresultsY(QA	qa) {
		dao.updateQAresultsY(qa);
	};
	//	comments변경
	public void updateQAcomnt(QA qa) {
		dao.updateQAcomnt(qa);
	}
	//	등록일 등록
	public void updateQAregdte(QA qa) {
		dao.updateQAregdte(qa);
	}
	*/
	

	
	/*매장오픈점검*/
	//본사:전매장오픈시간조회
	public List<Store> storeOpenList(Store otl) {
		return dao.storeOpenList(otl);
	}
	//본사:매장오픈시간상세조회
	public OpenTimeCalender storeDetailOpenTime(String writer){
		return dao.storeDetailOpenTime(writer);
	}
	//본사:매장오픈시간상세조회-캘린더
	public List<OpenTimeCalender> openTimeDetailCalendar(OpenTimeCalender otcd){
		return dao.openTimeDetailCalendar(otcd);

	}
	
	

}
