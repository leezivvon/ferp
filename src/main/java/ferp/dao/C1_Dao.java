package ferp.dao;

import java.util.List;

import vo.ACStatement;
import vo.Account;
import vo.DefectOrder;
import vo.Defect_store_product_order;
import vo.Emp;
import vo.ProdOrder;
import vo.Prod_order_stock_emp_store;
import vo.Product;
import vo.Store;

public interface C1_Dao {
	
	public List<Account> r7100SelectAccount(Account ac);
	public int r7101insertAccount(Account ac);
	public int r7102updateAccountUsing(Account ac);
	
	public int r7210insertStatement(ACStatement stmt);
	public List<ACStatement> r7211selectACStatement(ACStatement stmt);
	public List<ACStatement> r7211selectPrevNext(ACStatement stmt);
	public int r7212updateACStatement(ACStatement acstmt);
	public int r7213deleteACStatement(ACStatement acstmt);

	
	//거래내역,계정별 목록 조회
	//건별(모든내용)
	public List<ACStatement> r7204selectStatementList(ACStatement stmt);
	public List<ACStatement> r7204selectStatementListByDate(ACStatement stmt);
	
	public List<ProdOrder>r9203forTotalStock(ProdOrder prodOrder);
	public List<Prod_order_stock_emp_store>r9201select(ProdOrder prodOrder);
	public List<Prod_order_stock_emp_store>r9201select999(ProdOrder prodOrder);
	public int r9203updateOrderState(ProdOrder prodOrder);
	
	//결제내역 조회
	public List<Prod_order_stock_emp_store>r9310selectProdOrderPayState(ProdOrder prodOrder);
	public int r9311updateProdOrderPayState(ProdOrder prodOrder);
	
	//결제내역-매월 정산서
	public List<Prod_order_stock_emp_store> r9301prodOrderPayDetail(ProdOrder prodOrder);
	
	//defected order
	public List<Defect_store_product_order> r9402selectDefectOrder(DefectOrder defectOrder);
	public int r9403updateDefectOrder(DefectOrder defectOrder);
	public int r9403updateProdOrder(ProdOrder prodOrder);
	
	
	//모든 store 리스트
	public List<Store> selectActiveStore();
	public List<Emp> selectActiveEmp();
	public List<Product> selectProduct();
	
	//가맹점 비밀번호
	public Store r1003tempPassword(Store store);
	public int r1003updatePassword(Store store);
	
	public int r7204getTotalPagesByDate(ACStatement stmt);
	public int r7204getTotalPages(ACStatement stmt);
}
