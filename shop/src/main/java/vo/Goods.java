package vo;

public class Goods {
	private int goodsNo;
	private String goodsName;
	private int goodsPrice;
	private String soldeOut;
	private String createDate;
	private String updateDate;
	
	public int getGoodsNo() {
		return goodsNo;
	}
	public void setGoodsNo(int goodsNo) {
		this.goodsNo = goodsNo;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public int getGoodsPrice() {
		return goodsPrice;
	}
	public void setGoodsPrice(int goodsPrice) {
		this.goodsPrice = goodsPrice;
	}
	public String getSoldeOut() {
		return soldeOut;
	}
	public void setSoldeOut(String soldeOut) {
		this.soldeOut = soldeOut;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	
	@Override
	public String toString() {
		return "Goods [goodsNo=" + goodsNo + ", goodsName=" + goodsName + ", goodsPrice=" + goodsPrice + ", soldeOut="
				+ soldeOut + ", createDate=" + createDate + ", updateDate=" + updateDate + "]";
	}
}
