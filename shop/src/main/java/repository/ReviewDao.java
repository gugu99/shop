package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Review;

public class ReviewDao {
	
	// 고객별 리뷰 리스트 count(*) 구하기
	public int selectReviewByCustomerCount(Connection conn, String customerId) throws SQLException {
		System.out.println("\n--------------------ReviewDao.selectReviewByCustomerCount()");
		
		int cnt = 0;
		String sql = "SELECT COUNT(t.order_no) cnt FROM review r INNER JOIN (SELECT order_no FROM orders WHERE customer_id = ?) t ON r.order_no = t.order_no";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerId);
			
			System.out.println("stmt --- " + stmt);
			
			rs = stmt.executeQuery();
			
			if (rs.next()) {
				cnt = rs.getInt("cnt");
			}
			
			System.out.println("cnt --- " + cnt);
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		
		return cnt;
	}
	
	// 고객별 리뷰 리스트
	public List<Map<String, Object>> selectReviewByCustomer(Connection conn, String customerId, int rowPerPage, int beginRow) throws SQLException {
		System.out.println("\n--------------------ReviewDao.selectReviewByCustomer()");
		
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		String sql = "SELECT r.order_no orderNo, r.review_content reviewContent, r.update_date updateDate, r.create_date createDate, o.customer_id customerId, g.goods_name goodsName FROM review r INNER JOIN orders o ON r.order_no = o.order_no INNER JOIN goods g ON g.goods_no = o.goods_no WHERE o.customer_id = ? ORDER BY r.create_date DESC LIMIT ?,?";
		/*
		 SELECT
		 	r.order_no orderNo, r.review_content reviewContent, r.update_date updateDate, r.create_date createDate, o.customer_id customerId, g.goods_name
		 FROM review r INNER JOIN orders o ON r.order_no = o.order_no 
		 				INNER JOIN goods g ON g.goods_no = o.goods_no
		 WHERE o.customer_id = ? ORDER BY r.create_date DESC LIMIT ?,?
		 */
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerId);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			
			System.out.println("stmt --- " + stmt);
			
			rs = stmt.executeQuery();
			
			while (rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("orderNo", rs.getInt("orderNo"));
				map.put("updateDate", rs.getString("updateDate"));
				map.put("createDate", rs.getString("createDate"));
				map.put("reviewContent", rs.getString("reviewContent"));
				map.put("customerId", rs.getString("customerId"));
				map.put("goodsName", rs.getString("goodsName"));
				
				list.add(map);
			}
			System.out.println("list --- " + list);
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		
		return list;
	}
	
	// 상품별 리뷰리스트 count(*) 구하기
	public int selectGoodsByCustomerCount(Connection conn, int goodsNo) throws SQLException {
		System.out.println("\n--------------------ReviewDao.selectGoodsByCustomerCount()");
		
		int cnt = 0;
		String sql = "SELECT COUNT(t.order_no) cnt FROM review r INNER JOIN (SELECT order_no FROM orders WHERE goods_no = ?) t ON r.order_no = t.order_no";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsNo);
			
			System.out.println("stmt --- " + stmt);
			
			rs = stmt.executeQuery();
			
			if (rs.next()) {
				cnt = rs.getInt("cnt");
			}
			
			System.out.println("cnt --- " + cnt);
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		
		return cnt;
	}
	
	// 상품별 리뷰 리스트
	public List<Map<String, Object>> selectReviewByGoods(Connection conn, int goodsNo, int rowPerPage, int beginRow) throws SQLException {
		System.out.println("\n--------------------ReviewDao.selectReviewByGoods()");
		
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		String sql = "SELECT r.order_no orderNo, r.review_content reviewContent, r.update_date updateDate, r.create_date createDate, o.customer_id customerId FROM review r INNER JOIN orders o ON r.order_no = o.order_no WHERE o.goods_no = ? ORDER BY r.create_date DESC LIMIT ?,?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsNo);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			
			System.out.println("stmt --- " + stmt);
			
			rs = stmt.executeQuery();
			while (rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("orderNo", rs.getInt("orderNo"));
				map.put("reviewContent", rs.getString("reviewContent"));
				map.put("updateDate", rs.getString("updateDate"));
				map.put("createDate", rs.getString("createDate"));
				map.put("customerId", rs.getString("customerId"));
				
				list.add(map);
			}
			System.out.println("list --- " + list);
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		
		return list;
	}
	// 상품을 주문한 사람의 리뷰쓰기
	public int insertReviewByCustomer(Connection conn, Review paramReview) throws SQLException {
		System.out.println("\n--------------------ReviewDao.insertReviewByCustomer()");
		
		int result = 0;
		String sql = "INSERT INTO review (order_no, review_content, update_date, create_date) VALUES (?, ?, NOW(), NOW())";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramReview.getOrderNo());
			stmt.setString(2, paramReview.getReviewContent());
			
			System.out.println("stmt --- " + stmt);
			
			result = stmt.executeUpdate();
			
			System.out.println("result --- " + result);
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		
		return result;
	}
	
	// 자신이 작성한 리뷰 수정하기
	public int updateReviewByCustomer(Connection conn, Review paramReview) throws SQLException {
		System.out.println("\n--------------------ReviewDao.updateReviewByCustomer()");
		
		int result = 0;
		String sql = "UPDATE review SET review_content = ?, update_date = NOW() WHERE order_no = ?";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramReview.getReviewContent());
			stmt.setInt(2, paramReview.getOrderNo());
			
			System.out.println("stmt --- " + stmt);
			
			result = stmt.executeUpdate();
			
			System.out.println("result --- " + result);
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		
		return result;
	}
	
	// 자신이 작성한 리뷰 삭제하기
	public int deleteReviewByCustomer(Connection conn, int orderNo) throws SQLException {
		System.out.println("\n--------------------ReviewDao.deleteReviewByCustomer()");
		
		int result = 0;
		String sql = "DELETE FROM review WHERE order_no = ?";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, orderNo);
			
			System.out.println("stmt --- " + stmt);
			
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
