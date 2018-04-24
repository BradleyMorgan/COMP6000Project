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

            String query = "SELECT comments.comment_id, body, username, v1.vote_count, DATE_FORMAT(comments.timestamp, '%b. %D at %H:%i') as formatted_date FROM comments JOIN users ON comments.user_id = users.id LEFT JOIN (SELECT MAX(comment_id) as comment_id, SUM(vote) as vote_count FROM comment_votes GROUP BY(comment_id)) v1 ON comments.comment_id = v1.comment_id WHERE comments.post_id="+post_id+";";

            rs = st.executeQuery(query);
            
            if (!rs.next()) {

                out.println("<h3>No Comments for this Post</h3>");

            } else {

                rs.beforeFirst();

                while(rs.next()) {
                    
                    out.println("<div class='comment_wrapper'>");
                    
                    String up_arrow = "<a href='vote?post_id="+post_id+"&comment_id=" + rs.getString(1) + "&forum_id="+forum_id+"&count=1'>&#x25B2;</a>";
                    String down_arrow = "<a href='vote?post_id="+post_id+"&comment_id=" + rs.getString(1) + "&forum_id="+forum_id+"&count=-1'>&#x25BC;</a>";

                    if(request.getSession().getAttribute("uid") != null) {

                        String v_query = "SELECT count(*), vote FROM comment_votes WHERE user_id = " + request.getSession().getAttribute("uid").toString() + " AND comment_id = " + rs.getString(1) + ";";

                        vst = conn.createStatement();
                        vrs = vst.executeQuery(v_query);

                        if(vrs.next()) {

                           if(vrs.getInt(1) > 0) {

                                if(vrs.getInt(2) == 1) {
                                   up_arrow = "<span class='selected_arrow'>&#x25B2</span>";
                                   down_arrow = "<a href='vote?post_id="+post_id+"&comment_id=" + rs.getString(1)+"&forum_id="+forum_id + "&count=-1&update=1'>&#x25BC;</a>";
                                }

                                if(vrs.getInt(2) == -1) {
                                    up_arrow = "<a href='vote?post_id="+post_id+"&comment_id=" + rs.getString(1)+"&forum_id="+forum_id + "&count=1&update=1'>&#x25B2;</a>";
                                    down_arrow = "<span class='selected_arrow'>&#x25BC;</span>";
                                }

                                if(vrs.getInt(2) == 0) {
                                    up_arrow = "<a href='vote?post_id="+post_id+"&comment_id=" + rs.getString(1)+"&forum_id="+forum_id + "&count=1&update=1'>&#x25B2;</a>";
                                    down_arrow = "<a href='vote?post_id="+post_id+"&comment_id=" + rs.getString(1)+"&forum_id="+forum_id + "&count=-1&update=1'>&#x25BC;</a>";
                                }

                                out.println("<div class='vote_wrapper'>");
                                out.println("<div class='vote_arrow'>" + up_arrow + "<br />" + rs.getInt(4) + "<br />" + down_arrow + "</div>");
                                out.println("</div>");
                                
                           } else {

                                out.println("<div class='vote_wrapper'>");
                                out.println("<div class='vote_arrow'>" + up_arrow + "<br />" + rs.getInt(4) + "<br />" + down_arrow + "</div>");
                                out.println("</div>");
                           }

                        } else {

                            out.println("<div class='vote_wrapper'>");
                            out.println("<div class='vote_arrow'>" + up_arrow + "<br />" + rs.getInt(4) + "<br />" + down_arrow + "</div>");
                            out.println("</div>");

                        }

                    } else {

                        out.println("<div class='vote_wrapper'>");
                        out.println("<div class='vote_arrow'>&#x25B2;<br />"+rs.getInt(4)+"<br />&#x25BC;</div>");
                        out.println("</div>");
                        
                    }
                    
                    java.text.DateFormat df = new java.text.SimpleDateFormat("dd/MM/yyyy");

                    out.println("<div class='comment_header'>Comment by "+ rs.getString(3) + " on " + rs.getString(3) + "</div>");
                    out.println("<div class='comment_body'>" + rs.getString(2) + "</div>");
                    
                    out.println("</div>");

                }

            }

            
            out.println("<br /><hr /><a class='primary' href='browse.jsp?forum_id="+forum_id+"'>Back to Post</a>");

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
