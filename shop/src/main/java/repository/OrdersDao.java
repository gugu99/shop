package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Orders;

public class OrdersDao {
	
	// 주문 상태값 수정
	public int updateOrderState(Connection conn, Orders paramOrders) throws SQLException {
		
		int result = 0;
		String sql = "UPDATE orders SET order_state = ? WHERE order_no = ?";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramOrders.getOrderState());
			stmt.setInt(2, paramOrders.getOrderNo());
			
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
	
	// 주문 상세보기
	public Map<String , Object> selectOrdersOne(Connection conn, int orderNo) throws SQLException {
		System.out.println("\n--------------------OrdersDao.selectOrdersOne()");
		
		Map<String, Object> map = null;
		String sql = "SELECT o.order_no orderNo, o.goods_no goodsNo, o.customer_id customerId, o.order_price orderPrice, o.order_quantity orderQuantity, o.order_state orderState, o.order_addr orderAddr, o.create_date createDate, o.update_date updateDate "
					+"g.goods_name goodsName, c.customer_name customerName, c.customer_telephone customerTelephone "
					+"FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no INNER JOIN o.customer_id = c.customer_id WHERE o.order_no = ?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, orderNo);
			
			System.out.println("stmt --- " + stmt);
			
			rs = stmt.executeQuery();
			
			if (rs.next()) {
				map = new HashMap<String, Object>();
				map.put("orderNo", rs.getInt("orderNo"));
				map.put("goodsNo", rs.getInt("goodsNo"));
				map.put("customerId", rs.getString("customerId"));
				map.put("orderPrice", rs.getInt("orderPrice"));
				map.put("orderQuantity", rs.getInt("orderQuantity"));
				map.put("orderState", rs.getString("orderState"));
				map.put("orderAddr", rs.getString("orderAddr"));
				map.put("createDate", rs.getString("createDate"));
				map.put("updateDate", rs.getString("updateDate"));
				map.put("goodsName", rs.getString("goodsName"));
				map.put("customerName", rs.getString("customerName"));
				map.put("customerTelephone", rs.getString("customerTelephone"));
				
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		
		return map;
	}

	// 주문 리스트 count(*) 구하기
	public int selectOrdersCount(Connection conn) throws SQLException {
		System.out.println("\n--------------------OrdersDao.selectOrdersCount()");
		
		int cnt = 0;
		String sql = "SELECT COUNT(*) cnt FROM orders";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			
			System.out.println("stmt --- " + stmt);
			
			rs = stmt.executeQuery();
			
			if (rs.next()) {
				cnt = rs.getInt("cnt");
			}
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
	
	// 주문 리스트 (전체 주문 목록 - 관리자)
	public List<Map<String, Object>> selectOrdersList(Connection conn, int rowPerPage, int beginRow) throws SQLException {
		System.out.println("\n--------------------OrdersDao.selectOrdersList()");
		
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>(); // 다형성
		String sql = "SELECT o.order_no orderNo, o.customer_id customerId, o.order_price orderPrice, o.order_quantity orderQuantity, o.order_state orderState, o.create_date createDate, o.update_date updateDate, g.goods_name goodsName "
					+"FROM orders o INNER JOIN goods g ON o.order_no = g.goods_no ORDER BY create_date DESC LIMIT ?,?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			
			System.out.println("stmt --- " + stmt);
			
			rs = stmt.executeQuery();
			
			while (rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("orderNo", rs.getInt("orderNo"));
				map.put("customerId", rs.getString("customerId"));
				map.put("orderPrice", rs.getInt("orderPrice"));
				map.put("orderQuantity", rs.getInt("orderQuantity"));
				map.put("orderState", rs.getString("orderState"));
				map.put("createDate", rs.getString("createDate"));
				map.put("updateDate", rs.getString("updateDate"));
				map.put("goodsName", rs.getString("goodsName"));
				
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
	
	// 고객 한명의 주문 목록(관리자, 고객)
	public List<Map<String, Object>> selectOrdersListByCustomer(Connection conn, String customerId , int rowPerPage, int beginRow) throws SQLException {
		System.out.println("\n--------------------OrdersDao.selectOrdersListByCustomer()");
		
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>(); // 다형성
		String sql = "SELECT o.order_no orderNo, o.customer_id customerId, o.order_price orderPrice, o.order_quantity orderQuantity, o.order_state orderState, o.create_date createDate, o.update_date updateDate, g.goods_name goodsName "
				+ "FROM orders o INNER JOIN goods g ON o.order_no = g.goods_no WHERE o.customer_id = ? ORDER BY create_date DESC LIMIT ?,?";
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
				map.put("customerId", rs.getString("customerId"));
				map.put("orderPrice", rs.getInt("orderPrice"));
				map.put("orderQuantity", rs.getInt("orderQuantity"));
				map.put("orderState", rs.getString("orderState"));
				map.put("createDate", rs.getString("createDate"));
				map.put("updateDate", rs.getString("updateDate"));
				map.put("goodsName", rs.getString("goodsName"));
				
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
