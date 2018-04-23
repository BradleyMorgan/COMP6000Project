/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author bradley
 */
@WebServlet(urlPatterns = {"/commentOutput"})
public class commentOutput extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

                
        java.sql.Connection conn = null;
        java.sql.ResultSet rs = null;
        java.sql.ResultSet vrs;     
        java.sql.Statement st;
        java.sql.Statement vst;

        try (PrintWriter out = response.getWriter()) {
            
        try {
                
            Class.forName("com.mysql.jdbc.Driver");
            
        } catch (ClassNotFoundException ex) {
            
            RequestDispatcher rd = request.getRequestDispatcher("browse.jsp?err=1");
                    
            rd.forward(request,response);
            
        }

        try {

            conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost/comp6000", "comp6000", "comp6000");
            
            String forum_id = request.getParameter("forum_id");
            String post_id = request.getParameter("post_id");
            
            st = conn.createStatement();

            String query = "SELECT body, username, DATE_FORMAT(comments.timestamp, '%b. %D at %H:%i') as formatted_date FROM comments JOIN users ON comments.user_id = users.id WHERE post_id="+post_id+";";

            rs = st.executeQuery(query);
            
            if (!rs.next()) {

                out.println("<h3>No Comments for this Post</h3>");

            } else {

                rs.beforeFirst();

                while(rs.next()) {
                    
                    out.println("<div class='comment_wrapper'>");
                    
                    java.text.DateFormat df = new java.text.SimpleDateFormat("dd/MM/yyyy");

                    out.println("<div class='comment_header'>Comment by "+ rs.getString(2) + " on " + rs.getString(3) + "</div>");
                    out.println("<div class='comment_body'>" + rs.getString(1) + "</div>");
                    
                    out.println("</div>");

                }

            }

            out.println("<br /><a href='browse.jsp?forum_id="+forum_id+"'>Back to Post</a>");

        } catch (Exception dbException) {


        }
        
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
