
import java.sql.*;
import javax.sql.*;

import java.io.*;
import javax.naming.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/Delete")
public class Delete extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private DataSource dataSource;
    private Connection connection;
    private PreparedStatement statement;

    public Delete() {
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
        
        if(request.getParameter("record").length() <= 0) {
            response.sendRedirect("/contactbook/index.jsp");
        }
        
        String SQL = "DELETE FROM contact WHERE urlsafe=?";

        try {
            connection = dataSource.getConnection();
            statement = connection.prepareStatement(SQL);
            statement.setString(1, request.getParameter("record"));
            
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
