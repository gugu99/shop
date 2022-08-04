package service;

import java.sql.Connection;
import java.sql.SQLException;

import repository.CustomerDao;
import repository.OutIdDao;
import vo.Customer;

public class CustomerService {
	
	// 회원탈퇴 액션페이지에서 호출되는 메서드
	public boolean removeCustomer(Customer paramCustomer) {
		
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false); // executeUpdate();실행시 자동 커밋을 막는다.
			
			CustomerDao customerDao = new CustomerDao();
			if (customerDao.deleteCustomer(conn, paramCustomer) != 1) {
				throw new Exception(); // 강제 예외처리
			}
			OutIdDao outIdDao = new OutIdDao();
			if (outIdDao.insertOutId(conn, paramCustomer.getCustomerId()) != 1) {
				throw new Exception(); // 강제 예외처리
			}
			
			conn.commit();
			
		} catch (Exception e) {
			e.printStackTrace(); // 콘솔에 예외메세지 출력하기
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			return false; // 탈퇴 실패
		} finally {
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		return true;
	}
	
	// loginAction.jsp가 호출
	public Customer getCustomerByIdAndPw(Customer paramCustomer) {
		
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();
		Customer customer = null;
		
		try {
			conn= dbUtil.getConnection();
			
			CustomerDao customerDao = new CustomerDao();
			customer = customerDao.selectCustomerByIdAndPw(conn, paramCustomer);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
			
		return customer;
	}
}
