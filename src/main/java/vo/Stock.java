package vo;

public class Stock {
	private String productNum;
	private String frRegiNum;
	private String stockDate;
	private int applyAmount;
	private int remainAmount;
	private String remark;

	
	public Stock() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Stock(String productNum, String frRegiNum, String stockDate, int applyAmount, int remainAmount,
			String remark) {
		super();
		this.productNum = productNum;
		this.frRegiNum = frRegiNum;
		this.stockDate = stockDate;
		this.applyAmount = applyAmount;
		this.remainAmount = remainAmount;
		this.remark = remark;
	}
	public String getProductNum() {
		return productNum;
	}
	public void setProductNum(String productNum) {
		this.productNum = productNum;
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
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	
	

}
