package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import repository.NoticeDao;
import util.DBUtil;
import vo.Notice;

public class NoticeService {

	DBUtil dbUtil;
	NoticeDao noticeDao;
	
	// 공지 삭제
	public boolean removeNotice(int noticeNo) {
		
		Connection conn = null;
		dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false); // executeUpdate();실행시 자동 커밋을 막는다.
			
			noticeDao = new NoticeDao();
			
			if (noticeDao.deleteNotice(conn, noticeNo) != 1) { // 삭제 실패시
				throw new Exception(); // 강제 예외만들기
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
	
	// 공지 수정
	public boolean modifyNotice(Notice paramNotice) {
		
		Connection conn = null;
		dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false); // executeUpdate();실행시 자동 커밋을 막는다.
			
			noticeDao = new NoticeDao();
			
			if (noticeDao.updateNotice(conn, paramNotice) != 1) { // 수정 실패시
				throw new Exception(); // 강제 예외만들기
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
	
	// 공지 등록
	public boolean addNotice(Notice paramNotice) {
		
		Connection conn = null;
		dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false); // executeUpdate();실행시 자동 커밋을 막는다.
			
			noticeDao = new NoticeDao();

			if (noticeDao.insertNotice(conn, paramNotice) != 1) { // 입력 실패시
				throw new Exception(); // 강제 예외만들기
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
	
	// 공지 상세보기
	public Notice getNoticeOne(int noticeNo) {
		
		Notice notice = null;
		Connection conn = null;
		dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			noticeDao = new NoticeDao();
			notice = noticeDao.selectNoticeOne(conn, noticeNo);
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
		
		return notice;
	}
	
	// 공지 리스트 count(*) 구하기
	public int getNoticeLastPage(int rowPerPage) {
		
		int lastPage = 0;
		Connection conn = null;
		dbUtil = new DBUtil();
		int totalRow = 0;
		
		try {
			conn = dbUtil.getConnection();
			noticeDao = new NoticeDao();
			totalRow = noticeDao.selectNoticeCount(conn);
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
	
	// 공지 리스트
	public List<Notice> getNoticeList(int rowPerPage, int currentPage) {
		
		List<Notice> list = null;
		Connection conn = null;
		dbUtil = new DBUtil();
		
		int beginRow = (currentPage -1) * rowPerPage;
		
		try {
			conn = dbUtil.getConnection();
			noticeDao = new NoticeDao();
			list = noticeDao.selectNoticeList(conn, rowPerPage, beginRow);
		} catch (Exception e) {
			e.printStackTrace();
			
		}finally {
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
