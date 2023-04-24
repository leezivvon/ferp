package vo;

public class Orders {
	// 금일 전체 주문 개수
	private int totCnt;
	//orders테이블의 기본컬럼
	private String orderNum;
	private String orderDate;
	private String menuNum;
	private String frRegiNum;
	private String state;
	private int amount;
	private int payprice;
	private String orderOption;
	
	//본사:저번달 전체매장의 총 매출조회
	private int allfrsales; 
	
	//본사:매장의 개별매출 전체조회
	private String frname;
	private String frtel;
	private String frRepname;
	private String ename;
	private int frsales;
	private int frpurchase;
	private String frSchOrderdt;
	private String toSchOrderdt;
	
	//본사:특정매장의 매출조회
	private String frOpen;
	private String frAddress;
	private int profit;
	private int price;
	private int mcnt;
	private int msales;
	private String menuName;
	
	public Orders() {
		// TODO Auto-generated constructor stub
	}

	//본사:매장의 개별매출 전체조회
	public Orders(String frSchOrderdt, String toSchOrderdt) {
		this.frSchOrderdt = frSchOrderdt;
		this.toSchOrderdt = toSchOrderdt;
	}

	public String getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}
	public String getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}
	public String getMenuNum() {
		return menuNum;
	}
	public void setMenuNum(String menuNum) {
		this.menuNum = menuNum;
	}

	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public int getPayprice() {
		return payprice;
	}
	public void setPayprice(int payprice) {
		this.payprice = payprice;
	}
	public int getAllfrsales() {
		return allfrsales;
	}
	public void setAllfrsales(int allfrsales) {
		this.allfrsales = allfrsales;
	}
	public String getFrname() {
		return frname;
	}
	public void setFrname(String frname) {
		this.frname = frname;
	}
	public String getFrtel() {
		return frtel;
	}
	public void setFrtel(String frtel) {
		this.frtel = frtel;
	}
	public String getFrRepname() {
		return frRepname;
	}
	public void setFrRepname(String frRepname) {
		this.frRepname = frRepname;
	}
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}
	public int getFrsales() {
		return frsales;
	}
	public void setFrsales(int frsales) {
		this.frsales = frsales;
	}

	public String getFrSchOrderdt() {
		return frSchOrderdt;
	}

	public void setFrSchOrderdt(String frSchOrderdt) {
		this.frSchOrderdt = frSchOrderdt;
	}

	public String getToSchOrderdt() {
		return toSchOrderdt;
	}

	public void setToSchOrderdt(String toSchOrderdt) {
		this.toSchOrderdt = toSchOrderdt;
	}

	public int getFrpurchase() {
		return frpurchase;
	}
	public void setFrpurchase(int frpurchase) {
		this.frpurchase = frpurchase;
	}
	public String getFrOpen() {
		return frOpen;
	}
	public void setFrOpen(String frOpen) {
		this.frOpen = frOpen;
	}
	public String getFrAddress() {
		return frAddress;
	}
	public void setFrAddress(String frAddress) {
		this.frAddress = frAddress;
	}
	public int getProfit() {
		return profit;
	}
	public void setProfit(int profit) {
		this.profit = profit;
	}
	public int getMcnt() {
		return mcnt;
	}
	public void setMcnt(int mcnt) {
		this.mcnt = mcnt;
	}
	public int getMsales() {
		return msales;
	}
	public void setMsales(int msales) {
		this.msales = msales;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getOrderOption() {
		return orderOption;
	}

	public void setOrderOption(String orderOption) {
		this.orderOption = orderOption;
	}

	public String getFrRegiNum() {
		return frRegiNum;
	}

	public void setFrRegiNum(String frRegiNum) {
		this.frRegiNum = frRegiNum;
	}

	public Orders(String menuNum, String frRegiNum, int amount, int payprice, String orderOption) {
		super();
		this.menuNum = menuNum;
		this.frRegiNum = frRegiNum;
		this.amount = amount;
		this.payprice = payprice;
		this.orderOption = orderOption;
		
	}

	public int getTotCnt() {
		return totCnt;
	}

	public void setTotCnt(int totCnt) {
		this.totCnt = totCnt;
	} 

	
	
	
}
