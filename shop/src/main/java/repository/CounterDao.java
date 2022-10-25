package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CounterDao {

	// 오늘자 방문자가 있으면 update, 없으면 insert
	// 데이터 먼저 조회
	public String selectCounterToday(Connection conn) throws SQLException {
		System.out.println("\n----------- CounterDao.selectCounterToday()");
		
		String result = null;
		String sql = "SELECT counter_date FROM counter WHERE counter_date = CURDATE()";
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			System.out.println("stmt --- " + stmt);
			
			rs = stmt.executeQuery();
			if (rs.next()) {
				result = rs.getString("counter_date");
				System.out.println("result --- " + result);
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		
		return result; // 데이터가 있으면 오늘날짜, 없으면 null 리턴
	}
	
	// 방문자 수 추가하기
	public int insertCounter(Connection conn) throws SQLException {
		System.out.println("\n----------- CounterDao.insertCounter()");
		
		int result = 0;
		String sql = "INSERT INTO counter(counter_date, counter_num) VALUES (CURDATE(), 1)";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
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
	
	// 방문자수 더하기
	public int updateCounter(Connection conn) throws SQLException {
		System.out.println("\n----------- CounterDao.updateCounter()");
		
		int result = 0;
		String sql = "UPDATE counter SET counter_num = counter_num + 1 WHERE counter_date = CURDATE()";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
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
	
	// 전체 접속자수 구하기
	public int selectTotalCount(Connection conn) throws SQLException {
		System.out.println("\n----------- CounterDao.selectTotalCount()");
		
		int result = -1;
		String sql = "SELECT SUM(counter_num) sum FROM counter";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			System.out.println("stmt --- " + stmt);
			
			rs = stmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt("sum");
				System.out.println("result --- " + result);
			}
			
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		
		return result;
	}
	
	
	// 오늘 접속자 수
	public int selectTodayCount(Connection conn) throws SQLException {
		System.out.println("\n----------- CounterDao.selectTodayCount()");
		
		int result = -1;
		String sql = "SELECT counter_num FROM counter WHERE counter_date = CURDATE()";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			System.out.println("stmt --- " + stmt);
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt("counter_num");
				System.out.println("result --- " + result);
			}
			
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		
		return result;
	}
}
