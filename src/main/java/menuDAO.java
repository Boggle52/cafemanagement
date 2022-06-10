import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class menuDAO {
	
	private Statement stmt;
	private Connection conn;
	
	public ArrayList<menuDTO> listMenu(){
		ArrayList<menuDTO> list = new ArrayList<menuDTO>();
		try {
			connDB();
			String query = "Select * from menu order by seqno";
			this.stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while(rs.next()) {
				int seqNo = rs.getInt("seqNo");
				String name = rs.getString("name");
				String price = rs.getString("price");
				menuDTO mdto = new menuDTO();
				mdto.setSeqNo(seqNo);
				mdto.setName(name);
				mdto.setPrice(price);
				list.add(mdto);
			}
			rs.close();
			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public void addnewMenu(menuDTO mDto) {
		try {
			connDB();
			String query = "insert into menu values(sq1.nextval,?,?)";
			PreparedStatement psmt = conn.prepareStatement(query);
			psmt.setString(1, mDto.getName());
			psmt.setString(2, mDto.getPrice());
			psmt.executeUpdate();
			psmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void addnewMenu_org(menuDTO mDto) {
		try {
			connDB();
			String query = "insert into menu_org values(sq2.nextval,?,?)";
			PreparedStatement psmt = conn.prepareStatement(query);
			psmt.setString(1, mDto.getName());
			psmt.setString(2, mDto.getPrice());
			psmt.executeUpdate();
			psmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void deleteMenu(int seqNo) {
		try {
			connDB();
			String query = "delete from menu where seqno=?";
			PreparedStatement psmt = conn.prepareStatement(query);
			psmt.setInt(1, seqNo);
			psmt.executeUpdate();
			psmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void updateMenu(menuDTO mDto) {
		try {
			connDB();
			String query = "update menu set seqno=menu_seq.nextval, name=?, price=? where seqno=?";
			PreparedStatement psmt = conn.prepareStatement(query);
			psmt.setString(1, mDto.getName());
			psmt.setString(2, mDto.getPrice());
			psmt.setInt(3, mDto.getSeqNo());
			psmt.executeUpdate();
			psmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void updateMenu2(menuDTO mDto) {
		try {
			connDB();
			String query = "insert into menu_org values(menu_org_seq.nextval,?,?)";
			PreparedStatement psmt = conn.prepareStatement(query);
			psmt.setString(1, mDto.getName());
			psmt.setString(2, mDto.getPrice());
			psmt.executeUpdate();
			psmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private void connDB() {
		String driver="oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:orcl";
		String userid="ora_user";
		String passcode="human123";
		try {
			Class.forName(driver);
			this.conn=DriverManager.getConnection(url,userid,passcode);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
