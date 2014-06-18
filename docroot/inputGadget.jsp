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
            <p><b>Application' input file</b> <input type="file" name="file_inputFile" id="upload_inputFileId" accept="*.*" onchange="uploadInputFile()"/></p>
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
<form id="form_music" action="<portlet:actionURL portletMode="view"><portlet:param name="PortletStatus" value="ACTION_SUBMIT_GADGET"/></portlet:actionURL>" method="post">



<div id="container">
    <table>
        <tr>

            <td>
                <!-- <div id="gadget2_setup1">Click to add the setup value</div>-->
                <div id="gadget">
                    <center>
                        <fieldset class="gadget2_fieldset" >

                            <legend class="gadget2_legend"> GADGET VALUES </legend>
                            <table>
                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelPERIODIC"  >PERIODIC *</label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="PERIODIC" id="PERIODIC_Y_ID" value="Y"> Y 
                                        <input type="radio" name="PERIODIC" id="PERIODIC_N_ID" value="N"> N
                                    </td>
                                </tr>


                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelUNEQUALSOFTENINGS"  >UNEQUALSOFTENINGS </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="UNEQUALSOFTENINGS" id="UNEQUALSOFTENINGS_Y_ID" value="Y"> Y 
                                        <input type="radio" name="UNEQUALSOFTENINGS" id="UNEQUALSOFTENINGS_N_ID" value="N"> N
                                    </td>
                                </tr>


                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelPEANOHILBERT"  >PEANOHILBERT </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="PEANOHILBERT" id="PEANOHILBERT_Y_ID" value="Y"> Y 
                                        <input type="radio" name="PEANOHILBERT" id="PEANOHILBERT_N_ID" value="N"> N
                                    </td>
                                </tr>


                                <tr>
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelWALLCLOCK"  >WALLCLOCK </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="WALLCLOCK" id="WALLCLOCK_Y_ID" value="Y"> Y 
                                        <input type="radio" name="WALLCLOCK" id="WALLCLOCK_N_ID" value="N"> N
                                    </td>
                                </tr>

                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelWALLCLOCK"  >WALLCLOCK </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="WALLCLOCK" id="WALLCLOCK_Y_ID" value="Y"> Y 
                                        <input type="radio" name="WALLCLOCK" id="WALLCLOCK_N_ID" value="N"> N
                                    </td>

                                </tr>
                                
                                <tr>
                                    
                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelPMGRID"  >PMGRID </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="PMGRID" id="PMGRID_Y_ID" value="Y"> Y 
                                        <input type="radio" name="PMGRID" id="PMGRID_N_ID" value="N"> N
                                    </td>
                                        
                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelPLACEHIGHRESREGION"  >PLACEHIGHRESREGION </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                       <input class="gadget2_textbox" id="PLACEHIGHRESREGIONID" name="PLACEHIGHRESREGION" type="text" value=""/>
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelENLARGEREGION"  >ENLARGEREGION </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input class="gadget2_textbox" id="ENLARGEREGIONID" name="ENLARGEREGION" type="text" value=""/>
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelASMTH"  >ASMTH </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input class="gadget2_textbox" id="ASMTHID" name="ASMTH" type="text" value=""/>
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelRCUT"  >RCUT </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input class="gadget2_textbox" id="RCUTID" name="RCUT" type="text" value=""/>
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelDOUBLEPRECISION"  >DOUBLEPRECISION </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                         <input  type="radio" name="DOUBLEPRECISION" id="DOUBLEPRECISION_Y_ID" value="Y"> Y 
                                        <input type="radio" name="DOUBLEPRECISION" id="DOUBLEPRECISION_N_ID" value="N"> N
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelDOUBLEPRECISION_FFTW"  >DOUBLEPRECISION_FFTW </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="DDOUBLEPRECISION_FFTW" id="DDOUBLEPRECISION_FFTW_Y_ID" value="Y"> Y 
                                        <input type="radio" name="DOUBLEPRECISION_FFTW" id="DOUBLEPRECISION_FFTW_N_ID" value="N"> N
                                    </td>

                                </tr>
                                
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelSYNCHRONIZATION"  >SYNCHRONIZATION </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="checkbox" name="SYNCHRONIZATION" id="SYNCHRONIZATIONID" value="">  
                                       
                                        
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelFLEXSTEPS"  >FLEXSTEPS </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="FLEXSTEPS" id="FLEXSTEPS_Y_ID" value="Y"> Y 
                                        <input type="radio" name="FLEXSTEPS" id="FLEXSTEPS_Y_ID" value="N"> N
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelPSEUDOSYMMETRIC"  >PSEUDOSYMMETRIC </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="PSEUDOSYMMETRIC" id="PSEUDOSYMMETRIC_Y_ID" value="Y"> Y 
                                        <input type="radio" name="PSEUDOSYMMETRIC" id="PSEUDOSYMMETRIC_N_ID" value="N"> N
                                    </td>

                                </tr>
                                   <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelNOSTOP_WHEN_BELOW_MINTIMESTEP"  >NOSTOP_WHEN_BELOW_MINTIMESTEP </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="NOSTOP_WHEN_BELOW_MINTIMESTEP" id="NOSTOP_WHEN_BELOW_MINTIMESTEP_Y_ID" value="Y"> Y 
                                        <input type="radio" name="NOSTOP_WHEN_BELOW_MINTIMESTEP" id="NOSTOP_WHEN_BELOW_MINTIMESTEP_N_ID" value="N"> N
                                    </td>

                                </tr>
                                 <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelNOPMSTEPADJUSTMENT"  >NOPMSTEPADJUSTMENT </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="NOPMSTEPADJUSTMENT" id="NOPMSTEPADJUSTMENT_Y_ID" value="Y"> Y 
                                        <input type="radio" name="NOPMSTEPADJUSTMENT" id="NOPMSTEPADJUSTMENT_N_ID" value="N"> N
                                    </td>

                                </tr>
                                 <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelHAVE_HDF5"  >HAVE_HDF5 </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="HAVE_HDF5" id="HAVE_HDF5_Y_ID" value="Y"> Y 
                                        <input type="radio" name="HAVE_HDF5" id="HAVE_HDF5_N_ID" value="N"> N
                                    </td>

                                </tr>
                                
                                     <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelOUTPUTPOTENTIAL"  >OUTPUTPOTENTIAL </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="OUTPUTPOTENTIAL" id="OUTPUTPOTENTIAL_Y_ID" value="Y"> Y 
                                        <input type="radio" name="OUTPUTPOTENTIAL" id="OUTPUTPOTENTIAL_N_ID" value="N"> N
                                    </td>

                                </tr>
                                     <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelOUTPUTACCELERATION"  >OUTPUTACCELERATION </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="OUTPUTACCELERATION" id="OUTPUTACCELERATION_Y_ID" value="Y"> Y 
                                        <input type="radio" name="OUTPUTACCELERATION" id="OUTPUTACCELERATION_N_ID" value="N"> N
                                    </td>

                                </tr>
                                     <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelOUTPUTCHANGEOFENTROPY"  >OUTPUTCHANGEOFENTROPY </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="OUTPUTCHANGEOFENTROPY" id="OUTPUTCHANGEOFENTROPY_Y_ID" value="Y"> Y 
                                        <input type="radio" name="OUTPUTCHANGEOFENTROPY" id="OUTPUTCHANGEOFENTROPY_N_ID" value="N"> N
                                    </td>

                                </tr>
                                 <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelOUTPUTTIMESTEP"  >OUTPUTTIMESTEP </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="OUTPUTTIMESTEP" id="OUTPUTTIMESTEP_Y_ID" value="Y"> Y 
                                        <input type="radio" name="OUTPUTTIMESTEP" id="OUTPUTTIMESTEP_N_ID" value="N"> N
                                    </td>

                                </tr>
                                 <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelNOGRAVITY"  >NOTREERND </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="NOTREERND" id="NOGRAVITY_Y_ID" value="Y"> Y 
                                        <input type="radio" name="NOTREERND" id="NOGRAVITY_N_ID" value="N"> N
                                    </td>

                                </tr>
                                
                                 <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelNOTREERND"  >NOTREERND </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="NOTREERND" id="NOTREERND_Y_ID" value="Y"> Y 
                                        <input type="radio" name="NOTREERND" id="NOTREERND_N_ID" value="N"> N
                                    </td>

                                </tr>
                                
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelNOTYPEPREFIX_FFTW"  >NOTYPEPREFIX_FFTW </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="NOTYPEPREFIX_FFTW" id="NOTYPEPREFIX_FFTW_Y_ID" value="Y"> Y 
                                        <input type="radio" name="NOTYPEPREFIX_FFTW" id="NOTYPEPREFIX_FFTW_N_ID" value="N"> N
                                    </td>

                                </tr>
                                    <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelLONG_XYZ"  > LONG_X/Y/Z </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="LONG_XYZ" id="LONG_XYZ_Y_ID" value="Y"> Y 
                                        <input type="radio" name="LONG_XYZ" id="LONG_XYZ_N_ID" value="N"> N
                                    </td>

                                </tr>
                                 <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelTWODIMS"  > TWODIMS </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="TWODIMS" id="TWODIMS_Y_ID" value="Y"> Y 
                                        <input type="radio" name="TWODIMS" id="TWODIMS_N_ID" value="N"> N
                                    </td>

                                </tr>
                                   <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelNOVISCOSITYLIMITER"  > NOVISCOSITYLIMITER </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="NOVISCOSITYLIMITER" id="NOVISCOSITYLIMITER_Y_ID" value="Y"> Y 
                                        <input type="radio" name="NOVISCOSITYLIMITER" id="NOVISCOSITYLIMITER_N_ID" value="N"> N
                                    </td>

                                </tr>
                                     <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelCOMPUTE_POTENTIAL_ENERGY"  > COMPUTE_POTENTIAL_ENERGY </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="COMPUTE_POTENTIAL_ENERGY" id="COMPUTE_POTENTIAL_ENERGY_Y_ID" value="Y"> Y 
                                        <input type="radio" name="COMPUTE_POTENTIAL_ENERGY" id="COMPUTE_POTENTIAL_ENERGY_N_ID" value="N"> N
                                    </td>

                                </tr>
                                     <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelLONGIDS"  > LONGIDS </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="LONGIDS" id="LONGIDS_Y_ID" value="Y"> Y 
                                        <input type="radio" name="LONGIDS" id="LONGIDS_N_ID" value="N"> N
                                    </td>

                                </tr>
                                 <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelISOTHERMAL"  > ISOTHERMAL </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="ISOTHERMAL" id="ISOTHERMAL_Y_ID" value="Y"> Y 
                                        <input type="radio" name="ISOTHERMAL" id="ISOTHERMAL_N_ID" value="N"> N
                                    </td>

                                </tr>
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelSELECTIVE_NO_GRAVITY"  > SELECTIVE_NO_GRAVITY </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="SELECTIVE_NO_GRAVITY" id="SELECTIVE_NO_GRAVITY_Y_ID" value="Y"> Y 
                                        <input type="radio" name="SELECTIVE_NO_GRAVITY" id="SELECTIVE_NO_GRAVITY_N_ID" value="N"> N
                                    </td>

                                </tr>
                     
                                <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelFORCETEST"  > FORCETEST </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="FORCETEST" id="FORCETEST_Y_ID" value="Y"> Y 
                                        <input type="radio" name="FORCETEST" id="FORCETEST_N_ID" value="N"> N
                                    </td>

                                </tr>
                               <tr>

                                    <td id="td_left">   
                                        <label class="gadget2_label" id="labelMAKEGLASS"  > MAKEGLASS </label>
                                    </td>
                                    <td id="td_center">
                                        <label id="labelEquals">= </label>
                                    </td>
                                    <td id="td_right">
                                        <input  type="radio" name="MAKEGLASS" id="MAKEGLASS_Y_ID" value="Y"> Y 
                                        <input type="radio" name="MAKEGLASS" id="MAKEGLASS_N_ID" value="N"> N
                                    </td>

                                </tr>
                                <tr>
                                    <td colspan="3" align="center"><input type="button" value="Demo" onclick="DemoValues()">
                                        <input type="button" value="Reset" onclick="ResetValues()">
                                        <input type="button" value="Validate Random" onclick="ValidateValues()">
                                    </td>
                                      
                                </tr>
                              
                                
                            </table>
                        </fieldset>
                    </center>
                </div>




                <div align="center"><input type="button" value="Submit" onClick="SubmitGadgetParam()"></div>
                </form>




               