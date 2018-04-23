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
import javax.servlet.http.HttpSession;

/**
 *
 * @author bradley
 */
@WebServlet(urlPatterns = {"/comment"})
public class comment extends HttpServlet {

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

            java.sql.Connection conn;
            java.sql.ResultSet rs;
            java.sql.Statement st;

            try {
                
                Class.forName("com.mysql.jdbc.Driver");
            
            } catch (ClassNotFoundException ex) {
            
                RequestDispatcher rd = request.getRequestDispatcher("browse.jsp?err=1");
                    
                rd.forward(request,response);
            
            }
            
            try {
    
            conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost/comp6000", "comp6000", "comp6000");
            
            if(request.getParameter("post_id") != null) {
           
                HttpSession session = request.getSession();
                
                if(session.getAttribute("uid") == null) {
           
                    RequestDispatcher rd = request.getRequestDispatcher("login.jsp?c");
                    
                    rd.forward(request,response);
                    
                }
                
                String post_id = request.getParameter("post_id");
                String forum_id = request.getParameter("forum_id");
                String user_id = session.getAttribute("uid").toString();
                String body = request.getParameter("body");
                
                st = conn.createStatement();
                
                String query = "INSERT INTO comments (user_id, post_id, body) VALUES("+user_id+","+post_id+",'"+body+"');";

                st.executeUpdate(query);  
                
                response.sendRedirect("comment.jsp?post_id="+post_id+"&forum_id="+forum_id);
            
            }
            
            } catch (SQLException dbException) {

                String forum_id = request.getParameter("forum_id");
                
                RequestDispatcher rd = request.getRequestDispatcher("browse.jsp?err=2&forum_id="+forum_id);
                    
                rd.forward(request,response);

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
