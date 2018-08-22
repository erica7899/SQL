package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


/**
 * Connection 관리 클래스
 * hr/hr계정
 */
public class EmpUtil2 {
	
	public static Connection getConnection(){
		
		//connection을 만들기 위해 필요한 정보
		String driver = "oracle.jdbc.OracleDriver";
		String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
		String user = "hr";
		String pw = "hr";

		Connection con = null;

		try {
			Class.forName(driver);//드라이브 로딩

			con=DriverManager.getConnection(url,user,pw);
		}catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println(e.getMessage());
		}
		catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			System.out.println(e.getMessage());
		}

		return con;
	}//connection을 만들어서 리턴.

	public static void close(ResultSet rs, Statement st,Connection con) {//반납해야 하는 자원을 넘겨주면 반납을 해주는 메소드
		try {
			if(rs!=null) rs.close();
			if(st!=null) st.close();
			if(con!=null) con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println(e.getMessage());
		}///statement는 PreparedStatement의 부모이기 때문에 PreparedStatement의 반납도 할 수 있다.

	}
}
