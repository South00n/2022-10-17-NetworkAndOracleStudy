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
	// 해제
	// 기능 => 목록출력 SELECT column_list
	// 	   => 상세보기 SELECT *
	
}
