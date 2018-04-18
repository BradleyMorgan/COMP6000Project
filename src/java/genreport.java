/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;

/**
 *
 * @author bradley
 */
@WebServlet(urlPatterns = {"/genreport"})
public class genreport extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       
        java.sql.Connection conn;
        java.sql.ResultSet rs;
        java.sql.Statement st;
                
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
 
            out.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
            
            out.println("<u:users xmlns:t=\"http://creddit.biz/users\">");
            
            try {

              Class.forName("com.mysql.jdbc.Driver");

            } catch (ClassNotFoundException ex) {

                RequestDispatcher rd = request.getRequestDispatcher("report.jsp?err=1");
                    
                rd.forward(request,response);

            }
            
            try {
                
                conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost/comp6000", "comp6000", "comp6000");

                st = conn.createStatement();

                String query = "SELECT * FROM users, (SELECT user_id, COUNT(*) AS post_count FROM posts GROUP BY user_id) AS pc WHERE users.id = pc.user_id;";                    

                rs = st.executeQuery(query);

                while(rs.next()) {

                    out.println("\t<u:user id='"+rs.getString(1)+"'>");
                    out.println("\t\t<username>"+rs.getString(2)+"</username>");
                    out.println("\t\t<email>"+rs.getString(4)+"</username>");
                    out.println("\t\t<postcount>"+rs.getString(7)+"</username>");
                    out.println("\t\t<ctime>"+rs.getString(5)+"</username>");
                    out.println("\t</u:user>");

                }
            
            } catch (SQLException dbException) {

                String forum_id = request.getParameter("forum_id");
                
                RequestDispatcher rd = request.getRequestDispatcher("browse.jsp?err=2&forum_id="+forum_id);
                    
                rd.forward(request,response);

            }
            
            out.println("</u:users>");
            
        }
            
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
