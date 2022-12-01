package com.sist.client;

import java.util.*; //StringTokenizer
import java.io.*; // OutputStream, BufferedReader
import java.net.*; // Socket
import javax.swing.*; // JFrame
import java.awt.*;
import java.awt.event.*;

public class ChatClient extends JFrame implements ActionListener{
	JTextArea ta;
	JTextField tf;
	JButton b1, b2;
	private String name;
	public ChatClient() {
		ta = new JTextArea();
		JScrollPane js = new JScrollPane(ta);
		ta.setEditable(false);
		tf = new JTextField(30);
		tf.setEnabled(false);
		b1 = new JButton("접속");
		b2 = new JButton("종료");
		
		JPanel p = new JPanel();
		p.add(tf);
		p.add(b1);
		p.add(b2);
		
		add("Center", js);
		add("South", p);
		setSize(520, 600);
		setVisible(true);
		
		b1.addActionListener(this);
		b2.addActionListener(this);  // CallBack => 시스템에 의해서 자동호출 (자바스크립트)
		tf.addActionListener(this); // enter
		// CallBack => 대표적인 메소드
		// button => 클릭, mouseClick
	}
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		new ChatClient();
	}
	@Override
	public void actionPerformed(ActionEvent e) {
		// TODO Auto-generated method stub
		if(e.getSource() == b1) {
			name = JOptionPane.showInputDialog("이름 입력 : ");
			// 서버연결
			b1.setEnabled(false);
			tf.setEnabled(true);
			tf.requestFocus();
		}
		if(e.getSource() == b2) {
			dispose(); // 윈도우 메모리 회수
			System.exit(0); // 시스템 종료
		}
		if(e.getSource() == tf) {
			String msg = tf.getText();
			if(msg.trim().length() < 1) { //입력이 안된 상태
				return;
			}
			// 입력값을 서버로 전송
			ta.append(msg + "\n");
			tf.setText("");
		}
	}

}
