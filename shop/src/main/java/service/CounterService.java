package service;

import java.sql.Connection;
import java.sql.SQLException;

import repository.CounterDao;
import util.DBUtil;

public class CounterService {
	
	private CounterDao counterDao;
	private DBUtil dbUtil;
	
	// 오늘자 방문자 데이터 조회 후 null이면 insert 아니면 update
	public void count() {
		
		Connection conn = null;
		dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			
			counterDao = new CounterDao();
			
			if (counterDao.selectCounterToday(conn) == null) {
				counterDao.insertCounter(conn);
			} else {
				counterDao.updateCounter(conn);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	// 전체 방문자수 조회하기
	public int getTotalCount() {
		
		int totalCount = -1;
		Connection conn = null;
		dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			
			counterDao = new CounterDao();
			
			totalCount = counterDao.selectTotalCount(conn);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return totalCount;
	}
	
	// 오늘 방문자 수 구하기
	public int getTodayCount() {
		
		int todayCount = -1;
		Connection conn = null;
		dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			
			counterDao = new CounterDao();
			
			todayCount = counterDao.selectTodayCount(conn);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return todayCount;
	}
}
