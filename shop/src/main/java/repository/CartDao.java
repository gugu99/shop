package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Cart;

public class CartDao {
	
	// 장바구니 담기
	public int insertCartByCustomer(Connection conn, Cart paramCart) throws SQLException {
		System.out.println("\n--------------------CartDao.insertCartByCustomer");
		
		int result = 0;
		String sql = "INSERT INTO cart (goods_no, customer_id, cart_quantity, update_date, create_date) VALUES (?,?,?,NOW(),NOW())";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramCart.getGoodsNo());
			stmt.setString(2, paramCart.getCustomerId());
			stmt.setInt(3, paramCart.getCartQuantity());
			
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

	// 장바구니 수정하기(수량)
	public int updateCartQuantity(Connection conn, Cart paramCart) throws SQLException {
		System.out.println("\n--------------------CartDao.updateCartQuantity");
		
		int result = 0;
		String sql = "UPDATE cart SET cart_quantity = ? WHERE goods_no = ? AND customer_id = ?";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramCart.getCartQuantity());
			stmt.setInt(2, paramCart.getGoodsNo());
			stmt.setString(3, paramCart.getCustomerId());
			
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
	
	// 장바구니 삭제하기
	public int deleteCart(Connection conn, Cart paramCart) throws SQLException {
		System.out.println("\n--------------------CartDao.deleteCart");
		
		int result = 0;
		String sql = "DELETE FROM cart WHERE goods_no = ? AND customer_id = ?";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramCart.getGoodsNo());
			stmt.setString(2, paramCart.getCustomerId());
			
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
	
	// 장바구니 리스트 count(*) 구하기
	public int selectCartByCustomerCount(Connection conn, String customerId) throws SQLException {
		System.out.println("\n--------------------CartDao.selectCartByCustomerCount");
		
		int cnt = 0;
		String sql = "SELECT COUNT(*) cnt FROM cart WHERE customer_id = ?";
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
	
	
	// 장바구니 리스트(고객)
	public List<Map<String, Object>> selectCartByCustomer(Connection conn, String customerId, int rowPerPage, int beginRow) throws SQLException {
		System.out.println("\n--------------------CartDao.selectCartByCustomer");
		
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		String sql = "SELECT c.goods_no goodsNo, c.cart_quantity cartQuantity, c.update_date updateDate, c.create_date createDate, g.goods_name goodsName, g.goods_price goodsPrice, gi.filename filename "
				+ "FROM cart c INNER JOIN goods g ON c.goods_no = g.goods_no INNER JOIN goods_img gi ON c.goods_no = gi.goods_no WHERE c.customer_id = ? ORDER BY c.create_date DESC LIMIT ?,?";
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
				map.put("goodsNo", rs.getInt("goodsNo"));
				map.put("cartQuantity", rs.getInt("cartQuantity"));
				map.put("createDate", rs.getString("createDate"));
				map.put("updateDate", rs.getString("updateDate"));
				map.put("goodsName", rs.getString("goodsName"));
				map.put("goodsPrice", rs.getInt("goodsPrice"));
				map.put("filename", rs.getString("filename"));
				
				list.add(map);
			}
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
}
