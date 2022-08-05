package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import service.DBUtil;
import vo.Employee;

public class EmployeeDao {
	
	// 회원가입
	public int insertEmployee(Connection conn, Employee paramEmployee) throws SQLException {
		System.out.println("\n--------------------Employee.insertEmployee()");
		
		int result = 0;
		String sql = "INSERT INTO employee VALUES (?,PASSWORD(?),?, NOW(), NOW(), DEFAULT)";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramEmployee.getEmployeeId());
			stmt.setString(2, paramEmployee.getEmployeePass());
			stmt.setString(3, paramEmployee.getEmployeeName());
			
			System.out.println("stmt --- " + stmt); // 디버깅
			System.out.println("paramEmployee --- " + paramEmployee); // 디버깅
			
			result = stmt.executeUpdate();
			
			System.out.println("result --- " + result); // 디버깅
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		
		return result;
	}
	
	// 탈퇴
	// CustomerService.removeCustomer(Customer customer) 호출
	public int deleteEmployee(Connection conn, Employee paramEmployee) throws SQLException {
		System.out.println("\n--------------------Employee.deleteEmployee()");
		// 동일한 conn
		// conn.close() X
		int result = 0;
		String sql = "DELETE FROM employee WHERE employee_id = ? AND employee_pass = PASSWORD(?)";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramEmployee.getEmployeeId());
			stmt.setString(2, paramEmployee.getEmployeePass());
			
			System.out.println("stmt --- " + stmt); // 디버깅
			System.out.println("paramEmployee --- " + paramEmployee); // 디버깅
			
			result = stmt.executeUpdate();
			
			System.out.println("result --- " + result); // 디버깅
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return result;
	}

	// CutomerService.getEmployeeByIdAndPw(Employee paramEmployee)가 호출
	public Employee selectEmployeeByIdAndPw(Connection conn ,Employee paramEmployee) throws SQLException {
		System.out.println("\n--------------------Employee.selectEmployeeByIdAndPw()");
		
		Employee employee = null;
		String sql = "SELECT employee_name employeeName, active FROM employee WHERE employee_id = ? AND employee_pass = PASSWORD(?)";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramEmployee.getEmployeeId());
			stmt.setString(2, paramEmployee.getEmployeePass());
			
			System.out.println("stmt --- " + stmt); // 디버깅
			System.out.println("paramEmployee --- " + paramEmployee); // 디버깅
			
			rs = stmt.executeQuery();
			
			if (rs.next()) {
				employee = new Employee();
				employee.setEmployeeId(paramEmployee.getEmployeeId());
				employee.setEmployeeName(rs.getString("employeeName"));
				employee.setActive(rs.getString("active"));
				
				System.out.println("employee --- " + employee); // 디버깅
			}
		} finally {
			if(rs != null) {rs.close();}
			if(stmt != null) {stmt.close();}
		}
		
		return employee;
	}
}
