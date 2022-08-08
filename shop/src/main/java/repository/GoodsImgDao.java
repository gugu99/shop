package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import vo.GoodsImg;

public class GoodsImgDao {
	
	// 이미지 등록하기
	public int insertGoodsImg(Connection conn, GoodsImg paramGoodsImg) throws SQLException {
		System.out.println("\n--------------------GoodsImgDao.insertGoodsImg()");
		
		int result = 0;
		String sql = "INSERT INTO goods_img (goods_no,filename, origin_filename, content_type,system_filename, create_date) VALUES (?,?,?,?,?,NOW())";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramGoodsImg.getGoodsNo());
			stmt.setString(2, paramGoodsImg.getFilename());
			stmt.setString(3, paramGoodsImg.getOriginFilename());
			stmt.setString(4, paramGoodsImg.getContentType());
			stmt.setString(5, paramGoodsImg.getSystemFilename());
			
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
