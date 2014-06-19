<%
/**
 * Copyright (c) 2000-2011 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
%>

<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>

<portlet:defineObjects />
<%//
  // GATE 6.0.0 Submission Form
  //
  // The form has 3 input textareas respectively for:
  //    * Macro file
  //    * Material DB
  //    * ROOT Analysis C file
  // Beside each text area a upolad button takes as input the 
  // file name related to one of the above fields.
  // The forth submission buttons is related to the file 'phsp.root' file
  // A default phsp.root file will be used if no files will be uploaded by the user.
  // The ohter three buttons of the form are used for:
  //    o Demo:          Used to fill with demo values the text areas
  //    o SUBMIT:        Used to execute the job on the eInfrastructure
  //    o Reset values:  Used to reset input fields
  //
  
  // Gets the current timestamp
  java.util.Date date = new java.util.Date();
%>

<script type="text/javascript">

    //Script for SlideShow
    var i = 0; var path = new Array(); 
    // LIST OF IMAGES 
    path[0] = "<%=renderRequest.getContextPath()%>/images/img_1.jpg"; 
    path[1] = "<%=renderRequest.getContextPath()%>/images/img_2.jpg"; 
    path[2] = "<%=renderRequest.getContextPath()%>/images/img_3.jpg"; 
    path[3] = "<%=renderRequest.getContextPath()%>/images/img_4.jpg"; 
    path[4] = "<%=renderRequest.getContextPath()%>/images/img_5.jpg"; 
    path[5] = "<%=renderRequest.getContextPath()%>/images/img_6.jpg"; 

    function swapImage(){
        document.slide.src = path[i]; 
        if(i < path.length - 1) i++; 
        else i = 0; 
        setTimeout("swapImage()",3000); 
    } 

</script>

<%
// Below the descriptive area of the GATE web form 
%>
<table>
    <tr>
        <td valign="top">


            <img onload="swapImage();" src="<%=renderRequest.getContextPath()%>/images/img_1.jpg" width="0" heigh="0"/>
            <img align="left" style="padding:10px 10px;" name="slide" src="<%=renderRequest.getContextPath()%>/images/img_1.jpg" width="220" height="140"/>
        </td>
        <td>
            <!--This is an example portlet!
             <p><b>Exchange data between jsp page and java codeeee</b></p>-->

            <p style="font-size: small"> 
                GADGET is a freely available code for cosmological N-body/SPH<br/> 
                simulations on massively parallel computers with distributed memory.<br/> 
                GADGET uses an explicit communication model that is implemented<br/>
                with the standardized MPI communication interface. <br/>
                The code can be run on essentially all supercomputer systems presently in use,<br/>
                including clusters of workstations or individual PCs. 
            </p>

        </td>
    <tr>
</table>
<script src="<%=renderRequest.getContextPath()%>/js/jquery-1.3.2.min.js" type="text/javascript"></script>
<form id="form_music" action="<portlet:actionURL portletMode="view"><portlet:param name="PortletStatus" value="ACTION_SUBMIT"/></portlet:actionURL>" method="post">


<div id="container">
    <table>
        <tr>

            <td>
        <center>
            <fieldset class="gadget2_fieldset">

                <legend class="gadget2_legend"> SUBMIT FORM </legend>
                <table>
                    <tr>
                        <td id="td_left">   
                            <label value="music.conf"> music.conf </label>
                        </td>

                        <td id="td_right">
                            <input type="button" onclick="history.go(-3);" value="GO TO MUSIC">
                        </td>
                    </tr>  
                    <tr>
                        <td id="td_left">   
                            <label value="gadget.makefile"> gadget.makefile </label>
                        </td>

                        <td id="td_right">
                            <input type="button" onclick="history.go(-2);" value="GO TO GADGET MAKEFILE">
                        </td>
                    </tr> 
                    <tr>
                        <td id="td_left">   
                            <label value="gadget.param"> gadget.param </label>
                        </td>

                        <td id="td_right">
                            <input type="button" onclick="history.go(-1);" value="GO TO GADGET PARAM">
                        </td>
                    </tr> 
                </table>
            </fieldset>
        </center>
        </td>
        </tr>
    </table>
</div>
  <div align="center"><input type="button" value="Submit" onClick="submit()"></div>
</form>
<script>
