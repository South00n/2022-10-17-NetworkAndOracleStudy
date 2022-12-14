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
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ViewDAO dao = new ViewDAO();
		dao.empListData();
		System.out.println("=====================================");
		dao.viewListData();
	}

}










