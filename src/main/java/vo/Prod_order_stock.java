package vo;

public class Prod_order_stock {
	private String productNum;
	private String category;
	private String productName;
	private String opposite;
	private int price;
	private String img;
	private String remark;
	private String frRegiNum;
	private String stockDate;
	private int applyAmount;
	private int remainAmount;
	private String orderNum;
	private String demander;	//본사가 사올때는 본사코드, 팔때는 가맹점번호
	private String supplier;	//본사가 팔때는 본사코드, 본사가 밖에서 사올때는 다른곳 사업자번호나 그런거,검색할때 담당자이름이나 사원번호
	private String orderDate;
	private int amount;
	private String paymentState;
	private String orderState;
	private String orderStateUpdate;
	private String orderDateMonth;
	public String getProductNum() {
		return productNum;
	}
	public void setProductNum(String productNum) {
		this.productNum = productNum;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getOpposite() {
		return opposite;
	}
	public void setOpposite(String opposite) {
		this.opposite = opposite;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getFrRegiNum() {
		return frRegiNum;
	}
	public void setFrRegiNum(String frRegiNum) {
		this.frRegiNum = frRegiNum;
	}
	public String getStockDate() {
		return stockDate;
	}
	public void setStockDate(String stockDate) {
		this.stockDate = stockDate;
	}
	public int getApplyAmount() {
		return applyAmount;
	}
	public void setApplyAmount(int applyAmount) {
		this.applyAmount = applyAmount;
	}
	public int getRemainAmount() {
		return remainAmount;
	}
	public void setRemainAmount(int remainAmount) {
		this.remainAmount = remainAmount;
	}
	public String getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
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
	
}
