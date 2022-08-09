package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import vo.Notice;

public class NoticeDao {
	
	// 공지 삭제
	public int deleteNotice(Connection conn, int noticeNo) throws SQLException {
		System.out.println("\n--------------------NoticeDao.deleteNotice()");
		
		int result = 0;
		String sql = "DELETE FROM notice WHERE notice_no = ?";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, noticeNo);
			
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
	
	// 공지 수정
	public int updateNotice(Connection conn, Notice paramNotice) throws SQLException {
		System.out.println("\n--------------------NoticeDao.updateNotice()");
		
		int result = 0;
		String sql = "UPDATE notice SET notice_title = ?, notice_content = ?, update_date = NOW() WHERE notice_no = ?";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramNotice.getNoticeTitle());
			stmt.setString(2, paramNotice.getNoticeContent());
			stmt.setInt(3, paramNotice.getNoticeNo());
			
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
	
	// 공지 등록
	public int insertNotice(Connection conn, Notice paramNotice) throws SQLException {
		System.out.println("\n--------------------NoticeDao.insertNotice()");
		
		int result = 0;
		String sql = "INSERT INTO notice (notice_title, notice_content, create_date, update_date) VALUES (?,?,NOW(),NOW())";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramNotice.getNoticeTitle());
			stmt.setString(2, paramNotice.getNoticeContent());
			
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
	
	// 공지 상세보기
	public Notice selectNoticeOne(Connection conn, int noticeNo) throws SQLException {
		System.out.println("\n--------------------NoticeDao.selectNoticeOne()");
		
		Notice notice = null;
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent, create_date createDate, update_date updateDate FROM notice WHERE notice_no = ?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, noticeNo);
			
			System.out.println("stmt --- " + stmt); // 디버깅
			
			rs = stmt.executeQuery();
			
			if (rs.next()) {
				notice = new Notice();
				notice.setNoticeNo(rs.getInt("noticeNo"));
				notice.setNoticeTitle(rs.getString("noticeTitle"));
				notice.setNoticeContent(rs.getString("noticeContent"));
				notice.setCreateDate(rs.getString("createDate"));
				notice.setUpdateDate(rs.getString("updateDate"));
			}
			
			System.out.println("notice --- " + notice); // 디버깅
			
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		
		return notice;
	}
	
	// 공지 리스트 count(*) 구하기
	public int selectNoticeCount(Connection conn) throws SQLException {
		System.out.println("\n--------------------NoticeDao.selectNoticeCount()");
		
		int cnt = 0;
		String sql = "SELECT COUNT(*) cnt FROM notice";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			
			System.out.println("stmt --- " + stmt); // 디버깅
			
			rs = stmt.executeQuery();
			
			if (rs.next()) {
				cnt = rs.getInt("cnt");
			}
			
			System.out.println("cnt --- " + cnt); // 디버깅
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
	
	// 공지 리스트
	public List<Notice> selectNoticeList(Connection conn, int rowPerPage, int beginRow) throws SQLException {
		System.out.println("\n--------------------NoticeDao.selectNoticeList()");
		
		List<Notice> list = new ArrayList<Notice>();
		Notice notice = null;
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, create_date createDate, update_date updateDate FROM notice ORDER BY create_date DESC LIMIT ?,?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			
			System.out.println("stmt --- " + stmt); // 디버깅
			
			rs = stmt.executeQuery();
			
			while (rs.next()) {
				notice = new Notice();
				notice.setNoticeNo(rs.getInt("noticeNo"));
				notice.setNoticeTitle(rs.getString("noticeTitle"));
				notice.setCreateDate(rs.getString("createDate"));
				notice.setUpdateDate(rs.getString("updateDate"));
				
				list.add(notice);
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if ( stmt != null) {
				stmt.close();
			}
		}
		
		
		return list;
	}
}
