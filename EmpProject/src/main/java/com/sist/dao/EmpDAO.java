package com.sist.dao;
// 오라클 연결
import java.util.*;
import java.sql.*;

public class EmpDAO {
	private Connection conn; // 오라클 연결
	private PreparedStatement ps; // SQL문장을 전송하고 결과값을 받는다
	private final String URL = "jdbc:oracle:thin:@localhost:1521:XE"; // 오라클 주소 (thin => 연결만)
	// 드라이버 등록
	public EmpDAO() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (Exception e) {}
	}
	// 연결
	public void getConnection() {
		try {
			conn = DriverManager.getConnection(URL, "hr", "happy");
			// conn hr/happy
		} catch (Exception e) {}
	}
	// 해제
	public void disConnection() {
		try {
			if(ps != null) ps.close(); // OutputStream, BufferedReader
			if(conn != null) conn.close(); // Socket
		} catch (Exception e) {}
	}
	// 기능 => 목록출력 SELECT column_list
	public ArrayList<EmpVO> empListData() {
		ArrayList<EmpVO> list = new ArrayList<EmpVO>();
		try {
			// 1. 오라클 연결
			getConnection();
			// 2. SQL문장 제작
			String sql = "SELECT empno, ename, job, hiredate, deptno "
					   + "FROM emp";
			// 3. SQL문장을 전송
			ps = conn.prepareStatement(sql);
			// 4. 실행 결과를 받는다
			ResultSet rs = ps.executeQuery();
			// 5. 결과값을 ArrayList에 담아준다
			while (rs.next()) { // 데이터 출력 맨 윗줄에 커서를 이동
				EmpVO vo = new EmpVO();
				vo.setEmpno(rs.getInt(1));
				vo.setEname(rs.getString(2));
				vo.setJob(rs.getString(3));
				vo.setHiredate(rs.getDate(4));
				vo.setDeptno(rs.getInt(5));
				list.add(vo);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace(); // 오류 출력
		} finally {
			disConnection(); // 오라클 닫기
		}
		return list;
	}
	// 	   => 상세보기 SELECT *
	
}
