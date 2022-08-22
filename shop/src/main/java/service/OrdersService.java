package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import repository.OrdersDao;
import util.DBUtil;
import vo.Orders;

public class OrdersService {

	private DBUtil dbUtil;
	private OrdersDao ordersDao;
	
	// 주문 수정하기 (주문하고 결제를 했다는 가정하(배송전)에 배송정보만 수정할 수 있음)
	public boolean modifyOrders(Orders paramOrders) {
		
		Connection conn = null;
		dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false); // 자동 커밋을 막아준다.
			
			ordersDao = new OrdersDao();
			if (ordersDao.updateOrders(conn, paramOrders) != 1) { // 수정 실패하면
				throw new Exception(); // 예외를 발생시킨다.
			}
			
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			return false;
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		return true;
	}
	
	// 주문하기(고객) - 상품 한개씩만 주문 가능
	public boolean addOrder(Orders paramOrders) {
		
		Connection conn = null;
		dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false); // 자동 커밋을 막는다.
			
			ordersDao = new OrdersDao();
			if (ordersDao.insertOrder(conn, paramOrders) != 1) { // 주문 입력 실패하면
				throw new Exception(); // 예외를 발생시킨다.
			}
			
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			return false;
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		return true;
	}
	
	// 주문 상태값 수정
	public boolean modifyOrdersState(Orders paramOrders) {
		
		Connection conn = null;
		dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false); // 자동 커밋을 막는다.
			ordersDao = new OrdersDao();
			
			if (ordersDao.updateOrdersState(conn, paramOrders) != 1) { // 수정 실패시 
				throw new Exception(); // 강제 예외 만들기
			}
			
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			return false; 
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		return true;
	}
	
	// 주문 상세보기
	public Map<String, Object> getOrdersOne(int orderNo) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		Connection conn = null;
		dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			ordersDao = new OrdersDao();
			map = ordersDao.selectOrdersOne(conn, orderNo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		return map;
	}
	
	// 주문 리스트 lastPage 구하기
	public int getOrdersListLastPage(int rowPerPage) {
		
		int lastPage = 0;
		Connection conn = null;
		dbUtil = new DBUtil();
		int totalRow = 0;
		
		try {
			conn = dbUtil.getConnection();
			ordersDao = new OrdersDao();
			totalRow = ordersDao.selectOrdersCount(conn);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		lastPage = (totalRow % rowPerPage != 0) ? (totalRow / rowPerPage) + 1 : totalRow / rowPerPage;
		
		return lastPage;
	}
	
	// 주문 리스트 (전체 주문 목록 - 관리자)
	public List<Map<String, Object>> getOrdersList(int rowPerPage, int currentPage) {
		
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Connection conn = null;
		dbUtil = new DBUtil();
		
		int beginRow = (currentPage - 1) * rowPerPage;
		
		try {
			conn = dbUtil.getConnection();
			ordersDao = new OrdersDao();
			list = ordersDao.selectOrdersList(conn, rowPerPage, beginRow);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		return list;
	}
	
	// 고객 한명의 주문 목록(관리자, 고객)
	public List<Map<String, Object>> getOrdersListByCustomer(String customerId, int rowPerPage, int currentPage) {
		
		List<Map<String, Object>> list = null;
		Connection conn = null;
		dbUtil = new DBUtil();
		
		int beginRow = (currentPage -1) * rowPerPage;
		
		
		try {
			conn = dbUtil.getConnection();
			ordersDao = new OrdersDao();
			list = ordersDao.selectOrdersListByCustomer(conn, customerId, rowPerPage, beginRow);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		return list;
	}
}
