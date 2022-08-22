package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import repository.CartDao;
import repository.ReviewDao;
import util.DBUtil;
import vo.Review;

public class ReviewService {
	
	private ReviewDao reviewDao;
	private DBUtil dbUtil;
	
	// 고객별 리뷰 리스트 라스트페이지 구하기
	public int getReviewByCustomerLastPage(String customerId, int rowPerPage) {
		
		int lastPage = 0;
		Connection conn = null;
		dbUtil = new DBUtil();
		int totalRow = 0;
		
		try {
			conn = dbUtil.getConnection();
			
			reviewDao = new ReviewDao();
			totalRow = reviewDao.selectReviewByCustomerCount(conn, customerId);
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
	
	// 고객별 리뷰 리스트
	public List<Map<String, Object>> getReviewByCustomer(String customerId, int rowPerPage, int currentPage) {
		
		List<Map<String, Object>> list = null;
		Connection conn = null;
		dbUtil = new DBUtil();
		
		int beginRow = (currentPage -1) * rowPerPage;
		
		try {
			conn = dbUtil.getConnection();
			
			reviewDao = new ReviewDao();
			list = reviewDao.selectReviewByCustomer(conn, customerId, rowPerPage, beginRow);
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
	
	// 상품별 리뷰 리스트 라스트페이지 구하기
	public int getReviewByGoodsLastPage(int goodsNo, int rowPerPage) {
		
		int lastPage = 0;
		Connection conn = null;
		dbUtil = new DBUtil();
		int totalRow = 0;
		
		try {
			conn = dbUtil.getConnection();
			
			reviewDao = new ReviewDao();
			totalRow = reviewDao.selectGoodsByCustomerCount(conn, goodsNo);
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
		
		System.out.println("상품별 리스트 라스트페이지 --- " + lastPage);
		
		return lastPage;
	}

	// 상품별 리뷰 리스트
	public List<Map<String, Object>> getReviewByGoods(int goodsNo, int rowPerPage, int currentPage) {
		
		List<Map<String, Object>> list = null;
		Connection conn = null;
		dbUtil = new DBUtil();
		
		int beginRow = (currentPage -1) * rowPerPage;
		
		try {
			conn = dbUtil.getConnection();
			
			reviewDao = new ReviewDao();
			list = reviewDao.selectReviewByGoods(conn, goodsNo,rowPerPage, beginRow);
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
	
	// 상품을 주문한 사람의 리뷰쓰기
	public boolean addReviewByCustomer(Review paramReview) {
		
		Connection conn = null;
		dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false); // 자동 커밋을 막아준다.
			
			reviewDao = new ReviewDao();
			
			if (reviewDao.insertReviewByCustomer(conn, paramReview) != 1) { // 입력 실패하면
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
	
	// 자신이 작성한 리뷰 수정하기
	public boolean modifyReviewByCustomer(Review paramReview) {
		
		Connection conn = null;
		dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false); // 자동 커밋을 막아준다.
			
			reviewDao = new ReviewDao();
			
			if (reviewDao.updateReviewByCustomer(conn, paramReview) != 1) { // 수정 실패하면
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
	
	// 자신이 작성한 리뷰 삭제하기
	public boolean removeReviewByCustomer(int orderNo) {
		
		Connection conn = null;
		dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false); // 자동 커밋을 막아준다.
			
			reviewDao = new ReviewDao();
			
			if (reviewDao.deleteReviewByCustomer(conn, orderNo) != 1) { // 삭제 실패하면
				throw new Exception(); // 예외 발생시킨다.
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
}
