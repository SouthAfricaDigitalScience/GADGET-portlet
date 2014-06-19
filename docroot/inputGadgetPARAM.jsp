<%
    /**
     * Copyright (c) 2000-2011 Liferay, Inc. All rights reserved.
     *
     * This library is free software; you can redistribute it and/or modify it
     * under the terms of the GNU Lesser General Public License as published by
     * the Free Software Foundation; either version 2.1 of the License, or (at
     * your option) any later version.
     *
     * This library is distributed in the hope that it will be useful, but
     * WITHOUT ANY WARRANTY; without even the implied warranty of
     * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser
     * General Public License for more details.
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
            <img align="left" style="padding:10px 10px;" src="<%=renderRequest.getContextPath()%>/images/AppLogo.jpg" width="80%"/>
        </td>
        <td>
            <!--This is an example portlet!
             <p><b>Exchange data between jsp page and java codeeee</b></p>-->

            <p style="font-size: small"> 
                GADGET is a freely available code for cosmological N-body/SPH simulations <br> 
                on massively parallel computers with distributed memory.<br> 
                GADGET uses an explicit communication model that is implemented<br>
                with the standardized MPI communication interface. <br>
                The code can be run on essentially all supercomputer systems presently in use,<br>
                including clusters of workstations or individual PCs.  
            </p>
        </td>
    <tr>
</table>

<form enctype="multipart/form-data" action="<portlet:actionURL portletMode="view"><portlet:param name="PortletStatus" value="ACTION_SUBMIT_FILE"/></portlet:actionURL>" method="post">
<div style="text-align: center;">
    <dl>	
        <!-- This block contains: label, file input and textarea for GATE Macro file -->
        <dd>		
            <p><b>Application input file</b> <input type="file" name="file_inputFile" id="upload_inputFileId" accept="*.*" onchange="uploadInputFile()"/></p>
            <div hidden="yes">
                <textarea id="inputFileId" rows="20" cols="100%" name="inputFile">Insert here your text file, or upload a file</textarea>
            </div>
        </dd>
        <div hidden="yes">
            <!-- This block contains the experiment name -->
            <dd>
                <p>Insert below your <b>job identifyer</b></p>
                <textarea id="jobIdentifierId" rows="1" cols="60%" name="JobIdentifier">multi-infrastructure job description</textarea>
            </dd>	
            <!-- This block contains form buttons: Demo, SUBMIT and Reset values -->
            <dd>
            <td><input type="button" value="Demo" onClick="addDemo()"></td>
            <td><input type="button" value="Submit" onClick="preSubmit()"></td> 
            <td><input type="reset" value="Reset values" onClick="resetForm()"></td>
            </dd>
        </div>
    </dl>
    <br/><br/>
</div>    
</form>            



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

<script src="<%=renderRequest.getContextPath()%>/js/jquery-1.3.2.min.js" type="text/javascript"></script>
<form id="form_gadget" action="<portlet:actionURL portletMode="view"><portlet:param name="PortletStatus" value="ACTION_SUBMIT_GADGET_PARAM"/></portlet:actionURL>" method="post">



<div id="container">
    <table>
        <tr>

            <td>
                <!-- <div id="gadget2_setup1">Click to add the setup value</div>-->
                <div id="gadget">
                    <center>
                        <fieldset class="gadget2_fieldset" >

                            <legend class="gadget2_legend"> GADGET PARAM </legend>
                            <table>
                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelOutputDir"  >OutputDir *</label>
                                    </td>
                                    <td id="td_center"> = </td>
                                    <td id="td_right">
                                        <input  type="text" name="OutputDir" id="OutputDir_ID" value="">
                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelSnapshotFileBase"  >SnapshotFileBase * </label>
                                    </td>
                                    <td id="td_center">=</td>
                                    <td id="td_right">

                                        <input  type="text" name="SnapshotFileBase" id="SnapshotFileBase_ID" value=""> 


                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelSnapFormat"  >SnapFormat * </label>
                                    </td>
                                    <td id="td_center">=</td>
                                    <td id="td_right">

                                        <input  type="text" name="SnapFormat" id="SnapFormat_ID" value=""> 


                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelNumFilesPerSnapshot"  >NumFilesPerSnapshot * </label>
                                    </td>
                                    <td id="td_center">=</td>
                                    <td id="td_right">

                                        <input  type="text" name="NumFilesPerSnapshot" id="NumFilesPerSnapshot_ID" value=""> 


                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelInitCondFile"  >InitCondFile  </label>
                                    </td>
                                    <td id="td_center">=</td>
                                    <td id="td_right">

                                        <input  type="text" name="InitCondFile" id="InitCondFile_ID" value=""> 


                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelICFormat"  >ICFormat </label>
                                    </td>
                                    <td id="td_center">=</td>
                                    <td id="td_right">

                                        <input  type="text" name="ICFormat" id="ICFormat_ID" value=""> 


                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelRestartFile"  >RestartFile *</label>
                                    </td>
                                    <td id="td_center">=</td>
                                    <td id="td_right">

                                        <input  type="text" name="RestartFile" id="RestartFile_ID" value=""> 


                                    </td>
                                </tr>

                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelInfoFile"  >InfoFile * </label>
                                    </td>
                                    <td id="td_center">=</td>
                                    <td id="td_right">

                                        <input  type="text" name="InfoFile" id="InfoFile_ID" value=""> 


                                    </td>
                                </tr>

                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelTimingsFile"  >TimingsFile * </label>
                                    </td>
                                    <td id="td_center">=</td>
                                    <td id="td_right">

                                        <input  type="text" name="TimingsFile" id="TimingsFile_ID" value=""> 


                                    </td>
                                </tr>

                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelCpuFile"  >CpuFile * </label>
                                    </td>
                                    <td id="td_center">=</td>
                                    <td id="td_right">

                                        <input  type="text" name="CpuFile" id="CpuFile_ID" value=""> 


                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelEnergyFile"  >EnergyFile * </label>
                                    </td>
                                    <td id="td_center">=</td>
                                    <td id="td_right">

                                        <input  type="text" name="EnergyFile" id="EnergyFile_ID" value=""> 


                                    </td>
                                </tr>

                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelTimeLimitCPU"  >TimeLimitCPU * </label>
                                    </td>
                                    <td id="td_center">=</td>
                                    <td id="td_right">

                                        <input  type="text" name="TimeLimitCPU" id="TimeLimitCPU_ID" value=""> 


                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelResubmitCommand"  >ResubmitCommand * </label>
                                    </td>
                                    <td id="td_center">=</td>
                                    <td id="td_right">

                                        <input  type="text" name="ResubmitCommand" id="ResubmitCommand_ID" value=""> 


                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelResubmitOn"  >ResubmitOn * </label>
                                    </td>
                                    <td id="td_center">=</td>
                                    <td id="td_right">

                                        <input  type="text" name="ResubmitOn" id="ResubmitOn_ID" value=""> 


                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelCpuTimeBetRestartFile"  >CpuTimeBetRestartFile * </label>
                                    </td>
                                    <td id="td_center">=</td>
                                    <td id="td_right">

                                        <input  type="text" name="CpuTimeBetRestartFile" id="CpuTimeBetRestartFile_ID" value=""> 


                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelTimeBegin"  >TimeBegin * </label>
                                    </td>
                                    <td id="td_center">=</td>
                                    <td id="td_right">

                                        <input  type="text" name="TimeBegin" id="TimeBegin_ID" value=""> 


                                    </td>
                                </tr>
                                 <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelTimeMax"  >TimeMax * </label>
                                    </td>
                                    <td id="td_center">=</td>
                                    <td id="td_right">

                                        <input  type="text" name="TimeMax" id="TimeMax_ID" value=""> 


                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelBoxSize"  >BoxSize </label>
                                    </td>
                                    <td id="td_center">=</td>
                                    <td id="td_right">

                                        <input  type="text" name="BoxSize" id="BoxSize_ID" value=""> 


                                    </td>
                                </tr>

                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelPeriodicBoundariesOn"  >PeriodicBoundariesOn </label>
                                    </td>
                                    <td id="td_center">=</td>
                                    <td id="td_right">

                                        <input  type="text" name="PeriodicBoundariesOn" id="PeriodicBoundariesOn_ID" value=""> 


                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelComovingIntegrationOn"  >ComovingIntegrationOn </label>
                                    </td>
                                    <td id="td_center">=</td>
                                    <td id="td_right">

                                        <input  type="text" name="ComovingIntegrationOn" id="ComovingIntegrationOn_ID" value=""> 


                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelHubbleParam"  >HubbleParam </label>
                                    </td>
                                    <td id="td_center">=</td>
                                    <td id="td_right">

                                        <input  type="text" name="HubbleParam" id="HubbleParam_ID" value=""> 


                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelOmega0"  >Omega0 </label>
                                    </td>
                                    <td id="td_center">=</td>
                                    <td id="td_right">

                                        <input  type="text" name="Omega0" id="Omega0_ID" value=""> 


                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelOmegaLambda"  >OmegaLambda </label>
                                    </td>
                                    <td id="td_center">=</td>
                                    <td id="td_right">

                                        <input  type="text" name="OmegaLambda" id="OmegaLambda_ID" value=""> 


                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelOmegaBaryon"  >OmegaBaryon </label>
                                    </td>
                                    <td id="td_center">=</td>
                                    <td id="td_right">

                                        <input  type="text" name="OmegaBaryon" id="OmegaBaryon_ID" value=""> 


                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" align="center"><input type="button" value="Demo" onclick="SetGADGETDemoParam()">
                                        <input type="button" value="Reset" onclick="ResetGADGETparam()">
                                        <input type="button" value="Validate" onclick="ValidateGADGETparam()">
                                    </td>

                                </tr>

                            </table>
                        </fieldset>
                    </center>
                </div>
            </td>
        </tr>
    </table>
</div>
</form>
<script>
function SetGADGETDemoParam(){
    document.getElementById("OutputDir_ID").value="./";
        document.getElementById("labelOutputDir").style.color="black";
        
        document.getElementById("SnapshotFileBase_ID").value="snapshot";
        document.getElementById("labelSnapshotFileBase").style.color="black";
        
        
        document.getElementById("SnapFormat_ID").value="1";
        document.getElementById("labelSnapFormat").style.color="black";
        
        document.getElementById("NumFilesPerSnapshot_ID").value="2";
        document.getElementById("labelNumFilesPerSnapshot").style.color="black";
        
        
        document.getElementById("InitCondFile_ID").value="music.conf";
        document.getElementById("labelInitCondFile").style.color="black";
        
        
        document.getElementById("ICFormat_ID").value="1";
        document.getElementById("labelICFormat").style.color="black";
        
        document.getElementById("RestartFile_ID").value="restart";
        document.getElementById("labelRestartFile").style.color="black";
        
        document.getElementById("InfoFile_ID").value="info.txt";
        document.getElementById("labelInfoFile").style.color="black";
        
        document.getElementById("TimingsFile_ID").value="timings.txt";
        document.getElementById("labelTimingsFile").style.color="black";
        
        document.getElementById("CpuFile_ID").value="cpu.txt";
        document.getElementById("labelCpuFile").style.color="black";
        
        document.getElementById("EnergyFile_ID").value="energy.txt";
        document.getElementById("labelEnergyFile").style.color="black";
        
        document.getElementById("TimeLimitCPU_ID").value="40000.0";
        document.getElementById("labelTimeLimitCPU").style.color="black";
        
        document.getElementById("ResubmitCommand_ID").value="xyz.sh";
        document.getElementById("labelResubmitCommand").style.color="black";
        
        
        document.getElementById("ResubmitOn_ID").value="0";
        document.getElementById("labelResubmitOn").style.color="black";
        
        document.getElementById("CpuTimeBetRestartFile_ID").value="7200";
        document.getElementById("labelCpuTimeBetRestartFile").style.color="black";
        
        document.getElementById("TimeBegin_ID").value="0";
        document.getElementById("labelTimeBegin").style.color="black";
        
        document.getElementById("TimeMax_ID").value="3.0";
        document.getElementById("labelTimeMax").style.color="black";
        
        document.getElementById("BoxSize_ID").value="10000.0";
        document.getElementById("labelBoxSize").style.color="black";
        
        document.getElementById("PeriodicBoundariesOn_ID").value="1";
        document.getElementById("labelPeriodicBoundariesOn").style.color="black";
        
        document.getElementById("ComovingIntegrationOn_ID").value="0";
        document.getElementById("labelComovingIntegrationOn").style.color="black";
        
        document.getElementById("HubbleParam_ID").value="0.7";
        document.getElementById("labelHubbleParam").style.color="black";
        
        document.getElementById("Omega0_ID").value="0.3";
        document.getElementById("labelOmega0").style.color="black";
        
        document.getElementById("OmegaLambda_ID").value="0.7";
        document.getElementById("labelOmegaLambda").style.color="black";
        
        document.getElementById("OmegaBaryon_ID").value="0";
        document.getElementById("labelOmegaBaryon").style.color="black";
        
        
}

</script>