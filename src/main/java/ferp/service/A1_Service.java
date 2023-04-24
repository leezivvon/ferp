package ferp.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ferp.dao.A1_Dao;
import ferp.dao.C1_Dao;
import vo.ACStatement;
import vo.ClerkSchedule;
import vo.Emp;
import vo.Menu;
import vo.Onsale;
import vo.Orders;
import vo.Store;
import vo.StoreClerk;


@Service
public class A1_Service {

	@Autowired(required = false)
	private A1_Dao dao;
	@Autowired(required = false)
	private C1_Dao daoC;
	
	public Store storeLogin(Store st) {
		if(st.getFrRegiNum()==null) st.setFrRegiNum("");
		if(st.getFrPass()==null) st.setFrPass("");
		return dao.storeLogin(st);
	}
	
	public Emp empLogin(Emp emp) {
		if(emp.getEmpnum()==null) emp.setEmpnum("");
		if(emp.getPass()==null) emp.setPass("");
		return dao.empLogin(emp);
	}
	
	public List<StoreClerk> getStoreClerk(String FrRegiNum){
		return dao.getStoreClerk(FrRegiNum);
	}
	
	//메뉴 불러오기
	public List<Menu> getMenuList(String FrRegiNum){
		return dao.getMenuList(FrRegiNum);
	}
	public List<Menu> getMenuListCoffee(String FrRegiNum){
		return dao.getMenuListCoffee(FrRegiNum);
	}
	public List<Menu> getMenuListSmoothie(String FrRegiNum){
		return dao.getMenuListSmoothie(FrRegiNum);
	}
	public List<Menu> getMenuListEtc(String FrRegiNum){
		return dao.getMenuListEtc(FrRegiNum);
	}
	public List<Menu> getMenuListCake(String FrRegiNum){
		return dao.getMenuListCake(FrRegiNum);
	}
	public List<Menu> getMenuListSandwich(String FrRegiNum){
		return dao.getMenuListSandwich(FrRegiNum);
	}
	
	// 출근 등록
	public void addOnDay(ClerkSchedule inscs) {
		dao.addOnDay(inscs);
	}
	
	// 퇴근 등록
	public String addOffTime(ClerkSchedule uptcs) {
		System.out.println("★★★★★★★★"+dao.checkOff(uptcs).equals("0"));
		if(dao.checkOff(uptcs).equals("0")) {
			return "출근 정보가 없습니다.";
		}
		if(dao.checkOff(uptcs).equals("1")) {
			dao.addOffTime(uptcs);
			return "퇴근 등록이 완료되었습니다.";
		}else {
			return "그외";
		}
	}
	
	// 판매할 메뉴 등록
	public String insOnsale(Onsale ins) {
		if(dao.checkOnsale(ins)==null) {
			dao.insOnsale(ins);
			return "완료";
		}else {
			return "중복";
		}
	}
	
	// 판매 메뉴 삭제
	public void delOnsale(Onsale del) {
		dao.delOnsale(del);
	}
	
	// 본사 제공 전체 메뉴
	public List<Menu> getAllMenu(Menu sch){
		if(sch.getMenuName()==null) sch.setMenuName("");
		if(sch.getPageSize()==0) {
			sch.setPageSize(10);
		}
		sch.setCount(dao.pageAllMenu(sch));
		if(sch.getCurPage()==0) {
			sch.setCurPage(1);
		}
		sch.setPageCount(
				(int)Math.ceil(
				sch.getCount()/(double)sch.getPageSize())
				);
		if(sch.getCurPage()>sch.getPageCount()) {
			sch.setCurPage(sch.getPageCount());
		}
		sch.setStart((sch.getCurPage()-1)*sch.getPageSize()+1);
		sch.setEnd(sch.getCurPage()*sch.getPageSize());
		sch.setBlockSize(5);
		int blocknum = (int)Math.ceil(sch.getCurPage()/
					(double)sch.getBlockSize());
		int endBlock = blocknum*sch.getBlockSize();
		if(endBlock>sch.getPageCount()) {
			endBlock = sch.getPageCount();
		}
		sch.setEndBlock(endBlock);
		sch.setStartBlock((blocknum-1)*sch.getBlockSize()+1);
		return dao.getAllMenu(sch);
	}
	
	// 예상 시간 대기
		public int getWaitTime(String frRegiNum) {
			return dao.getWaitTime(frRegiNum);
		}
	
	
	// orders ins
    public void insertOrdersList(
    		String[] menuNum,
			String[] frRegiNum,
			int[] amount,
			int[] payprice,
			String[] orderOption
    		) {
    	System.out.println(menuNum[0]);
    	int totCnt = dao.totCnt();
    	for(int i=0;i<menuNum.length;i++) {
    		System.out.println(menuNum[i]);
    		Orders ins = new Orders();
    		ins.setTotCnt(totCnt);
        	ins.setAmount(amount[i]); ins.setFrRegiNum(frRegiNum[i]);
    		ins.setMenuNum(menuNum[i]); ins.setPayprice(payprice[i]);
    		ins.setOrderOption(orderOption[i]);
            dao.insertOrdersList(ins);
    	}
    	
 
    	
    }
	
    // maxOrderNum
    public String getMaxOrderNum(String frRegiNum) {
    	return dao.getMaxOrderNum(frRegiNum);
    }
    
    public List<Orders> getPayPrice(Orders order){
    	return dao.getPayPrice(order);
    }
    
 // 결제대기에서 제조대기로
 	public void uptOrderStatePay(String orderNum, int price, int tax, String frRegiNum, String opp) {


 		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String dateString=dateFormat.format(date);
		
 		ACStatement ast = new ACStatement();
		
		//미수수익(자산) 총 금액
		ast.setAcntNum("11600"); // 계정코드
		ast.setCredit(0); 
		ast.setDebit(price); // 총 금액
		ast.setFrRegiNum(frRegiNum); // 사업자
		ast.setLineNum(0); 
		ast.setRemark(orderNum); // 리마크
		ast.setStatementNum("SC"); // auto Store-Customer
		ast.setStmtDate(dateString); // 날짜
		ast.setStmtOpposite(opp); // 거래처 (카카오/빌게이트 등)
		daoC.r7210insertStatement(ast);
		
		//매출(자산)
		ast.setAcntNum("40400"); // 제품 매출
		ast.setCredit(price-tax); // 총 금액의 0.9%
		ast.setDebit(0); 
		ast.setFrRegiNum(frRegiNum); // 사업자
		ast.setLineNum(1); 
		ast.setRemark(orderNum); // 리마크
		ast.setStmtDate(dateString); // 날짜
		ast.setStmtOpposite(opp); // 거래처 (카카오/빌게이트 등)
		daoC.r7210insertStatement(ast);
		
		//부가세
		ast.setAcntNum("25500");
		ast.setCredit(tax);
		ast.setDebit(0); 
		ast.setFrRegiNum(frRegiNum); // 사업자
		ast.setLineNum(2); 
		ast.setRemark(orderNum); // 리마크
		ast.setStmtDate(dateString); // 날짜
		ast.setStmtOpposite("부가세"); // 공백이라도 넣을 것
		daoC.r7210insertStatement(ast);
		
 		dao.uptOrderStatePay(orderNum);
		
 	}
 	
 	// 제조 대기 리스트
 	public List<Orders> getStandByList(Orders orders){
 		return dao.getStandByList(orders);
 	}
 	
	// 결제 취소
	public void delOrder(String orderNum) {
		dao.delOrder(orderNum);
		dao.delPay(orderNum);
	}
	// 제조 완료
	public void clearOrder(String orderNum) {
		dao.clearOrder(orderNum);
		
	}
	
	// 고객 호출
	public List<Orders> loadOrderList(String frRegiNum) {
		return dao.loadOrderList(frRegiNum);
	}
	public List<Orders> comOrderList(String frRegiNum) {
		return dao.comOrderList(frRegiNum);
	}

    
}
