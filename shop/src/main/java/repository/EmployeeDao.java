package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.spi.DirStateFactory.Result;

import util.DBUtil;
import vo.Employee;

public class EmployeeDao {
	
	// 직원 권한 수정하기
	public int updateEmployeeActive(Connection conn, Employee paramEmployee) throws SQLException {
		System.out.println("\n--------------------EmployeeDao.updateEmployeeActive()");
		
		int result = 0;
		String sql = "UPDATE employee SET active = ?, update_date = NOW() WHERE employee_id = ?";
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramEmployee.getActive());
			stmt.setString(2, paramEmployee.getEmployeeId());
			
			System.out.println("stmt --- " + stmt); // 디버깅
			
			result = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		
		return result;
	}
	
	// 직원 리스트 count(*) 구하기
	public int selectEmployeeCount(Connection conn) throws SQLException {
		System.out.println("\n--------------------EmployeeDao.selectEmployeeCount()");
		
		int cnt = 0;
		String sql = "SELECT COUNT(*) cnt FROM employee";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			
			System.out.println("stmt --- " + stmt); // 디버깅
			
			rs = stmt.executeQuery();
			
			if (rs.next()) {
				cnt = rs.getInt("cnt");
			}
		} finally {
			if(rs != null) {
				rs.close();
				}
			if (stmt != null) {
				stmt.close();
			}
		}
		
		return cnt;
	}
	
	// 직원 리스트
	public List<Employee> selectEmployeeList(Connection conn, int rowPerPage, int beginRow) throws SQLException {
		System.out.println("\n--------------------EmployeeDao.selectEmployeeList()");
		
		List<Employee> list = new ArrayList<Employee>();
		Employee employee = null;
		String sql = "SELECT employee_id employeeId, employee_name employeeName, create_date createDate, update_date updateDate, active FROM employee LIMIT ?,?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			
			System.out.println("stmt --- " + stmt); // 디버깅
			
			rs = stmt.executeQuery();
			
			while (rs.next()) {
				employee = new Employee();
				employee.setEmployeeId(rs.getString("employeeId"));
				employee.setEmployeeName(rs.getString("employeeName"));
				employee.setCreateDate(rs.getString("createDate"));
				employee.setUpdateDate(rs.getString("updateDate"));
				employee.setActive(rs.getString("active"));
				
				list.add(employee);
			}
			
		} finally {
			if(rs != null) {
				rs.close();
				}
			if (stmt != null) {
				stmt.close();
			}
		}
		
		return list;
	}
	
	// 회원가입
	public int insertEmployee(Connection conn, Employee paramEmployee) throws SQLException {
		System.out.println("\n--------------------EmployeeDao.insertEmployee()");
		
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
		System.out.println("\n--------------------EmployeeDao.deleteEmployee()");
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
		System.out.println("\n--------------------EmployeeDao.selectEmployeeByIdAndPw()");
		
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
