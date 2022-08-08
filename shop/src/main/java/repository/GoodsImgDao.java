package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import vo.GoodsImg;

public class GoodsImgDao {
	
	// 이미지 수정하기
	public int updateGoodsImg(Connection conn, GoodsImg paramGoodsImg) throws SQLException {
		System.out.println("\n--------------------GoodsImgDao.updateGoodsImg()");
		
		int result = 0;
		String sql = "UPDATE goods_img SET filename = ?, origin_filename = ?, content_type = ? WHERE goods_no = ?";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramGoodsImg.getFilename());
			stmt.setString(2, paramGoodsImg.getOriginFilename());
			stmt.setString(3, paramGoodsImg.getContentType());
			stmt.setInt(4, paramGoodsImg.getGoodsNo());
			
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
	
	// 이미지 삭제하기
	public int deleteGoodsImg(Connection conn, int goodsNo) throws SQLException {
		System.out.println("\n--------------------GoodsImgDao.deleteGoodsImg()");
		
		int result = 0;
		String sql = "DELETE FROM goods_img WHERE goods_no = ?";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsNo);
			
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
	
	// 이미지 등록하기
	public int insertGoodsImg(Connection conn, GoodsImg paramGoodsImg) throws SQLException {
		System.out.println("\n--------------------GoodsImgDao.insertGoodsImg()");
		
		int result = 0;
		String sql = "INSERT INTO goods_img (goods_no,filename, origin_filename, content_type, create_date) VALUES (?,?,?,?,NOW())";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramGoodsImg.getGoodsNo());
			stmt.setString(2, paramGoodsImg.getFilename());
			stmt.setString(3, paramGoodsImg.getOriginFilename());
			stmt.setString(4, paramGoodsImg.getContentType());
			
			System.out.println("stmt --- " + stmt); // 디버깅
			
			result = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		
		return result;
	}
}
