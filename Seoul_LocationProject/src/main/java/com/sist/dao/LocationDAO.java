package com.sist.dao;
// 오라클 연결
import java.util.*; // ArrayList ==> 데이터 묶어준다
import java.sql.*; // 오라클 연결 => 송수신
/*
 * 		LocationVO
 * 		-----------------------------------
 * 			=====> 오라클에 저장 (한개 명소에 대한 저장) ==> new LocationVO()
 * 		-----------------------------------
 * 			=====> 오라클에 저장 (한개 명소에 대한 저장) ==> new LocationVO()
 * 		-----------------------------------
 * 			=====> 오라클에 저장 (한개 명소에 대한 저장) ==> new LocationVO()  --> ArrayList로 처리
 * 		-----------------------------------
 * 			
 * 
 */
// 286page 데이터베이스 연결
public class LocationDAO {
	// 데이터베이스 연결 객체
	private Connection conn;
	// 데이터베이스 송수신이 가능
	private PreparedStatement ps;
	// SQL문장 전송, 데이터 받기
	private final String URL = "jdbc:oracle:thin:@localhost:1521:XE";
	// 드라이버 등록
	public LocationDAO() {
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
	// 닫기
	public void disConnection() {
		try {
			if (ps != null) ps.close();
			if (conn != null) conn.close();
		} catch (Exception e) {}
	}
	// ----------------------------------------- 모든 DAO동일
	// 기능 (SQL문장)
	public ArrayList<LocationVO> locationListData() {
		ArrayList<LocationVO> list = new ArrayList<LocationVO>();
		try {
			// 1. 연결
			getConnection();
			// 2. SQL문장
			String sql = "SELECT no, title, poster, msg "
						+ "FROM seoul_location "
						+ "WHERE no BETWEEN 1 AND 20"; // **한 화면에 20개 출력**
			// 3. 오라클 전송 ======================
			ps = conn.prepareStatement(sql);
			// 4. 결과값 읽기
			ResultSet rs = ps.executeQuery(); // rs에 결과값이 저장됨
			// 5. 결과값을 ArrayList에 담는다 ==> 브라우저에서 읽어서 출력
			while (rs.next()) {
				LocationVO vo = new LocationVO();
				vo.setNo(rs.getInt(1));
				vo.setTitle(rs.getString(2));
				vo.setPoster(rs.getString(3));
				vo.setMsg(rs.getString(4));
				list.add(vo); // 추출된 데이터를 모아둔다
			}
			rs.close();
			// ======================================= > 오라클 문법적용
		} catch (Exception e) {
			// 오류 확인
			e.printStackTrace();
		} finally {
			// 닫기
			disConnection();
		}
		
		return list;
	}
	
	
}
