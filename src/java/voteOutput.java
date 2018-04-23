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

@WebServlet(urlPatterns = {"/voteOutput"})
public class voteOutput extends HttpServlet {

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
        
        java.sql.Connection conn = null;
        java.sql.ResultSet rs = null;
        java.sql.ResultSet vrs;     
        java.sql.Statement st;
        java.sql.Statement vst;

        String forum_name = "";
        
        try {
                
            Class.forName("com.mysql.jdbc.Driver");
            
        } catch (ClassNotFoundException ex) {
            
            RequestDispatcher rd = request.getRequestDispatcher("browse.jsp?err=1");
                    
            rd.forward(request,response);
            
        }

        try {

            conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost/comp6000", "comp6000", "comp6000");
            
            String forum_id = request.getParameter("forum_id");

            st = conn.createStatement();
            
            String query = "SELECT name FROM forums WHERE id="+forum_id+";";

            rs = st.executeQuery(query);

            if(rs.next()) {

                forum_name = rs.getString(1);

            }

            query = "SELECT title, body, username, posts.id, v1.vote_count, DATE_FORMAT(posts.timestamp, '%b. %D at %H:%i') as formatted_date " +
                    "FROM forum_posts JOIN posts ON posts.id = forum_posts.post_id " +
                    "JOIN users ON users.id = posts.user_id " +
                    "LEFT JOIN (SELECT MAX(post_id) as post_id, SUM(vote) as vote_count FROM votes GROUP BY(post_id)) v1 " +
                    "ON forum_posts.post_id = v1.post_id " + 
                    "WHERE forum_posts.forum_id ="+forum_id+";";

            rs = st.executeQuery(query);
            
        } catch(SQLException dbException) {
            
            
            
        }
        
        response.setContentType("text/html;charset=UTF-8");
        
        
        try (PrintWriter out = response.getWriter()) {

            String forum_id = request.getParameter("forum_id");
            
            out.println("<h2>Posts in " + forum_name + "</h2><br />");
            
            if (!rs.next()) {

                out.println("<h3>No Posts in " + forum_name + "</h3>");

            } else {

                rs.beforeFirst();

                while(rs.next()) {
                    
                    out.println("<div class='entry_wrapper'>");
                    
                    String up_arrow = "<a href='vote?post_id=" + rs.getString(4)+"&forum_id="+forum_id+"&count=1'>&#x25B2;</a>";
                    String down_arrow = "<a href='vote?post_id=" + rs.getString(4)+"&forum_id="+forum_id+"&count=-1'>&#x25BC;</a>";

                    if(request.getSession().getAttribute("uid") != null) {

                        String v_query = "SELECT count(*), vote FROM votes WHERE user_id = " + request.getSession().getAttribute("uid").toString() + " AND post_id = " + rs.getString(4) + ";";

                        vst = conn.createStatement();
                        vrs = vst.executeQuery(v_query);

                        if(vrs.next()) {

                           if(vrs.getInt(1) > 0) {

                                if(vrs.getInt(2) == 1) {
                                   up_arrow = "<span class='selected_arrow'>&#x25B2</span>";
                                   down_arrow = "<a href='vote?post_id=" + rs.getString(4)+"&forum_id="+forum_id + "&count=-1&update=1'>&#x25BC;</a>";
                                }

                                if(vrs.getInt(2) == -1) {
                                    up_arrow = "<a href='vote?post_id=" + rs.getString(4)+"&forum_id="+forum_id + "&count=1&update=1'>&#x25B2;</a>";
                                    down_arrow = "<span class='selected_arrow'>&#x25BC;</span>";
                                }

                                if(vrs.getInt(2) == 0) {
                                    up_arrow = "<a href='vote?post_id=" + rs.getString(4)+"&forum_id="+forum_id + "&count=1&update=1'>&#x25B2;</a>";
                                    down_arrow = "<a href='vote?post_id=" + rs.getString(4)+"&forum_id="+forum_id + "&count=-1&update=1'>&#x25BC;</a>";
                                }

                                out.println("<div class='vote_wrapper'>");
                                out.println("<div class='vote_arrow'>" + up_arrow + "<br />" + rs.getInt(5) + "<br />" + down_arrow + "</div>");
                                out.println("</div>");
                                
                           } else {

                                out.println("<div class='vote_wrapper'>");
                                out.println("<div class='vote_arrow'>" + up_arrow + "<br />" + rs.getInt(5) + "<br />" + down_arrow + "</div>");
                                out.println("</div>");
                           }

                        } else {

                            out.println("<div class='vote_wrapper'>");
                            out.println("<div class='vote_arrow'>" + up_arrow + "<br />" + rs.getInt(5) + "<br />" + down_arrow + "</div>");
                            out.println("</div>");

                        }

                    } else {

                        out.println("<div class='vote_wrapper'>");
                        out.println("<div class='vote_arrow'>&#x25B2;<br />"+rs.getInt(5)+"<br />&#x25BC;</div>");
                        out.println("</div>");


                    }
                    
                    java.text.DateFormat df = new java.text.SimpleDateFormat("dd/MM/yyyy");

                    out.println("<div class='post_wrapper'><b>" + rs.getString(1)+"</b><br />Posted by "+ rs.getString(3) + " on " + rs.getString(6) + "<br />" + rs.getString(2) + "</div>");
                    out.println("<a href='comment.jsp?post_id="+rs.getString(4)+"&forum_id="+forum_id+"'>Comments</a>");
                    out.println("</div>");

                }

            }

            out.println("<div style='clear: left;'><a href='post.jsp?forum_id="+forum_id+"'>Post</a></div>");

        } catch (Exception dbException) {


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
