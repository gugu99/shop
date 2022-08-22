package vo;

public class Review {
	private int orderNo;
	private String reviewContent;
	private String updateDate;
	private String createDate;
	
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	
	@Override
	public String toString() {
		return "Review [orderNo=" + orderNo + ", reviewContent=" + reviewContent + ", updateDate=" + updateDate
				+ ", createDate=" + createDate + "]";
	}
}
