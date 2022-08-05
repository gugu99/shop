package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SignDao {
	
	public String idCheck(Connection conn,String id) throws SQLException {
		System.out.println("\n--------------------SignDao.idCheck()");
		
		String ckId =null;
		/*
		 select t.id from (select cutomer_id id from customer 
		 				union 
		 				select employee_id id from employee 
		 				union 
		 				select out_id id from outid) t 
		 	where t.id=?
		 				---> null 일때 사용 가능한 아이디
		 */
		String sql = "select t.id  from (select customer_id id from customer union select employee_id id from employee union select out_id id from outid) t where t.id=?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			
			System.out.println("stmt --- " + stmt); // 디버깅
			
			rs = stmt.executeQuery();
			
			if (rs.next()) {
				ckId = rs.getString("id");
			}
			
			System.out.println("ckId --- " + ckId); // 디버깅
		} finally {
			if(rs != null) {rs.close();}
			if(stmt != null) {stmt.close();}
		}
		
		return ckId;
	}
}
