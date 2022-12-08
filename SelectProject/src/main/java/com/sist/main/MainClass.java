package com.sist.main;

import java.util.*;
import com.sist.dao.*;

public class MainClass {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		// 오라클 연결
		EmpDAO dao =EmpDAO.newInstance(); // 싱글턴 객체 생성할때 사용
		ArrayList<EmpVO> list = dao.empListData();
		for(EmpVO vo : list) {
			System.out.println(vo.getEmpno() + " "
					+ vo.getEname() + " "
					+ vo.getJob() + " "
					+ vo.getHiredate().toString() + " "
					+ vo.getSal() + " "
					+ vo.getDvo().getDname() + " "
					+ vo.getDvo().getLoc() + " "
					+ vo.getSvo().getGrade());
		}
		
	}

}
