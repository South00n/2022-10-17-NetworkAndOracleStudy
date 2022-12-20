package com.sist.dao;

import java.util.*;
import java.sql.*;

public class FoodDAO {
	// 연결 객체
		private Connection conn;
		// SQL문장 전송, 결과값 읽기
		private PreparedStatement ps;
		// 오라클 주소, 유저명, 비밀번호, 드라이버명 ==> final ==> xml, properties => WEB-INF
		// ==================================> 경로 ( \\ , / )
		private final String URL = "jdbc:oracle:thin:@localhost:1521:XE";
		private final String DRIVER = "oracle.jdbc.driver.OracleDriver";
		private final String USER = "hr";
		private final String PWD = "happy";
		
		// 드라이버 등록
		public FoodDAO() {
			// 한번만 등록이 가능 => 객체 생성시 한번만 호출 : 자동로그인, ID저장
			try {
				// 등록 => Class.forName(), Properties이용
				Class.forName(DRIVER); // DriverManager => 메모리를 할당
				// 패키지명.클래스명을 등록 => 메모리 할당을 요청
				// => MyBatis, Spring, Spring-Boot : 클래스 관리자 => 등록 => 싱글턴
				// 스프링 => new 사용하지 않는다 => 메모리 할당 => 어노테이션
				/*
				 * 	@Repository - DAO를 저장해달라
				 * 	class A
				 * 	
				 * 	class B {
				 * 		@Autowired
				 * 		A a;
				 *  }
				 */
			} catch (Exception e) {}
		}
		// 오라클 연결 ==> DBCP ==> ORM
		public void getConnection() {
			try {
				conn = DriverManager.getConnection(URL, USER, PWD);
			} catch (Exception e) {}
		}
		// 오라클 닫기
		public void disConnection() {
			try {
				if(ps != null) ps.close();
				if(conn != null) conn.close();
			} catch (Exception e) {}
		}
		// 기능
		// 1. 목록 출력 ==> inlineview, index
		public ArrayList<FoodVO> foodListData(int page) {
			ArrayList<FoodVO> list = new ArrayList<FoodVO>();
			
			try {
				getConnection();
				String sql = "SELECT fno, name, poster, score, num "
						+ "FROM (SELECT fno, name, poster, score, rownum as num "
						+ "FROM (SELECT /*+ INDEX_ASC(food_location pk_food_location)*/fno, name, poster, score "
						+ "FROM food_location)) "
						+ "WHERE num BETWEEN ? AND ?";
				ps = conn.prepareStatement(sql);
				int rowSize = 20;
				int start = (rowSize * page) - (rowSize - 1); // rownum = 시작번호 1
				int end = rowSize * page;
				/*
				 *   1page가 들어오면  1 ~ 20 ==> start = 1, end = 20
				 *   2page가 들어오면 21 ~ 40 ==> start = 21, end = 40
				 *   3page가 들어오면 41 ~ 60
				 */
				ps.setInt(1, start);
				ps.setInt(2, end);
				
				ResultSet rs = ps.executeQuery();
				while(rs.next()) {
					FoodVO vo = new FoodVO();
					vo.setFno(rs.getInt(1));
					vo.setName(rs.getString(2));
					vo.setPoster(rs.getString(3));
					vo.setScore(rs.getDouble(4));
					// vo는 맛집정보를 가지고 있다 (한개)
					list.add(vo); // list안에 맛집정보 20개 추가
				}
				rs.close();
								
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				disConnection();
			}
			
			
			return list;
		}
}













