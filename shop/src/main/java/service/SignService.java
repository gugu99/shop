package service;

import java.sql.Connection;
import java.sql.SQLException;

import repository.SignDao;
import util.DBUtil;

public class SignService {

	private SignDao signDao;
	private DBUtil dbUtil;
	
	// return
	// true : 시용가능한 아이디
	// false : 
	public boolean idCheck(String id) {
	
		boolean result = false;
		signDao = new SignDao(); // this 생략 가능
		dbUtil = new DBUtil();
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			if (signDao.idCheck(conn, id) == null) {
				result = true;
			}
			
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
		
		return result;
	}
}
