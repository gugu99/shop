package vo;

public class OutId {
	private String outId;
	private String outDate;
	
	public String getOutId() {
		return outId;
	}
	public void setOutId(String outId) {
		this.outId = outId;
	}
	public String getOutDate() {
		return outDate;
	}
	public void setOutDate(String outDate) {
		this.outDate = outDate;
	}
	
	@Override
	public String toString() {
		return "OutId [outId=" + outId + ", outDate=" + outDate + "]";
	}
	
}
