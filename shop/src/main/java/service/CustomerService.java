package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import repository.CustomerDao;
import repository.OutIdDao;
import util.DBUtil;
import vo.Customer;

public class CustomerService {
	
	private DBUtil dbUtil;
	private CustomerDao customerDao;
	private OutIdDao outIdDao;
	
	// customerList.jsp에서 호출(고객 리스트 라스트페이지 구하기)
	public int getCustomerListLastPage(int rowPerPage) {
		
		int lastPage = 0;
		Connection conn = null;
		dbUtil = new DBUtil();
		int totalRow = 0;
		
		try {
			conn = dbUtil.getConnection();
			customerDao = new CustomerDao();
			totalRow = customerDao.selectCustmoerCount(conn);
		} catch (Exception e) {
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
		
		lastPage = (totalRow % rowPerPage != 0) ? (totalRow / rowPerPage) +1 : totalRow / rowPerPage;
		
		return lastPage;
	}
	
	// customerList.jsp에서 호출(고객 리스트)
	public List<Customer> getCustomerList(int rowPerPage, int currentPage) {
		
		List<Customer> list = null;
		Connection conn = null;
		dbUtil = new DBUtil();
		
		int beginRow = (currentPage -1) * rowPerPage;
		
		try {
			conn = dbUtil.getConnection();
			customerDao = new CustomerDao();
			list = customerDao.selectCustomerList(conn, rowPerPage, beginRow);
		} catch (Exception e) {
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
		
		return list;
	}
	
	// addCustomerAction.jsp에서 호출(회원가입)
	public boolean addCustomer(Customer paramCustomer) {
		
		Connection conn = null;
		dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false); // executeUpdate();실행시 자동 커밋을 막는다.
			
			customerDao = new CustomerDao();
			
			if (customerDao.insertCustomer(conn, paramCustomer) != 1) {
				throw new Exception(); // 강제 예외처리
			}
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
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
	
	// 회원탈퇴 액션페이지에서 호출되는 메서드
	public boolean removeCustomer(Customer paramCustomer) {
		
		Connection conn = null;
		dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false); // executeUpdate();실행시 자동 커밋을 막는다.
			
			customerDao = new CustomerDao();
			if (customerDao.deleteCustomer(conn, paramCustomer) != 1) {
				throw new Exception(); // 강제 예외처리
			}
			outIdDao = new OutIdDao();
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
		dbUtil = new DBUtil();
		Customer customer = null;
		
		try {
			conn= dbUtil.getConnection();
			
			customerDao = new CustomerDao();
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
