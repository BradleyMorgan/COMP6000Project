package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class db_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    \n");
      out.write("    ");

    
    java.sql.Connection conn;
    java.sql.ResultSet rs;
    java.sql.Statement st;

    Class.forName("com.mysql.jdbc.Driver");
    
    conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost/comp6000", "comp6000", "comp6000");
    
    if(request.getParameter("topic_submit") != null) {

        st = conn.createStatement();

        String name = request.getParameter("name");

        String query = "INSERT INTO topics (forums) VALUES('"+name+"');";

        //out.println(query);

        st.executeUpdate(query);

    }
        
    
      out.write("\n");
      out.write("    \n");
      out.write("    <head>\n");
      out.write("    \n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>Database Admin Tools</title>\n");
      out.write("    \n");
      out.write("    </head>\n");
      out.write("    \n");
      out.write("    <body>\n");
      out.write("    \n");
      out.write("        <form action=\"db.jsp\" method=\"POST\">\n");
      out.write("            <fieldset>\n");
      out.write("                \n");
      out.write("                <legend>Add New Forum \\ Subcreddit</legend>\n");
      out.write("                \n");
      out.write("                <p>\n");
      out.write("                    <label for=\"topic\"><span>Name</span></label>\n");
      out.write("                    <input type=\"text\" name=\"name\">\n");
      out.write("                </p>          \n");
      out.write("                \n");
      out.write("                <span class=\"button\">\n");
      out.write("                    <input type=\"submit\" name=\"forum_submit\" value=\"Add Topic\">\n");
      out.write("                </span>\n");
      out.write("\n");
      out.write("            </fieldset>\n");
      out.write("        </form>     \n");
      out.write("        \n");
      out.write("    </body>\n");
      out.write("    \n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
