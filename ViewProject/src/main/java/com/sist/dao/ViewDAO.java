package com.sist.dao;

import java.util.*;
import java.sql.*;

public class ViewDAO {
	private Connection conn;
	private PreparedStatement ps;
	private final String URL = "jdbc:oracle:thin:@localhost:1521:XE";
	
	// Driver 등록 => Propertise => Class.forName()
	public ViewDAO() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (Exception e) {}
	}
	
	// 연결
	public void getConnection() {
		try {
			conn = DriverManager.getConnection(URL, "hr", "happy");
		} catch (Exception e) {}
	}
	
	// 연결해제
	public void disConnection() {
		try {
			if (ps != null) ps.close();
			if (conn != null) conn.close();
		} catch (Exception e) {}
	}
	
	// 기능
	// 전체목록 ==> 테이블 4개 연결
	public void empListData() {
		try {
			// 1. 연결
			getConnection();
			// 2. SQL문장 제작
			String sql = "SELECT e1.empno, e1.ename, e2.ename as manager, e1.job, e1.hiredate, e1.sal, e1.comm, dname, loc, grade "
					+ "FROM emp e1 JOIN dept "
					+ "ON e1.deptno = dept.deptno "
					+ "JOIN salgrade "
					+ "ON e1.sal BETWEEN losal AND hisal "
					+ "LEFT OUTER JOIN emp e2 "
					+ "ON e1.mgr = e2.empno";
			// 3. SQL문장 전송
			ps = conn.prepareStatement(sql);
			// 4. 실행후에 데이터 저장
			ResultSet rs = ps.executeQuery();
			// 5. 저장된 데이터를 출력
			while (rs.next()) {
				System.out.println(
					rs.getInt(1) + " "
					+ rs.getString(2) + " "
					+ rs.getString(3) + " "
					+ rs.getString(4) + " "
					+ rs.getDate(5).toString() + " "
					+ rs.getInt(6) + " "
					+ rs.getInt(7) + " "
					+ rs.getString(8) + " "
					+ rs.getString(9) + " "
					+ rs.getInt(10)
				);
			
			}
			rs.close();
		} catch (Exception e) {
			// 오류확인
			e.printStackTrace();
		} finally {
			// 해제
			disConnection();
		}
	}
	// 상세보기
	public void empDetailData(int empno) {
		try {
			getConnection();
			String sql = "SELECT e1.empno, e1.ename, e2.ename as manager, e1.job, e1.hiredate, e1.sal, e1.comm, dname, loc, grade "
					+ "FROM emp e1 JOIN dept "
					+ "ON e1.deptno = dept.deptno "
					+ "JOIN salgrade "
					+ "ON e1.sal BETWEEN losal AND hisal "
					+ "LEFT OUTER JOIN emp e2 "
					+ "ON e1.mgr = e2.empno "
					+ "WHERE e1.empno = " + empno;
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			rs.next();
			System.out.println(
					rs.getInt(1) + " "
					+ rs.getString(2) + " "
					+ rs.getString(3) + " "
					+ rs.getString(4) + " "
					+ rs.getDate(5).toString() + " "
					+ rs.getInt(6) + " "
					+ rs.getInt(7) + " "
					+ rs.getString(8) + " "
					+ rs.getString(9) + " "
					+ rs.getInt(10)
				);
			rs.close();
			// row 한개 -> rs.next()
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disConnection();
		}
		
	}
	// View이용 => 전체목록
	public void viewListData() {
		try {
			// 1. 연결
			getConnection();
			// 2. SQL문장 제작
			String sql = "SELECT * FROM empDeptGrade_1";
			// 3. SQL문장 전송
			ps = conn.prepareStatement(sql);
			// 4. 실행후에 데이터 저장
			ResultSet rs = ps.executeQuery();
			// 5. 저장된 데이터를 출력
			while (rs.next()) {
				System.out.println(
					rs.getInt(1) + " "
					+ rs.getString(2) + " "
					+ rs.getString(3) + " "
					+ rs.getString(4) + " "
					+ rs.getDate(5).toString() + " "
					+ rs.getInt(6) + " "
					+ rs.getInt(7)
					+ rs.getString(8) + " "
					+ rs.getString(9) + " "
					+ rs.getInt(10)
				);
			
			}
			rs.close();
		} catch (Exception e) {
			// 오류확인
			e.printStackTrace();
		} finally {
			// 해제
			disConnection();
		}
	}
	// View이용 => 상세보기
	// 뷰 ==> 응용프로그램 제작시에 복잡한 SQL문장 => 단순하게 만들 수 있다
	public void viewDetailData(int empno) {
		try {
			getConnection();
			String sql = "SELECT * FROM empDeptGrade_1 "
					+ "WHERE empno = " + empno;
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			rs.next();
			System.out.println(
					rs.getInt(1) + " "
					+ rs.getString(2) + " "
					+ rs.getString(3) + " "
					+ rs.getString(4) + " "
					+ rs.getDate(5).toString() + " "
					+ rs.getInt(6) + " "
					+ rs.getInt(7) + " "
					+ rs.getString(8) + " "
					+ rs.getString(9) + " "
					+ rs.getInt(10)
				);
			rs.close();
			// row 한개 -> rs.next()
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disConnection();
		}
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ViewDAO dao = new ViewDAO();
		dao.empListData();
		System.out.println("=====================================");
		dao.viewListData();
		System.out.println("=====================================");
		dao.empDetailData(7788);
		System.out.println("=====================================");
		dao.viewDetailData(7788);
	}

}










