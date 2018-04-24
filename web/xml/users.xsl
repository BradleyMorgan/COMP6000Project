<?xml version="1.0" encoding="UTF-8" ?>

<!--

Bradley Morgan
morgaia@auburn.edu 
Assignment 3: XSL \ XPath
COMP 6000 Spring 2018
Auburn University

-->

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tge="http://example.org/XMLSchema">

    <xsl:output method="html" doctype-system="about:legacy-compat"	encoding="UTF-8" indent="yes" />

        <xsl:template match="/">
            
            <html>
                
                <head>
                    
                    <title>Creddit: User Report</title>
                    
                    <link href="pstyles.css" rel="stylesheet" type="text/css" />
                    
                    <style type="text/css">
                        
                        body {
                                font-family: Arial, Helvetica, sans-serif;
                        }
                        img {
                                display: block;
                                margin-left: auto;
                                maergin-right: auto;
                        }
                        h1 {
                                margin-top: 38px;
                                margin-bottom: 18px;
                        }
                        table {
                                width: 1000px;
                                margin-left:auto; 
                                margin-right:auto;
                                border: 1px solid #99999;
                                border-collapse: collapse;
                                margin-bottom: 56px;
                        }
                        tr:nth-child(even) {
                                background: #E8E8E8
                        }
                        tr:nth-child(odd) {
                                background: #FFF
                        }
                        th, td {
                                border: 1px solid gray;
                                border-collapse: collapse;
                                padding: 12px;
                        }
                        th {
                                text-align: left;
                                font-weight: bold;	
                                background-color: #ced8e8;						
                        }
                        td .narrow {
                                width: 150px;
                        }
                        td. wide {
                                width: 300px;
                        }

                    </style>
			
                </head>
			
                <body>
                    
                    <div id="wrap">
                        <header>
                                <h2>Creddit: User Report</h2>
                        </header>
                    </div>
			
                    <h1>Current Users</h1>
                    <hr />
				
                    <table>
                        
                        <thead>
                            
                            <tr>
                                <th>User ID</th>
                                <th>Username</th>
                                <th>Email Address</th>
                                <th>Post Count</th>
                                <th>Upvotes</th>
                                <th>Downvotes</th>
                                <th>Date Created</th>
                                <th>Time Created</th>
                            </tr>
                        
                        </thead>

                        <xsl:for-each select="users/user">

                            <tbody>
                                    <xsl:apply-templates select="current()" />
                            </tbody>

                        </xsl:for-each>

                    </table>				
                
                    <hr />

            </body>
            
        </html>

	</xsl:template>
	
	<xsl:template match="user">
            <tr>
                <td class="narrow"><xsl:value-of select="@id" /></td>
                <td class="narrow"><xsl:value-of select="username" /></td>
                <td class="narrow"><xsl:value-of select="email" /></td>
                <td class="narrow"><xsl:value-of select="postcount" /></td>
                <td class="narrow"><xsl:value-of select="upvotes" /></td>
                <td class="narrow"><xsl:value-of select="downvotes" /></td>
                <td class="narrow"><xsl:value-of select="cdate" /></td>
                <td class="narrow"><xsl:value-of select="ctime" /></td>
            </tr>
	</xsl:template>

</xsl:stylesheet>
