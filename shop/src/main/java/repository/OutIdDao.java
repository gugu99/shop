package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;


public class OutIdDao {
	
	// 탈퇴 회원의 아이디를 입력
	// CustomerService.removeCustomer(Customer customer) 호출
	public int insertOutId(Connection conn, String outId) throws SQLException {
		System.out.println("\n--------------------Customer.insertOutId()");
		// 동일한 conn
		// conn.close() X
		int result = 0;
		String sql = "INSERT INTO outid (out_id, out_date) VALUES (?,NOW())";
		PreparedStatement stmt = null;
		
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, outId);
			
			System.out.println("stmt --- " + stmt); // 디버깅
			
			result = stmt.executeUpdate();
			
			System.out.println("result --- " + result);
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return result;
	}

}
