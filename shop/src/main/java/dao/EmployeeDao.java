package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import vo.Employee;

public class EmployeeDao {

	// 로그인
	public Employee login(Employee employee) throws ClassNotFoundException, SQLException {
		System.out.println("\n--------------------Employee.login()");
		
		Employee loginEmployee = null;
		String sql = "SELECT employee_name employeeName FROM employee WHERE employee_id = ? AND employee_pass = PASSWORD(?)";
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, employee.getEmployeeId());
			stmt.setString(2, employee.getEmployeePass());
			
			System.out.println("stmt --- " + stmt); // 디버깅
			System.out.println("employee --- " + employee); // 디버깅
			
			rs = stmt.executeQuery();
			
			if (rs.next()) {
				loginEmployee = new Employee();
				loginEmployee.setEmployeeId(employee.getEmployeeId());
				loginEmployee.setEmployeeName(rs.getString("employeeName"));
			}
		} finally {
			if(rs != null) {rs.close();}
			if(stmt != null) {stmt.close();}
			if(conn != null) {conn.close();}
		}
		
		return loginEmployee;
	}
}
