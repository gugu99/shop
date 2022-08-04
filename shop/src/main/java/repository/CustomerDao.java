package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import vo.Customer;



public class CustomerDao {
	
	// 탈퇴
	// CustomerService.removeCustomer(Customer customer) 호출
	public int deleteCustomer(Connection conn, Customer paramCustomer) throws SQLException {
		System.out.println("\n--------------------Customer.deleteCustomer()");
		// 동일한 conn
		// conn.close() X
		int result = 0; 
		String sql = "DELETE FROM customer WHERE customer_id = ? AND customer_pass = PASSWORD(?)";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramCustomer.getCustomerId());
			stmt.setString(2, paramCustomer.getCustomerPass());
			
			System.out.println("stmt --- " + stmt); // 디버깅
			System.out.println("paramCustomer --- " + paramCustomer); // 디버깅
			
			result = stmt.executeUpdate();
			
			System.out.println("result --- " + result); // 디버깅
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return result;
	}
	
	
	// CutomerService가 호출
	public Customer selectCustomerByIdAndPw(Connection conn ,Customer paramCustomer) throws ClassNotFoundException, SQLException {
		System.out.println("\n--------------------Customer.selectCustomerByIdAndPw()");
		
		Customer customer = null;
		String sql = "SELECT customer_name customerName FROM customer WHERE customer_id = ? AND customer_pass = PASSWORD(?)";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramCustomer.getCustomerId());
			stmt.setString(2, paramCustomer.getCustomerPass());
			
			System.out.println("stmt --- " + stmt); // 디버깅
			System.out.println("paramCustomer --- " + paramCustomer); // 디버깅
			
			rs = stmt.executeQuery();
			
			if (rs.next()) {
				customer = new Customer();
				customer.setCustomerId(paramCustomer.getCustomerId());
				customer.setCustomerName(rs.getString("customerName"));
				
				System.out.println("customer --- " + customer); // 디버깅
			}
		} finally {
			if(rs != null) {rs.close();}
			if(stmt != null) {stmt.close();}
		}
		
		return customer;
	}
}
