package com.sist.server;
import java.io.*;
import java.net.*;
import java.util.*;
/*
 * 	  class ChatServer {
 * 		  Client의 정보 저장 ==> IP, PORT
 * 		  ------------------------------ 접속시마다 저장 (담당)
 * 
 * 		  ------------------------------
 * 		  class Client extends Thread {  ==> 접속마다 통신을 담당하는 쓰레드
 * 	  	  	   통신만 담당 ==> 내부 클래스
 * 		  }
 * 		  ------------------------------
 * 	  }
 * 	  내부 클래스 : 쓰레드, 네트워크 => 공유하는 데이터가 많다 ==> 멤버 클래스를 이용해서 공유
 * 	    = 멤버클래스
 * 		  class A {
 * 			  class B {
 * 				 A가 가지고있는 모든 데이터를 공유할 목적
 * 			  }
 * 		  }
 * 		= 익명의 클래스 : 상속없이 오버라이딩을 할때 사용
 */
// 접속시에 클라이언트 정보 저장 ==> 교환 소켓
public class ChatServer {
	// 클라이언트 정보 저장
	private Vector<Client> waitVc = new Vector<Client>();
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
	}
	// 통신 => 사용자 요청 받기, 사용자 요청처리후에 응답 ==> 통신 소켓 ==> 접속마다 생성해야 된다 => 접속자마다 따로 통신을 수행
	class Client extends Thread {
		
	}

}
