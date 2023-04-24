package vo;

public class ProdOrder {
	private String orderNum;
	private String productNum;
	private String demander;	//본사가 사올때는 본사코드, 팔때는 가맹점번호
	private String supplier;	//본사가 팔때는 본사코드, 본사가 밖에서 사올때는 다른곳 사업자번호나 그런거,검색할때 담당자이름이나 사원번호
	private String orderDate;
	private int amount;
	private String paymentState;
	private String orderState;
	private String orderStateUpdate;
	private String orderDateMonth;
	public String getOrderStateUpdate() {
		return orderStateUpdate;
	}
	public void setOrderStateUpdate(String orderStateUpdate) {
		this.orderStateUpdate = orderStateUpdate;
	}
	public String getOrderDateMonth() {
		return orderDateMonth;
	}
	public void setOrderDateMonth(String orderDateMonth) {
		this.orderDateMonth = orderDateMonth;
	}
	public ProdOrder() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}
	public String getProductNum() {
		return productNum;
	}
	public void setProductNum(String productNum) {
		this.productNum = productNum;
	}
	public String getDemander() {
		return demander;
	}
	public void setDemander(String demander) {
		this.demander = demander;
	}
	public String getSupplier() {
		return supplier;
	}
	public void setSupplier(String supplier) {
		this.supplier = supplier;
	}
	public String getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getPaymentState() {
		return paymentState;
	}
	public void setPaymentState(String paymentState) {
		this.paymentState = paymentState;
	}
	public String getOrderState() {
		return orderState;
	}
	public void setOrderState(String orderState) {
		this.orderState = orderState;
	}
	
	
}
