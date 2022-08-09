package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Goods;

public class GoodsDao {
	
	// 상품 수정하기
	public int updateGoods(Connection conn, Goods paramGoods) throws SQLException {
		System.out.println("\n--------------------GoodsDao.updateGoods()");
		
		int result = 0;
		String sql = "UPDATE goods SET goods_name = ?, goods_price = ?, sold_out = ?, update_date = NOW() WHERE goods_no = ?";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramGoods.getGoodsName());
			stmt.setInt(2, paramGoods.getGoodsPrice());
			stmt.setString(3, paramGoods.getSoldOut());
			stmt.setInt(4, paramGoods.getGoodsNo());
			
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
	
	// 상품 품절 여부 수정
	public int updateGoodsSoldOut(Connection conn, Goods paramGoods) throws SQLException {
		System.out.println("\n--------------------GoodsDao.updateSoldOut()");
		
		int result = 0;
		String sql = "UPDATE goods SET sold_out = ? WHERE goods_no = ?";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramGoods.getSoldOut());
			stmt.setInt(2, paramGoods.getGoodsNo());
			
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
	
	// 상품 등록
	// 반화 : key 값 (jdbc api)
	public int insertGoods(Connection conn, Goods paramGoods) throws SQLException {
		System.out.println("\n--------------------GoodsDao.insertGoods()");
		
		int keyId = 0;
		String sql = "INSERT INTO goods (goods_name, goods_price, sold_out , update_date, create_date) VALUES (?,?,?,NOW(),NOW())";
		PreparedStatement stmt = null;
		ResultSet rs =null;
		
		try {
			stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			stmt.setString(1, paramGoods.getGoodsName());
			stmt.setInt(2, paramGoods.getGoodsPrice());
			stmt.setString(3, paramGoods.getSoldOut());
			
			System.out.println("stmt --- " + stmt); // 디버깅
			// 1) insert
			stmt.executeUpdate(); // insert 성공한 row수
			// 2) select last_key from...
			rs = stmt.getGeneratedKeys(); // select last_key
			if (rs.next()) {
				keyId = rs.getInt(1);
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		System.out.println("keyId --- " + keyId); // 디버깅
		
		return keyId;
	}
	
	// 상품 상세보기 
	public Map<String, Object> selectGoodsAndImgOne(Connection conn, int goodsNo) throws SQLException {
		System.out.println("\n--------------------GoodsDao.selectGoodsAndImgOne()");
		
		Map<String, Object> map = null;
		String sql = "SELECT g.goods_no goodsNO, g.goods_name goodsName, g.goods_price goodsPrice, g.update_date gUpdateDate, g.create_date gCreateDate, g.sold_out soldOut, gi.filename filename, gi.origin_filename originFilename, gi.content_type contentType, gi.create_date giCreateDate FROM goods g INNER JOIN goods_img gi ON g.goods_no = gi.goods_no WHERE g.goods_no = ?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		/*
		 select g.*, gi.*
		 from goods g inner join goods_img gi
		 on g.goods_no = gi.goods_no
		 where g.goods_no = ?;
		 
		 쿼리에서 where조건이 없다면 .. 반환타입 List<Map<String,Object>> list
		 */
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsNo);
			
			System.out.println("stmt --- " + stmt); // 디버깅
			
			rs = stmt.executeQuery();
			
			while (rs.next()) {
				map = new HashMap<String, Object>();
				// goods
				map.put("goodsNo", rs.getInt("goodsNo"));
				map.put("goodsName", rs.getString("goodsName"));
				map.put("goodsPrice", rs.getString("goodsPrice"));
				map.put("goodsUpdateDate", rs.getString("gUpdateDate"));
				map.put("goodsCreateDate", rs.getString("gCreateDate"));
				map.put("soldOut", rs.getString("soldOut"));
				// goods_img
				map.put("filename", rs.getString("filename"));
				map.put("originFilename", rs.getString("originFilename"));
				map.put("contentType", rs.getString("contentType"));
				map.put("goodsImgCreateDate", rs.getString("giCreateDate"));
			
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
	
	// 상품 목록 count(*)구하기
	public int selectGoodsCount(Connection conn) throws SQLException {
		System.out.println("\n--------------------GoodsDao.selectGoodsCount()");
		
		int cnt = 0;
		String sql = "SELECT COUNT(*) cnt FROM goods";
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
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		
		return cnt;
	}
	
	// 상품목록
	public List<Goods> selectGoodsListByPage(Connection conn, int rowPerPage, int beginRow) throws SQLException {
		System.out.println("\n--------------------GoodsDao.selectGoodsListByPage()");
		
		List<Goods> list = new ArrayList<Goods>();
		String sql = "SELECT goods_no goodsNo, goods_name goodsName, goods_price goodsPrice, sold_out soldOut, create_date createDate, update_date updateDate FROM goods LIMIT ?,?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			
			System.out.println("stmt --- " + stmt); // 디버깅
			
			rs = stmt.executeQuery();
			
			while (rs.next()) {
				Goods goods = new Goods();
				goods.setGoodsNo(rs.getInt("goodsNo"));
				goods.setGoodsName(rs.getString("goodsName"));
				goods.setGoodsPrice(rs.getInt("goodsPrice"));
				goods.setCreateDate(rs.getString("createDate"));
				goods.setUpdateDate(rs.getString("updateDate"));
				goods.setSoldOut(rs.getString("soldOut"));
				
				list.add(goods);
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
