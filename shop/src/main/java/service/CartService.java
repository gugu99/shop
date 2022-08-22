package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import repository.CartDao;
import util.DBUtil;
import vo.Cart;

public class CartService {
	
	private CartDao cartDao;
	private DBUtil dbUtil;
	
	// 장바구니 담기
	public boolean addCartByCustomer(Cart paramCart) {
		
		Connection conn = null;
		dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false); // 자동 커밋을 막아준다.
			
			cartDao = new CartDao();
			if (cartDao.insertCartByCustomer(conn, paramCart) != 1) { // 입력 실패하면 
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
	
	// 장바구니 수정하기(수량)
	public boolean modifyCartQuantity(Cart paramCart) {
		
		Connection conn = null;
		dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false); // 자동 커밋을 막아준다.
			
			cartDao = new CartDao();
			if (cartDao.updateCartQuantity(conn, paramCart) != 1) { // 수정에 실패하면
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
	
	// 장바구니 삭제하기
	public boolean removeCart(Cart paramCart) {
		
		Connection conn = null;
		dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false); // 자동 커밋을 막아준다.
			
			cartDao = new CartDao();
			if (cartDao.deleteCart(conn, paramCart) != 1) { // 삭제 실패하면
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
	
	// 장바구니 리스트 라스트페이지
	public int getCartByCustomerLastPage(String customerId, int rowPerPage) {
		
		int lastPage = 0;
		Connection conn = null;
		dbUtil = new DBUtil();
		int totalRow = 0;
		
		try {
			conn = dbUtil.getConnection();
			
			cartDao = new CartDao();
			totalRow = cartDao.selectCartByCustomerCount(conn, customerId);
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
		lastPage = (totalRow % rowPerPage != 0) ? (totalRow / rowPerPage)+1 : totalRow / rowPerPage;
		
		return lastPage;
	}
	
	// 장바구니 리스트(고객)
	public List<Map<String, Object>> getCartByCustomer(String customerId, int rowPerPage, int currentPage) {
		
		List<Map<String, Object>> list = null;
		Connection conn = null;
		dbUtil = new DBUtil();
		
		int beginRow = (currentPage -1) * rowPerPage;
		
		try {
			conn = dbUtil.getConnection();
			
			cartDao = new CartDao();
			list = cartDao.selectCartByCustomer(conn, customerId, rowPerPage, beginRow);
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
 