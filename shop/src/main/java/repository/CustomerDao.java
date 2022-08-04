package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import vo.Customer;



public class CustomerDao {
	
	// 로그인
	public Customer login(Customer customer) throws ClassNotFoundException, SQLException {
		System.out.println("\n--------------------Customer.login()");
		
		Customer loginCustomer = null;
		String sql = "SELECT customer_name customerName FROM customer WHERE customer_id = ? AND customer_pass = PASSWORD(?)";
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customer.getCustomerId());
			stmt.setString(2, customer.getCustomerPass());
			
			System.out.println("stmt --- " + stmt);
			
			rs = stmt.executeQuery();
			
			if (rs.next()) {
				loginCustomer = new Customer();
				loginCustomer.setCustomerId(customer.getCustomerId());
				loginCustomer.setCustomerName(rs.getString("customerName"));
			}
		} finally {
			if(rs != null) {rs.close();}
			if(stmt != null) {stmt.close();}
			if(conn != null) {conn.close();}
		}
		
		
		return loginCustomer;
	}
}
