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
@WebServlet(urlPatterns = {"/vote"})
public class vote extends HttpServlet {

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
        
        response.setContentType("text/html;charset=UTF-8");
        
        String referer = request.getHeader("Referer");
        
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
           
                String post_id = request.getParameter("post_id");
                String count = request.getParameter("count");
                st = conn.createStatement();

                String query = "UPDATE posts SET vote_count = vote_count + " + count + " WHERE id = " + post_id;
           
                st.executeUpdate(query);  
                
                String dest = referer.substring(referer.lastIndexOf("/") + 1, referer.length());
                
                response.sendRedirect(dest);
            
            }
            
            } catch (SQLException dbException) {

                RequestDispatcher rd = request.getRequestDispatcher("browse.jsp?err=2");
                    
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
