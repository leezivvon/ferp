package ferp.dao;

import java.util.List;

import vo.ClerkSchedule;
import vo.Emp;
import vo.Menu;
import vo.Onsale;
import vo.Orders;
import vo.Store;
import vo.StoreClerk;

public interface A1_Dao {
	
	public Store storeLogin(Store st);
	public Emp empLogin(Emp emp);
	
	public List<StoreClerk> getStoreClerk(String FrRegiNum);
	
	
	// 출근 등록
	public void addOnDay(ClerkSchedule inscs);
	
	// 퇴근 유효성
	public String checkOff(ClerkSchedule uptcs);
	// 퇴근 등록
	public void addOffTime(ClerkSchedule uptcs);
	
	
	// 각 가맹점 메뉴 리스트
	public List<Menu> getMenuList(String FrRegiNum);
	public List<Menu> getMenuListCoffee(String FrRegiNum);
	public List<Menu> getMenuListEtc(String FrRegiNum);
	public List<Menu> getMenuListSmoothie(String FrRegiNum);
	public List<Menu> getMenuListSandwich(String FrRegiNum);
	public List<Menu> getMenuListCake(String FrRegiNum);
	
	// 판매할 메뉴 등록
	public List<Onsale> checkOnsale(Onsale ins); // 중복 체크
	public void insOnsale(Onsale ins);
	// 판매할 메뉴 제거
	public void delOnsale(Onsale del);
	
	// 본사 제공 전체 메뉴
	public List<Menu> getAllMenu(Menu sch);
	
	public int totCnt();
	
	// orders 추가 dao
	public void insertOrdersList(Orders ins);
	// orderNum 가져오기
	public String getMaxOrderNum(String frRegiNum);
	public List<Orders> getPayPrice(Orders order);
	// 결제대기에서 제조대기로
	public void uptOrderStatePay(String orderNum);
	
	// 예상 시간 대기
	public int getWaitTime(String frRegiNum);
	
	// 본사 제공 페이지 수
	public int pageAllMenu(Menu sch);
	
	// 제조 대기 리스트
	public List<Orders> getStandByList(Orders orders);
	
	// 결제 취소
	public void delOrder(String orderNum);
	public void delPay(String orderNum);
	// 제조 완료
	public void clearOrder(String orderNum);
	
	// 고객 호출
	public List<Orders> loadOrderList(String frRegiNum);
	public List<Orders> comOrderList(String frRegiNum);
	
	
}
