import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class incomeDAO {
	
	private Statement stmt;
	private Connection conn;
	
	public void addTotal(incomeDTO iDto) {
		try {
			connDB();
			String query = "insert into income values(order_seq.nextval,?,?,?,?,to_char(sysdate,'yyyy-mm-dd hh:mi:ss'))";
			PreparedStatement psmt = conn.prepareStatement(query);
			psmt.setString(1, iDto.getMobile());
			psmt.setInt(2, iDto.getSeqno());
			psmt.setString(3, iDto.getQty());
			psmt.setString(4, iDto.getPrice());
			psmt.executeUpdate();
			psmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	int getSum() {
		int sum = 0;
		try {
			connDB();
			String query = "select sum(price) total from income";
			Statement stmt = conn.prepareStatement(query);
			ResultSet rs = stmt.executeQuery(query);
			sum = rs.getInt("total");
			rs.close();
			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sum;
	}
	
	public ArrayList<incomeDTO> listIncome(){
		ArrayList<incomeDTO> list = new ArrayList<incomeDTO>();
		try {
			connDB();
			String query = "select a.mobile, b.name, a.qty, a.price, a.income_date "
					+ "from income a, menu_org b where a.seqno=b.seqno order by order_no";
			this.stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while(rs.next()) {
				String mobile = rs.getString("mobile");
				String name = rs.getString("name");
				String qty = rs.getString("qty");
				String price = rs.getString("price");
				String income_date = rs.getString("income_date");
				incomeDTO iDto = new incomeDTO();
				iDto.setMobile(mobile);
				iDto.setName(name);
				iDto.setQty(qty);
				iDto.setPrice(price);
				iDto.setIncome_date(income_date);
				list.add(iDto);
			}
			rs.close();
			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
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
