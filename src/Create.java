
import java.sql.*;
import javax.sql.*;

import java.io.*;
import javax.naming.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/Create")
public class Create extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private DataSource dataSource;
    private Connection connection;
    private PreparedStatement statement;

    public Create() {
        super();
    }

    @Override
    public void init(ServletConfig config) 
        throws ServletException {
        
        super.init(config);
        try{
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:/comp/env");
            dataSource = (DataSource) envContext.lookup("jdbc/contactbook");
        } catch (NamingException e) {

        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    	
        String SQL = "INSERT INTO contact (name, phone, email, urlsafe) VALUES (?, ?, ?, md5(?))";
        String recordID = request.getParameter("recordID");
        if(recordID.length() > 0) {
        	SQL = "UPDATE contact SET name=?, phone=?, email=?, urlsafe=md5(?) WHERE urlsafe=?";
        }
        try {
            connection = dataSource.getConnection();
            statement = connection.prepareStatement(SQL);
            statement.setString(1, request.getParameter("name"));
            statement.setString(2, request.getParameter("phone"));
            statement.setString(3, request.getParameter("email"));
            statement.setString(4, request.getParameter("email"));
            
            if(recordID.length() > 0) {
            	statement.setString(5, recordID);
            }
            statement.execute();
        } catch (SQLException e) {
            
        }
        response.sendRedirect("/contactbook/index.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {

        doGet(request, response);
    }

}
