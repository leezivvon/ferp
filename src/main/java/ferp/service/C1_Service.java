package ferp.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ferp.dao.C1_Dao;
import ferp.dao.C2_Dao;
import vo.ACStatement;
import vo.Account;
import vo.DefectOrder;
import vo.Defect_store_product_order;
import vo.ProdOrder;
import vo.Prod_order_stock_emp_store;
import vo.Stock;
import vo.Store;

@Service
public class C1_Service {

	@Autowired
	C1_Dao dao;
	
	@Autowired
	C2_Dao daoC2;

	public List<Account> r7100SelectAccount(Account ac) {
		if(ac.getAcntNum()==null) {ac.setAcntNum("");}
		if(ac.getAcntTitle()==null) {ac.setAcntTitle("");}
		return dao.r7100SelectAccount(ac);
	}

	public int r7101insertAccount(Account ac) {
		return dao.r7101insertAccount(ac);
	}

	public int r7210insertStatement(String statementNum,String stmtDate,String frRegiNum,List<ACStatement> stmtlist) {
		int stmtcount=0;
		for (ACStatement stmt : stmtlist) {
			stmt.setStatementNum(statementNum);
			stmt.setStmtDate(stmtDate);
			stmt.setFrRegiNum(frRegiNum);
			stmtcount=+ dao.r7210insertStatement(stmt);
		}
		return stmtcount;
	}
	
	public int r7102updateAccountUsing(Account ac) {
		return dao.r7102updateAccountUsing(ac);
	}
	
	
	public List<ACStatement> r7211selectACStatement(ACStatement stmt) {
		if(stmt.getRronum()==null||stmt.getRronum().equals("")) {
			return dao.r7211selectACStatement(stmt);
		}else {
			return dao.r7211selectPrevNext(stmt);
		}
	}
	
	public int r7212updateACStatement(String statementNum,String stmtDate,String frRegiNum,List<ACStatement> stmtlist) {
		int stmtcount=0;
		for (ACStatement stmt : stmtlist) {
			stmt.setStatementNum(statementNum);
			stmt.setStmtDate(stmtDate);
			stmt.setFrRegiNum(frRegiNum);
			stmtcount=+ dao.r7212updateACStatement(stmt);
		}
		return stmtcount;
	}
	
	public List<ACStatement> r7204selectStatementList(ACStatement stmt,int howtosearch) {
		if(stmt.getStmtDate()==null||stmt.getStmtDate().equals("") ) {
			LocalDate now = LocalDate.now();
			stmt.setStmtDate(now+"");
		}
		if(stmt.getStmtDate2()==null||stmt.getStmtDate2().equals("")) {
			stmt.setStmtDate2(stmt.getStmtDate());
		}
		if(howtosearch==1) {
			return dao.r7204selectStatementList(stmt);
		}else {
			return dao.r7204selectStatementListByDate(stmt);
		}
	}
	
	public int r7204getTotalPages(ACStatement stmt,int howtosearch) {
		if(howtosearch==1) {
			return dao.r7204getTotalPages(stmt);
		}
		return dao.r7204getTotalPagesByDate(stmt);
	}
	
	public int r7213deleteACStatement(ACStatement acstmt) {
		return dao.r7213deleteACStatement(acstmt);
	}

	public List<Prod_order_stock_emp_store>r9201select(ProdOrder prodOrder){
		return dao.r9201select(prodOrder);
	}
	
	public List<Prod_order_stock_emp_store>r9201select999(ProdOrder prodOrder){
		return dao.r9201select999(prodOrder);
	}
	
	public int r9203updateOrderState(ProdOrder prodOrder) {
		if(prodOrder.getDemander().equals("9999999999")) {	//본사일땐 완료만 추가, for문 돌리는 dao가 다름
			for(Prod_order_stock_emp_store poses : dao.r9201select999(prodOrder)) {
				System.out.println("본사 물류 select까지 함");
				if(prodOrder.getOrderStateUpdate().equals("완료")){
					Stock stock = new Stock();
					System.out.println("완료일때 서비스");
					//재고stock에 insert 가맹점에 들어가게
					stock.setApplyAmount(poses.getProdOrder().getAmount());
					stock.setFrRegiNum("9999999999");	//받은사람 재고에 추가하는거
					stock.setProductNum(poses.getProdOrder().getProductNum());
					stock.setRemark(poses.getProdOrder().getOrderNum());
					daoC2.r8103InoutIns(stock);
				}
			}
		}else{
			//본사에서 시킨거 아님
				Stock stock = new Stock();
				if(prodOrder.getOrderStateUpdate().equals("배송중")) {
					prodOrder.setOrderState("요청");
					for(ProdOrder poses : dao.r9203forTotalStock(prodOrder)) {
						//재고stock에 insert 본사에서 빠진거 (본사주문일때 빼고)
						stock.setApplyAmount(poses.getAmount()*(-1));
						stock.setFrRegiNum("9999999999"); //가맹점이 시키면 공급자는 항상 본사니까 본사재고에서 조정하는거
						stock.setProductNum(poses.getProductNum());
						stock.setRemark(poses.getOrderNum());
						daoC2.r8103InoutIns(stock);
						}
				}else if(prodOrder.getOrderStateUpdate().equals("완료")){
					prodOrder.setOrderState("배송중");
					for(Prod_order_stock_emp_store poses : dao.r9201select(prodOrder)) {
						//재고stock에 insert 가맹점에 들어가게
						stock.setApplyAmount(poses.getProdOrder().getAmount());
						stock.setFrRegiNum(poses.getProdOrder().getDemander());	//받은사람 재고에 추가하는거
						stock.setProductNum(poses.getProdOrder().getProductNum());
						stock.setRemark(poses.getProdOrder().getOrderNum());
						daoC2.r8103InoutIns(stock);
					}
				}
			
		}
		return dao.r9203updateOrderState(prodOrder);
	}
	
	public List<Prod_order_stock_emp_store>r9310selectProdOrderPayState(ProdOrder prodOrder){
		if(prodOrder.getOrderDate()==null||prodOrder.getOrderDate().equals("")) {
			prodOrder.setOrderDate(prodOrder.getOrderDateMonth());
		}
		return dao.r9310selectProdOrderPayState(prodOrder);
	}
	
	public int r9311updateProdOrderPayState(ProdOrder prodOrder,int price,int tax) {
		int a =dao.r9311updateProdOrderPayState(prodOrder);
		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String dateString=dateFormat.format(date);
		ACStatement ast= new ACStatement();
		if(prodOrder.getPaymentState().equals("계산서 발행")&&price!=0) {
			//일괄 아니고 계산서 발행일때
			//계산서 발행 : 본사 미수수익(자산)
			ast.setAcntNum("11600");
			ast.setCredit(0);
			ast.setDebit(price+tax);
			ast.setFrRegiNum("9999999999");
			ast.setLineNum(0);
			ast.setRemark(prodOrder.getOrderDateMonth()+" "+prodOrder.getDemander());
			ast.setStatementNum("AT");
			ast.setStmtDate(dateString);
			ast.setStmtOpposite(prodOrder.getDemander());
			dao.r7210insertStatement(ast);
			//본사 부가세
			ast.setAcntNum("25500");
			ast.setCredit(tax);
			ast.setDebit(0);
			ast.setLineNum(1);
			dao.r7210insertStatement(ast);
			//본사 상품매출(수익)
			ast.setAcntNum("40100");
			ast.setCredit(price);
			ast.setDebit(0);
			ast.setLineNum(2);
			dao.r7210insertStatement(ast);
			//매장에 제품매출원가(비용)
			ast.setAcntNum("45500");
			ast.setCredit(0);
			ast.setDebit(price);
			ast.setFrRegiNum(prodOrder.getDemander());
			ast.setLineNum(0);
			ast.setStmtOpposite("본사");
			dao.r7210insertStatement(ast);
			//부가세대급금 (자산)
			ast.setAcntNum("13500");
			ast.setDebit(tax);
			ast.setLineNum(1);
			dao.r7210insertStatement(ast);
			//부채 외상매입금
			ast.setAcntNum("25100");
			ast.setCredit(price+tax);
			ast.setDebit(0);
			ast.setLineNum(2);
			dao.r7210insertStatement(ast);
		}
		if(prodOrder.getPaymentState().equals("완료")&&price!=0) {
			//일괄 아니고 입금했을때
			//입금했을때 본사에서 미수수익 사라짐
			ast.setAcntNum("11600");
			ast.setDebit(0);
			ast.setCredit(price+tax);
			ast.setFrRegiNum("9999999999");
			ast.setLineNum(0);
			ast.setRemark(prodOrder.getOrderDateMonth()+" "+prodOrder.getDemander());
			ast.setStatementNum("AT");
			ast.setStmtDate(dateString);
			ast.setStmtOpposite(prodOrder.getDemander());
			dao.r7210insertStatement(ast);
			//본사 입금
			ast.setAcntNum("10300");
			ast.setDebit(price+tax);
			ast.setCredit(0);
			ast.setLineNum(1);
			dao.r7210insertStatement(ast);
			//매장에서 부채 사라지고 현금 빠짐
			ast.setAcntNum("25100");
			ast.setFrRegiNum(prodOrder.getDemander());
			ast.setLineNum(0);
			ast.setStmtOpposite("본사");
			dao.r7210insertStatement(ast);
			//자산 빠짐
			ast.setAcntNum("10300");
			ast.setCredit(price+tax);
			ast.setDebit(0);
			ast.setLineNum(1);
			dao.r7210insertStatement(ast);
		}
		//일괄 계산서 발행할때
		if(prodOrder.getPaymentState().equals("계산서 발행")&&price==0) {
		//검색해서 목록 불러오기
			List<Prod_order_stock_emp_store> alist=r9310selectProdOrderPayState(prodOrder);
			//목록 반복문 돌려서 전표 만들어넣기
			for(Prod_order_stock_emp_store pp:alist) {
				int price1=pp.getProduct().getPrice();
				int tax1=Integer.parseInt(pp.getProduct().getRemark());
				//계산서 발행 : 본사 미수수익(자산)
				ast.setAcntNum("11600");
				ast.setCredit(0);
				ast.setDebit(price1+tax1);
				ast.setFrRegiNum("9999999999");
				ast.setLineNum(0);
				ast.setRemark(pp.getProdOrder().getOrderDateMonth()+" "+pp.getStore().getFrRegiNum());
				ast.setStatementNum("AT");
				ast.setStmtDate(dateString);
				ast.setStmtOpposite(pp.getStore().getFrRegiNum()+pp.getStore().getFrName());
				dao.r7210insertStatement(ast);
				//본사 부가세
				ast.setAcntNum("25500");
				ast.setDebit(0);
				ast.setCredit(tax1);
				ast.setLineNum(1);
				dao.r7210insertStatement(ast);
				//본사 상품매출(수익)
				ast.setAcntNum("40100");
				ast.setCredit(price1);
				ast.setDebit(0);
				ast.setLineNum(2);
				dao.r7210insertStatement(ast);
				//매장에 제품매출원가(비용)
				ast.setAcntNum("45500");
				ast.setCredit(0);
				ast.setDebit(price1);
				System.out.println("매장 사업자번호 "+pp.getStore().getFrRegiNum());
				ast.setFrRegiNum(pp.getStore().getFrRegiNum());
				ast.setLineNum(0);
				ast.setStmtOpposite("본사");
				dao.r7210insertStatement(ast);
				//부가세대급금 (자산)
				ast.setAcntNum("13500");
				ast.setDebit(tax1);
				ast.setLineNum(1);
				dao.r7210insertStatement(ast);
				//부채 외상매입금
				ast.setAcntNum("25100");
				ast.setCredit(price1+tax1);
				ast.setDebit(0);
				ast.setLineNum(2);
				dao.r7210insertStatement(ast);
			}
		}
		return a;
	}
	
	
	public List<Prod_order_stock_emp_store> r9301prodOrderPayDetail(ProdOrder prodOrder){
		return dao.r9301prodOrderPayDetail(prodOrder);
	}
	
	public List<Defect_store_product_order> r9402selectDefectOrder(DefectOrder dfo){
		if(dfo.getOrderDateMonth()==null||dfo.getOrderDateMonth().equals("")) {
			dfo.setOrderDateMonth(dfo.getApplyDate());
		}
		return dao.r9402selectDefectOrder(dfo);
	}
	
	public int r9403updateDefectOrder(DefectOrder dfo,Stock stock,ProdOrder po) {
		int change=dao.r9403updateDefectOrder(dfo);
		if(po.getOrderNum()!=null) {
			//prodOrder 변경
			change+=dao.r9403updateProdOrder(po);
		}
		if(stock.getApplyAmount()!=0) {
			//stock 변경사항
			daoC2.r8103InoutIns(stock);
		}
		
		return change;
	}
	
	
	public List<Store> selectActiveStore(){
		return dao.selectActiveStore();
	}
	public Map<String, List<?>> selectActiveDatalist(){
		 Map<String, List<?>> listsMap = new HashMap<>();
		 listsMap.put("storelist",dao.selectActiveStore());
		 listsMap.put("emplist",dao.selectActiveEmp());
		 listsMap.put("productlist",dao.selectProduct());
		 return listsMap;
				
	}
	
	
}
