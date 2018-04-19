/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.*;
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
 
            String context = this.getServletContext().getRealPath("/");
            String strPath = context + "./xml/users.xml";
            File strFile = new File(strPath);
            boolean fileCreated = strFile.createNewFile();
                
            Writer objWriter = new BufferedWriter(new FileWriter(strFile));
            objWriter.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
            objWriter.write("<users xmlns:t=\"http://creddit.biz/users\">\n");
            
            //out.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
            //out.println("<u:users xmlns:t=\"http://creddit.biz/users\">");
            
            try {

              Class.forName("com.mysql.jdbc.Driver");

            } catch (ClassNotFoundException ex) {

                RequestDispatcher rd = request.getRequestDispatcher("report.jsp?err=1");
                    
                rd.forward(request,response);

            }
            
            try {
                
                conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost/comp6000", "comp6000", "comp6000");

                st = conn.createStatement();

                String query = "SELECT users.id, username, email, COALESCE(post_count, 0), COALESCE(upvote_count, 0), COALESCE(downvote_count, 0), timestamp FROM users " 
                        + "LEFT JOIN (SELECT user_id, COUNT(*) AS post_count FROM posts GROUP BY user_id) AS pc ON users.id = pc.user_id "
                        + "LEFT JOIN (SELECT user_id, COUNT(*) AS upvote_count FROM votes WHERE vote=1 GROUP BY user_id) AS upvotes ON users.id = upvotes.user_id "
                        + "LEFT JOIN (SELECT user_id, COUNT(*) AS downvote_count FROM votes WHERE vote=-1 GROUP BY user_id) AS downvotes ON users.id = downvotes.user_id";                   

                rs = st.executeQuery(query);

                while(rs.next()) {

                    objWriter.write("\t<user id='"+rs.getString(1)+"'>\n");
                    objWriter.write("\t\t<username>"+rs.getString(2)+"</username>\n");
                    objWriter.write("\t\t<email>"+rs.getString(3)+"</email>\n");
                    objWriter.write("\t\t<postcount>"+rs.getString(4)+"</postcount>\n");
                    objWriter.write("\t\t<upvotes>"+rs.getString(5)+"</upvotes>\n");
                    objWriter.write("\t\t<downvotes>"+rs.getString(6)+"</downvotes>\n");
                    objWriter.write("\t\t<ctime>"+rs.getString(7)+"</ctime>\n");
                    objWriter.write("\t</user>\n");

                }
            
            } catch (SQLException dbException) {

                String forum_id = request.getParameter("forum_id");
                
                RequestDispatcher rd = request.getRequestDispatcher("browse.jsp?err=2&forum_id="+forum_id);
                    
                rd.forward(request,response);

            }
            
            objWriter.write("</users>");
        
            objWriter.flush();
            objWriter.close();
            
            response.sendRedirect("report.jsp?complete=1");
            
        
        } catch(Exception ex) {
            
            System.out.println("Error: " + ex.getLocalizedMessage());
            
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
