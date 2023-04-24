package ferp.controller;


import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ferp.service.B1_Service;
import vo.Emp;
import vo.OpenTimeCalender;
import vo.Orders;
import vo.QA;
import vo.QAchecklist;
import vo.Store;


@Controller
public class B1_Controller {

	@Autowired(required=false)
	private B1_Service service;
	
	// http://localhost:6080/ferp/salesInfo.do
	// http://localhost:6080/ferp/strOpenInfo.do
	
	/*매장정보조회*/
	// 본사:정보조회페이지 가는 컨트롤러 
	@CrossOrigin(origins = "*",allowedHeaders = "*")
	@RequestMapping("salesInfo.do")
	public String r7503salesInfo(@ModelAttribute("sch") Orders ord, Model d){
		d.addAttribute("sbslist", service.salesByStoreList(ord));
		return "WEB-INF\\headquarter\\pg7501_salesInfo.jsp";
	}
	// 본사:지난달전체매장매출총액
	@ModelAttribute("addAllsales")
	public int r7501salesInfo() {
		return service.lastmonthAllSales();
	}
	// 본사:전매장매출 전체조회
	@RequestMapping("salesInfoJson.do")
	public String r7503SalesInfoJson(Orders ord, Model d){
		d.addAttribute("sbslist", service.salesByStoreList(ord));
		return "pageJsonReport";
	}
	
	// 본사:특정매장정보조회&페이지이동
	@RequestMapping("salesDetail.do")
	public String r7505storeDetail(@RequestParam("frRegiNum") String frRegiNum, Model d ){
		d.addAttribute("dinfo", service.storeDetailInfo(frRegiNum));
		return "WEB-INF\\headquarter\\pg7505_salesDetailInfo.jsp";
	}
	// 본사:특정매장정보JSON
	@RequestMapping("detailInfoJson.do")
	public String r7505detailSalesJson(Orders ord, Model d) {
		d.addAttribute("dInfoList",service.multipleJson(ord) );
		return "pageJsonReport";
	}
	
	
	

	// http://localhost:6080/ferp/qaList.do
	// http://localhost:6080/ferp/qaStore.do
	/*매장QA점검*/
	//본사:qa표항목전체출력
	@RequestMapping("qaList.do")
	public String r6105qaMangement(@ModelAttribute("ql") QAchecklist ql, Model d){
		d.addAttribute("qalist", service.qaList(ql));
		return "WEB-INF\\headquarter\\pg6105_QAchecklist.jsp";
	} 
	@RequestMapping("qaListJson.do")
	public String r6105qaMangementJson(QAchecklist ql, Model d){
		d.addAttribute("qalist", service.qaList(ql));
		return "pageJsonReport";
	}
	
	//qa표 항목추가	
	@PostMapping("qaAdd.do")
	public String r6105qaAdd(@RequestParam("qaItem") String qaItem, RedirectAttributes redirect) {
		service.qaListIns(qaItem);
		return "redirect:/qaList.do";
	}
	//qa표 항목활성화/비활성화
	@PostMapping("qaUseable.do")
	public String r6105qaUseable(QAchecklist upt, RedirectAttributes redirect) {
		service.qaListUpt(upt);
		return "redirect:/qaList.do";
	}
	
	
	//이달qa 전매장 조회
	@RequestMapping("qaStore.do")
	public String r6104qaStore(@ModelAttribute("sch") QA qa, Model d){
		d.addAttribute("qaStrlist", service.qaStoresList(qa));
		return 	"WEB-INF\\headquarter\\pg6104_QAstore.jsp";
	}
	@RequestMapping("qaStoreJson.do")
	public String r6104qaStoreJson(QA qa, Model d){
		d.addAttribute("qaStrlist", service.qaStoresList(qa));
		return 	"pageJsonReport";
	}
	
	//이달qa 특정매장 
	//매장정보 //점수
	@RequestMapping("qaDetailInfo.do")
	public String r6104qaStoreDetail(@RequestParam("frRegiNum") String frRegiNum, 
									 @RequestParam("inspectDte") String inspectDte, Model d){
		//매장정보출력
		d.addAttribute("qdinfo", service.qaDetailStrinfo(frRegiNum));		
		
		//점수출력
		QA qa = new QA();
		qa.setFrRegiNum(frRegiNum);
		qa.setInspectDte(inspectDte);

		double qncnt = service.qaDetailScore(qa).getQncnt();
		double ycnt = service.qaDetailScore(qa).getYcnt();
		double score =  ycnt/qncnt*10.0;
		String resultScore="";
		
		if(score>=9.0) {
			resultScore ="이상없음";
		}else if(score>=8.0) {
			resultScore ="주의";
		}else {
			resultScore="심각";
		}
		
	    d.addAttribute("resultScore", resultScore);
		
		return 	"WEB-INF\\headquarter\\pg6104_QAstoreDetail.jsp";
	} 
	//결과표 
	@RequestMapping("qaDetailList.do")
	public String r6104qaStoreDetailJson(QA qa, Model d) {
		d.addAttribute("qaResultList",service.qaDetailList(qa) );
		return "pageJsonReport";
	}
	/*
	//// json일때 단일 파라미터값넘기느 법!!!뭐야!!
	@RequestMapping("qaDetailList.do")
	public String r6104qaStoreDetailJson(@RequestBody String frRegiNum, Model d) {
		d.addAttribute("qaResultList",service.qaDetailList(frRegiNum) );
		return "pageJsonReport";
	}
	*/
	//결과점수
	//@PathVariable 사용법만 잘 알았어도...
	
	
	
	
	/*담당 매장 점검*/
	//담당매장 목록 
	@RequestMapping("inchargeStore.do")
	public String r6101inchargeStore(Model d, HttpSession session) {
		
		//세션값받기
		Emp s = (Emp)session.getAttribute("login");
		
		d.addAttribute("ename", s.getEname() );
		d.addAttribute("icStrlist", service.inchargeStore( s.getEmpnum() ) );
	
		//List<QA> qa= service.inchargeStore( s.getEmpnum() );
		//qa.get(0).getFrRegiNum();

		return "WEB-INF\\headquarter\\pg6101_QAinCharge.jsp";
	}
	
	// 담당매장 중 특정매장 점검정보
	@RequestMapping("inchargeStrQA.do")
	public String r6101inchargeStrQA(QA qa, Model d) {
		/*
		Emp s = (Emp)session.getAttribute("login");
		qa.setEmpnum(s.getEmpnum());
		*/
		d.addAttribute("sQAinfo",service.inchargeStrQA(qa));
		return "pageJsonReport";
	}
	// 특정매장 과거점검결과
	@RequestMapping("inchargeStrPastQA.do")
	public String r6101inchargeStrPastQA(QA qa, Model d) {
		d.addAttribute("sPasteQA",service.inchargeStrPastQA(qa));
		return "pageJsonReport";
	}
	
	//점검등록-페이지출력
	@RequestMapping("inspectQAPrint.do")
	public String r6102inspectQAPrint(){
		return "WEB-INF\\headquarter\\pg6102_QAInspect.jsp";
	} 
	//점검등록-항목출력
	@RequestMapping("inspectQAclmn.do")
	public String r6102inspectQAclmnPrint(QA qa, Model d) {
		d.addAttribute("ispQAList",service.inspectQAclmn(qa));
		return "pageJsonReport";
	}
	//점검등록-y랑contents변경
	@PostMapping("updateQAall.do")
	public String r6102updateQAall( @RequestParam("nlist[]") List<String> nlist,
									@RequestParam("ylist[]") List<String> ylist,
									@RequestParam("clist[]") List<String> clist,
								    @RequestParam("frRegiNum") String frRegiNum) {
		QA qa= new QA ();
		qa.setFrRegiNum(frRegiNum);
		qa.setNlist(nlist);
		qa.setYlist(ylist);
		qa.setClist(clist);

		service.updateQA(qa);
		
		return "WEB-INF\\headquarter\\pg6102_QAInspect.jsp";
	}
	//점검일배정
	
	
	/*
	
	@PostMapping("updateQAall.do")
	public String r6102updateQAall(@RequestParam("ylist") String[] ylist,
								   @RequestParam("comnlist") String[] comnlist,
								   @RequestParam("frRegiNum") String frRegiNum) {
		
		QA qa= new QA ();
		qa.setFrRegiNum(frRegiNum);
		qa.setYlist(ylist);
		service.updateQAall(qa);
			
		return "redirect:/inspectQAPrint.do";
	}
	
	
	//특정매장 점검등록-y로체크하는 항목들
	@PostMapping("uptResultsY.do")
	public String r6102updateQAresultsY(@RequestParam("ylist") String[] ylist,
										@RequestParam("frRegiNum") String frRegiNum) {
		QA qa= new QA ();
		qa.setFrRegiNum(frRegiNum);
		qa.setYlist(ylist);
		service.updateQAresultsY(qa);
        return "redirect:/inspectQAPrint";
	}
	@PostMapping("uptComment.do")
	public String r6102updateQAcomnt(QA qa) {
		service.updateQAcomnt(qa);
		return "redirect:/inspectQAPrint";
	}
	@PostMapping("uptRegdte.do")
	public String updateQAregdte(QA qa) {
		service.updateQAregdte(qa);
		return "redirect:/inspectQAPrint";
	}
	
	*/
	
	
	/*매장오픈점검*/
	// 본사:전매장오픈시간조회페이지/검색
	@RequestMapping("strOpenInfo.do")
	public String r6202storeOpenInfo(@ModelAttribute("sch") Store otl,  Model d){
		d.addAttribute("optimelist", service.storeOpenList(otl));
		return "WEB-INF\\headquarter\\pg6202_storeOpenInf.jsp";
	} 
	// 본사:전매장오픈시간조회JSON
	@RequestMapping("strOpenInfoJson.do")
	public String r6202storeOpenInfoJson(Store otl, Model d){
		d.addAttribute("optimelist", service.storeOpenList(otl));
		return "pageJsonReport";
	}
	
	// 본사:특정매장오픈시간상세조회페이지&캘린더불러오기
	@RequestMapping("openTimeCalendar.do")
	public String r6202openTimeCalendar(@RequestParam("writer") String writer, Model d ) {
		d.addAttribute("otdetail", service.storeDetailOpenTime(writer));
		return "WEB-INF\\headquarter\\pg6202_storeOpenDetail.jsp";
	}
	// 본사:특정매장캘린더JSON
	@RequestMapping("openTimeCalendarJson.do")
	public String r6202openTimeCalendarJson(OpenTimeCalender otcd, Model d){
		d.addAttribute("calendarlist", service.openTimeDetailCalendar(otcd));
		return "pageJsonReport";
	}	
	
	

}