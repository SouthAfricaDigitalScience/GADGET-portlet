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

<%
// Below the descriptive area of the GATE web form 
%>
<table>
    <tr>
        <td valign="top">
            <img align="left" style="padding:10px 10px;" src="<%=renderRequest.getContextPath()%>/images/AppLogo.png" width="80%"/>
        </td>
        <td>
            This is an example portlet!
            <p><b>Exchange data between jsp page and java code</b></p>
        </td>
    <tr>
</table>
<%
// Below the application submission web form 
//
// The <form> tag contains a portlet parameter value called 'PortletStatus' the value of this item
// will be read by the processAction portlet method which then assigns a proper view mode before
// the call to the doView method.
// PortletStatus values can range accordingly to values defined into Enum type: Actions
// The processAction method will assign a view mode accordingly to the values defined into
// the Enum type: Views. This value will be assigned calling the function: setRenderParameter
//
%>
<center>
    <!-- <div>
         <form  action="<portlet:actionURL portletMode="view"><portlet:param name="PortletStatus" value="ACTION_SUBMIT"/></portlet:actionURL>" method="post">
 
                 <b>Input value</b> 
                 <input type="text" id="inputValueId" name="inputValue" />
 
                 <input type="submit" value="GO">
 
         </form>
     </div>
     <br>
     <div>
         <form  action="<portlet:renderURL portletMode="view"><portlet:param name="PortletStatus" value="VIEW_NO_ACTION"/></portlet:renderURL>" method="post">
 
                 <b>Go a new JSP page without Action</b> 
                 <input type="submit" value="GO">
 
         </form>
     </div>
     
    -->
    <form  action="<portlet:actionURL portletMode="view"><portlet:param name="PortletStatus" value="ACTION_SUBMIT"/></portlet:actionURL>" method="post">
       

              

        

        <div id="gadget2_setup" hidden="true">

            <fieldset class="gadget2_fieldset">

                <legend class="gadget2_legend"> SETUP </legend>
                <dl>

                    <dt><label id="gadget2_label">Boxlength =</label><input  id="boxlengthID" name="boxlength" type="text"   /></dt>
                </dl>



                <dl>
                    <dt><label id="gadget2_label"> Zstart =</label>

                    <input  id="zstartID" name="zstart" type="text" value=""/></dt>

                </dl>



                <dl>
                    <dt><label id="gadget2_label">Levelmin</label>


                    <input id="levelminID" name="levelmin" type="text" value=""/></dt>
                </dl>
                <dl>
                    <dt><label id="gadget2_label">Levelmin_TF</label>


                   <input id="levelmin_TFID" name="levelmin_TF" type="text" value=""/></dt>
                </dl>
                <dl>
                    <dt><label id="gadget2_label">levelmax</label>


                    <input id="levelmaxID" name="levelmax" type="text" value=""/></dt>
                </dl>
                <dl>
                    <dt><label id="gadget2_label">padding</label>


                   <input id="paddingID" name="padding" type="text" value=""/></dt>
                </dl>
                <dl>
                    <dt><label id="gadget2_label">overlap</label>


                   <input id="overlapID" name="overlap" type="text" value=""/></dt>
                </dl>
                <dl>
                    <dt><label id="gadget2_label">ref_center</label>


                    <input id="ref_centerID" name="ref_center" type="text" value=""/></dt>
                </dl>
                <dl>
                    <dt><label id="gadget2_label">ref_extent</label>


                    <input id="ref_extentID" name="ref_extent" type="text" value=""/></dt>
                </dl>
                <dl>
                    <dt><label id="gadget2_label">ref_extent</label>


                    <input id="ref_extentID" name="ref_extent" type="text" value=""/></dt>
                </dl>

                <dl>
                    <dt><label id="gadget2_label">align_top</label>
                    <input  type="radio" name="align_top" id="align_topID" value="Y"> Yes 
                    <input type="radio" name="align_top" id="align_topID" valueID="N"> No </dt>

                </dl>


                <dl>
                    <dt><label id="gadget2_label">baryons</label>
                    <input  type="radio" name="baryons" id="baryonsID" value="Y"> Yes 
                    <input type="radio" name="baryons" id="baryonsID" valueID="N"> No </dt>

                </dl>

                <dl>
                    <dt><label id="gadget2_label">use_2LPT</label>
                   <input  type="radio" name="use_2LPT" id="use_2LPTID" value="Y"> Yes 
                    <input type="radio" name="use_2LPT" id="use_2LPTID" valueID="N"> No </dt>

                </dl>
                <dl>
                    <dt><label id="gadget2_label">use_LLA</label></dt>
                    <dt><input  type="radio" name="use_LLA" id="use_LLAID" value="Y"> Yes 
                    <input type="radio" name="use_LLA" id="use_LLAID" valueID="N"> No </dt>

                </dl>
                <dl>
                    <dt><label id="gadget2_label">periodic_TF</label>
                    <input  type="radio" name="periodic_TF" id="periodic_TFID" value="Y"> Yes 
                    <input type="radio" name="periodic_TF" id="periodic_TFID" valueID="N"> No </dt>

                </dl>

          



            </fieldset>
        </div>







                </form>




                </center>
