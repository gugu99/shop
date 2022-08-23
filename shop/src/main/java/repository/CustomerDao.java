package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import vo.Customer;


public class CustomerDao {
	
	// 회원정보 조회
	public Customer selectCustomerOne(Connection conn, String customerId) throws SQLException {
		System.out.println("\n--------------------CustomerDao.selectCustomerOne()");
		
		Customer customer = new Customer();;
		String sql = "SELECT customer_name customerName, customer_address customerAddress, customer_telephone customerTelephone FROM customer WHERE customer_id = ?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerId);
			
			System.out.println("stmt --- " + stmt); // 디버깅
			
			rs = stmt.executeQuery();
			
			if (rs.next()) {
				customer.setCustomerName(rs.getString("customerName"));
				customer.setCustomerAddress(rs.getString("customerAddress"));
				customer.setCustomerTelephone(rs.getString("customerTelephone"));
			}
			System.out.println("customer --- " + customer); // 디버깅
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		
		return customer;
	}
	
	// 회원정보 수정
	public int updateCustomer(Connection conn, Customer paramCustomer) throws SQLException {
		System.out.println("\n--------------------CustomerDao.updateCustomer()");
		
		int result = 0;
		String sql = "UPDATE customer SET customer_name = ?, customer_address = ?, customer_telephone = ?, update_date = NOW() WHERE customer_id = ?";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramCustomer.getCustomerName());
			stmt.setString(2, paramCustomer.getCustomerAddress());
			stmt.setString(3, paramCustomer.getCustomerTelephone());
			stmt.setString(4, paramCustomer.getCustomerId());
			
			System.out.println("stmt --- " + stmt); // 디버깅
			
			result = stmt.executeUpdate();
			
			System.out.println("result --- " + result); // 디버깅
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		
		return result;
	}
	
	// 관리자에 의한 비밀번호 변경 
	public int updatePassByEmployee(Connection conn, Customer paramCustomer) throws SQLException {
		System.out.println("\n--------------------CustomerDao.updatePassByEmployee()");
		
		int result = 0;
		String sql = "UPDATE customer SET customer_pass = PASSWORD(?), update_date = NOW() WHERE customer_id = ?";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramCustomer.getCustomerPass());
			stmt.setString(2, paramCustomer.getCustomerId());
			
			System.out.println("stmt --- " + stmt); // 디버깅
			
			result = stmt.executeUpdate();
			
			System.out.println("result --- " + result); // 디버깅
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		
		return result;
	}
	
	// 관리자에 의한 강제탈퇴
	public int deleteCustomerByEmployee(Connection conn, String customerId) throws SQLException {
		System.out.println("\n--------------------CustomerDao.deleteCustomerByEmployee()");
		
		int result = 0;
		String sql = "DELETE FROM customer WHERE customer_id = ?";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerId);
			
			System.out.println("stmt --- " + stmt); // 디버깅
			
			result = stmt.executeUpdate();
			
			System.out.println("result --- " + result); // 디버깅
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		
		return result;
	}
	
	
	// 고객 리스트 count(*) 구하기
	public int selectCustmoerCount(Connection conn) throws SQLException {
		System.out.println("\n--------------------CustomerDao.selectCustmoerCount()");
		
		int cnt = 0;
		String sql = "SELECT count(*) cnt FROM customer";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			
			System.out.println("stmt --- " + stmt); // 디버깅
			
			rs = stmt.executeQuery();
			
			if (rs.next()) {
				cnt = rs.getInt("cnt");
			}
		} finally {
			if(rs != null) {
				rs.close();
				}
			if (stmt != null) {
				stmt.close();
			}
		}
		
		return cnt;
	}
	
	// 고객 리스트
	public List<Customer> selectCustomerList(Connection conn, int rowPerPage, int beginRow) throws SQLException{
		System.out.println("\n--------------------CustomerDao.selectCustomerList()");
		
		List<Customer> list = new ArrayList<Customer>();
		String sql = "SELECT customer_id customerId, customer_name customerName, customer_address customerAddress, customer_telephone customerTelephone, update_date updateDate, create_date createDate From customer LIMIT ?,?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			
			System.out.println("stmt --- " + stmt); // 디버깅
			
			rs = stmt.executeQuery();
			
			while (rs.next()) {
				Customer customer = new Customer();
				customer.setCustomerId(rs.getString("customerId"));
				customer.setCustomerName(rs.getString("customerName"));
				customer.setCustomerAddress(rs.getString("customerAddress"));
				customer.setCustomerTelephone(rs.getString("customerTelephone"));
				customer.setUpdateDate(rs.getString("updateDate"));
				customer.setCreateDate(rs.getString("createDate"));
				
				list.add(customer);
			}
		} finally {
			if(rs != null) {
				rs.close();
				}
			if (stmt != null) {
				stmt.close();
			}
		}
		
		return list;
	}
	
	// 회원가입
	public int insertCustomer(Connection conn, Customer paramCustomer) throws SQLException {
		System.out.println("\n--------------------CustomerDao.insertCustomer()");
		
		int result = 0;
		String sql = "INSERT INTO customer VALUES (?, PASSWORD(?), ?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramCustomer.getCustomerId());
			stmt.setString(2, paramCustomer.getCustomerPass());
			stmt.setString(3, paramCustomer.getCustomerName());
			stmt.setString(4, paramCustomer.getCustomerAddress());
			stmt.setString(5, paramCustomer.getCustomerTelephone());
			
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
	
	// 탈퇴
	// CustomerService.removeCustomer(Customer customer) 호출
	public int deleteCustomer(Connection conn, Customer paramCustomer) throws SQLException {
		System.out.println("\n--------------------CustomerDao.deleteCustomer()");
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
		System.out.println("\n--------------------CustomerDao.selectCustomerByIdAndPw()");
		
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
