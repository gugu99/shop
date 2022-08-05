package service;

import java.sql.Connection;
import java.sql.SQLException;

import repository.EmployeeDao;
import repository.OutIdDao;
import vo.Employee;

public class EmployeeService {
	
	private DBUtil dbUtil;
	private EmployeeDao employeeDao;
	private OutIdDao outIdDao;
	
	// addEmployeeAction.jsp에서 호출(회원가입)
	public boolean addEmployee(Employee paramEmployee) {
		
		Connection conn = null;
		dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false); // executeUpdate();실행시 자동 커밋을 막는다.
			
			employeeDao = new EmployeeDao();
			if (employeeDao.insertEmployee(conn, paramEmployee) != 1) {
				throw new Exception(); // 강제 예외처리
			}
			
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		return true;
	}
	
	// 회원탈퇴 액션페이지에서 호출되는 메서드
	public boolean removeEmployee(Employee paramEmployee) {
		
		Connection conn = null;
		dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false); // executeUpdate();실행시 자동 커밋을 막는다.
			
			employeeDao = new EmployeeDao();
			if (employeeDao.deleteEmployee(conn, paramEmployee) != 1) {
				throw new Exception(); // 강제 예외처리
			}
			
			outIdDao = new OutIdDao();
			if (outIdDao.insertOutId(conn, paramEmployee.getEmployeeId()) != 1) {
				throw new Exception(); // 강제 예외처리
			}
			
			conn.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			return false; // executeUpdate() 실패하면 false리턴
		} finally {
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		return true;
	}
	
	// loginAction.jsp가 호출
	public Employee getEmployeeByIdAndPw(Employee paramEmployee) {
		Connection conn = null;
		dbUtil = new DBUtil();
		Employee employee = null;
		
		try {
			conn = dbUtil.getConnection();
			
			employeeDao = new EmployeeDao();
			employee = employeeDao.selectEmployeeByIdAndPw(conn, paramEmployee);
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		return employee;
	}
}
