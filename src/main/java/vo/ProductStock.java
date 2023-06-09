package vo;

import org.springframework.web.multipart.MultipartFile;

public class ProductStock {
	private String productNum;
	private String category;
	private String productName;
	private String opposite;
	private int price;
	private String img;
	private String remark;
	private MultipartFile multipartfile;
	private String frRegiNum;
	private String stockDate;
	private int applyAmount;
	private int remainAmount;
	
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
	public ProductStock() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ProductStock(String productNum, String category, String productName, String opposite, int price, String img,
			String remark) {
		super();
		this.productNum = productNum;
		this.category = category;
		this.productName = productName;
		this.opposite = opposite;
		this.price = price;
		this.img = img;
		this.remark = remark;
	}
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
	public MultipartFile getMultipartfile() {
		return multipartfile;
	}
	public void setMultipartfile(MultipartFile multipartfile) {
		this.multipartfile = multipartfile;
	}
	
}
